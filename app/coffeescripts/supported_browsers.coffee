$(document).ready ->
  $("#supported_browsers a").live "hover", ->
    $(@children[0]).addClass("hover").stop().animate 
      marginBottom: "2px"
      marginRight: "2px"
      top: "0"
      left: "0"
      width: "35px"
      height: "40px"
      padding: "0px"
    , 50
  
  $("#supported_browsers a").live "mouseleave", ->
    $(@children[0]).addClass("hover").stop().animate 
      marginTop: "0"
      marginLeft: "0"
      top: "0"
      left: "0"
      width: "27px"
      height: "30px"
      padding: "0px"
    , 50
