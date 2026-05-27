<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM strBoardID, Action, I, strBoardIDTemp, Query

	Action     = GetReplaceInput(REQUEST.QueryString("Action"), "S")
	strBoardID = GetReplaceInput(REQUEST.QueryString("strBoardID"), "S")

	IF Action = "1" THEN
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '" & strBoardID & "' ")
	ELSE
		strBoardIDTemp = SPLIT(strBoardID,",")
		Query = ""
		FOR I = 0 TO UBOUND(strBoardIDTemp)
			IF Query <> "" THEN Query = Query & ","
			Query = Query & "'" & strBoardIDTemp(I) & "'"
		NEXT
		Query = " WHERE [strBoardID] IN (" & Query & ") "
		SET RS = DBCON.EXECUTE("SELECT [strBoardID] FROM [MPLUS_BOARD_CONFIG_DEFAULT] " & Query)
	END IF

	IF RS.EOF THEN
		RESPONSE.WRITE "<script language=javascript>" & vbcrlf
		RESPONSE.WRITE "alert('사용가능한 게시판 아이디 입니다.');" & vbcrlf
		RESPONSE.WRITE "window.returnValue=1;" & vbcrlf
		RESPONSE.WRITE "self.close();" & vbcrlf
		RESPONSE.WRITE "</script>" & vbcrlf
	ELSE
		RESPONSE.WRITE "<script language=javascript>" & vbcrlf
		RESPONSE.WRITE "alert('이미사용되고 있는 게시판 아이디 입니다.');" & vbcrlf
		RESPONSE.WRITE "window.returnValue=0;" & vbcrlf
		RESPONSE.WRITE "self.close();" & vbcrlf
		RESPONSE.WRITE "</script>" & vbcrlf
	END IF
%>
<% SET RS = NOTHING : DBCON.CLOSE %>