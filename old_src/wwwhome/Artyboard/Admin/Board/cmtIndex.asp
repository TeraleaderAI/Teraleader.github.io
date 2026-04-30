<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM strBoardID, tmpIntCmtThread, tmpCount
	strBoardID = GetReplaceInput(REQUEST.QueryString("strBoardID"), "S")

	SET RS = DBCON.EXECUTE("SELECT [intSeq], [intCmtThread], [intDepth] FROM [MPLUS_BOARD_COMMENT] WHERE [strBoardID] = '" & strBoardID & "' AND [bitDelete] = '0' ORDER BY [intCmtThread] ")

	tmpIntCmtThread = 0
	tmpCount        = 0

	WHILE NOT(RS.EOF)

		IF RS("intDepth") = 0 THEN
			tmpCount = tmpCount + 1
			tmpIntCmtThread = tmpCount * 100
		ELSE
			tmpIntCmtThread = tmpIntCmtThread + 1
		END IF

		DBCON.EXECUTE("UPDATE [MPLUS_BOARD_COMMENT] SET [intCmtThread] = '" & tmpIntCmtThread & "' WHERE [intSeq] = '" & RS("intSeq") & "' ")

	RS.MOVENEXT
	WEND

	RESPONSE.WRITE "<script language=javascript>" & vbcrlf
	RESPONSE.WRITE "alert('인덱스 재구성이 완료되었습니다.');" & vbcrlf
	RESPONSE.WRITE "self.close();" & vbcrlf
	RESPONSE.WRITE "</script>" & vbcrlf
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>