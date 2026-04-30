<!-- #include file = "MemoInclude.asp" -->
<%
	DIM intNum
	intNum = GetReplaceInput(REQUEST.QueryString("intNum"), "S")

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMO_READ] '" & intNum & "', '" & SESSION("strLoginID") & "' ")

	DIM MEMO_strSendID, MEMO_strRecvID, MEMO_strContent, MEMO_dateReadDate, MEMO_dateRegDate, MEMO_strSendName, MEMO_strRecvName
	DIM MEMO_strReplyLink, MEMO_strRemoveLink

	MEMO_strSendID    = RS("strSendID")
	MEMO_strRecvID    = RS("strRecvID")
	MEMO_strContent   = RS("strContent")
	MEMO_dateReadDate = RS("dateReadDate")
	MEMO_dateRegDate  = RS("dateRegDate")
	MEMO_strSendName  = RS("strSendName")
	MEMO_strRecvName  = RS("strRecvName")
	MEMO_strReplyLink = "javascript:OnReplyMemo('" & MEMO_strSendID & "');"
	MEMO_strRemoveLink = "javascript:OnRemoveRead('" & RS("intNum") & "');"

	IF MEMO_strSendID = SESSION("strLoginID") THEN
		IF RS("bitDeleteSend") = True THEN
			RESPONSE.WRITE ExecJavaAlert("삭제된 메모입니다.", 1)
			RESPONSE.End()
		END IF
	END IF

	IF MEMO_strRecvID = SESSION("strLoginID") THEN
		IF RS("bitDeleteRecv") = True THEN
			RESPONSE.WRITE ExecJavaAlert("삭제된 메모입니다.", 1)
			RESPONSE.End()
		END IF
	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>