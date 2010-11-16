(function( $ ) {
        $.widget( "ui.combobox", {
            _create: function() {
                var self = this,
                    select = this.element.hide(),
                    selected = select.children( ":selected" ),
                    value = selected.val() ? selected.text() : "";
                var controller_name = self.element.context.parentNode.getAttribute('data-controller-name');
                var input = $( "<input size=40>" )
                    .insertAfter( select )
                    .val( value )
                    .autocomplete({
                        delay: 3,
                        minLength: 1,
                        source: '/'+controller_name+'/autocompleted_search',
                        select: function( event, ui ) {
                            select.children().remove().end().append('<option selected value="'+ui.item.id+'">'+ui.item.label+'</option>');
                        },
                        change: function( event, ui ) {
                            if ( !ui.item ) {
                                var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" ),
                                    valid = false;
                                select.children( "option" ).each(function() {
                                    if ( this.value.match( matcher ) ) {
                                        this.selected = valid = true;
                                        return false;
                                    }
                                });
                                if ( !valid ) {
                                    // remove invalid value, as it didn't match anything
                                    $( this ).val( "" );
                                    select.val( "" );
                                    return false;
                                }
                            }
                        }
                    })
                    .addClass( "ui-widget ui-widget-content ui-corner-left" );

                input.data( "autocomplete" )._renderItem = function( ul, item ) {
                    return $( "<li></li>" )
                        .data( "item.autocomplete", item )
                        .append( "<a>" + item.label + "</a>" )
                        .appendTo( ul );
                };


            }
        });
})( jQuery );

$(document).ready(function() {
    $(".associated_authors a").live("click", function() {
        publication_id = this.id;
        options = {
            url: this.href,
            success: function(request) {
                $("#associated_authors_"+publication_id).after(request);
            }
        }
        $.ajax(options);
        return false;
    });

    $("td.add_or_delete_author a").live("click", function() {
        dom_id = this.getAttribute('data-parent-id');
        options = {
            url: this.href,
            beforeSend: function(){
                open_dialog_with_progressbar();
            },
            complete: function(request){ 
                set_button_behaviour();
                close_dialog_with_progressbar();
            },
            success: function(request) {
                $("#"+dom_id).replaceWith(request);
            }
        }
        $.ajax(options);
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
    $( ".autocompleted_select" ).combobox();

    $('#autocomplete_filter_journal_name').live('focus', function(){
        filter_by_journal_name();
    });

    set_button_behaviour();
});

function dialog_for_new_record(controller) {
    $('#dialog').dialog({title:'Nuevo registro', width: 400, height: 320}).dialog('open');
    $.ajax({
        url: '/' + controller + '/new.js',
        success: function(request) {
            $("div#dialog").html(request);
        }
    });
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
