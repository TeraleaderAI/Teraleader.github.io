<%
	IF LIST_intTotalCount = 0 THEN
		AdRs_GetRows_Count = ""
	ELSE
		SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.Command")
		SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RecordSet")

		AdRs_GetRows_Count = ""
		WITH AdCmd

			.ActiveConnection = DbConnect
			.CommandText      = "MPLUS_GET_BOARD_LIST_CALENDAR"
			.CommandTimeOut   = 10
			.CommandType      = adCmdStoredProc
			.Parameters.Append	.CreateParameter("strBoardID",			adVarChar,	adParamInput,	64,	strBoardID)
			.Parameters.Append	.CreateParameter("strDate",					adVarChar,	adParamInput,	10,	strScYear & "-" & strScMonth & "-" & strScDay)
			.Parameters.Append	.CreateParameter("bitAdminCheck",	adTinyInt,	adParamInput,		,	GetTrueFalse(CONF_bitAdminCheck))

			AdRs.Open .Execute
			IF (NOT (AdRs.EOF OR AdRs.BOF)) THEN
				AdRs_GetRows 		= AdRs.GetRows
				AdRs_GetRows_Count	= UBOUND(AdRs_GetRows, 2)
			END IF
			AdRs.Close
				
		END WITH
		SET	AdRS	= Nothing : SET	AdCmd	= Nothing
	END IF

	IF AdRs_GetRows_Count <> "" THEN
		FOR tmpFor = 0 TO AdRs_GetRows_Count
%>
<!-- #include file = "BoardIncludeLoop.asp" -->