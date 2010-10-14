$.validator.setDefaults({
    highlight: function(input) {
        $(input).addClass("ui-state-highlight");
    },
    unhighlight: function(input) {
        $(input).removeClass("ui-state-highlight");
    }
});

$(function() {
  $('form a.add_child').click(function() {
    var assoc   = $(this).attr('data-association');
    var content = $('#' + assoc + '_fields_template').html();
    var regexp  = new RegExp('new_' + assoc, 'g');
    var new_id  = new Date().getTime();
        
    $(this).before(content.replace(regexp, new_id));    

    // FIX IT: Move these lines to another method
    date_picker_for('#user_user_schoolarships_attributes_'+new_id+'_start_date',start_year, current_year);
    date_picker_for('#user_user_schoolarships_attributes_'+new_id+'_end_date',start_year, current_year);

    return false;
  });
  
  $('form a.remove_child').live('click', function() {
    $(this).parent().parent().remove();
    return false;
  });

  $('form a.remove_document').live('click', function() {
    document_id = this.id;
    $.ajax({
        url: "/documents/"+document_id,
        type: 'DELETE',
        dataType: 'xml',
        success: function(request) { 

        }
    });
    $(this).parent().parent().remove();
    return false;
  });

  $('form a.remove_user_schoolarship').live('click', function() {
    schoolarship_id = this.id;
    $.ajax({
        url: "/user_schoolarships/"+schoolarship_id,
        type: 'DELETE',
        dataType: 'xml',
        success: function(request) { 

        }
    });
    $(this).parent().parent().remove();
    return false;
  });

});

$(document).ready(function() {

    $("#dialog").dialog({
        bgiframe: true,
        draggable: false,
        modal: true,
        autoOpen: false,
        resizable: false,
    });

    current_year = new Date().getFullYear();
    start_year = current_year - 100;
    end_year = current_year - 15;

    date_picker_for('#user_person_attributes_dateofbirth', start_year, end_year);

    $('#user_login').live('focus', function(){
        search_by_username_autocomplete();
    });

    $('#user_login').live('focusout', function(){
        search_by_username_onchange_observer();
    });

    $('#autocomplete_user_fullname,').live('focus', function(){
        search_by_fullname_autocomplete();
    });

    $('#change_user_incharge').live('click', function() {
        search_by_fullname_autocomplete_form();
    });

    $("#user_person_attributes_country_id").live('change', function() {
        country_id = $("#user_person_attributes_country_id").val();
        if ( country_id == "484"  || country_id == 840) {
            state_list_by_country(country_id);
            $("#city_field").replaceWith('<div id="city_field"> </div>');
        } else {
            $("#state_list").html('');
            $("#city_list").replaceWith('');
            $("#city_new").hide();
            textfield_for_city();
            $("#city_new").before('<div id="city_list"> </div>');
        }
    });

    $("#state_list").live('change', function() {
        state_id = $("#state_list").val();
        if (state_id >= 1 || state_id <= 83 ) {
            city_list_by_state(state_id);
            $("#city_new").show();
            $("#city_field").replaceWith('<div id="city_field"> </div>');
        }
    });

    $("#city_new").live('click', function() {
        dialog_for_new_city();
    });

    $('#new_city').live('submit', function() {
        $("#new_city").ajaxComplete(function(event, request, settings){
            $("#city_list").replaceWith(request.responseText);
            $('#dialog').dialog('close');
        });
    });
    date_picker_for('#user_jobposition_attributes_start_date', start_year, current_year);
    date_picker_for('#user_jobposition_attributes_end_date', start_year, current_year);
    date_picker_for('#user_user_schoolarship_attributes_start_date', start_year, current_year);
    date_picker_for('#user_user_schoolarship_attributes_end_date', start_year, current_year);
    date_picker_for('#user_user_schoolarships_attributes_0_start_date',start_year, current_year);
    date_picker_for('#user_user_schoolarships_attributes_0_end_date',start_year, current_year);
    $("#save_user").validate({
        rules: {
            "user[password]": {required:true, minlength:3},
            "user[password_confirmation]": { equalTo: "#user_password"},
            "user[userstatus_id]": {required:true}, 
            "user[person_attributes][maritalstatus_id]": {required:true}, 
            "user[person_attributes][country_id]": {required:true},
            "user[person_attributes][gender]": {required:true},
            "user[person_attributes][city_id]": {required:true}, 
            "user[jobposition_attributes][schoolarship_id]": {required:true}, 
            "user[jobposition_attributes][user_adscription_attributes][adscription_id]": {required:true}, 
        }   
    });

    $('#save_user').live('submit', function() {
        $('#user_schoolarships_fields_template').remove();
        $('#documents_fields_template').remove();
    });

    $('#collection tr td').hover( function() {
            var iCol = $('td').index(this) % 5;
            var nTrs = oTable.fnGetNodes();
            $('td:nth-child('+(iCol+1)+')', nTrs).addClass( 'highlighted' );
        }, function() {
            var nTrs = oTable.fnGetNodes();
            $('td.highlighted', nTrs).removeClass('highlighted');
    } );

    $("tr#filter_row select").live('change', function() {
        remote_user_list('/academic_secretary/users.js', $.param($("form").serializeArray()));
        return false;
    });

    $("tr#filter_row input").live('focusout', function() {
        remote_user_list('/academic_secretary/users.js', $.param($("form").serializeArray()));
        return false;
    });

    $("#ajaxed_paginator a").live("click", function() {
        remote_user_list(this.href);
        return false;
     });

    $("#edit_status a").live("click", function() {
        user_id = this.id;
        options = {
            url: this.href,
            success: function(request) {
                $("#edit_status_user_" + user_id).remove();
                $("#userstatus_user_" + user_id).after(request);
                }
        }
        $.ajax(options);
        return false;
     });

    $("#filter_header_reset_all").live("click", function() {
        document.forms['filter_form'].reset();
        remote_user_list('/academic_secretary/users.js');
        return false;
    });

    $("td#profile a").live("click", function() {
        if ( $(this).attr('data-remote') == 'true' ) {
            user_id = this.id;
            options = {
                url: '/academic_secretary/users/'+user_id+'.js',
                success: function(request) {
                    $('#show_profile_user_'+user_id).remove();
                    $("#profile_user_"+user_id).after(request);
                    }
            }
            $.ajax(options);
            return false;
        }
     });

    $("#update_status a").live("click", function() {
        user_id = this.id;
        options = {
            url: this.href,
            success: function(request) {
                    $("#userstatus_indicator_user_" + user_id).html(request);
                    $("#edit_status_user_" + user_id).remove();
                }
        }
        $.ajax(options);
        return false;
     });

    $("#export_to_xls").live("click", function() {
        $.download('/academic_secretary/users/list.xls', decodeURIComponent($.param($("form").serializeArray())), 'get');
        return false;
    });
    
    set_button_behaviour();
    date_picker_for('#search_jobposition_start_date_equals', start_year, end_year);
    date_picker_for('#search_jobposition_end_date_equals', start_year, end_year);

});

