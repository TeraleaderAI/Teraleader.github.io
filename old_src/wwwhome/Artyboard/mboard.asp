<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- #include file = "Library/topSide.asp" -->
<head>

<!-- #include file = "Dbconnect/Dbconnect.asp" -->
<!-- #include file = "Library/Function.asp" -->
<%
	RESPONSE.AddHeader "Pragma","no-cache"
	RESPONSE.AddHeader "Cache-Control","private"
	RESPONSE.CacheControl = "no-chche"
	RESPONSE.Buffer = True
	RESPONSE.Expires = -1

	DIM strBoardID, intSeq, Action
	strBoardID = GetReplaceInput(REQUEST.QueryString("strBoardID"), "S")
	intSeq     = GetReplaceInput(REQUEST.QueryString("intSeq"), "S")
	Action     = UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S")) : IF Action = "" THEN Action = "LIST"

	IF strBoardID = "" THEN
		RESPONSE.WRITE ExecJavaAlert("게시판이 존재하지 않거나 게시판 아이디가 올바르지 않습니다.", 0)
		RESPONSE.End()
	END IF

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '" & strBoardID & "' ")
	IF RS.EOF THEN
		RESPONSE.WRITE ExecJavaAlert("게시판이 존재하지 않거나 게시판 아이디가 올바르지 않습니다.", 0)
		RESPONSE.End()
	ELSE

		DIM CONF_strName, CONF_strTitle, CONF_strBoardSkin, CONF_strSkinGroup, CONF_strAdmin, CONF_strCharset, CONF_strKeyword
		DIM CONF_strDescription, CONF_strLanguage, CONF_strBrowser, CONF_strFont, CONF_strFontSize, CONF_strWidth, CONF_strBodyTag
		DIM CONF_intTopMargin, CONF_intLeftMargin, CONF_intRightMargin, CONF_strAlign, CONF_strColorBg, CONF_strColorActive
		DIM CONF_strColorHover, CONF_strColorVisited, CONF_strColorLink, CONF_strUserCss, CONF_strHeadFile, CONF_strTailFile
		DIM CONF_strHeadText, CONF_strTailText, CONF_bitSecret, CONF_bitNotLink, CONF_strNotLinkMsg, CONF_strNotLinkList
		DIM CONF_bitNotIp, CONF_strNotIpMsg, CONF_strNotIpList, CONF_bitListBoard, CONF_bitUseStat, CONF_bitStatCheck
		DIM CONF_bitBoardGroup, CONF_bitImgLightbox

		CONF_strName         = RS("strName")
		CONF_strTitle        = RS("strTitle")
		CONF_strBoardSkin    = RS("strSkin")
		CONF_strSkinGroup    = RS("strSkinGroup")
		CONF_strAdmin        = RS("strAdmin")
		CONF_strCharset      = RS("strCharset")
		CONF_strKeyword      = RS("strKeyword")
		CONF_strDescription  = RS("strDescription")
		CONF_strLanguage     = RS("strLanguage")
		CONF_strBrowser      = RS("strBrowser")
		CONF_strFont         = RS("strFont")
		CONF_strFontSize     = RS("strFontSize")
		CONF_strWidth        = RS("strWidth")
		CONF_strBodyTag      = RS("strBodyTag")
		CONF_intTopMargin    = RS("intTopMargin")
		CONF_intLeftMargin   = RS("intLeftMargin")
		CONF_intRightMargin  = RS("intRightMargin")
		CONF_strAlign        = GetAlignSet(RS("strAlign"))
		CONF_strColorBg      = RS("strColorBg")
		CONF_strColorActive  = RS("strColorActive")
		CONF_strColorHover   = RS("strColorHover")
		CONF_strColorVisited = RS("strColorVisited")
		CONF_strColorLink    = RS("strColorLink")
		CONF_strUserCss      = RS("strUserCss")
		CONF_strHeadFile     = RS("strHeadFile")
		CONF_strTailFile     = RS("strTailFile")
		CONF_strHeadText     = GetReplaceTag2Html(RS("strHeadText"))
		CONF_strTailText     = GetReplaceTag2Html(RS("strTailText"))
		CONF_bitSecret       = RS("bitSecret")
		CONF_bitNotLink      = RS("bitNotLink")
		CONF_strNotLinkMsg   = RS("strNotLinkMsg")
		CONF_strNotLinkList  = RS("strNotLinkList")
		CONF_bitNotIp        = RS("bitNotIp")
		CONF_strNotIpMsg     = RS("strNotIpMsg")
		CONF_strNotIpList    = RS("strNotIpList")
		CONF_bitListBoard    = RS("bitListBoard")
		CONF_bitUseStat      = RS("bitUseStat")
		CONF_bitStatCheck    = RS("bitStatCheck")
		CONF_bitBoardGroup   = RS("bitBoardGroup")
		CONF_bitImgLightbox  = RS("bitImgLightbox")
