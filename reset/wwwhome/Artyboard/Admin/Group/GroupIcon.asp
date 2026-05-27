<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Group/GroupList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM strFileList
	strFIleList = SPLIT(GetFileList(rootPath & "Pds\Member\GroupIcon\", "file"), "|")
%>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<form name="theForm" method="post" enctype="multipart/form-data">
	<tr>
		<td height="44" background="../images/pop_title_bg.gif"><img src="../images/pop_title_group_icon.gif" width="155" height="44"></td>
	</tr>
	<tr>
		<td height="8"></td>
	</tr>
	<tr>
		<td align="center" valign="top">
<%
	RESPONSE.WRITE "			<table width='400'  border='0' cellspacing='0' cellpadding='0'>" & vbcrlf
	
	DIM iCount
	iCount = 0

	FOR I = 0 TO UBOUND(strFIleList) - 1

		iCount = iCount + 1
		IF iCount = 1 THEN RESPONSE.WRITE "				<tr align='center'>" & vbcrlf

		IF checkImageFile(rootPath & "Pds\Member\GroupIcon\" & strFIleList(I)) = True THEN
			RESPONSE.WRITE "					<td width='76'><input type='checkbox' name='strFileName' value='" & strFileList(I) & "' class='no_Line'>&nbsp;<img src='../../Pds/Member/GroupIcon/" & strFIleList(I) & "' OnClick=""OnSelect('" & strFileList(I) & "');return false;"" style=""cursor:hand;""></td>" & vbcrlf
		END IF
	
		IF iCount = 6 THEN
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
	<tr>
		<td height="20">
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center"><input name="uploadFile" type="file" class="input" id="strFileName" size="26">					  &nbsp;&nbsp; <a href="javascript:;" onClick="OnSubmitAction();return false;"><img src="../images/btn_add_new_s.gif" width="59" height="16" border="0" align="absmiddle"></a>&nbsp;<a href="javascript:;" onClick="OnFileRemove();return false;"><img src="../images/btn_select_delete_s.gif" width="58" height="16" border="0" align="absmiddle"></a></td>
					</tr>
			</table>
		</td>
	</tr>
</form>
</table>
<script language="javascript">
	function OnSubmitAction(){
		str = document.all['uploadFile'];
		if (str.value == ""){alert("파일을 선택해 주시기 바랍니다.");str.focus();return false;}

		if (confirm("마크이미지 파일은 가로 16px, 세로 16px 이하로 등록하시기 바랍니다.\n\n이미지 파일을 등록하시겠습니까?")){
			document.theForm.action = "GroupIcon_ok.asp?Action=add";
			document.theForm.submit();
		}
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
			if (confirm("선택된 아이콘을 삭제하시겠습니까?")){
				document.theForm.action = "GroupIcon_ok.asp?Action=remove";
				document.theForm.submit();
			}
			return false;
		}
	}

	function OnSelect(str){
		parent.document.all['setIcon'].src = "../../Pds/Member/GroupIcon/" + str;
		parent.document.all['strAvata'].value = str;
		parent.closeLayer();
	}
</script>
<!-- #include file = "../Foot.asp" -->