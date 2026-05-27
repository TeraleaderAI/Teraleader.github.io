<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Group/MailingGroupList.asp"
%>
<!-- #include file = "../head.asp" -->
<%
	DIM Action
	Action = UCASE(REQUEST.QueryString("Action"))
	IF Action = "" THEN Action = "ADD"

	DIM strCode, strName, strGroupMemo

	SELECT CASE Action
	CASE "ADD"
		SET RS = DBCON.EXECUTE("SELECT TOP 1 [strCode] FROM [MPLUS_MEMBER_MAILING_GROUP] ORDER BY [strCode] DESC ")
		IF RS.EOF THEN
			strCode = "M001"
		ELSE
			strCode = INT(RIGHT(RS("strCode"), 3)) + 1
			FOR I = LEN(strCode) TO 2
				strCode = "0" & strCode
			NEXT
			strCode = "M" & strCode
		END IF
	CASE "EDIT"
		strCode = REQUEST.QueryString("strCode")
		SET RS = DBCON.EXECUTE("SELECT [strCode], [strName], [strMemo] FROM [MPLUS_MEMBER_MAILING_GROUP] WHERE [strCode] = '" & strCode & "' ")
		strName    = RS("strName")
		strMemo    = RS("strMemo")
	END SELECT
%>
<table width="520"  border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="MailingGroup_ok.asp?Action=<%=Action%>" onSubmit="return OnSubmitAction();">
<input type="hidden" name="strCode" value="<%=strCode%>">
	<tr>
		<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong><% IF Action = "ADD" THEN %>신규 그룹등록<% ELSE %>그룹 정보수정<% END IF %></strong></span></td>
	</tr>
	<tr>
		<td height="3" bgcolor="#CCCCCC"></td>
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
					<td class="table_Right1"><input name="strName" type="text" id="strName" value="<%=strName%>" size="32" maxlength="32">					</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">그룹 설명</td>
					<td class="table_Right1"><input name="strMemo" type="text" id="strMemo" value="<%=strMemo%>" maxlength="128" style="width:98%">					</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="40" align="right" style="padding-right:30;"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
	</tr>
	</form>
</table>
<script language="javascript">
	function OnSubmitAction(){
		str = document.all['strName'];
		if (str.value == ""){alert("그룹명을 입력해 주시기 바랍니다.");str.focus();return false;}
	}
</script>
<!-- #include file = "../foot.asp" -->