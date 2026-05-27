<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM mode, strLoginID, strKey
	mode       = GetReplaceInput(REQUEST.QueryString("mode"), "S")
	strLoginID = GetReplaceInput(REQUEST.QueryString("strLoginID"), "S")
	strKey     = GetReplaceInput(REQUEST.QueryString("key"), "")

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_ACTIVATE] '" & strLoginID & "', '" & strKey & "' ")

	IF RS.EOF THEN
		RESPONSE.WRITE ExecJavaAlert("재인증 정보가 없습니다.", 1)
		RESPONSE.End()
	ELSE
		SELECT CASE mode
		CASE "JOIN"
			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [bitAuth] = '1' WHERE [strLoginID] = '" & strLoginID & "' ")
		CASE "EDIT"
			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strEmail] = '" & RS("strEmail") & "' WHERE [strLoginID] = '" & strLoginID & "' ")
		END SELECT
		DBCON.EXECUTE("DELETE FROM [MPLUS_ACTIVATE] WHERE [strLoginID] = '" & strLoginID & "' AND [strNumBer] = '" & strKey & "' ")
	END IF

	RESPONSE.WRITE ExecJavaAlert("인증처리가 완료되었습니다.", 1)
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>