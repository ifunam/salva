//= require application
//= require chosen.jquery.min
//= require base

$(document).ready(function() {
    $(".approve_document").live("click", function(e) {
      e.preventDefault();
      var html = $.response_from_remote_resource(this.href);
      $(this).parent().parent().replaceWith(html);
      return false;
    });

    $(".reject_document").live("click", function(e) {
      e.preventDefault();
      var html = $.response_from_remote_resource(this.href);
      $(this).parent().parent().replaceWith(html);
      return false;
    });
 });