<HTML>
<HEAD>
<TITLE>▒▒▒ 회원 아이디/비밀번호 찾기 ▒▒▒</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"></HEAD>
<BODY bgcolor="#FFFFFF" onLoad="init();">
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM Action
	Action = UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))

	DIM strLoginID, strLoginName, strEmail, strSSN, SQL, tPassword, strFindID, strFindPw
	strLoginID   = GetReplaceInput(REQUEST.Form("strLoginID"), "")
	strLoginName = GetReplaceInput(REQUEST.Form("strLoginName"), "")
	strEmail     = GetReplaceInput(REQUEST.Form("strEmail"), "")
	strSSN       = GetReplaceInput(REQUEST.Form("strSSN1") & REQUEST.Form("strSSN2"), "")

	SELECT CASE Action
	CASE "ID"

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_FIND_IDPW] '" & strLoginName & "', '" & strEmail & "', '" & strSSN & "', '" & strLoginID & "', '0' ")
		IF RS.EOF THEN
			RESPONSE.WRITE ExecJavaAlert("일치하는 회원정보가 없습니다.", 0)
			RESPONSE.End()
		ELSE
			strFindID = RS("strLoginID")
		END IF

	CASE "PW"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_FIND_IDPW] '" & strLoginName & "', '" & strEmail & "', '" & strSSN & "', '" & strLoginID & "', '1' ")
		IF RS.EOF THEN

			RESPONSE.WRITE ExecJavaAlert("일치하는 회원정보가 없습니다.", 0)
			RESPONSE.End()

		ELSE

			RANDOMIZE
			strChangePw = INT(RND() * 9) & INT(RND() * 9) & INT(RND() * 9) & INT(RND() * 9) & INT(RND() * 9) & INT(RND() * 9) & INT(RND() * 9) & INT(RND() * 9) & INT(RND() * 9) & INT(RND() * 9)				

			strFindID = RS("strLoginID")
			strFindPw = strChangePw

			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strLoginPwd] = '" & strChangePw & "' WHERE [strLoginID] = '" & strLoginID & "' ")

			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_LOGIN] ")
			DIM bitFindEmail
			bitFindEmail = RS("bitFindEmail")

			IF bitFindEmail <> "0" THEN CALL sendMemberEmail(strLoginID, "1")
		END IF
	END SELECT
%>
<style>
	#scrollbox {width:100%; height:140; overflow:auto; padding:0px; border:0px solid #A0D7D9;}
	BODY {MARGIN: 0px; SCROLLBAR-FACE-COLOR: #cccccc; SCROLLBAR-HIGHLIGHT-COLOR: #666666; SCROLLBAR-SHADOW-COLOR: #666666; SCROLLBAR-3DLIGHT-COLOR: #eeeeee; SCROLLBAR-ARROW-COLOR: #000000; SCROLLBAR-TRACK-COLOR: #eeeeee; SCROLLBAR-DARKSHADOW-COLOR: #ffffff}
	BODY {FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: 굴림}
	TH, TD {FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: Tahoma,Verdana,Arial;line-height:130%;}

	.input      {FONT-FAMILY:돋움; FONT-SIZE:9pt; BORDER:#E5E5E5 1px solid; COLOR:#555555; HEIGHT:18px;}
  .inputfs    {FONT-FAMILY:돋움; FONT-SIZE:9pt; BORDER:#E5E5E5 1px solid; COLOR:#555555; HEIGHT:18px; background:#F5F5F5;}

	A:link 		{FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: "굴림"; TEXT-DECORATION: none}
	A:visited {FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: "굴림"; TEXT-DECORATION: none}
	A:hover 	{FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: "굴림"; TEXT-DECORATION: none}
</style>
<table width="590" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="findPost.asp?strForm=<%=strForm%>">
	<tr>
		<td><img src="images/tit_idsearch.jpg" width="590" height="66"></td>
	</tr>
	<tr>
		<td height="300" align="center" valign="top">
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="25"></td>
				</tr>
				<tr>
					<td align="center" valign="top">
						<table width="400"  border="0" cellspacing="0" cellpadding="0">
						<% IF Action = "ID" THEN %>
							<tr bgcolor="#996633"><td height="1"></td>
							</tr>
								<tr><td height="10"></td>
							</tr>
							<tr>
								<td height="28">회원님의 아이디는 <span style="color:#660000;"><%=strFindID%></span> 입니다.</td>
							</tr>
								<tr><td height="10"></td>
							</tr>
							<tr bgcolor="#EAE6E6"><td height="1"></td>
							</tr>
						<% ELSE %>
							<tr bgcolor="#996633"><td height="1"></td>
							</tr>
								<tr><td height="10"></td>
							</tr>
							<tr>
								<td><span style="color:#660000;"><% IF bitFindEmail = "1" THEN %></span>
								회원님께서 가입하실때 사용하신 이메일로 아이디와 비밀번호를 발송해 드렸습니다.
								<% ELSE %>
								회원님의 아이디는 <span style="color:#660000;"><%=strFindID%></span> 이며 비밀번호는 <span style="color:#660000;"><%=strFindPw%></span>로 임시변경 되었습니다.<br>
								임시 비밀번호를 이용하셔서 로그인 하신 후 비밀번호를 변경해 주시기 바랍니다.
								<% END IF %></td>
							</tr>
								<tr><td height="10"></td>
							</tr>
						<% END IF %>
							<tr bgcolor="#EAE6E6">
								<td height="1"></td>
							</tr>
								<tr><td height="40" align="center"><a href="javascript:;" onClick="self.close();return false;"><img src="images/btn_ok.gif" width="49" height="23" border="0"></a></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
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
</script>
<% SET RS = NOTHING : DBCON.CLOSE %>
</BODY>
</HTML>