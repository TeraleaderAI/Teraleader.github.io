<!--METADATA TYPE="typelib" NAME="ADODB Type Library" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"-->
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM strBoardID, Action, intCategory, strSearchCategory, strSearchWord, intPage, isSearch
	strBoardID        = GetReplaceInput(REQUEST.QueryString("strBoardID"), "S")
	Action            = UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))
	intCategory       = GetReplaceInput(REQUEST.QueryString("intCategory"), "S")
	strSearchCategory = GetReplaceInput(REQUEST.QueryString("strSearchCategory"), "S")
	strSearchWord     = GetReplaceInput(REQUEST.QueryString("strSearchWord"), "S")
	intPage           = GetReplaceInput(REQUEST.QueryString("intPage"), "S")

	IF Action               = "" THEN Action            = "LIST"
	IF intCategory          = "" THEN intCategory       = 0
	IF strSearchCategory    = "" THEN strSearchCategory = "|s_name|s_subject|"
	IF TRIM(strSearchWord) <> "" THEN isSearch          = True
	IF intPage              = "" THEN intPage           = 1
	
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '" & strBoardID & "', '" & SESSION("strLoginID") & "' ")

	DIM CONF_strSkin, CONF_strSkinGroup, skinPath, CONF_bitUseMarkAvata, CONF_bitUseNameAvata, CONF_bitUseCategory
	DIM CONF_bitUseVote, CONF_bitUseComment, CONF_bitUseScrap, CONF_bitUseMemo, CONF_bitUseNickName, CONF_bitUseBad
	DIM CONF_intColSpan, CONF_intUserLevel, CONF_bitBoardAdmin, CONF_bitAdminCheck, CONF_bitUseRss, CONF_strLanguage

	CONF_strSkin            = RS("strSkin")
	CONF_strSkinGroup       = RS("strSkinGroup")
	skinPath                = GetSkinPath(CONF_strSkin, 0, CONF_strSkinGroup, 1) & "/"
	CONF_bitUseMarkAvata    = RS("bitUseMarkAvata")
	IF CONF_bitUseMarkAvata = 0 THEN CONF_bitUseMarkAvata = False ELSE CONF_bitUseMarkAvata = True
	CONF_bitUseNameAvata    = RS("bitUseNameAvata")
	IF CONF_bitUseNameAvata = 0 THEN CONF_bitUseNameAvata = False ELSE CONF_bitUseNameAvata = True
	CONF_bitUseCategory     = RS("bitUseCategory")
	CONF_bitUseVote         = RS("bitUseVote")
	CONF_bitUseComment      = RS("bitUseComment")

	IF RS("bitUseScrap") = True AND RS("bitUseScrapDefault") = True THEN CONF_bitUseScrap = True ELSE CONF_bitUseScrap = False

	CONF_bitUseNickName     = RS("bitUseNickName")
	CONF_bitUseBad          = RS("bitUseBad")
	CONF_bitUseMemo         = RS("bitUseMemo")
	CONF_bitAdminCheck      = RS("bitAdminCheck")
	CONF_bitUseRss          = RS("bitUseRss")
	CONF_intColSpan         = 5
	CONF_intUserLevel       = RS("intUserLevel")
	IF CONF_intUserLevel = "" OR ISNULL(CONF_intUserLevel) = True THEN CONF_intUserLevel = 0
	CONF_bitBoardAdmin      = GetAdminCheck(SESSION("strLoginID"), RS("strAdmin"), SESSION("strAdmin"))
	CONF_strLanguage        = RS("strLanguage")

	DIM CONF_strListLevel, CONF_strReadLevel, CONF_strWriteLevel, CONF_strRepleLevel, CONF_strWriteCommentLevel
	DIM CONF_strReplyCommentLevel, CONF_strReadCommentLevel, CONF_strUploadLevel, CONF_strSubjectStyleLevel, CONF_strDownLevel

	CONF_strListLevel         = SPLIT(RS("strListLevel"), "|")
	CONF_strReadLevel         = SPLIT(RS("strReadLevel"), "|")
	CONF_strWriteLevel        = SPLIT(RS("strWriteLevel"), "|")
	CONF_strRepleLevel        = SPLIT(RS("strRepleLevel"), "|")
	CONF_strWriteCommentLevel = SPLIT(RS("strWriteCommentLevel"), "|")
	CONF_strReplyCommentLevel = SPLIT(RS("strReplyCommentLevel"), "|")
	CONF_strReadCommentLevel  = SPLIT(RS("strReadCommentLevel"), "|")
	CONF_strUploadLevel       = SPLIT(RS("strUploadLevel"), "|")
	CONF_strSubjectStyleLevel = SPLIT(RS("strSubjectStyleLevel"), "|")
	CONF_strDownLevel         = SPLIT(RS("strDownLevel"), "|")

	DIM CONF_bitListLevelLogin, CONF_bitReadLevelLogin

	CONF_bitListLevelLogin    = RS("bitListLevelLogin")
	CONF_bitReadLevelLogin    = RS("bitReadLevelLogin")
	CONF_bitWriteLevelLogin   = RS("bitWriteLevelLogin")
	CONF_bitRepleLevelLogin   = RS("bitRepleLevelLogin")

	DIM CONF_strListLevelUrl, CONF_strReadLevelUrl, CONF_strWriteLevelUrl, CONF_strRepleLevelUrl

	CONF_strListLevelUrl      = RS("strListLevelUrl")
	CONF_strReadLevelUrl      = RS("strReadLevelUrl")
	CONF_strWriteLevelUrl     = RS("strWriteLevelUrl")
	CONF_strRepleLevelUrl     = RS("strRepleLevelUrl")

	DIM CONF_strListLevelMsg, CONF_strReadLevelMsg, CONF_strWriteLevelMsg, CONF_strRepleLevelMsg, CONF_strWriteCommentMsg
	DIM CONF_strReplyCommentMsg, CONF_intListLevel, CONF_intReadLevel, CONF_intWriteLevel, CONF_intRepleLevel
	DIM CONF_intWriteCommentLevel, CONF_intReplyCommentLevel, CONF_intReadCommentLevel, CONF_intUploadLevel
	DIM CONF_intSubjectStyleLevel, CONF_intDownLevel

	CONF_strListLevelMsg    = CONF_strListLevel(2)
	CONF_strReadLevelMsg    = CONF_strReadLevel(2)
	CONF_strWriteLevelMsg   = CONF_strWriteLevel(2)
	CONF_strRepleLevelMsg   = CONF_strRepleLevel(2)
	CONF_strWriteCommentMsg = CONF_strWriteCommentLevel(2)
	CONF_strReplyCommentMsg = CONF_strReplyCommentLevel(2)

	IF CONF_strListLevel(0)         = 1 THEN CONF_intListLevel         = 0 ELSE CONF_intListLevel         = CONF_strListLevel(1)
	IF CONF_strReadLevel(0)         = 1 THEN CONF_intReadLevel         = 0 ELSE CONF_intReadLevel         = CONF_strReadLevel(1)
	IF CONF_strWriteLevel(0)        = 1 THEN CONF_intWriteLevel        = 0 ELSE CONF_intWriteLevel        = CONF_strWriteLevel(1)
	IF CONF_strRepleLevel(0)        = 1 THEN CONF_intRepleLevel        = 0 ELSE CONF_intRepleLevel        = CONF_strRepleLevel(1)
	IF CONF_strWriteCommentLevel(0) = 1 THEN CONF_intWriteCommentLevel = 0 ELSE CONF_intWriteCommentLevel = CONF_strWriteCommentLevel(1)
	IF CONF_strReplyCommentLevel(0) = 1 THEN CONF_intReplyCommentLevel = 0 ELSE CONF_intReplyCommentLevel = CONF_strReplyCommentLevel(1)
	IF CONF_strReadCommentLevel(0)  = 1 THEN CONF_intReadCommentLevel  = 0 ELSE CONF_intReadCommentLevel  = CONF_strReadCommentLevel(1)
	IF CONF_strUploadLevel(0)       = 1 THEN CONF_intUploadLevel       = 0 ELSE CONF_intUploadLevel       = CONF_strUploadLevel(1)
	IF CONF_strSubjectStyleLevel(0) = 1 THEN CONF_intSubjectStyleLevel = 0 ELSE CONF_intSubjectStyleLevel = CONF_strSubjectStyleLevel(1)
	IF CONF_strDownLevel(0)         = 1 THEN CONF_intDownLevel         = 0 ELSE CONF_intDownLevel         = CONF_strDownLevel(1)

	DIM CONF_bitListLevel, CONF_bitReadLevel, CONF_bitWriteLevel, CONF_bitRepleLevel, CONF_bitCommentLevel, CONF_bitCommentWriteLevel
	DIM CONF_bitCommentReplyLevel, CONF_bitUploadLevel, CONF_bitUploadImageLevel, CONF_bitDownLevel

	CONF_bitListLevel         = GetBoardLevelCheck(CONF_bitBoardAdmin, CONF_intListLevel,         CONF_intUserLevel)
	CONF_bitReadLevel         = GetBoardLevelCheck(CONF_bitBoardAdmin, CONF_intReadLevel,         CONF_intUserLevel)
	CONF_bitWriteLevel        = GetBoardLevelCheck(CONF_bitBoardAdmin, CONF_intWriteLevel,        CONF_intUserLevel)
	CONF_bitRepleLevel        = GetBoardLevelCheck(CONF_bitBoardAdmin, CONF_intRepleLevel,        CONF_intUserLevel)
	CONF_bitCommentLevel      = GetBoardLevelCheck(CONF_bitBoardAdmin, CONF_intReadCommentLevel,  CONF_intUserLevel)
	CONF_bitCommentWriteLevel = GetBoardLevelCheck(CONF_bitBoardAdmin, CONF_intWriteCommentLevel, CONF_intUserLevel)
	CONF_bitCommentReplyLevel = GetBoardLevelCheck(CONF_bitBoardAdmin, CONF_intReplyCommentLevel, CONF_intUserLevel)
	CONF_bitUploadLevel       = GetBoardLevelCheck(CONF_bitBoardAdmin, CONF_intUploadLevel,       CONF_intUserLevel)
	CONF_bitSubjectStyleLevel = GetBoardLevelCheck(CONF_bitBoardAdmin, CONF_intSubjectStyleLevel, CONF_intUserLevel)
	CONF_bitDownLevel         = GetBoardLevelCheck(CONF_bitBoardAdmin, CONF_intDownLevel,         CONF_intUserLevel)

	DIM CONF_bitUsePoint, CONF_intReadPoint, CONF_intDownPoint, CONF_intVotePoint, CONF_intWritePoint, CONF_intReplePoint
	DIM CONF_intUploadPoint, CONF_intCommentPoint

	CONF_bitUsePoint         = RS("bitUsePoint")
	CONF_intReadPoint        = RS("intReadPoint")
	CONF_intDownPoint        = RS("intDownPoint")
	CONF_intVotePoint        = RS("intVotePoint")
	CONF_intWritePoint       = RS("intWritePoint")
	CONF_intReplePoint       = RS("intReplePoint")
	CONF_intUploadPoint      = RS("intUploadPoint")
	CONF_intCommentPoint     = RS("intCommentPoint")

	DIM CONF_strMemberJoinLink, CONF_strMemberEditLink, CONF_strLoginLink, CONF_strLogoutLink, CONF_strRssLink
	CONF_strMemberJoinLink = "member.asp?Action=join"
	CONF_strMemberEditLink = "member.asp?Action=edit"
	CONF_strLoginLink      = "javascript:OnBoardLogin();"
	CONF_strLogoutLink     = "javascript:OnBoardLogout();"
	CONF_strRssLink        = "boardRss.asp?strBoardID=" & strBoardID

	DIM strScYear, strScMonth, strScDay, strScHour, strScMinute
	IF Action = "WRITE" OR Action = "LIST" OR Action = "VIEW" THEN
		strScYear  = GetReplaceInput(REQUEST.QueryString("strScYear"), "S")
		strScMonth = GetReplaceInput(REQUEST.QueryString("strScMonth"), "S")
		strScDay   = GetReplaceInput(REQUEST.QueryString("strScDay"), "S")
		IF strScYear  = "" THEN strScYear   = YEAR(NOW)
		IF strScMonth = "" THEN strScMonth  = MONTH(NOW)
		IF strScDay   = "" THEN strScDay    = DAY(NOW)
		strScHour   = HOUR(NOW)
		strScMinute = MINUTE(NOW)
	END IF

	IF Action = "EDIT" THEN
		strScYear   = YEAR(AdRs_dateRegDate)
		strScMonth  = MONTH(AdRs_dateRegDate)
		strScDay    = DAY(AdRs_dateRegDate)
		strScHour   = HOUR(AdRs_dateRegDate)
		strScMinute = MINUTE(AdRs_dateRegDate)
	END IF

	DIM CATEGORY_LIST, strCategorySelect, strCategoryList, strCategorySelected
