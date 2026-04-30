<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardBestList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM Action, intNum, strCode, strName, strMemo, I, strMsg

	Action  = REQUEST.QueryString("Action")
	intNum  = REQUEST.QueryString("intNum")
	strCode = REQUEST.FORM("strCode")
	strName = GetReplaceInput(REQUEST.FORM("strName"), "")
	strMemo = GetReplaceInput(REQUEST.FORM("strMemo"), "")

	SELECT CASE UCASE(Action)
	CASE "ADD"
		SET RS = DBCON.EXECUTE("SELECT TOP 1 [strCode] FROM [MPLUS_BOARD_NOTICE] ORDER BY [strCode] DESC ")
		IF RS.EOF THEN
			strCode = "N001"
		ELSE
			strCode = INT(RIGHT(RS("strCode"), 3)) + 1
			FOR I = LEN(strCode) TO 2
				strCode = "0" & strCode
			NEXT
			strCode = "N" & strCode
		END IF

		DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_NOTICE] ([strCode], [strName], [strMemo]) VALUES ('" & strCode & "', '" & strName & "', '" & strMemo & "') ")

		strMsg = "그룹등록이 완료되었습니다."

	CASE "EDIT"

		DBCON.EXECUTE("UPDATE [MPLUS_BOARD_NOTICE] SET [strName] = '" & strName & "', [strMemo] = '" & strMemo & "' WHERE [intNum] = '" & intNum & "' ")

		strMsg = "그룹수정이 완료되었습니다."

	CASE "REMOVE"

		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_NOTICE] WHERE [intNum] = '" & intNum & "' ")
		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_NOTICE_LIST] WHERE [strCode] = '" & REQUEST.QueryString("strCode") & "' ")

		strMsg = "그룹삭제가 완료되었습니다."

	END SELECT

	RESPONSE.WRITE ExecFormSubmit(strMsg, "BoardBestGroupList.asp", "")
	RESPONSE.End()
	
	SET RS = NOTHING : DBCON.CLOSE
%>