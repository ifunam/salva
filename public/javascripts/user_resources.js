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

    $(".autocompleted_select" ).autocomplete_select();

    $(".autocompleted_text" ).autocompleted_text();

    $(".chosen-select").chosen();

    $(".chosen-select").live('focus change', function(){
        $(this).chosen();
    });

    // user_profiles code
    current_year = new Date().getFullYear();
    date_picker_for('.birthdate', (current_year - 100), (current_year - 15));
    date_picker_for('.date', (current_year -20), current_year);

    $('#filter_jobpositiontype_id').change(function(){
      var responseData = response_from_simple_remote_resource("/jobpositioncategories/filtered_select?id=" + $('#filter_jobpositiontype_id').val());
      $('#jobpositioncategories_select').html(responseData);
    });

     $(".submit_button").live('click', function() {
         $('.fields_template').remove();
     });

     $('form a.add_child').click(function() {
         var assoc   = $(this).attr('data-association');
         var content = $('#' + assoc + '_fields_template').html();
         var regexp  = new RegExp('new_' + assoc, 'g');
         var new_id  = new Date().getTime();
         $("#nested_table").append(content.replace(regexp, new_id));
         $('.chzn-container').remove();
         $('.chzn-select').removeClass('chzn-done').chosen();
         return false;
     });

     $('form a.remove_new_child').live('click', function() {
         $(this).parent().parent().remove();
         return false;
     });

     $('form a.remove_existent_child').live('click', function() {
         $(this).parent().find(".destroy")[0].value = true;
         $(this).parent().parent().hide();
         return false;
     });
});

function dialog_for_new_record(controller) {
    $('#dialog').dialog({title:'Nuevo registro', width: 400, height: 320}).dialog('open');
    var responseData = response_from_simple_remote_resource('/' + controller + '/new.js');
    $("div#dialog").html(responseData);

}

function change_record(class_name) {
    $('#autocomplete_'+class_name+'_name').removeAttr("disabled");
    $('#autocomplete_'+class_name+'_name').val('');
    $('#change_'+class_name).hide();
}

