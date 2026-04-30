<%
	SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.Command")
	SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RecordSet")

	AdRs_GetRows_Count = ""
	WITH AdCmd

		.ActiveConnection = DbConnect
		.CommandText      = "MPLUS_GET_BOARD_LIST_REPLY"
		.CommandTimeOut   = 10
		.CommandType      = adCmdStoredProc
		.Parameters.Append	.CreateParameter("strBoardID",	adVarchar,	adParamInput,	20,	strBoardID)
		.Parameters.Append	.CreateParameter("intSeq",	adInteger,	adParamInput,	,	intSeq)
		.Parameters.Append	.CreateParameter("bitAdminCheck",	adTinyInt,	adParamInput,		,	GetTrueFalse(CONF_bitAdminCheck))

		AdRs.Open .Execute
		IF (NOT (AdRs.EOF OR AdRs.BOF)) THEN
			AdRs_GetRows 		= AdRs.GetRows
			AdRs_GetRows_Count	= UBOUND(AdRs_GetRows, 2)
		END IF
		AdRs.Close
			
	END WITH
	SET	AdCmd	= NOTHING : SET	AdRS	= NOTHING

	REPLY_COUNT      = AdRs_GetRows_Count
	REPLY_iConFolder = GetListIcon("Folder", CONF_strIconFolder)

	IF REPLY_COUNT = "" THEN REPLY_COUNT = 0

	IF REPLY_COUNT <> 0 THEN
		
		REDIM REPLY_intSeq(REPLY_COUNT)
		REDIM REPLY_intDepth(REPLY_COUNT)
		REDIM REPLY_strName(REPLY_COUNT)
		REDIM REPLY_strSubject(REPLY_COUNT)
		REDIM REPLY_strContent(REPLY_COUNT)
		REDIM REPLY_intRead(REPLY_COUNT)
		REDIM REPLY_intComment(REPLY_COUNT)
		REDIM REPLY_dateRegDate(REPLY_COUNT)
		REDIM REPLY_iConReply(REPLY_COUNT)
		REDIM REPLY_iConNew(REPLY_COUNT)
		REDIM REPLY_iConSecret(REPLY_COUNT)
		REDIM REPLY_strReadLink(REPLY_COUNT)

		FOR REPLY_LIST = 0 TO REPLY_COUNT
			REPLY_intSeq(REPLY_LIST)      = AdRs_GetRows(0, REPLY_LIST)
			REPLY_intDepth(REPLY_LIST)    = AdRs_GetRows(1, REPLY_LIST)

			IF CONF_bitUseNickName = True THEN
				REPLY_strName(REPLY_LIST)     = AdRs_GetRows(17, REPLY_LIST)
				IF REPLY_strName(REPLY_LIST) = "" OR ISNULL(REPLY_strName(REPLY_LIST)) = True THEN
					REPLY_strName(REPLY_LIST)     = GetCutSubject(AdRs_GetRows(3, REPLY_LIST), CONF_intCutName)
				ELSE
					REPLY_strName(REPLY_LIST)     = GetCutSubject(REPLY_strName(REPLY_LIST), CONF_intCutName)
				END IF
			ELSE
				REPLY_strName(REPLY_LIST)     = GetCutSubject(AdRs_GetRows(3, REPLY_LIST), CONF_intCutName)
			END IF

			IF AdRs_GetRows(7, REPLY_LIST) = True THEN
				REPLY_strSubject(REPLY_LIST) = DIM_strBoardMsg(11)
				REPLY_strContent(REPLY_LIST)  = DIM_strBoardMsg(11)
			ELSE
				REPLY_strSubject(REPLY_LIST)  = GetCutSubject(AdRs_GetRows(4, REPLY_LIST), CONF_intCutSubject)
				REPLY_strContent(REPLY_LIST)  = GetCutSubject(AdRs_GetRows(5, REPLY_LIST), CONF_intCutContent)
			END IF
			REPLY_iConSecret(REPLY_LIST)  = AdRs_GetRows(6, REPLY_LIST)
			REPLY_intRead(REPLY_LIST)     = AdRs_GetRows(8, REPLY_LIST)
			REPLY_intComment(REPLY_LIST)  = AdRs_GetRows(9, REPLY_LIST)
			REPLY_dateRegDate(REPLY_LIST) = GetDateType(CONF_strDateListType, AdRs_GetRows(10, REPLY_LIST))
			REPLY_strReadLink(REPLY_LIST) = "javascript:OnReadArticle('" & AdRs_GetRows(0, REPLY_LIST) & "','0');"

			IF REPLY_intDepth(REPLY_LIST) = 0 THEN
				REPLY_iConReply(REPLY_LIST) = False
			ELSE
				REPLY_iConReply(REPLY_LIST) = ""
				FOR I = 1 TO REPLY_intDepth(REPLY_LIST)
					REPLY_iConReply(REPLY_LIST) = REPLY_iConReply(REPLY_LIST) & "&nbsp;&nbsp;"
				NEXT
		
				IF GetListIcon("Reple", CONF_strIconReple) = False THEN REPLY_iConReply(REPLY_LIST) = REPLY_iConReply(REPLY_LIST) & "Re: " ELSE REPLY_iConReply(REPLY_LIST) = REPLY_iConReply(REPLY_LIST) & "<img src='" & GetListIcon("Reple", CONF_strIconReple) & "' align=absmiddle>"
			END IF

			IF GetNewBoardTime(CONF_intNewIconTime, AdRs_GetRows(9, REPLY_LIST)) = True THEN REPLY_iConNew(REPLY_LIST) = GetListIcon("New", CONF_strIconNew) ELSE REPLY_iConNew(REPLY_LIST) = False

			IF AdRs_GetRows(7, REPLY_LIST) = True THEN REPLY_iConSecret(REPLY_LIST) = GetListIcon("Secret", CONF_strIconSecret) ELSE REPLY_iConSecret(REPLY_LIST) = False

		NEXT

		DIM REPLY_iConLine
		REPLY_iConLine   = GetListIcon("Line", CONF_strIconLine)

	END IF
%>