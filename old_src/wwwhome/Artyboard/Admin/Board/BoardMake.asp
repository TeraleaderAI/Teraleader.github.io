<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 5
	intLeftMenu  = 1
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM bitOneMake
	bitOneMake = REQUEST.FORM("bitOneMake")
	IF bitOneMake = "" THEN bitOneMake = "1"
%>
<table width="750" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="BoardMake_ok.asp" onSubmit="return OnSubmitAction();">
<input type="hidden" name="bitBoardIdCheck" value="0" />
<input type="hidden" name="strSkinGroup">
<input type="hidden" name="strSkin">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="35"><img src="../images/main_title19.gif" width="125" height="19"></td>
          <td align="right">관리자 홈 &gt; 게시판관리 &gt; <b>신규 게시판 생성</b></td>
        </tr>
      </table>                </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>게시판 기본정보</strong></span></td>
  </tr>
	<tr>
		<td height="3" bgcolor="#CCCCCC"></td>
	</tr>
  <tr>
    <td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="table_Left1">게시판 생성구분</td>
					<td class="table_Right1">
          <input type="radio" name="bitOneMake" id="bitOneMake1" value="1" class="no_Line"<% IF bitOneMake = "1" THEN %> checked<% END IF %> onClick="OnMakeType();"><LABEL FOR="bitOneMake1" style="cursor:hand">단일생성</LABEL>
					<input type="radio" name="bitOneMake" id="bitOneMake2" value="0" class="no_Line"<% IF bitOneMake = "0" THEN %> checked<% END IF %> onClick="OnMakeType();"><LABEL FOR="bitOneMake2" style="cursor:hand">다중생성</LABEL></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
<% IF bitOneMake = "1" THEN %>
				<tr>
					<td class="table_Left1">게시판 아이디</td>
					<td class="table_Right1"><input name="strBoardID" type="text" id="strBoardID" onblur="onlyBoardID(this);document.all['bitBoardIdCheck'].value='0';" size="20" maxlength="20">
					&nbsp;<a href="javascript:;" onclick="OnBoardIDCheck('1');return false;"><img src="../images/btn_idcheck_w.gif" width="105" height="19" border="0" align="absmiddle"></a>&nbsp;<font color="#FD8402">알파벳, 숫자, _만 사용할 수 있습니다.</font></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">게시판 이름</td>
					<td class="table_Right1"><input name="strName" type="text" id="strName" style="width:98%" maxlength="128"></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
<% ELSE %>
				<tr>
					<td class="table_Left1">게시판 정보</td>
					<td class="table_Right1">
						<table width="100%" id="table" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td width="15" nowrap><%=I + 1%></td>
								<td width="100%">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
											<td width="90" align="right" style="padding-right:10;">게시판 아이디 : </td>
                      <td>
                      <input name="strBoardID" type="text" id="strBoardID" size="20" maxlength="20" onblur="onlyBoardID(this);document.all['bitBoardIdCheck'].value='0';">
                      <a href="javascript:add()"><img src="../images/btn_text_plus.gif" width="70" height="19" border="0" align=absmiddle></a>
											<a href="javascript:;" onclick="OnBoardIDCheck('2');return false;"><img src="../images/btn_idcheck_all_w.gif" width="169" height="19" border="0" align="absmiddle"></a>
                      </td>
                    </tr>
                    <tr>
											<td width="90" align="right" style="padding-right:10;">게시판 이름 : </td>
                      <td><input type="text" name="strName" style="width:98%" value=""></td>
                    </tr>
                  </table>
                </td>
							</tr>
						</table>
          </td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
<% END IF %>
				<tr>
					<td class="table_Left1">게시판 스킨</td>
					<td class="table_Right1" style="padding-top:10px;"><iframe name="BoardSkin" src="BoardSkin.asp?strSkinGroup=Board" frameborder="0" width="100%" height="140"></iframe></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">게시판 환경설정 복사</td>
					<td class="table_Right1">
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] ")
	RESPONSE.WRITE "<select name=strCopyBoardID id=strCopyBoardID>" & vbcrlf
	RESPONSE.WRITE "<option value=''>게시판을 선택하세요.</option>" & vbcrlf
	WHILE NOT(RS.EOF)
	RESPONSE.WRITE "<option value='" & RS("strBoardID") & "'>" & RS("strBoardID") & " [" & RS("strName") & "]</option>" & vbcrlf
	RS.MOVENEXT
	WEND
	RESPONSE.WRITE "</select>" & vbcrlf
