<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"></head>
<title>▒▒▒ 메일보내기 ▒▒▒</title>
<link rel="stylesheet" type="text/css" href="style.css">
<script language="javascript" src="../Js/valid.js"></script>
<!-- #include file = "Function.asp" -->
<body leftmargin="0" topmargin="0" onLoad="init();">
<%
	DIM strLoginID, strLoginName, intSeq
	strLoginID   = GetReplaceInput(REQUEST.QueryString("strLoginID"), "S")
	strLoginName = GetReplaceInput(REQUEST.QueryString("strLoginName"), "S")
	intSeq       = GetReplaceInput(REQUEST.QueryString("intSeq"), "S")
%>
<script language="javascript">
	var SET_Editor_FilePath = "Pds/Mail/Editor/";
</script>
<script type="text/javascript" language="javascript" src="../Editor/cheditor.js"></script>
<script language="javascript">

	var myeditor = new cheditor("myeditor");

	myeditor.config.editorHeight = '260px';
	myeditor.config.editorWidth = '100%';
	myeditor.config.editorPath = '../Editor/';
	myeditor.config.imgReSize = false;
	myeditor.config.useJustifyLeft = false;
	myeditor.config.useJustifyCenter = false;
	myeditor.config.useJustifyRight = false;
	myeditor.config.useJustifyFull = false;
	myeditor.config.useOrderedList = false;
	myeditor.config.useUnOrderedList = false;
	myeditor.config.useOutdent = false;
	myeditor.config.useIndent = false;
	myeditor.config.useSuperscript = false;
	myeditor.config.useSubscript = false;
	myeditor.config.useParagraph = false;
	myeditor.config.useBackColor = false;
	myeditor.config.useBoxStyle = false;
	myeditor.config.ieEnterMode = 'br';
	myeditor.inputForm = 'strContent';

</script>
<table width="600"  border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="sendMail_ok.asp?intSeq=<%=intSeq%>" onSubmit="return OnMailCheck();" enctype="multipart/form-data">
<textarea id="strContent" name="strContent" style="display:none"></textarea>
	<tr>
		<td><img src="images/tit_mail.jpg" width="600" height="66"></td>
	</tr>
	<tr>
		<td>
			<table width="97%"  border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td height="30"><b><font color="3096B7"><%=strLoginName%>님<font color="#000000">(<%=strLoginID%>)</font> 께 메일을 보냅니다.</font></b></td>
				</tr>
				<tr>
					<td>
						<table width="100%"  border="0" cellpadding="15" cellspacing="3" bgcolor="F0F0F0">
							<tr>
								<td bgcolor="#FFFFFF">
									<table width="100%"  border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="80" height="27" style="padding:0 0 0 10">참조</td>
											<td><input name="recvEamilCc" type="text" id="recvEamilCc" style="width:100%"></td>
										</tr>
										<tr>
											<td height="1" colspan="2" bgcolor="F0F0F0"></td>
										</tr>
										<tr>
											<td height="27" style="padding:0 0 0 10">숨은참조</td>
											<td><input name="recvEamilBcc" type="text" id="recvEamilBcc" style="width:100%"></td>
										</tr>
										<tr>
											<td height="1" colspan="2" bgcolor="F0F0F0"></td>
										</tr>
										<tr>
											<td height="27" style="padding:0 0 0 10">보내는 사람</td>
											<td><input name="sendName" type="text" id="sendName" size="30"></td>
										</tr>
										<tr>
											<td height="1" colspan="2" bgcolor="F0F0F0"></td>
										</tr>
										<tr>
											<td height="27" style="padding:0 0 0 10">이메일</td>
											<td><input name="sendMail" type="text" id="sendMail" style="width:100%"></td>
										</tr>
										<tr>
											<td height="1" colspan="2" bgcolor="F0F0F0"></td>
										</tr>
										<tr>
											<td height="27" style="padding:0 0 0 10">제목</td>
											<td><input name="strSubject" type="text" id="strSubject" style="width:100%"></td>
										</tr>
										<tr>
											<td height="1" colspan="2" bgcolor="F0F0F0"></td>
										</tr>
										<tr>
											<td height="27" colspan="2"><script type="text/javascript" language="javascript">myeditor.run();</script></td>
										</tr>
										<tr>
											<td height="1" colspan="2" bgcolor="F0F0F0"></td>
										</tr>
										<tr>
											<td height="27" style="padding:0 0 0 10">첨부파일 #1 </td>
											<td><input name="sendFileName1" type="file" id="sendFileName1" style="width:100%"></td>
										</tr>
										<tr>
											<td height="1" colspan="2" bgcolor="F0F0F0"></td>
										</tr>
										<tr>
											<td height="27" style="padding:0 0 0 10">첨부파일 #1 </td>
											<td><input name="sendFileName2" type="file" id="sendFileName2" style="width:100%"></td>
										</tr>
										<tr>
											<td height="1" colspan="2" bgcolor="F0F0F0"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="40" align="center" valign="bottom"><input name="imageField" type="image" src="images/btn_send.gif" width="63" height="23" border="0" align="absmiddle"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
	<tr>
		<td align="right" bgcolor="E7E7E7"><a href="javascript:self.close();"><img src="images/bu_close.gif" width="56" height="38" border="0"></a></td>
	</tr>
</form>
</table>
<script language="javascript">
	function OnMailCheck(){
		str = document.all['recvEamilCc'];
		if (str.value != ""){if (!isEmailCheck(str.value)){alert("메일주소를 올바르게 입력해 주시기 바랍니다.");str.focus();return false;}}

		str = document.all['recvEamilBcc'];
		if (str.value != ""){if (!isEmailCheck(str.value)){alert("메일주소를 올바르게 입력해 주시기 바랍니다.");str.focus();return false;}}

		str = document.all['sendName'];
		if (str.value == ""){alert("보내는 사람의 이름을 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['sendMail'];
		if (str.value == ""){alert("메일주소를 입력해 주시기 바랍니다.");str.focus();return false;}
		if (!isEmailCheck(str.value)){alert("메일주소를 올바르게 입력해 주시기 바랍니다.");str.focus();return false;}
		
		str = document.all['strSubject'];
		if (str.value == ""){alert("제목을 입력해 주시기 바랍니다.");str.focus();return false;}

		document.getElementById("strContent").value = myeditor.outputBodyHTML();

		if (document.getElementById("strContent").value == ""){
			alert("내용을 입력하여 주세요.");myeditor.editArea.focus();return false;
		}

	}

	function init(){
		window.resizeTo(600, 820);
	}
</script>
</body>
</html>