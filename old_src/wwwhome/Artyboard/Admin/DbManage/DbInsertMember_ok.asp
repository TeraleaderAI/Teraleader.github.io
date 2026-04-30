<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "DbManage/DbInsertMember.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	RESPONSE.EXPIRES     = 0
	SERVER.SCRIPTTIMEOUT = 2000
%>
<!-- #include file = "../../Include/UploadInclude.asp" -->
<%
	DIM theField, strUploadFile

	SET theField = UPLOAD("strFileName")(1)

	IF checkExcelFileField(setUploadComponet, theField) = False THEN
		RESPONSE.WRITE ExecJavaAlert("엑셀 파일만 가능합니다.", 0)
		RESPONSE.End()
	END IF

	strUploadFile = ExecFileUpload(setUploadComponet, theField, 104857600, rootPath & "Pds\", "", False, "", False, 0, 0, False, "0", False, "0", "")

	IF strUploadFile = False THEN
		RESPONSE.WRITE ExecJavaAlert("파일 업로드가 실패되었습니다.", 0)
		RESPONSE.End()
	END IF

	FileName = rootPath & "Pds\" & strUploadFile

	SET UPLOAD = NOTHING

	set xlsConn = Server.CreateObject("ADODB.connection")
	xlsConnection = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & FileName & "; Extended Properties=Excel 8.0;"
	
	xlsConn.Open xlsConnection
	
	SET xlsRs = Server.CreateObject("ADODB.RecordSet")
	xlsRs.Open "SELECT * FROM [Sheet1$] ", xlsConn

	DIM OnErrorMsg, I, sCount

	ON ERROR RESUME NEXT

	WHILE NOT(xlsRs.EOF)

		OnErrorMsg = ""
	
		intNum            = GetReplaceInput(xlsRs("intNum"),"")
		strLoginID        = GetReplaceInput(xlsRs("strLoginID"),"")
		strGroup          = GetReplaceInput(xlsRs("strGroup"),"")
		strLoginPwd       = GetReplaceInput(xlsRs("strLoginPwd"),"")
		strLoginName      = GetReplaceInput(xlsRs("strLoginName"),"")
		strEmail          = GetReplaceInput(xlsRs("strEmail"),"")
		bitMailing        = GetReplaceInput(xlsRs("bitMailing"),"")
		strSSN            = GetReplaceInput(xlsRs("strSSN"),"")
		strBirthday       = GetReplaceInput(xlsRs("strBirthday"),"")
		strNick           = GetReplaceInput(xlsRs("strNick"),"")
		strIcq            = GetReplaceInput(xlsRs("strIcq"),"")
		strMsn            = GetReplaceInput(xlsRs("strMsn"),"")
		strHomepage       = GetReplaceInput(xlsRs("strHomepage"),"")
		strHomePost       = GetReplaceInput(xlsRs("strHomePost"),"")
		strHomeAddr1      = GetReplaceInput(xlsRs("strHomeAddr1"),"")
		strHomeAddr2      = GetReplaceInput(xlsRs("strHomeAddr2"),"")
		strHomeTel        = GetReplaceInput(xlsRs("strHomeTel"),"")
		strMobile         = GetReplaceInput(xlsRs("strMobile"),"")
		strCompPost       = GetReplaceInput(xlsRs("strCompPost"),"")
		strCompAddr1      = GetReplaceInput(xlsRs("strCompAddr1"),"")
		strCompAddr2      = GetReplaceInput(xlsRs("strCompAddr2"),"")
		strCompTel        = GetReplaceInput(xlsRs("strCompTel"),"")
		strJob            = GetReplaceInput(xlsRs("strJob"),"")
		strJobLevel       = GetReplaceInput(xlsRs("strJobLevel"),"")
		strHobby          = GetReplaceInput(xlsRs("strHobby"),"")
		strMarry          = GetReplaceInput(xlsRs("strMarry"),"")
		strJoinMemo       = GetReplaceInput(xlsRs("strJoinMemo"),"")
		strPhotoFile      = GetReplaceInput(xlsRs("strPhotoFile"),"")
		strNameFile       = GetReplaceInput(xlsRs("strNameFile"),"")
		strMemo           = GetReplaceInput(xlsRs("strMemo"),"")
		bitUserInfo       = GetReplaceInput(xlsRs("bitUserInfo"),"")
		strRecLoginID     = GetReplaceInput(xlsRs("strRecLoginID"),"")
		strMemberAdd1     = GetReplaceInput(xlsRs("strMemberAdd1"),"")
		strMemberAdd2     = GetReplaceInput(xlsRs("strMemberAdd1"),"")
		strMemberAdd3     = GetReplaceInput(xlsRs("strMemberAdd1"),"")
		strMemberAdd4     = GetReplaceInput(xlsRs("strMemberAdd1"),"")
		strMemberAdd5     = GetReplaceInput(xlsRs("strMemberAdd1"),"")
		strMemberAdd6     = GetReplaceInput(xlsRs("strMemberAdd1"),"")
		strMemberAdd7     = GetReplaceInput(xlsRs("strMemberAdd1"),"")
		strMemberAdd8     = GetReplaceInput(xlsRs("strMemberAdd1"),"")
		strMemberAdd9     = GetReplaceInput(xlsRs("strMemberAdd1"),"")
		strMemberAdd10    = GetReplaceInput(xlsRs("strMemberAdd1"),"")
		bitAuth           = GetReplaceInput(xlsRs("bitAuth"),"")
		intVisit          = GetReplaceInput(xlsRs("intVisit"),"")
		intPoint          = GetReplaceInput(xlsRs("intPoint"),"")
		intBoardCount     = GetReplaceInput(xlsRs("intBoardCount"),"")
		intCommentCount   = GetReplaceInput(xlsRs("intCommentCount"),"")
		intVote           = GetReplaceInput(xlsRs("intVote"),"")
		strAdmin          = GetReplaceInput(xlsRs("strAdmin"),"")
		dateSignDate      = GetReplaceInput(xlsRs("dateSignDate"),"")
		strSignIP         = GetReplaceInput(xlsRs("strSignIP"),"")
		strSido           = GetReplaceInput(xlsRs("strSido"),"")
		bitSecession      = GetReplaceInput(xlsRs("bitSecession"),"")
		strSecessionMemo  = GetReplaceInput(xlsRs("strSecessionMemo"),"")
		dateSecessionDate = GetReplaceInput(xlsRs("dateSecessionDate"),"")
		dateRegDate       = GetReplaceInput(xlsRs("dateRegDate"),"")

		DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_LIST] ([strLoginID], [strGroup], [strLoginPwd], [strLoginName], [strEmail], [bitMailing], [strSSN], [strBirthday], [strNick], [strIcq], [strMsn], [strHomepage], [strHomePost], [strHomeAddr1], [strHomeAddr2], [strHomeTel], [strMobile], [strCompPost], [strCompAddr1], [strCompAddr2], [strCompTel], [strJob], [strJobLevel], [strHobby], [strMarry], [strJoinMemo], [strPhotoFile], [strNameFile], [strMemo], [bitUserInfo], [strRecLoginID], [strMemberAdd1], [strMemberAdd2], [strMemberAdd3], [strMemberAdd4], [strMemberAdd5], [strMemberAdd6], [strMemberAdd7], [strMemberAdd8], [strMemberAdd9], [strMemberAdd10], [bitAuth], [intVisit], [intPoint], [intBoardCount], [intCommentCount], [intVote], [strAdmin], [dateSignDate], [strSignIP], [strSido], [bitSecession], [strSecessionMemo], [dateSecessionDate], [dateRegDate]) VALUES ('" & strLoginID & "', '" & strGroup & "', '" & strLoginPwd & "', '" & strLoginName & "', '" & strEmail & "', '" & bitMailing & "', '" & strSSN & "', '" & strBirthday & "', '" & strNick & "', '" & strIcq & "', '" & strMsn & "', '" & strHomepage & "', '" & strHomePost & "', '" & strHomeAddr1 & "', '" & strHomeAddr2 & "', '" & strHomeTel & "', '" & strMobile & "', '" & strCompPost & "', '" & strCompAddr1 & "', '" & strCompAddr2 & "', '" & strCompTel & "', '" & strJob & "', '" & strJobLevel & "', '" & strHobby & "', '" & strMarry & "', '" & strJoinMemo & "', '" & strPhotoFile & "', '" & strNameFile & "', '" & strMemo & "', '" & bitUserInfo & "', '" & strRecLoginID & "', '" & strMemberAdd1 & "', '" & strMemberAdd2 & "', '" & strMemberAdd3 & "', '" & strMemberAdd4 & "', '" & strMemberAdd5 & "', '" & strMemberAdd6 & "', '" & strMemberAdd7 & "', '" & strMemberAdd8 & "', '" & strMemberAdd9 & "', '" & strMemberAdd10 & "', '" & bitAuth & "', '" & intVisit & "', " & intPoint & ", '" & intBoardCount & "', '" & intCommentCount & "', '" & intVote & "', '" & strAdmin & "', '" & dateSignDate & "', '" & strSignIP & "', '" & strSido & "', '" & bitSecession & "', '" & strSecessionMemo & "', '" & dateSecessionDate & "', '" & dateRegDate & "') ")

	xlsRs.MOVENEXT
	WEND

	IF err.Number <> 0 THEN
		RESPONSE.WRITE "<script language=javascript>" & vbcrlf
		RESPONSE.WRITE "alert(""오류가 발생되었습니다.\n\n오류 DB [intNum] : " & intNum & "\n\nERR:" & err.Number & ":" & err.Description & """);" & vbcrlf
		RESPONSE.WRITE "history.back(-1);" & vbcrlf
		RESPONSE.wRITE "</script>" & vbcrlf
		RESPONSE.End()
	END IF

	xlsConn.CLOSE : SET xlsRs = NOTHING

	CALL ExecFileDelete(rootPath & "Pds\",  strUploadFile)

	RESPONSE.WRITE ExecFormSubmit("회원DB 등록이 정상적으로 처리되었습니다.", "DbTableList_Excel.asp", "")
	RESPONSE.End()
	
	FUNCTION GetCheckLength(str, intLength)

		IF INT(LEN(str)) > INT(intLength) THEN
			GetCheckLength = False
		ELSE
			GetCheckLength = True
		END IF

	END FUNCTION
%>