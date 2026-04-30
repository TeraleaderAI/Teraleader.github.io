<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"></head>
<title>▒▒▒ 첨부파일 다운로드 ▒▒▒</title>
<link rel="stylesheet" type="text/css" href="style.css">
<body topmargin="0" leftmargin="0">
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM strBoardID, intSeq
	strBoardID  = GetReplaceInput(REQUEST.QueryString("strBoardID"), "S")
	intSeq      = GetReplaceInput(REQUEST.QueryString("intSeq"), "S")

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_READ_DEFAULT] '" & intSeq & "' ")

	DIM strSubject, intRead, dateRegDate, strFileCode
	strSubject  = RS("strSubject")
	intRead     = RS("intRead")
	dateRegDate = RS("dateRegDate")
	strFileCode = RS("strFileCode")
%>
<table width="460" height="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="images/tit_down.gif" width="460" height="41"></td>
  </tr>
  <tr>
    <td height="12" bgcolor="F0F0F0">&nbsp;</td>
  </tr>
  <tr>
    <td height="100%" valign="top">
		<table width="97%"  border="0" align="center" cellpadding="0" cellspacing="0">
		  <tr>
			<td height="30"><font color="3096B7"><b>- <%=strSubject%></b></font> </td>
		  </tr>
		  <tr>
		  	<td height="30" align="right">조회 : <%=intRead%> 등록일자 : <%=dateRegDate%></td>
	  	</tr>
		  <tr>
			<td>
				<table width="100%"  border="0" cellpadding="15" cellspacing="3" bgcolor="F0F0F0">
				  <tr>
						<td bgcolor="#FFFFFF">
							<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#CCCCCC">
								<tr>
									<td height="24" align="center" bgcolor="#F7F4F8">파일명</td>
									<td width="70" align="center" bgcolor="#F7F4F8">사이즈</td>
									<td width="70" align="center" bgcolor="#F7F4F8">다운수</td>
								</tr>
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_FILE] '" & strFileCode & "', '' ")

	DIM strFileExt
	WHILE NOT(RS.EOF)
		strFileExt = REPLACE(MID(RS("strFileName"), InStrRev(RS("strFileName"), ".")), ".", "")
%>
								<tr>
									<td height="24" bgcolor="#FFFFFF" style="padding-left:10px;"><img src="fileicon/<%=strFileExt%>.gif" align="absmiddle">&nbsp;<a href="fileDown.asp?strBoardID=<%=strBoardID%>&intNum=<%=RS("intNum")%>&intSeq=<%=intSeq%>"><%=RS("strFileName")%></a></td>
									<td align="center" bgcolor="#FFFFFF"><%=GetFilesize(RS("intFileSize"))%></td>
									<td align="center" bgcolor="#FFFFFF"><%=GetMoneyComma(RS("intFileDown"))%></td>
								</tr>
<%
	RS.MOVENEXT
	WEND
%>
							</table>
						</td>
				  </tr>
				</table>
			</td>
		  </tr>
		</table>
	</td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" bgcolor="E7E7E7"><a href="javascript:self.close();"><img src="images/snap_close.gif" width="57" height="33" border="0"></a></td>
  </tr>
</table>
<% SET RS = NOTHING : DBCON.CLOSE %>
</body>
</html>