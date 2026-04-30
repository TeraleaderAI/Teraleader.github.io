<!-- #include file = "../DBConnect/DBconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM strBoardID, intSeq, intNum, upload_strLoginID, upload_strPwd, bitFileDelete, strFileCode, strPassword, strLoginID

	strBoardID        = REQUEST.QueryString("strBoardID")
	intSeq            = REQUEST.QueryString("intSeq")
	intNum            = REQUEST.QueryString("intNum")
	upload_strLoginID = REQUEST.FORM("upload_strLoginID")
	upload_strPwd     = REQUEST.FORM("upload_strPwd")
	bitFileDelete     = False

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_READ_DEFAULT] '" & intSeq & "' ")

	strFileCode = RS("strFileCode")
	strPassword = RS("strPassword")
	strLoginID  = RS("strLoginID")

	IF upload_strLoginID = "" THEN
		IF upload_strPwd = strPassword THEN bitFileDelete = True ELSE bitFileDelete = False
	ELSE
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '" & strBoardID & "', '" & upload_strLoginID & "' ")
		IF GetAdminCheck(upload_strLoginID, RS("strAdmin"), SESSION("strAdmin")) = True THEN
			bitFileDelete = True
		ELSE
			IF strLoginID = upload_strLoginID THEN bitFileDelete = True ELSE bitFileDelete = False
		END IF
	END IF

	IF bitFileDelete = True THEN

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_FILE] '" & intNum & "', '0' ")
		CALL ExecFileDelete(rootPath & "Pds\Board\" & strBoardID & "\", RS("strFileName"))
		CALL ExecFileDelete(rootPath & "Pds\Board\" & strBoardID & "\Small\", RS("strFileName"))
		CALL ExecFileDelete(rootPath & "Pds\Board\" & strBoardID & "\Thrum\", RS("strFileName"))
		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_FILE] WHERE [intNum] = '" & intNum & "' ")

		RESPONSE.WRITE "<script language=javascript>" & vbcrlf
		RESPONSE.WRITE "	var obj = parent.document.theForm.strFileList;" & vbcrlf
		RESPONSE.WRITE "	for (var i = obj.length - 1; i > -1; i--){" & vbcrlf
		RESPONSE.WRITE "		obj.options[i].value = null;" & vbcrlf
		RESPONSE.WRITE "		obj.options[i] = null;" & vbcrlf
		RESPONSE.WRITE "	}" & vbcrlf

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_FILE] '" & strFileCode & "', '' ")

		DIM intNowUploadSize
		intNowUploadSize = 0

		WHILE NOT(RS.EOF)
			intNowUploadSize = intNowUploadSize + RS("intFileSize")
			RESPONSE.WRITE "	var oOption = parent.document.createElement(""OPTION"");" & vbcrlf
			RESPONSE.WRITE "	oOption.text = """ & RS("strFileName") & " - " & GetFilesize(RS("intFileSize")) & """;" & vbcrlf
			RESPONSE.WRITE "	oOption.value = """ & RS("intNum") & "," & RS("strFileName") & """;" & vbcrlf
			RESPONSE.WRITE "	obj.add(oOption);" & vbcrlf
		RS.MOVENEXT
		WEND

		IF intNowUploadSize > 0 THEN intNowUploadSize = ROUND(intNowUploadSize / 1048576, 1)

		DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [intFileCount] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_FILE] WHERE [strFileCode] = '" & strFileCode & "'), [intImgCount] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_FILE] WHERE [strFileCode] = '" & strFileCode & "' AND [intFileType] = '0') WHERE [intSeq] = '" & intSeq & "' ")

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_WRITE] '" & strBoardID & "' ")

		IF RS("bitUseUploadLarge") = True THEN
			RESPONSE.WRITE "parent.chxUpload.location.href=""../Library/chxupload/chxUpload.asp?strBoardID=" & strBoardID & "&strSessionID=" & SESSION.SESSIONID & "&intUploadSize=" & RS("intUploadSize") & "&intNowUploadSize=" & intNowUploadSize & "&intUploadCount=" & RS("intUploadCount") & """;"
			RESPONSE.WRITE "parent.document.all['uploadedSize'].innerHTML = '" & intNowUploadSize & "';" & vbcrlf
		END IF

		RESPONSE.WRITE "</script>" & vbcrlf
		RESPONSE.End()

	ELSE
		RESPONSE.WRITE ExecJavaAlert("비밀번호가 일치하지 않거나 올바른 접근방식이 아닙니다.", 0)
		RESPONSE.End()
	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>