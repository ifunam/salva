// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function handleKeyPress(keyEvent)
{
 // Below handler Navigator/IE differences
 var keyEvent = (keyEvent ? keyEvent : event);
 var keyPressed = (keyEvent.which ? keyEvent.which : keyEvent.keyCode);

 if (keyPressed == 9 || keyPressed == 13) // 9 = TAB key and 13 = ENTER key
 {
  return true;
 }
}

function checkString(string)
{
 if (string.length >= 1 ) {
     return true;
 }
}

function set_class_name(element, class_name) {
  new Element.ClassNames(element).set(class_name);
}

function hide_element(element) {
  $(element).hide();
}

function check_ids_from_list(form) {
 var ids = $(form).getInputs('checkbox' , 'id[]');
 var n= ids.length;
 for (i=0; i<n; i++) {
         ids[i].checked = true;
 }
}

function uncheck_ids_from_list(form) {
 var ids = $(form).getInputs('checkbox' , 'id[]');
 var n= ids.length;
 for (i=0; i<n; i++) {
         ids[i].checked = false;
 }
}
