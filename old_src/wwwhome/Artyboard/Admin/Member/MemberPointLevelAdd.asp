<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Member/MemberPointLevel.asp"
%>
<!-- #include file = "../head.asp" -->
<%
	DIM Action, intSeq
	Action = UCASE(REQUEST.QueryString("Action"))
	intSeq = REQUEST.QueryString("intSeq")

	IF Action = "" THEN Action = "ADD"

	DIM strGroupCodeForm, intStartPoint, intEndPoint, strGroupCode

	strGroupCodeForm = "<select name=""strGroupCode"" id=""strGroupCode"">" & vbcrlf

	SELECT CASE Action
	CASE "ADD"

		SET RS =DBCON.EXECUTE("SELECT [strGroupCode], [strGroupName] FROM [MPLUS_GROUP] WHERE [strGroupCode] != 'G000' AND [strGroupCode] NOT IN (SELECT [strGroupCode] FROM [MPLUS_MEMBER_POINT_LEVEL]) ")

		IF RS.EOF THEN
			RESPONSE.WRITE ExecJavaAlertLayer("더이상 등록할 그룹이 없습니다.\n그룹을 먼저 생성하시기 바랍니다.", "MemberPointLevel.asp")
			RESPONSE.End()
		ELSE
			WHILE NOT(RS.EOF)
				strGroupCodeForm = strGroupCodeForm & "<option value='" & RS("strGroupCode") & "'>" & RS("strGroupName") & "</option>" & vbcrlf
			RS.MOVENEXT
			WEND
		END IF

		SET RS = DBCON.EXECUTE("SELECT TOP 1 [intEndPoint] FROM [MPLUS_MEMBER_POINT_LEVEL] ORDER BY [intEndPoint] DESC ")

		IF RS.EOF THEN intStartPoint = 1 ELSE intStartPoint = RS("intEndPoint") + 1

	CASE "EDIT"

		SET RS = DBCON.EXECUTE("SELECT [strGroupCode], [intStartPoint], [intEndPoint] FROM [MPLUS_MEMBER_POINT_LEVEL] WHERE [intSeq] = '" & intSeq & "' ")

		strGroupCode  = RS("strGroupCode")
		intStartPoint = RS("intStartPoint")
		intEndPoint   = RS("intEndPoint")

		SET RS =DBCON.EXECUTE("SELECT [strGroupCode], [strGroupName] FROM [MPLUS_GROUP] WHERE [strGroupCode] != 'G000' AND [strGroupCode] NOT IN (SELECT [strGroupCode] FROM [MPLUS_MEMBER_POINT_LEVEL] WHERE [strGroupCode] != '" & strGroupCode & "') ")

		WHILE NOT(RS.EOF)
			strGroupCodeForm = strGroupCodeForm & "<option value='" & RS("strGroupCode") & "'"
			IF strGroupCode = RS("strGroupCOde") THEN strGroupCodeForm = strGroupCodeForm & " SELECTED"
			strGroupCodeForm = strGroupCodeForm & ">" & RS("strGroupName") & "</option>" & vbcrlf
		RS.MOVENEXT
		WEND

	END SELECT

	strGroupCodeForm = strGroupCodeForm & "</select>" & vbcrlf
%>
<table width="520"  border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="MemberPointLevel_ok.asp?Action=<%=Action%>&intSeq=<%=intSeq%>" onSubmit="return OnSubmitAction();">
	<tr>
		<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong><% IF Action = "ADD" THEN %>신규 등급 포인트 등록<% ELSE %>등급 포인트 정보수정<% END IF %></strong></span></td>
	</tr>
	<tr>
		<td height="3" bgcolor="#CCCCCC"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="33" class="table_Left1">그룹선택</td>
					<td class="table_Right1"><%=strGroupCodeForm%></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">시작 포인트</td>
					<td class="table_Right1"><input name="intStartPoint" type="text" id="intStartPoint" value="<%=intStartPoint%>" size="10" maxlength="10" onBlur="onlyInt(this, 1);">&nbsp;Points
					</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">마침 포인트</td>
					<td class="table_Right1"><input name="intEndPoint" type="text" id="intEndPoint" value="<%=intEndPoint%>" size="10" maxlength="10" onBlur="onlyInt(this, 1);">&nbsp;Points
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

		str = document.all['intStartPoint'];
		if (str.value == ""){alert("시작 포인트를 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['intEndPoint'];
		if (str.value == ""){alert("마침 포인트를 입력해 주시기 바랍니다.");str.focus();return false;}

		if (eval(document.all['intStartPoint'].value) > eval(document.all['intEndPoint'].value)){
			alert("마침 포인트가 시작 포인트 보다 작습니다.");str.focus();return false;
		}

	}
</script>
<!-- #include file = "../foot.asp" -->