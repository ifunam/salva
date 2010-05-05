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
});