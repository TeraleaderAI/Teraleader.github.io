<!-- #include file = "BoardInclude.asp" -->
<%
	DIM prevAction
	prevAction = GetReplaceInput(REQUEST.QueryString("prevAction"),"S")

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_LOGIN] ")

	DIM intLoginPoint, strLoginMsg, strLoginErrorMsg1, strLoginErrorMsg2, strLogOutMsg

	intLoginPoint     = RS("intLoginPoint")
	strLoginMsg       = RS("strLoginMsg")
	strLoginErrorMsg1 = RS("strLoginErrorMsg1")
	strLoginErrorMsg2 = RS("strLoginErrorMsg2")
	strLogOutMsg      = RS("strLogOutMsg")

	IF strLoginMsg       = "" OR ISNULL(strLoginMsg)       = True THEN strLoginMsg       = DIM_strBoardMsg(11)
	IF strLogOutMsg      = "" OR ISNULL(strLogOutMsg)      = True THEN strLogOutMsg      = DIM_strBoardMsg(12)
	IF strLoginErrorMsg1 = "" OR ISNULL(strLoginErrorMsg1) = True THEN strLoginErrorMsg1 = DIM_strBoardMsg(13)
	IF strLoginErrorMsg2 = "" OR ISNULL(strLoginErrorMsg2) = True THEN strLoginErrorMsg2 = DIM_strBoardMsg(14)

	SELECT CASE UCASE(Action)
	CASE "LOGIN"
		DIM LOGIN_strFormUrl, LOGIN_strLink
		LOGIN_strFormUrl = "mboard.asp?Action=login_ok&strBoardID=" & strBoardID & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intPage=" & intPage & "&intSeq=" & GetReplaceInput(REQUEST.QueryString("intSeq"),"S") & "&prevAction=" & prevAction
		LOGIN_strLink    = "javascript:OnBoardLoginCheck();"
	CASE "LOGIN_OK"
		DIM strLoginID, strLoginPwd
		strLoginID  = GetReplaceInput(REQUEST.Form("strLoginID"), "S")
		strLoginPwd = GetReplaceInput(REQUEST.Form("strLoginPwd"), "S")

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_LOGIN_EXEC] '" & strLoginID & "', '', '', '0' ")
		IF RS.EOF THEN
			RESPONSE.WRITE ExecJavaAlert(strLoginErrorMsg1, 0)
			RESPONSE.End()
		ELSE
			IF strLoginPwd = RS("strLoginPwd") THEN

				IF RS("bitAuth") = False THEN
					RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(23), 0)
					RESPONSE.End()
				END IF

				IF RS("bitSecession") = True THEN
					RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(24), 0)
					RESPONSE.End()
				END IF

				SESSION("strLoginID")   = LCASE(strLoginID)
				SESSION("strLoginName") = RS("strLoginName")
				SESSION("strAdmin")     = RS("strAdmin")

				IF intLoginPoint <> 0 THEN

					SET RS = DBCON.EXECUTE("SELECT [strLoginID] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & strLoginID & "' AND DATEDIFF(second, [dateSignDate], getdate()) >= 86400 ")

					IF NOT(RS.EOF) THEN DBCON.EXECUTE("EXEC [MPLUS_PUT_MEMBER_POINT] '0', '', '', '', '" & strLoginID & "', '', '', 'M003', " & intLoginPoint & ", '로그인시 지급한 포인트' ")

				END IF

				DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [intVisit] = [intVisit] + 1, [dateSignDate] = getdate(), [strSignIP] = '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "' WHERE [strLoginID] = '" & strLoginID & "' ")

				SET RS = DBCON.EXECUTE("SELECT [bitPointLevel] FROM [MPLUS_MEMBER_CONFIG_LOGIN] ")

				IF RS("bitPointLevel") = True THEN

					SET RS = DBCON.EXECUTE("SELECT [strGroupCode], [intStartPoint], [intEndPoint] FROM [MPLUS_MEMBER_POINT_LEVEL] ")
				
					WHILE NOT(RS.EOF)
				
						DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strGroup] = '" & RS("strGroupCode") & "' WHERE [intPoint] >=" & RS("intStartPoint") & " AND [intPoint] <=" & RS("intEndPoint") & " AND [strLoginID] = '" & SESSION("strLoginID") & "' ")
				
					RS.MOVENEXT
					WEND

				END IF

				RESPONSE.WRITE ExecFormSubmit(strLoginMsg, "mboard.asp?Action=" & prevAction & "&strBoardID=" & strBoardID & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intPage=" & intPage & "&intSeq=" & GetReplaceInput(REQUEST.QueryString("intSeq"),"S"), "")				
				RESPONSE.End()

			ELSE

				RESPONSE.WRITE ExecJavaAlert(strLoginErrorMsg2, 0)
				RESPONSE.End()

			END IF
		END IF
	CASE "LOGOUT"
		IF SESSION("strLoginID") = "" THEN

			RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(15), 0)
			RESPONSE.End()

		ELSE

			SESSION("strLoginID")     = ""
			SESSION("strLoginName")   = ""
			SESSION("strAdmin")       = ""
			SESSION("strSecretBoard") = ""

			RESPONSE.WRITE ExecFormSubmit(strLogOutMsg, "mboard.asp?Action=" & prevAction & "&strBoardID=" & strBoardID & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intPage=" & intPage & "&intSeq=" & REQUEST.QueryString("intSeq"), "")
			RESPONSE.End()

		END IF
	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>