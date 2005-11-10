// Morten's JavaScript Tree Menu Tracking Script
// version 2.3.2-macfriendly, dated 2002-06-10
// http://www.treemenu.com/

// Copyright (c) 2001-2002, Morten Wang & contributors
// All rights reserved.

// This software is released under the BSD License which should accompany
// it in the file "COPYING".  If you do not have this file you can access
// the license through the WWW at http://www.treemenu.com/license.txt

if((navigator.appName == "Netscape" && parseInt(navigator.appVersion) >= 3 && navigator.userAgent.indexOf("Opera") == -1) || (navigator.appName == "Microsoft Internet Explorer" && parseInt(navigator.appVersion) >= 4) || (navigator.appName == "Opera" && parseInt(navigator.appVersion) >= 5)) {
	var MTMCodeFrame = "code";
	for(i = 0; i < parent.frames.length; i++) {
		if(parent.frames[i].name == MTMCodeFrame && parent.frames[i].MTMLoaded) {
			parent.frames[i].MTMTrack = true;
			setTimeout("parent.frames[" + i + "].MTMDisplayMenu()", 50);
			break;
		}
	}
}

var n;
function help(n) {
    var url = "/Salva/Help/?id="+n;
    window.open(url,"Help","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300,height=300");
}


var mail;
function pastemail (mail) {
	top.opener.parent.text.document.forms['Cards'].a_email.value=mail;
}

