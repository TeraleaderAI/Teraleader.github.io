<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title></title>
</head>
<!-- #include file = "../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM strCssLink, strCssContent, strContent
	
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_AGREE] '" & UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S")) & "' ")
	
	strCssLink     = RS("strCssLink")
	strCssContent  = RS("strCssContent")
	strContent     = GetReplaceTag2Html(RS("strContent"))

	IF strCssLink <> "" AND ISNULL(strCssLink) = False THEN
%>
<LINK REL="stylesheet" HREF="<%=strCssLink%>" TYPE="text/css">
<%
	END IF

	IF strCssContent <> "" AND ISNULL(strCssContent) = False THEN
		RESPONSE.WRITE "<style type=""text/css"">" & vbcrlf
		RESPONSE.WRITE strCssContent
		RESPONSE.WRITE "</style>"
	END IF
%>
<body topmargin="0" leftmargin="0">
<%
	RESPONSE.WRITE strContent
%>
<% SET RS = NOTHING : DBCON.CLOSE %>
</body>
</html>