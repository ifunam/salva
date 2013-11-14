$(document).ready ->
  $("#submit_buttons").on "click", ->
    $(".fields_template").remove()

  $("form a.add_child_link").click ->
    assoc = $(this).attr("data-association")
    content = $("#" + assoc + "_fields_template").html()
    regexp = new RegExp("new_" + assoc, "g")
    new_id = new Date().getTime()
    $(this).before content.replace(regexp, new_id)
    $(".chzn-container").remove()
    $(".chosen-select").removeClass("chzn-done").chosen()
    false

  $("form a.remove_new_child").on "click", ->
    $(this).parent().parent().remove()
    false

  $("form a.remove_existent_child").on "click", ->
    $(this).parent().find(".destroy")[0].value = true
    $(this).parent().parent().hide()
    false
