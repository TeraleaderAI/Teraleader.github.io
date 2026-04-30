<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Group/MailingGroupList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM Action, strCode, I
	Action  = REQUEST.QueryString("Action")
	strCode = REQUEST.QueryString("strCode")

	SELECT CASE UCASE(Action)
	CASE "SREMOVE", "REMOVE"

		IF UCASE(Action) = "SREMOVE" THEN
			FOR I = 1 TO REQUEST.FORM("strLoginID").COUNT
				DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_MAILING_MEMBER] WHERE [strLoginID] = '" & REQUEST.FORM("strLoginID")(I) & "' AND [strGroup] = '" & strCode & "' ")
			NEXT
		ELSE
			DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_MAILING_MEMBER] WHERE [strLoginID] = '" & REQUEST.QueryString("strLoginID") & "' AND [strGroup] = '" & strCode & "' ")
		END IF

		RESPONSE.WRITE "<script language=javascript>" & vbcrlf
		RESPONSE.WRITE "parent.document.frames('MailingGroupMemberSearchList').location = ""MailingGroupMemberSearchList.asp?strCode=" & strCode & """;"
		RESPONSE.WRITE "</script>" & vbcrlf
		RESPONSE.WRITE ExecFormSubmit("선택된 회원삭제가 완료되었습니다.", "MailingGroupMemberList.asp?strCode=" & strCode, "")
		RESPONSE.End()

	CASE "SADD", "ADD"
		IF UCASE(Action) = "SADD" THEN
			FOR I = 1 TO REQUEST.FORM("strLoginID").COUNT
				DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_MAILING_MEMBER] ([strGroup], [strLoginID]) VALUES ('" & strCode & "', '" & REQUEST.FORM("strLoginID")(I) & "') ")
			NEXT
		ELSE
			DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_MAILING_MEMBER] ([strGroup], [strLoginID]) VALUES ('" & strCode & "', '" & REQUEST.QueryString("strLoginID") & "') ")
		END IF

		RESPONSE.WRITE "<script language=javascript>" & vbcrlf
		RESPONSE.WRITE "parent.document.frames('MailingGroupMemberList').location = ""MailingGroupMemberList.asp?strCode=" & strCode & """;"
		RESPONSE.WRITE "</script>" & vbcrlf
		RESPONSE.WRITE ExecFormSubmit("선택된 회원등록이 완료되었습니다.", "MailingGroupMemberSearchList.asp?strCode=" & strCode, "")
		RESPONSE.End()

	END SELECT

	DBCON.CLOSE
%>