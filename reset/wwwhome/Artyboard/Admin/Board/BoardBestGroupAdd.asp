<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardBestList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM Action
	Action = REQUEST.QueryString("Action")
	IF Action = "" THEN Action = "ADD"

	DIM intNum, strCode, strName, strMemo
	intNum = REQUEST.QueryString("intNum")

	SELECT CASE UCASE(Action)
	CASE "ADD"
		strCode = "신규등록"
	CASE "EDIT"
		SET RS = DBCON.EXECUTE("SELECT [strCode], [strName], [strMemo] FROM [MPLUS_BOARD_NOTICE] WHERE [intNum] = '" & intNum & "' ")
		strCode = RS("strCode")
		strName = RS("strName")
		strMemo = RS("strMemo")
	END SELECT
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<form name="theForm" method="post" action="BoardBestGroup_ok.asp?Action=<%=Action%>&intNum=<%=intNum%>" onSubmit="return OnSubmitAction();">
	<tr>
		<td height="44" background="../images/pop_title_bg.gif"><img src="../images/pop_title_board_group.gif" width="155" height="44"></td>
	</tr>
	<tr>
		<td height="8"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="33" class="table_Left1">그룹코드</td>
					<td class="table_Right1"><B><%=strCode%></B></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">그룹명</td>
					<td class="table_Right1"><input name="strName" type="text" id="strName" value="<%=strName%>" size="30" maxlength="32"></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">그룹 메모 </td>
					<td class="table_Right1"><input name="strMemo" type="text" id="strMemo" value="<%=strMemo%>" style="width:98%"></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="40" align="center"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
	</tr>
</form>
</table>
<script language="javascript">

	function OnSubmitAction(){
		str = document.all['strName'];
		if (str.value == ""){alert("그룹명을 입력해 주시기 바랍니다.");str.focus();return false;}
	}

</script>
<!-- #include file = "../Foot.asp" -->