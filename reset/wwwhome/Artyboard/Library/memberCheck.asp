<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	RESPONSE.EXPIRES = -1

	DIM strInput, Action
	strInput = GetReplaceInput(REQUEST.QueryString("strInput"), 1)
	strInput = GetReplaceInput(REQUEST.QueryString("strInput"), "S")
	Action   = UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))

	IF strInput = "" THEN
		RESPONSE.WRITE ExecJavaAlert("올바른 값을 입력해 주시기 바랍니다.+" & strInput, 1)
		RESPONSE.End()
	END IF

	DIM strMsg, intReturn

	SELECT CASE Action
	CASE "0", "1"

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & strInput & "', '0' ")

		IF RS.EOF THEN
			IF Action = "0" THEN
				strMsg    = "사용가능한 회원아이디 입니다."
				intReturn = "1"
			ELSE
				strMsg    = "등록되어 있지 않은 회원아이디 입니다."
				intReturn = "0"
			END IF
		ELSE
			IF Action = "0" THEN
				IF RS("bitSecession") = True THEN
					strMsg    = "탈퇴 처리중인 회원 아이디 입니다.\n\n다른 아이디를 입력해 주시기 바랍니다."
				ELSE
					strMsg    = "이미 사용되고 있는 회원아이디 입니다.\n\n다른 아이디를 입력해 주시기 바랍니다."
				END IF
				intReturn = "0"
			ELSE
				strMsg    = "정상적으로 등록되어 있는 회원아이디 입니다."
				intReturn = "1"
			END IF
		END IF

	CASE "2", "4"
		SET RS = DBCON.EXECUTE("SELECT [strEmail] FROM [MPLUS_MEMBER_LIST] WHERE [strEmail] = '" & strInput & "' ")
		IF RS.EOF THEN
			strMsg    = "사용가능한 E-MAIL 주소입니다."
			IF Action = "4" THEN
				strMsg = strMsg & "\n\n회원님의 메일계정 (" & strInput & ") 로 인증번호를 발송했습니다.\n메일내용에 링크를 클릭하시면 회원인증이 되어 가입하신 아이디를 사용하실 수 있습니다."
				
				SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_JOIN] ")

				DIM strSubject, strContent, strLoginID, strLoginName, mode, strTempKey, strKey, I, RndVirtualID
				strLoginID   = GetReplaceInput(REQUEST.QueryString("strLoginID"), "")
				strLoginName = GetReplaceInput(REQUEST.QueryString("strLoginName"), "")
				mode         = GetReplaceInput(REQUEST.QueryString("mode"), "")
				strSubject   = RS("strActivateSubject")
				strContent   = RS("strActivateContent")

				strTempKey = "abcdefghijklmnopqrstuvwxyz1234567890"
				FOR I = 1 TO 20
				Randomize
					RndVirtualID = INT(RND() * 35)
					strKey = strKey & MID(strTempKey, RndVirtualID + 1, 1)
				NEXT

				SET RS = DBCON.EXECUTE("SELECT [strLoginID], [strEmail], [strNumber] FROM [MPLUS_ACTIVATE] WHERE [strLoginID] = '" & strLoginID & "' AND [strEmail] = '" & strInput & "' ")

				IF RS.EOF THEN
					DBCON.EXECUTE("INSERT INTO [MPLUS_ACTIVATE] ([strLoginID], [strEmail], [strNumber], [dateRegDate]) VALUES ('" & strLoginID & "', '" & strInput & "', '" & strKey & "', getdate()) ")
				ELSE
					strKey = RS("strNumber")
				END IF

				strContent = GetReplaceTag2Text(strContent)
				strContent = strContent & "<br><br><a href='" & httpPath & "Library/activate.asp?mode=" & mode & "&strLoginID=" & strLoginID & "&key=" & strKey & "'>" & httpPath & "Library/activate.asp?mode=" & mode & "&strLoginID=" & strLoginID & "&key=" & strKey & "</a>"

				SET RS = DBCON.EXECUTE("SELECT [strLoginName], [strEmail] FROM [MPLUS_MEMBER_LIST] WHERE [strAdmin] = '2' ")

				CALL sendEmail(RS("strLoginName"), RS("strEmail"), strLoginName, strInput, strSubject, strContent, "", "", "", "")

			END IF
			intReturn = "1"
		ELSE
			strMsg    = "이미 등록되어 있는 E-MAIL 주소입니다."
			intReturn = "0"
		END IF
	CASE "3"
		SET RS = DBCON.EXECUTE("SELECT [strSSN] FROM [MPLUS_MEMBER_LIST] WHERE [strSSN] = '" & strInput & "' ")
		IF RS.EOF THEN
			strMsg    = "사용가능한 주민등록번호 입니다."
			intReturn = "1"
		ELSE
			strMsg    = "이미 등록되어 있는 주민등록번호 입니다."
			intReturn = "0"
		END IF
	CASE "5"
		IF UCASE(GetReplaceInput(REQUEST.QueryString("mode"), "")) = "EDIT" THEN
			SET RS = DBCON.EXECUTE("SELECT [strNick] FROM [MPLUS_MEMBER_LIST] WHERE [strNick] = '" & strInput & "' AND [strLoginID] NOT IN ('" & GetReplaceInput(REQUEST.QueryString("strLoginID"), "") & "') ")
		ELSE
			SET RS = DBCON.EXECUTE("SELECT [strNick] FROM [MPLUS_MEMBER_LIST] WHERE [strNick] = '" & strInput & "' ")
		END IF
		IF RS.EOF THEN
			strMsg    = "사용 가능한 닉네임 입니다."
			intReturn = "1"
		ELSE
			strMsg    = "이미 등록되어 있는 닉네임 입니다."
			intReturn = "0"
		END IF
	END SELECT

	RESPONSE.WRITE "<script language=javascript>" & vbcrlf
	RESPONSE.WRITE "alert('" & strMsg & "');" & vbcrlf
	RESPONSE.WRITE "window.returnValue=" & intReturn & ";" & vbcrlf
	RESPONSE.WRITE "self.close();" & vbcrlf
	RESPONSE.WRITE "</script>" & vbcrlf

	SET RS = NOTHING : DBCON.CLOSE
%>