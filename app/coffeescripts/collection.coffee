$(document).ready ->
  $("#search_button").live "click", ->
    resource = $("#filter_form").attr("action") + ".js"
    $.remote_collection_list resource, $.param($("#filter_form").serializeArray())
    false

  $("#reset_search_button").live "click", ->
    document.forms["filter_form"].reset()
    resource = $("#filter_form").attr("action") + ".js"
    $.remote_collection_list resource
    false

  $("#destroy_selected_records").live "click", ->
    ids = new Array()
    dom_ids = new Array()
    $("input[name=record_id]").each (index, item) ->
      if $(item).is(":checked")
        ids.push item.value
        dom_ids.push @getAttribute("data-parent-id")
    $.destroy_selected_records ids, dom_ids

  $(".page a").live "click", (e) ->
    if @getAttribute("data-remote") == 'true'
      e.preventDefault()
      $.remote_collection_list @href
      false

  $("#enable_search").live "click", ->
    $.ajax(
      url: '/session_preferences/enable_search'
      async: false
      success: (data) ->
       $("#filter_form").show()
       $("#enable_search").hide()
       $("#disable_search").show()
    )

  $("#disable_search").live "click", ->
    $.ajax(
      url: '/session_preferences/disable_search'
      async: false
      success: (data) ->
       $("#filter_form").hide()
       $("#enable_search").show()
       $("#disable_search").hide()
    )

  $("#ajaxed_paginator a").live "click", ->
    $.remote_collection_list this.href
    false
