// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

(function( $ ) {
        $.widget( "ui.autocomplete_select", {
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

function set_button_behaviour() {
    $(".ui-state-default").hover(
        function() { $(this).addClass('ui-state-hover'); },
        function() { $(this).removeClass('ui-state-hover'); }
    );
    $(".ui-state-default").css("cursor", "pointer");
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

function remote_collection_list(href, params) {
    options = {
        url: href,
        async: false,
        beforeSend: function(){
            open_dialog_with_progressbar();
        },
        complete: function(request){ 
            set_button_behaviour();
            close_dialog_with_progressbar();
        },
        type:'get'
    }
    if (params != undefined) {
        options['data'] = params;
    }
    var html = $.ajax(options).responseText;
    $('#collection').remove();
    $('#paginator').remove();
    $('#filter_header').after(html);
    return false;
}

function date_picker_for(dom_id, start_year, end_year) {
    $(dom_id).datepicker({
        changeYear: true,
        changeMonth: true,
        yearRange: start_year+':'+end_year,
        dateFormat: 'dd-mm-yy',
        defaultDate: '01-01-'+end_year,
        showOn: 'both',
        buttonImageOnly: true,
        buttonImage: '/images/calendar.gif'
    });
}

