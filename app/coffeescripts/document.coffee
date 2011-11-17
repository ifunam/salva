$(document).ready ->
  $(".new_record").live "click", ->
    $.dialog_for_new_record $(this).attr("data-remote-resource")

  $("#new_record_form").live "submit", ->
    class_name = @getAttribute("data-class-name")
    $("#new_record_form").ajaxComplete (event, request, settings) ->
      object = jQuery.parseJSON(request.responseText)
      html_options = "<option selected value=\"" + object.id + "\" >" + object.name + "</option>"
      $($("#" + class_name).find("select")[0]).append html_options
      $($("#" + class_name).find("select")[0]).removeClass "chosen-select chzn-done"
      $(".chzn-container").remove()
      $($("#" + class_name).find("select")[0]).chosen()
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
