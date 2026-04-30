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

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_LOGIN] ")

	bitUseSsnFindID     = RS("bitUseSsnFindID")
	bitUseSsnFindPW     = RS("bitUseSsnFindPW")
	bitFindEmail        = RS("bitFindEmail")

	SELECT CASE Action
	CASE "ID"
		IF bitUseSsnFindID = True THEN bitUseSSN = True ELSE bitUseSSN = False
	CASE "PW"
		IF bitUseSsnFindPW = True THEN bitUseSSN = True ELSE bitUseSSN = False
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
<script language="javascript" src="../Js/valid.js"></script>
<table width="590" border="0" cellspacing="0" cellpadding="0" height="100%">
<form name="theForm" method="post" action="findMemberID_ok.asp?Action=<%=Action%>" onSubmit="return OnSubmitAction();">
	<tr>
		<td><img src="images/tit_idsearch.jpg" width="590" height="66"></td>
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
							<tr bgcolor="#996633"><td height="1" colspan="2"></td>
							</tr>
<% IF Action = "PW" THEN %>
							<tr>
								<td width="130" height="28" align="right" bgcolor="#EEE5DB" style="padding:0 5 0 0">회원 아이디 </td>
								<td height="28" style="padding:0 0 0 5"><input name="strLoginID" type="text" class="input" id="strLoginID" onFocus="this.className='inputfs'" onBlur="this.className='input'"></td>
							</tr>
							<tr bgcolor="#EAE6E6"><td height="1" colspan="2"></td>
							</tr>
<% END IF %>
							<tr>
								<td width="130" height="28" align="right" bgcolor="#EEE5DB" style="padding:0 5 0 0">회원 이름</td>
								<td height="28" style="padding:0 0 0 5"><input name="strLoginName" type="text" class="input" id="strLoginName" onFocus="this.className='inputfs'" onBlur="this.className='input'" size="20" maxlength="20"></td>
							</tr>
							<tr bgcolor="#EAE6E6"><td height="1" colspan="2"></td>
							</tr>
							<tr>
								<td width="130" height="28" align="right" bgcolor="#EEE5DB" style="padding:0 5 0 0">이메일</td>
								<td height="28" style="padding:0 0 0 5"><input name="strEmail" type="text" class="input" id="strEmail" onFocus="this.className='inputfs'" onBlur="this.className='input'" size="30" maxlength="64"></td>
							</tr>
							<tr bgcolor="#EAE6E6"><td height="1" colspan="2"></td>
							</tr>
<% IF bitUseSSN = True THEN %>
							<tr>
								<td width="130" height="28" align="right" bgcolor="#EEE5DB" style="padding:0 5 0 0">주민등록번호</td>
								<td height="28" style="padding:0 0 0 5"><input name="strSSN1" type="text" class="input" id="strSSN1" onFocus="this.className='inputfs'" onBlur="this.className='input'" size="9" maxlength="6"> 
								- 
								<input name="strSSN2" type="text" class="input" id="strSSN2" onFocus="this.className='inputfs'" onBlur="this.className='input'" size="9" maxlength="7"></td>
							</tr>
							<tr bgcolor="#EAE6E6"><td height="1" colspan="2"></td>
							</tr>
<% END IF %>
							<tr align="center"><td height="70" colspan="2"><span style="color:#660000;font-size:8pt;">※ 신규 회원 가입시 입력한 정보를정확히 입력해주시기 바랍니다.</span><br>
							  <br>
							    <% IF Action = "ID" THEN %><a href="findMemberID.asp?Action=PW">비밀번호를 찾으시려면 <u>여기</u> 클릭하세요.</a><% ELSE %><a href="findMemberID.asp?Action=ID">아이디를 찾으시려면 <u>여기</u>를 클릭하세요.</a><% END IF %></td>
							</tr>
							<tr bgcolor="#EAE6E6"><td height="1" colspan="2"></td>
							</tr>
							<tr align="center"><td height="40" colspan="2"><input name="imageField" type="image" src="images/btn_search.gif" width="49" height="23" border="0"></td>
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

	SET_USE_SSN = "<%=bitUseSSN%>";
	SET_FIND_MODE = "<%=Action%>";

	function init(){
		window.resizeTo(600, 432);
	}

	function OnSubmitAction(){
		if (SET_FIND_MODE == "PW"){
			str = document.all['strLoginID'];
			if (str.value == ""){alert("회원 아이디를 입력해 주시기 바랍니다.");str.focus();return false;}
		}

		str = document.all['strLoginName'];
		if (str.value == ""){alert("회원 이름을 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['strEmail'];
		if (!isEmailCheck(str.value)){alert("이메일 주소를 올바르게 입력해 주시기 바랍니다.");str.focus();return false;}

		if (SET_USE_SSN == "True"){
			if (!isSSNNo(document.all['strSSN1'].value + document.all['strSSN2'].value)){
				alert("주민등록번호를 올바르게 입력해 주시기 바립니다.");
				document.all['strSSN1'].focus();
				return;
			}
		}
	}
</script>
<% SET RS = NOTHING : DBCON.CLOSE %>
</BODY>
</HTML>