$(document).ready(function() {
    $(".associated_authors a.icon_action_user_list").live("click", function() {
        var href = $(this).attr("data-remote-resource");
        $(this).after($.response_from_simple_remote_resource(href));
        return false;
    });

    $(".icon_action_close_author_list").live("click", function() {
       $(this).parent().parent().parent().remove();
    });

    $(".chosen-select").chosen();

    $(".author_action a").live("click", function() {
        var href = $(this).attr("data-remote-resource");
        var html = $.response_from_remote_resource(href);
        $(this).parent().parent().replaceWith(html);
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

    $("#new_checkbox").live('click', function() {
        href = $(this).parent().attr("data-remote-resource");
        $.dialog_for_new_checkbox(href);
    });

    $('#new_checkbox_form').live('submit', function() {
        class_name = $(this).attr('data-class-name');
        $("#new_checkbox_form").ajaxComplete(function(event, request, settings){
            object = jQuery.parseJSON(request.responseText);
            var content = $('#'+class_name).find('.fields_template')[0];
            var assoc_name = $('#'+class_name).attr('data-has-many-association');
            var regexp = new RegExp('new_'+assoc_name, 'g');
            var new_id  = new Date().getTime();
            html = $(content).html().replace('-1', object.id).replace('template_string', object.name);
            $($("#"+class_name).find("ul")[0]).append(html.replace(regexp, new_id));
            $('#dialog').dialog('close');
        });
    });

    $("#new_period").live('click', function() {
       $.dialog_for_new_period(this.href);
    });

    $('#new_period_form').live('submit', function() {
        class_name = this.getAttribute('data-collection-id');
        $("#new_period_form").ajaxComplete(function(event, request, settings) {
            $("#"+class_name).append(request.responseText);
            $('#dialog').dialog('close');
        });
    });

    $('.delete_regularcourse_period').live('click', function() {
      $('#'+this.id).remove();
    });

    $(".chosen-select").live("focus change", function() {
      return $(this).chosen();
    });

    $(".chosen-select").chosen();
    current_year = new Date().getFullYear();
    $.date_picker_for('.date', (current_year -20), current_year);
    $.set_button_behaviour();
});
