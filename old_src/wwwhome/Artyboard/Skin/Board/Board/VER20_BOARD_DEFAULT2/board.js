	function verify_data(){
	
		str = document.all['strName'];
		if(str.value == ""){alert("이름을 입력해주세요.");str.focus();return;}
	
		str = document.all['strPassword'];
		if(document.all['strLoginID'].value == "guest"){
			if(WRITE_BOARD_ADMIN == "False"){if(str.value == ""){alert("패스워드를 입력해주세요.");str.focus();return;}}
		}
	
		str = document.all['strEmail'];
		if(str.value != ""){if(!isEmailCheck(str.value)) {alert("이메일 형식이 올바르지 않습니다.");str.focus();return;}}
	
		str = document.all['strSubject'];
		if(str.value == ""){alert("제목을 입력해주세요.");str.focus();return;}
	
		if (WRITE_USE_EDITOR == true){
			document.getElementById("strContent").value = myeditor.outputBodyHTML();
			if (document.getElementById("strContent").value == ""){
				alert("내용을 입력해 주세요..");myeditor.editArea.focus();return;
			}
		}else{
			str = document.all['strContent'];
			if(str.value == ""){alert("내용을 입력해 주세요.");if (WRITE_USE_EDITOR == "False"){str.focus();}return;}
		}
	
		if(CATEGORY_WRITE_METHOD == "True") {
			str = document.all['intCategory'];
			if (str.value == "0"){alert("카테고리를 선택해 주세요.");str.focus();return;}
		}
	
		if (document.all['bitReMail']!=null && document.all['bitReMail'].checked == true){
			str = document.all['strEmail'];
			if (str.value == "" || !isEmailCheck(str.value)){alert("답변글을 이메일로 받으시려면 올바른 이메일 주소를 입력하세요.");str.focus();return;}
		}

		if (SET_Action != "EDIT"){
			if(document.all['strLoginID'].value == "guest"){
				if(WRITE_BOARD_ADMIN == "False"){
					if (WRITE_USE_CAPTCHA == "True"){
						str = document.all['strCaptchaText'];
						if(str.value == ""){alert("무단입력 방지를 위해 좌측의 글자를 순서대로 입력해 주시기 바랍니다.");str.focus();return;}
						var arr = showModalDialog('Include/BoardCaptcha.asp?strCaptchaText=' + str.value, 'captcha', 'dialogWidth:10px; dialogHeight: 10px; resizable: no; help: no; status: no; scroll: no;');
						if (arr == "0"){
							alert("자동 등록 방지를 위한 문자를 잘못 입력하셨습니다.");str.focus();return;
						}
					}
				}
			}
		}

		document.all['writeButton'].style.display = "none";

		if (WRITE_USE_UPLOAD == "True"){
			if (WRITE_USE_UPLOAD_FLEX == "True"){
				chxUpload.CHXUploadStart();
			}else{
				chxUpload.fileUploadDiv.style.posLeft = (document.body.clientWidth / 2) - 150;
				chxUpload.fileUploadDiv.style.visibility = 'visible';
				chxUpload.document.theUpload.submit();
			}
		}else{
			show_waiting();
			document.theForm.submit();
		}

	}

	function show_waiting(){
		var _x = document.body.clientWidth / 2 + document.body.scrollLeft - 145;
		var _y = document.body.clientHeight / 2 + document.body.scrollTop - 200;
		mb_waiting.style.posLeft=_x;
		mb_waiting.style.posTop=_y;
		mb_waiting.style.visibility='visible';
	}

	function OnBoardLoginCheck(){
		str = document.all['strLoginID'];
		if (str.value == ""){alert("로그인 아이디를 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['strLoginPwd'];
		if (str.value == ""){alert("로그인 비밀번호를 입력해 주시기 바랍니다.");str.focus();return false;}
	}

	function OnReadArticle(str1, str2){
		if (str2 == "0"){
			location.href = "mboard.asp?Action=view&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + SET_INTPAGE + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD + "&intSeq=" + str1;
		}else{
			switch (SET_READ_TYPE){
				case "0" :
					location.href = "mboard.asp?Action=view&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + SET_INTPAGE + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD + "&intSeq=" + str1;
					break;
				case "1" :
					openWindows("mboard.asp?Action=popview&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + SET_INTPAGE + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD + "&intSeq=" + str1, 'popupRead', SET_READ_POPUP_WIDTH, SET_READ_POPUP_HEIGHT, 3);
					break;
				case "2" :
					openWindows("mboard.asp?Action=view&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + SET_INTPAGE + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD + "&intSeq=" + str1, 'popupRead', SET_READ_POPUP_WIDTH, SET_READ_POPUP_HEIGHT, 3);
					break;
			}
		}
	}

	function OnBoardList(){
		location.href = LINK_LIST;
	}

	function OnBoardWrite(str1, str2){

		if (SET_Action == "POPVIEW"){
			switch (str1){
				case "write" : opener.location.href = LINK_WRITE; break;
				case "edit" : opener.location.href = LINK_EDIT + "&intSeq=" + str2; break;
				case "reply" : opener.location.href = LINK_REPLY + "&intSeq=" + str2; break;
			}
			self.close();
		}else{
			switch (str1){
				case "write" : location.href = LINK_WRITE; break;
				case "edit" : location.href = LINK_EDIT + "&intSeq=" + str2; break;
				case "reply" : location.href = LINK_REPLY + "&intSeq=" + str2; break;
			}
		}
	}

	function OnBoardRead(){
		obj = document.all['checkIntSeq'];
		var str = "";
		for(var i=0; i< obj.length; i++){
			if (obj[i].checked == true){
				str = str + obj[i].value + ",";
				if(document.all['checkIntSeqSecret'][i].value == "True"){alert("비밀 게시물은 다중읽기를 하실 수 없습니다.");return;}
			}
		}
		if (str == ""){alert("게시글이 선택되지 않았습니다.");return;}
		
		switch (SET_READ_TYPE){
			case "0" :
				location.href = "mboard.asp?Action=view&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + SET_INTPAGE + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD + "&checkIntSeq=" + str;
				break;
			case "1" :
				openWindows("mboard.asp?Action=popview&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + SET_INTPAGE + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD + "&checkIntSeq=" + str, 'popupRead', SET_READ_POPUP_WIDTH, SET_READ_POPUP_HEIGHT, 3);
				break;
			case "2" :
				openWindows("mboard.asp?Action=view&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + SET_INTPAGE + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD + "&checkIntSeq=" + str, 'popupRead', SET_READ_POPUP_WIDTH, SET_READ_POPUP_HEIGHT, 3);
				break;
		}
	}

	function OnBoardRemove(str){
		location.href = LINK_REMOVE + "&intSeq=" + str;
	}

	function OnDeleteCheck(){
		if (SET_strBoardDeleteMode == "1"){
			str = document.all['strPassword'];
			if (str.value == ""){alert("비밀번호를 입력해 주시기 바랍니다.");str.focus();return false;}
		}
	}

	function OnBoardLogin(){
		location.href = LINK_LOGIN;
	}

	function OnBoardLogout(){
		location.href = LINK_LOGOUT;
	}

	function OnBoardGalleryImg(str){
		location.href = LINK_READ + "&bitViewImageAll=" + str;
	}

	function OnBoardAdmin(){
		obj = document.all['checkIntSeq'];
		if(!obj){alert("관리할 게시글이 없습니다.");return;}

		var str = "";
		if (obj.length == null){
			if (obj.checked == true){
				str = obj.value + ",";
			}
		}else{
			for(var i=0; i< obj.length; i++){
				if (obj[i].checked == true){str = str + obj[i].value + ",";}
			}
		}
		if (str == ""){alert("관리할 게시글이 선택되지 않았습니다.");return;}
		openWindows("Library/Snap.asp?strBoardID=" + SET_STRBOARD_ID + "&intCategory=" + SET_INTCATEGORY + "&intSeq=" + str,"strSnap", 460, 299, 0);
	}

	function OnAddComment(intSeqNum, strLoginID, intThread){

		if (strLoginID == ""){		
			str = document.all['cmtName'];
			if (str.value == ""){alert("이름을 입력해 주시기 바랍니다.");str.focus();return;}

			str = document.all['cmtPwd'];
			if (str.value.length < 4){alert("비밀번호를 4자리 이상 입력해 주시기 바랍니다.");str.focus();return;}
			
			document.theCmtForm.comment_id.value = "guest";
		}else{
			document.theCmtForm.comment_id.value = strLoginID;
		}

		if (SET_bitUseEditor == "False"){
			str = document.all['cmtContent'];
			if (str.value == ""){alert("내용을 입력해 주시기 바랍니다.");str.focus();return;}
		}else{
			document.getElementById("cmtContent").value = myeditor.outputBodyHTML();
			if (document.getElementById("cmtContent").value == ""){alert("내용을 입력해 주시기 바랍니다.");myeditor.editArea.focus();return;}
		}

		document.theCmtForm.comment_intThread.value = intThread;
		document.theCmtForm.comment_name.value = document.all['cmtName'].value;
		if (strLoginID == "")
			document.theCmtForm.comment_pwd.value = document.all['cmtPwd'].value;
		document.theCmtForm.comment_content.value = document.all['cmtContent'].value;

		obj = document.all['cmtScore'];
		if (obj!=null){
			var cntBox = obj.length - 1;
			for(var i = 0; i <= cntBox; i++){
				if (obj[i].checked == true){
					document.theCmtForm.comment_intScore.value = document.all['cmtScore'][i].value;
				}
			}
		}

		obj = document.all['cmtIcon'];
		if (obj!=null){
			document.theCmtForm.comment_intIcon.value = document.all['cmtIcon'].value;
		}

		document.theCmtForm.action = "Include/CommentAction.asp?Action=cmtadd&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + SET_INTPAGE + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD + "&checkIntSeq=" + SET_CHECK_INT_SEQ + "&strScYear=" + SET_SCH_YEAR + "&strScMonth=" + SET_SCH_MONTH + "&strScDay=" + SET_SCH_DAY + "&intSeq=" + SET_intSeq;
		document.theCmtForm.submit();
	}

	function OnSubmitComment(strLoginID, sType){

		str = document.all['cmtName'];
		if (str.value == ""){
			alert("이름을 입력해 주시기 바랍니다.");str.focus();return;
		}

		document.theCmtForm.comment_name.value = document.all['cmtName'].value;

		if (strLoginID == ""){
			str = document.all['cmtPwd'];
			if (str.value.length < 4){alert("비밀번호를 4자리 이상 입력해 주시기 바랍니다.");str.focus();return;}
			document.theCmtForm.comment_pwd.value = document.all['cmtPwd'].value;
		}

		if (SET_bitUseEditor == "False"){
			str = document.all['cmtContent'];
			if (str.value == ""){alert("내용을 입력해 주시기 바랍니다.");str.focus();return;}
		}else{
			document.getElementById("cmtContent").value = myeditor.outputBodyHTML();
			if (document.getElementById("cmtContent").value == ""){alert("내용을 입력해 주시기 바랍니다.");myeditor.editArea.focus();return;}
		}

		document.theCmtForm.comment_content.value = document.all['cmtContent'].value;

		obj = document.all['cmtScore'];
		if (obj!=null){
			var cntBox = obj.length - 1;
			for(var i = 0; i <= cntBox; i++){
				if (obj[i].checked == true)
					document.theCmtForm.comment_intScore.value = document.all['cmtScore'][i].value;
			}
		}

		obj = document.all['cmtIcon'];
		if (obj!=null){
			document.theCmtForm.comment_intIcon.value = document.all['cmtIcon'].value;
		}

		switch (sType){
		case "E" :
			document.theCmtForm.action = "Include/CommentAction.asp?Action=cmtedit&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + SET_INTPAGE + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD + "&checkIntSeq=" + SET_CHECK_INT_SEQ + "&strScYear=" + SET_SCH_YEAR + "&strScMonth=" + SET_SCH_MONTH + "&strScDay=" + SET_SCH_DAY + "&intSeq=" + SET_intSeq + "&intCmtSeq=" + SET_intCmtSeq;
			document.theCmtForm.submit();
			break;
		case "R" :
			document.theCmtForm.action = "Include/CommentAction.asp?Action=cmtreply&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + SET_INTPAGE + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD + "&checkIntSeq=" + SET_CHECK_INT_SEQ + "&strScYear=" + SET_SCH_YEAR + "&strScMonth=" + SET_SCH_MONTH + "&strScDay=" + SET_SCH_DAY + "&intSeq=" + SET_intSeq + "&intCmtSeq=" + SET_intCmtSeq;
			document.theCmtForm.submit();
			break;
		}
	}

	function OnCommentReply(intCmtSeq){
		document.theCmtForm.action = "mboard.asp?Action=CMTREPLY&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + SET_INTPAGE + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD + "&checkIntSeq=" + SET_CHECK_INT_SEQ + "&strScYear=" + SET_SCH_YEAR + "&strScMonth=" + SET_SCH_MONTH + "&strScDay=" + SET_SCH_DAY + "&intSeq=" + SET_intSeq + "&intCmtSeq=" + intCmtSeq;
		document.theCmtForm.submit();
	}

	function OnCommentEdit(str1, str2){
		document.theCmtForm.action = "mboard.asp?Action=CMTEDIT&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + SET_INTPAGE + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD + "&checkIntSeq=" + SET_CHECK_INT_SEQ + "&intCmtSeq=" + str1 + "&intSeq=" + str2;
		document.theCmtForm.submit();
	}

	function OnEraseComment(intCmtSeq){
		theCmtForm.action = "Mboard.asp?Action=cmtremove&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + SET_INTPAGE + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD + "&checkIntSeq=" + SET_CHECK_INT_SEQ + "&strScYear=" + SET_SCH_YEAR + "&strScMonth=" + SET_SCH_MONTH + "&strScDay=" + SET_SCH_DAY + "&intSeq=" + SET_intSeq + "&intCmtSeq=" + intCmtSeq;
		theCmtForm.submit();
	}

	function OnEraseCommentSubmit(){
		if (SET_strCmtDeleteMode == "1"){
			str = document.all['strPassword'];
			if (str.value == ""){alert("비밀번호를 입력해 주시기 바랍니다.");str.focus();return false;}
		}
	}

	function OnVote(intSeq){
		if (confirm("해당 게시글을 추천하시겠습니까?")){
			location.href = "Library/VoteAction.asp?strBoardID=" + SET_STRBOARD_ID + "&intPage=" + SET_INTPAGE + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD + "&checkIntSeq=" + SET_CHECK_INT_SEQ + "&intSeq=" + intSeq;
		}
	}

	function OnCategoryGo(str){
		location.href = "mboard.asp?Action=list&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + SET_INTPAGE + "&intCategory=" + str + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD;
	}
	
	function OnSearch(){
		var k = 0;
		var s = "";
		for (i=0; i < 4; i++){
			if (SET_SEARCH_CATEGORY_DIM[i]!= ""){
				k++;
			}
			s = s + SET_SEARCH_CATEGORY_DIM[i] + "|";
		}
		if (k == 0){alert("검색할 항목을 선택해 주시기 바랍니다.");return;}

		str = document.all['searchWord'];
		if (str.value == ""){alert("검색할 내용을 입력해 주시기 바랍니다.");str.focus();return;}
	
		location.href = "mboard.asp?Action=list&strBoardID=" + SET_STRBOARD_ID + "&intPage=1&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + s + "&strSearchWord=" + str.value;
	}

	function OnSearchCancel(){
		location.href = "mboard.asp?Action=list&strBoardID=" + SET_STRBOARD_ID + "&intPage=1&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=&strSearchWord=";
	}
	
	function check_enter(id) {
		if(event.keyCode == 13) {
			switch (id){
				case "search" : OnSearch(); break;
				case "jump_page" : break;
				case "del_comment" : break;
			}
			event.returnValue = false;
		}
	}
	
	function go_jump(){
		str = document.all['jump_page'];
		if (str.value == "" || !onlynum(str)){
			alert("이동할 페이지를 입력하지 않았거나 숫자가 아닌 문자를 입력하셨습니다.");
			str.focus();
			return;
		}
		document.theForm.action = "mboard.asp?Action=list&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + str.value + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD;
		document.theForm.submit();
	}

	function OnListPreview(content) {
		var obj = document.all["id_preview"];
	
		if(content == "") {obj.innerHTML = "";return;}
	
		var text = "";
		text =  "<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
		text += "    <tr>";
		text += "        <td>";
		text += "            <td bgcolor='#FFFFFF' style='word-break:break-all; padding:5px;'>" + content + "</td>";
		text += "        </td>";
		text += "    </tr>";
		text += "</table>";
	
		obj.innerHTML = text;
		OnListMovePreview();
		obj.style.visibility = "visible";
	}
	
	function OnListMovePreview() {
		var obj = document.all["id_preview"];
	
		if(obj.innerHTML != ""){
			obj.style.posLeft = event.x - 40 + document.documentElement.scrollLeft;
			obj.style.posTop = event.y + 10 + document.documentElement.scrollTop;
		}
	}

	function OnListHidePreview() {
		document.all["id_preview"].style.visibility = "hidden";
	}

	function OnPasswordCheck(){
		str = document.all['strPassword'];
		if (str.value == ""){alert("비밀번호를 입력해 주시기 바랍니다.");str.focus();return false;}

		document.theForm.submit();

	}

	function OnFileDown(str1, str2, str3){
		location.href = "Library/fileDown.asp?strBoardID=" + str2 + "&intNum=" + str1 + "&intSeq=" + str3;
	}
	
	function OnBoardPrint(intSeq, strBoardID){
		window.open('Library/boardPrint.asp?strBoardID=' + strBoardID + '&intSeq=' + intSeq);
	}
	
	function OnBoardBad(intSeq, strBoardID){
		openWindows("Library/BoardBad.asp?strBoardID=" + strBoardID + "&intSeq=" + intSeq,"strBadBoard", 460, 370, 0);
	}
	
	function OnHtmlBr(){
		if(confirm("자동 줄바꿈을 하시겠습니까?\n\n자동 줄바꿈은 게시물 내용중 줄바뀐 곳을 <br>태그로 변환하는 기능입니다.")){
			document.all['bitHtmlBr'].value = "1";
		}
	}

	function OnBoardSelectAll(){
		var obj = document.getElementsByName("checkIntSeq"); 
		for (var i=0; i<obj.length; i++){
			if (obj[i].checked == true){
				obj[i].checked = false;
			}else{
				obj[i].checked = true;
			}
		}
	}

	function Onrollover(obj, color) {
		if(!obj) return false;
		obj.style.backgroundColor = color;
	}
	
	function OnPageMove(str){
		document.theForm.action = "mboard.asp?Action=list&strBoardID=" + SET_STRBOARD_ID + "&intPage=" + str + "&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=" + SET_SEARCH_CATEGORY + "&strSearchWord=" + SET_SEARCH_WORD;
		document.theForm.submit();
	}
	
	function OnGalleryChange(str1, str2, str3, str4, str5){
		SET_GALLERY_NOW_IMG = str2;
		var new_img = document['galleryIMG_' + str1];
		new_img.src = "Pds/Board/" + str5 + "/" + str2;
		new_img.width = str3;
		new_img.height = str4;
	}
	
	function OnScrap(intSeq){
		if (SET_Action == "POPVIEW"){
			opener.openWindows('scrap.asp?Action=add&strBoardID=' + SET_STRBOARD_ID + '&intSeq=' + intSeq, 'scrap', '500','500','0');
			self.close();
		}else{
			openWindows('scrap.asp?Action=add&strBoardID=' + SET_STRBOARD_ID + '&intSeq=' + intSeq, 'scrap', '500','500','0');
		}
	}

	function OnWritePrevIMG(filename){
		filename = filename.split(",");
		fileExt = filename[1].split(".");

		var uploaded_filename = "Pds/Board/" + SET_STRBOARD_ID + "/" + filename[1];

		var html = "";

		if (fileExt[1] == "gif" || fileExt[1] == "jpg" || fileExt[1] == "jpeg" || fileExt[1] == "png" || fileExt[1] == "bmp"){
			html = "<img src=" + uploaded_filename + " width=100 height=100>";
		}

		if (fileExt[1] == "flv"){
			html = "<EMBED src=\"Library/flvplayer.swf?autoStart=false&file=../"+uploaded_filename+"\" width=\"110\" height=\"110\" type=\"application/x-shockwave-flash\"></EMBED>";
		}

		if (fileExt[1] == "swf"){
			html = "<EMBED src=\""+uploaded_filename+"\" width=\"110\" height=\"110\" type=\"application/x-shockwave-flash\"></EMBED>";
		}

		if (fileExt[1] == "wmv" || fileExt[1] == "avi" || fileExt[1] == "mpg" || fileExt[1] == "mpeg" || fileExt[1] == "asx" || fileExt[1] == "asf" || fileExt[1] == "mp3"){
			html = "<EMBED src=\""+uploaded_filename+"\" width=\"110\" height=\"110\" autostart=\"true\" Showcontrols=\"0\"></EMBED>";
		}

		document.all['imtPrev'].innerHTML = html;
	}

	function OnUploadFileDelete(sType){
		var obj = document.theForm.strFileList;
		if(obj.value == "")
			return false;

		if (sType == "1"){
			str = document.theForm.strFilePass;
			if (str.value == ""){alert("게시글 비밀번호를 입력해 주시기 바랍니다.");str.focus();return false;}
			document.tmp_upload_form.upload_strPwd.value = str.value;
		}

		if (!confirm("선택된 파일을 삭제하시겠습니까?")){
			return false;
		}

		for(var i=0; i< obj.length; i++){
			if (obj[i].selected == true){
				tmpNum = obj[i].value.split(",");
				document.tmp_upload_form.action = "Include/BoardUploadErase.asp?strBoardID=" + SET_STRBOARD_ID + "&intSeq=" + SET_intSeq + "&intNum=" + tmpNum[0];
				document.tmp_upload_form.target = "tmp_upload_iframe";
				document.tmp_upload_form.submit();
			}
		}
	}