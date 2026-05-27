<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- #include file = "Library/topSide.asp" -->
<head>
<!-- #include file = "Dbconnect/Dbconnect.asp" -->
<!-- #include file = "Library/Function.asp" -->
<%
	DIM Action
	Action = UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))

	DIM UseDefaultHeadTail

	SELECT CASE UCASE(Action)
	CASE "JOIN", "REGIST", "EDIT", "RESULT"
		IF UCASE(Action) = "RESULT" THEN
			IF REQUEST.FORM("memberJoinCheck") <> "1" THEN
				RESPONSE.WRITE ExecJavaAlert("올바른 접근방식이 아닙니다.", 0)
				RESPONSE.End()
			END IF
		END IF
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_JOIN] ")
		UseDefaultHeadTail = True
	CASE "LOGIN", "LOGIN_OK", "LOGOUT", "FIND_ID", "FIND_OK"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_LOGIN] ")
		UseDefaultHeadTail = False
	CASE "PROFILE"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_PROFILE] ")
		UseDefaultHeadTail = False
	END SELECT

	DIM strBrowser, strFont, strFontSize, intTopMargin, intLeftMargin, intRightMargin, strColorBg, strColorActive
	DIM strColorHover, strColorVisited, strColorLink, strUserCss, defaultHeadFile, defaultHeadText, defaultTailFile, defaultTailText
	DIM strHeadFile, strTailFile, strHeadText, strTailText, strSkin, strSkinGroup, strSkinFile

	strBrowser      = RS("strBrowser")
	strFont         = RS("strFont")
	strFontSize     = RS("strFontSize")
	intTopMargin    = RS("intTopMargin")
	intLeftMargin   = RS("intLeftMargin")
	intRightMargin  = RS("intRightMargin")
	strColorBg      = RS("strColorBg")
	strColorActive  = RS("strColorActive")
	strColorHover   = RS("strColorHover")
	strColorVisited = RS("strColorVisited")
	strColorLink    = RS("strColorLink")
	strUserCss      = RS("strUserCss")

	IF UseDefaultHeadTail = True THEN
		defaultHeadFile = RS("defaultHeadFile")
		defaultHeadText = GetReplaceTag2Html(RS("defaultHeadText"))
		defaultTailFile = RS("defaultTailFile")
		defaultTailText = GetReplaceTag2Html(RS("defaultTailText"))
	END IF

	IF UCASE(Action) <> "PROFILE" THEN
		strHeadFile     = RS("strHeadFile")
		strTailFile     = RS("strTailFile")
		strHeadText     = GetReplaceTag2Html(RS("strHeadText"))
		strTailText     = GetReplaceTag2Html(RS("strTailText"))
	END IF

	strSkin         = RS("strSkin")
	strSkinGroup    = RS("strSkinGroup")
	
	SELECT CASE UCASE(Action)
	CASE "JOIN"
		strSkinFile     = GetSkinPath(strSkin, 1, strSkinGroup, 0) & "\agree.asp"
	CASE "EDIT", "REGIST"
		strSkinFile     = GetSkinPath(strSkin, 1, strSkinGroup, 0) & "\join.asp"
	CASE "RESULT"
		strSkinFile     = GetSkinPath(strSkin, 1, strSkinGroup, 0) & "\result.asp"
	CASE "LOGIN", "LOGIN_OK", "LOGOUT"
		strSkinFile     = GetSkinPath(strSkin, 1, strSkinGroup, 0) & "\login.asp"
	CASE "PROFILE"
		strSkinFile     = GetSkinPath(strSkin, 1, strSkinGroup, 0) & "\memberProfile.asp"
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
<LINK REL="stylesheet" HREF="<%=GetSkinPath(strSkin, 1, strSkinGroup, 1)%>/style.css" TYPE="text/css" TITLE="style">
<%
	SELECT CASE UCASE(Action)
	CASE "JOIN", "EDIT", "REGIST", "RESULT", "PROFILE"
%>
<script language="javascript" src="<%=GetSkinPath(strSkin, 1, strSkinGroup, 1)%>/member_join.js"></script>
<%
	CASE ELSE
%>
<script language="javascript" src="<%=GetSkinPath(strSkin, 1, strSkinGroup, 1)%>/login.js"></script>
<% END SELECT %>
<script language="javascript" src="Js/valid.js"></script>
</head>
<body leftmargin='<%=intLeftMargin%>' topmargin='<%=intTopMargin%>' marginheight='<%=intRightMargin%>' bgcolor="<%=strColorBg%>">
<%
	IF UseDefaultHeadTail = True THEN
		IF defaultHeadFile <> "" AND ISNULL(defaultHeadFile) = False THEN SERVER.EXECUTE(defaultHeadFile)
		IF defaultHeadText <> "" AND ISNULL(defaultHeadText) = False THEN RESPONSE.WRITE defaultHeadText
	END IF

	IF strHeadFile <> "" AND ISNULL(strHeadFile) = False THEN SERVER.EXECUTE(strHeadFile)
	IF strHeadText <> "" AND ISNULL(strHeadText) = False THEN RESPONSE.WRITE strHeadText

	SERVER.EXECUTE(strSkinFile)

	IF strTailText <> "" AND ISNULL(strTailText) = False THEN RESPONSE.WRITE strTailText
	IF strTailFile <> "" AND ISNULL(strTailFile) = False THEN SERVER.EXECUTE(strTailFile)

	IF UseDefaultHeadTail = True THEN
		IF defaultTailText <> "" AND ISNULL(defaultTailText) = False THEN RESPONSE.WRITE defaultTailText
		IF defaultTailFile <> "" AND ISNULL(defaultTailFile) = False THEN SERVER.EXECUTE(defaultTailFile)
	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>
</body>
</html>
<!-- #include file = "Library/downSide.asp" -->