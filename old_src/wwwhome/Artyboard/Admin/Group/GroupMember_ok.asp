<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Group/GroupBoardList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM Action, strGroupCode, I
	Action       = REQUEST.QueryString("Action")
	strGroupCode = REQUEST.QueryString("strGroupCode")

	SELECT CASE UCASE(Action)
	CASE "SREMOVE", "REMOVE"

		IF UCASE(Action) = "SREMOVE" THEN
			FOR I = 1 TO REQUEST.FORM("strLoginID").COUNT
				DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_GROUP_MEMBER] WHERE [strLoginID] = '" & REQUEST.FORM("strLoginID")(I) & "' AND [strGroupCode] = '" & strGroupCode & "' ")
			NEXT
		ELSE
			DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_GROUP_MEMBER] WHERE [strLoginID] = '" & REQUEST.QueryString("strLoginID") & "' AND [strGroupCode] = '" & strGroupCode & "' ")
		END IF

		RESPONSE.WRITE "<script language=javascript>" & vbcrlf
		RESPONSE.WRITE "parent.document.frames('GroupMemberSearchList').location = ""GroupMemberSearchList.asp?strGroupCode=" & strGroupCode & """;"
		RESPONSE.WRITE "</script>" & vbcrlf
		RESPONSE.WRITE ExecFormSubmit("선택된 회원삭제가 완료되었습니다.", "GroupMemberList.asp?strGroupCode=" & strGroupCode, "")
		RESPONSE.End()

	CASE "SADD", "ADD"
		IF UCASE(Action) = "SADD" THEN
			FOR I = 1 TO REQUEST.FORM("strLoginID").COUNT
				DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_GROUP_MEMBER] ([strGroupCode], [strLoginID]) VALUES ('" & strGroupCode & "', '" & REQUEST.FORM("strLoginID")(I) & "') ")
			NEXT
		ELSE
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_GROUP_MEMBER] ([strGroupCode], [strLoginID]) VALUES ('" & strGroupCode & "', '" & REQUEST.QueryString("strLoginID") & "') ")
		END IF

		RESPONSE.WRITE "<script language=javascript>" & vbcrlf
		RESPONSE.WRITE "parent.document.frames('GroupMemberList').location = ""GroupMemberList.asp?strGroupCode=" & strGroupCode & """;"
		RESPONSE.WRITE "</script>" & vbcrlf
		RESPONSE.WRITE ExecFormSubmit("선택된 회원등록이 완료되었습니다.", "GroupMemberSearchList.asp?strGroupCode=" & strGroupCode, "")
		RESPONSE.End()

	END SELECT

	DBCON.CLOSE
%>