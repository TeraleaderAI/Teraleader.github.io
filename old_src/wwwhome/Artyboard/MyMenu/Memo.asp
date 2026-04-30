<!-- #include file = "Head.asp" -->
<%
	IF CONF_bitUseMemo = False THEN
		RESPONSE.WRITE ExecJavaAlert("쪽지기능을 사용할 수 없습니다.", 1)
		RESPONSE.End()
	END IF

	IF CONF_bitMemoUse = True THEN
		IF SESSION("strAdmin") = "2" THEN
		ELSE
			IF INT(CONF_intMemoUseLevel) < INT(CONF_intMemberLevel) OR INT(intMemoUseLevel) = INT(CONF_intMemberLevel) THEN
			ELSE
				RESPONSE.WRITE ExecJavaAlert(strErrorMsg, 1)
				RESPONSE.End()
			END IF
		END IF
	END IF

	DIM CONF_bitMemoExec

	SELECT CASE CONF_strOpenMemo
	CASE "0" : CONF_bitMemoExec = False
	CASE "1"
		IF SESSION("strLoginID") = strUserID THEN
			CONF_bitMemoExec = True
		ELSE
			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_FRIEND] '" & strUserID & "', '" & SESSION("strLoginID") & "' ")
			IF RS.EOF THEN CONF_bitMemoExec = False ELSE CONF_bitMemoExec = True
		END IF
	CASE "2" : CONF_bitMemoExec = True
	END SELECT
%>
<script language="javascript">
	var SET_Editor_FilePath = "Pds/Memo/";
</script>
<script type="text/javascript" language="javascript" src="Editor/cheditor.js"></script>
<script language="javascript">

	var myeditor = new cheditor("myeditor");

	myeditor.config.editorWidth = '100%';
	myeditor.config.editorHeight = '300px';
	myeditor.config.includeHostname = false;
	myeditor.config.editorBgcolor = "";
	myeditor.inputForm = 'strContent';

</script>
<table width="100%" border="0" cellpadding="10" cellspacing="0" bgcolor="#FFFFFF">
<form name="theForm" method="post" action="MyMenu/MemoSend.asp">
<input type="hidden" name="strUserID" value="<%=strUserID%>">
<input type="hidden" name="strLoginID" value="<%=SESSION("strLoginID")%>">
	<tr>
		<td valign="top" height="100%">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
				<tr>
					<td height="30"><img src="MyMenu/images/ico_dot.gif" width="9" height="9"><b><%=strUserName%></b>님에게 쪽지를 발송합니다.(<input name="bitSendClose" type="checkbox" id="bitSendClose" value="1" checked>
					전송 후 창닫음)</td>
				</tr>
				<tr>
					<td height="10">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td background="MyMenu/images/line_dot.gif" height="9"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="5">&nbsp;</td>
				</tr>
				<tr>
					<td height="2">
						<table width="100%" border="1" cellpadding="10" cellspacing="0" bordercolor="#e7e7e7" style="border-collapse:collapse; line-height:16px;">
							<tr>
							<td bgcolor="#f7f7f7"><font color="#808080">쪽지는 상대방이 수신동의를 했을 경우에만 발송하실수 있습니다.
							</font></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="3">&nbsp;</td>
				</tr>
				<tr>
					<td>
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#FFFFFF">
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><textarea name="strContent" cols="70" style="display:none"></textarea><script type="text/javascript" language="javascript">myeditor.run();</script></td>
										</tr>
<% IF CONF_bitMemoExec = True THEN %>
										<tr>
											<td align="center"><a href="javascript:;" onClick="OnSubmitAction();return false;"><img src="MyMenu/images/btn_send.gif" border="0" align="absmiddle"></a>&nbsp;<a href="javascript:history.back(-1);"><img src="MyMenu/images/btn_cancle.gif" border="0" align="absmiddle"></a></td>
										</tr>
<% ELSE %>
										<tr>
											<td align="center"><%=strUserName%> 님은 쪽지수신 거부상태로 설정되어 있습니다.</td>
										</tr>
<% END IF %>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="100%" align="center" valign="bottom">&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
<script language="javascript">

	function OnSubmitAction(){

		document.getElementById("strContent").value = myeditor.outputBodyHTML();
		if (document.getElementById("strContent").value == ""){
			alert("내용을 입력해 주세요..");myeditor.editArea.focus();return;
		}

		document.theForm.submit();

	}

</script>
<!-- #include file = "Foot.asp" -->