function search_by_username_onchange_observer() {
    $.ajax({
        dataType: 'json',
        url: "/academic_secretary/users/search_by_username",
        data: { term: $('#user_login').val() }, 
        success: function(json){
            not_found = true;
            $.each(json, function(index){
                if (json[index].value == $('#user_login').val()) {
                    not_found = false;
                    dialog_for_existent_login(json[index].value);
                    $('#user_login').val('');
                }
            });
            login_length = $('#user_login').val().length;
            if (login_length >= 3 && not_found == true )  {
                $('#user_email').val($('#user_login').val() + '@fisica.unam.mx') 
            } else {
                $('#user_email').val('');
            }
        }
    });
}

function search_by_username_autocomplete() {
    $('#user_login').autocomplete({
        source: '/academic_secretary/users/search_by_username',
        minLength: 2,
        select: function(event, ui) {
            dialog_for_existent_login(ui.item.id);
        }
    });
}

function dialog_for_existent_login(login) {
    $('#dialog').dialog({title:'Error', width: 270, height: 125}).dialog('open');
    $('#dialog').html('<p> <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 50px 0;"></span> El usuario ' +  login + ' ya existe, asigne un login distinto.</p>');
}

function  search_by_fullname_autocomplete() {
    $('#autocomplete_user_fullname').autocomplete({
        source: '/academic_secretary/users/search_by_fullname',
        minLength: 3,
        select: function(event, ui) {  
            $('#user_user_incharge_id').val(ui.item.id);
            secretary_users_show(ui.item.id);
        }
    });
}

function secretary_users_show(id) {
    $.ajax({
        url: "/academic_secretary/users/" + id + '/user_incharge.js',
        success: function(request) { 
            $("#user_fullname").html(request); 
        }
    });
}

function search_by_fullname_autocomplete_form() {
    $.ajax({
        url: "/academic_secretary/users/autocomplete_form", 
        success: function(request) { $("#user_fullname").html(request); }
    });
}

function state_list_by_country(id) {
    $.ajax({
        url: '/states/list_by_country',
        data: { country_id: id },
        success: function(data){ $("#state_list").replaceWith(data); }
    });
}

function city_list_by_state(id) {
    $.ajax({
        url: '/cities/list_by_state',
        data: { state_id: id },
        success: function(data){ $("#city_list").replaceWith(data); }
    });
}

function dialog_for_new_city() {
    $('#dialog').dialog({title:'Nueva ciudad', width: 320, height: 180}).dialog('open');
    $.ajax({
        url: "/cities/new.js",
        data: {state_id: $("#state_list").val()},
        success: function(request) {
            $("div#dialog").html(request);
        }
    });
}

function textfield_for_city() {
   $.ajax({
        url: "/cities/remote_form.js",
        success: function(request) {
            $("#city_field").html(request);
        }
    });
}

function set_button_behaviour() {
  $(".ui-state-default").hover(
    function() { $(this).addClass('ui-state-hover'); },
    function() { $(this).removeClass('ui-state-hover'); }
  );
  $(".ui-state-default").css("cursor", "pointer");
}

function remote_user_list(href, params) {
    options = {
        url: href,
        complete: function(request){ set_button_behaviour(); },
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
