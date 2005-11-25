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
