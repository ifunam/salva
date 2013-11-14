$(document).on "click", ".associated_authors a.icon_action_user_list", (e)->
  (e).preventDefault()
  $(this).after $.response_from_simple_remote_resource(@href)
  false

$(document).on "click", ".icon_action_close_author_list", (e) ->
  e.preventDefault()
  $(this).parent().parent().parent().remove()
  false

$(document).on "click", ".author_action a", (e, elements)->
  e.preventDefault()
  html = $.response_from_simple_remote_resource(@href)
  $(this).parent().parent().replaceWith html
  false

$(document).on "click", ".role_list ul li a", (e)->
  e.preventDefault()
  href = $(this).attr("data-remote-resource")
  html = $.response_from_remote_resource(href)
  $(this).parent().parent().parent().parent().parent().parent().replaceWith html
  false

$(document).on "click", ".role_action a.action_link", (e)->
  (e).preventDefault()
  $(this).after $.response_from_simple_remote_resource(@href)
  false

$(document).on "click", "#new_checkbox", ->
  href = $(this).parent().attr("data-remote-resource")
  $.dialog_for_new_checkbox href

$(document).on "submit", "#new_checkbox_form", ->
  class_name = $(this).attr("data-class-name")
  $("#new_checkbox_form").ajaxComplete (event, request, settings) ->
    object = jQuery.parseJSON(request.responseText)
    content = $("#" + class_name).find(".fields_template")[0]
    assoc_name = $("#" + class_name).attr("data-has-many-association")
    regexp = new RegExp("new_" + assoc_name, "g")
    new_id = new Date().getTime()
    html = $(content).html().replace("-1", object.id).replace("template_string", object.name)
    $($("#" + class_name).find("ul")[0]).append html.replace(regexp, new_id)
    $("#dialog").dialog "close"
    $("#dialog").html('')

$(document).on "click", ".new_period", (e) ->
  (e).preventDefault()
  $.dialog_for_new_period @href

$(document).on "submit", "#new_period_form", (e) ->
  (e).preventDefault()
  regularcourse_id = $("#new_period_form").attr("data-regularcourse-id")
  $("#new_period_form").ajaxComplete (event, request, settings) ->
    $($("#regularcourse_"+regularcourse_id).find('.periods ul')[0]).append request.responseText
    $("#dialog").dialog "close"
    $("#dialog").html('')

$(document).on "click", ".delete_period", (e) ->
  e.preventDefault()
  $(this).parent().remove()

$(document).on "change", ".radio-set-thesisstatus", (e) ->
  if this.name == "thesis[thesisstatus_id]" and this.checked
    if this.value == "3"
      new_label = "<abbr title=\"required\">*</abbr>Fecha de presentación de examen"
      $("label[for=thesis_end_date]").html(new_label)
    else
      new_label = "<abbr title=\"required\">*</abbr>Fecha estimada de presentación de examen"
      $("label[for=thesis_end_date]").html(new_label)
