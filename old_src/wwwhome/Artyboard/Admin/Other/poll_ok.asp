<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM Action, I, strMsg
	DIM strPollCode, strSubject, strMemo, intItemCount, strItem, strValue, bitMember, strReadLevel
	DIM strWriteLevel, bitPollPK, intTimePK, strStartDate, strEndDate, bitResultWindow, intResultWidth, intResultHeight
	DIM bitComment, bitCommentMember

	Action = UCASE(REQUEST.QueryString("Action"))

	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	SELECT CASE Action
	CASE "REMOVE" : isAdminPopup = False
	CASE ELSE     : isAdminPopup = True
	END SELECT
	strAdminPrevUrl = "Other/PollList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	SELECT CASE Action
	CASE "ADD", "EDIT"
		WITH REQUEST
		
			strSubject       = GetReplaceInput(.FORM("strSubject"), "")
			strMemo          = GetReplaceInput(.FORM("strMemo"), "")
			bitMember        = .FORM("bitMember")
			strReadLevel     = .FORM("strReadLevel")
			strWriteLevel    = .FORM("strWriteLevel")
			bitPollPK        = .FORM("bitPollPK")
			intTimePK        = .FORM("intTimePK")
			strStartDate     = GetReplaceInput(.FORM("strStartDate")(1),"") & GetReplaceInput(.FORM("strStartDate")(2),"") & GetReplaceInput(.FORM("strStartDate")(3),"") & GetReplaceInput(.FORM("strStartDate")(4),"") & GetReplaceInput(.FORM("strStartDate")(5),"")
			strEndDate       = GetReplaceInput(.FORM("strEndDate")(1),"") & GetReplaceInput(.FORM("strEndDate")(2),"") & GetReplaceInput(.FORM("strEndDate")(3),"") & GetReplaceInput(.FORM("strEndDate")(4),"") & GetReplaceInput(.FORM("strEndDate")(5),"")
			bitResultWindow  = .FORM("bitResultWindow")
			intResultWidth   = .FORM("intResultWidth")
			intResultHeight  = .FORM("intResultHeight")
			bitComment       = .FORM("bitComment")
			bitCommentMember = .FORM("bitCommentMember")
	
		END WITH
	END SELECT

	IF Action = "ADD" THEN
		SET RS = DBCON.EXECUTE("SELECT TOP 1 [strPollCode] FROM [MPLUS_POLL] ORDER BY [strPollCode] DESC ")
		IF RS.EOF THEN
			strPollCode = "P0001"
		ELSE
			strPollCode = RS("strPollCode")
			strPollCode = INT(RIGHT(strPollCode, 4)) + 1
			FOR I = LEN(strPollCode) TO 3
				strPollCode = "0" & strPollCode
			NEXT
			strPollCode = "P" & strPollCode
		END IF
	ELSE
		strPollCode = REQUEST.FORM("strPollCode")
	END IF

	SELECT CASE Action
	CASE "ADD"

		DBCON.EXECUTE("INSERT INTO [MPLUS_POLL] ([strPollCode], [strSubject], [strMemo], [bitMember], [strReadLevel], [strWriteLevel], [bitPollPK], [intTimePK], [strStartDate], [strEndDate], [bitResultWindow], [intResultWidth], [intResultHeight], [bitComment], [bitCommentMember]) VALUES ('" & strPollCode & "', '" & strSubject & "', '" & strMemo & "', '" & bitMember & "', '" & strReadLevel & "', '" & strWriteLevel & "', '" & bitPollPK & "', '" & intTimePK & "', '" & strStartDate & "', '" & strEndDate & "', '" & bitResultWindow & "', '" & intResultWidth & "', '" & intResultHeight & "', '" & bitComment & "', '" & bitCommentMember & "') ")

		strMsg = "설문조사 등록이 완료되었습니다."

	CASE "EDIT"

		DBCON.EXECUTE("UPDATE [MPLUS_POLL] SET [strSubject] = '" & strSubject & "', [strMemo] = '" & strMemo & "', [bitMember] = '" & bitMember & "', [strReadLevel] = '" & strReadLevel & "', [strWriteLevel] = '" & strWriteLevel & "', [bitPollPK] = '" & bitPollPK & "', [intTimePK] = '" & intTimePK & "', [strStartDate] = '" & strStartDate & "', [strEndDate] = '" & strEndDate & "', [bitResultWindow] = '" & bitResultWindow & "', [intResultWidth] = '" & intResultWidth & "', [intResultHeight] = '" & intResultHeight & "', [bitComment] = '" & bitComment & "', [bitCommentMember] = '" & bitCommentMember & "' WHERE [strPollCode] = '" & REQUEST.QueryString("strPollCode") & "' ")

		strMsg = "설문조사 수정이 완료되었습니다."

	CASE "REMOVE"

		DBCON.EXECUTE("DELETE FROM [MPLUS_POLL] WHERE [strPollCode] = '" & REQUEST.QueryString("strPollCode") & "' ")
		DBCON.EXECUTE("DELETE FROM [MPLUS_POLL_MEMBER] WHERE [strPollCode] = '" & REQUEST.QueryString("strPollCode") & "' ")
		DBCON.EXECUTE("DELETE FROM [MPLUS_POLL_COMMENT] WHERE [strPollCode] = '" & REQUEST.QueryString("strPollCode") & "' ")
		DBCON.EXECUTE("DELETE FROM [MPLUS_POLL_ITEM] WHERE [strPollCode] = '" & REQUEST.QueryString("strPollCode") & "' ")

		strMsg = "설문조사 삭제가 완료되었습니다."

	END SELECT

	RESPONSE.WRITE ExecFormSubmit(strMsg, "PollList.asp", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>