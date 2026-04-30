	if (typeof(SIDEVIEW_JS) == 'undefined'){
		var SIDEVIEW_JS = true;
	
	function insertHead(name, text, evt){
		var idx = this.heads.length;
		var row = new SideViewRow(-idx, name, text, evt);
		this.heads[idx] = row;
		return row;
	}
	
	function insertTail(name, evt){
		var idx = this.tails.length;
		var row = new SideViewRow(idx, name, evt);
		this.tails[idx] = row;
		return row;
	}
	
	function SideViewRow(idx, name, onclickEvent){
		this.idx = idx;
		this.name = name;
		this.onclickEvent = onclickEvent;
		this.renderRow = renderRow;
		
		this.isVisible = true;
		this.isDim = false;
	}

	function SideRollOver(obj, color) {
		if(!obj) return false;
		obj.style.backgroundColor = color;
	}

	function renderRow(){
		if (!this.isVisible)
			return "";
		
		var str = "<tr style='padding-left:5px; padding-right:5px' height='20'><td id='sideViewRow_"+this.name+"' onMouseOver=\"SideRollOver(this, '#F0F0F0');\" onMouseOut=\"SideRollOver(this, '');\"><span id='sideview'>"+this.onclickEvent+"</span></td></tr>";
		return str;
	}

	function showSideView(curObj, nameclick, userid, username, email, homepage, boardseq){
		
		var isMenuExec = false;

		if (nameclick != "3"){
			switch (nameclick){
				case "0" :
					if (SET_USER_SESSION_ID != "" && userid != "guest"){
						isMenuExec = true;
					}
					break;
				case "1" :
					isMenuExec = true;
					break;
				case "2" :
					if (email!= "False"){
						isMenuExec = true;
					}
					break;
			}

			if (isMenuExec == true){
				var sideView = new SideView('nameContextMenu', curObj, nameclick, userid, username, email, homepage, boardseq);
				sideView.showLayer();
			}
		}
	}

	function SideView(targetObj, curObj, nameclick, userid, username, email, homepage, boardseq){

		this.targetObj = targetObj;
		this.curObj = curObj;
		this.showLayer = showLayer;
		this.makeNameContextMenus = makeNameContextMenus;
		this.heads = new Array();
		this.insertHead = insertHead;
		this.tails = new Array();
		this.insertTail = insertTail;
		this.getRow = getRow;
		this.hideRow = hideRow;
		this.dimRow = dimRow;

		switch (nameclick){
			case "0" :
				this.insertTail("member", "<img src=\"Library/LayerIcon/icon_member.gif\" border=\"0\" align=\"absmiddle\">&nbsp;<a href=\"javascript:;\" onClick=\"openWindows('MyMenu.asp?Action=info&strUserID=" + userid + "','MyMenu','800','630','0');\" class=\"link_default\">회원정보 보기</a>");
				this.insertTail("email", "<img src=\"Library/LayerIcon/icon_email.gif\" border=\"0\" align=\"absmiddle\">&nbsp;<a href=\"javascript:;\" onClick=\"openWindows('MyMenu.asp?Action=email&strUserID=" + userid + "','MyMenu','800','630','0');\" class=\"link_default\">메일 보내기</a>");
				if (SET_USE_MEMO == "True")
					this.insertTail("memo", "<img src=\"Library/LayerIcon/icon_memo.gif\" border=\"0\" align=\"absmiddle\">&nbsp;<a href=\"javascript:;\" onClick=\"openWindows('MyMenu.asp?Action=memo&strUserID=" + userid + "','MyMenu','800','630','0');\" class=\"link_default\">쪽지 보내기</a>");
				this.insertTail("namesearch", "<img src=\"Library/LayerIcon/icon_board.gif\" border=\"0\" align=\"absmiddle\">&nbsp;<a href=\"javascript:;\" onClick=\"openWindows('MyMenu.asp?Action=BoardList&strUserID=" + userid + "','MyMenu','800','630','0');\" class=\"link_default\">등록 게시글</a>");
				this.insertTail("idsearch", "<img src=\"Library/LayerIcon/icon_comment.gif\" border=\"0\" align=\"absmiddle\">&nbsp;<a href=\"javascript:;\" onClick=\"openWindows('MyMenu.asp?Action=CmtList&strUserID=" + userid + "','MyMenu','800','630','0');\" class=\"link_default\">등록 코멘트</a>");
				this.insertTail("friend", "<img src=\"Library/LayerIcon/icon_friend.gif\" border=\"0\" align=\"absmiddle\">&nbsp;<a href=\"javascript:;\" onClick=\"OnFriendAdd('" + userid + "');return false;\" class=\"link_default\">친구 등록하기</a>");
				if (homepage !="")
					this.insertTail("homepage", "<img src=\"Library/LayerIcon/icon_homepage.gif\" border=\"0\" align=\"absmiddle\">&nbsp;<a href=" + homepage + " target=\"blank\" class=\"link_default\">홈페이지</a>");
				break;
			case "1" :
				this.insertTail("namesearch", "<img src=\"Library/LayerIcon/icon_board.gif\" border=\"0\" align=\"absmiddle\">&nbsp;<a href=\"mboard.asp?Action=list&strBoardID=" + SET_STRBOARD_ID + "&intPage=1&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=|s_name|||&strSearchWord=" + username + "\" class=\"link_default\">이름으로 검색</a>");
				if (userid != "guest")
					this.insertTail("idsearch", "<img src=\"Library/LayerIcon/icon_comment.gif\" border=\"0\" align=\"absmiddle\">&nbsp;<a href=\"mboard.asp?Action=list&strBoardID=" + SET_STRBOARD_ID + "&intPage=1&intCategory=" + SET_INTCATEGORY + "&strSearchCategory=s_id||||&strSearchWord=" + userid + "\" class=\"link_default\">아이디로 검색</a>");
				if (email !="False")
					this.insertTail("email", "<img src=\"Library/LayerIcon/icon_email.gif\" border=\"0\" align=\"absmiddle\">&nbsp;<a href=\"javascript:;\" OnClick=\"openWindows('Library/sendmail.asp?strLoginID=" + userid + "&strLoginName=" + username + "&intSeq=" + boardseq + "','sendMail','510','615','0');\" class=\"link_default\">메일 보내기</a>");
				if (homepage !="")
					this.insertTail("homepage", "<img src=\"Library/LayerIcon/icon_homepage.gif\" border=\"0\" align=\"absmiddle\">&nbsp;<a href=" + homepage + " target=\"blank\" class=\"link_default\">홈페이지</a>");
				break;
			case "2" :
				if (email !="False")
					this.insertTail("email", "<img src=\"Library/LayerIcon/icon_email.gif\" border=\"0\" align=\"absmiddle\">&nbsp;<a href=\"javascript:;\" OnClick=\"openWindows('Library/sendmail.asp?strLoginID=" + userid + "&strLoginName=" + username + "&intSeq=" + boardseq + "','sendMail','510','615','0');\" class=\"link_default\">메일 보내기</a>");
		}
	}

	function OnFriendAdd(userid){
		if (confirm("[" + userid + "] 님을 친구로 등록하시겠습니까?")){
			showModalDialog('Library/memberFriend.asp?strUserID=' + userid + '&Action=add', 'memberFriend', 'dialogWidth:300px; dialogHeight: 300px; resizable: no; help: no; status: no; scroll: no;');
		}
	}

	function showLayer(){
		clickAreaCheck = true;
		var oSideViewLayer = document.getElementById(this.targetObj);
		var oBody = document.body;
	
		if (oSideViewLayer == null) {
			oSideViewLayer = document.createElement("DIV");
			oSideViewLayer.id = this.targetObj;
			oSideViewLayer.style.position = 'absolute';
			oBody.appendChild(oSideViewLayer);
		}
		oSideViewLayer.innerHTML = this.makeNameContextMenus();
	
		if (getAbsoluteTop(this.curObj) + this.curObj.offsetHeight + oSideViewLayer.scrollHeight + 5 > oBody.scrollHeight)
			oSideViewLayer.style.top = getAbsoluteTop(this.curObj) - oSideViewLayer.scrollHeight;
		else
			oSideViewLayer.style.top = getAbsoluteTop(this.curObj) + this.curObj.offsetHeight;

		if (this.cafe_notice == false)
			oSideViewLayer.style.left = getAbsoluteLeft(this.curObj) - this.curObj.offsetWidth + 14;
		else
			oSideViewLayer.style.left = getAbsoluteLeft(this.curObj) - this.curObj.offsetWidth - 20;
		
		divDisplay(this.targetObj, 'block');
		
		selectBoxHidden(this.targetObj);
	}
	
	function getAbsoluteTop(oNode){
		var oCurrentNode=oNode;
		var iTop=0;
		while(oCurrentNode.tagName!="BODY") {
			iTop+=oCurrentNode.offsetTop - oCurrentNode.scrollTop;
			oCurrentNode=oCurrentNode.offsetParent;
		}
		return iTop;
	}
	
	function getAbsoluteLeft(oNode){
		var oCurrentNode=oNode;
		var iLeft=0;
		iLeft+=oCurrentNode.offsetWidth;
		while(oCurrentNode.tagName!="BODY") {
			iLeft+=oCurrentNode.offsetLeft;
			oCurrentNode=oCurrentNode.offsetParent;
		}
		return iLeft;
	}
	
	function makeNameContextMenus(){
		var str = "<table width='110' border='0' cellpadding='0' cellspacing='2' bgcolor='#D9D9D9'><tr><td bgcolor='#FFFFFF'>";
		str += "<table border='0' cellpadding='0' cellspacing='5' width='110' style='border:1px solid #CACACA;' bgcolor='#FFFFFF'><tr><td>";
		str += "<table border='0' cellpadding='0' cellspacing='0' width='110'>";
		var i=0;
		for (i=this.heads.length - 1; i >= 0; i--)
			str += this.heads[i].renderRow();
		
		var j=0;
		for (j=0; j < this.tails.length; j++)
			str += this.tails[j].renderRow();

		str += "</table>";
		str += "</td></tr></table>";
		str += "</td></tr></table>";
		return str;
	}
	
	function getRow(name){
		var i = 0;
		var row = null;
		for (i=0; i<this.heads.length; ++i){
			row = this.heads[i];
			if (row.name == name) return row;
		}
		
		for (i=0; i<this.tails.length; ++i){
			row = this.tails[i];
			if (row.name == name) return row;
		}
		return row;
	}
	
	function hideRow(name){
		var row = this.getRow(name);
		if (row != null)
			row.isVisible = false;
	}
	
	function dimRow(name){
	    var row = this.getRow(name);
	    if (row != null)
	        row.isDim = true;
	}
	
	function selectBoxHidden(layer_id){
		var ly = document.getElementById(layer_id);
		
		var ly_left   = ly.offsetLeft;
		var ly_top    = ly.offsetTop;
		var ly_right  = ly.offsetLeft + ly.offsetWidth;
		var ly_bottom = ly.offsetTop + ly.offsetHeight;
		
		var el;
		
		for (i=0; i<document.forms.length; i++) {
			for (k=0; k<document.forms[i].length; k++) {
				el = document.forms[i].elements[k];
				if (el.type == "select-one"){
	
					var el_left = el_top = 0;
					var obj = el;
					if (obj.offsetParent) {
						while (obj.offsetParent) {
							el_left += obj.offsetLeft;
							el_top  += obj.offsetTop;
							obj = obj.offsetParent;
						}
					}
					el_left   += el.clientLeft;
					el_top    += el.clientTop;
					el_right  = el_left + el.clientWidth;
					el_bottom = el_top + el.clientHeight;
					
					if ((el_left >= ly_left && el_top >= ly_top && el_left <= ly_right && el_top <= ly_bottom) ||
						(el_right >= ly_left && el_right <= ly_right && el_top >= ly_top && el_top <= ly_bottom) ||
						(el_left >= ly_left && el_bottom >= ly_top && el_right <= ly_right && el_bottom <= ly_bottom) ||
						(el_left >= ly_left && el_left <= ly_right && el_bottom >= ly_top && el_bottom <= ly_bottom) )
						el.style.visibility = 'hidden';
	
				}
			}
		}
	}
	
	function selectBoxVisible(){
		for (i=0; i<document.forms.length; i++){
			for (k=0; k<document.forms[i].length; k++){
				el = document.forms[i].elements[k];
				if (el.type == "select-one" && el.style.visibility == 'hidden')
				el.style.visibility = 'visible';
			}
		}
	}
	
	
	function getAbsoluteTop(oNode){
		var oCurrentNode=oNode;
		var iTop=0;
		while(oCurrentNode.tagName!="BODY") {
			iTop+=oCurrentNode.offsetTop - oCurrentNode.scrollTop;
			oCurrentNode=oCurrentNode.offsetParent;
		}
		return iTop;
	}
	
	
	function getAbsoluteLeft(oNode){
		var oCurrentNode=oNode;
		var iLeft=0;
		iLeft+=oCurrentNode.offsetWidth;
		while(oCurrentNode.tagName!="BODY") {
			iLeft+=oCurrentNode.offsetLeft;
			oCurrentNode=oCurrentNode.offsetParent;
		}
		return iLeft;
	}
	
	function divDisplay(id, act){
		selectBoxVisible();
		
		document.getElementById(id).style.display = act;
	}
	
	function hideSideView(){
		if (document.getElementById("nameContextMenu"))
			divDisplay ("nameContextMenu", 'none');
	}
	
		var clickAreaCheck = false;
	    document.onclick = function(){
			if (!clickAreaCheck)
				hideSideView();
			else
				clickAreaCheck = false;
		}
	}