%>
<!-- #include file = "BoardIncludeLanguage.asp" -->
<script language="javascript">

	var PATH_SKIN               = "<%=skinPath%>";
	var SET_CHECK_INT_SEQ       = "<%=GetReplaceInput(REQUEST.QueryString("checkIntSeq"), "S")%>";
	var SET_USE_MEMO            = "<%=CONF_bitUseMemo%>";
	var SET_STRBOARD_ID         = "<%=strBoardID%>";
	var SET_INTPAGE             = "<%=intPage%>";
	var SET_INTCATEGORY         = "<%=intCategory%>";
	var SET_SEARCH_CATEGORY     = "<%=strSearchCategory%>";
	var SET_SEARCH_WORD         = "<%=strSearchWord%>";
	var SET_SEARCH_CATEGORY_DIM = new Array(4);
	var SET_EDITOR_TYPE         = "BOARD";
	var SET_intSeq              = "<%=GetReplaceInput(REQUEST.QueryString("intSeq"),"S")%>";
	var SET_SCH_YEAR            = "<%=GetReplaceInput(REQUEST.QueryString("strScYear"), "S")%>";
	var SET_SCH_MONTH           = "<%=GetReplaceInput(REQUEST.QueryString("strScMonth"), "S")%>";
	var SET_SCH_DAY             = "<%=GetReplaceInput(REQUEST.QueryString("strScDay"), "S")%>";
	var SET_USER_SESSION_ID     = "<%=SESSION("strLoginID")%>";
	var SET_SESSIONID           = "<%=SESSION.SESSIONID%>";

