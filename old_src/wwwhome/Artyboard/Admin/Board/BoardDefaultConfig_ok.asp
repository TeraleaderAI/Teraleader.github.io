<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 1
	isAdminPopup    = False
	strAdminPrevUrl = "Board/BoardList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM strBoardID, strName, strTitle, strMemo, strSkin, strSkinGroup, strAdmin, strBrowser, strFont, strFontSize, strWidth, strBodyTag
	DIM intTopMargin, intLeftMargin, intRightMargin, strAlign, strColorBg, strColorActive, strColorHover, strColorVisited
	DIM strColorLink, strUserCss, strHeadFile, strTailFile, strHeadText, strTailText, bitSecret, strSecretPassword
	DIM bitNotLink, strNotLinkMsg, strNotLinkList, bitNotIp, strNotIpMsg, strNotIpList, bitUseCategory, bitUseVote
	DIM bitUseComment, bitUseScrap, bitUseNickName, bitUseBad, bitUseStat, bitStatCheck, bitAdminCheck, bitUseRss

	WITH REQUEST

		strBoardID        = .FORM("strBoardID")
		strName           = GetReplaceInput(.FORM("strName"), "")
		strTitle          = GetReplaceInput(.FORM("strTitle"), "")
		strMemo           = GetReplaceInput(.FORM("strMemo"), "")
		strSkin           = GetReplaceInput(.FORM("strSkin"),"")
		strSkinGroup      = GetReplaceInput(.FORM("strSkinGroup"),"")
		strCharset        = GetReplaceInput(.FORM("strCharset"),"")
		strKeyword        = GetReplaceInput(.FORM("strKeyword"), "")
		strDescription    = GetReplaceInput(.FORM("strDescription"), "")
		strLanguage       = GetReplaceInput(.FORM("strLanguage"),"")
		strBrowser        = GetReplaceInput(.FORM("strBrowser"), "")
		strFont           = GetReplaceInput(.FORM("strFont"),"")
		strFontSize       = GetReplaceInput(.FORM("strFontSize"),"")
		strWidth          = GetReplaceInput(.FORM("strWidth"),"")
		strBodyTag        = GetReplaceInput(.FORM("strBodyTag"), "")
		intTopMargin      = .FORM("intTopMargin")
		intLeftMargin     = .FORM("intLeftMargin")
		intRightMargin    = .FORM("intRightMargin")
		strAlign          = GetReplaceInput(.FORM("strAlign"),"")
		strColorBg        = GetReplaceInput(.FORM("strColorBg"),"")
		strColorActive    = GetReplaceInput(.FORM("strColorActive"),"")
		strColorHover     = GetReplaceInput(.FORM("strColorHover"),"")
		strColorVisited   = GetReplaceInput(.FORM("strColorVisited"),"")
		strColorLink      = GetReplaceInput(.FORM("strColorLink"),"")
		strUserCss        = GetReplaceInput(.FORM("strUserCss"), "")
		strHeadFile       = GetReplaceInput(.FORM("strHeadFile"), "")
		strTailFile       = GetReplaceInput(.FORM("strTailFile"), "")
		strHeadText       = GetReplaceInput(.FORM("strHeadText"), "")
		strTailText       = GetReplaceInput(.FORM("strTailText"), "")
		bitSecret         = .FORM("bitSecret")
		strSecretPassword = GetReplaceInput(.FORM("strSecretPassword"),"")
		bitNotLink        = .FORM("bitNotLink")
		strNotLinkMsg     = GetReplaceInput(.FORM("strNotLinkMsg"), "")
		strNotLinkList    = GetReplaceInput(.FORM("strNotLinkList"), "")
		bitNotIp          = .FORM("bitNotIp")
		strNotIpMsg       = GetReplaceInput(.FORM("strNotIpMsg"), "")
		strNotIpList      = GetReplaceInput(.FORM("strNotIpList"), "")
		bitUseCategory    = .FORM("bitUseCategory")
		bitUseVote        = .FORM("bitUseVote")
		bitUseComment     = .FORM("bitUseComment")
		bitUseScrap       = .FORM("bitUseScrap")
		bitUseBad         = .FORM("bitUseBad")
		bitUseNickName    = .FORM("bitUseNickName")
		bitUseStat        = .FORM("bitUseStat")
		bitStatCheck      = .FORM("bitStatCheck")
		bitAdminCheck     = .FORM("bitAdminCheck")
		bitUseRss         = .FORM("bitUseRss")

	END WITH

	DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CONFIG_DEFAULT] SET [strName] = '" & strName & "', [strTitle] = '" & strTitle & "', [strMemo] = '" & strMemo & "', [strSkin] = '" & strSkin & "', [strSkinGroup] = '" & strSkinGroup & "', [strCharset] = '" & strCharset & "', [strKeyword] = '" & strKeyword & "', [strDescription] = '" & strDescription & "', [strLanguage] = '" & strLanguage & "', [strBrowser] = '" & strBrowser & "', [strFont] = '" & strFont & "', [strFontSize] = '" & strFontSize & "', [strWidth] = '" & strWidth & "', [strBodyTag] = '" & strBodyTag & "', [intTopMargin] = '" & intTopMargin & "', [intLeftMargin] = '" & intLeftMargin & "', [intRightMargin] = '" & intRightMargin & "', [strAlign] = '" & strAlign & "', [strColorBg] = '" & strColorBg & "', [strColorActive] = '" & strColorActive & "', [strColorHover] = '" & strColorHover & "', [strColorVisited] = '" & strColorVisited & "', [strColorLink] = '" & strColorLink & "', [strUserCss] = '" & strUserCss & "', [strHeadFile] = '" & strHeadFile & "', [strTailFile] = '" & strTailFile & "', [strHeadText] = '" & strHeadText & "', [strTailText] = '" & strTailText & "', [bitSecret] = '" & bitSecret & "', [strSecretPassword] = '" & strSecretPassword & "', [bitNotLink] = '" & bitNotLink & "', [strNotLinkMsg] = '" & strNotLinkMsg & "', [strNotLinkList] = '" & strNotLinkList & "', [bitNotIp] = '" & bitNotIp & "', [strNotIpMsg] = '" & strNotIpMsg & "', [strNotIpList] = '" & strNotIpList & "', [bitUseCategory] = '" & bitUseCategory & "', [bitUseVote] = '" & bitUseVote & "', [bitUseComment] = '" & bitUseComment & "', [bitUseScrap] = '" & bitUseScrap & "', [bitUseBad] = '" & bitUseBad & "', [bitUseNickName] = '" & bitUseNickName & "', [bitUseStat] = '" & bitUseStat & "', [bitStatCheck] = '" & bitStatCheck & "', [bitAdminCheck] = '" & bitAdminCheck & "', [bitUseRss] = '" & bitUseRss & "' WHERE [strBoardID] = '" & strBoardID & "' ")

	RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "BoardDefaultConfig.asp?strBoardID=" & strBoardID, "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>