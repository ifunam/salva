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

	autocomplete_for_institution_name();

	$('#new_institution').click(function() {
		new_institution_dialog();
	});

	autocomplete_for_user_fullname();

	$("#institution_autocomplete_form").click(function() {
		institution_autocomplete_form(); 
	});

	$("#user_autocomplete_form").click(function() {
		user_autocomplete_form(); 
	});
});

function autocomplete_for_institution_name() {
	$('#autocomplete_institution_name').autocomplete({
		source: '/institutions/autocomplete_name',
		minLength: 2,
		select: function(event, ui) {
			var hidden = $('#user_jobposition_attributes_	institution_id');
			hidden.val(ui.item.id);
			institution_show(ui.item.id);
		}
	});
}

function institution_show(id) {
	$.ajax({
		url: "/institutions/" + id + ".js", 
		success: function(request) { 
			$("#institution_name").html(request); 
		}
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
	$('#autocomplete_user_fullname').autocomplete({
		source: "/admin/users/autocomplete_fullname",
		minLength: 2,
		select: function(event, ui) {
			var hidden = $('#user_user_incharge_id');
			hidden.val(ui.item.id);
			admin_user_show(ui.item.id);
		}		
	});
}

function admin_user_show(id) {
	$.ajax({
		url: "/admin/users/" + id + ".js",
		success: function(request) { 
			$("#user_fullname").html(request); 
		}
	});
}

function user_autocomplete_form() {
	$.ajax({
		url: "/admin/users/autocomplete_form", 
		success: function(request) { $("#user_fullname").html(request); }
	});
}
