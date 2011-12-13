/* DO NOT MODIFY. This file was compiled Tue, 13 Dec 2011 19:56:19 GMT from
 * /Users/alex/Projects/Rails/salva/app/coffeescripts/document_academic.coffee
 */


  $(document).ready(function() {
    $(".approve_document").live("click", function(e) {
      var html;
      e.preventDefault();
      html = $.response_from_remote_resource(this.href);
      $(this).parent().parent().replaceWith(html);
      return false;
    });
    $(".reject_document").live("click", function(e) {
      e.preventDefault();
      return $.dialog_for_new_record(this.href);
    });
    return $(".simple_form").live("submit", function() {
      var dom_id;
      dom_id = $(".simple_form").attr("id");
      return $(".simple_form").ajaxComplete(function(event, request, settings) {
        $("#dialog").empty();
        $("#dialog").dialog("close");
        return $("#" + dom_id).replaceWith(request.responseText);
      });
    });
  });
