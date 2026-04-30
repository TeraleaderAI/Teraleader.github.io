<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM strBoardID
	strBoardID = GetReplaceInput(REQUEST.QueryString("strBoardID"), "S")

	DBCON.EXECUTE("EXEC [MPLUS_BOARD_INDEX] '" & strBoardID & "', '1' ")

	RESPONSE.WRITE "<script language=javascript>" & vbcrlf
	RESPONSE.WRITE "alert('인덱스 재구성이 완료되었습니다.');" & vbcrlf
	RESPONSE.WRITE "self.close();" & vbcrlf
	RESPONSE.WRITE "</script>" & vbcrlf
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>