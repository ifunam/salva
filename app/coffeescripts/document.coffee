$(document).on "click", ".new_record", (e) ->
  e.preventDefault()
  $.dialog_for_new_record @href
  $(".chosen-select").chosen()

$(document).on "click", "#new_record_form input[type=submit]", (e) ->
  e.preventDefault()
  class_name = this.parentNode.parentNode.getAttribute("data-class-name")
  p = $.param($("#new_record_form").serializeArray())
  url = $("#new_record_form").attr("action") + '.js'
  options = 
   url: url
   type: "POST"
   data: p
   async: false
  object = jQuery.parseJSON($.ajax(options).responseText)
  option = $('<option>', { value: object.id}).text(object.name)
  option.attr('selected','selected')
  $($("#" + class_name).find("select option:selected")[0]).remove()
  $($('#' + class_name).find("select")[0]).append(option)
  $($('#' + class_name).find("select")[0]).trigger("chosen:updated")
  $("#dialog").empty()
  $("#dialog").dialog "close"

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

  current_year = new Date().getFullYear()
  $.date_picker_for ".birthdate", current_year - 100, current_year - 15
  $.date_picker_for ".date", current_year - 60, current_year + 3
  $.date_picker_for ".start-date", current_year - 60, current_year + 1
  $.date_picker_for ".end-date", current_year - 60, current_year + 10
