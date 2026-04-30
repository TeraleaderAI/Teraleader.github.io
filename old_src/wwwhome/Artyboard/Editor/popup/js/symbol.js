var c = null;
var curView = null;
var S1 = '£¢ £¨ £© £Û £Ý £û £ý ¡® ¡¯ ¡° ¡± ¡² ¡³ ¡´ ¡µ ¡¶ ¡· ¡¸ ¡¹ ¡º ¡» ¡¼ ¡½ ¡× ¡Ø ¡Ù ¡Ú ¡Û ¡Ü ¡á ¡â ¡ã ¡ä ¡å ¡æ ¡ë ¢· ¢¸ ¢¹ ¢º ¢» ¢À ¢Á ¢Â ¢Ã ¢Ä ¢Å ¢Ê ¢Ë ¢Ì ¢Í ¢Î ¢Ï ¢Ô ¢Þ ¢Õ ¢Ö ¢× ¢Ø ¢Ù ¢ß ¢à ¢á ¢â ¢ã £« £­ £¼ £½ £¾ ¡¾ ¡¿ ¡À ¡Á ¡Â ¡Ã ¡Ä ¡Å ¡Î ¡Ï ¡Ð ¡Ñ ¡Ò ¡Ó ¡Ô ¡Õ ¡Ö ¡ì ¡í ¡î ¡ï ¡ð ¡ñ ¡ò ¡ó ¡ô ¡õ ¡ö ¡÷ ¡ø ¡ù ¢± ¡ú ¡û ¢² ¢³ ¡ü ¡ý ¡þ ¢¡ ¢¢ ¢£ ¢¤';
var S2 = '¦¡ ¦¢ ¦£ ¦¤ ¦¥ ¦¦ ¦§ ¦¨ ¦© ¦ª ¦« ¦¬ ¦­ ¦® ¦¯ ¦° ¦± ¦² ¦³ ¦´ ¦µ ¦¶ ¦· ¦¸ ¦¹ ¦º ¦» ¦¼ ¦½ ¦¾ ¦¿ ¦À ¦Á ¦Â ¦Ã ¦Ä ¦Å ¦Æ ¦Ç ¦È ¦É ¦Ê ¦Ë ¦Ì ¦Í ¦Î ¦Ï ¦Ð ¦Ñ ¦Ò ¦Ó ¦Ô ¦Õ ¦Ö ¦× ¦Ø ¦Ù ¦Ú ¦Û ¦Ü ¦Ý ¦Þ ¦ß ¦à ¦á ¦â ¦ã ¦ä';
var S3 = '¨ö ¨÷ ¨ø ¨ù ¨ú ¨û ¨ü ¨ý ¨þ ©ö ©÷ ©ø ©ù ©ú ©û ©ü ©ý ©þ £° £± £² £³ £´ £µ £¶ £· £¸ £¹ ¥¡ ¥¢ ¥£ ¥¤ ¥¥ ¥¦ ¥§ ¥¨ ¥© ¥ª ¥° ¥± ¥² ¥³ ¥´ ¥µ ¥¶ ¥· ¥¸ ¥¹ £¤ £¥ £Ü ¡Æ ¡Ç ¡È ¡É ¡Ê ¡Ë ¡Ì ¡Í ¢´ ¢µ ¢¶ §¡ §¢ §£ §¤ §¥ §¦ §§ §¨ §© §ª §« §¬ §­ §® §¯ §° §± §² §³ §´ §µ §¶ §· §¸ §¹ §º §» §¼ §½ §¾ §¿ §À §Á §Â §Ã §Ä §Å §Æ §Ç §È §É §Ê §Ë §Ì §Í §Î §Ï §Ð §Ñ §Ò §Ó §Ô §Õ §Ö §× §Ø §Ù §Ú §Û §Ü §Ý §Þ §ß §à §á §â §ã §ä §å §æ §ç §è §é §ê §ë §í §î §ï'; 
var S4 = '¤Õ ¤Ö ¤× ¤Ø ¤Ù ¤Ú ¤Û ¤Ü ¤Ý ¤Þ ¤à ¤ß ¤á ¤â ¤ã ¤ä ¤å ¤æ ¤ç ¤è ¤é ¤ê ¤ë ¤ì ¤í ¤î ¤ï ¤ð ¤ñ ¤ò ¤ó ¤ô ¤õ ¤ö ¤÷ ¤ø ¤ù ¤ú ¤û ¤ü ¤ý ¤þ';
var S5 = '¨± ¨² ¨³ ¨´ ¨µ ¨¶ ¨· ¨¸ ¨¹ ¨º ¨» ¨¼ ¨½ ¨¾ ¨¿ ¨À ¨Á ¨Â ¨Ã ¨Ä ¨Å ¨Ç ¨Ç ¨È ¨É ¨Ê ¨Ë ¨Ì ©± ©² ©³ ©´ ©µ ©¶ ©· ©¸ ©¹ ©º ©» ©¼ ©½ ©¾ ©¿ ©À ©Á ©Â ©Ã ©Ä ©Å ©Æ ©Ç ©È ©É ©Ê ©Ë ©Ì ¨Í ¨Î ¨Ï ¨Ð ¨Ñ ¨Ò ¨Ó ¨Ô ¨Õ ¨Ö ¨× ¨Ø ¨Ù ¨Ú ¨Û ¨Ü ¨Ý ¨Þ ¨ß ¨à ¨á ¨â ¨ã ¨ä ¨å ¨æ ¨ç ¨è ¨é ¨ê ¨ë ¨ì ¨í ¨î ¨ï ¨ð ¨ñ ¨ò ¨ó ¨ô ¨õ ©Í ©Î ©Ï ©Ð ©Ñ ©Ò ©Ó ©Ô ©Õ ©Ö ©× ©Ø ©Ù ©Ú ©Û ©Ü ©Ý ©Þ ©ß ©à ©á ©â ©ã ©ä ©å ©æ ©ç ©è ©é ©ê ©ë ©ì ©í ©î ©ï ©ð ©ñ ©ò ©ó ©ô ©õ';
var japan1 = 'ª¡ ª« ªµ ª¿ ªÉ ªÓ ªÝ ªç ªñ ª¢ ª¬ ª¶ ªÀ ªÊ ªÔ ªÞ ªè ªò ª£ ª­ ª· ªÁ ªË ªÕ ªß ªé ªó ª¤ ª® ª¸ ªÂ ªÌ ªÖ ªà ªê ª¥ ª¯ ª¹ ªÃ ªÍ ª× ªá ªë ª¦ ª° ªº ªÄ ªÎ ªØ ªâ ªì ª§ ª± ª» ªÅ ªÏ ªÙ ªã ªí ª¨ ª² ª¼ ªÆ ªÐ ªÚ ªä ªî ª© ª³ ª½ ªÇ ªÑ ªÛ ªå ªï ªª ª´ ª¾ ªÈ ªÒ ªÜ ªæ ªð';
var japan2 = '«¡ «« «µ «¿ «É «Ó «Ý «ç «ñ «¢ «¬ «¶ «À «Ê «Ô «Þ «è «ò «£ «­ «· «Á «Ë «Õ «ß «é «ó «¤ «® «¸ «Â «Ì «Ö «à «ê «ô «¥ «¯ «¹ «Ã «Í «× «á «ë «õ «¦ «° «º «Ä «Î «Ø «â «ì «ö «§ «± «» «Å «Ï «Ù «ã «í «¨ «² «¼ «Æ «Ð «Ú «ä «î «© «³ «½ «Ç «Ñ «Û «å «ï «ª «´ «¾ «È «Ò «Ü «æ «ð';

