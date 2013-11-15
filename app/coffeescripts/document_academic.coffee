$(document).on "click", ".approve_document", (e) ->
  e.preventDefault()
  html = $.response_from_remote_resource(this.href)
  $(this).parent().parent().replaceWith(html)
  false

$(document).on "click", ".reject_document", (e) ->
  e.preventDefault()
  $.dialog_for_new_record(this.href)

$(document).on "submit", ".simple_form", ->
  dom_id = $(".simple_form").attr("id")
  $(".simple_form").ajaxComplete (event, request, settings) ->
    $("#dialog").empty()
    $("#dialog").dialog "close"
    $("#"+dom_id).replaceWith(request.responseText)

