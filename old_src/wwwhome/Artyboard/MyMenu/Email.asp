<!-- #include file = "Head.asp" -->
<script language="javascript">
	var SET_Editor_FilePath = "Pds/Mail/";
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
<form name="theForm" method="post" action="MyMenu/MailSend.asp">
<input type="hidden" name="strUserID" value="<%=strUserID%>">
<input type="hidden" name="strLoginID" value="<%=SESSION("strLoginID")%>">
	<tr>
		<td valign="top" height="100%">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
				<tr>
					<td height="30"><img src="MyMenu/images/ico_dot.gif" width="9" height="9"><b><%=strUserName%></b>님에게 메일을 발송합니다.</td>
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
					<td height="10">&nbsp;</td>
				</tr>
				<tr>
					<td>
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#FFFFFF">
								<td height="30"><img src="MyMenu/images/ico_dot.gif" width="9" height="9"><b>메일제목
								<input name="strSubject" type="text" id="strSubject" style="font-size:12px;" size="80" maxlength="100">
								</b></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td height="100%" align="center"><textarea name="strContent" cols="70" style="display:none"></textarea><script type="text/javascript" language="javascript">myeditor.run();</script></td>
							</tr>
						</table>
					</td>
				</tr>
<% IF CONF_strOpenEmail = True THEN %>
				<tr>
					<td height="40" align="center" valign="bottom"><a href="javascript:;" onClick="OnSubmitAction();return false;"><img src="MyMenu/images/btn_send.gif" border="0" align="absmiddle"></a>&nbsp;<a href="javascript:history.back(-1);"><img src="MyMenu/images/btn_cancle.gif" border="0" align="absmiddle"></a></td>
				</tr>
<% ELSE %>
				<tr>
					<td align="center"><%=strUserName%> 님은 메일수신 거부상태로 설정되어 있습니다.</td>
				</tr>
<% END IF %>
			</table>
		</td>
	</tr>
</form>
</table>
<script language="javascript">

	function OnSubmitAction(){

		if (myeditor.outputBodyHTML() <= 0){
			alert("내용을 입력하여 주세요.");
			myeditor.editArea.focus();
			return false;
		}

		myeditor.outputBodyHTML();

		document.theForm.submit();

	}

</script>
<!-- #include file = "Foot.asp" -->