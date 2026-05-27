<HTML>
<HEAD>
<TITLE>▒▒▒ 회원탈퇴 신청 ▒▒▒</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</HEAD>
<BODY bgcolor="#FFFFFF" onLoad="init();">
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	IF SESSION("strLoginID") = "" THEN
		RESPONSE.WRITE ExecJavaAlert("로그인 후 이용하시기 바랍니다.", 1)
		RESPONSE.End()
	END IF

	DIM intPage, intPageSize, intTotalCount, intPageCount
	intPage     = GetReplaceInput(REQUEST.QueryString("intPage"), "S") : IF intPage = "" THEN intPage     = 1
	intPageSize = 10

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_POINT_LIST] '1', '" & SESSION("strLoginID") & "', '0', '0' ")
	
	DIM intTotalPoint
	intTotalPoint = RS("intTotalPoint")   : IF intTotalPoint = "" OR ISNULL(intTotalPoint) = True THEN intTotalPoint = 0

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_POINT_LIST] '2', '" & SESSION("strLoginID") & "', '0', '0' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_POINT_LIST] '3', '" & SESSION("strLoginID") & "', '" & intPage & "', '" & intPageSize & "' ")
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
<form name="theForm" method="post">
	<tr>
		<td><img src="images/tit_m_Point.jpg" width="590" height="66"></td>
	</tr>
	<tr>
		<td height="100%" align="center" valign="top">
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="25" style="padding-left:15"><%=SESSION("strLoginName")%>(<%=SESSION("strLoginID")%>) 님의 포인트 내역입니다. </td>
				</tr>
				<tr>
					<td align="center" valign="top">
						<table width="95%"  border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#996633"><td height="1" colspan="6"></td>
							</tr>
							<tr>
								<td height="28" align="center" bgcolor="#EEE5DB" style="padding:0 5 0 0">번호</td>
								<td height="28" align="center" bgcolor="#EEE5DB">포인트구분</td>
							  <td align="center" bgcolor="#EEE5DB">포인트코드</td>
							  <td align="center" bgcolor="#EEE5DB">포인트</td>
							  <td align="center" bgcolor="#EEE5DB">메모</td>
							  <td align="center" bgcolor="#EEE5DB">일자</td>
							  </tr>
							<tr bgcolor="#EAE6E6"><td height="1" colspan="6"></td>
							</tr>
<%
	IF RS.EOF THEN
%>
							<tr>
								<td height="28" colspan="6" align="center" style="padding:0 5 0 0">포인트 내역이 없습니다.</td>
							</tr>
							<tr bgcolor="#EAE6E6"><td height="1" colspan="6"></td>
							</tr>
<%
	ELSE
		DIM strPointType, intNumber, iCount
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
			SELECT CASE RS("strPointType")
			CASE "0" : strPointType = "회원관련"
			CASE "1" : strPointType = "게시판관련"
			CASE "2" : strPointType = "그룹관련"
			CASE "3" : strPointType = "기타"
			END SELECT
%>
							<tr>
								<td height="28" align="center" style="padding:0 5 0 0"><%=intNumber%></td>
								<td height="28" align="center"><%=strPointType%></td>
							  <td align="center"><%=RS("strPointCode")%></td>
							  <td align="center"><%=RS("moneyPoint")%></td>
							  <td align="center"><%=RS("strMemo")%></td>
							  <td align="center"><%=GetDateType(0, RS("dateRegDate"))%></td>
							</tr>
							<tr bgcolor="#EAE6E6"><td height="1" colspan="6"></td>
							</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
							<tr>
								<td height="28" colspan="6" align="right" style="padding:0 5 0 0">포인트 합계 : <b><%=GetMoneyComma(intTotalPoint)%></b> Points </td>
								</tr>
							<tr bgcolor="#EAE6E6"><td height="1" colspan="6"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				  <td height="30" align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="38" align="right" bgcolor="#E7E7E7"><a href="javascript:self.close();"><img src="images/bu_close.gif" width="56" height="38" border="0"></a></td>
	</tr>
</table>
<%
	SUB GotoPageHTML(intPage, intPageCount)
	
	DIM blockpage, i
	blockpage = INT((intPage - 1) / 10) * 10 + 1

	IF blockpage = 1 THEN RESPONSE.WRITE "[이전10개] "	ELSE RESPONSE.WRITE "<a href=MemberPoint.asp?intPage=" & blockpage - 10 & "&strLoginID=" & strLoginID & ">[이전 10개]</a> "

	i = 1
	
	DO UNTIL i > 10 OR blockpage > intPageCount
		IF blockpage = INT(intPage) THEN RESPONSE.WRITE " <b>" & blockpage & "</b> " ELSE RESPONSE.WRITE "[<a href=MemberPoint.asp?intPage=" & blockpage & "&strLoginID=" & strLoginID & ">" & blockpage & "</a>]"

		blockpage = blockpage + 1
		i = i + 1
	LOOP

	IF blockpage > intPageCount THEN RESPONSE.WRITE " [다음 10개]"	ELSE RESPONSE.WRITE " <a href=MemberPoint.asp?intPage=" & blockpage & "&strLoginID=" & strLoginID & ">[다음 10개]</a>"

	END SUB
%>
<script language="javascript">
	function init(){
		window.resizeTo(600, 560);
	}
</script>
<% SET RS = NOTHING : DBCON.CLOSE %>
</BODY>
</HTML>