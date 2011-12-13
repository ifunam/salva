$(document).ready ->
  $(".approve_document").live "click", (e) ->
    e.preventDefault()
    html = $.response_from_remote_resource(this.href)
    $(this).parent().parent().replaceWith(html)
    false

  $(".reject_document").live "click", (e) ->
      e.preventDefault()
      $.dialog_for_new_record(this.href)

  $(".simple_form").live "submit", ->
    dom_id = $(".simple_form").attr("id")
    $(".simple_form").ajaxComplete (event, request, settings) ->
      $("#dialog").empty()
      $("#dialog").dialog "close"
      $("#"+dom_id).replaceWith(request.responseText)

