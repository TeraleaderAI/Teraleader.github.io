<!-- #include file = "PollInclude.asp" -->
<%
	SET RS = DBCON.EXECUTE("SELECT [strSubject], [strTextValue] FROM [MPLUS_POLL_ITEM] WHERE [intSeq] = '" & GetReplaceInput(REQUEST.QueryString("intSeq"), "S") & "' ")

	DIM READ_strSubject, READ_strText, READ_intCount

	READ_strSubject = RS("strSubject")
	READ_strText    = SPLIT(RS("strTextValue"), "|")
	READ_intCount   = UBOUND(READ_strText)

	SET RS = NOTHING : DBCON.CLOSE
%>