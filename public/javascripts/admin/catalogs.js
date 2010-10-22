$.validator.setDefaults({
    highlight: function(input) {
        $(input).addClass("ui-state-highlight");
    },
    unhighlight: function(input) {
        $(input).removeClass("ui-state-highlight");
    }
});

$(document).ready(function() {
    $('a[data-draggable]').live("hover", function() {
        draggable_item(this.id);
        droppable_items_for_move_association(this);
        return false;
    });

    $('a[data-record-draggable]').live("hover", function() {
        draggable_item(this.id);
        droppable_items_for_move_associations(this);
        return false;
    });

    $("tr#filter_header input").live('focusout', function() {
        resource = $('#filter_form').attr('action') + '.js';
        remote_collection_list(resource, $.param($("form").serializeArray()));
        return false;
    });

    $("#filter_reset_all").live("click", function() {
        document.forms['filter_form'].reset();
        resource = $('#filter_form').attr('action') + '.js';
        remote_collection_list(resource);
        return false;
    });

    $('a[data-method]=delete').live("click", function() {
        $('#'+this.getAttribute('data-parent-id')).remove();
        return false;
    });

    $("#ajaxed_paginator a").live("click", function() {
        remote_collection_list(this.href);
        return false;
    });

    $("input[name=record_id]").live("change", function() {
        if (this.getAttribute('checked')) {
            this.removeAttribute('checked');
        }
        else {
            this.setAttribute('checked', 'checked');
        }
    });

    $("#destroy_selected_records").live("click", function() {
        ids = new Array();
        dom_ids = new Array();
        $("input[name=record_id][checked]").each(function(index, item){
            ids.push(item.value);
            dom_ids.push(this.getAttribute('data-parent-id'));
        });
        destroy_selected_records(ids, dom_ids);
    });
    set_button_behaviour();
});

function set_button_behaviour() {
    $(".ui-state-default").hover(
        function() { $(this).addClass('ui-state-hover'); },
        function() { $(this).removeClass('ui-state-hover'); }
    );
    $(".ui-state-default").css("cursor", "pointer");
}

function draggable_item(dom_id) {
    $('#'+dom_id).removeClass('ui-droppable');
    $('#'+dom_id).draggable({ revert: "invalid" }); 
    return false;
}

function droppable_items_for_move_association(prev_item) {
    $("a[data-draggable]").each(function(index){
        if ((this.id != prev_item.id) && (this.getAttribute('data-association') == prev_item.getAttribute('data-association'))) {
            $('#'+this.id).droppable({
                accept: '.'+prev_item.getAttribute('data-association'),
                activeClass: "ui-state-hover",
                hoverClass: "ui-state-active",
                drop: function( event, ui ) {
                    move_association(this, prev_item.getAttribute('data-id'));
                    update_previous_association_size(prev_item.id);

                }
            }); 
        }
    });
}

function move_association(new_item, prev_record_id) {
    new_record_id = new_item.getAttribute('data-id');
    controller_name = new_item.getAttribute('data-controller-name');
    association_name = new_item.getAttribute('data-association');
    $.ajax({
        url: '/admin/' + controller_name + '/' + prev_record_id +'/move_association.js',
        data: { new_id: new_record_id,
            association_name: association_name
        },
        type: 'PUT',
        beforeSend: function(){
            //$('#'+new_item.id).hide();
            open_dialog_with_progressbar();
        },
        complete: function(request){ 
            close_dialog_with_progressbar();
        },
        success: function(data){  
            $('#'+new_item.id).replaceWith(data);
            $('#'+new_item.id).fadeIn(3000);
        }
    });
}

function droppable_items_for_move_associations(prev_item) {
    $("a[data-record-draggable]").each(function(index){
        if (this.id != prev_item.id) {
            $('#'+this.id).droppable({
                accept: '.record-draggable',
                activeClass: "ui-state-hover",
                hoverClass: "ui-state-active",
                drop: function( event, ui ) {
                    move_associations(this, prev_item.getAttribute('data-id'));
                    show_updated_record(prev_item);
                }
            }); 
        }
    });
}

function move_associations(new_item, prev_record_id) {
    new_record_id = new_item.getAttribute('data-id');
    controller_name = new_item.getAttribute('data-controller-name');
    $.ajax({
        url: '/admin/' + controller_name + '/' + prev_record_id +'/move_associations.js',
        data: { new_id: new_record_id },
        type: 'PUT',
        beforeSend: function(){
            open_dialog_with_progressbar();
        },
        complete: function(data){ 
            close_dialog_with_progressbar();
        },
        success: function(data){  
            $('#'+new_item.id).parent().parent().replaceWith(data);
            $('#'+new_item.id).parent().parent().fadeIn(3000);
        }
    });
}

function show_updated_record(item) {
    record_id = item.getAttribute('data-id');
    controller_name = item.getAttribute('data-controller-name');
    $.ajax({
        url: '/admin/' + controller_name + '/' + record_id +'.js',
        type: 'GET',
        beforeSend: function(){
            //$('#'+item.id).parent().parent().hide();
        },
        success: function(data){  
            $('#'+item.id).parent().parent().replaceWith(data);
            $('#'+item.id).parent().parent().fadeIn(3000);
        }
    });
}

function destroy_selected_records(ids, dom_ids) {
    $.ajax({
        url: $('#filter_form').attr('action') + '/destroy_all',
        data: { 'ids': ids },
        type: 'POST',
        beforeSend: function(){
            open_dialog_with_progressbar();
        },
        complete: function(data){ 
            close_dialog_with_progressbar();
        },
        success: function(data){ 
            $.each(dom_ids, function(index, dom_id){
                $('#'+dom_id).remove();
            });
        }
    });
}

function remote_collection_list(href, params) {
    options = {
        url: href,
        beforeSend: function(){
            open_dialog_with_progressbar();
        },
        complete: function(request){ 
            set_button_behaviour();
            close_dialog_with_progressbar();
        },
        success: function(request) {
            $('#collection').remove();
            $('#paginator').remove();
            $('#filter_header').after(request);
        },
        type:'get'
    }
    if (params != undefined) {
        options['data'] = params;
    }
    $.ajax(options);
}

function open_dialog_with_progressbar() {
    $('#dialog').dialog({ width: 260, height: 130, bgiframe: true, modal: true, hide: 'slide', 
    open: function(event, ui) { $(this).parent().children('.ui-dialog-titlebar').hide(); }
    }).dialog('open');
    $('#dialog').html('<div id="progressbar"></div><p style="font-size:12px">Cargando, por favor espere...</p>');
    $( "#progressbar" ).progressbar({value: 100});
}

function close_dialog_with_progressbar() {
    $('#dialog').dialog('close');
    $('#dialog').html('');
}

function update_previous_association_size(dom_id) {
    var htmlStr = $('#'+dom_id).html();
    var newStr = htmlStr.replace(/\((\d)+\)$/,'(0)');
    $('#'+dom_id).hide();
    $('#'+dom_id).html(newStr);
    $('#'+dom_id).fadeIn(3000);
    $('#'+dom_id).css('top', '0px');
    $('#'+dom_id).css('left', '0px');
    $('#'+dom_id).css('right', '0px');
    $('#'+dom_id).css('bottom', '0px');
}