c = S1.split(' ');
var button = [ { alt : "", img : 'input.gif', 	cmd : inputChar },              
               { alt : "", img : 'cancel.gif', 	cmd : popupClose } ];

var oEditor = null;

function init(dialog) {
	oEditor = this;
	oEditor.dialog = dialog;
	
	var dlg = new Dialog(oEditor);
	dlg.showButton(button);
	
	setupEvent();
	dlg.setDialogHeight();
}

function showTable() {
  	var k = 0;
  	var len = c.length;
  	var w = 9;
  	var h = 20;
  	
  	var table = document.createElement('table');
  	table.border = 0;
  	table.cellSpacing = 1;
  	table.cellPadding = 0;
  	table.align = 'center';
  	
  	for(i=0; i < w; i++) {
  		var tr = table.insertRow(i);
    	for(var j = 0; j < h; j++) {
    		var td = tr.insertCell(j);
    		td.className = 'schar';
    		
        	if ( len < k+1) {
        		td.appendChild(document.createTextNode('\u00a0'));
        	}
        	else {
        		td.style.cursor = 'pointer';
        		td.id = k;
        		td.onclick = function() { getchar(this.id); };
        		td.onmouseover = function() { hover(this, true); };
        		td.onmouseout = function() { hover(this, false); };
        		td.appendChild(document.createTextNode(c[k]));
        	}
      		k++;
    	}
  	}

  	var output = document.getElementById('output');
  	if (output.hasChildNodes()) {
  		for (var i=0; i<output.childNodes.length; i++) {
  			output.removeChild(output.firstChild);
  		}
  	}
  	output.appendChild(table);
}

function sp1 () {
	c = S1.split(' ');
	showTable();
}

function sp2 () {
	c = S2.split(' ');
	showTable();
}

function sp3 () {
	c = S3.split(' ');
	showTable();
}

function sp4 () {
	c = S4.split(' ');
	showTable();
}

function sp5 () {
	c = S5.split(' ');
	showTable();
}

function sp6 () {
	c = japan1.split(' ').concat(japan2.split(' '));
	showTable();
}

function hover(obj, val) {
  	obj.style.backgroundColor = val ? "#5579aa" : "#fff";
  	obj.style.color = val ? "#fff" : "#000";
}

function getchar(i) {
  	document.getElementById('fm_input').value = document.getElementById('fm_input').value + c[i];
}

function inputChar() {
	oEditor.insertHtmlPopup(document.getElementById('fm_input').value);
	oEditor.popupWinClose();
}

function popupClose() {
    oEditor.popupWinClose();
}

function setupEvent() {
	var el = document.body.getElementsByTagName('LABEL');
	
	for (var i=0; i < el.length; i++) {
		el[i].className = 'handCursor';
		el[i].style.fontSize = '9pt';
		el[i].style.margin = (i==0) ? '0px 0px 5px 5px' : '0px 0px 5px 0px';
		el[i].onclick = function () {
			document.getElementById(this.id).style.fontWeight = 'bold';
			switch (this.id) {
			case 's1' : sp1(); break;
			case 's2' : sp2(); break;
			case 's3' : sp3(); break;
			case 's4' : sp4(); break;
			case 's5' : sp5(); break;
			default : sp6();
			};
			
			if (curView != this.id) {
				document.getElementById(curView).style.fontWeight = 'normal';
			}
			curView = this.id;
		} ;

	}
	
	if (curView == null) {
		showTable();
		curView = 's1';
		document.getElementById(curView).style.fontWeight = 'bold';
		document.getElementById('output').style.visibility = 'visible';
	}
	
	document.getElementById("fm_input").value = "";
}