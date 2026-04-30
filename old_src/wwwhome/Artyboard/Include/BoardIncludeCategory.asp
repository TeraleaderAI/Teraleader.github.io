<%
	IF CONF_bitUseCategory = True THEN

		SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.Command")
		SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RecordSet")
	
		AdRs_GetRows_Count = ""
		WITH AdCmd
	
			.ActiveConnection = DbConnect
			.CommandText      = "MPLUS_GET_BOARD_CATEGORY"
			.CommandTimeOut   = 10
			.CommandType      = adCmdStoredProc
			.Parameters.Append	.CreateParameter("strBoardID",	adVarchar,	adParamInput,	20,	strBoardID)
	
			AdRs.Open .Execute
			IF (NOT (AdRs.EOF OR AdRs.BOF)) THEN
				AdRs_GetRows 		= AdRs.GetRows
				AdRs_GetRows_Count	= UBOUND(AdRs_GetRows, 2)
			END IF
			AdRs.Close
				
		END WITH
	
		SET	AdCmd	= NOTHING : SET	AdRS	= NOTHING
	
		CATEGORY_COUNT      = AdRs_GetRows_Count

		REDIM CATEGORY_intCategory(CATEGORY_COUNT)
		REDIM CATEGORY_strCategory(CATEGORY_COUNT)
		REDIM CATEGORY_intCategoryCount(CATEGORY_COUNT)
		REDIM CATEGORY_intStep(CATEGORY_COUNT)
		REDIM CATEGORY_strFileName1(CATEGORY_COUNT)
		REDIM CATEGORY_strFileName2(CATEGORY_COUNT)
		REDIM CATEGORY_strLink(CATEGORY_COUNT)

		FOR CATEGORY_LIST = 0 TO CATEGORY_COUNT
	
			CATEGORY_intCategory(CATEGORY_LIST)      = AdRs_GetRows(0, CATEGORY_LIST)
			CATEGORY_strCategory(CATEGORY_LIST)      = AdRs_GetRows(1, CATEGORY_LIST)
			CATEGORY_intCategoryCount(CATEGORY_LIST) = AdRs_GetRows(2, CATEGORY_LIST)
			CATEGORY_intStep(CATEGORY_LIST)          = AdRs_GetRows(3, CATEGORY_LIST)
			CATEGORY_strFileName1(CATEGORY_LIST)     = AdRs_GetRows(4, CATEGORY_LIST)
			CATEGORY_strFileName2(CATEGORY_LIST)     = AdRs_GetRows(5, CATEGORY_LIST)
			CATEGORY_strLink(CATEGORY_LIST)          = "javascript:OnCategoryGo('" & CATEGORY_intCategory(CATEGORY_LIST) & "');"

			IF CATEGORY_strFileName1(CATEGORY_LIST) <> "" AND ISNULL(CATEGORY_strFileName1(CATEGORY_LIST)) = False THEN CATEGORY_strFileName1(CATEGORY_LIST) = "Pds/Board/" & strBoardID & "/Category/" & CATEGORY_strFileName1(CATEGORY_LIST)
			IF CATEGORY_strFileName2(CATEGORY_LIST) <> "" AND ISNULL(CATEGORY_strFileName2(CATEGORY_LIST)) = False THEN CATEGORY_strFileName2(CATEGORY_LIST) = "Pds/Board/" & strBoardID & "/Category/" & CATEGORY_strFileName2(CATEGORY_LIST)

		NEXT

		strCategorySelect = "<select name=intCategory id=intCategory OnChange=OnCategoryGo(this.value); class=CateListForm>" & vbcrlf
		strCategoryList   = ""

		FOR CATEGORY_LIST = 0 TO CATEGORY_COUNT
	
			IF INT(intCategory) = INT(CATEGORY_intCategory(CATEGORY_LIST)) THEN
				strCategorySelected = " SELECTED "
				strNowCategoryName  = CATEGORY_strCategory(CATEGORY_LIST)
			ELSE
				strCategorySelected = ""
			END IF
				strCategorySelect = strCategorySelect & "<option value='" & CATEGORY_intCategory(CATEGORY_LIST) & "'" & strCategorySelected & ">" & CATEGORY_strCategory(CATEGORY_LIST)
				IF CATEGORY_intCategory(CATEGORY_LIST) <> 0 THEN strCategorySelect = strCategorySelect & " (" & CATEGORY_intCategoryCount(CATEGORY_LIST) & ")"
				strCategorySelect = strCategorySelect & "</option>" & vbcrlf
				strCategoryList = strCategoryList & "<a href=""javascript:OnCategoryGo('" & CATEGORY_intCategory(CATEGORY_LIST) & "');"">" & CATEGORY_strCategory(CATEGORY_LIST) & " (" & CATEGORY_intCategoryCount(CATEGORY_LIST) & ")</a>&nbsp;"
	
		NEXT
	
		strCategorySelect = strCategorySelect & "</select>" & vbcrlf

	END IF
%>