%>
<!-- #include file = "Include/BoardIncludeLanguage.asp" -->
<%
		DIM Query
		IF GetAdminCheck(SESSION("strLoginID"), CONF_strAdmin, SESSION("strAdmin")) = False THEN

			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_GROUP_CHECK] '" & strBoardID & "' ")

			IF NOT(RS.EOF) THEN

				DIM strNotMsg, strMoveUrl
				strNotMsg    = RS("strNotMsg")
				strMoveUrl   = RS("strMoveUrl")

				IF strNotMsg = "" OR ISNULL(strNotMsg) = True THEN strNotMsg = "게시판 접근 권한이 없습니다."

				WHILE NOT(RS.EOF)
					IF Query <> "" THEN Query = Query & ","
					Query = Query & "'" & RS("strGroupCode") & "' "
				RS.MOVENEXT
				WEND
				Query = " AND [strGroupCode] IN (" & Query & ") "

				IF SESSION("strLoginID") = "" THEN

					IF strMoveUrl = "" OR ISNULL(strMoveUrl) = True THEN RESPONSE.WRITE ExecJavaAlert(strNotMsg, 0) ELSE RESPONSE.WRITE ExecFormSubmit(strNotMsg, strMoveUrl, "")
					RESPONSE.End()

				ELSE

					SET RS = DBCON.EXECUTE("SELECT [strLoginID] FROM [MPLUS_BOARD_GROUP_MEMBER] WHERE [strLoginID] = '" & SESSION("strLoginID") & "' " & Query)

					IF RS.EOF THEN
						IF strMoveUrl = "" OR ISNULL(strMoveUrl) = True THEN
							RESPONSE.WRITE ExecJavaAlert(strNotMsg, 0)
						ELSE
							RESPONSE.WRITE ExecFormSubmit(strNotMsg, strMoveUrl, "")
						END IF
						RESPONSE.End()
					END IF

				END IF
			END IF
		END IF

		IF CONF_bitNotLink = True THEN
			IF checkBoardLink(CONF_strNotLinkList) = False THEN
				RESPONSE.WRITE ExecJavaAlert(CONF_strNotLinkMsg, 0)
				RESPONSE.End()
			END IF
		END IF

		IF CONF_bitNotIp = True THEN
			IF checkUserIP(CONF_strNotIpList) = False THEN
				RESPONSE.WRITE ExecJavaAlert(CONF_strNotIpMsg, 0)
				RESPONSE.End()
			END IF
		END IF

		IF CONF_bitUseStat = True THEN
			IF SESSION("strStat") = "" THEN
				DIM tempAgent, strBrowser, strOs
				tempAgent = SPLIT(REPLACE(REQUEST.ServerVariables("HTTP_USER_AGENT"), "'", "''"), ";")
	
				IF UBOUND(tempAgent) > 1 THEN
					strBrowser = TRIM(tempAgent(1))
					strOs      = TRIM(REPLACE(tempAgent(2), ")", ""))
				ELSE
					strBrowser = ""
					strOs      = ""
				END IF

				DBCON.EXECUTE("EXEC [MPLUS_PUT_BOARD_STAT] '" & strBoardID & "', '" & YEAR(NOW) & "', '" & MONTH(NOW) & "', '" & DAY(NOW) & "', '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "', '" & REQUEST.ServerVariables("HTTP_USER_AGENT") & "', '" & REQUEST.ServerVariables("HTTP_REFERER") & "', '" & strBrowser & "', '" & strOs & "', '" & GetTrueFalse(CONF_bitStatCheck) & "' ")

				SESSION("strStat") = True

			END IF
		END IF

	END IF

	IF UCASE(Action) = "VIEW" AND (CONF_strBrowser = "" OR ISNULL(CONF_strBrowser) = True) AND intSeq <> "" THEN
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_READ_DEFAULT] '" & intSeq & "' ")
		IF RS("strSubject") <> "" AND ISNULL(RS("strSubject")) = False THEN CONF_strBrowser = StripTags(RS("strSubject"))
	END IF
