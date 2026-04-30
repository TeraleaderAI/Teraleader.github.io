<%
	SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.Command")
	SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RecordSet")

	AdRs_GetRows_Count = ""
	WITH AdCmd
	
		.ActiveConnection = DbConnect
		.CommandText      = "MPLUS_GET_POLL"
		.CommandTimeOut   = 10
		.CommandType      = adCmdStoredProc
		.Parameters.Append	.CreateParameter("strListType",	adVarchar,	adParamInput,	1,	"1")
		.Parameters.Append	.CreateParameter("strPollCode",	adVarchar,	adParamInput,	5,	"P0000")
		.Parameters.Append	.CreateParameter("intPage",	adInteger,	adParamInput,	,	intPage)
		.Parameters.Append	.CreateParameter("intPageSize",	adInteger,	adParamInput,	,	CONF_intLineCount)
		.Parameters.Append	.CreateParameter("strSearchCategory",	adVarchar,	adParamInput,	20,	searchCategory)
		.Parameters.Append	.CreateParameter("strSearchWord",	adVarchar,	adParamInput,	128,	searchWord)
		.Parameters.Append	.CreateParameter("strState",	adVarchar,	adParamInput,	1,	strState)
		.Parameters.Append	.CreateParameter("strState",	adVarchar,	adParamInput,	12,	intNowDate)

		AdRs.Open .Execute
		IF (NOT (AdRs.EOF OR AdRs.BOF)) THEN
			AdRs_GetRows 		= AdRs.GetRows
			AdRs_GetRows_Count	= UBOUND(AdRs_GetRows, 2)
		END IF
		AdRs.Close
			
	END WITH
	
	SET	AdCmd	= NOTHING : SET	AdRS	= NOTHING

	SET RS = NOTHING : DBCON.CLOSE

	IF AdRs_GetRows_Count <> "" THEN
		FOR tmpFor = 0 TO AdRs_GetRows_Count

		LIST_intNumber       = INT(LIST_intTotalCount) - (CONF_intLineCount * (INT(intPage) - 1)) - INT(tmpFor + 1) + 1
		LIST_strPollCode     = AdRs_GetRows(1, tmpFor)
		LIST_strSubject      = AdRs_GetRows(2, tmpFor)
		LIST_strMemo         = AdRs_GetRows(3, tmpFor)
		LIST_intVoteCount    = AdRs_GetRows(5, tmpFor)
		LIST_bitMember       = AdRs_GetRows(6, tmpFor)
		LIST_strStartDate    = LEFT(AdRs_GetRows(11, tmpFor), 4) & "." & MID(AdRs_GetRows(11, tmpFor), 5, 2) & "." & MID(AdRs_GetRows(11, tmpFor), 7, 2)
		LIST_strEndDate      = LEFT(AdRs_GetRows(12, tmpFor), 4) & "." & MID(AdRs_GetRows(12, tmpFor), 5, 2) & "." & MID(AdRs_GetRows(12, tmpFor), 7, 2)
		LIST_bitResultWindow = AdRs_GetRows(13, tmpFor)
		LIST_intResultWidth  = AdRs_GetRows(14, tmpFor)
		LIST_intResultHeight = AdRs_GetRows(15, tmpFor)
		LIST_intRead         = AdRs_GetRows(18, tmpFor)
		LIST_dateRegDate     = AdRs_GetRows(19, tmpFor)
		LIST_intComment      = AdRs_GetRows(20, tmpFor)

		IF (INT(AdRs_GetRows(11, tmpFor)) < INT(intNowDate) OR INT(AdRs_GetRows(11, tmpFor)) = INT(intNowDate)) AND (INT(AdRs_GetRows(12, tmpFor)) > INT(intNowDate) OR INT(AdRs_GetRows(12, tmpFor)) = INT(intNowDate)) THEN
			LIST_strState = "진행중"
			LIST_LINK = "javascript:OnRead('" & LIST_strPollCode & "');"
		ELSE
			LIST_strState = "설문마감"
			LIST_LINK = "javascript:OnResult('" & LIST_strPollCode & "');"
		END IF
%>