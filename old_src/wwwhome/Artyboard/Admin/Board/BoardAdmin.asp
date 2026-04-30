<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu  = 2
	isAdminPopup = True
%>
<!-- #include file = "../Head.asp" -->
<style type="text/css">
	body {margin : 0 0 0 0}
</style>
<%
	DIM strBoardID
	strBoardID = REQUEST.QueryString("strBoardID")
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '" & strBoardID & "' ")
	DIM strAdmin, I
	strAdmin = RS("strAdmin")
%>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="BoardAdmin_ok.asp?strBoardID=<%=strBoardID%>">
<input type="hidden" name="Action">
	<tr>
		<td width="110" height="26">등록된 관리자 </td>
	  <td height="26"><select name="strAdminList" id="strAdminList" style="width:180">
<%
	IF strAdmin <> "" AND ISNULL(strAdmin) = False THEN
		strAdmin = SPLIT(strAdmin, "|")
		FOR I = 0 TO UBOUND(strAdmin)
			IF strAdmin(I) <> "" THEN RESPONSE.WRITE "<option value=" & strAdmin(I) & ">" & strAdmin(I) & "</option>" & vbcrlf
		NEXT
	ELSE
		RESPONSE.WRITE "<option>등록된 관리자가 없습니다.</option>" & vbcrlf
	END IF
%>
		</select>&nbsp;<a href="javascript:;" onClick="OnAdminRemove();return false;"><img src="../images/btn_select_delete_w.gif" width="68" height="19" border="0" align="absmiddle"></a></td>
	</tr>
	<tr>
		<td height="26">관리자 아이디 입력</td>
	  <td height="26"><input name="strAdminInput" type="text" id="strMemberList" style="width:180;">&nbsp;<a href="javascript:popupLayer('../Member/MemberSearchList.asp?sType=B',810,650);" target="_parent"><img src="../images/btn_member_search_w.gif" width="68" height="19" border="0" align="absmiddle"></a> <a href="javascript:;" onClick="OnAdminAdd();return false;"><img src="../images/btn_member_id_add_w.gif" width="110" height="19" border="0" align="absmiddle"></a></td>
	</tr>
</form>
</table>
<script language="javascript">
	function OnAdminRemove(){
		if (document.all['strAdminList'].value == ""){
			alert("삭제할 관리자가 없습니다.");return false;
		}

		if(confirm("[" + document.all['strAdminList'].value + "] 를 관리자 아이디에서 삭제합니까?")){
			document.all['Action'].value = "remove";
			document.theForm.submit();
		}
	}

	function OnAdminAdd(){
		str = document.all['strAdminInput'];
		if (str.value == ""){alert("추가할 회원 아이디를 입력해 주시기 바랍니다.");str.focus();return false;}
		document.all['Action'].value = "add";
		document.theForm.submit();
	}

	function OnAdminSearch(){
		openWindows('../Member/MemberSearch.asp?openerForm=strAdminInput&strSearchID=' + document.all['strAdminInput'].value,'MemberSearch','536','500','3');
	}
</script>
<!-- #include file = "../Foot.asp" -->