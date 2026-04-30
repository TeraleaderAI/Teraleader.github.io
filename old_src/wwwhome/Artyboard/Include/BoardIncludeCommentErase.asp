<!-- #include file = "BoardInclude.asp" -->
<%
	DIM intSeq, intCmtSeq, checkIntSeq, strCmtDeleteMode

	intSeq      = GetReplaceInput(REQUEST.QueryString("intSeq"), "S")
	intCmtSeq   = GetReplaceInput(REQUEST.QueryString("intCmtSeq"), "S")
	checkIntSeq = GetReplaceInput(REQUEST.QueryString("checkIntSeq"), "S")

	IF CONF_bitBoardAdmin = True THEN
		strCmtDeleteMode = 2
	ELSE
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_COMMENT] '" & strBoardID & "', '0', '" & intCmtSeq & "' ")
		IF RS("strLoginID") = "guest" THEN
			strCmtDeleteMode = 1
		ELSE
			IF SESSION("strLoginID") = "" THEN
				strCmtDeleteMode = 0
			ELSE
				IF SESSION("strLoginID") = RS("strLoginID") THEN strCmtDeleteMode = 2 ELSE strCmtDeleteMode = 0
			END IF
		END IF
	END IF

	CMT_DeleteLink = "Include/CommentAction.asp?Action=CMTREMOVE&strBoardID=" & strBoardID & "&intPage=" & intPage & "&intCategory=" & intCategory & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&checkIntSeq=" & checkIntSeq & "&intSeq=" & intSeq & "&strScYear=" & strScYear & "&strScMonth=" & strScMonth & "&strScDay=" & strScDay & "&intCmtSeq=" & intCmtSeq

	CMT_BackLink = "mboard.asp?Action=view&strBoardID=" & strBoardID & "&intPage=" & intPage & "&intCategory=" & intCategory & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intSeq=" & intSeq & "&strScYear=" & strScYear & "&strScMonth=" & strScMonth & "&strScDay=" & strScDay

	SET RS = NOTHING : DBCON.CLOSE
%>
<script language="javascript">

	var SET_strCmtDeleteMode = "<%=strCmtDeleteMode%>";

</script>