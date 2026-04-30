<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Group/GroupBoardList.asp"
%>
<!-- #include file = "../head.asp" -->
<%
	DIM Action
	Action = UCASE(REQUEST.QueryString("Action"))
	IF Action = "" THEN Action = "ADD"

	DIM strGroupCode, strGroupName, strGroupMemo, strNotMsg, strMoveUrl

	SELECT CASE Action
	CASE "ADD"
		SET RS = DBCON.EXECUTE("SELECT TOP 1 [strGroupCode] FROM [MPLUS_BOARD_GROUP] ORDER BY [strGroupCode] DESC ")
		IF RS.EOF THEN
			strGroupCode = "B001"
		ELSE
			strGroupCode = INT(RIGHT(RS("strGroupCode"), 3)) + 1
			FOR I = LEN(strGroupCode) TO 2
				strGroupCode = "0" & strGroupCode
			NEXT
			strGroupCode = "B" & strGroupCode
		END IF
	CASE "EDIT"
		strGroupCode = REQUEST.QueryString("strGroupCode")
		SET RS = DBCON.EXECUTE("SELECT [strGroupCode], [strGroupName], [strGroupMemo], [strNotMsg], [strMoveUrl] FROM [MPLUS_BOARD_GROUP] WHERE [strGroupCode] = '" & strGroupCode & "' ")
		strGroupName    = RS("strGroupName")
		strGroupMemo    = RS("strGroupMemo")
		strNotMsg       = RS("strNotMsg")
		strMoveUrl      = RS("strMoveUrl")
	END SELECT
%>
<table width="520"  border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="GroupBoard_ok.asp?Action=<%=Action%>" onSubmit="return OnSubmitAction();">
<input type="hidden" name="strGroupCode" value="<%=strGroupCode%>">
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
					<td class="table_Right1"><B><%=strGroupCode%></B></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">그룹명</td>
					<td class="table_Right1"><input name="strGroupName" type="text" id="strGroupName" value="<%=strGroupName%>" size="32" maxlength="32">
					</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">그룹 설명</td>
					<td class="table_Right1"><input name="strGroupMemo" type="text" id="strGroupMemo" value="<%=strGroupMemo%>" maxlength="128" style="width:98%">
					</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">접근불가시 출력 메시지</td>
					<td class="table_Right1"><input name="strNotMsg" type="text" id="strNotMsg" value="<%=strNotMsg%>" maxlength="128" style="width:98%"></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">접근불가시 이동 URL</td>
					<td class="table_Right1"><input name="strMoveUrl" type="text" id="strMoveUrl" value="<%=strMoveUrl%>" maxlength="128" style="width:98%"><br><font color="#FD8402">입력하지 않을 경우 이전화면으로 이동</font>
					</td>
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
		str = document.all['strGroupName'];
		if (str.value == ""){alert("그룹명을 입력해 주시기 바랍니다.");str.focus();return false;}
	}
</script>
<!-- #include file = "../foot.asp" -->