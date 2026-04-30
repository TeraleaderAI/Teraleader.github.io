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
<!-- #include file = "../../Include/UploadInclude.asp" -->
<%
	DIM strBoardID, strWriteDefault, bitUseLink1, bitUseLink2, bitUseReple, strReplePreview, bitUseSecret, bitUseSecretReple
	DIM bitUseRepleMail, bitUseWriteAdminMail, strWriteMailList, bitUseEditor, strEditorWidth, strEditorHeight, bitEditorSource
	DIM bitEditorPrev, strEditorBgColor, bitEditorZoom, intEditorZoomSize1, intEditorZoomSize2, bitEditorHostName, strWriteOkLink
	DIM strWriteCustLink, bitWriteAdmin, bitWriteAdminMsg, bitUseCaptcha, strBadContent, strBadContentReplace, strBadContentMsg
	DIM strBadContentList, bitAdminContent, strAdminContentMsg, strAdminContentList, bitUseUpload, intUploadCount
	DIM bitUseUploadLarge, bitUploadAdmin, intUploadSize, strUploadNotFile, bitUploadReplaceFile, strUploadReplaceFile
	DIM bitThrum, intThrumWidth, intThrumHeight, bitThrumScale, strThrumProg, bitUseWaterMark, strWaterMarkType
	DIM strWaterMarkCont, bitUseExif

	strBoardID           = UPLOAD("strBoardID")
	strWriteDefault      = GetReplaceInput(UPLOAD("strWriteDefault"), "")
	bitUseLink1          = UPLOAD("bitUseLink1")
	bitUseLink2          = UPLOAD("bitUseLink2")
	bitUseReple          = UPLOAD("bitUseReple")
	strReplePreview      = GetReplaceInput(UPLOAD("strReplePreview"), "")
	bitUseSecret         = UPLOAD("bitUseSecret")
	bitUseSecretReple    = UPLOAD("bitUseSecretReple")
	bitUseRepleMail      = UPLOAD("bitUseRepleMail")
	bitUseWriteAdminMail = GetReplaceInput(UPLOAD("bitUseWriteAdminMail"), "")
	strWriteMailList     = UPLOAD("strWriteMailList")
	bitUseEditor         = UPLOAD("bitUseEditor")
	strEditorWidth       = GetReplaceInput(UPLOAD("strEditorWidth"), "")
	strEditorHeight      = GetReplaceInput(UPLOAD("strEditorHeight"), "")
	bitEditorSource      = UPLOAD("bitEditorSource")
	bitEditorPrev        = UPLOAD("bitEditorPrev")
	strEditorBgColor     = UPLOAD("strEditorBgColor")
	bitEditorZoom        = UPLOAD("bitEditorZoom")
	intEditorZoomSize1   = UPLOAD("intEditorZoomSize1")
	intEditorZoomSize2   = UPLOAD("intEditorZoomSize2")
	bitEditorHostName    = UPLOAD("bitEditorHostName")
	strWriteOkLink       = GetReplaceInput(UPLOAD("strWriteOkLink"), "")
	strWriteCustLink     = GetReplaceInput(UPLOAD("strWriteCustLink"), "")
	bitWriteAdmin        = UPLOAD("bitWriteAdmin")
	bitWriteAdminMsg     = GetReplaceInput(UPLOAD("bitWriteAdminMsg"), "")
	bitUseCaptcha        = UPLOAD("bitUseCaptcha")
	strBadContent        = GetReplaceInput(UPLOAD("strBadContent"), "")
	strBadContentReplace = GetReplaceInput(UPLOAD("strBadContentReplace"), "")
	strBadContentMsg     = GetReplaceInput(UPLOAD("strBadContentMsg"), "")
	strBadContentList    = GetReplaceInput(UPLOAD("strBadContentList"), "")
	bitAdminContent      = UPLOAD("bitAdminContent")
	strAdminContentMsg   = GetReplaceInput(UPLOAD("strAdminContentMsg"), "")
	strAdminContentList  = GetReplaceInput(UPLOAD("strAdminContentList"), "")
	bitUseUpload         = UPLOAD("bitUseUpload")
	intUploadCount       = UPLOAD("intUploadCount")
	bitUseUploadLarge    = UPLOAD("bitUseUploadLarge")
	bitUploadAdmin       = UPLOAD("bitUploadAdmin")
	intUploadSize        = UPLOAD("intUploadSize")
	strUploadNotFile     = GetReplaceInput(UPLOAD("strUploadNotFile"), "")
	bitUploadReplaceFile = UPLOAD("bitUploadReplaceFile")
	strUploadReplaceFile = GetReplaceInput(UPLOAD("strUploadReplaceFile"), "")
	bitThrum             = UPLOAD("bitThrum")
	intThrumWidth        = UPLOAD("intThrumWidth")
	intThrumHeight       = UPLOAD("intThrumHeight")
	bitThrumScale        = UPLOAD("bitThrumScale")
	strThrumProg         = UPLOAD("strThrumProg")
	bitUseWaterMark      = UPLOAD("bitUseWaterMark")
	strWaterMarkType     = UPLOAD("strWaterMarkType")
	strWaterMarkCont     = strBoardID & "|"
	bitUseExif           = UPLOAD("bitUseExif")

	DIM theField, strPath
	SET theField = UPLOAD("strFileName")(1)

	strPath = rootPath & "Pds\Board\" & strBoardID & "\WaterMark\"

	CALL ExecFolderMake(rootPath & "Pds\Board\" & strBoardID & "WaterMark")

	DIM strFileName
	IF checkImageFileField(setUploadComponet, theField) = True THEN
		strFileName = ExecFIleUpload(setUploadComponet, theField, 10485760, strPath, "", False, "", False, 0, 0, False, "0", False, "0", "")
		IF strFileName = False THEN strFileName = ""
	ELSE
		strFileName = UPLOAD("strPrevWaterMarkFile")
	END IF

	strWaterMarkCont = strWaterMarkCont & strFileName & "|"

	strWaterMarkCont = strWaterMarkCont & REPLACE(GetReplaceInput(UPLOAD("strMarkText"), ""), "|", "") & "|" & UPLOAD("intMarkX") & "|" & UPLOAD("intMarkY") & "|" & UPLOAD("intMarkFont")

	IF intEditorZoomSize1 = 0 OR intEditorZoomSize1 = "" THEN intEditorZoomSize1 = 500
	IF intEditorZoomSize2 = 0 OR intEditorZoomSize2 = "" THEN intEditorZoomSize2 = 500

	DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CONFIG_WRITE] SET [strWriteDefault] = '" & strWriteDefault & "', [bitUseLink1] = '" & bitUseLink1 & "', [bitUseLink2] = '" & bitUseLink2 & "', [bitUseReple] = '" & bitUseReple & "', [strReplePreview] = '" & strReplePreview & "', [bitUseSecret] = '" & bitUseSecret & "', [bitUseSecretReple] = '" & bitUseSecretReple & "', [bitUseRepleMail] = '" & bitUseRepleMail & "', [bitUseWriteAdminMail] = '" & bitUseWriteAdminMail & "', [strWriteMailList] = '" & strWriteMailList & "', [bitUseEditor] = '" & bitUseEditor & "', [strEditorWidth] = '" & strEditorWidth & "', [strEditorHeight] = '" & strEditorHeight & "', [bitEditorSource] = '" & bitEditorSource & "', [bitEditorPrev] = '" & bitEditorPrev & "', [strEditorBgColor] = '" & strEditorBgColor & "', [bitEditorZoom] = '" & bitEditorZoom & "', [intEditorZoomSize] = '" & intEditorZoomSize1 & "|" & intEditorZoomSize2 & "', [bitEditorHostName] = '" & bitEditorHostName & "', [strWriteOkLink] = '" & strWriteOkLink & "', [strWriteCustLink] = '" & strWriteCustLink & "', [bitWriteAdmin] = '" & bitWriteAdmin & "', [bitWriteAdminMsg] = '" & bitWriteAdminMsg & "', [bitUseCaptcha] = '" & bitUseCaptcha & "', [strBadContent] = '" & strBadContent & "', [strBadContentReplace] = '" & strBadContentReplace & "', [strBadContentMsg] = '" & strBadContentMsg & "', [strBadContentList] = '" & strBadContentList & "', [bitAdminContent] = '" & bitAdminContent & "', [strAdminContentMsg] = '" & strAdminContentMsg & "', [strAdminContentList] = '" & strAdminContentList & "', [bitUseUpload] = '" & bitUseUpload & "', [intUploadCount] = '" & intUploadCount & "', [bitUseUploadLarge] = '" & bitUseUploadLarge & "', [bitUploadAdmin] = '" & bitUploadAdmin & "', [intUploadSize] = '" & intUploadSize & "', [strUploadNotFile] = '" & strUploadNotFile & "', [bitUploadReplaceFile] = '" & bitUploadReplaceFile & "', [strUploadReplaceFile] = '" & strUploadReplaceFile & "', [bitThrum] = '" & bitThrum & "', [intThrumWidth] = '" & intThrumWidth & "', [intThrumHeight] = '" & intThrumHeight & "', [bitThrumScale] = '" & bitThrumScale & "', [strThrumProg] = '" & strThrumProg & "', [bitUseWaterMark] = '" & bitUseWaterMark & "', [strWaterMarkType] = '" & strWaterMarkType & "', [strWaterMarkCont] = '" & strWaterMarkCont & "', [bitUseExif] = '" & bitUseExif & "' WHERE [strBoardID] = '" & strBoardID & "' ")

	RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "BoardWriteConfig.asp?strBoardID=" & strBoardID, "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>