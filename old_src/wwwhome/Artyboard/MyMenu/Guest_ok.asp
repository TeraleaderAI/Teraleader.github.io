<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM strAction, strLoginID, strUserID, strContent

	strAction  = UCASE(GetReplaceInput(REQUEST.QueryString("action"), "S"))
	strLoginID = REQUEST.FORM("strLoginID")
	strUserID  = REQUEST.FORM("strUserID")

	SELECT CASE strAction
	CASE "ADD"

		strContent = GetReplaceInput(REQUEST.FORM("strContent"), "")

		DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_GUEST] ([strUserID], [strLoginID], [strContent]) VALUES ('" & strUserID & "', '" & strLoginID & "', '" & strContent & "') ")

	CASE "ERASE"

		SET RS = DBCON.EXECUTE("SELECT [intSeq] FROM [MPLUS_MEMBER_GUEST] WHERE [intSeq] = '" & REQUEST.QueryString("intSeq") & "' AND ([strLoginID] = '" & SESSION("strLoginID") & "' OR [strUserID] = '" & SESSION("strLoginID") & "') ")

		IF RS.EOF THEN
			RESPONSE.WRITE ExecJavaAlert("본인의 글만 삭제가 가능합니다.", 0)
			RESPONSE.End()
		END IF

		DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_GUEST] WHERE [intSeq] = '" & REQUEST.QueryString("intSeq") & "' ")

	END SELECT

	RESPONSE.WRITE ExecFormSubmit("", "../MyMenu.asp?Action=guest&strUserID=" & strUserID, "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>