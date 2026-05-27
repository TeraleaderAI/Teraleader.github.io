<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM Action, strCode, strName, strMemo, strMsg
	Action    = UCASE(REQUEST.QueryString("Action"))

	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	IF Action = "REMOVE" THEN isAdminPopup = False ELSE isAdminPopup = True
	strAdminPrevUrl = "Group/MailingGroupList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	SELECT CASE Action
	CASE "ADD", "EDIT"

		strCode = REQUEST.FORM("strCode")
		strName = GetReplaceInput(REQUEST.FORM("strName"), "")
		strMemo = GetReplaceInput(REQUEST.FORM("strMemo"), "")

		SELECT CASE Action
		CASE "ADD"
			DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_MAILING_GROUP] ([strCode], [strName], [strMemo]) VALUES ('" & strCode & "', '" & strName & "', '" & strMemo & "') ")
			strMsg = "그룹생성이 완료되었습니다."
		CASE "EDIT"
			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_MAILING_GROUP] SET [strName] = '" & strName & "', [strMemo] = '" & strMemo & "' WHERE [strCode] = '" & strCode & "' ")
			strMsg = "그룹수정이 완료되었습니다."
		END SELECT

		RESPONSE.WRITE ExecJavaAlertLayer(strMsg, "MailingGroupList.asp")
		RESPONSE.End()

	CASE "REMOVE"

		DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_MAILING_GROUP] WHERE [strCode] = '" & REQUEST.QueryString("strCode") & "' ")
		DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_MAILING_MEMBER] WHERE [strGroup] = '" & REQUEST.QueryString("strCode") & "' ")

		RESPONSE.WRITE ExecFormSubmit("그룹삭제가 완료되었습니다.", "MailingGroupList.asp", "")
		RESPONSE.End()

	END SELECT

	DBCON.CLOSE
%>