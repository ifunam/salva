$(document).ready(function() {
    $(".country-select").live('change', function() {
        country_id = $(this).val();
        if ( country_id == "484"  || country_id == 840) {
            state_list_by_country(country_id);
            $("#city_text_field").html("");
        } else {
            $("#state_list").html('');
            $("#state_list_chzn").remove();
            $("#city_list_chzn").remove();
            $("#city_list").replaceWith('');
            $("#city_new").hide();
            textfield_for_city();
            $("#city_new").before('<div id="city_list"> </div>');
        }
    });

    $("#state_list").live('change', function() {
        state_id = $("#state_list").val();
        if (state_id >= 1 || state_id <= 83 ) {
            city_list_by_state(state_id);
            $("#city_new").show();
            $("#city_field").replaceWith('<div id="city_field"> </div>');
            $("#city_list_chzn").remove();
        }
    });

    $("#city_new").live('click', function() {
        dialog_for_new_city();
    });

    $('#new_city').live('submit', function() {
        $("#new_city").ajaxComplete(function(event, request, settings){
            $("#city_list_chzn").remove();
            $("#city_list").replaceWith(request.responseText);
            $('#dialog').dialog('close');
        });
    });
});

function state_list_by_country(id) {
    $.ajax({
        url: '/states/list_by_country',
        data: { country_id: id },
        success: function(data){ $("#state_list").replaceWith(data); }
    });
}

function city_list_by_state(id) {
    $.ajax({
        url: '/cities/list_by_state',
        data: { state_id: id },
        success: function(data){ $("#city_list").replaceWith(data); }
    });
}

function dialog_for_new_city() {
    $('#dialog').dialog({title:'Nueva ciudad', width: 320, height: 230}).dialog('open');
    $.ajax({
        url: "/cities/new.js",
        type: 'GET',
        dataType: 'html',
        data: {state_id: $("#state_list").val()},
        success: function(request) {
            $("#dialog").html(request);
        }
    });
}

function textfield_for_city() {
   $.ajax({
        url: "/cities/remote_form.js",
        type: 'GET',
        dataType: 'html',
        success: function(html) {
            $("#city_text_field").html(html);
        }
    });
}
