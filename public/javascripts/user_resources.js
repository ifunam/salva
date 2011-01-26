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