%>
					<input name="bitBoardCopy" type="checkbox" id="bitBoardCopy" value="1" class="no_Line"><font color="#FD8402"><LABEL FOR="bitBoardCopy" style="cursor:hand">선택된 게시판의 환경설정을 복제합니다.</LABEL></font></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">게시판 설명</td>
					<td class="table_Right1"><input name="strMemo" type="text" id="strMemo" style="width:98%" maxlength="128"></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">게시판 타이틀</td>
					<td class="table_Right1">
						<table width="100%"  border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><textarea name="strTitle" rows="8" id="strTitle" style="width:98%"><%=strTitle%></textarea></td>
								<td width="15" valign="top">
									<table width="100%"  border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="18"><a href="javascript:;" onClick="resize_textarea('strTitle', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
										</tr>
										<tr>
											<td height="18"><a href="javascript:;" onClick="reset_textarea('strTitle', 8);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
										</tr>

										<tr>
											<td height="18"><a href="javascript:;" onClick="resize_textarea('strTitle', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
			</table>
		</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
	<tr>
		<td align="right" style="padding-right:20;"><input type="image" name="imageField" src="../images/btn_board_make_m.gif" class="no_Line"></td>
	</tr>
	<tr>
		<td style="padding:10 10 10 10">
			<fieldset CLASS="infobox">
			<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
			<table width="100%"  border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td>
					<LI>게시판의 아이디는 영문 및 숫자와 _(언더바) 만 사용하실 수 있습니다.</LI>
					<LI>스킨은 등록된 스킨만 사용이 가능하며, Skin/Board/스킨구분/ 폴더에 스킨을 다운받아 넣으시면 사용이 가능합니다.</LI>
					<LI>게시판 환경설정 복사 항목에서 이미 생성된 게시판을 선택해서 해당 게시판의 환경설정을 동일하게 설정하실 수 있습니다.</LI>
					</td>
				</tr>
			</table>
			</fieldset>
		</td>
	</tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
	</form>
