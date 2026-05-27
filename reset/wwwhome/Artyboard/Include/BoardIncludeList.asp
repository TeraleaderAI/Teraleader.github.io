<!-- #include file = "BoardInclude.asp" -->
<%
	IF CONF_bitListLevel = False THEN
		IF SESSION("strLoginID") = "" AND CONF_bitListLevelLogin = True THEN
			RESPONSE.WRITE "<script language=javascript>" & vbcrlf
			RESPONSE.WRITE "location.href=LINK_LOGIN;" & vbcrlf
			RESPONSE.WRITE "</script>" & vbcrlf
			RESPONSE.End()
		ELSE
			IF CONF_strListLevelUrl <> "" AND ISNULL(CONF_strListLevelUrl) = False THEN

				CONF_strListLevelUrl = CONF_strListLevelUrl & "?strPrevUrl=" & Request.ServerVariables("url") & "?" & Replace(Request.ServerVariables("QUERY_STRING"), "&", "--**--" )

				RESPONSE.WRITE ExecFormSubmit(CONF_strListLevelMsg, CONF_strListLevelUrl, "")
				RESPONSE.End()
			ELSE
				IF INSTR(1, UCASE(Request.ServerVariables("HTTP_REFERER")), "Action=LOGIN_OK") = "0" THEN
					RESPONSE.WRITE ExecJavaAlert(CONF_strListLevelMsg, 0)
					RESPONSE.End()
				ELSE
					RESPONSE.WRITE ExecFormSubmit(CONF_strListLevelMsg, sitePath, "")
					RESPONSE.End()
				END IF
			END IF
		END IF
	END IF

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_LIST] '" & strBoardID & "' ")

	DIM CONF_intRowCount, CONF_intLineCount, CONF_intListImgWidth, CONF_intListImgHeight, CONF_intLineHeight, CONF_bitMouseOver
	DIM CONF_strMouseOverColor, CONF_bitPreview, CONF_intPreviewCut, CONF_intPreviewWidth, CONF_intCutSubject, CONF_intCutContent
	DIM CONF_intCutName, CONF_strNameClick, CONF_strViewType, CONF_intPopViewWidth, CONF_intPopViewHeight, CONF_strDateType
	DIM CONF_intColorListCount, CONF_strColorNoticeBg, CONF_strColorNoticeFont, CONF_strColorRepleBg, CONF_strColorRepleFont
	DIM CONF_strColorListOddBg, CONF_strColorListEvenBg, CONF_bitColorListBgGrd, CONF_strColorListOddFont, CONF_strColorListEvenFont
	DIM CONF_bitColorListFontGrd, CONF_strColorListRead, CONF_strColorListReadFont, CONF_strIconFolder, CONF_strIconNotice
	DIM CONF_strIconNew, CONF_strIconReple, CONF_strIconLine, CONF_strIconSecret, CONF_strIconRead, CONF_bitUseSelectView
	DIM CONF_intNewIconTime, CONF_strBadSubject, CONF_strLinkHomepage, CONF_strLinkHomepageTarget, CONF_intPageCount, CONF_strPagePrevGroup
	DIM CONF_strPageNextGroup, CONF_strPageFirstPage, CONF_strPageEndPage, CONF_strPageNow, CONF_strPageDefault, CONF_bitUseSearch
	DIM CONF_intSearchCount, CONF_strSeaechTag, CONF_bitUseUpload
	DIM CONF_bitUseLink1, CONF_bitUseLink2, CONF_iConFolder, CONF_iConNew, CONF_iConReply, CONF_iConReplySpace, CONF_iConSecret
	DIM CONF_bitThrum, CONF_intThrumWidth, CONF_intThrumHeight, CONF_intListCount
	
	CONF_intRowCount           = RS("intRowCount")
	CONF_intLineCount          = RS("intLineCount")
	CONF_intLineHeight         = RS("intLineHeight")
	CONF_intListImgWidth       = RS("intListImgWidth")
	CONF_intListImgHeight      = RS("intListImgHeight")
	CONF_bitMouseOver          = RS("bitMouseOver")
	CONF_strMouseOverColor     = RS("strMouseOverColor")
	CONF_bitPreview            = RS("bitPreview")
	CONF_intPreviewCut         = RS("intPreviewCut")
	CONF_intPreviewWidth       = RS("intPreviewWidth")
	CONF_intCutSubject         = RS("intCutSubject")
	CONF_intCutContent         = RS("intCutContent")
	CONF_intCutName            = RS("intCutName")
	CONF_strNameClick          = RS("strNameClick")
	CONF_strViewType           = RS("strViewType")
	CONF_intPopViewWidth       = RS("intPopViewWidth")
	CONF_intPopViewHeight      = RS("intPopViewHeight")
	CONF_strDateType           = RS("strDateType")
	CONF_intColorListCount     = -1
	CONF_strColorNoticeBg      = RS("strColorNoticeBg")
	CONF_strColorNoticeFont    = RS("strColorNoticeFont")
	CONF_strColorRepleBg       = RS("strColorRepleBg")
	CONF_strColorRepleFont     = RS("strColorRepleFont")
	CONF_strColorListOddBg     = RS("strColorListOddBg")
	CONF_strColorListEvenBg    = RS("strColorListEvenBg")
	CONF_bitColorListBgGrd     = RS("bitColorListBgGrd")
	CONF_strColorListOddFont   = RS("strColorListOddFont")
	CONF_strColorListEvenFont  = RS("strColorListEvenFont")
	CONF_bitColorListFontGrd   = RS("bitColorListFontGrd")
	CONF_strColorListReadBg    = RS("strColorListReadBg")
	CONF_strColorListReadFont  = RS("strColorListReadFont")
	CONF_strIconFolder         = GetListIcon("Folder", RS("strIconFolder"))
	CONF_strIconNotice         = GetListIcon("Notice", RS("strIconNotice"))
	CONF_strIconNew            = RS("strIconNew")
	CONF_strIconReple          = RS("strIconReple")
	CONF_strIconLine           = GetListIcon("Line", RS("strIconLine"))
	CONF_strIconSecret         = RS("strIconSecret")
	CONF_strIconRead           = RS("strIconRead")
	CONF_strIconNewCmt         = RS("strIconNewCmt")
	CONF_bitUseSelectView      = RS("bitUseSelectView")
	IF CONF_bitBoardAdmin = True THEN CONF_bitUseSelectView = True
	CONF_intNewIconTime        = RS("intNewIconTime")
	CONF_strBadSubject         = RS("strBadSubject")
	CONF_strLinkHomepage       = RS("strLinkHomepage")
	CONF_strLinkHomepageTarget = RS("strLinkHomepageTarget")
	IF CONF_strLinkHomepage = "" OR ISNULL(CONF_strLinkHomepage) = True THEN CONF_strLinkHomepage = False
	CONF_intPageCount          = RS("intPageCount")

	CONF_strPagePrevGroup      = REPLACE(RS("strPagePrevGroup"), "{SKINPATH}", skinPath)
	CONF_strPageNextGroup      = REPLACE(RS("strPageNextGroup"), "{SKINPATH}", skinPath)
	CONF_strPageFirstPage      = REPLACE(RS("strPageFirstPage"), "{SKINPATH}", skinPath)
	CONF_strPageEndPage        = REPLACE(RS("strPageEndPage"),   "{SKINPATH}", skinPath)
	CONF_strPageNow            = REPLACE(RS("strPageNow"),       "{SKINPATH}", skinPath)
	CONF_strPageDefault        = REPLACE(RS("strPageDefault"),   "{SKINPATH}", skinPath)

	CONF_bitUseSearch          = RS("bitUseSearch")
	CONF_intSearchCount        = RS("intSearchCount")
	CONF_strSeaechTag          = RS("strSeaechTag")
	CONF_bitUseLink1           = RS("bitUseLink1")
	CONF_bitUseLink2           = RS("bitUseLink2")
	CONF_bitUseUpload          = RS("bitUseUpload")
	CONF_bitThrum              = RS("bitThrum")
	CONF_intThrumWidth         = RS("intThrumWidth")
	CONF_intThrumHeight        = RS("intThrumHeight")

	IF CONF_bitColorListBgGrd = True THEN
		DIM intStepRgb1, intStepRgb2, intStepRgb3
		intStepRgb1 = Hex2Dec(LEFT(REPLACE(CONF_strColorListOddBg, "#", ""), 2))
		intStepRgb2 = Hex2Dec(MID(REPLACE(CONF_strColorListOddBg, "#", ""), 3, 2))
		intStepRgb3 = Hex2Dec(RIGHT(REPLACE(CONF_strColorListOddBg, "#", ""), 2))
		intStepRgb1 = INT(255 - intStepRgb1)
		intStepRgb2 = INT(255 - intStepRgb2)
		intStepRgb3 = INT(255 - intStepRgb3)
	END IF

	IF CONF_bitColorListFontGrd = True THEN
		DIM intStepRgbFont1, intStepRgbFont2, intStepRgbFont3
		intStepRgbFont1 = Hex2Dec(LEFT(REPLACE(CONF_strColorListOddFont, "#", ""), 2))
		intStepRgbFont2 = Hex2Dec(MID(REPLACE(CONF_strColorListOddFont, "#", ""), 3, 2))
		intStepRgbFont3 = Hex2Dec(RIGHT(REPLACE(CONF_strColorListOddFont, "#", ""), 2))
		intStepRgbFont1 = INT(255 - intStepRgbFont1)
		intStepRgbFont2 = INT(255 - intStepRgbFont2)
		intStepRgbFont3 = INT(255 - intStepRgbFont3)
	END IF

	SELECT CASE UCASE(CONF_strSkinGroup)
	CASE "CALENDAR"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_COUNT_CALENDAR] '" & strBoardID & "', '" & strScYear & "-" & GetCharDate(strScMonth) & "-" & GetCharDate(strScDay) & "', '" & GetTrueFalse(CONF_bitAdminCheck) & "' ")
	CASE ELSE
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_COUNT] '" & strBoardID & "', '" & intCategory & "', '" & bitSearchType01 & "', '" & bitSearchType02 & "', '" & bitSearchType03 & "', '" & bitSearchType04 & "', '" & strSearchWord & "', '" & GetTrueFalse(CONF_bitAdminCheck) & "' ")
	END SELECT

	DIM LIST_intTotalCount, LIST_intTotalPage, LIST_intStartPage, LIST_intEndPage, LIST_strPage, LIST_intPage, intPageTemp

	LIST_intPage       = intPage
	LIST_intTotalCount = RS(0)
	LIST_intTotalPage  = LIST_intTotalCount / (CONF_intLineCount * CONF_intRowCount)

	IF (LIST_intTotalPage - (LIST_intTotalCount \ CONF_intLineCount * CONF_intRowCount)) > 0 THEN LIST_intTotalPage  = INT(LIST_intTotalPage) + 1 ELSE LIST_intTotalPage  = INT(LIST_intTotalPage)

	LIST_intStartPage  = INT((((intPage - 1) \ CONF_intPageCount)) * CONF_intPageCount + 1)
	LIST_intEndPage    = INT(((((intPage - 1) + CONF_intPageCount) \ CONF_intPageCount)) * CONF_intPageCount)

	IF INT(LIST_intTotalPage) < INT(LIST_intEndPage) THEN LIST_intEndPage = LIST_intTotalPage

	LIST_strPage = ""

	intPageTemp = INT((intPage - 1) / CONF_intPageCount) * CONF_intPageCount + 1

	IF intPageTemp <> 1 THEN LIST_strPage = LIST_strPage & REPLACE(REPLACE(CONF_strPagePrevGroup, "&#39;", ""), "{LINK}", "javascript:OnPageMove(" & intPageTemp - CONF_intPageCount & ");")

	IF intPage > 1 THEN LIST_strPage = LIST_strPage & REPLACE(REPLACE(REPLACE(CONF_strPageFirstPage, "&#39;", ""), "{LINK}", "javascript:OnPageMove(" & intPage - 1 & ");"), "{PAGE}", "1")

	DIM LIST_strPagePrevLink
	IF intPage > 1 THEN LIST_strPagePrevLink = "javascript:OnPageMove(" & intPage - 1 & ");" ELSE LIST_strPagePrevLink = "javascript:OnPageMove(" & intPage & ");"

	FOR I = LIST_intStartPage TO LIST_intEndPage

		IF INT(I) = INT(intPage) THEN LIST_strPage = LIST_strPage & REPLACE(CONF_strPageNow, "{PAGE}", intPage) ELSE LIST_strPage = LIST_strPage & REPLACE(REPLACE(REPLACE(CONF_strPageDefault, "&#39;", ""), "{LINK}", "javascript:OnPageMove(" & I & ");"), "{PAGE}", I)

		intPageTemp = intPageTemp + 1

	NEXT

	IF INT(intPage) + 1 <= INT(LIST_intTotalPage) THEN LIST_strPage = LIST_strPage & REPLACE(REPLACE(REPLACE(CONF_strPageEndPage, "&#39;", ""), "{LINK}", "javascript:OnPageMove(" & intPage + 1 & ");"), "{PAGE}", LIST_intTotalPage)

	IF intPageTemp < LIST_intTotalPage THEN LIST_strPage = LIST_strPage & REPLACE(REPLACE(CONF_strPageNextGroup, "&#39;", ""), "{LINK}", "javascript:OnPageMove(" & LIST_intEndPage + 1 & ");")

	IF INT(intPage) + 1 <= INT(LIST_intTotalPage) THEN LIST_strPageNextLink = "javascript:OnPageMove(" & intPage + 1 & ");" ELSE LIST_strPageNextLink = "javascript:OnPageMove(" & intPage & ");"

	DIM LIST_intSeqNow
	LIST_intSeqNow = GetReplaceInput(REQUEST.QueryString("intSeq"), "S")

	RESPONSE.WRITE "<div id=""id_preview"" style=""position:absolute; left:0px; top:10px; width:" & CONF_intPreviewWidth & "px; z-index:1; overflow-x:hidden; visibility:hidden;"" class=""border""></div>" & vbcrlf
