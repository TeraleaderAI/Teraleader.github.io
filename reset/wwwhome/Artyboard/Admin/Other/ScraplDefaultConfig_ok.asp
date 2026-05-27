<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Other/ScraplDefaultConfig.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM bitUse, strSKin, strBrowser, strFont, strFontSize, intTopMargin, intLeftMargin, intRightMargin, strColorBg, strColorActive
	DIM strColorHover, strColorVisited, strColorLink, strUserCss, strHeadFile, strTailFile
	DIM strHeadText, strTailText, strWidth, strAlign, strUseHeadTailFile1, strUseHeadTailFile2, strUseHeadTailFile3, strUseHeadTailText1
	DIM strUseHeadTailText2, strUseHeadTailText3, intPageCount, intLineCount, strPagePrevGroup, strPageNextGroup, strPageFirstPage
	DIM strPageEndPage, strPageNow, strPageDefault
	
		WITH REQUEST
	
			bitUse             = .FORM("bitUse")
			strSKin            = GetReplaceInput(.FORM("strSKin"),"")
			strBrowser         = GetReplaceInput(.FORM("strBrowser"), "")
			strFont            = GetReplaceInput(.FORM("strFont"), "")
			strFontSize        = GetReplaceInput(.FORM("strFontSize"), "")
			intTopMargin       = .FORM("intTopMargin")
			intLeftMargin      = .FORM("intLeftMargin")
			intRightMargin     = .FORM("intRightMargin")
			strColorBg         = GetReplaceInput(.FORM("strColorBg"), "")
			strColorActive     = GetReplaceInput(.FORM("strColorActive"), "")
			strColorHover      = GetReplaceInput(.FORM("strColorHover"), "")
			strColorVisited    = GetReplaceInput(.FORM("strColorVisited"), "")
			strColorLink       = GetReplaceInput(.FORM("strColorLink"), "")
			strUserCss         = GetReplaceInput(.FORM("strUserCss"), "")
			strHeadFile        = GetReplaceInput(.FORM("strHeadFile"), "")
			strTailFile        = GetReplaceInput(.FORM("strTailFile"), "")
			strHeadText        = GetReplaceInput(.FORM("strHeadText"), "")
			strTailText        = GetReplaceInput(.FORM("strTailText"), "")
			strWidth           = GetReplaceInput(.FORM("strWidth"), "")
			strAlign           = GetReplaceInput(.FORM("strAlign"), "")
			intLineCount       = .FORM("intLineCount")
			intPageCount       = .FORM("intPageCount")
			strPagePrevGroup   = GetReplaceInput(.FORM("strPagePrevGroup"), "")
			strPageNextGroup   = GetReplaceInput(.FORM("strPageNextGroup"), "")
			strPageFirstPage   = GetReplaceInput(.FORM("strPageFirstPage"), "")
			strPageEndPage     = GetReplaceInput(.FORM("strPageEndPage"), "")
			strPageNow         = GetReplaceInput(.FORM("strPageNow"), "")
			strPageDefault     = GetReplaceInput(.FORM("strPageDefault"), "")

		END WITH

		DBCON.EXECUTE("UPDATE [MPLUS_SCRAP_CONFIG] SET [bitUse] = '" & bitUse & "', [strSKin] = '" & strSKin & "', [strBrowser] = '" & strBrowser & "', [strFont] = '" & strFont & "', [strFontSize] = '" & strFontSize & "', [intTopMargin] = '" & intTopMargin & "', [intLeftMargin] = '" & intLeftMargin & "', [intRightMargin] = '" & intRightMargin & "', [strColorBg] = '" & strColorBg & "', [strColorActive] = '" & strColorActive & "', [strColorHover] = '" & strColorHover & "', [strColorVisited] = '" & strColorVisited & "', [strColorLink] = '" & strColorLink & "', [strUserCss] = '" & strUserCss & "', [strHeadFile] = '" & strHeadFile & "', [strTailFile] = '" & strTailFile & "', [strHeadText] = '" & strHeadText & "', [strTailText] = '" & strTailText & "', [strWidth] = '" & strWidth & "', [strAlign] = '" & strAlign & "', [intLineCount] = '" & intLineCount & "', [intPageCount] = '" & intPageCount & "', [strPagePrevGroup] = '" & strPagePrevGroup & "', [strPageNextGroup] = '" & strPageNextGroup & "', [strPageFirstPage] = '" & strPageFirstPage & "', [strPageEndPage] = '" & strPageEndPage & "', [strPageNow] = '" & strPageNow & "', [strPageDefault] = '" & strPageDefault & "' ")

	RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "ScraplDefaultConfig.asp", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>