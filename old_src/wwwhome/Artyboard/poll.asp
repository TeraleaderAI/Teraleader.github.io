<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "Library/topSide.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- #include file = "Dbconnect/Dbconnect.asp" -->
<!-- #include file = "Library/Function.asp" -->
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_POLL_CONFIG] ")

	DIM strSkin, strSkinGroup, strBrowser, strFont, strFontSize, intTopMargin, intLeftMargin, intRightMargin, strColorBg
	DIM strColorActive, strColorHover, strColorVisited, strColorLink, strUserCss, strUseHeadTailFile, strUseHeadTailText
	DIM strHeadFile, strTailFile, strHeadText, strTailText, strWidth, strAlign

	strSkin            = RS("strSkin")
	strSkinGroup       = RS("strSkinGroup")
	strBrowser         = RS("strBrowser")
	strFont            = RS("strFont")
	strFontSize        = RS("strFontSize")
	intTopMargin       = RS("intTopMargin")
	intLeftMargin      = RS("intLeftMargin")
	intRightMargin     = RS("intRightMargin")
	strColorBg         = RS("strColorBg")
	strColorActive     = RS("strColorActive")
	strColorHover      = RS("strColorHover")
	strColorVisited    = RS("strColorVisited")
	strColorLink       = RS("strColorLink")
	strUserCss         = RS("strUserCss")
	strUseHeadTailFile = SPLIT(RS("strUseHeadTailFile"), "|")
	strUseHeadTailText = SPLIT(RS("strUseHeadTailText"), "|")
	strHeadFile        = RS("strHeadFile")
	strTailFile        = RS("strTailFile")
	strHeadText        = RS("strHeadText")
	strTailText        = RS("strTailText")
	strWidth           = RS("strWidth")
	strAlign           = RS("strAlign")

	DIM bitHeadTailFileExec, bitHeadTailHtmlExec

	SELECT CASE UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))
	CASE "LIST", "READ"
		IF strUseHeadTailFile(0) = "1" THEN bitHeadTailFileExec = True ELSE bitHeadTailFileExec = False
		IF strUseHeadTailText(0) = "1" THEN bitHeadTailHtmlExec = True ELSE bitHeadTailHtmlExec = False
	CASE "ACTION"
		IF strUseHeadTailFile(1) = "1" THEN bitHeadTailFileExec = True ELSE bitHeadTailFileExec = False
		IF strUseHeadTailText(1) = "1" THEN bitHeadTailHtmlExec = True ELSE bitHeadTailHtmlExec = False
	CASE "RESULT"
		IF strUseHeadTailFile(2) = "1" THEN bitHeadTailFileExec = True ELSE bitHeadTailFileExec = False
		IF strUseHeadTailText(2) = "1" THEN bitHeadTailHtmlExec = True ELSE bitHeadTailHtmlExec = False
	CASE "TEXTRESULT"
		bitHeadTailFileExec = False
		bitHeadTailHtmlExec = False
	END SELECT
%>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title><%=strBrowser%></title>
<style type="text/css">
    
    BODY, TD    {FONT-FAMILY:<%=strFont%>; FONT-SIZE:<%=strFontSize%>; COLOR:#555555; LINE-HEIGHT:normal; TEXT-DECORATION:none;}
    IMG         {border:0px;}

    a           {FONT-FAMILY:<%=strFont%>; FONT-SIZE:<%=strFontSize%>; LINE-HEIGHT:normal;}
    a:link      {COLOR:<%=strColorLink%>; TEXT-DECORATION:none;}
    a:visited   {COLOR:<%=strColorVisited%>; TEXT-DECORATION:none;}
    a:active    {COLOR:<%=strColorActive%>; TEXT-DECORATION:none;}
    a:hover     {COLOR:<%=strColorHover%>; TEXT-DECORATION:underline;}

    .barcolor   {background:#ABA79E}
    .border     {border:1px solid #ABA79E}
    .bordertb   {border-top:1px solid #ABA79E; border-bottom:1px solid #ABA79E}
<%=strUserCss%>
</style>
<LINK REL="stylesheet" HREF="<%=GetSkinPath(strSkin, 2, strSkinGroup, 1)%>/style.css" TYPE="text/css" TITLE="style">
<script language="javascript" src="<%=GetSkinPath(strSkin, 2, strSkinGroup, 1)%>/poll.js"></script>
<script language="javascript" src="Js/valid.js"></script>
</head>
<body leftmargin='<%=intLeftMargin%>' topmargin='<%=intTopMargin%>' marginheight='<%=intRightMargin%>' bgcolor="<%=strColorBg%>">
<%
	IF bitHeadTailFileExec = True THEN
		IF strHeadFile <> "" AND ISNULL(strHeadFile) = False THEN SERVER.EXECUTE(strHeadFile)
	END IF

	IF bitHeadTailHtmlExec = True THEN
		IF strHeadText <> "" AND ISNULL(strHeadText) = False THEN RESPONSE.WRITE strHeadText
	END IF

	SELECT CASE UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))
	CASE "LIST"
		strSkinFile     = GetSkinPath(strSkin, 2, strSkinGroup, 0) & "\list.asp"
	CASE "READ"
		strSkinFile     = GetSkinPath(strSkin, 2, strSkinGroup, 0) & "\read.asp"
	CASE "ACTION"
		strSkinFile     = GetSkinPath(strSkin, 2, strSkinGroup, 0) & "\action.asp"
	CASE "RESULT"
		strSkinFile     = GetSkinPath(strSkin, 2, strSkinGroup, 0) & "\result.asp"
	CASE "TEXTRESULT"
		strSkinFile     = GetSkinPath(strSkin, 2, strSkinGroup, 0) & "\TextResult.asp"
	END SELECT

	SERVER.EXECUTE(strSkinFile)

	IF bitHeadTailFileExec = True THEN
		IF strTailText <> "" AND ISNULL(strTailText) = False THEN RESPONSE.WRITE strTailText
	END IF

	IF bitHeadTailHtmlExec = True THEN
		IF strTailFile <> "" AND ISNULL(strTailFile) = False THEN SERVER.EXECUTE(strTailFile)
	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>
</body>
</html>
<!-- #include file = "Library/downSide.asp" -->