</table>
<script language="javascript">

	var SET_boardMakeCount = 0;

	function OnSubmitAction(){

		var isCheck = "";

		if (document.all['bitOneMake'][0].checked == true){
			isCheck = "1";
		}else{
			if (SET_boardMakeCount == 0){
				isCheck = "1";
			}else{
				isCheck = "0";
			}
		}

		if (isCheck == "1"){

			str = document.all['strBoardID'];
			if (str.value.length < 3){alert("게시판 아이디를 3자리 이상 입력해 주시기 바랍니다.");str.focus();return false;}
	
			if (document.all['bitBoardIdCheck'].value == "0"){
				alert("게시판 아이디 중복체크를 실행해 주시기 바랍니다.");
				return false;
			}
	
			str = document.all['strName'];
			if (str.value == ""){alert("게시판 이름을 입력해 주시기 바랍니다.");str.focus();return false;}

		}else{

			for (var i = 0; i <= SET_boardMakeCount; i++){
				if (document.all['strBoardID'][i].value.length < 3){alert("게시판 아이디를 3자리 이상 입력해 주시기 바랍니다.");document.all['strBoardID'][i].focus();return false;}
				if (document.all['strName'][i].value.length < 3){alert("게시판 이름을 입력해 주시기 바랍니다.");document.all['strName'][i].focus();return false;}
			}

			for (var i = 0; i <= SET_boardMakeCount; i++){
				for (var j = 0; j <= SET_boardMakeCount; j++){
					if (i!=j){
						if (document.all['strBoardID'][i].value == document.all['strBoardID'][j].value){
							alert("중복된 게시판 아이디 입니다.");document.all['strBoardID'][j].focus();return false;
						}
					}
				}
			}

			if (document.all['bitBoardIdCheck'].value == "0"){
				alert("게시판 아이디 중복체크를 실행해 주시기 바랍니다.");
				return false;
			}

		}

		document.all['strSkinGroup'].value = parent.BoardSkin.document.all['strSkinGroupSet'].value;
		document.all['strSkin'].value = parent.BoardSkin.document.all['strSkinSet'].value;
	}

	function OnBoardIDCheck(){

		var isCheck = "";

		if (document.all['bitOneMake'][0].checked == true){
			isCheck = "1";
		}else{
			if (SET_boardMakeCount == 0){
				isCheck = "1";
			}else{
				isCheck = "0";
			}
		}

		if (isCheck == "1"){
			str = document.all['strBoardID'];
			if (str.value.length < 4){alert("게시판 아이디를 3자리 이상 입력해 주시기 바랍니다.");str.focus();return false;}
	
			var arr = showModalDialog('BoardIDCheck.asp?Action=1&strBoardID=' + str.value, 'BoardIDCheck', 'dialogWidth:300px; dialogHeight: 300px; resizable: no; help: no; status: no; scroll: no;');
			document.all['bitBoardIdCheck'].value = arr;
	
			if (arr == "1"){
				document.theForm.strName.focus();
			}else{
				document.theForm.strBoardID.focus();
			}
		}else{

			for (var i = 0; i <= SET_boardMakeCount; i++){
				if (document.all['strBoardID'][i].value.length < 3){alert("게시판 아이디를 3자리 이상 입력해 주시기 바랍니다.");document.all['strBoardID'][i].focus();return false;}
				if (document.all['strName'][i].value.length < 3){alert("게시판 이름을 입력해 주시기 바랍니다.");document.all['strName'][i].focus();return false;}
			}

			var tmpBoardID = "";

			for (var i = 0; i <= SET_boardMakeCount; i++){
				if (tmpBoardID!= ""){
					tmpBoardID = tmpBoardID + ",";
				}
				tmpBoardID = tmpBoardID + document.all['strBoardID'][i].value;
				for (var j = 0; j <= SET_boardMakeCount; j++){
					if (i!=j){
						if (document.all['strBoardID'][i].value == document.all['strBoardID'][j].value){
							alert("중복된 게시판 아이디 입니다.");document.all['strBoardID'][j].focus();return false;
						}
					}
				}
			}

			var arr = showModalDialog('BoardIDCheck.asp?Action=2&strBoardID=' + tmpBoardID, 'BoardIDCheck', 'dialogWidth:300px; dialogHeight: 300px; resizable: no; help: no; status: no; scroll: no;');
			document.all['bitBoardIdCheck'].value = arr;
	
		}

	}

	function OnMakeType(){
		document.theForm.action = "BoardMake.asp";
		document.theForm.submit();
	}

function add(){
	var table = document.getElementById('table');

	SET_boardMakeCount = SET_boardMakeCount + 1;
	date	= new Date();
	oTr		= table.insertRow( table.rows.length );
	oTr.id	= date.getTime();
	oTr.insertCell(0);
	oTd		= oTr.insertCell(1);

	tmpHTML = "<table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td width='90' align='right' style='padding-right:10;'>게시판 아이디 : </td><td><input name='strBoardID' type='text' id='strBoardID' size='20' maxlength='20' onblur=onlyBoardID(this);document.all['bitBoardIdCheck'].value='0';> <a href='javascript:del(" + oTr.id + ")'><img src='../images/btn_text_minus.gif' width='70' height='19' border='0' align=absmiddle></a></td></tr><tr><td width='90' align='right' style='padding-right:10;'>게시판 이름 : </td><td><input type='text' name='strName' style='width:98%' value=''></td></tr></table>"

	oTd.innerHTML = tmpHTML;
	oTd = oTr.insertCell(2);
	oTd.id = "prvImg" + oTr.id;
	calcul();
}

function calcul(){
	var table = document.getElementById('table');
	for (i=0;i<table.rows.length;i++){
		table.rows[i].cells[0].innerHTML = i+1;
	}
}

function del(index){
	SET_boardMakeCount = SET_boardMakeCount - 1;
	var table = document.getElementById('table');
    for (i=0;i<table.rows.length;i++) if (index==table.rows[i].id) table.deleteRow(i);
	calcul();
}

</script>
<!-- #include file = "Foot.asp" -->