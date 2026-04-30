<!-- #include file = "Library/topSide.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file = "Dbconnect/Dbconnect.asp" -->
<!-- #include file = "Library/Function.asp" -->
<%
	DIM Action
	Action = UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))

	DIM UseDefaultHeadTail

	SELECT CASE UCASE(Action)
	CASE "ADD"
		DIM MEMO_strRecvID, MEMO_strSendID, MEMO_strContent
		WITH REQUEST

			MEMO_strRecvID  = GetReplaceInput(.FORM("MEMO_strRecvID"), "")
			MEMO_strSendID  = GetReplaceInput(.FORM("MEMO_strSendID"), "")
			MEMO_strContent = GetReplaceInput(.FORM("MEMO_strContent"), "")

		END WITH

		IF MEMO_strRecvID = MEMO_strSendID THEN
			RESPONSE.WRITE ExecJavaAlert("자기 자신에게 메모를 보낼수는 없습니다.", 0)
			RESPONSE.End()
		END IF

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & MEMO_strRecvID & "', '0' ")

		IF RS.EOF THEN
			RESPONSE.WRITE ExecJavaAlert("등록된 회원 아이디가 아닙니다.", 0)
			RESPONSE.End()
		ELSE
			IF RS("bitSecession") = True THEN
				RESPONSE.WRITE ExecJavaAlert("탈퇴 처리된 회원 아이디 입니다.", 0)
				RESPONSE.End()
			ELSE
				DBCON.EXECUTE("INSERT INTO [MPLUS_MEMO] ([strSendID], [strRecvID], [strContent]) VALUES ('" & MEMO_strSendID & "', '" & MEMO_strRecvID & "', '" & MEMO_strContent & "') ")
	
				RESPONSE.WRITE ExecJavaAlert("메모발송이 완료되었습니다.", 1)
				RESPONSE.End()
			END IF
		END IF

	CASE "WRITE", "READ"
		UseDefaultHeadTail = False
	CASE "LIST"
		UseDefaultHeadTail = True
	CASE "REMOVE"
		
		DIM intNum, I, SQL

		SQL = ""
		FOR I = 1 TO REQUEST.FORM("intNum").COUNT
			SQL = SQL & "'" & GetReplaceInput(REQUEST.FORM("intNum")(I), "") & "',"
		NEXT
		SQL = LEFT(SQL, LEN(SQL) - 1)
		SET RS = DBCON.EXECUTE("SELECT [intNum], [strSendID], [strRecvID] FROM [MPLUS_MEMO] WHERE [intNum] IN (" & SQL & ") ")

		WHILE NOT(RS.EOF)

			IF RS("strSendID") = SESSION("strLoginID") THEN DBCON.EXECUTE("UPDATE [MPLUS_MEMO] SET [bitDeleteSend] = '1' WHERE [intNum] = '" & RS("intNum") & "' ")
			IF RS("strRecvID") = SESSION("strLoginID") THEN DBCON.EXECUTE("UPDATE [MPLUS_MEMO] SET [bitDeleteRecv] = '1' WHERE [intNum] = '" & RS("intNum") & "' ")

		RS.MOVENEXT
		WEND

		RESPONSE.WRITE ExecFormSubmit("삭제되었습니다.", "memo.asp?Action=list&strType=" & GetReplaceInput(REQUEST.QueryString("strType"), "S"), "")
		RESPONSE.End()

	CASE "REMOVEREAD"

		SET RS = DBCON.EXECUTE("SELECT [strSendID], [strRecvID] FROM [MPLUS_MEMO] WHERE [intNum] = '" & GetReplaceInput(REQUEST.QueryString("intNum"), "S") & "' ")

		IF RS("strSendID") = RS("strRecvID") THEN
			DBCON.EXECUTE("UPDATE [MPLUS_MEMO] SET [bitDeleteSend] = '1', [bitDeleteRecv] = '1' WHERE [intNum] = '" & GetReplaceInput(REQUEST.QueryString("intNum"), "S") & "' ")
		ELSE
			IF RS("strSendID") = SESSION("strLoginID") THEN DBCON.EXECUTE("UPDATE [MPLUS_MEMO] SET [bitDeleteSend] = '1' WHERE [intNum] = '" & GetReplaceInput(REQUEST.QueryString("intNum"), "S") & "' ") ELSE DBCON.EXECUTE("UPDATE [MPLUS_MEMO] SET [bitDeleteRecv] = '1' WHERE [intNum] = '" & GetReplaceInput(REQUEST.QueryString("intNum"), "S") & "' ")
		END IF

		RESPONSE.WRITE ExecJavaAlert("삭제되었습니다.", 1)
		RESPONSE.End()

	END SELECT

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMO_CONFIG] ")

	DIM strBrowser, strFont, strFontSize, intTopMargin, intLeftMargin, intRightMargin, strColorBg, strColorActive
	DIM strColorHover, strColorVisited, strColorLink, strUserCss, strHeadFile, strTailFile, strHeadText, strTailText
	DIM strSkin, strSkinGroup, strSkinFile

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
		strHeadFile     = RS("strHeadFile")
		strTailFile     = RS("strTailFile")
		strHeadText     = GetReplaceTag2Html(RS("strHeadText"))
		strTailText     = GetReplaceTag2Html(RS("strTailText"))
	END IF

	strSkin         = RS("strSkin")
	strSkinGroup    = RS("strSkinGroup")
	
	SELECT CASE UCASE(Action)
	CASE "WRITE"
		strSkinFile     = GetSkinPath(strSkin, 1, strSkinGroup, 0) & "\write.asp"
	CASE "LIST"
		strSkinFile     = GetSkinPath(strSkin, 1, strSkinGroup, 0) & "\list.asp"
	CASE "READ"
		strSkinFile     = GetSkinPath(strSkin, 1, strSkinGroup, 0) & "\read.asp"
	CASE "FIND_OK"
		strSkinFile     = GetSkinPath(strSkin, 1, strSkinGroup, 0) & "\find_ok.asp"
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
<script language="javascript" src="<%=GetSkinPath(strSkin, 1, strSkinGroup, 1)%>/memo.js"></script>
<script language="javascript" src="Js/valid.js"></script>
</head>
<body leftmargin='<%=intLeftMargin%>' topmargin='<%=intTopMargin%>' marginheight='<%=intRightMargin%>' bgcolor="<%=strColorBg%>">
<%
	IF UseDefaultHeadTail = True THEN
		IF defaultHeadFile <> "" AND ISNULL(defaultHeadFile) = False THEN SERVER.EXECUTE(defaultHeadFile)
		IF defaultHeadText <> "" AND ISNULL(defaultHeadText) = False THEN RESPONSE.WRITE defaultHeadText
	
		IF strHeadFile <> "" AND ISNULL(strHeadFile) = False THEN SERVER.EXECUTE(strHeadFile)
		IF strHeadText <> "" AND ISNULL(strHeadText) = False THEN RESPONSE.WRITE strHeadText
	END IF

	SERVER.EXECUTE(strSkinFile)

	IF UseDefaultHeadTail = True THEN
		IF strTailText <> "" AND ISNULL(strTailText) = False THEN RESPONSE.WRITE strTailText
		IF strTailFile <> "" AND ISNULL(strTailFile) = False THEN SERVER.EXECUTE(strTailFile)
	
		IF defaultTailText <> "" AND ISNULL(defaultTailText) = False THEN RESPONSE.WRITE defaultTailText
		IF defaultTailFile <> "" AND ISNULL(defaultTailFile) = False THEN SERVER.EXECUTE(defaultTailFile)
	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>
</body>
</html>
<!-- #include file = "Library/downSide.asp" -->