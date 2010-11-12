$(document).ready(function() {
    $(".associated_authors a").live("click", function() {
        publication_id = this.id;
        options = {
            url: this.href,
            success: function(request) {
                $("#associated_authors_"+publication_id).after(request);
            }
        }
        $.ajax(options);
        return false;
    });

    $("td.add_or_delete_author a").live("click", function() {
        dom_id = this.getAttribute('data-parent-id');
        options = {
            url: this.href,
            beforeSend: function(){
                open_dialog_with_progressbar();
            },
            complete: function(request){ 
                set_button_behaviour();
                close_dialog_with_progressbar();
            },
            success: function(request) {
                $("#"+dom_id).replaceWith(request);
            }
        }
        $.ajax(options);
        return false;
    });

    $("tr#filter_header input").live('focusout', function() {
        resource = $('#filter_form').attr('action') + '.js';
        remote_collection_list(resource, $.param($("form").serializeArray()));
        return false;
    });

    $("tr#filter_header select").live('change', function() {
        resource = $('#filter_form').attr('action') + '.js';
        remote_collection_list(resource, $.param($("form").serializeArray()));
        return false;
    });

    $("#filter_reset_all").live("click", function() {
        document.forms['filter_form'].reset();
        resource = $('#filter_form').attr('action') + '.js';
        remote_collection_list(resource);
        return false;
    });

    $("#ajaxed_paginator a").live("click", function() {
        remote_collection_list(this.href);
        return false;
    });

    $('#autocomplete_journal_name,').live('focus', function(){
        search_by_journal_name();
    });

    $('#change_journal').live('click', function() {
      change_journal();
    });

    $("#journal_new").live('click', function() {
      dialog_for_new_journal();
    });

    $('#new_journal').live('submit', function() {
        $("#new_journal").ajaxComplete(function(event, request, settings){
          $("#autocomplete_journal_name").val(request.responseText);
          $('#autocomplete_journal_name').attr("disabled", "disabled");
          $('#change_journal').show();
           $('#dialog').dialog('close');
        });
    });

    set_button_behaviour();
});


function  search_by_journal_name() {
    $('#autocomplete_journal_name').autocomplete({
        source: '/journals/search_by_name',
        minLength: 1,
        delay: 0,
        select: function(event, ui) {  
            $('#article_journal_id').val(ui.item.id);
            $('#autocomplete_journal_name').attr("disabled", "disabled");
            $('#change_journal').show();
        }
    });
}

function show_record(id) {
    $.ajax({
        url: "/journals/" + id + '.js',
        success: function(request) { 
            $("#journal").html(request); 
        },
    });
}

function dialog_for_new_journal() {
    $('#dialog').dialog({title:'Nuevo Journal', width: 400, height: 320}).dialog('open');
    $.ajax({
        url: "/journals/new.js",
        success: function(request) {
            $("div#dialog").html(request);
        }
    });
}

function change_journal() {
	$('#article_journal_id').val('');
    $('#autocomplete_journal_name').removeAttr("disabled");
    $('#autocomplete_journal_name').val('');
    $('#change_journal').hide();
}