<!--METADATA TYPE="typelib" NAME="ADODB Type Library" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"-->
<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "Dbconnect/Dbconnect.asp" -->
<!-- #include file = "Library/Function.asp" -->
<%
	RESPONSE.EXPIRES     = 0
	SERVER.SCRIPTTIMEOUT = 2000

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_JOIN] ")
	
	DIM strJoinType, bitJoinEmailActivate, strDefaultGroupCode, bitJoinResult, strJoinMsg, strJoinScript, strJoinUrl
	DIM strJoinUrlTarget, strEditMsg, strEditScript, strEditUrl, strEditUrlTarget, intJoinPoint, intRecPoint, bitJoinEmail
	strJoinType          = RS("strJoinType")
	bitJoinEmailActivate = RS("bitJoinEmailActivate")
	strDefaultGroupCode  = RS("strDefaultGroupCode")
	intJoinPoint         = RS("intJoinPoint")
	intRecPoint          = RS("intRecPoint")
	bitJoinEmail         = RS("bitJoinEmail")
	bitJoinResult        = RS("bitJoinResult")
	strJoinMsg           = RS("strJoinMsg")
	strJoinScript        = RS("strJoinScript")
	strJoinUrl           = RS("strJoinUrl")
	strJoinUrlTarget     = RS("strJoinUrlTarget")
	strEditMsg           = RS("strEditMsg")
	strEditScript        = RS("strEditScript")
	strEditUrl           = RS("strEditUrl")
	strEditUrlTarget     = RS("strEditUrlTarget")

	DIM bitIdCheck, bitEmailCheck, bitSsnCheck, bitRecIdCheck

	bitIdCheck    = GetReplaceInput(REQUEST.QueryString("bitIdCheck"), "S")
	bitEmailCheck = GetReplaceInput(REQUEST.QueryString("bitEmailCheck"), "S")
	bitSsnCheck   = GetReplaceInput(REQUEST.QueryString("bitSsnCheck"), "S")
	bitRecIdCheck = GetReplaceInput(REQUEST.QueryString("bitRecIdCheck"), "S")

	DIM Action
	Action = UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))
