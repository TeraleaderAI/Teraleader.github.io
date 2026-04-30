<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM Action, I
	Action = UCASE(REQUEST.QueryString("Action"))

	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	IF Action = "REMOVE" THEN isAdminPopup = False ELSE isAdminPopup = True
	strAdminPrevUrl = "Group/GroupBoardList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	RESPONSE.EXPIRES     = 0
	SERVER.SCRIPTTIMEOUT = 2000

	SELECT CASE Action
	CASE "ADD", "EDIT"

		DIM strGroupCode, strGroupName, strGroupMemo, strNotMsg, strMoveUrl
	
		WITH REQUEST
	
			strGroupCode = .FORM("strGroupCode")
			strGroupName = GetReplaceInput(.FORM("strGroupName"), "")
			strGroupMemo = GetReplaceInput(.FORM("strGroupMemo"), "")
			strNotMsg    = GetReplaceInput(.FORM("strNotMsg"), "")
			strMoveUrl   = GetReplaceInput(.FORM("strMoveUrl"), "")
	
		END WITH

		SELECT CASE Action
		CASE "ADD"

			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_GROUP] ([strGroupCode], [strGroupName], [strGroupMemo], [strNotMsg], [strMoveUrl]) VALUES ('" & strGroupCode & "', '" & strGroupName & "', '" & strGroupMemo & "', '" & strNotMsg & "', '" & strMoveUrl & "') ")
			
			RESPONSE.WRITE ExecJavaAlertLayer("신규그룹 등록이 완료되었습니다.", "GroupBoardList.asp")
			RESPONSE.End()

		CASE "EDIT"

			DBCON.EXECUTE("UPDATE [MPLUS_BOARD_GROUP] SET [strGroupName] = '" & strGroupName & "', [strGroupMemo] = '" & strGroupMemo & "', [strNotMsg] = '" & strNotMsg & "', [strMoveUrl] = '" & strMoveUrl & "' WHERE [strGroupCode] = '" & strGroupCode & "' ")
	
			RESPONSE.WRITE ExecJavaAlertLayer("그룹 수정이 완료되었습니다.", "GroupBoardList.asp")
			RESPONSE.End()

		END SELECT

	CASE "REMOVE"

		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_GROUP] WHERE [strGroupCode] = '" & REQUEST.QueryString("strGroupCode") & "' ")
		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_GROUP_MEMBER] WHERE [strGroupCode] = '" & REQUEST.QueryString("strGroupCode") & "' ")
		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_GROUP_BOARD] WHERE [strGroupCode] = '" & REQUEST.QueryString("strGroupCode") & "' ")

		RESPONSE.WRITE ExecFormSubmit("그룹 삭제가 완료되었습니다.", "GroupBoardList.asp", "")
		RESPONSE.End()

	CASE "MOVE"

		FOR I = 1 TO REQUEST.FORM("strBoardList").COUNT
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_GROUP_BOARD] ([strGroupCode], [strBoardID]) VALUES ('" & REQUEST.QueryString("strGroupCode") & "', '" & REQUEST.FORM("strBoardList")(I) & "') ")
		NEXT

		RESPONSE.WRITE ExecFormSubmit("", "GroupBoard.asp?strGroupCode=" & REQUEST.QueryString("strGroupCode"), "")
		RESPONSE.End()

	CASE "NOUSE"

		FOR I = 1 TO REQUEST.FORM("strBoardGroupList").COUNT
			DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_GROUP_BOARD] WHERE [strGroupCode] = '" & REQUEST.QueryString("strGroupCode") & "' AND [strBoardiD] = '" & REQUEST.FORM("strBoardGroupList")(I) & "' ")
		NEXT

		RESPONSE.WRITE ExecFormSubmit("", "GroupBoard.asp?strGroupCode=" & REQUEST.QueryString("strGroupCode"), "")
		RESPONSE.End()

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>