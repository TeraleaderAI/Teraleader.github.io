<%
	SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.Command")
	SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RecordSet")
	
	AdRs_GetRows_Count = ""
	WITH AdCmd
			
		.ActiveConnection = DbConnect
		.CommandText      = "MPLUS_GET_BOARD_COMMENT"
		.CommandTimeOut   = 10
		.CommandType      = adCmdStoredProc
		.Parameters.Append	.CreateParameter("strBoardID",	adVarchar,	adParamInput, 20,	strBoardID)
		.Parameters.Append	.CreateParameter("intThread",	adInteger,	adParamInput,	,	AdRs_intThread)

		AdRs.Open .Execute
		IF (NOT (AdRs.EOF OR AdRs.BOF)) THEN
			AdRs_GetRows 		= AdRs.GetRows
			AdRs_GetRows_Count	= UBOUND(AdRs_GetRows, 2)
		END IF
		AdRs.Close
			
	END WITH

	SET AdCmd = NOTHING : SET AdRS = NOTHING

	CMT_intCount = AdRs_GetRows_Count

	IF CMT_intCount <> "" THEN

		REDIM CMT_REDIM_intSeq(CMT_intCount)
		REDIM CMT_REDIM_intCmtThread(CMT_intCount)
		REDIM CMT_REDIM_intDepth(CMT_intCount)
		REDIM CMT_REDIM_intScore(CMT_intCount)
		REDIM CMT_REDIM_intIcon(CMT_intCount)
		REDIM CMT_REDIM_strLoginID(CMT_intCount)
		REDIM CMT_REDIM_strName(CMT_intCount)
		REDIM CMT_REDIM_strNickName(CMT_intCount)
		REDIM CMT_REDIM_strContent(CMT_intCount)
		REDIM CMT_REDIM_dateRegDate(CMT_intCount)
		REDIM CMT_REDIM_strMarkName(CMT_intCount)
		REDIM CMT_REDIM_NameImage(CMT_intCount)
		REDIM CMT_REDIM_PhotoImage(CMT_intCount)
		REDIM CMT_REDIM_strBoardBg(CMT_intCount)
		REDIM CMT_REDIM_strIpAddr(CMT_intCount)
		REDIM CMT_REDIM_Edit(CMT_intCount)
		REDIM CMT_REDIM_Remove(CMT_intCount)

		FOR CMT_LIST = 0 TO CMT_intCount

			CMT_REDIM_intSeq(CMT_LIST)       = AdRs_GetRows(0, CMT_LIST)
			CMT_REDIM_intCmtThread(CMT_LIST) = AdRs_GetRows(1, CMT_LIST)
			CMT_REDIM_intDepth(CMT_LIST)     = AdRs_GetRows(2, CMT_LIST)
			CMT_REDIM_intScore(CMT_LIST)     = AdRs_GetRows(4, CMT_LIST)
			CMT_REDIM_intIcon(CMT_LIST)      = AdRs_GetRows(5, CMT_LIST)
			CMT_REDIM_strLoginID(CMT_LIST)   = AdRs_GetRows(6, CMT_LIST)
			CMT_REDIM_strName(CMT_LIST)      = AdRs_GetRows(7, CMT_LIST)
			CMT_REDIM_strNickName(CMT_LIST)  = AdRs_GetRows(8, CMT_LIST)

			IF CONF_bitUseNickName = True THEN
				IF CMT_REDIM_strLoginID(CMT_LIST) <> "guest" AND CMT_REDIM_strLoginID(CMT_LIST) <> "" AND ISNULL(CMT_REDIM_strLoginID(CMT_LIST)) = False THEN
					CMT_REDIM_strName(CMT_LIST) = CMT_REDIM_strNickName(CMT_LIST)
					IF TRIM(CMT_REDIM_strName(CMT_LIST)) = "" THEN CMT_REDIM_strName(CMT_LIST) = AdRs_GetRows(7, CMT_LIST)
				ELSE
					CMT_REDIM_strName(CMT_LIST) = AdRs_GetRows(7, CMT_LIST)
				END IF
			END IF

			IF AdRs_GetRows(3, CMT_LIST) = True THEN CMT_REDIM_strContent(CMT_LIST)  = GetReplaceTag2Html(AdRs_GetRows(11, CMT_LIST)) ELSE CMT_REDIM_strContent(CMT_LIST)  = GetReplaceTag2Text(AdRs_GetRows(11, CMT_LIST))

			IF AdRs_GetRows(12, CMT_LIST) <> "" AND ISNULL(AdRs_GetRows(12, CMT_LIST)) = False THEN
				CMT_REDIM_strIpAddr(CMT_LIST) = REPLACE(AdRs_GetRows(12, CMT_LIST), MID(AdRs_GetRows(12, CMT_LIST), InStrRev(AdRs_GetRows(12, CMT_LIST), ".")), ".*")
			ELSE
				CMT_REDIM_strIpAddr(CMT_LIST) = "none"
			END IF

			CMT_REDIM_dateRegDate(CMT_LIST) = GetDateType(CONF_strDateTypeComment, AdRs_GetRows(13, CMT_LIST))
			CMT_REDIM_strMarkName(CMT_LIST) = AdRs_GetRows(14, CMT_LIST)
			IF CONF_bitUseMarkAvata = True THEN
				IF CMT_REDIM_strMarkName(CMT_LIST) = "" OR ISNULL(CMT_REDIM_strMarkName(CMT_LIST)) = True THEN CMT_REDIM_strMarkName(CMT_LIST) = False ELSE CMT_REDIM_strMarkName(CMT_LIST) = "<img src='Pds/Member/GroupIcon/" & CMT_REDIM_strMarkName(CMT_LIST) & "' align='absmiddle'>"
			ELSE
				CMT_REDIM_strMarkName(CMT_LIST) = False
			END IF

			CMT_REDIM_NameImage(CMT_LIST)   = AdRs_GetRows(15, CMT_LIST)

			IF CONF_bitUseNameAvata = True THEN
				IF CMT_REDIM_NameImage(CMT_LIST) = "" OR ISNULL(CMT_REDIM_NameImage(CMT_LIST)) = True THEN CMT_REDIM_NameImage(CMT_LIST) = False ELSE CMT_REDIM_NameImage(CMT_LIST) = "<img src='Pds/Member/Name/" & CMT_REDIM_NameImage(CMT_LIST) & "' align='absmiddle'>"
			ELSE
				CMT_REDIM_NameImage(CMT_LIST) = False
			END IF

			CMT_REDIM_PhotoImage(CMT_LIST)  = AdRs_GetRows(16, CMT_LIST)
			IF CMT_REDIM_PhotoImage(CMT_LIST) = "" OR ISNULL(CMT_REDIM_PhotoImage(CMT_LIST)) = True THEN CMT_REDIM_PhotoImage(CMT_LIST) = False ELSE CMT_REDIM_PhotoImage(CMT_LIST) = "<img src='Pds/Member/Photo/" & CMT_REDIM_PhotoImage(CMT_LIST) & "' align='absmiddle'>"

			IF AdRs_GetRows(17, CMT_LIST) = "" AND ISNULL(AdRs_GetRows(17, CMT_LIST)) = True THEN
				CMT_REDIM_strBoardBg(CMT_LIST) = False
			ELSE
				IF LEN(AdRs_GetRows(17, CMT_LIST)) = 7 THEN
					CMT_REDIM_strBoardBg(CMT_LIST) = " bgcolor=""" & AdRs_GetRows(17, CMT_LIST) & """"
				ELSE
					CMT_REDIM_strBoardBg(CMT_LIST) = " background=""" & AdRs_GetRows(17, CMT_LIST) & """"
				END IF
			END IF

			IF CONF_bitBoardAdmin = True THEN
				CMT_REDIM_Remove(CMT_LIST) = 1
				CMT_REDIM_Edit(CMT_LIST)   = True
			ELSE
				IF SESSION("strLoginID") = "" THEN
					IF CMT_REDIM_strLoginID(CMT_LIST) = "guest" THEN
						CMT_REDIM_Remove(CMT_LIST) = 2
						CMT_REDIM_Edit(CMT_LIST)   = True
					ELSE
						CMT_REDIM_Remove(CMT_LIST) = 0
						CMT_REDIM_Edit(CMT_LIST)   = False
					END IF
				ELSE
					IF SESSION("strLoginID") = CMT_REDIM_strLoginID(CMT_LIST) THEN
						CMT_REDIM_Remove(CMT_LIST) = 1
						CMT_REDIM_Edit(CMT_LIST)   = True
					ELSE
						CMT_REDIM_Remove(CMT_LIST) = 0
						CMT_REDIM_Edit(CMT_LIST)   = False
					END IF
				END IF
			END IF

			IF CONF_bitCommentEdit  = False THEN CMT_REDIM_Edit(CMT_LIST) = False

		NEXT
	END IF
%>
<script language="javascript">

	var SET_Editor_FilePath = "Pds/Board/<%=strBoardID%>/Editor/";

</script>
<script type="text/javascript" language="javascript" src="Editor/cheditor.js"></script>
<script language="javascript">

	var myeditor = new cheditor("myeditor");

	myeditor.config.editorWidth = '<%=CONF_strEditorWidth%>';
	myeditor.config.editorHeight = '<%=CONF_strEditorHeight%>';
	myeditor.config.ieEnterMode = 'br';
<%
	IF CONF_bitEditorZoom = True THEN
		RESPONSE.WRITE "	myeditor.config.imgReSize = true;" & vbcrlf
		RESPONSE.WRITE "	myeditor.config.imgMaxWidth = " & CONF_intEditorZoomSize(0) & ";" & vbcrlf
		RESPONSE.WRITE "	myeditor.config.imgMaxHeight = " & CONF_intEditorZoomSize(1) & ";" & vbcrlf
	ELSE
		RESPONSE.WRITE "	myeditor.config.imgReSize = false;" & vbcrlf
	END IF
%>
<% IF CONF_bitEditorSource = False THEN RESPONSE.WRITE "	myeditor.config.useSource = false;" & vbcrlf %>
<% IF CONF_bitEditorPrev = False THEN RESPONSE.WRITE "	myeditor.config.usePreview = false;" & vbcrlf %>
	myeditor.config.editorBgcolor = "<%=CONF_strEditorBgColor%>";
	myeditor.inputForm = 'cmtContent';

</script>