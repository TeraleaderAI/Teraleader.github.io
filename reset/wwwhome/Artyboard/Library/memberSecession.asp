<HTML>
<HEAD>
<TITLE>▒▒▒ 회원탈퇴 신청 ▒▒▒</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"></HEAD>
<BODY bgcolor="#FFFFFF" onLoad="init();">
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	IF SESSION("strLoginID") = "" THEN
		RESPONSE.WRITE ExecJavaAlert("로그인 후 이용하시기 바랍니다.", 1)
		RESPONSE.End()
	END IF
%>
<style>
	#scrollbox {width:100%; height:140; overflow:auto; padding:0px; border:0px solid #A0D7D9;}
	BODY {MARGIN: 0px; SCROLLBAR-FACE-COLOR: #cccccc; SCROLLBAR-HIGHLIGHT-COLOR: #666666; SCROLLBAR-SHADOW-COLOR: #666666; SCROLLBAR-3DLIGHT-COLOR: #eeeeee; SCROLLBAR-ARROW-COLOR: #000000; SCROLLBAR-TRACK-COLOR: #eeeeee; SCROLLBAR-DARKSHADOW-COLOR: #ffffff}
	BODY {FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: 굴림}
	TH, TD {FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: Tahoma,Verdana,Arial;line-height:130%;}

	.input      {FONT-FAMILY:돋움; FONT-SIZE:9pt; BORDER:#E5E5E5 1px solid; COLOR:#555555; HEIGHT:18px;}
  .inputfs    {FONT-FAMILY:돋움; FONT-SIZE:9pt; BORDER:#E5E5E5 1px solid; COLOR:#555555; HEIGHT:18px; background:#F5F5F5;}

  .textarea   {FONT-FAMILY:돋움; FONT-SIZE:9pt; background:#FFFFFF; BORDER:#C0C0C0 1px solid; PADDING:4px;
              scrollbar-track-color:#FFFFFF; scrollbar-face-color:#FFFFFF;
              scrollbar-3dlight-color:#FFFFFF; scrollbar-highlight-color:#FFFFFF;
              scrollbar-shadow-color:#FFFFFF; scrollbar-darkshadow-color:#FFFFFF;
              scrollbar-arrow-color:#DDDDDD;}

  .textareafs {FONT-FAMILY:돋움; FONT-SIZE:9pt; background:#F5F5F5; BORDER:#C0C0C0 1px solid; PADDING: 4px;
              scrollbar-track-color:#F5F5F5; scrollbar-face-color:#FFFFFF;
              scrollbar-3dlight-color:#F5F5F5; scrollbar-highlight-color:#F5F5F5;
              scrollbar-shadow-color:#F5F5F5; scrollbar-darkshadow-color:#F5F5F5;
              scrollbar-arrow-color:#DDDDDD;}

	A:link 		{FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: "굴림"; TEXT-DECORATION: none}
	A:visited {FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: "굴림"; TEXT-DECORATION: none}
	A:hover 	{FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: "굴림"; TEXT-DECORATION: none}
</style>
<script language="javascript" src="../Js/valid.js"></script>
<table width="590" border="0" cellspacing="0" cellpadding="0" height="100%">
<form name="theForm" method="post" action="memberSecession_ok.asp" onSubmit="return OnSubmitAction();">
<input type="hidden" name="strLoginID" value="<%=SESSION("strLoginID")%>">
	<tr>
		<td><img src="images/tit_m_Secession.jpg" width="590" height="66"></td>
	</tr>
	<tr>
		<td height="100%" align="center" valign="top">
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="25"></td>
				</tr>
				<tr>
					<td align="center" valign="top">
						<table width="400"  border="0" cellspacing="0" cellpadding="0">
							<col width="130"><col>
							<tr bgcolor="009999"><td height="1" colspan="2"></td>
							</tr>
							<tr>
								<td height="28" align="right" bgcolor="DBEEE5" style="padding:0 5 0 0">회원 아이디 </td>
								<td height="28" style="padding:0 0 0 5"><%=SESSION("strLoginID")%></td>
							</tr>
							<tr bgcolor="#EAE6E6"><td height="1" colspan="2"></td>
							</tr>
							<tr>
								<td height="28" align="right" bgcolor="DBEEE5" style="padding:0 5 0 0">비밀번호</td>
								<td height="28" style="padding:0 0 0 5"><input name="strLoginPwd" type="password" class="input" id="strLoginPwd" onFocus="this.className='inputfs'" onBlur="this.className='input'" size="20" maxlength="20"></td>
							</tr>
							<tr bgcolor="#EAE6E6"><td height="1" colspan="2"></td>
							</tr>
							<tr>
								<td height="28" align="right" bgcolor="DBEEE5" style="padding:0 5 0 0">탈퇴사유</td>
								<td height="28" style="padding:5 0 5 5"><textarea name="strSecessionMemo" cols="40" rows="6" class="textarea" id="strSecessionMemo" onFocus="this.className='textareafs'" onBlur="this.className='textarea'"></textarea></td>
							</tr>
							<tr bgcolor="#EAE6E6"><td height="1" colspan="2"></td>
							</tr>
							<tr align="center"><td height="30" colspan="2"><span style="color:#275849;font-size:8pt;">※ 회원님의 비밀번호와 탈퇴사유를 입력해 주시기 바랍니다.</span></td>
							</tr>
							<tr bgcolor="#EAE6E6"><td height="1" colspan="2"></td>
							</tr>
							<tr align="center"><td height="40" colspan="2"><input name="imageField" type="image" src="images/btn_ok.gif" width="49" height="23" border="0"></td>
							</tr>
						</table>					</td>
				</tr>
			</table>		</td>
	</tr>
	<tr>
		<td height="38" align="right" bgcolor="#E7E7E7"><a href="javascript:self.close();"><img src="images/bu_close.gif" width="56" height="38" border="0"></a></td>
	</tr>
</form>
</table>
<script language="javascript">

	function init(){
		window.resizeTo(600, 432);
	}

	function OnSubmitAction(){

		str = document.all['strLoginPwd'];
		if (str.value == ""){alert("비밀번호를 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['strSecessionMemo'];
		if (str.value == ""){alert("탈퇴사유를 간단히 입력해 주시기 바랍니다.");str.focus();return false;}

	}
</script>
<% SET RS = NOTHING : DBCON.CLOSE %>
</BODY>
</HTML>