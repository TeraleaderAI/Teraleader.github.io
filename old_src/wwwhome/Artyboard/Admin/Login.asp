<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<html>
<head>
<meta http-equiv=Cache-Control content=No-Cache>
<meta http-equiv=Pragma content=No-Cache>
<meta http-equiv=expires content=now>
<meta http-equiv=Content-Type content=text/html; charset=euc-kr>
<title>아티보드 관리자모드</title>
<script language="JavaScript" src="../Js/valId.js"></script>
<link rel="stylesheet" type="text/css" href="Css/style.css">
</head>
<body topmargin="170" leftmargin="0" bgcolor="f7f7f7">
<!-- #include file = "../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
<form name="theForm" method="post" action="Login_ok.asp" onSubmit="return OnAdminLognCheck();">
<input type="hidden" name="strPrevUrl" value="<%=REQUEST.QueryString("strPrevUrl")%>">
	<tr>
		<td width="100%" height="283" background="images/bodybg.gif">
			<table width="670"  border="0" align="center" valign="middle" cellpadding="0" cellspacing="0">
				<tr>
					<td width="330"><img src="images/loginvisual.gif"></td>
					<td>
						<table width="270"  border="0" align="center" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="right" style="padding:0 7 0 0"><img src="images/id.gif" align="absmiddle"></td>
											<td>
											<input name="strLoginID" type="text" id="strLoginID" style="background-color:#ffffff; color:#333333; border:1x solid #ccc8c7; font-size:9pt;" size="23" maxlength="20">
											</td>
										</tr>
										<tr>
											<td align="right" style="padding:0 7 0 0"><img src="images/password.gif" align="absmiddle"></td>
											<td valign="bottom">
											<input name="strLoginPwd" type="password" id="strLoginPwd" style="background-color:#ffffff; color:#333333; border:1x solid #ccc8c7; font-size:9pt;" size="23" maxlength="20">
											</td>
										</tr>
									</table>
								</td>
								<td align="center" style="padding: 0 0 0 5">
								<input type="image" name="imageField" src="images/btn_login.gif" style="border:0; width:58px; height:46px" align="absmiddle">
								</td>
							</tr>
							<tr height="55">
								<td colspan="2" align="right" valign="bottom"><img src="images/login_notice.gif"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
<script language="javascript">
	function OnAdminLognCheck(){
		str = document.all['strLoginID'];
		if (str.value == ""){alert("아이디를 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['strLoginPwd'];
		if (str.value == ""){alert("비밀번호를 입력해 주시기 바랍니다.");str.focus();return false;}
	}
</script>
</body>
</html>
<% SET RS = NOTHING : DBCON.CLOSE %>