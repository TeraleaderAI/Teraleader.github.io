<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM strLoginID, strBoardID, intSeq, strContent

	WITH REQUEST

		strLoginID = GetReplaceInput(.FORM("strLoginID"), "")
		strBoardID = GetReplaceInput(.FORM("strBoardID"), "")
		intSeq     = GetReplaceInput(.FORM("intSeq"), "")
		strContent = GetReplaceInput(.FORM("strContent"), "")

	END WITH

	DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_BAD] ([strLoginID], [strBoardID], [intSeq], [strContent]) VALUES ('" & strLoginID & "', '" & strBoardID & "', '" & intSeq & "', '" & strContent & "') ")

	RESPONSE.WRITE ExecJavaAlert("게시글 신고접수가 완료되었습니다.\n\n관리자가 확인 후 처리하도록 하겠습니다.", 1)
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>