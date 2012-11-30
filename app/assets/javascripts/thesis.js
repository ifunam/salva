(function() {

  $(document).ready(function() {
    $(".radio-set-thesisstatus").live("change", function(e) {
      var new_label;
      if (this.name === "thesis[thesisstatus_id]" && this.checked) {
        if (this.value === "3") {
          new_label = "<abbr title=\"required\">*</abbr>Fecha de presentación de examen";
          return $("label[for=thesis_end_date]").html(new_label);
        } else {
          new_label = "<abbr title=\"required\">*</abbr>Fecha estimada de presentación de examen";
          return $("label[for=thesis_end_date]").html(new_label);
        }
      }
    });
    return $(".radio-set-degrees").live("change", function(e) {
      var html, url;
      url = "/thesismodalities/list_by_degree?degree_id=" + this.value;
      if (this.name === "thesis[career_attributes][degree_id]") {
        $("#thesismodality").remove();
        html = $.response_from_simple_remote_resource(url);
        $(this.parentNode.parentNode.parentNode.parentNode).after(html);
      }
      if (this.name === "thesis_examination[career_attributes][degree_id]") {
        $("#thesismodality").remove();
        url += "&model_name=thesis_examination";
        html = $.response_from_simple_remote_resource(url);
        return $(this.parentNode.parentNode.parentNode.parentNode).after(html);
      }
    });
  });

}).call(this);
