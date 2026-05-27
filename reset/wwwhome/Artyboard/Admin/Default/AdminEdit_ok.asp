<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Default/AdminEdit.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<!-- #include file = "../../Include/UploadInclude.asp" -->
<%
	DIM strPath
	strPath = rootPath & "Pds\Member\"

	SELECT CASE UCASE(REQUEST.QueryString("Action"))
	CASE "EDIT"

		DIM strLoginID, strLoginName, strLoginPwd, strEmail, strHomepage, strNick

		strLoginID   = GetReplaceInput(UPLOAD("strLoginID"),"")
		strLoginName = GetReplaceInput(UPLOAD("strLoginName"), "")
		strLoginPwd  = GetReplaceInput(UPLOAD("strLoginPwd"), "")
		strEmail     = GetReplaceInput(UPLOAD("strEmail"), "")
		strHomepage  = GetReplaceInput(UPLOAD("strHomepage"), "")
		strNick      = GetReplaceInput(UPLOAD("strNick"), "")
		strUserSign  = GetReplaceInput(UPLOAD("strUserSign"), "")

		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strLoginPwd] = '" & strLoginPwd & "', [strLoginName] = '" & strLoginName & "', [strEmail] = '" & strEmail & "', [strHomepage] = '" & strHomepage & "', [strNick] = '" & strNick & "', [strUserSign] = '" & strUserSign & "', [bitMailing] = '0' WHERE [strLoginID] = '" & strLoginID & "' ")
		
		DIM theField1, theField2
		SET theField1 = UPLOAD("strPhotoFile")(1)
		SET theField2 = UPLOAD("strNameFile")(1)
	
		DIM strFileName1, strFileName2
	
		IF checkImageFileField(setUploadComponet, theField1) = True THEN
			strFileName1 = ExecFIleUpload(setUploadComponet, theField1, 1048576, strPath & "Photo\", "", False, "", False, 0, 0, False, "0", False, "0", "")
		END IF

'ExecFIleUpload(setUploadComponet, strFileField, intUploadSize, strPath, strUploadNotFile, bitUploadReplaceFile, strUploadReplaceFile, bitThrum, intThrumWidth, intThrumHeight, bitThrumScale, strThrumProg, bitUseWaterMark, strWaterMarkType, strWaterMarkCont)


		IF checkImageFileField(setUploadComponet, theField2) = True THEN
			strFileName2 = ExecFIleUpload(setUploadComponet, theField2, 1048576, strPath & "Name\", "", False, "", False, 0, 0, False, "0", False, "0", "")
		END IF
	
		IF strFileName1 = False THEN strFileName1 = ""
		IF strFileName2 = False THEN strFileName2 = ""
	
		IF strFileName1 <> "" AND ISNULL(strFileName1) = False THEN
			SET RS = DBCON.EXECUTE("SELECT [strPhotoFile] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & strLoginID & "' ")
			IF RS("strPhotoFile") <> "" AND ISNULL(RS("strPhotoFile")) = False THEN CALL ExecFileDelete(strPath & "Photo\", RS("strPhotoFile"))
			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strPhotoFile] = '" & strFileName1 & "' WHERE [strLoginID] = '" & strLoginID & "' ")
		END IF
	
		IF strFileName2 <> "" AND ISNULL(strFileName2) = False THEN
			SET RS = DBCON.EXECUTE("SELECT [strNameFile] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & strLoginID & "' ")
			IF RS("strNameFile") <> "" AND ISNULL(RS("strNameFile")) = False THEN CALL ExecFileDelete(strPath & "Name\", RS("strNameFile"))
			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strNameFile] = '" & strFileName2 & "' WHERE [strLoginID] = '" & strLoginID & "' ")
		END IF
	
		RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "AdminEdit.asp", "")
		RESPONSE.End()

	CASE "REMOVE"

		SELECT CASE REQUEST.QueryString("intFile")
		CASE "1"

			SET RS = DBCON.EXECUTE("SELECT [strPhotoFile] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & UPLOAD("strLoginID") & "' ")
			IF RS("strPhotoFile") <> "" AND ISNULL(RS("strPhotoFile")) = False THEN CALL ExecFileDelete(strPath & "Photo\", RS("strPhotoFile"))
			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strPhotoFile] = '' WHERE [strLoginID] = '" & UPLOAD("strLoginID") & "' ")

		CASE "2"

			SET RS = DBCON.EXECUTE("SELECT [strNameFile] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & UPLOAD("strLoginID") & "' ")
			IF RS("strNameFile") <> "" AND ISNULL(RS("strNameFile")) = False THEN CALL ExecFileDelete(strPath & "Name\", RS("strNameFile"))
			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strNameFile] = '' WHERE [strLoginID] = '" & UPLOAD("strLoginID") & "' ")

		END SELECT

		RESPONSE.WRITE ExecFormSubmit("이미지 삭제가 정상적으로 처리되었습니다.", "AdminEdit.asp", "")
		RESPONSE.End()

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>