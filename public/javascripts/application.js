// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
        current_year = new Date().getFullYear();
        start_year = current_year - 100;
        end_year = current_year - 15;
	$('#user_person_attributes_dateofbirth').datepicker({ changeYear: true, changeMonth: true, yearRange: start_year+':'+end_year, dateFormat: 'dd-mm-yy', defaultDate: '01-01-'+end_year });

	$('#filter_jobpositiontype_id').change(function(){
		$.ajax({
			url: "/jobpositioncategories/filtered_select?id=" + $('#filter_jobpositiontype_id').val(),
			success: function(data) { $('#jobpositioncategories_select').html(data); }
		});
	});

	$('#autocomplete_institution_name').focus(function(){
		autocomplete_for_institution_name();
	});
	
	$('#new_institution').click(function() {
		new_institution_dialog();
	});

        $('#autocomplete_user_fullname').focus(function(){
		autocomplete_for_user_fullname();
	});
	
	$("#institution_autocomplete_form").click(function() {
	  institution_autocomplete_form(); 
	});
	
	$("#user_autocomplete_form").click(function() {
	  user_autocomplete_form(); 
	});
});

function autocomplete_for_institution_name() {
	$('#autocomplete_institution_name').autocomplete("/institutions/autocomplete_name", { mustMatch: true });
	$('#autocomplete_institution_name').result(function(event, data, formatted) {
		var hidden = $('#user_jobposition_attributes_institution_id');
		hidden.val(data[1]);
		$.ajax({
			url: "/institutions/" + data[1] + ".js", 
			success: function(request) { $("#institution_name").html(request); }
		});
	});
}

function institution_autocomplete_form() {
	$.ajax({
	 	url: "/institutions/autocomplete_form", 
		success: function(request) { $("#institution_name").html(request); }
	 });
}

function new_institution_dialog() {
	$("#dialog").dialog({
		title: "Institución",
		bgiframe: true,
		height: 300,
		width: 550,
		draggable: false,
		modal: false,
		autoOpen: false,
		resizable: false,
	});

	$('#dialog').dialog('open');
	$.ajax({
		url: "/institutions/new.js",
		success: function(request) {
			$("div#dialog").html(request);
		}
	});
	return false;
}

function autocomplete_for_user_fullname() {
	$('#autocomplete_user_fullname').autocomplete("/admin/users/autocomplete_fullname", { mustMatch: true });
	$('#autocomplete_user_fullname').result(function(event, data, formatted) {
		var hidden = $('#user_user_incharge_id');
		if (data != undefined) {
			hidden.val(data[1]);
			$.ajax({
				url: "/admin/users/" + data[1] + ".js",
				success: function(request) { $("#user_fullname").html(request); }
			});
		}
		
	});
}

function user_autocomplete_form() {
	$.ajax({
	 	url: "/admin/users/autocomplete_form", 
		success: function(request) { $("#user_fullname").html(request); }
	 });
}
