<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 1
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM strFileList, strFolder, strSetIcon
	strFolder   = REQUEST.QueryString("strFolder")
	strSetIcon  = REQUEST.QueryString("strSetIcon")
	strFIleList = GetFileList(rootPath & "Pds\Board\Icon\" & strFolder & "\", "file")
	strFIleList = SPLIT(strFIleList, "|")
%>
<table width="400" height="100%" border='0' cellpadding=0 cellspacing=0 bordercolorlight='#cccccc' bordercolordark='#FFFFFF'>
<form name="theForm" method="post" enctype="multipart/form-data">
	<tr>
		<td height="44" background="../images/pop_title_bg.gif"><img src="../images/pop_title_board_icon.gif" width="155" height="44"></td>
	</tr>
  <tr>
    <td align="center" valign="top">
<%
	RESPONSE.WRITE "			<table width='380'  border='0' cellspacing='0' cellpadding='0'>" & vbcrlf
	
	DIM iCount
	iCount = 0

	FOR I = 0 TO UBOUND(strFIleList) - 1

		iCount = iCount + 1
		IF iCount = 1 THEN RESPONSE.WRITE "				<tr align='center'>" & vbcrlf

		IF checkImageFile(rootPath & "Pds\Board\Icon\" & strFolder & "\" & strFIleList(I)) = True THEN
			RESPONSE.WRITE "					<td width=""20%"" height=""26"" align=""left""><input type=""checkbox"" name=""strFileName"" value=""" & strFileList(I) & """ class=""no_Line"">&nbsp;<img src=""../../Pds/Board/Icon/" & strFolder & "/" & strFIleList(I) & """ OnClick=""OnSelect('" & strFileList(I) & "');"" style=""cursor:hand;"" align=""absmiddle""></td>" & vbcrlf
		END IF
	
		IF iCount = 5 THEN
			RESPONSE.WRITE "					</tr>" & vbcrlf
			iCount = 0
		END IF

	NEXT

	IF iCount <> 0 THEN
		FOR I = iCount TO 4
			RESPONSE.WRITE "					<td width='76'></td>" & vbcrlf
		NEXT
		RESPONSE.WRITE "					</tr>" & vbcrlf
	END IF

	RESPONSE.WRITE "			</table>" & vbcrlf
%>
		</td>
  </tr>
<% IF SESSION("strAdmin") = "2" THEN %>
  <tr>
    <td height="20" align="center"><input name="uploadFile" type="file" class="input" id="strFileName" size="26">&nbsp;<a href="javascript:;" onClick="OnSubmitAction();return false;"><img src="../images/btn_add_new_s.gif" width="59" height="16" border="0" align="absmiddle"></a>&nbsp;<a href="javascript:;" onClick="OnFileRemove();return false;"><img src="../images/btn_select_delete_s.gif" width="58" height="16" border="0" align="absmiddle"></a></td>
  </tr>
<% END IF %>
</form>
</table>
<script language="javascript">
	SET_FOLDER_TYPE = "<%=strFolder%>";
	SET_ICON_TYPE   = "<%=strSetIcon%>";

	function OnSubmitAction(){
		str = document.all['uploadFile'];
		if (str.value == ""){alert("파일을 선택해 주시기 바랍니다.");str.focus();return false;}

		document.theForm.action = "BoardListIcon_ok.asp?Action=add" + "&strFolder=" + SET_FOLDER_TYPE + "&strSetIcon=" + SET_ICON_TYPE;
		document.theForm.submit();
	}

	function OnFileRemove(){

		var k = 0;
		for (var i=0; i<document.theForm.elements.length; i++) {
			if(document.theForm.elements[i].name == 'strFileName'){
				if (document.theForm.elements[i].checked == true){
					k++;
				}
			}
		}

		if (k == 0){
			alert("아이콘을 선택하지 않으셨습니다.");return false;
		}else{
			if (confirm("선택된 아이콘을 삭제하시겠습니까?\n\n아이콘을 삭제하기전에 게시판에 적용되었는지\n\n먼저 확인해 보시기 바랍니다.")){
				document.theForm.action = "BoardListIcon_ok.asp?Action=remove" + "&strFolder=" + SET_FOLDER_TYPE + "&strSetIcon=" + SET_ICON_TYPE;
				document.theForm.submit();
			}
			return false;
		}
	}

	function OnSelect(str){
		parent.document.all[SET_ICON_TYPE].value = str;
		parent.document.all[SET_ICON_TYPE + '1'].src = "../../Pds/Board/Icon/" + SET_FOLDER_TYPE + "/" + str;
		parent.closeLayer();
	}
</script>
<!-- #include file = "../Foot.asp" -->