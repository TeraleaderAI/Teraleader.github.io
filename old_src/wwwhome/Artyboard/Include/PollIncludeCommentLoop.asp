<%
	SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.Command")
	SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RecordSet")
		
	AdRs_GetRows_Count = ""
	WITH AdCmd
		
		.ActiveConnection = DbConnect
		.CommandText      = "MPLUS_GET_POLL_COMMENT"
		.CommandTimeOut   = 10
		.CommandType      = adCmdStoredProc
		.Parameters.Append	.CreateParameter("strPollCode",	adVarchar,	adParamInput,	5,	strPollCode)
		
		AdRs.Open .Execute
		IF (NOT (AdRs.EOF OR AdRs.BOF)) THEN
			AdRs_GetRows 		= AdRs.GetRows
			AdRs_GetRows_Count	= UBOUND(AdRs_GetRows, 2)
		END IF
		AdRs.Close
					
	END WITH
		
	SET	AdCmd	= NOTHING : SET	AdRS	= NOTHING

	DIM CMT_intNum, CMT_strLoginID, CMT_strName, CMT_strEmail, CMT_strPwd, CMT_strContent, CMT_intIcon
	DIM CMT_strUserIP, CMT_dateRegDate, CMT_strRemoveLink

	IF AdRs_GetRows_Count <> "" THEN

		FOR tmpFor = 0 TO AdRs_GetRows_Count
	
			CMT_intNum      = AdRs_GetRows(0, tmpFor)
			CMT_strLoginID  = AdRs_GetRows(1, tmpFor)
			CMT_strName     = AdRs_GetRows(2, tmpFor)
			CMT_strEmail    = AdRs_GetRows(3, tmpFor)
			CMT_strPwd      = AdRs_GetRows(4, tmpFor)
			CMT_strContent  = GetReplaceTag2Text(AdRs_GetRows(5, tmpFor))
			CMT_intIcon     = AdRs_GetRows(6, tmpFor)
			CMT_strUserIP   = AdRs_GetRows(7, tmpFor)
			CMT_dateRegDate = AdRs_GetRows(8, tmpFor)

			IF SESSION("strAdmin") = "2" THEN
				CMT_strRemoveLink = "OnCommentRemove('1','" & CMT_intNum & "','" & Action & "');return false;"
			ELSE
				IF CMT_strLoginID = "guest" THEN
					CMT_strRemoveLink = "OnCommentRemove('0','" & CMT_intNum & "','" & Action & "');return false;"
				ELSE
					IF CMT_strLoginID = SESSION("strLoginID") THEN
						CMT_strRemoveLink = "OnCommentRemove('1','" & CMT_intNum & "','" & Action & "');return false;"
					ELSE
						CMT_strRemoveLink = False
					END IF
				END IF
			END IF
%>