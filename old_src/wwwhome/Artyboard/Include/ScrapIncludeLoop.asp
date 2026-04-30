<%
	DIM AdRs_GetRows_Count, AdRs_GetRows, AdCmd, AdRS
	DIM LIST_intSeq, LIST_strLoginID, LIST_strBoardID, LIST_strBoardName, LIST_intBoardNum, LIST_strSubject, LIST_strComment
	DIM LIST_dateRegDate, LIST_intNum, LIST_BoardLink1, LIST_BoardLink2, LIST_RemoveLink

	IF LIST_intTotalCount = 0 THEN
		AdRs_GetRows_Count = ""
	ELSE
		SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.Command")
		SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RecordSet")
	
		AdRs_GetRows_Count = ""
		WITH AdCmd

			.ActiveConnection = DbConnect
			.CommandText      = "MPLUS_GET_SCRAP_LIST"
			.CommandTimeOut   = 10
			.CommandType      = adCmdStoredProc
			.Parameters.Append	.CreateParameter("strLoginID",			adVarChar,	adParamInput,	20,	SESSION("strLoginID"))
			.Parameters.Append	.CreateParameter("intPage",					adInteger,	adParamInput,		,	intPage)
			.Parameters.Append	.CreateParameter("intPageSize",			adInteger,	adParamInput,		,	CONF_intLineCount)

			AdRs.Open .Execute
			IF (NOT (AdRs.EOF OR AdRs.BOF)) THEN
				AdRs_GetRows 		= AdRs.GetRows
				AdRs_GetRows_Count	= UBOUND(AdRs_GetRows, 2)
			END IF
			AdRs.Close
				
		END WITH
		SET	AdRS	= Nothing : SET	AdCmd	= Nothing

	END IF

	SET RS = NOTHING : DBCON.CLOSE

	IF AdRs_GetRows_Count <> "" THEN
		FOR tmpFor = 0 TO AdRs_GetRows_Count

			LIST_intSeq       = AdRs_GetRows(0, tmpFor)
			LIST_strLoginID   = AdRs_GetRows(1, tmpFor)
			LIST_strBoardID   = AdRs_GetRows(2, tmpFor)
			LIST_strBoardName = AdRs_GetRows(3, tmpFor)
			LIST_intBoardNum  = AdRs_GetRows(4, tmpFor)
			LIST_strSubject   = AdRs_GetRows(5, tmpFor)
			LIST_strComment   = AdRs_GetRows(6, tmpFor)
			LIST_dateRegDate  = AdRs_GetRows(7, tmpFor)
			LIST_intNumber    = INT(LIST_intTotalCount) - (CONF_intLineCount * (INT(intPage) - 1)) - INT(tmpFor + 1) + 1
			LIST_BoardLink1   = "Mboard.asp?strBoardID=" & LIST_strBoardID
			LIST_BoardLink2   = "Mboard.asp?Action=view&strBoardID=" & LIST_strBoardID + "&intSeq=" & LIST_intBoardNum
			LIST_RemoveLink   = "javascript:OnRemove('" & LIST_intSeq & "');"
%>