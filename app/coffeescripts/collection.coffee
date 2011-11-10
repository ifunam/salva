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

  $("#ajaxed_paginator a").live "click", ->
    $.remote_collection_list @href
    false