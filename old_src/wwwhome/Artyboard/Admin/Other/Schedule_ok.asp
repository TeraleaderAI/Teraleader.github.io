<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Other/ScheduleList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<!-- #include file = "../../Include/UploadInclude.asp" -->
<%
	RESPONSE.EXPIRES     = 0
	SERVER.SCRIPTTIMEOUT = 2000

	DIM Action, intSeq, strPath, strMsg
	Action  = UCASE(REQUEST.QueryString("Action"))
	intSeq  = REQUEST.QueryString("intSeq")
	strPath = rootPath & "Pds\Schedule\"

	DIM strScYear, strScMonth, strScDay, intHour, intMinute, strSubject, strContent, strFilename1, strFilename2, strFilename3
	DIM intFileSize1, intFileSize2, intFileSize3

	SELECT CASE Action
	CASE "ADD", "EDIT"

		strScYear  = GetReplaceInput(UPLOAD("strScYear"),"")
		strScMonth = GetReplaceInput(UPLOAD("strScMonth"),"")
		strScDay   = GetReplaceInput(UPLOAD("strScDay"),"")
		intHour    = UPLOAD("intHour")
		intMinute  = UPLOAD("intMinute")
		strSubject = GetReplaceInput(UPLOAD("strSubject"), "")
		strContent = GetReplaceInput(UPLOAD("strContent"), "")

		IF LEN(strScMonth) = 1 THEN strScMonth = "0" & strScMonth
		IF LEN(strScDay)   = 1 THEN strScDay   = "0" & strScDay
		IF LEN(intHour)    = 1 THEN intHour    = "0" & intHour
		IF LEN(intMinute)  = 1 THEN intMinute  = "0" & intMinute

		IF Action = "EDIT" THEN

			SET RS = DBCON.EXECUTE("SELECT [strFileName1], [strFileName2], [strFileName3] FROM [MPLUS_SCHEDULE] WHERE [intSeq] = '" & intSeq & "' ")
	
			IF UPLOAD("bitFileDelete1") = "1" THEN
				CALL ExecFileDelete(strPath, RS("strFileName1"))
				DBCON.EXECUTE("UPDATE [MPLUS_SCHEDULE] SET [strFileName1] = '', [intFileSize1] = 0 WHERE [intSeq] = '" & intSeq & "' ")
			END IF
	
			IF UPLOAD("bitFileDelete2") = "1" THEN
				CALL ExecFileDelete(strPath, RS("strFileName2"))
				DBCON.EXECUTE("UPDATE [MPLUS_SCHEDULE] SET [strFileName2] = '', [intFileSize2] = 0 WHERE [intSeq] = '" & intSeq & "' ")
			END IF
	
			IF UPLOAD("bitFileDelete3") = "1" THEN
				CALL ExecFileDelete(strPath, RS("strFileName3"))
				DBCON.EXECUTE("UPDATE [MPLUS_SCHEDULE] SET [strFileName3] = '', [intFileSize3] = 0 WHERE [intSeq] = '" & intSeq & "' ")
			END IF

		END IF

		DIM theField1, theField2, theField3

		SET theField1 = UPLOAD("strFileName1")(1)
		SET theField2 = UPLOAD("strFileName2")(1)
		SET theField3 = UPLOAD("strFileName3")(1)

		strFileName1 = ExecFIleUpload(setUploadComponet, theField1, 31457280, strPath, "", False, "", False, 0, 0, False, "0", False, "0", "")
		strFileName2 = ExecFIleUpload(setUploadComponet, theField2, 31457280, strPath, "", False, "", False, 0, 0, False, "0", False, "0", "")
		strFileName3 = ExecFIleUpload(setUploadComponet, theField3, 31457280, strPath, "", False, "", False, 0, 0, False, "0", False, "0", "")

		IF strFileName1 = False THEN
			strFileName1 = ""
		ELSE
			intFileSize1 = ExecFIleUploadSize(setUploadComponet, theField1)
			IF Action = "EDIT" THEN DBCON.EXECUTE("UPDATE [MPLUS_SCHEDULE] SET [strFileName1] = '" & strFileName1 & "', [intFileSize1] = '" & intFileSize1 & "' WHERE [intSeq] = '" & intSeq & "' ")
		END IF

		IF strFileName2 = False THEN
			strFileName2 = ""
		ELSE
			intFileSize2 = ExecFIleUploadSize(setUploadComponet, theField2)
			IF Action = "EDIT" THEN DBCON.EXECUTE("UPDATE [MPLUS_SCHEDULE] SET [strFileName2] = '" & strFileName2 & "', [intFileSize2] = '" & intFileSize2 & "' WHERE [intSeq] = '" & intSeq & "' ")
		END IF

		IF strFileName3 = False THEN
			strFileName3 = ""
		ELSE
			intFileSize3 = ExecFIleUploadSize(setUploadComponet, theField3)
			IF Action = "EDIT" THEN DBCON.EXECUTE("UPDATE [MPLUS_SCHEDULE] SET [strFileName3] = '" & strFileName3 & "', [intFileSize3] = '" & intFileSize3 & "' WHERE [intSeq] = '" & intSeq & "' ")
		END IF

		SELECT CASE UCASE(Action)
		CASE "ADD"

			DBCON.EXECUTE("INSERT INTO [MPLUS_SCHEDULE] ([intYear], [intMonth], [intDay], [intHour], [intMinute], [strSubject], [strContent], [strFileName1], [intFileSize1], [strFileName2], [intFileSize2], [strFileName3], [intFileSize3]) VALUES ('" & strScYear & "', '" & strScMonth & "', '" & strScDay & "', '" & intHour & "', '" & intMinute & "', '" & strSubject & "', '" & strContent & "', '" & strFileName1 & "', '" & intFileSize1 & "', '" & strFileName2 & "', '" & intFileSize2 & "', '" & strFileName3 & "', '" & intFileSize3 & "') ")

			strMsg = "일정 등록이 완료되었습니다."

		CASE "EDIT"

			DBCON.EXECUTE("UPDATE [MPLUS_SCHEDULE] SET [intYear] = '" & strScYear & "', [intMonth] = '" & strScMonth & "', [intDay] = '" & strScDay & "', [intHour] = '" & intHour & "', [intMinute] = '" & intMinute & "', [strSubject] = '" & strSubject & "', [strContent] = '" & strContent & "' WHERE [intSeq] = '" & intSeq & "' ")

			strMsg = "일정 수정이 완료되었습니다."

		END SELECT

		RESPONSE.WRITE ExecFormSubmit(strMsg, "ScheduleList.asp?strScYear=" & strScYear & "&strScMonth=" & strScMonth & "&strScDay=" & strScDay, "")
		RESPONSE.End()

	CASE "REMOVE"

		SET RS = DBCON.EXECUTE("SELECT [strFileName1], [strFileName2], [strFileName3] FROM [MPLUS_SCHEDULE] WHERE [intSeq] = '" & intSeq & "' ")
	
		IF RS("strFileName1") <> "" AND ISNULL(RS("strFileName1")) = False THEN CALL ExecFileDelete(strPath, RS("strFileName1"))
		IF RS("strFileName2") <> "" AND ISNULL(RS("strFileName2")) = False THEN CALL ExecFileDelete(strPath, RS("strFileName2"))
		IF RS("strFileName3") <> "" AND ISNULL(RS("strFileName3")) = False THEN CALL ExecFileDelete(strPath, RS("strFileName3"))
	
		DBCON.EXECUTE("DELETE FROM [MPLUS_SCHEDULE] WHERE [intSeq] = '" & intSeq & "' ")

		RESPONSE.WRITE ExecFormSubmit("일정 삭제가 완료되었습니다.", "ScheduleList.asp?strScYear=" & REQUEST.QueryString("strScYear") & "&strScMonth=" & REQUEST.QueryString("strScMonth") & "&strScDay=" & REQUEST.QueryString("strScDay"), "")
		RESPONSE.End()

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>