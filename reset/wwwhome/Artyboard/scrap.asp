<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "Library/topSide.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file = "Dbconnect/Dbconnect.asp" -->
<!-- #include file = "Library/Function.asp" -->
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_SCRAP_CONFIG] ")

	DIM bitUse, strSkin, strSkinGroup, strBrowser, strFont, strFontSize, intTopMargin, intLeftMargin, intRightMargin, strColorBg
	DIM strColorActive, strColorHover, strColorVisited, strColorLink, strUserCss
	DIM strHeadFile, strTailFile, strHeadText, strTailText, strWidth, strAlign

	bitUse             = RS("bitUse")
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
	strHeadFile        = RS("strHeadFile")
	strTailFile        = RS("strTailFile")
	strHeadText        = GetReplaceTag2Html(RS("strHeadText"))
	strTailText        = GetReplaceTag2Html(RS("strTailText"))
	strWidth           = RS("strWidth")
	strAlign           = RS("strAlign")

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_GROUP_MEMBER] ")

	DIM bitBoardScrap, intBoardScrapLevel, strErrorUrl, strErrorUrlTarget, strErrorMsg

	bitBoardScrap      = RS("bitBoardScrap")
	intBoardScrapLevel = RS("intBoardScrapLevel")
	strErrorUrl        = RS("strErrorUrl")
	strErrorUrlTarget  = RS("strErrorUrlTarget")
	strErrorMsg        = RS("strErrorMsg")   : IF strErrorMsg = "" OR ISNULL(strErrorMsg) = True THEN strErrorMsg = "이용권한이 없습니다."

	IF SESSION("strLoginID") = "" THEN
		IF UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S")) = "ADD" THEN
			RESPONSE.WRITE ExecJavaAlert("로그인 후 이용해 주시기 바랍니다.", 1)
			RESPONSE.End()
		ELSE
			RESPONSE.WRITE ExecJavaAlert("로그인 후 이용해 주시기 바랍니다.", 0)
			RESPONSE.End()
		END IF
	END IF

	DIM bitScrapUseLevel

	IF bitBoardScrap = True THEN
		bitScrapUseLevel = True
	ELSE
		IF SESSION("strAdmin") = "2" THEN
			bitScrapUseLevel = True
		ELSE
			SET RS = DBCON.EXECUTE("SELECT [intLevel] = (SELECT [intLevel] FROM [MPLUS_GROUP] WHERE [strGroupCode] = [MPLUS_MEMBER_LIST].[strGroup]) FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & SESSION("strLoginID") & "' ")
			IF RS("intLevel") = "" OR ISNULL(RS("intLevel")) = True THEN
				bitScrapUseLevel = False
			ELSE
				IF (INT(RS("intLevel")) = INT(intBoardScrapLevel)) OR (INT(RS("intLevel")) > INT(intBoardScrapLevel)) THEN
					bitScrapUseLevel = True
				ELSE
					bitScrapUseLevel = False
				END IF
			END IF
		END IF
	END IF

	IF bitScrapUseLevel = False THEN
		IF UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S")) = "ADD" THEN
			RESPONSE.WRITE ExecJavaAlert(strErrorMsg, 1)
			RESPONSE.End()
		ELSE
			IF strErrorUrl <> "" AND ISNULL(strErrorUrl) = False THEN
				RESPONSE.WRITE ExecFormSubmit(strErrorMsg, strErrorUrl, strErrorUrlTarget)
				RESPONSE.End()
			ELSE
				RESPONSE.WRITE ExecJavaAlert(strErrorMsg, 0)
				RESPONSE.End()
			END IF
		END IF
	END IF

	DIM bitHeadTailFileExec, bitHeadTailHtmlExec

	SELECT CASE UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))
	CASE "ADD", "ADD_OK", "REMOVE"
		bitHeadTailFileExec = False
		bitHeadTailHtmlExec = False
	CASE "LIST"
		bitHeadTailFileExec = True
		bitHeadTailHtmlExec = True
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
<script language="javascript" src="<%=GetSkinPath(strSkin, 2, strSkinGroup, 1)%>/scrap.js"></script>
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
	CASE "ADD_OK"

		DBCON.EXECUTE("INSERT INTO [MPLUS_SCRAP_LIST] ([strLoginID], [strBoardID], [intBoardNum], [strComment]) VALUES ('" & GetReplaceInput(REQUEST.QueryString("strLoginID"), "S") & "', '" & GetReplaceInput(REQUEST.QueryString("strBoardID"), "S") & "', '" & GetReplaceInput(REQUEST.QueryString("intSeq"), "S") & "', '" & GetReplaceInput(REQUEST.FORM("strComment"), "") & "' ) ")

		RESPONSE.WRITE "<script language=javascript>" & vbcrlf
		RESPONSE.WRITE "	if (confirm('게시글 스크랩이 완료되었습니다.\n\n지금 스크랩을 확인하시겠습니까?')){" & vbcrlf
		RESPONSE.WRITE "opener.location.href='scrap.asp?Action=list';" & vbcrlf
		RESPONSE.WRITE "self.close();" & vbcrlf
		RESPONSE.WRITE "}else{" & vbcrlf
		RESPONSE.WRITE "self.close();" & vbcrlf
		RESPONSE.WRITE "}" & vbcrlf
		RESPONSE.WRITE "</script>" & vbcrlf
		RESPONSE.End()

	CASE "REMOVE"

		SET RS = DBCON.EXECUTE("SELECT [intSeq] FROM [MPLUS_SCRAP_LIST] WHERE [intSeq] = '" & GetReplaceInput(REQUEST.QueryString("intSeq"), "S") & "' AND [strLoginID] = '" & SESSION("strLoginID") & "' ")

		IF RS.EOF THEN
			RESPONSE.WRITE ExecJavaAlert("스크랩 정보가 존재하지 않거나\n로그인 세션 정보가 없습니다.", 0)
			RESPONSE.End()
		ELSE

			DBCON.EXECUTE("DELETE FROM [MPLUS_SCRAP_LIST] WHERE [intSeq] = '" & GetReplaceInput(REQUEST.QueryString("intSeq"), "S") & "' AND [strLoginID] = '" & SESSION("strLoginID") & "' ")

			RESPONSE.WRITE ExecFormSubmit("정상적으로 삭제되었습니다.", "scrap.asp?Action=list", "")
			RESPONSE.End()

		END IF

	END SELECT

	SELECT CASE UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))
	CASE "ADD"
		strSkinFile     = GetSkinPath(strSkin, 2, strSkinGroup, 0) & "\write.asp"
	CASE "LIST"
		strSkinFile     = GetSkinPath(strSkin, 2, strSkinGroup, 0) & "\list.asp"
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