<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Other/PollList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM strPollCode, Action, I
	strPollCode = REQUEST.QueryString("strPollCode")
	Action      = UCASE(REQUEST.QueryString("Action"))

	DIM strSubject, bitObjective, bitCrowd, intCrowd, intItemCount, strItem, strValue, intStep

	SELECT CASE Action
	CASE "ADD", "EDIT"

		WITH REQUEST

			strSubject   = GetReplaceInput(.FORM("strSubject"), "")
			bitObjective = .FORM("bitObjective")
			bitCrowd     = .FORM("bitCrowd")
			intCrowd     = .FORM("intCrowd")
			intItemCount = .FORM("intItemCount")

		END WITH

		SELECT CASE Action
		CASE "ADD"

			strItem  = ""
			strValue = ""

			IF bitObjective = "0" THEN
				bitCrowd     = "0"
				intItemCount = 0
			ELSE
				FOR I = 1 TO intItemCount
					IF strItem <> "" THEN strItem = strItem & "|"
					IF strValue <> "" THEN strValue = strValue & "|"
					strItem  = strItem & GetReplaceInput(REQUEST.FORM("strItemSubject")(I), "")
					strValue = strValue & "0"
				NEXT
			END IF

			SET RS = DBCON.EXECUTE("SELECT TOP 1 [intStep] FROM [MPLUS_POLL_ITEM] WHERE [strPollCode] = '" & strPollCode & "' ORDER BY [intStep] DESC ")

			IF RS.EOF THEN intStep = 1 ELSE intStep = RS("intStep") + 1

			DBCON.EXECUTE("INSERT INTO [MPLUS_POLL_ITEM] ([strPollCode], [strSubject], [bitObjective], [bitCrowd], [intCrowd], [intItemCount], [strItem], [strValue], [intStep]) VALUES ('" & strPollCode & "', '" & strSubject & "', '" & bitObjective & "', '" & bitCrowd & "', '" & intCrowd & "', '" & intItemCount & "', '" & strItem & "', '" & strValue & "', '" & intStep & "') ")
	
			strMsg = "설문항목 등록이 완료되었습니다."
	
		CASE "EDIT"

			strItem  = ""

			IF bitObjective = "1" THEN
				FOR I = 1 TO intItemCount
					IF strItem <> "" THEN strItem = strItem & "|"
					strItem  = strItem & GetReplaceInput(REQUEST.FORM("strItemSubject")(I), "")
				NEXT
			END IF
	
			DBCON.EXECUTE("UPDATE [MPLUS_POLL_ITEM] SET [strSubject] = '" & strSubject & "', [bitObjective] = '" & bitObjective & "', [bitCrowd] = '" & bitCrowd & "', [intCrowd] = '" & intCrowd & "', [intItemCount] = '" & intItemCount & "', [strItem] = '" & strItem & "' WHERE [intSeq] = '" & REQUEST.QueryString("intSeq") & "' ")
	
			strMsg = "설문항목 수정이 완료되었습니다."

		END SELECT

	CASE "REMOVE"

		DBCON.EXECUTE("DELETE FROM [MPLUS_POLL_ITEM] WHERE [intSeq] = '" & REQUEST.QueryString("intSeq") & "' ")

		strMsg = "설문항목 삭제가 완료되었습니다."

	CASE "EDITALL"

		FOR I = 1 TO REQUEST.FORM("intSeq").COUNT
			DBCON.EXECUTE("UPDATE [MPLUS_POLL_ITEM] SET [intStep] = '" & REQUEST.FORM("intStep")(I) & "' WHERE [intSeq] = '" & REQUEST.FORM("intSeq")(I) & "' ")
		NEXT

		strMsg = "순서정보가 일괄적으로 수정되었습니다."

	END SELECT

	RESPONSE.WRITE ExecFormSubmit(strMsg, "PollItemList.asp?strPollCode=" & strPollCode, "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>