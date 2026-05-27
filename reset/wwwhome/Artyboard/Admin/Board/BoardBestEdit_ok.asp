<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardBestList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<!-- #include file = "../../Include/UploadInclude.asp" -->
<script language="javascript" src="../../Js/valId.js"></script>
<%
	DIM Action, intNum, intSeq, intPage, intPageSize, strSelectGroup, strFileName, strHidden
	
	Action         = REQUEST.QueryString("Action")   : IF Action = "" THEN Action = "EDIT"
	intNum         = REQUEST.QueryString("intNum")
	intSeq         = REQUEST.QueryString("intSeq")
	strSelectGroup = REQUEST.QueryString("strSelectGroup")
	intPage        = REQUEST.QueryString("intPage")
	intPageSize    = REQUEST.QueryString("intPageSize")

	SELECT CASE UCASE(Action)
	CASE "EDIT"
	
		strCode      = UPLOAD("strCode")
		intStep      = UPLOAD("intStep")
		bitUsage     = UPLOAD("bitUsage")
		bitMemoInfo  = UPLOAD("bitMemoInfo")
		strFontColor = GetReplaceInput(UPLOAD("strFontColor"),"")
		bitBold      = UPLOAD("bitBold")
		IF bitBold = "" THEN bitBold = "0"
	
		SET theField = UPLOAD("strFileName")(1)
	
		IF checkImageFileField(setUploadComponet, theField) = True THEN
			strFileName = ExecFIleUpload(setUploadComponet, theField, 1048576, rootPath & "Pds\Main\", "", False, "", False, 0, 0, False, "0", False, "0", "")
			IF strFileName <> False THEN DBCON.EXECUTE("UPDATE [MPLUS_BOARD_NOTICE_LIST] SET [strFileName] = '" & strFileName & "', [intImgWidth] = '" & theField.ImageWidth & "', [intImgHeight] = '" & theField.ImageHeight & "' WHERE [intNum] = '" & intNum & "' ")
		END IF

		DBCON.EXECUTE("UPDATE [MPLUS_BOARD_NOTICE_LIST] SET [strCode] = '" & strCode & "', [intStep] = '" & intStep & "', [bitUsage] = '" & bitUsage & "', [bitMemoInfo] = '" & bitMemoInfo & "', [strFontColor] = '" & strFontColor & "', [bitBold] = '" & bitBold & "' WHERE [intNum] = '" & intNum & "' ")

		IF bitMemoInfo = "1" THEN
			
			DIM strSmallSubject, strSMallContent
			
			strSmallSubject = GetReplaceInput(UPLOAD("strSmallSubject"), "")
			strSMallContent = GetReplaceInput(UPLOAD("strSMallContent"), "")

			DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [strSmallSubject] = '" & strSmallSubject & "', [strSMallContent] = '" & strSMallContent & "' WHERE [intSeq] = '" & intSeq & "' ")

		END IF
	
		RESPONSE.WRITE ExecJavaAlertLayer("수정이 완료되었습니다.", "BoardBestList.asp?intPage=" & intPage & "&intPageSize=" & intPageSize & "&strSelectGroup=" & strSelectGroup)
		RESPONSE.End()

	CASE "REMOVE"
		
		SET RS = DBCON.EXECUTE("SELECT [strFileName] FROM [MPLUS_BOARD_NOTICE_LIST] WHERE [intNum] = '" & REQUEST.QueryString("intNum") & "' ")
		IF RS("strFileName") <> "" AND ISNULL(RS("strFileName")) = False THEN CALL ExecFileDelete(rootPath & "Pds\Main\", RS("strFileName"))

		DBCON.EXECUTE("UPDATE [MPLUS_BOARD_NOTICE_LIST] SET [strFileName] = '' WHERE [intNum] = '" & REQUEST.QueryString("intNum") & "' ")

		RESPONSE.WRITE ExecFormSubmit("이미지 삭제가 완료되었습니다.", "BoardBestEdit.asp?intNum=" & REQUEST.QueryString("intNum") & "&intPage=" & intPage & "&intPageSize=" & intPageSize & "&strSelectGroup=" & strSelectGroup, "")
		RESPONSE.End()

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>