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

(function( $ ) {
        $.widget( "ui.autocompleted_text", {
            _create: function() {
                var dom_id = this.element.attr('id');
                var controller_name = this.element.attr('data-controller-name');
                $('#'+dom_id).autocomplete({
                        delay: 3,
                        minLength: 4,
                        source: '/'+controller_name+'/autocompleted_search',
                        select: function( event, ui ) {
                           $('#'+dom_id).val(ui.item.value);
                        }
                });
            }
        });
})( jQuery );


$(document).ready(function() {
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

    $("td.delete_record a").live("click", function() {
       dom_id = this.getAttribute('data-parent-id');
       $('#'+dom_id).remove();
        return false;
    });

    $(".autocompleted_select" ).combobox();

    current_year = new Date().getFullYear();
    date_picker_for('.birthdate', (current_year - 100), (current_year - 15));
    date_picker_for('.date', (current_year -20), current_year);

    $('#filter_jobpositiontype_id').change(function(){
      $.ajax({
            url: "/jobpositioncategories/filtered_select?id=" + $('#filter_jobpositiontype_id').val(),
            success: function(data) { $('#jobpositioncategories_select').html(data); }
      });
    });

   $(".autocompleted_text" ).autocompleted_text();
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

