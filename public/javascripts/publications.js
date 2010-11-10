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

	set_button_behaviour();
});