%>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=<%=CONF_strCharset%>">
<META NAME="Keywords" CONTENT="<%=CONF_strKeyword%>">
<META NAME="Description" CONTENT="<%=CONF_strDescription%>">
<title><%=CONF_strBrowser%></title>
<style type="text/css">
    
    BODY, TD    {FONT-FAMILY:<%=CONF_strFont%>; FONT-SIZE:<%=CONF_strFontSize%>; LINE-HEIGHT:normal; TEXT-DECORATION:none;}
    IMG         {border:0px;}

    a           {FONT-FAMILY:<%=CONF_strFont%>; FONT-SIZE:<%=CONF_strFontSize%>; LINE-HEIGHT:normal;}
    a:link      {COLOR:<%=CONF_strColorLink%>; TEXT-DECORATION:none;}
    a:visited   {COLOR:<%=CONF_strColorVisited%>; TEXT-DECORATION:none;}
    a:active    {COLOR:<%=CONF_strColorActive%>; TEXT-DECORATION:none;}
    a:hover     {COLOR:<%=CONF_strColorHover%>; TEXT-DECORATION:underline;}

    .barcolor   {background:#ABA79E}
    .border     {border:1px solid #ABA79E}
    .bordertb   {border-top:1px solid #ABA79E; border-bottom:1px solid #ABA79E}

</style>
<LINK REL="stylesheet" HREF="<%=GetSkinPath(CONF_strBoardSkin, 0, CONF_strSkinGroup, 1)%>/style.css" TYPE="text/css" TITLE="style">
<script language="javascript" src="<%=GetSkinPath(CONF_strBoardSkin, 0, CONF_strSkinGroup, 1)%>/board.js"></script>
<script language="javascript" src="Js/valid.js"></script>
<script language="javascript" src="Js/sideview.js"></script>
</head>
<%
	IF CONF_strUserCss <> "" AND ISNULL(CONF_strUserCss) = False THEN
		RESPONSE.WRITE "<STYLE>" & vbcrlf
		RESPONSE.WRITE CONF_strUserCss
		RESPONSE.WRITE "</STYLE>" & vbcrlf
	END IF
%>
<body leftmargin='<%=CONF_intLeftMargin%>' topmargin='<%=CONF_intTopMargin%>' marginheight='<%=CONF_intRightMargin%>' bgcolor="<%=CONF_strColorBg%>" <% IF CONF_strBodyTag <> "" AND ISNULL(CONF_strBodyTag) = False THEN %><%=CONF_strBodyTag%><% END IF %>>
<%
	IF CONF_strHeadFile <> "" AND ISNULL(CONF_strHeadFile) = False AND UCASE(Action) <> "POPVIEW" THEN SERVER.EXECUTE(CONF_strHeadFile)
	IF CONF_strHeadText <> "" AND ISNULL(CONF_strHeadText) = False AND UCASE(Action) <> "POPVIEW" THEN RESPONSE.WRITE CONF_strHeadText

	RESPONSE.WRITE "<table width=" & CONF_strWidth & " align=" & CONF_strAlign & " border=0 cellspacing=0 cellpadding=0>" & vbcrlf
	IF CONF_strTitle <> "" AND ISNULL(CONF_strTitle) = False THEN
	RESPONSE.WRITE "	<tr>" & vbcrlf
	RESPONSE.WRITE "		<td>" & vbcrlf
	RESPONSE.WRITE CONF_strTitle
	RESPONSE.WRITE "		</td>" & vbcrlf
	RESPONSE.WRITE "	</tr>" & vbcrlf
	END IF
	RESPONSE.WRITE "	<tr>" & vbcrlf
	RESPONSE.WRITE "		<td>" & vbcrlf

	DIM strSkinFile

	IF GetSecretBoardCheck(CONF_bitSecret, CONF_strAdmin, SESSION("strSecretBoard"), strBoardID) = True THEN
		SELECT CASE UCASE(Action)
		CASE "LIST"                        : strSkinFile = GetSkinPath(CONF_strBoardSkin, 0, CONF_strSkinGroup, 0) & "\list.asp"
		CASE "WRITE", "REPLY", "EDIT"      : strSkinFile = GetSkinPath(CONF_strBoardSkin, 0, CONF_strSkinGroup, 0) & "\write.asp"
		CASE "VIEW"                        : strSkinFile = GetSkinPath(CONF_strBoardSkin, 0, CONF_strSkinGroup, 0) & "\view.asp"
		CASE "POPVIEW"                     : strSkinFile = GetSkinPath(CONF_strBoardSkin, 0, CONF_strSkinGroup, 0) & "\Popview.asp"
		CASE "REMOVE", "REMOVE_PWD"        : strSkinFile = GetSkinPath(CONF_strBoardSkin, 0, CONF_strSkinGroup, 0) & "\delete.asp"
		CASE "LOGIN", "LOGOUT", "LOGIN_OK" : strSkinFile = GetSkinPath(CONF_strBoardSkin, 0, CONF_strSkinGroup, 0) & "\login.asp"
		CASE "PASSWORD"                    : strSkinFile = GetSkinPath(CONF_strBoardSkin, 0, CONF_strSkinGroup, 0) & "\password.asp"
		CASE "CMTREMOVE"                   : strSkinFile = GetSkinPath(CONF_strBoardSkin, 0, CONF_strSkinGroup, 0) & "\commentDelete.asp"
		CASE "CMTEDIT", "CMTREPLY"         : strSkinFile = GetSkinPath(CONF_strBoardSkin, 0, CONF_strSkinGroup, 0) & "\commentAdd.asp"
		END SELECT
	ELSE
		IF GetReplaceInput(REQUEST.FORM("strPassword"), "S") = "" THEN
			strSkinFile = GetSkinPath(CONF_strBoardSkin, 0, CONF_strSkinGroup, 0) & "\password.asp"
		ELSE
			SET RS = DBCON.EXECUTE("SELECT [strSecretPassword] FROM [MPLUS_BOARD_CONFIG_DEFAULT] WHERE [strBoardID] = '" & strBoardID & "' AND [strSecretPassword] = '" & GetReplaceInput(REQUEST.FORM("strPassword"), "S") & "' ")
			IF RS.EOF THEN
				RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(7), 0)
				RESPONSE.End()
			ELSE
				SESSION("strSecretBoard") = strBoardID
				RESPONSE.REDIRECT "mboard.asp?strBoardID=" & strBoardID
				RESPONSE.End()
			END IF
		END IF
	END IF

	SERVER.EXECUTE(strSkinFile)

	IF UCASE(Action) = "VIEW" AND CONF_bitListBoard = True THEN SERVER.EXECUTE(GetSkinPath(CONF_strBoardSkin, 0, CONF_strSkinGroup, 0) & "\list.asp")

	RESPONSE.WRITE "		</td>" & vbcrlf
	RESPONSE.WRITE "	</tr>" & vbcrlf
	RESPONSE.WRITE "	<tr>" & vbcrlf
	RESPONSE.WRITE "		<td align=right><br>" & vbcrlf
	RESPONSE.WRITE GetCopyRight(rootPath & GetSkinPath(CONF_strBoardSkin, 0, CONF_strSkinGroup, 0))
	RESPONSE.WRITE "		</td>" & vbcrlf
	RESPONSE.WRITE "	</tr>" & vbcrlf
	RESPONSE.WRITE "</table>" & vbcrlf

	IF CONF_strTailText <> "" AND ISNULL(CONF_strTailText) = False AND UCASE(Action) <> "POPVIEW" THEN RESPONSE.WRITE CONF_strTailText
	IF CONF_strTailFile <> "" AND ISNULL(CONF_strTailFile) = False AND UCASE(Action) <> "POPVIEW" THEN SERVER.EXECUTE(CONF_strTailFile)
%>
<% SET RS = NOTHING : DBCON.CLOSE %>
</body>
</html>
<!-- #include file = "Library/downSide.asp" -->