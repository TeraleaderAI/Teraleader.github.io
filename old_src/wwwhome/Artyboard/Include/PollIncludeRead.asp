<!-- #include file = "PollInclude.asp" -->
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_POLL] '2', '" & strPollCode & "', '', '', '" & strSearchCategory & "', '" & strSearchWord & "' ")

	DIM READ_strSubject, READ_strMemo, READ_intItemCount, READ_intVoteCount, READ_bitMember, READ_strReadLevel, READ_strWriteLevel
	DIM READ_bitPollPK, READ_intTimePK, READ_strStartDate, READ_strEndDate, READ_bitResultWindow, READ_intResultWidth
	DIM READ_intResultHeight, READ_bitComment, READ_bitCommentMember, READ_intRead, READ_dateRegDate
	DIM READ_bitUserComment, READ_strPrevCode, READ_strNextCode, READ_intComment, READ_strState

	READ_strSubject       = RS("strSubject")
	READ_strMemo          = GetReplaceTag2Text(RS("strMemo"))
	READ_intItemCount     = RS("intItemCount") - 1
	READ_intVoteCount     = RS("intVoteCount")
	READ_bitMember        = RS("bitMember")
	READ_strReadLevel     = RS("strReadLevel")
	READ_strWriteLevel    = RS("strWriteLevel")
	READ_bitPollPK        = RS("bitPollPK")
	READ_intTimePK        = RS("intTimePK")
	READ_strStartDate     = RS("strStartDate")
	READ_strEndDate       = RS("strEndDate")
	READ_bitResultWindow  = RS("bitResultWindow")
	READ_intResultWidth   = RS("intResultWidth")
	READ_intResultHeight  = RS("intResultHeight")
	READ_bitComment       = RS("bitComment")
	READ_bitCommentMember = RS("bitCommentMember")
	READ_intRead          = RS("intRead")
	READ_dateRegDate      = RS("dateRegDate")
	READ_strPrevCode      = RS("strPrevCode")
	READ_strNextCode      = RS("strNextCode")
	READ_intComment       = RS("intComment")

	IF READ_bitMember = True THEN

		IF SESSION("strLoginID") = "" THEN

			READ_strReadLevel  = False
			READ_strWriteLevel = False

		ELSE

			IF SESSION("strAdmin") = "2" THEN

				READ_strReadLevel  = True
				READ_strWriteLevel = True

			ELSE

				SET RS = DBCON.EXECUTE("SELECT [intLevel] AS [intUserLevel] FROM [MPLUS_MEMBER_LIST][a] INNER JOIN [MPLUS_GROUP][b] ON [a].[strGroup] = [b].[strGroupCode] WHERE [a].[strLoginID] = '" & SESSION("strLoginID") & "' ")
	
				DIM intUserLevel
				intUserLevel = RS("intUserLevel")
	
				SET RS = DBCON.EXECUTE("SELECT [intReadLevel] = (SELECT [intLevel] FROM [MPLUS_GROUP] WHERE [strGroupCode] = '" & READ_strReadLevel & "'), [intWriteLevel] = (SELECT [intLevel] FROM [MPLUS_GROUP] WHERE [strGroupCode] = '" & READ_strWriteLevel & "') ")
response.write RS("intReadLevel") & "," & RS("intWriteLevel") & "," & intUserLevel		
				READ_strReadLevel  = GetBoardLevelCheck(False, RS("intReadLevel"), intUserLevel)
				READ_strWriteLevel = GetBoardLevelCheck(False, RS("intWriteLevel"), intUserLevel)

			END IF

		END IF

	ELSE

		READ_strReadLevel  = True
		READ_strWriteLevel = True

	END IF

	IF UCASE(Action) = "READ" THEN
		IF (INT(READ_strStartDate) < INT(intNowDate) OR INT(READ_strStartDate) = INT(intNowDate)) AND (INT(READ_strEndDate) > INT(intNowDate) OR INT(READ_strEndDate) = INT(intNowDate)) THEN
		ELSE
			RESPONSE.WRITE ExecJavaAlert("마감된 설문조사 입니다.", 0)
			RESPONSE.End()
		END IF
	END IF

	DIM LINK_VOTE, LINK_RESULT, LINK_READ, LINK_LIST

	IF (INT(READ_strStartDate) < INT(intNowDate) OR INT(READ_strStartDate) = INT(intNowDate)) AND (INT(READ_strEndDate) > INT(intNowDate) OR INT(READ_strEndDate) = INT(intNowDate)) THEN
		READ_strState = "진행중"
		IF READ_strWriteLevel = True THEN
			LINK_VOTE = "javascript:OnVote('" & strPollCode & "');"
		ELSE
			LINK_VOTE = "javascript:alert('설문조사 참여 권한이 없습니다.');"
		END IF
	ELSE
		READ_strState = "마감"
		LINK_VOTE = "javascript:alert('마감된 설문조사 입니다.');"
	END IF

	IF READ_strReadLevel = True THEN
		LINK_RESULT = "javascript:OnResult('" & strPollCode & "');"
	ELSE
		LINK_RESULT = "javascript:alert('결과보기 권한이 없습니다.');"
	END IF

	LINK_LIST   = "javascript:OnList();"
	LINK_READ   = "javascript:OnRead('" & strPollCode & "');"

	IF UCASE(Action) = "READ" THEN DBCON.EXECUTE("UPDATE [MPLUS_POLL] SET [intRead] = [intRead] + 1 WHERE [strPollCode] = '" & strPollCode & "' ")

	IF READ_bitCommentMember = True THEN
		IF SESSION("strLoginID") = "" THEN READ_bitUserComment = False ELSE READ_bitUserComment = True
	ELSE
		READ_bitUserComment = True
	END IF
%>