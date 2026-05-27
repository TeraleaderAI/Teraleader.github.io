<!-- #include file = "MemoInclude.asp" -->
<%
	DIM MEMO_intPage, MEMO_intPageSize, MEMO_intTotalCount, MEMO_intPageCount, MEMO_strListType, strQuery, MEMO_strUserID, MEMO_strUserName

	MEMO_intPage     = GetReplaceInput(REQUEST("intPage"), "S") : IF MEMO_intPage = "" THEN MEMO_intPage = 1
	MEMO_intPageSize = 10
	MEMO_strListType = GetReplaceInput(REQUEST("strType"), "S")
	MEMO_strUserID   = SESSION("strLoginID")
	MEMO_strUserName = SESSION("strLoginName")

	SELECT CASE UCASE(MEMO_strListType)
	CASE "RECV" : strQuery = " WHERE [strRecvID] = '" & SESSION("strLoginiD") & "' AND [bitDeleteRecv] = '0' "
	CASE "SEND" : strQuery = " WHERE [strSendID] = '" & SESSION("strLoginiD") & "' AND [bitDeleteSend] = '0' "
	CASE ELSE   : strQuery = " WHERE (([strRecvID] = '" & SESSION("strLoginiD") & "' AND [bitDeleteRecv] = '0') OR ([strSendID] = '" & SESSION("strLoginiD") & "' AND [bitDeleteSend] = '0')) "
	END SELECT

	SET RS = DBCON.EXECUTE("SELECT COUNT([intNum]) AS [RecCount] FROM [MPLUS_MEMO] " & strQuery)

	MEMO_intTotalCount = RS(0)
	MEMO_intPageCount = INT((MEMO_intTotalCount - 1) / MEMO_intPageSize) + 1

	SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.Command")
	SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RecordSet")
	
	AdRs_GetRows_Count = ""
	WITH AdCmd
			
		.ActiveConnection = DbConnect
		.CommandText      = "MPLUS_GET_MEMO_LIST"
		.CommandTimeOut   = 10
		.CommandType      = adCmdStoredProc
		.Parameters.Append	.CreateParameter("strLoginID",	adVarchar,	adParamInput, 20,	SESSION("strLoginID"))
		.Parameters.Append	.CreateParameter("strListType",	adVarchar,	adParamInput,  4,	UCASE(MEMO_strListType))
		.Parameters.Append	.CreateParameter("intPageSize",	adInteger,	adParamInput,	  ,	MEMO_intPageSize)
		.Parameters.Append	.CreateParameter("intPage",	    adInteger,	adParamInput,	  ,	MEMO_intPage)

		AdRs.Open .Execute
		IF (NOT (AdRs.EOF OR AdRs.BOF)) THEN
			AdRs_GetRows 		= AdRs.GetRows
			AdRs_GetRows_Count	= UBOUND(AdRs_GetRows, 2)
		END IF
		AdRs.Close
			
	END WITH

	SET AdCmd = NOTHING : SET AdRS = NOTHING

	DIM MEMO_intCount, MEMO_LIST
	MEMO_intCount = AdRs_GetRows_Count

	IF MEMO_intCount <> "" THEN

		REDIM MEMO_REDIM_intViewNum(MEMO_intCount)
		REDIM MEMO_REDIM_intNum(MEMO_intCount)
		REDIM MEMO_REDIM_strType(MEMO_intCount)
		REDIM MEMO_REDIM_strUserID(MEMO_intCount)
		REDIM MEMO_REDIM_strUserNAME(MEMO_intCount)
		REDIM MEMO_REDIM_strContent(MEMO_intCount)
		REDIM MEMO_REDIM_bitRead(MEMO_intCount)
		REDIM MEMO_REDIM_strContent(MEMO_intCount)
		REDIM MEMO_REDIM_dateReadDate(MEMO_intCount)
		REDIM MEMO_REDIM_dateRegDate(MEMO_intCount)
		REDIM MEMO_REDIM_strReadLink(MEMO_intCount)

		FOR MEMO_LIST = 0 TO MEMO_intCount

			MEMO_REDIM_intViewNum(MEMO_LIST)   = INT(MEMO_intTotalCount) - (INT(MEMO_intPageSize) * (INT(MEMO_intPage) - 1)) - MEMO_LIST
			MEMO_REDIM_intNum(MEMO_LIST)       = AdRs_GetRows(0, MEMO_LIST)

			IF AdRs_GetRows(1, MEMO_LIST) = SESSION("strLoginID") THEN
				MEMO_REDIM_strType(MEMO_LIST)     = "SEND"
				MEMO_REDIM_strUserID(MEMO_LIST)   = AdRs_GetRows(2, MEMO_LIST)
				MEMO_REDIM_strUserNAME(MEMO_LIST) = AdRs_GetRows(4, MEMO_LIST)
			ELSE
				MEMO_REDIM_strType(MEMO_LIST)     = "RECV"
				MEMO_REDIM_strUserID(MEMO_LIST)   = AdRs_GetRows(1, MEMO_LIST)
				MEMO_REDIM_strUserNAME(MEMO_LIST) = AdRs_GetRows(3, MEMO_LIST)
			END IF

			MEMO_REDIM_strContent(MEMO_LIST)   = GetReplaceTag2Text(StripTags(AdRs_GetRows(5, MEMO_LIST)))
			MEMO_REDIM_bitRead(MEMO_LIST)      = AdRs_GetRows(6, MEMO_LIST)
			MEMO_REDIM_dateReadDate(MEMO_LIST) = AdRs_GetRows(7, MEMO_LIST)
			MEMO_REDIM_dateRegDate(MEMO_LIST)  = AdRs_GetRows(8, MEMO_LIST)
			MEMO_REDIM_strReadLink(MEMO_LIST)  = "javascript:OnReadMemo('" & AdRs_GetRows(0, MEMO_LIST) & "');"

		NEXT
	END IF

	DIM MEMO_LINK_WRITE, MEMO_LINK_SELECT, MEMO_LINK_SELECT_CHANGE, MEMO_LINK_SELECT_NOT
	MEMO_LINK_WRITE         = "javascript:OnWriteMemo();"
	MEMO_LINK_SELECT        = "javascript:OnSelectAll('s');"
	MEMO_LINK_SELECT_CHANGE = "javascript:OnSelectAll('c');"
	MEMO_LINK_SELECT_NOT    = "javascript:OnSelectAll('n');"

	DIM intBlockPage, I, MEMO_LINK_PAGE
	intBlockPage = INT((MEMO_intPage - 1) / 10) * 10 + 1

	IF intBlockPage = 1 THEN MEMO_LINK_PAGE = "<font color=#CCCCCC>[이전 10개]</font> " ELSE MEMO_LINK_PAGE = "<a href=memo.asp?Action=list&strType=" & MEMO_strListType & "&intPage=" & intBlockPage - 10 & "'>[이전 10개]</a> "

	I = 1
	DO UNTIL I > 10 OR intBlockPage > MEMO_intPageCount
		IF intBlockPage = INT(MEMO_intPage) THEN MEMO_LINK_PAGE = MEMO_LINK_PAGE & " <b>" & intBlockPage & "</b> " ELSE MEMO_LINK_PAGE = MEMO_LINK_PAGE & "[<a href=memo.asp?Action=list&strType=" & MEMO_strListType & "&intPage=" & intBlockPage & ">" & intBlockPage & "</a>]"

		intBlockPage =intBlockPage + 1
		i = i + 1
	LOOP

	IF intBlockPage > MEMO_intPageCount THEN MEMO_LINK_PAGE = MEMO_LINK_PAGE & " <font color=#CCCCCC>[다음 10개]</font>" ELSE MEMO_LINK_PAGE = MEMO_LINK_PAGE & " <a href=memo.asp?Action=list&strType=" & MEMO_strListType & "&intPage=" & intBlockPage & ">[다음 10개]</a>"

	SET RS = NOTHING : DBCON.CLOSE
%>
<script language="javascript">

	var SET_MEMO_LIST_TYPE = "<%=MEMO_strListType%>";
	var SET_MEMO_COUNT     = "<%=MEMO_intTotalCount%>"

</script>