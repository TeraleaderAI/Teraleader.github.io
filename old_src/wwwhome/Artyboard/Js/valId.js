
function onlynum(objtext1, msg){
	var inText = objtext1.value;
	var ret;

	for (var i = 0; i < inText.length; i++) {
    ret = inText.charCodeAt(i);
		if (!((ret > 47) && (ret < 58))){
			if (msg == "1"){
				alert("숫자만 입력이 가능합니다.");
				objtext1.value = "";
				objtext1.focus();
			}
			return false;
		}
	}
	return true;
}

function onlyInt(objtext1){
	var inText = objtext1.value;
	var ret;

	for (var i = 0; i < inText.length; i++) {
    ret = inText.charCodeAt(i);
		if (!((ret > 47) && (ret < 58))){
			if (ret!= 45){
				alert("숫자 또는 음수부호(-)만 입력이 가능합니다.");
				objtext1.value = "";
				objtext1.focus();
				return false;
			}
		}
	}
	return true;
}

function onlyBoardID(objtext1){
	var inText = objtext1.value;
	var ret;

	for (var i = 0; i < inText.length; i++) {
		ret = inText.charCodeAt(i);
		if ((ret > 122) || (ret < 48) || (ret > 57 && ret < 65) || (ret > 90 && ret < 97)) {
			if (ret!=95){
				alert("영문자와 숫자만을 입력하세요");objtext1.value = "";objtext1.focus();return false;
			}
		}
	}
	return true;
}

function openWindows(filename,p_name,s_width,s_height,s_scrol){
	var x = screen.width;
	var y = screen.height;
	var wid = (x / 2) - (s_width / 2);
	var hei = (y / 2) - (s_height / 2);

	window.open(filename, p_name, "toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=0,scrollbars=" + s_scrol + ",width=" + s_width + ",height=" + s_height + ",top=" + hei + ",left=" + wid + ",scrolbar=no"); 
}

function isUserId(str){
	var valid = true;
	var cmp = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz01234567890.";

	if (str.length < 4 ) return false;
		for (var i=0; i<str.length; i++) {
			if (cmp.indexOf(str.charAt(i)) < 0) {
				valid = false;
				break;
		}
	}
	return valid;
}
	
function isSSNNo(str){
	var idtot = 0;
	var idadd = "234567892345";
		
	for (var i=0; i<12; i++) {
		idtot = idtot+parseInt(str.substring(i,i+1))*parseInt(idadd.substring(i,i+1));
	}
	idtot=11-(idtot%11);
	if (idtot==10) {
		idtot=0;
	} else if(idtot==11) {
		idtot=1;
	}
	if (parseInt(str.substring(12,13))!=idtot) 
		return false;
	return true;
}

function OnDisplayView(str){
	if (document.all[str].style.display == "none"){
		document.all[str].style.display = "block";
	}else{
		document.all[str].style.display = "none";
	}
}

function OnColorPicker(id) {
	var left = (screen.width - 210) / 2;
	var top = (screen.height - 325) / 3;

	window.open("../../Library/setColor.asp?target=" + id, "",
		"width=210, height=325, left="+left+", top="+top);
}

function resize_textarea(id, row, col){
	if (col == "")
		cols = 0;

	if(document.all[id].rows + row > 0)
		document.all[id].rows += row;
	
	if(document.all[id].cols + col > 0)
		document.all[id].cols += col;
}

function reset_textarea(id, row) {
	document.all[id].rows = row;
}

function OnZoomGallery(str1, str2){

	var x = document.body.offsetWidth - 50;
	var y = document.body.offsetHeight - 50;

	window.open('Library/ZoomImage.asp?sType=0&strFileName=' + str1 + "&strBoardID=" + str2,'','width=1,height=1');
}

function popupImg(src){
	if (!src) src = this.src;
	window.open('Library/ZoomImage.asp?sType=0&strFileName=' + str1 + "&strBoardID=" + str2,'','width=1,height=1');
}

function OnColorSet(obj1, obj2){
	if (obj2.value.length < 7){
		obj2.value = "";
		alert("올바르게 색상을 입력해 주시기 바랍니다.\n\n예)#FFFFFF");
		obj2.focus();
		return false;
	}
	obj1.style.backgroundColor = obj2.value;
}

function OnBoardConfigCopy(str1, str2){
	var obj = document.all['copyConfig'];
	var cntBox = obj.length - 1;
	var cList = "";

	for(var i = 0; i <= cntBox; i++){
		if (obj[i].checked == true){
			cList = cList + obj[i].value + ",";
		}
	}

	if (str1 == "5"){
		obj = document.all['copyConfigRe'];
		cntBox = obj.length - 1;
		cList = cList + "$";
		for(var i = 0; i <= cntBox; i++){
			if (obj[i].checked == true){
				cList = cList + obj[i].value + ",";
			}
		}
	}

	if (cList == ""){
		alert("복사할 항목을 선택해 주시기 바랍니다.");return false;
	}

	popupLayer("BoardCopyList.asp?Action=" + str1 + "&strBoardID=" + str2 + "&strField=" + cList, 520,480);

}

function OnConfigSelect(){
	var obj = document.all['copyConfig'];
	var cntBox = obj.length - 1;
	for(var i = 0; i <= cntBox; i++){
		if (obj[i].checked == true){
			obj[i].checked = false;
		}else{
			obj[i].checked = true;
		}
	}
}

