<%
	SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.Command")
	SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RecordSet")

	AdRs_GetRows_Count = ""
	WITH AdCmd
			
		.ActiveConnection	= DbConnect
		.CommandText    = "MPLUS_GET_BOARD_NOTICE_LIST"
		.CommandTimeOut = 10
		.CommandType    = adCmdStoredProc
		.Parameters.Append	.CreateParameter("strBoardID",			adVarChar,	adParamInput,	64,	strBoardID)
		.Parameters.Append	.CreateParameter("intCategory",			adTinyInt,	adParamInput,		,	intCategory)
		.Parameters.Append	.CreateParameter("bitSearchType01",	adTinyInt,	adParamInput,		,	bitSearchType01)
		.Parameters.Append	.CreateParameter("bitSearchType02",	adTinyInt,	adParamInput,		,	bitSearchType02)
		.Parameters.Append	.CreateParameter("bitSearchType03",	adTinyInt,	adParamInput,		,	bitSearchType03)
		.Parameters.Append	.CreateParameter("bitSearchType04",	adTinyInt,	adParamInput,		,	bitSearchType04)
		.Parameters.Append	.CreateParameter("strSearchTxt",		adVarChar,	adParamInput,	32,	strSearchWord)

		AdRs.Open .Execute

		IF (NOT (AdRs.EOF OR AdRs.BOF)) THEN
			AdRs_GetRows 		= AdRs.GetRows
			AdRs_GetRows_Count	= UBOUND(AdRs_GetRows, 2)
		END IF

		AdRs.Close
			
	END WITH

	IF AdRs_GetRows_Count <> "" THEN
		FOR tmpFor = 0 TO AdRs_GetRows_Count
%>
<!-- #include file = "BoardIncludeLoop.asp" -->