%>
<script language="javascript">
	var SET_READ_TYPE         = "<%=CONF_strViewType%>";
	var SET_READ_POPUP_WIDTH  = "<%=CONF_intPopViewWidth%>";
	var SET_READ_POPUP_HEIGHT = "<%=CONF_intPopViewHeight%>";
	var SET_BOARD_SEARCH      = "<%=CONF_bitUseSearch%>";
</script>
<%
	DIM AdRs_intSeq, AdRs_intIndex, AdRs_intThread, AdRs_intDepth, AdRs_strLoginID, AdRs_intCategory, AdRs_strName, AdRs_strNickName
	DIM AdRs_strPassword, AdRs_strEmail, AdRs_strHomepage, AdRs_strSubject, AdRs_strSubjectStyle, AdRs_strContent
	DIM AdRs_strLink1, AdRs_strLink2, AdRs_strBoardBg, AdRs_strIpAddr, AdRs_bitDelete, AdRs_bitHtml, AdRs_bitHtmlBr, AdRs_bitText
	DIM AdRs_bitNotice, AdRs_bitReMail, AdRs_bitSecret, AdRs_strSecretID, AdRs_bitBad, AdRs_intRead, AdRs_intVote, AdRs_intComment
	DIM AdRs_intFileCount, AdRs_intImgount, AdRs_strFileCode, AdRs_dateCmtDate, AdRs_dateRegDate, AdRs_strMarkImage
	DIM AdRs_strUserImage, AdRs_strFileName, AdRs_strFileImage, AdRs_strCategory
	DIM AdRs_strAddData1, AdRs_strAddData2, AdRs_strAddData3, AdRs_strAddData4, AdRs_strAddData5
	DIM AdRs_strAddData6, AdRs_strAddData7, AdRs_strAddData8, AdRs_strAddData9, AdRs_strAddData10

	DIM LIST_intSeq, LIST_intIndex, LIST_intThread, LIST_intDepth, LIST_strLoginID, LIST_intCategory, LIST_strName
	DIM LIST_strNickName, LIST_strPassword, LIST_strEmail, LIST_strHomepage, LIST_strSubject, LIST_strContent, LIST_strContentPrev
	DIM LIST_strLink, LIST_strLink1, LIST_strLinkTarget1, LIST_strLink2
	DIM LIST_strLinkTarget2, LIST_strBoardBg, LIST_strIpAddr, LIST_bitDelete, LIST_bitHtml, LIST_bitHtmlRe, LIST_bitText
	DIM LIST_bitNotice, LIST_bitReMail, LIST_bitSecret, LIST_strSecretID, LIST_bitBad, LIST_intRead, LIST_intVote, LIST_intComment

	DIM LIST_intFileCount, LIST_intImgCount, LIST_strFileCode, LIST_strFileName, LIST_strFileLink
	DIM LIST_dateCmtDate, LIST_dateRegDate, LIST_strMarkImage, List_strUserImage, LIST_strNameImage, LIST_strPhotoImage
	DIM LIST_strFileImage, LIST_strCategory, LIST_strReadLink, LIST_iConFolder, List_iConNotice, LIST_iConNew, LIST_iConReply
	DIM LIST_iConLine, LIST_iConSecret, LIST_iConRead, LIST_iConNewCmt, LIST_intViewNum, LIST_intViewNumTemp, LIST_strFileImageWidth
	DIM LIST_strFileImageHeight, LIST_strFileImageSize, LIST_strFileImageLink, CONF_bitEditLevel, CONF_bitRemoveLevel
	DIM LIST_strAddData1, LIST_strAddData2, LIST_strAddData3, LIST_strAddData4, LIST_strAddData5
	DIM LIST_strAddData6, LIST_strAddData7, LIST_strAddData8, LIST_strAddData9, LIST_strAddData10

	LIST_intViewNumTemp = 0

	DIM AdCmd, AdRS, AdRs_GetRows, AdRs_GetRows_Count
%>