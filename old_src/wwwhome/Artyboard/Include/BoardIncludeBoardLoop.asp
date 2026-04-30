<%
	IF LIST_intTotalCount = 0 THEN
		AdRs_GetRows_Count = ""
	ELSE
		SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.Command")
		SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RecordSet")
	
		AdRs_GetRows_Count = ""
		WITH AdCmd

			.ActiveConnection = DbConnect
			.CommandText      = "MPLUS_GET_BOARD_LIST"
			.CommandTimeOut   = 10
			.CommandType      = adCmdStoredProc
			.Parameters.Append	.CreateParameter("strBoardID",			adVarChar,	adParamInput,	64,	strBoardID)
			.Parameters.Append	.CreateParameter("intCategory",			adTinyInt,	adParamInput,		,	intCategory)
			.Parameters.Append	.CreateParameter("intIndexSize",		adSmallInt,	adParamInput,		,	500)
			.Parameters.Append	.CreateParameter("intPageSize",			adTinyInt,	adParamInput,		,	CONF_intLineCount * CONF_intRowCount)
			.Parameters.Append	.CreateParameter("intPage",					adInteger,	adParamInput,		,	intPage)
			.Parameters.Append	.CreateParameter("bitSearchType01",	adTinyInt,	adParamInput,		,	bitSearchType01)
			.Parameters.Append	.CreateParameter("bitSearchType02",	adTinyInt,	adParamInput,		,	bitSearchType02)
			.Parameters.Append	.CreateParameter("bitSearchType03",	adTinyInt,	adParamInput,		,	bitSearchType03)
			.Parameters.Append	.CreateParameter("bitSearchType04",	adTinyInt,	adParamInput,		,	bitSearchType04)
			.Parameters.Append	.CreateParameter("strSearchTxt",		adVarChar,	adParamInput,	32,	strSearchWord)
			.Parameters.Append	.CreateParameter("bitAdminCheck",	adTinyInt,	adParamInput,		,	GetTrueFalse(CONF_bitAdminCheck))

			AdRs.Open .Execute
			IF (NOT (AdRs.EOF OR AdRs.BOF)) THEN
				AdRs_GetRows 		= AdRs.GetRows
				AdRs_GetRows_Count	= UBOUND(AdRs_GetRows, 2)
			END IF
			AdRs.Close
				
		END WITH
		SET	AdRS	= Nothing : SET	AdCmd	= Nothing

		IF AdRs_GetRows_Count <> "" THEN
			intStepRgb1 = intStepRgb1 - INT(intStepRgb1 / (AdRs_GetRows_Count + 1))
			intStepRgb1 = INT(intStepRgb1 / (AdRs_GetRows_Count + 1))
			intStepRgb2 = intStepRgb2 - INT(intStepRgb2 / (AdRs_GetRows_Count + 1))
			intStepRgb2 = INT(intStepRgb2 / (AdRs_GetRows_Count + 1))
			intStepRgb3 = intStepRgb3 - INT(intStepRgb3 / (AdRs_GetRows_Count + 1))
			intStepRgb3 = INT(intStepRgb3 / (AdRs_GetRows_Count + 1))
		
			intStepRgbFont1 = intStepRgbFont1 - INT(intStepRgbFont1 / (AdRs_GetRows_Count + 1))
			intStepRgbFont1 = INT(intStepRgbFont1 / (AdRs_GetRows_Count + 1))
			intStepRgbFont2 = intStepRgbFont2 - INT(intStepRgbFont2 / (AdRs_GetRows_Count + 1))
			intStepRgbFont2 = INT(intStepRgbFont2 / (AdRs_GetRows_Count + 1))
			intStepRgbFont3 = intStepRgbFont3 - INT(intStepRgbFont3 / (AdRs_GetRows_Count + 1))
			intStepRgbFont3 = INT(intStepRgbFont3 / (AdRs_GetRows_Count + 1))
		END IF
	END IF

	IF AdRs_GetRows_Count <> "" THEN
		FOR tmpFor = 0 TO AdRs_GetRows_Count
%>
<!-- #include file = "BoardIncludeLoop.asp" -->