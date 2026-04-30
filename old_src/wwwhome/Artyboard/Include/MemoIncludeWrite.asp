<!-- #include file = "MemoInclude.asp" -->
<%
	DIM strUserID
	strUserID = GetReplaceInput(REQUEST.QueryString("strUserID"), "S")

	IF SESSION("strLoginiD") = strUserID THEN
		RESPONSE.WRITE ExecJavaAlert("자기 자신에게 메모를 보낼수는 없습니다.", 1)
		RESPONSE.End()
	END IF

	DIM MEMO_strRecvID, MEMO_strSendID
	MEMO_strRecvID = strUserID
	MEMO_strSendID = SESSION("strLoginID")

	SET RS = NOTHING : DBCON.CLOSE
%>