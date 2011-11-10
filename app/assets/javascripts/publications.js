$(document).ready(function() {
    $(".associated_authors a").live("click", function() {
        $("#associated_authors_"+this.id).after(response_from_simple_remote_resource(this.href));
        return false;
    });

    $("td.add_or_delete_author a").live("click", function() {
        dom_id = this.getAttribute('data-parent-id');
        var html = response_from_remote_resource(this.href);
        $("#"+dom_id).replaceWith(html);
        return false;
    });

    $("ul.add_or_delete_author a").live("click", function() {
        dom_id = this.getAttribute('data-parent-id');
        var html = response_from_remote_resource(this.href);
        $("#"+dom_id).replaceWith(html);

        return false;
    });

    $("tr#filter_header input").live('focusout', function() {
        resource = $('#filter_form').attr('action') + '.js';
        remote_collection_list(resource, $.param($("form").serializeArray()));
        return false;
    });

    $("tr#filter_header select").live('change', function() {
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

    $("#ajaxed_paginator a").live("click", function() {
        remote_collection_list(this.href);
        return false;
    });

    $("#new_record").live('click', function() {
        dialog_for_new_record(this.parentNode.getAttribute('data-controller-name'));
    });

    $('#new_record_form').live('submit', function() {
        class_name = this.getAttribute('data-class-name');
        $("#new_record_form").ajaxComplete(function(event, request, settings){
            object = jQuery.parseJSON(request.responseText);
            label = eval('object.'+class_name+'.name');
            value = eval('object.'+class_name+'.id');
            html_options = '<option selected value="'+value+'" >'+label+'</option>';
            $("#"+class_name).find('select').children().remove().end().append(html_options);
            $("#"+class_name).find('input').val(label);
            $('#dialog').dialog('close');
        });
    });

    $(".autocompleted_select").autocomplete_select();

    $('#autocomplete_filter_journal_name').live('focus', function(){
        filter_by_journal_name();
    });

    $("#new_checkbox").live('click', function() {
        dialog_for_new_checkbox(this.parentNode.getAttribute('data-controller-name'));
    });

    $('#new_checkbox_form').live('submit', function() {
        class_name = this.getAttribute('data-class-name');
        $("#new_checkbox_form").ajaxComplete(function(event, request, settings){
            object = jQuery.parseJSON(request.responseText);
            label = eval('object.'+class_name+'.name');
            value = eval('object.'+class_name+'.id');
            var content = $('#'+class_name).find('[class=fields_template]').first();
            var assoc_name = content.parent().attr('data-has-many-association');
            var regexp = new RegExp('new_'+assoc_name, 'g');
            var new_id  = new Date().getTime();
            html = content.html().replace('-1', value).replace('template_string', label);
            $("#"+class_name).append(html.replace(regexp, new_id));
            $('#dialog').dialog('close');
        });
    });

    $('#record').live('submit', function() {
        $('.fields_template').remove();
    });

    current_year = new Date().getFullYear();
    date_picker_for('.date', (current_year -20), current_year);

    $(".autocompleted_text" ).autocompleted_text();

    $("#new_period").live('click', function() {
       dialog_for_new_period(this.href);
    });


    $('#new_period_form').live('submit', function() {
        class_name = this.getAttribute('data-collection-id');
        $("#new_period_form").ajaxComplete(function(event, request, settings) {
            $("#"+class_name).append(request.responseText);
            $('#dialog').dialog('close');
        });
    });
    $('.delete_regularcourse_period').live('click', function() {
      $('#'+this.id).remove();
    });
    set_button_behaviour();
});

function dialog_for_new_record(controller) {
    $('#dialog').dialog({title:'Nuevo registro', width: 400, height: 320}).dialog('open');
    var responseData = response_from_simple_remote_resource('/' + controller + '/new.js');
    $("div#dialog").html(responseData);
    return false;
}

function change_record(class_name) {
    $('#autocomplete_'+class_name+'_name').removeAttr("disabled");
    $('#autocomplete_'+class_name+'_name').val('');
    $('#change_'+class_name).hide();
}

function filter_by_journal_name() {
    $('#autocomplete_filter_journal_name').autocomplete({
        source: '/journals/search_by_name',
        minLength: 1,
        delay: 0,
        select: function(event, ui) { 
            $('#search_journal_id_eq').val(ui.item.id);
        }
    });
}

function dialog_for_new_checkbox(controller) {
    $('#dialog').dialog({title:'Nuevo registro', width: 400, height: 320}).dialog('open');
    var responseData = response_from_simple_remote_resource('/' + controller + '/new.js');
    $("div#dialog").html(responseData);
    $('#new_record_form').attr('id', "new_checkbox_form");
}

function dialog_for_new_period(url) {
    $('#dialog').dialog({title:'Nuevo periodo', width: 480, height: 420}).dialog('open');
    var responseData = response_from_simple_remote_resource(url);
    $("div#dialog").html(responseData);
}
