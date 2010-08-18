$(document).ready(function() {
    $("#dialog").dialog({
        bgiframe: true,
        draggable: false,
        modal: true,
        autoOpen: false,
        resizable: false,
    });
    
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
