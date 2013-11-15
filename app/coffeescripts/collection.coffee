$(document).on "click", "#search_button", ->
  resource = $("#filter_form").attr("action") + ".js"
  $.remote_collection_list resource, $.param($("#filter_form").serializeArray())
  false

$(document).on "click", "#reset_search_button", ->
  document.forms["filter_form"].reset()
  resource = $("#filter_form").attr("action") + ".js"
  $.remote_collection_list resource
  false

$(document).on "click", "#destroy_selected_records", ->
  ids = new Array()
  dom_ids = new Array()
  $("input[name=record_id]").each (index, item) ->
    if $(item).is(":checked")
      ids.push item.value
      dom_ids.push @getAttribute("data-parent-id")
  $.destroy_selected_records ids, dom_ids

$(document).on "click", ".page a", (e) ->
  if @getAttribute("data-remote") == 'true'
    e.preventDefault()
    $.remote_collection_list @href
    false
  
$(document).on "click", "#enable_search", ->
  $.ajax(
    url: '/session_preferences/enable_search'
    async: false
    success: (data) ->
      $("#filter_form").show()
      $("#enable_search").hide()
      $("#disable_search").show()
  )

$(document).on "click", "#disable_search", ->
  $.ajax(
    url: '/session_preferences/disable_search'
    async: false
    success: (data) ->
      $("#filter_form").hide()
      $("#enable_search").show()
      $("#disable_search").hide()
  )

$(document).on "click", "#ajaxed_paginator a", ->
  $.remote_collection_list this.href
  false