function OnBoardConfigCopyRe(str1, str2){
	var obj = document.all['copyConfig'];
	var cntBox = obj.length - 1;
	var cList = "";
	for(var i = 0; i <= cntBox; i++){
		if (obj[i].checked == true){
			cList = cList + obj[i].value + ",";
		}
	}
	
	if (cList == ""){
		alert("게시판 권한설정 부분에서 복사할 항목을 선택해 주시기 바랍니다.");return false;
	}

	obj = document.all['copyConfigRe'];
	cntBox = obj.length - 1;
	var rList = "";
	for(var i = 0; i <= cntBox; i++){
		if (obj[i].checked == true){
			rList = rList + obj[i].value + ",";
		}
	}
	
	cList = cList + "$" + rList;
	openWindows("BoardCopyList.asp?Action=" + str1 + "&strBoardID=" + str2 + "&strField=" + cList, "BoardCopyList", 480, 470, 0);
}

function OnConfigSelectRe(){
	var obj = document.all['copyConfig'];
	var cntBox = obj.length - 1;
	for(var i = 0; i <= cntBox; i++){
		if (obj[i].checked == true){
			obj[i].checked = false;
		}else{
			obj[i].checked = true;
		}
	}

	obj = document.all['copyConfigRe'];
	cntBox = obj.length - 1;
	for(var i = 0; i <= cntBox; i++){
		if (obj[i].checked == true){
			obj[i].checked = false;
		}else{
			obj[i].checked = true;
		}
	}
}

function OnAdminBoardPageMove(page, str){

	if (page == ""){
		return false;
	}else{
		switch (str){
			case "1" :
				location.href = "BoardDefaultConfig.asp?strBoardID=" + page;
				break;
			case "2" :
				location.href = "BoardListConfig.asp?strBoardID=" + page;
				break;
			case "3" :
				location.href = "BoardReadConfig.asp?strBoardID=" + page;
				break;
			case "4" :
				location.href = "BoardWriteConfig.asp?strBoardID=" + page;
				break;
			case "5" :
				location.href = "BoardCategoryConfig.asp?strBoardID=" + page;
				break;
			case "6" :
				location.href = "BoardPointConfig.asp?strBoardID=" + page;
				break;
		}
	}
}

	function onlyNumber(){
		if((event.keyCode == 13) || (event.keyCode == 190) || (event.keyCode >= 96 && event.keyCode <= 105) || (event.keyCode == 110) || (event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8 || event.keyCode == 16 || event.keyCode == 116 || event.keyCode == 18 || event.keyCode == 9 || (event.keyCode >= 37 && event.keyCode <= 40) || event.keyCode == 46);
		else event.returnValue = false;
	}

	function playflash(file,width,height,bgcolor,quality,name){
	 document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="'+width+'" height="'+height+'" id="'+name+'">');
	 document.write('<param name="movie" value="'+file+'" />');
	 document.write('<param name="quality" value="'+quality+'" />');
	 document.write('<param name="wmode" value="transparent" />');
	 document.write('<param name="bgcolor" value="'+bgcolor+'" />');
	 document.write('<embed src="'+file+'" quality="'+quality+'" wmode="transparent" bgcolor="'+bgcolor+'" width="'+width+'" height="'+height+'" name="'+name+'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />');
	 document.write('</object>')
	}

function _ID(obj){return document.getElementById(obj)}

function popupLayer(s,w,h)
{
	if (!w) w = 600;
	if (!h) h = 400;

	var pixelBorder = 3;
	var titleHeight = 12;
	w += pixelBorder * 2;
	h += pixelBorder * 2 + titleHeight;

	var bodyW = document.body.clientWidth;
	var bodyH = document.body.clientHeight;

	var posX = (bodyW - w) / 2;
	var posY = (bodyH - h) / 2;

	var obj = document.createElement("div");
	with (obj.style){
		position = "absolute";
		left = 0;
		top = 0;
		width = "100%";
		height = document.body.scrollHeight;
		backgroundColor = "#000000";
		filter = "Alpha(Opacity=50)";
		opacity = "0.5";
	}
	obj.id = "objPopupLayerBg";
	document.body.appendChild(obj);

	var obj = document.createElement("div");
	with (obj.style){
		position = "absolute";
		left = posX + document.body.scrollLeft;
		top = posY + document.body.scrollTop;
		width = w;
		height = h;
		backgroundColor = "#FFFFFF";
		border = "3px solid #000000";
	}
	obj.id = "objPopupLayer";
	document.body.appendChild(obj);

	var bottom = document.createElement("div");
	with (bottom.style){
		position = "absolute";
		width = w - pixelBorder * 2;
		height = titleHeight;
		left = 0;
		top = h - titleHeight - pixelBorder * 3;
		padding = "2px 0 0 0";
		textAlign = "right";
		backgroundColor = "#000000";
		color = "#ffffff";
		font = "bold 11px tahoma";
	}
	bottom.innerHTML = "<a href='javascript:closeLayer()'><font color='#FFFFFF'>창닫기</font></a>&nbsp;&nbsp;&nbsp;";
	obj.appendChild(bottom);

	var ifrm = document.createElement("iframe");
	with (ifrm.style){
		width = w - 6;
		height = h - pixelBorder * 2 - titleHeight - 3;
	}
	ifrm.frameBorder = 0;
	ifrm.src = s;
	obj.appendChild(ifrm);
}

	function closeLayer(){
		_ID('objPopupLayer').parentNode.removeChild( _ID('objPopupLayer') );
		_ID('objPopupLayerBg').parentNode.removeChild( _ID('objPopupLayerBg') );
	}

	function isEmailCheck(str) {
		if(str == "") return false;
		var regex = /[-!#$%&'*+/^_~{}|0-9a-zA-Z]+(.[-!#$%&'*+/^_~{}|0-9a-zA-Z]+)*@[-!#$%&'*+/^_~{}|0-9a-zA-Z]+(.[-!#$%&'*+/^_~{}|0-9a-zA-Z]+)*/;
		if(regex.test(str)) return true;
		else return false;
	}