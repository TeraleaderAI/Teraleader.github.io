<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM Action, I, strPollCode
	Action      = UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))
	strPollCode = GetReplaceInput(REQUEST.QueryString("strPollCode"), "S")

	DIM strMsg, cmt_strLoginID, cmt_strName, cmt_strPwd, cmt_strContent, cmt_intIcon, searchCategory, searchWord

	SELECT CASE Action
	CASE "ADD"

		DIM strLoginID
		IF SESSION("strLoginID") = "" THEN strLoginID = "guest" ELSE strLoginID = SESSION("strLoginID")

		SET RS = DBCON.EXECUTE("SELECT [bitMember], [bitPollPK], [intTimePK] FROM [MPLUS_POLL] WHERE [strPollCode] = '" & strPollCode & "' ")

		IF RS("bitMember") = True THEN
			IF strLoginID = "guest" THEN
				RESPONSE.WRITE ExecJavaAlert("로그인 후 이용해 주시기 바랍니다.", 0)
				RESPONSE.End()
			END IF
		END IF

		IF RS("bitPollPK") = True THEN
			SQL = "SELECT [intNum] FROM [MPLUS_POLL_MEMBER] WHERE [strPollCode] = '" & strPollCode & "' AND [strLoginID] = '" & strLoginID & "' "
			IF strLoginID = "guest" THEN SQL = SQL & " AND [strUserIP] = '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "' "
			SQL = SQL & "AND DATEDIFF(hh, [dateRegDate], getdate()) < " & RS("intTimePK") & " "
			SET RS = DBCON.EXECUTE(SQL)
	
			IF NOT(RS.EOF) THEN
				RESPONSE.WRITE ExecJavaAlert("이미 설문조사에 참여를 하셨습니다.", 0)
				RESPONSE.End()
			END IF
		END IF

		DIM strPollItem, strPollValue, strValue, strTextValue, strTempValue

		DBCON.EXECUTE("UPDATE [MPLUS_POLL] SET [intVoteCount] = [intVoteCount] + 1 WHERE [strPollCode] = '" & strPollCode & "' ")

		DBCON.EXECUTE("INSERT INTO [MPLUS_POLL_MEMBER] ([strPollCode], [strLoginID], [strUserIP]) VALUES ('" & strPollCode & "', '" & SESSION("strLoginID") & "', '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "') ")

		FOR I = 1 TO REQUEST.FORM("strPollItem").COUNT

			strPollItem  = SPLIT(REQUEST.FORM("strPollItem")(I), "|")
			strPollValue = REQUEST.FORM("strPollValue")(I)
			strPollValue = SPLIT(strPollValue, "|")

			SET RS = DBCON.EXECUTE("SELECT [strValue], [strTextValue] FROM [MPLUS_POLL_ITEM] WHERE [intSeq] = '" & strPollItem(0) & "' ")

			strValue     = SPLIT(RS("strValue"), "|")
			strTextValue = RS("strTextValue") : IF ISNULL(strTextValue) = True THEN strTextValue = ""

			IF strPollItem(1) = "True" THEN

				FOR J = 0 TO UBOUND(strPollValue)
					strValue(strPollValue(J)) = INT(strValue(strPollValue(J))) + 1
				NEXT

				strTempValue = ""
				FOR J = 0 TO UBOUND(strValue)
					IF strTempValue <> "" THEN strTempValue = strTempValue & "|"
					strTempValue = strTempValue & strValue(J)
				NEXT

				DBCON.EXECUTE("UPDATE [MPLUS_POLL_ITEM] SET [strValue] = '" & strTempValue & "' WHERE [intSeq] = '" & strPollItem(0) & "' ")

			ELSE
				IF strTextValue <> "" THEN strTextValue = strTextValue & "|"
				strTextValue = strTextValue & GetReplaceInput(strPollValue(0), "")
				DBCON.EXECUTE("UPDATE [MPLUS_POLL_ITEM] SET [strTextValue] = '" & strTextValue & "' WHERE [intSeq] = '" & strPollItem(0) & "' ")
			END IF

		NEXT

		RESPONSE.WRITE ExecFormSubmitHidden("참여가 완료되었습니다.", "<input type=""hidden"" name=""searchCategory"" value=""" & REQUEST.FORM("searchCategory") & """><input type=""hidden"" name=""POLL_searchWord"" value=""" & GetReplaceInput(REQUEST.FORM("searchWord"), "S") & """>", "../poll.asp?Action=read&strPollCode=" & strPollCode & "&intPage=" & GetReplaceInput(REQUEST.QueryString("intPage"),"S"), "")
		RESPONSE.End()

	CASE "COMMENTREMOVE"

		WITH REQUEST

			cmt_intNum     = GetReplaceInput(.FORM("cmt_intNum"), "")
			cmt_hiddenPwd  = GetReplaceInput(.FORM("cmt_hiddenPwd"), "")
			cmt_strLoginID = GetReplaceInput(.FORM("strLoginID"), "")
			searchCategory = GetReplaceInput(.FORM("searchCategory"), "S")
			searchWord     = GetReplaceInput(.FORM("searchWord"), "S")

		END WITH

		DIM bitCommentRemoveOK

		IF cmt_strLoginID = "guest" THEN
			SET RS = DBCON.EXECUTE("SELECT [intNum] FROM [MPLUS_POLL_COMMENT] WHERE [intNum] = '" & cmt_intNum & "' AND [strLoginID] = 'guest' AND [strPwd] = '" & cmt_hiddenPwd & "' ")
			IF RS.EOF THEN bitCommentRemoveOK = False ELSE bitCommentRemoveOK = True
		ELSE
			IF SESSION("strAdmin") = "2" THEN
				bitCommentRemoveOK = True
			ELSE
				SET RS = DBCON.EXECUTE("SELECT [intNum] FROM [MPLUS_POLL_COMMENT] WHERE [intNum] = '" & cmt_intNum & "' AND [strLoginID] = '" & cmt_strLoginID & "' ")
				IF RS.EOF THEN bitCommentRemoveOK = False ELSE bitCommentRemoveOK = True
			END IF
		END IF

		IF bitCommentRemoveOK = True THEN
			DBCON.EXECUTE("DELETE FROM [MPLUS_POLL_COMMENT] WHERE [intNum] = '" & cmt_intNum & "' ")
			strMsg = "댓글 삭제가 완료되었습니다."
		ELSE
			strMsg = "본인의 댓글이 아니거나 비밀번호가 일치하지 않습니다."
		END IF

		strHidden = "<input type=""hidden"" name=""searchCategory"" value=""" & searchCategory & """>"
		strHidden = strHidden & "<input type=""hidden"" name=""searchWord"" value=""" & searchWord & """>"
		RESPONSE.WRITE ExecFormSubmitHidden(strMsg, strHidden, "../poll.asp?Action=" & GetReplaceInput(REQUEST.QueryString("pollType"),"S") & "&strPollCode=" & strPollCode & "&intPage=" & GetReplaceInput(REQUEST.QueryString("intPage"),"S"), "")
		RESPONSE.End()

	CASE "COMMENTADD"

		WITH REQUEST

			cmt_strLoginID = GetReplaceInput(.FORM("strLoginID"), "")
			cmt_strName    = GetReplaceInput(.FORM("cmt_strName"), 1)
			cmt_strPwd     = GetReplaceInput(.FORM("cmt_strPwd"), 1)
			cmt_strContent = GetReplaceInput(.FORM("cmt_strContent"), 1)
			cmt_intIcon    = GetReplaceInput(.FORM("cmt_intIcon"), "")
			searchCategory = GetReplaceInput(.FORM("searchCategory"), "S")
			searchWord     = GetReplaceInput(.FORM("searchWord"), "S")

		END WITH

		IF cmt_strName = "" THEN
			RESPONSE.WRITE ExecJavaAlert("이름을 올바르게 입력해 주시기 바랍니다.", 0)
			RESPONSE.End()
		END IF

		IF cmt_strLoginID = "guest" AND cmt_strPwd = "" THEN
			RESPONSE.WRITE ExecJavaAlert("비밀번호를 올바르게 입력해 주시기 바랍니다.", 0)
			RESPONSE.End()
		END IF

		IF cmt_strContent = "" THEN
			RESPONSE.WRITE ExecJavaAlert("내용을 올바르게 입력해 주시기 바랍니다.", 0)
			RESPONSE.End()
		END IF

		DBCON.EXECUTE("INSERT INTO [MPLUS_POLL_COMMENT] ([strPollCode], [strLoginID], [strName], [strPwd], [strContent], [intIcon], [strUserIP]) VALUES ('" & strPollCode & "', '" & cmt_strLoginID & "', '" & cmt_strName & "', '" & cmt_strPwd & "', '" & cmt_strContent & "', '" & cmt_intIcon & "', '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "') ")

		strHidden = "<input type=""hidden"" name=""searchCategory"" value=""" & searchCategory & """>"
		strHidden = strHidden & "<input type=""hidden"" name=""searchWord"" value=""" & searchWord & """>"
		RESPONSE.WRITE ExecFormSubmitHidden("댓글이 등록되었습니다.", strHidden, "../poll.asp?Action=" & GetReplaceInput(REQUEST.QueryString("pollType"),"S") & "&strPollCode=" & strPollCode & "&intPage=" & GetReplaceInput(REQUEST.QueryString("intPage"),"S"), "")
		RESPONSE.End()

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>