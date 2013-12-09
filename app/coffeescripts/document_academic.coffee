$(document).on "click", ".approve_document", (e) ->
  e.preventDefault()
  html = $.response_from_remote_resource(this.href)
  $(this).parent().parent().replaceWith(html)
  false

$(document).on "click", ".reject_document", (e) ->
  e.preventDefault()
  $.dialog_for_new_record(this.href)

$(document).on "click", ".simple_form input[type=submit]", (e)->
  e.preventDefault()
  dom_id = $(".simple_form").attr("id")
  url = $(".simple_form").attr("action") + '.js'
  p = $.param($(".simple_form").serializeArray())
  options = 
    url: url
    type: "POST"
    data: p
    async: false
  $("#dialog").empty()
  $("#dialog").dialog "close"
  $("#"+dom_id).replaceWith($.ajax(options).responseText)

