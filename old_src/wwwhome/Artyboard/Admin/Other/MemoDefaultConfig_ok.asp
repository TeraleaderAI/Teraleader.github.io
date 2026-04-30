<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Other/MemoDefaultConfig.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<!-- #include file = "../../Include/UploadInclude.asp" -->
<%
	RESPONSE.EXPIRES     = 0
	SERVER.SCRIPTTIMEOUT = 2000

	DIM Action, strPath
	Action  = UCASE(REQUEST.QueryString("Action"))
	strPath = rootPath & "Pds\Memo\"

	SELECT CASE Action
	CASE "EDIT"

		DIM strSkin, strBrowser, strFont, strFontSize, intTopMargin, intLeftMargin, intRightMargin, strColorBg, strColorActive, strColorHover
		DIM strColorVisited, strColorLink, strUserCss, strHeadFile, strTailFile, strHeadText, strTailText, strWidth, strAlign
		DIM bitUsage, bitSound, strFileName, intMemoTime, intMemoSaveCount, intPageCount
	
		strSkin          = GetReplaceInput(UPLOAD("strSkin"), "")
		strBrowser       = GetReplaceInput(UPLOAD("strBrowser"), "")
		strFont          = GetReplaceInput(UPLOAD("strFont"), "")
		strFontSize      = GetReplaceInput(UPLOAD("strFontSize"), "")
		intTopMargin     = UPLOAD("intTopMargin")   : IF intTopMargin   = "" THEN intTopMargin = 0
		intLeftMargin    = UPLOAD("intLeftMargin")  : IF intLeftMargin  = "" THEN intLeftMargin = 0
		intRightMargin   = UPLOAD("intRightMargin") : IF intRightMargin = "" THEN intRightMargin = 0
		strColorBg       = GetReplaceInput(UPLOAD("strColorBg"), "")
		strColorActive   = GetReplaceInput(UPLOAD("strColorActive"), "")
		strColorHover    = GetReplaceInput(UPLOAD("strColorHover"), "")
		strColorVisited  = GetReplaceInput(UPLOAD("strColorVisited"), "")
		strColorLink     = GetReplaceInput(UPLOAD("strColorLink"), "")
		strUserCss       = GetReplaceInput(UPLOAD("strUserCss"), "")
		strHeadFile      = GetReplaceInput(UPLOAD("strHeadFile"), "")
		strTailFile      = GetReplaceInput(UPLOAD("strTailFile"), "")
		strHeadText      = GetReplaceInput(UPLOAD("strHeadText"), "")
		strTailText      = GetReplaceInput(UPLOAD("strTailText"), "")
		strWidth         = GetReplaceInput(UPLOAD("strWidth"), "")
		strAlign         = GetReplaceInput(UPLOAD("strAlign"), "")
		bitUsage         = UPLOAD("bitUsage")
		bitSound         = UPLOAD("bitSound")
		intMemoTime      = UPLOAD("intMemoTime")
		intMemoSaveCount = UPLOAD("intMemoSaveCount")
		intPageCount     = UPLOAD("intPageCount")

		DIM theField
		SET theField = UPLOAD("strFileName")(1)

		IF checkMusicFile(setUploadComponet, theField) = True THEN
			strFileName = ExecFIleUpload(setUploadComponet, theField, 1048576, strPath, "", False, "", False, 0, 0, False, "0", False, "0", "")
		END IF

		IF strFileName = False THEN strFileName = ""

		IF strFileName <> "" THEN
			SET RS = DBCON.EXECUTE("SELECT [strSoundFile] FROM [MPLUS_MEMO_CONFIG] ")
			IF RS("strSoundFile") <> "" AND ISNULL(RS("strSoundFile")) = False THEN CALL ExecFileDelete(strPath, RS("strSoundFile"))
			DBCON.EXECUTE("UPDATE [MPLUS_MEMO_CONFIG] SET [strSoundFile] = '" & strFileName & "' ")
		END IF

		DBCON.EXECUTE("UPDATE [MPLUS_MEMO_CONFIG] SET [strBrowser] = '" & strBrowser & "', [strFont] = '" & strFont & "', [strFontSize] = '" & strFontSize & "', [intTopMargin] = '" & intTopMargin & "', [intLeftMargin] = '" & intLeftMargin & "', [intRightMargin] = '" & intRightMargin & "', [strColorBg] = '" & strColorBg & "', [strColorActive] = '" & strColorActive & "', [strColorHover] = '" & strColorHover & "', [strColorVisited] = '" & strColorVisited & "', [strColorLink] = '" & strColorLink & "', [strUserCss] = '" & strUserCss & "', [strHeadFile] = '" & strHeadFile & "', [strTailFile] = '" & strTailFile & "', [strHeadText] = '" & strHeadText & "', [strTailText] = '" & strTailText	& "', [strWidth] = '" & strWidth & "', [strAlign] = '" & strAlign & "', [strSkin] = '" & strSkin & "', [bitUsage] = '" & bitUsage & "', [bitSound] = '" & bitSound & "', [intMemoTime] = '" & intMemoTime & "', [intMemoSaveCount] = '" & intMemoSaveCount & "', [intPageCount] = '" & intPageCount & "' ")

	CASE "REMOVE"

		SET RS = DBCON.EXECUTE("SELECT [strSoundFile] FROM [MPLUS_MEMO_CONFIG] ")
		IF RS("strSoundFile") <> "" AND ISNULL(RS("strSoundFile")) = False THEN CALL ExecFileDelete(strPath, RS("strSoundFile"))
		DBCON.EXECUTE("UPDATE [MPLUS_MEMO_CONFIG] SET [strSoundFile] = '' ")

	END SELECT

	RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "MemoDefaultConfig.asp?strMenu=1", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>