%>
<!-- #include file = "Include/UploadInclude.asp" -->
<%
	DIM strLoginID, strLoginPwd, strLoginName, strEmail, bitMailing, strSSN, strBirthday, strNick, strIcq, strMsn, strHomepage
	DIM strHomePost, strHomeAddr1, strHomeAddr2, strHomeTel, strMobile, strCompPost, strCompAddr1, strCompAddr2, strCompTel
	DIM strJob, strJobLevel, strHobby, strMarry, strJoinMemo, strPhotoFile, strNameFile, strMemo, bitUserInfo, strRecLoginID
	DIM strUserSign, strMemberAdd1, strMemberAdd2, strMemberAdd3, strMemberAdd4, strMemberAdd5, strMemberAdd6, strMemberAdd7
	DIM strMemberAdd8, strMemberAdd9, strMemberAdd10, strSIDO, strCaptchaText

	strLoginID     = GetReplaceInput(UPLOAD("strLoginID"), "")
	strLoginPwd    = GetReplaceInput(UPLOAD("strLoginPwd")(1), "")
	strLoginName   = GetReplaceInput(UPLOAD("strLoginName"), "")
	strEmail       = GetReplaceInput(UPLOAD("strEmail"), "")

	strCaptchaText = GetReplaceInput(UPLOAD("strCaptchaText"), "")

	IF Action = "JOIN" THEN
		IF CheckCAPTCHA(strCaptchaText) = False THEN
			RESPONSE.WRITE ExecJavaAlert("자동 가입 방지를 위한 문자를 잘못 입력하셨습니다.", 0)
			RESPONSE.End()
		END IF
	END IF

	DIM theField1, theField2, bitFileUpload1, bitFileUpload2

	bitFileUpload1 = False
	bitFileUpload2 = False

	SET RS = DBCON.EXECUTE("SELECT [strItem] FROM [MPLUS_MEMBER_CONFIG_JOIN_ITEM] WHERE [intDefault] != '0' AND [bitUse] = '1' ORDER BY [intStep] ASC")

	WHILE NOT(RS.EOF)
		SELECT CASE RS("strItem")
		CASE "bitMailing"    : bitMailing    = UPLOAD("bitMailing")
		CASE "strSSN"        : strSSN        = UPLOAD("strSSN")(1) & UPLOAD("strSSN")(2)
		CASE "strBirthday"   : strBirthday   = UPLOAD("strBirthdayR")
		CASE "strNick"       : strNick       = GetReplaceInput(UPLOAD("strNick"), "")
		CASE "strIcq"        : strIcq        = GetReplaceInput(UPLOAD("strIcq"), "")
		CASE "strMsn"        : strMsn        = GetReplaceInput(UPLOAD("strMsn"), "")
		CASE "strHomepage"   : strHomepage   = GetReplaceInput(UPLOAD("strHomepage"), "")
		CASE "strHomeAddr"
			strHomePost  = UPLOAD("strHomeAddr")(1) & UPLOAD("strHomeAddr")(2)
			strHomeAddr1 = UPLOAD("strHomeAddr")(3)
			strHomeAddr2 = GetReplaceInput(UPLOAD("strHomeAddr")(4), "")
			IF strHomePost <> "" AND ISNULL(strHomePost) = False THEN
				SET RS2 = DBCON.EXECUTE("SELECT [SIDO] FROM [post2005] WHERE [ZIPCODE] = '" & LEFT(strHomePost, 3) & "-" & RIGHT(strHomePost, 3) & "' ")
				strSIDO = RS2("SIDO")
			END IF
		CASE "strHomeTel"    : strHomeTel    = UPLOAD("strHomeTel")(1) & "-" & UPLOAD("strHomeTel")(2) & "-" & UPLOAD("strHomeTel")(3)
		CASE "strMobile"     : strMobile     = UPLOAD("strMobile")(1) & "-" & UPLOAD("strMobile")(2) & "-" & UPLOAD("strMobile")(3)
		CASE "strCompAddr"
			strCompPost  = UPLOAD("strCompAddr")(1) & UPLOAD("strCompAddr")(2)
			strCompAddr1 = UPLOAD("strCompAddr")(3)
			strCompAddr2 = GetReplaceInput(UPLOAD("strCompAddr")(4), "")
		CASE "strCompTel"    : strCompTel    = UPLOAD("strCompTel")(1) & "-" & UPLOAD("strCompTel")(2) & "-" & UPLOAD("strCompTel")(3)
		CASE "strJob"        : strJob        = GetReplaceInput(UPLOAD("strJob"), "")
		CASE "strJobLevel"   : strJobLevel   = GetReplaceInput(UPLOAD("strJobLevel"), "")
		CASE "strHobby"      : strHobby      = GetReplaceInput(UPLOAD("strHobby"), "")
		CASE "strMarry"      : strMarry      = UPLOAD("strMarryR")
		CASE "bitUserInfo"   : bitUserInfo   = UPLOAD("bitUserInfo")
		CASE "strJoinMemo"   : strJoinMemo   = GetReplaceInput(UPLOAD("strJoinMemo"), "")
		CASE "strMemo"       : strMemo       = GetReplaceInput(UPLOAD("strMemo"), "")
		CASE "strUserSign"   : strUserSign   = GetReplaceInput(UPLOAD("strUserSign"), "")
		CASE "strRecLoginID" : strRecLoginID = GetReplaceInput(UPLOAD("strRecLoginID"), "")
		CASE "strMemberAdd1" : strMemberAdd1  = GetReplaceInput(UPLOAD("strMemberAdd1"), "")
		CASE "strMemberAdd2" : strMemberAdd2  = GetReplaceInput(UPLOAD("strMemberAdd2"), "")
		CASE "strMemberAdd3" : strMemberAdd3  = GetReplaceInput(UPLOAD("strMemberAdd3"), "")
		CASE "strMemberAdd4" : strMemberAdd4  = GetReplaceInput(UPLOAD("strMemberAdd4"), "")
		CASE "strMemberAdd5" : strMemberAdd5  = GetReplaceInput(UPLOAD("strMemberAdd5"), "")
		CASE "strMemberAdd6" : strMemberAdd6  = GetReplaceInput(UPLOAD("strMemberAdd6"), "")
		CASE "strMemberAdd7" : strMemberAdd7  = GetReplaceInput(UPLOAD("strMemberAdd7"), "")
		CASE "strMemberAdd8" : strMemberAdd8  = GetReplaceInput(UPLOAD("strMemberAdd8"), "")
		CASE "strMemberAdd9" : strMemberAdd9  = GetReplaceInput(UPLOAD("strMemberAdd9"), "")
		CASE "strMemberAdd10": strMemberAdd10 = GetReplaceInput(UPLOAD("strMemberAdd10"), "")
		CASE "strPhotoFile"
			SET theField1 = UPLOAD("strPhotoFile")(1)
			SELECT CASE setUploadComponet
			CASE "1" : IF theField1.FileExists     THEN bitFileUpload1 = True ELSE bitFileUpload1 = False
			CASE "2" : IF theField1.FileName <> "" THEN bitFileUpload1 = True ELSE bitFileUpload1 = False
			END SELECT
		CASE "strNameFile"
			SET theField2 = UPLOAD("strNameFile")(1)
			SELECT CASE setUploadComponet
			CASE "1" : IF theField2.FileExists     THEN bitFileUpload2 = True ELSE bitFileUpload2 = False
			CASE "2" : IF theField2.FileName <> "" THEN bitFileUpload2 = True ELSE bitFileUpload2 = False
			END SELECT
		END SELECT

	RS.MOVENEXT
	WEND

	IF LEN(strBirthday) <> 9 THEN strBirthday = ""
	IF LEN(strMarry)     = 1 THEN strMarry    = "000000000"

	IF strLoginID = "" THEN
		RESPONSE.WRITE ExecJavaAlert("올바른 가입경로로 접근하지 않으셨습니다.", 0)
		RESPONSE.End()
	END IF

	IF Action = "JOIN" THEN

		IF bitIdCheck = "0" THEN
			RESPONSE.WRITE ExecJavaAlert("올바른 가입경로로 접근하지 않으셨습니다.", 0)
			RESPONSE.End()
		END IF
	
		IF strSSN <> "" AND bitSsnCheck = "0" THEN
			RESPONSE.WRITE ExecJavaAlert("올바른 가입경로로 접근하지 않으셨습니다.", 0)
			RESPONSE.End()
		END IF
		
		IF strRecLoginID <> "" AND bitRecIdCheck = "0" THEN
			RESPONSE.WRITE ExecJavaAlert("올바른 가입경로로 접근하지 않으셨습니다.", 0)
			RESPONSE.End()
		END IF

	END IF

	IF bitEmailCheck = "0" THEN
		RESPONSE.WRITE ExecJavaAlert("올바른 가입경로로 접근하지 않으셨습니다." & bitEmailCheck, 0)
		RESPONSE.End()
	END IF

	SELECT CASE strJoinType
	CASE "0" : bitAuth = "1"
	CASE "1" : bitAuth = "0"
	END SELECT

	IF bitJoinEmailActivate = True THEN bitAuth = "0"

	DIM strPath
	strPath = rootPath & "Pds\Member\"

	DIM strFileName1, strFileName2

	IF bitFileUpload1 = True THEN
		IF checkImageFileField(setUploadComponet, theField1) = True THEN
			strFileName1 = ExecFIleUpload(setUploadComponet, theField1, 1048576, strPath & "Photo\", "", False, "", False, 0, 0, False, "0", False, "0", "")
		END IF
	END IF

	IF bitFileUpload2 = True THEN
		IF checkImageFileField(setUploadComponet, theField2) = True THEN
			strFileName2 = ExecFIleUpload(setUploadComponet, theField2, 1048576, strPath & "Name\", "", False, "", False, 0, 0, False, "0", False, "0", "")
		END IF
	END IF

	IF strFileName1 = False THEN strFileName1 = ""
	IF strFileName2 = False THEN strFileName2 = ""

	IF Action = "JOIN" THEN

		DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_LIST] ([strLoginID], [strGroup], [strLoginPwd], [strLoginName], [strEmail], [bitMailing], [strSSN], [strBirthday], [strNick], [strIcq], [strMsn], [strHomepage], [strHomePost], [strHomeAddr1], [strHomeAddr2], [strHomeTel], [strMobile], [strCompPost], [strCompAddr1], [strCompAddr2], [strCompTel], [strJob], [strJobLevel], [strHobby], [strMarry], [strJoinMemo], [strPhotoFile], [strNameFile], [strMemo], [bitUserInfo], [strRecLoginID], [strUserSign], [strMemberAdd1], [strMemberAdd2], [strMemberAdd3], [strMemberAdd4], [strMemberAdd5], [strMemberAdd6], [strMemberAdd7], [strMemberAdd8], [strMemberAdd9], [strMemberAdd10], [bitAuth], [strSIDO]) VALUES ('" & strLoginID & "', '" & strDefaultGroupCode & "', '" & strLoginPwd & "', '" & strLoginName & "', '" & strEmail & "', '" & bitMailing & "', '" & strSSN & "', '" & strBirthday & "', '" & strNick & "', '" & strIcq & "', '" & strMsn & "', '" & strHomepage & "', '" & strHomePost & "', '" & strHomeAddr1 & "', '" & strHomeAddr2 & "', '" & strHomeTel & "', '" & strMobile & "', '" & strCompPost & "', '" & strCompAddr1 & "', '" & strCompAddr2 & "', '" & strCompTel & "', '" & strJob & "', '" & strJobLevel & "', '" & strHobby & "', '" & strMarry & "', '" & strJoinMemo & "', '" & strFileName1 & "', '" & strFileName2 & "', '" & strMemo & "', '" & bitUserInfo & "', '" & strRecLoginID & "', '" & strUserSign & "', '" & strMemberAdd1 & "', '" & strMemberAdd2 & "', '" & strMemberAdd3 & "', '" & strMemberAdd4 & "', '" & strMemberAdd5 & "', '" & strMemberAdd6 & "', '" & strMemberAdd7 & "', '" & strMemberAdd8 & "', '" & strMemberAdd9 & "', '" & strMemberAdd10 & "', '" & bitAuth & "', '" & strSIDO & "') ")

		IF bitJoinEmail = True THEN CALL sendMemberEmail(strLoginID, "0")

		IF intJoinPoint <> 0 THEN DBCON.EXECUTE("EXEC [MPLUS_PUT_MEMBER_POINT] '0', '', '', '', '" & strLoginID & "', '', '', 'M001', " & intJoinPoint & ", '회원 가입시 지급한 포인트' ")

		IF intRecPoint <> 0 THEN
			IF strRecLoginID <> "" THEN DBCON.EXECUTE("EXEC [MPLUS_PUT_MEMBER_POINT] '0', '', '', '', '" & strLoginID & "', '', '" & strRecLoginID & "', 'M002', " & intRecPoint & ", '추천인 회원 가입시 지급한 포인트' ")
		END IF

		IF bitAuth = "1" THEN
			SESSION("strLoginID")   = strLoginID
			SESSION("strLoginName") = strLoginName
			SESSION("strAdmin")     = "0"

			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [intVisit] = '1', [dateSignDate] = getdate() WHERE [strLoginID] = '" & strLoginID & "' ")
		END IF

		IF bitJoinResult = True THEN
			DIM strHidden
			strHidden = "<input type=hidden name=memberJoinCheck value=1>"
			RESPONSE.WRITE ExecFormSubmitHidden("", strHidden, "Member.asp?Action=result&strLoginID=" & strLoginID, "")
			RESPONSE.End()
		ELSE
			IF strJoinScript <> "" AND ISNULL(strJoinScript) = False THEN
				RESPONSE.WRITE ExecJavaScript(strJoinScript)
			END IF	
	
			IF strJoinMsg = "" OR ISNULL(strJoinMsg) = True THEN
				RESPONSE.REDIRECT strJoinUrl
				RESPONSE.End()
			ELSE
				RESPONSE.WRITE ExecFormSubmit(strJoinMsg, strJoinUrl, strJoinUrlTarget)
				RESPONSE.End()
			END IF
		END IF

	ELSE

		IF bitJoinEmailActivate = True THEN
		ELSE
			SET RS = DBCON.EXECUTE("SELECT [strEmail] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & strLoginID & "' AND [strEmail] = '" & strEmail & "' ")
	
			IF RS.EOF THEN
				SET RS = DBCON.EXECUTE("SELECT [strEmail] FROM [MPLUS_MEMBER_LIST] WHERE [strEmail] = '" & strEmail & "' ")
				IF NOT(RS.EOF) THEN
					RESPONSE.WRITE ExecJavaAlert("이미 등록되어 있는 E-MAIL 주소입니다.", 0)
					RESPONSE.End()
				END IF
			END IF
		END IF

		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strLoginPwd] = '" & strLoginPwd & "', [strLoginName] = '" & strLoginName & "', [bitMailing] = '" & bitMailing & "', [strBirthday] = '" & strBirthday & "', [strNick] = '" & strNick & "', [strIcq] = '" & strIcq & "', [strMsn] = '" & strMsn & "', [strHomepage] = '" & strHomepage & "', [strHomePost] = '" & strHomePost & "', [strHomeAddr1] = '" & strHomeAddr1 & "', [strHomeAddr2] = '" & strHomeAddr2 & "', [strHomeTel] = '" & strHomeTel & "', [strMobile] = '" & strMobile & "', [strCompPost] = '" & strCompPost & "', [strCompAddr1] = '" & strCompAddr1 & "', [strCompAddr2] = '" & strCompAddr2 & "', [strCompTel] = '" & strCompTel & "', [strJob] = '" & strJob & "', [strJobLevel] = '" & strJobLevel & "', [strHobby] = '" & strHobby & "', [strMarry] = '" & strMarry & "', [strJoinMemo] = '" & strJoinMemo & "', [strMemo] = '" & strMemo & "', [bitUserInfo] = '" & bitUserInfo & "', [strUserSign] = '" & strUserSign & "', [strMemberAdd1] = '" & strMemberAdd1 & "', [strMemberAdd2] = '" & strMemberAdd2 & "', [strMemberAdd3] = '" & strMemberAdd3 & "', [strMemberAdd4] = '" & strMemberAdd4 & "', [strMemberAdd5] = '" & strMemberAdd5 & "', [strMemberAdd6] = '" & strMemberAdd6 & "', [strMemberAdd7] = '" & strMemberAdd7 & "', [strMemberAdd8] = '" & strMemberAdd8 & "', [strMemberAdd9] = '" & strMemberAdd9 & "', [strMemberAdd10] = '" & strMemberAdd10 & "', [strSIDO] = '" & strSIDO & "' WHERE [strLoginID] = '" & strLoginID & "' ")

		IF bitJoinEmailActivate = False THEN DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strEmail] = '" & strEmail & "' WHERE [strLoginID] = '" & strLoginID & "' ")

		IF strFileName1 <> "" AND ISNULL(strFileName1) = False THEN
			SET RS = DBCON.EXECUTE("SELECT [strPhotoFile] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & strLoginID & "' ")
			strPhotoFile = RS("strPhotoFile")
			IF strPhotoFile <> "" AND ISNULL(strPhotoFile) = False THEN CALL ExecFileDelete(strPath & "Photo\", strPhotoFile)
			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strPhotoFile] = '" & strFileName1 & "' WHERE [strLoginID] = '" & strLoginID & "' ")
		END IF

		IF strFileName2 <> "" AND ISNULL(strFileName2) = False THEN
			SET RS = DBCON.EXECUTE("SELECT [strNameFile] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & strLoginID & "' ")
			strNameFile = RS("strNameFile")
			IF strNameFile <> "" AND ISNULL(strNameFile) = False THEN CALL ExecFileDelete(strPath & "Name\", strNameFile)
			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strNameFile] = '" & strFileName2 & "' WHERE [strLoginID] = '" & strLoginID & "' ")
		END IF

		IF strEditScript <> "" AND ISNULL(strEditScript) = False THEN
			RESPONSE.WRITE ExecJavaScript(strEditScript)
		END IF	

		IF strEditMsg = "" OR ISNULL(strEditMsg) = True THEN
			RESPONSE.REDIRECT strEditUrl
			RESPONSE.End()
		ELSE
			RESPONSE.WRITE ExecFormSubmit(strEditMsg, strEditUrl, strEditUrlTarget)
			RESPONSE.End()
		END IF

	END IF

	SET RS = NOTHING : SET RS2 = NOTHING : DBCON.CLOSE
%>