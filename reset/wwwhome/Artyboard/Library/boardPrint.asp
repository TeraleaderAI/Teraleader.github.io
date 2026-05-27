<!--METADATA TYPE="typelib" NAME="ADODB Type Library" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"-->
<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<HTML>
<HEAD>
<TITLE>▒▒▒ 게시글 프린트 화면 보기 ▒▒▒</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</HEAD>
<body bgcolor="#FFFFFF" onload=printWindow();>
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "Function.asp" -->
<style>
	BODY {MARGIN: 10px; SCROLLBAR-FACE-COLOR: #EAE6E6; SCROLLBAR-HIGHLIGHT-COLOR: #666666; SCROLLBAR-SHADOW-COLOR: #666666; SCROLLBAR-3DLIGHT-COLOR: #eeeeee; SCROLLBAR-ARROW-COLOR: #000000; SCROLLBAR-TRACK-COLOR: #eeeeee; SCROLLBAR-DARKSHADOW-COLOR: #ffffff}
	BODY {FONT-SIZE: 9pt; COLOR: #000000; FONT-FAMILY: 굴림}
	TH, TD {FONT-SIZE: 9pt; COLOR: #000000; FONT-FAMILY: Tahoma,Verdana,Arial;line-height:130%;}
</style>
<%
	DIM intSeq, strBoardID
	intSeq     = GetReplaceInput(REQUEST.QueryString("intSeq"), "S")
	strBoardID = GetReplaceInput(REQUEST.QueryString("strBoardID"), "S")

	SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.Command")
	SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RecordSet")

	AdRs_GetRows_Count = ""
	WITH AdCmd

		.ActiveConnection = DbConnect
		.CommandText      = "MPLUS_GET_BOARD_READ"
		.CommandTimeOut   = 10
		.CommandType      = adCmdStoredProc
		.Parameters.Append	.CreateParameter("intSeq",	adInteger,	adParamInput,	,	intSeq)
		.Parameters.Append	.CreateParameter("strBoardID",	adVarchar,	adParamInput,	20,	strBoardID)
		.Parameters.Append	.CreateParameter("strLoginID",	adVarchar,	adParamInput,	20,	strLoginID)
		.Parameters.Append	.CreateParameter("intCategory",	adInteger,	adParamInput,	,	intCategory)

		AdRs.Open .Execute
		IF (NOT (AdRs.EOF OR AdRs.BOF)) THEN
			AdRs_GetRows 		= AdRs.GetRows
			AdRs_GetRows_Count	= UBOUND(AdRs_GetRows, 2)
		END IF
		AdRs.Close
			
	END WITH

	DIM AdRs_intSeq, AdRs_intIndex, AdRs_intThread, AdRs_intDepth, AdRs_strLoginID, AdRs_intCategory, AdRs_strName, AdRs_strPassword
	DIM AdRs_strEmail, AdRs_strHomepage, AdRs_strSubject, AdRs_strContent, AdRs_strSmallSubject, AdRs_strSmallContent, AdRs_strLink1
	DIM AdRs_strLink2, AdRs_strBoardBg, AdRs_strIpAddr, AdRs_bitDelete, AdRs_bitHtml, AdRs_bitText, AdRs_bitNotice, AdRs_bitReMail
	DIM AdRs_bitSecret, AdRs_strSecretID, AdRs_intRead, AdRs_intVote, AdRs_intComment, AdRs_intFileCount, AdRs_strFileCode, AdRs_strFileName1
	DIM AdRs_intFileSize1, AdRs_strFileDown1, AdRs_strFileName2, AdRs_intFileSize2, AdRs_strFileDown2, AdRs_dateRegDate
	DIM AdRs_strMarkImage, AdRs_strNameImage, AdRs_strFileImage, AdRs_strCategory

	AdRs_strContent = REPLACE(AdRs_strContent, CHR(13)&CHR(10), "<br>")

	IF AdRs_bitHtml = True THEN AdRs_strContent = GetReplaceTag2Html(AdRs_strContent)
	IF AdRs_bitText = True THEN AdRs_strContent = GetReplaceTag2Text(AdRs_strContent)

%>
<!-- #include file = "../Include/BoardIncludeReadDefault.asp" -->
<script>
function printWindow() {
/*
	factory.printing.header = ""
	factory.printing.footer = ""
	factory.printing.portrait = true
	factory.printing.leftMargin = 10.0
	factory.printing.topMargin = 20.0
	factory.printing.rightMargin = 10.0
	factory.printing.bottomMargin = 10.0
	factory.printing.Print(true, window)
*/
	window.print();
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<col width="80"><col>
  <tr>
    <td height="1" bgcolor="#000000"></td>
    <td bgcolor="#000000"></td>
  </tr>
  <tr>
    <td height="26" align="right" style="padding-right:10">제 목 :</td>
    <td><%=AdRs_strSubject%></td>
  </tr>
  <tr>
    <td height="1" bgcolor="#000000"></td>
    <td bgcolor="#000000"></td>
  </tr>
  <tr>
    <td height="22" align="right" style="padding-right:10">이 름 : </td>
    <td height="22"><%=AdRs_strName%></td>
  </tr>
<% IF AdRs_strHomepage <> "" AND ISNULL(AdRs_strHomepage) = False THEN %>
  <tr>
    <td height="22" align="right" style="padding-right:10">홈페이지 : </td>
    <td height="22"><%=AdRs_strHomepage%></td>
  </tr>
<% END IF %>
  <tr>
    <td height="22" align="right" style="padding-right:10">작성일자 : </td>
    <td height="22"><%=AdRs_dateRegDate%></td>
  </tr>
  <tr>
    <td height="1" colspan="2" bgcolor="#000000"></td>
  </tr>
  <tr>
    <td colspan="2" style="padding:5 0 5 0"><%=AdRs_strContent%></td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
</table>
<% SET RS = NOTHING : DBCON.CLOSE %>
</body>
</html>