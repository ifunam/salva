// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
   $('#user_person_attributes_dateofbirth').datepicker({ changeYear: true, changeMonth: true, yearRange: '1910:1995', dateFormat: 'dd-mm-yy' });

   $('#filter_jobpositiontype_id').change(function(){
    $.ajax({
       url: "/jobpositioncategories/filtered_select?id=" + $('#filter_jobpositiontype_id').val(),
       success: function(data) { $('#jobpositioncategories_select').html(data); }
    });
   });

    $('#autocomplete_institution_name').focus(function(){
       autocomplete_for_institution_name();
    });


});

function autocomplete_for_institution_name() {
  $('#autocomplete_institution_name').autocomplete("/institutions/autocomplete_name", { mustMatch: true });
  $('#autocomplete_institution_name').result(function(event, data, formatted) {
      var hidden = $('#user_jobposition_attributes_institution_id');
      hidden.val(data[1]);
      $.ajax({
          url: "/institutions/" + data[1],
          success: function(request) { $("#institution_name").html(request); }
      });
  });
}