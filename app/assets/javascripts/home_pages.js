/**
 * Created with JetBrains RubyMine.
 * User: martinezo
 * Date: 9/5/12
 * Time: 11:51 AM
 * To change this template use File | Settings | File Templates.
 */
//= require jquery.min

$(document).ready(function(){

    $(':checkbox').click(function() {
        if($(this).is(':checked')){
            $('.' + $(this).attr('value')).show(600);
        } else {
            $('.' + $(this).attr('value')).hide(600);
        }

    })

    $('#show_all_published_articles').click(function(event){
        $('.recent_published_articles').hide();
        $('.all_published_articles').show(600);
         event.preventDefault();
    })

    $('#hide_all_published_articles').click(function(event){
        $('.all_published_articles').hide();
        $('.recent_published_articles').show(600);
        event.preventDefault();
    })
});