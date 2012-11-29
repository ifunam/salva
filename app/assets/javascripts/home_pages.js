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
        if($(this).attr('checked')){
            $('.' + $(this).attr('value')).show(600);
        } else {
            $('.' + $(this).attr('value')).hide(600);
        }

    })

});


