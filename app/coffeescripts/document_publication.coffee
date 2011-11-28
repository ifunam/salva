$(document).ready ->
  $(".associated_authors a.icon_action_user_list").live "click", ->
    href = $(this).attr("data-remote-resource")
    $(this).after $.response_from_simple_remote_resource(href)
    false
  
  $(".icon_action_close_author_list").live "click", ->
    $(this).parent().parent().parent().remove()

  $(".author_action a").live "click", ->
    href = $(this).attr("data-remote-resource")
    html = $.response_from_remote_resource(href)
    $(this).parent().parent().replaceWith html
    false

  $(".role_list ul li a").live "click", ->
    href = $(this).attr("data-remote-resource")
    html = $.response_from_remote_resource(href)
    $(this).parent().parent().parent().parent().parent().parent().replaceWith html
    false

  $(".role_action a.action_link").live "click", ->
    href = $(this).attr("data-remote-resource")
    $(this).after $.response_from_simple_remote_resource(href)
    false

  $("#new_checkbox").live "click", ->
    href = $(this).parent().attr("data-remote-resource")
    $.dialog_for_new_checkbox href
  
  $("#new_checkbox_form").live "submit", ->
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

  $("#new_period").live "click", (e) ->
    (e).preventDefault()
    $.dialog_for_new_period @href
  
  $("#new_period_form").live "submit", (e) ->
    (e).preventDefault()
    regularcourse_id = $("#new_period_form").attr("data-regularcourse-id")
    $("#new_period_form").ajaxComplete (event, request, settings) ->
      #$("#" + class_name).append request.responseText
      $($("#regularcourse_"+regularcourse_id).find('.periods ul')[0]).append request.responseText
      $("#dialog").dialog "close"
      $("#dialog").html('')

  $(".delete_period").live "click", (e) ->
    e.preventDefault()
    $(this).parent().remove()
