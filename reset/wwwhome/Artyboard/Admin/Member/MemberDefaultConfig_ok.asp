<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Member/MemberDefaultConfig.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM strBrowser, strFont, strFontSize, intTopMargin, intLeftMargin, intRightMargin, strColorBg, strColorActive, strColorHover
	DIM strColorVisited, strColorLink, strUserCss, bitUseMarkAvata, bitUseNameAvata, intNameAvataWidth, intNameAvataHeight
	DIM strHeadFile, strTailFile, strHeadText, strTailText

	WITH REQUEST

		strBrowser         = GetReplaceInput(.FORM("strBrowser"), "")
		strFont            = GetReplaceInput(.FORM("strFont"), "")
		strFontSize        = GetReplaceInput(.FORM("strFontSize"), "")
		intTopMargin       = .FORM("intTopMargin")
		IF intTopMargin = "" THEN intTopMargin = 0
		intLeftMargin      = .FORM("intLeftMargin")
		IF intLeftMargin = "" THEN intLeftMargin = 0
		intRightMargin     = .FORM("intRightMargin")
		IF intRightMargin = "" THEN intRightMargin = 0
		strColorBg         = GetReplaceInput(.FORM("strColorBg"), "")
		strColorActive     = GetReplaceInput(.FORM("strColorActive"), "")
		strColorHover      = GetReplaceInput(.FORM("strColorHover"), "")
		strColorVisited    = GetReplaceInput(.FORM("strColorVisited"), "")
		strColorLink       = GetReplaceInput(.FORM("strColorLink"), "")
		strUserCss         = GetReplaceInput(.FORM("strUserCss"), "")
		bitUseMarkAvata    = .FORM("bitUseMarkAvata")
		bitUseNameAvata    = .FORM("bitUseNameAvata")
		intNameAvataWidth  = .FORM("intNameAvataWidth")
		IF intNameAvataWidth = "" THEN intNameAvataWidth = 0
		intNameAvataHeight = .FORM("intNameAvataHeight")
		IF intNameAvataHeight = "" THEN intNameAvataHeight = 0
		strHeadFile        = GetReplaceInput(.FORM("strHeadFile"), "")
		strTailFile        = GetReplaceInput(.FORM("strTailFile"), "")
		strHeadText        = GetReplaceInput(.FORM("strHeadText"), "")
		strTailText        = GetReplaceInput(.FORM("strTailText"), "")

	END WITH

	DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_CONFIG_DEFAULT] SET [strBrowser] = '" & strBrowser & "', [strFont] = '" & strFont & "', [strFontSize] = '" & strFontSize & "', [intTopMargin] = '" & intTopMargin & "', [intLeftMargin] = '" & intLeftMargin & "', [intRightMargin] = '" & intRightMargin & "', [strColorBg] = '" & strColorBg & "', [strColorActive] = '" & strColorActive & "', [strColorHover] = '" & strColorHover & "', [strColorVisited] = '" & strColorVisited & "', [strColorLink] = '" & strColorLink & "', [strUserCss] = '" & strUserCss & "', [bitUseMarkAvata] = '" & bitUseMarkAvata & "', [bitUseNameAvata] = '" & bitUseNameAvata & "', [intNameAvataWidth] = '" & intNameAvataWidth & "', [intNameAvataHeight] = '" & intNameAvataHeight & "', [strHeadFile] = '" & strHeadFile & "', [strTailFile] = '" & strTailFile & "', [strHeadText] = '" & strHeadText & "', [strTailText] = '" & strTailText	& "' ")

	RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "MemberDefaultConfig.asp", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>