<%
	DIM TempSearchCategory, strNowCategoryName, bitSearchType01, bitSearchType02, bitSearchType03, bitSearchType04
	TempSearchCategory = SPLIT(strSearchCategory, "|")

	FOR I = 0 TO UBOUND(TempSearchCategory)
		IF isSearch = True THEN
			SELECT CASE I
			CASE 0 : IF TempSearchCategory(I) = "" THEN bitSearchType01 = 0 ELSE bitSearchType01 = 1
			CASE 1 : IF TempSearchCategory(I) = "" THEN bitSearchType02 = 0 ELSE bitSearchType02 = 1
			CASE 2 : IF TempSearchCategory(I) = "" THEN bitSearchType03 = 0 ELSE bitSearchType03 = 1
			CASE 3 : IF TempSearchCategory(I) = "" THEN bitSearchType04 = 0 ELSE bitSearchType04 = 1
			END SELECT
		END IF
		RESPONSE.WRITE "	SET_SEARCH_CATEGORY_DIM[" & I & "] = """ & TempSearchCategory(I) & """;" & vbcrlf
	NEXT
%>

	var LINK_LIST       = "mboard.asp?Action=list&strBoardID=<%=strBoardID%>&intCategory=<%=intCategory%>&strSearchCategory=<%=strSearchCategory%>&strSearchWord=<%=strSearchWord%>&intPage=<%=intPage%>";
	var LINK_LIST_QUERY = "mboard.asp?Action=list&strBoardID=<%=strBoardID%>&intCategory=<%=intCategory%>&strSearchCategory=<%=strSearchCategory%>&strSearchWord=<%=strSearchWord%>&intPage=<%=intPage%>";
	var LINK_WRITE      = "mboard.asp?Action=write&strBoardID=<%=strBoardID%>&intCategory=<%=intCategory%>&strSearchCategory=<%=strSearchCategory%>&strSearchWord=<%=strSearchWord%>&intPage=<%=intPage%>";
	var LINK_REPLY      = "mboard.asp?Action=reply&strBoardID=<%=strBoardID%>&intCategory=<%=intCategory%>&strSearchCategory=<%=strSearchCategory%>&strSearchWord=<%=strSearchWord%>&intPage=<%=intPage%>";
	var LINK_EDIT       = "mboard.asp?Action=edit&strBoardID=<%=strBoardID%>&intCategory=<%=intCategory%>&strSearchCategory=<%=strSearchCategory%>&strSearchWord=<%=strSearchWord%>&intPage=<%=intPage%>";
	var LINK_REMOVE     = "mboard.asp?Action=remove&strBoardID=<%=strBoardID%>&intCategory=<%=intCategory%>&strSearchCategory=<%=strSearchCategory%>&strSearchWord=<%=strSearchWord%>&intPage=<%=intPage%>";
	var LINK_LOGIN      = "mboard.asp?Action=login&strBoardID=<%=strBoardID%>&intCategory=<%=intCategory%>&strSearchCategory=<%=strSearchCategory%>&strSearchWord=<%=strSearchWord%>&intPage=<%=intPage%>&intSeq=<%=GetReplaceInput(REQUEST.QueryString("intSeq"),"S")%>&prevAction=<%=Action%>";
	var LINK_LOGOUT     = "mboard.asp?Action=logout&strBoardID=<%=strBoardID%>&intCategory=<%=intCategory%>&strSearchCategory=<%=strSearchCategory%>&strSearchWord=<%=strSearchWord%>&intPage=<%=intPage%>&intSeq=<%=GetReplaceInput(REQUEST.QueryString("intSeq"),"S")%>&prevAction=<%=Action%>";
	var LINK_READ     = "mboard.asp?Action=view&strBoardID=<%=strBoardID%>&intCategory=<%=intCategory%>&strSearchCategory=<%=strSearchCategory%>&strSearchWord=<%=strSearchWord%>&intPage=<%=intPage%>&intSeq=<%=GetReplaceInput(REQUEST.QueryString("intSeq"),"S")%>";
	var SET_Action = "<%=Action%>";
</script>