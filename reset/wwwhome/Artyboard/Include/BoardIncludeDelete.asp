<!-- #include file = "BoardInclude.asp" -->
<%
	DIM intSeq, strMoveUrl, strBoardDeleteMode
	intSeq = GetReplaceInput(REQUEST.QueryString("intSeq"), "S")

	IF CONF_bitBoardAdmin = True THEN
		strBoardDeleteMode = 2
	ELSE
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_READ_DEFAULT] '" & intSeq & "' ")
		IF RS("strLoginID") = "guest" THEN
			strBoardDeleteMode = 1
		ELSE
			IF SESSION("strLoginID") = "" THEN
				strBoardDeleteMode = 0
			ELSE
				IF SESSION("strLoginID") = RS("strLoginID") THEN strBoardDeleteMode = 2 ELSE strBoardDeleteMode = 1
			END IF
		END IF
	END IF

	strFormLink = "Include/BoardErase.asp?strBoardID=" & strBoardID & "&intPage=" & intPage & "&intCategory=" & intCategory & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intSeq=" & intSeq

	SET RS = NOTHING : DBCON.CLOSE
%>
<script language="javascript">

	var SET_strBoardDeleteMode = "<%=strBoardDeleteMode%>";

</script>