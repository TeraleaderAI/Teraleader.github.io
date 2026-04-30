<%
	SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.Command")
	SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RecordSet")

	AdRs_GetRows_Count = ""
	WITH AdCmd
	
		.ActiveConnection = DbConnect
		.CommandText      = "MPLUS_GET_POLL_ITEM"
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
	SET RS = NOTHING : DBCON.CLOSE

	IF AdRs_GetRows_Count = "" OR ISNULL(AdRs_GetRows_Count) = True THEN
		RESPONSE.WRITE ExecFormSubmit("설문조사 항목이 없습니다.", "poll.asp?Action=list", "")
		RESPONSE.End()
	END IF
%>
<script language="javascript">

	function makeApplFormData(req, objective, crowd1, crowd2, itemcount){
		this.require = req;
		this.objective = objective;
		this.crowd1 = crowd1;
		this.crowd2 = crowd2;
		this.itemcount = itemcount;
	}

	var arApplForm = new Array();

<%
	FOR tmpFor = 0 TO AdRs_GetRows_Count
		RESPONSE.WRITE "	arApplForm[" & tmpFor & "] = new makeApplFormData('" & AdRs_GetRows(0, tmpFor) & "', '" & AdRs_GetRows(2, tmpFor) & "','" & AdRs_GetRows(3, tmpFor) & "','" & AdRs_GetRows(4, tmpFor) & "', '" & AdRs_GetRows(5, tmpFor) & "');" & vbcrlf
	NEXT
%>
</script>
<%
	DIM ITEM_intSeq, ITEM_strSubject, ITEM_bitObjective, ITEM_bitCrowd, ITEM_intCrowd, ITEM_intItemCount, ITEM_strItem
	DIM ITEM_strValue, ITEM_strTextValue, ITEM_strTextResultLink

	FOR tmpFor = 0 TO AdRs_GetRows_Count

		ITEM_intSeq            = AdRs_GetRows(0, tmpFor)
		ITEM_strSubject        = AdRs_GetRows(1, tmpFor)
		ITEM_bitObjective      = AdRs_GetRows(2, tmpFor)
		ITEM_bitCrowd          = AdRs_GetRows(3, tmpFor)
		ITEM_intCrowd          = AdRs_GetRows(4, tmpFor)
		ITEM_intItemCount      = AdRs_GetRows(5, tmpFor)
		ITEM_strItem           = AdRs_GetRows(6, tmpFor)
		ITEM_strValue          = AdRs_GetRows(7, tmpFor)
		ITEM_strTextValue      = AdRs_GetRows(8, tmpFor)
		ITEM_strTextResultLink = "javascript:OnTextResult('" & ITEM_intSeq & "');"

		IF ITEM_strItem <> "" AND ISNULL(ITEM_strItem) = False THEN ITEM_strItem = SPLIT(ITEM_strItem, "|")
		IF ITEM_strValue <> "" AND ISNULL(ITEM_strValue) = False THEN ITEM_strValue = SPLIT(ITEM_strValue, "|")
		IF ITEM_strTextValue <> "" AND ISNULL(ITEM_strTextValue) = False THEN ITEM_strTextValue = SPLIT(ITEM_strTextValue, "|")
%>