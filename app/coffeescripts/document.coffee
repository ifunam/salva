$(document).ready ->
  $("#new_record").live "click", ->
    $.dialog_for_new_record @parentNode.getAttribute("data-controller-name")
  
  $("#new_record_form").live "submit", ->
    class_name = @getAttribute("data-class-name")
    $("#new_record_form").ajaxComplete (event, request, settings) ->
      object = jQuery.parseJSON(request.responseText)
      label = eval("object." + class_name + ".name")
      value = eval("object." + class_name + ".id")
      html_options = "<option selected value=\"" + value + "\" >" + label + "</option>"
      $("#" + class_name).find("select").children().remove().end().append html_options
      $("#" + class_name).find("input").val label
      $("#dialog").dialog "close"

  $(".chosen-select").chosen()

  $(".chosen-select").live "focus change", ->
    $(this).chosen()

  current_year = new Date().getFullYear()

  $.date_picker_for ".birthdate", (current_year - 100), (current_year - 15)

  $.date_picker_for ".date", (current_year - 20), current_year + 1

  $("#filter_jobpositiontype_id").change ->
    responseData = $.response_from_simple_remote_resource("/jobpositioncategories/filtered_select?id=" + $("#filter_jobpositiontype_id").val())
    $("#jobpositioncategories_select").html responseData
