$(document).on "click", ".new_record", (e) ->
  e.preventDefault()
  $.dialog_for_new_record @href
  $(".chosen-select").chosen()


$(document).on "submit", "#new_record_form", ->
  class_name = @getAttribute("data-class-name")
  $("#new_record_form").ajaxComplete (event, request, settings) ->
    $($("#" + class_name).find("select option:selected")[0]).remove()
    object = jQuery.parseJSON(request.responseText)
    html_options = "<option selected value=\"" + object.id + "\" >" + object.name + "</option>"
    $($("#" + class_name).find("select")[0]).append html_options
    $($("#" + class_name).find("select")[0]).removeClass "chosen-select chzn-done"
    $("#" + class_name).find(".chzn-container").remove()
    $($("#" + class_name).find("select")[0]).chosen()
    $("#dialog").empty()
    $("#dialog").dialog "close"

$(document).on "focus change", ".chosen-select", ->
  $(this).chosen()

current_year = new Date().getFullYear()

$(document).on "focus change ", ".start_date", ->
  $.date_picker_for ".start-date", current_year - 60, current_year + 1

$(document).on "focus change ", ".end_date", ->
  $.date_picker_for ".end-date", current_year - 60, current_year + 10
  
$(document).on "change", "#filter_jobpositiontype_id", ->
  responseData = $.response_from_simple_remote_resource("/jobpositioncategories/filtered_select?id=" + $("#filter_jobpositiontype_id").val())
  $("#jobpositioncategories_select").html responseData

$ ->
  $(".chosen-select").chosen()
  $("select").each ->
    $(this).chosen()

  current_year = new Date().getFullYear()
  $.date_picker_for ".birthdate", current_year - 100, current_year - 15
  $.date_picker_for ".date", current_year - 60, current_year + 3
  $.date_picker_for ".start-date", current_year - 60, current_year + 1
  $.date_picker_for ".end-date", current_year - 60, current_year + 10
