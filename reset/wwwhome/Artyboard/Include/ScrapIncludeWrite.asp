<!-- #include file = "ScrapInclude.asp" -->
<%
	DIM strBoardID, intSeq, ScrapBoardName, ScrapSubject

	strBoardID = GetReplaceInput(REQUEST.QueryString("strBoardID"), "S")
	intSeq     = GetReplaceInput(REQUEST.QueryString("intSeq"), "S")

	SET RS = DBCON.EXECUTE("SELECT [intSeq] FROM [MPLUS_SCRAP_LIST] WHERE [strLoginID] = '" & SESSION("strLoginID") & "' AND [strBoardID] = '" & strBoardID & "' AND [intBoardNum] = '" & intSeq & "' ")

	IF NOT(RS.EOF) THEN
		RESPONSE.WRITE "<script language=javascript>" & vbcrlf
		RESPONSE.WRITE "	if (confirm('이미 스크랩하신 게시글 입니다.\n\n지금 스크랩을 확인하시겠습니까?')){" & vbcrlf
		RESPONSE.WRITE "		opener.location.href='scrap.asp?Action=list';" & vbcrlf
		RESPONSE.WRITE "		self.close();" & vbcrlf
		RESPONSE.WRITE "	}else{" & vbcrlf
		RESPONSE.WRITE "		self.close();" & vbcrlf
		RESPONSE.WRITE "	}" & vbcrlf
		RESPONSE.WRITE "</script>" & vbcrlf
		RESPONSE.End()
	END IF

	SET RS = DBCON.EXECUTE("SELECT [strBoardName] = (SELECT [strName] FROM [MPLUS_BOARD_CONFIG_DEFAULT] WHERE [strBoardID] = [MPLUS_BOARD].[strBoardID]), [strSubject] FROM [MPLUS_BOARD] WHERE [intSeq] = '" & intSeq & "' ")

	ScrapBoardName = RS("strBoardName")
	ScrapSubject   = RS("strSubject")

	SET RS = NOTHING : DBCON.CLOSE
%>
<script language="javascript">

	var SET_strBoardID = "<%=strBoardID%>";
	var SET_intSeq     = "<%=intSeq%>";
	var SET_strLoginID = "<%=SESSION("strLoginID")%>";

</script>