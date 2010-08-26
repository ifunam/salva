$.validator.setDefaults({
    highlight: function(input) {
        $(input).addClass("ui-state-highlight");
    },
    unhighlight: function(input) {
        $(input).removeClass("ui-state-highlight");
    }
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

    $('#user_person_attributes_dateofbirth').datepicker({ changeYear: true, changeMonth: true, yearRange: start_year+':'+end_year, dateFormat: 'dd-mm-yy', defaultDate: '01-01-'+end_year });

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
        } else {
            $("#state_list").html('');
            $("#city_list").html('');
        }
    });

    $("#state_list").live('change', function() {
        state_id = $("#state_list").val();
        if (state_id >= 1 || state_id <= 83 ) {
            city_list_by_state(state_id);
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

    $('#user_jobposition_attributes_start_date').datepicker({ changeYear: true, changeMonth: true, yearRange: start_year+':'+end_year, dateFormat: 'dd-mm-yy', defaultDate: '01-01-'+end_year });
    $('#user_jobposition_attributes_end_date').datepicker({ changeYear: true, changeMonth: true, yearRange: start_year+':'+end_year, dateFormat: 'dd-mm-yy', defaultDate: '01-01-'+end_year });

    $("#new_user").validate({
        rules: {
            "user[password]": {required:true},
            "user[password_confirmation]": {required:true,equalTo:"#user[password]"},
            "user[userstatus_id]": {required:true}, 
            "user[person_attributes][maritalstatus_id]": {required:true}, 
            "user[person_attributes][country_id]": {required:true},
            "user[person_attributes][gender]": {required:true},
            "user[person_attributes][city_id]": {required:true}, 
            "user[jobposition_attributes][schoolarship_id]": {required:true}, 
            "user[jobposition_attributes][user_adscription_attributes][adscription_id]": {required:true}, 
        }   
    });

});

function search_by_username_onchange_observer() {
    $.ajax({
        dataType: 'json',
        url: "search_by_username",
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
            if (not_found == true)  {
                $('#user_email').val($('#user_login').val() + '@fisica.unam.mx') 
            }
        }
    });
}

function search_by_username_autocomplete() {
    $('#user_login').autocomplete({
        source: 'search_by_username',
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
        source: 'search_by_fullname',
        minLength: 3,
        select: function(event, ui) {  
            $('#user_user_incharge_id').val(ui.item.id);
            secretary_users_show(ui.item.id);
        }
    });
}

function secretary_users_show(id) {
    $.ajax({
        url: "/academic_secretary/users/" + id + '.js', 
        success: function(request) { 
            $("#user_fullname").html(request); 
        }
    });
}

function search_by_fullname_autocomplete_form() {
    $.ajax({
        url: "autocomplete_form", 
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
