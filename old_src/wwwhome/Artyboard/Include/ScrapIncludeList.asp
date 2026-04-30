<!-- #include file = "ScrapInclude.asp" -->
<%
	SET RS = DBCON.EXECUTE("SELECT COUNT([intSeq]) FROM [MPLUS_SCRAP_LIST] WHERE [strLoginID] = '" & SESSION("strLoginID") & "' ")

	DIM LIST_intTotalCount, LIST_intTotalPage, LIST_intStartPage, LIST_intEndPage, LIST_strPage, LIST_intPage

	LIST_intPage       = intPage
	LIST_intTotalCount = RS(0)
	LIST_intTotalPage  = LIST_intTotalCount / CONF_intLineCount
	IF (LIST_intTotalPage - (LIST_intTotalCount \ CONF_intLineCount)) > 0 THEN LIST_intTotalPage  = INT(LIST_intTotalPage) + 1 ELSE LIST_intTotalPage  = INT(LIST_intTotalPage)
	LIST_intStartPage  = INT((((intPage - 1) \ CONF_intPageCount)) * CONF_intPageCount + 1)
	LIST_intEndPage    = INT(((((intPage - 1) + CONF_intPageCount) \ CONF_intPageCount)) * CONF_intPageCount)
	IF INT(LIST_intTotalPage) < INT(LIST_intEndPage) THEN LIST_intEndPage    = LIST_intTotalPage

	LIST_strPage = ""
	IF INT(intPage) > INT(CONF_intPageCount) THEN
		CONF_strPagePrevGroup = REPLACE(REPLACE(CONF_strPagePrevGroup, "&#39;", ""), "{LINK}", "javascript:OnPageMove(" & LIST_intStartPage - 1 & ");")
		CONF_strPageFirstPage = REPLACE(REPLACE(REPLACE(CONF_strPageFirstPage, "&#39;", ""), "{LINK}", "javascript:OnPageMove(1);"), "{PAGE}", "1")
		LIST_strPage = CONF_strPagePrevGroup & CONF_strPageFirstPage
	END IF

	DIM LIST_strPagePrevLink
	IF intPage > 1 THEN LIST_strPagePrevLink = "javascript:OnPageMove(" & intPage - 1 & ");" ELSE LIST_strPagePrevLink = "javascript:OnPageMove(" & intPage & ");"

	FOR I = LIST_intStartPage TO LIST_intEndPage
		IF INT(I) = INT(intPage) THEN LIST_strPage = LIST_strPage & REPLACE(CONF_strPageNow, "{PAGE}", intPage) ELSE LIST_strPage = LIST_strPage & REPLACE(REPLACE(REPLACE(CONF_strPageDefault, "&#39;", ""), "{LINK}", "javascript:OnPageMove(" & I & ");"), "{PAGE}", I)
	NEXT

	IF INT(LIST_intTotalPage - LIST_intStartPage + 1) > INT(CONF_intPageCount) THEN LIST_strPage = LIST_strPage & REPLACE(REPLACE(REPLACE(CONF_strPageEndPage, "&#39;", ""), "{LINK}", "javascript:OnPageMove(" & LIST_intTotalPage & ");"), "{PAGE}", LIST_intTotalPage)

	IF INT(intPage) + CONF_intPageCount < LIST_intTotalPage + 1 THEN LIST_strPage = LIST_strPage & REPLACE(REPLACE(CONF_strPageNextGroup, "&#39;", ""), "{LINK}", "javascript:OnPageMove(" & LIST_intEndPage + 1 & ");")

	IF INT(intPage) + 1 <= INT(LIST_intTotalPage) THEN LIST_strPageNextLink = "javascript:OnPageMove(" & intPage + 1 & ");" ELSE LIST_strPageNextLink = "javascript:OnPageMove(" & intPage & ");"

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_SCRAP_LIST] '" & SESSION("strLoginID") & "', '" & LIST_intPage & "', '" & CONF_intLineCount & "' ")
%>