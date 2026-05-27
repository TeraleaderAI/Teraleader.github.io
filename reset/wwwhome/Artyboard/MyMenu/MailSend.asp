<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM strUserID, strLoginID, strSubject, strContent
	DIM strSendName, strSendMail, strRecvName, strRecvMail

	WITH REQUEST

		strUserID  = GetReplaceInput(.FORM("strUserID"), "")
		strLoginID = GetReplaceInput(.FORM("strLoginID"), "")
		strSubject = GetReplaceInput(.FORM("strSubject"), "")
		strContent = GetReplaceInput(.FORM("strContent"), "")

	END WITH

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & strLoginID & "' ")

	strSendName = RS("strLoginName")
	strSendMail = RS("strEmail")

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & strUserID & "' ")

	strRecvName = RS("strLoginName")
	strRecvMail = RS("strEmail")

	CALL sendEmail(strSendName, strSendMail, strRecvName, strRecvMail, strSubject, strContent, "", "", "", "")

	RESPONSE.WRITE ExecFormSubmit("메일발송이 완료되었습니다.", "../MyMenu.asp?Action=email&strUserID=" & strUserID, "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>