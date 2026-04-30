<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM strLoginID, strLoginPwd, strPrevUrl
	strLoginID  = GetReplaceInput(REQUEST.FORM("strLoginID"), 1)
	strLoginID  = GetReplaceInput(REQUEST.FORM("strLoginID"), "S")
	strLoginPwd = GetReplaceInput(REQUEST.FORM("strLoginPwd"), "S")
	strPrevUrl  = REQUEST.FORM("strPrevUrl")
	
	IF strLoginID = "" OR strLoginPwd = "" THEN
		RESPONSE.WRITE ExecJavaAlert("아이디 또는 비밀번호를 입력해 주시기 바랍니다.", 0)
		RESPONSE.End()
	END IF

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_LOGIN_EXEC] '" & strLoginID & "', '" & strLoginPwd & "', '2', '2' ")

	IF NOT(RS.EOF) THEN

		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [intVisit] = [intVisit] + 1, [dateSignDate] = getdate(), [strSignIP] = '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "' WHERE [strLoginID] = '" & strLoginID & "' ")

		SESSION("strLoginID")   = strLoginID
		SESSION("strLoginName") = RS("strLoginName")
		SESSION("strAdmin")     = RS("strAdmin")

		IF REQUEST.FORM("strPrevUrl") <> "" THEN
			RESPONSE.REDIRECT REPLACE(REPLACE(REQUEST.FORM("strPrevUrl"), "'", ""), "--**--", "&")
		ELSE
			RESPONSE.REDIRECT "Main/Main.asp"
		END IF
		RESPONSE.End()

	ELSE

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_LOGIN_EXEC] '" & strLoginID & "', '" & strLoginPwd & "', '', '1' ")

		IF RS.EOF THEN
			RESPONSE.WRITE ExecJavaAlert("아이디 또는 비밀번호가 일치하지 않거나\n관리자가 아닌 아이디로 로그인을 시도하셨습니다.", 0)
			RESPONSE.End()
		END IF

		DIM strBoardAdminList, bitBoardAdmin, I

		SET RS = DBCON.EXECUTE("SELECT [strAdmin] FROM [MPLUS_BOARD_CONFIG_DEFAULT] ")

		strBoardAdminList = ""
		WHILE NOT(RS.EOF)

			IF RS("strAdmin") <> "" AND ISNULL(RS("strAdmin")) = False THEN strBoardAdminList = strBoardAdminList & RS("strAdmin")

		RS.MOVENEXT
		WEND

		bitBoardAdmin = False

		IF strBoardAdminList = "" THEN
			bitBoardAdmin = False
		ELSE
			strBoardAdminList = SPLIT(strBoardAdminList, "|")
			FOR I = 0 TO UBOUND(strBoardAdminList)
				IF SESSION("strLoginID") = strBoardAdminList(I) THEN
					bitBoardAdmin = True
					EXIT FOR
				END IF
			NEXT
		END IF

		IF bitBoardAdmin = True THEN

			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [intVisit] = [intVisit] + 1, [dateSignDate] = getdate(), [strSignIP] = '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "' WHERE [strLoginID] = '" & strLoginID & "' ")

			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_LOGIN_EXEC] '" & strLoginID & "', '" & strLoginPwd & "', '', '0' ")

			SESSION("strLoginID")   = strLoginID
			SESSION("strLoginName") = RS("strLoginName")
			SESSION("strAdmin")     = "1"
	
			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_LOGIN] ")
			DIM intLoginPoint
			intLoginPoint = RS("intLoginPoint")
			
			IF intLoginPoint <> 0 THEN
				SET RS = DBCON.EXECUTE("SELECT [strLoginID] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & strLoginID & "' AND DATEDIFF(day, [dateSignDate], getdate()) > 0 ")
				IF NOT(RS.EOF) THEN DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_POINT] ([strPointType], [strLoginID], [strCode], [moneyPoint], [strMemo]) VALUES ('1', '" & strLoginID & "', 'M003', " & intLoginPoint & ", '로그인시 지급한 포인트') ")
			END IF

			RESPONSE.REDIRECT "Board/BoardList.asp"
			RESPONSE.End()

		ELSE

			RESPONSE.WRITE ExecJavaAlert("아이디 또는 비밀번호가 일치하지 않거나\n관리자가 아닌 아이디로 로그인을 시도하셨습니다.^^", 0)
			RESPONSE.End()

		END IF

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>