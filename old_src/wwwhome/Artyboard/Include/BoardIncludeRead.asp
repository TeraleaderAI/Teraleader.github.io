<%
	IF CONF_bitReadLevel = False THEN
		IF SESSION("strLoginID") = "" AND CONF_bitReadLevelLogin = True THEN
			RESPONSE.WRITE "<script language=javascript>" & vbcrlf
			RESPONSE.WRITE "location.href=LINK_LOGIN;" & vbcrlf
			RESPONSE.WRITE "</script>" & vbcrlf
			RESPONSE.End()
		ELSE
			IF CONF_strReadLevelUrl <> "" AND ISNULL(CONF_strReadLevelUrl) = False THEN

				CONF_strReadLevelUrl = CONF_strReadLevelUrl & "?strPrevUrl=" & Request.ServerVariables("url") & "?" & Replace(Request.ServerVariables("QUERY_STRING"), "&", "--**--" )

				RESPONSE.WRITE ExecFormSubmit(CONF_strReadLevelMsg, CONF_strReadLevelUrl, "")
				RESPONSE.End()
			ELSE
				IF INSTR(1, UCASE(Request.ServerVariables("HTTP_REFERER")), "Action=LOGIN_OK") = "0" THEN
					RESPONSE.WRITE ExecJavaAlert(CONF_strReadLevelMsg, 0)
					RESPONSE.End()
				ELSE
					RESPONSE.WRITE ExecJavaAlert(CONF_strReadLevelMsg, 0)
					RESPONSE.End()
				END IF
			END IF
		END IF
	END IF

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_READ] '" & strBoardID & "' ")

	DIM CONF_strNameClick, CONF_bitImgView, CONF_intImgWidth, CONF_intImgHeight, CONF_intImgScare, CONF_bitImgLightbox
	DIM CONF_bitImgViewAll, CONF_bitFileExe, CONF_intExeWidth
	DIM CONF_intExeHeight, CONF_bitAutoLink, CONF_bitWordBreak, CONF_bitReadInsert, CONF_bitVoteInsert, CONF_strBadErrMsg
	DIM CONF_bitContentIp, CONF_bitCommentIp, CONF_strDateType, CONF_strDateTypeComment, CONF_bitPrevNext, CONF_bitListReple
	DIM CONF_bitListBoard, CONF_bitUseLink1, CONF_bitUseLink2, CONF_bitUseUpload
	DIM CONF_bitThrum, CONF_bitUseReple, CONF_bitEditLevel, CONF_bitRemoveLevel, CONF_intNewIconTime, CONF_strIconFolder
	DIM CONF_strIconNew, CONF_strIconReple, CONF_strIconLine, CONF_strIconSecret, CONF_intLineHeight, CONF_bitMouseOver
	DIM CONF_strMouseOverColor, CONF_strDateListType, CONF_bitCommentEdit, CONF_bitCommentReply, CONF_bitUseEditor
	DIM CONF_strEditorWidth, CONF_strEditorHeight, CONF_bitEditorSource, CONF_bitEditorPrev, CONF_strEditorBgColor
	DIM CONF_bitEditorZoom, CONF_intEditorZoomSize
	DIM I, iCount, CMT_intCount, CMT_LIST, REPLY_COUNT, REPLY_LIST
	DIM REPLY_iConFolder, CONF_intListImgWidth, CONF_intListImgHeight, CONF_bitUseSign, CONF_bitViewSign

	CONF_strNameClick       = RS("strNameClick")
	CONF_bitImgView         = RS("bitImgView")
	CONF_intImgWidth        = RS("intImgWidth")
	CONF_intImgHeight       = RS("intImgHeight")
	CONF_intImgScare        = RS("intImgScare")
	CONF_bitImgLightbox     = RS("bitImgLightbox")
	CONF_bitImgViewAll      = RS("bitImgViewAll")
	CONF_bitFileExe         = RS("bitFileExe")
	CONF_intExeWidth        = RS("intExeWidth")
	CONF_intExeHeight       = RS("intExeHeight")
	CONF_bitAutoLink        = RS("bitAutoLink")
	CONF_bitWordBreak       = RS("bitWordBreak")
	CONF_bitReadInsert      = RS("bitReadInsert")
	CONF_bitVoteInsert      = RS("bitVoteInsert")
	CONF_strBadErrMsg       = RS("strBadErrMsg")
	CONF_bitContentIp       = RS("bitContentIp")
	CONF_bitCommentIp       = RS("bitCommentIp")
	CONF_strDateType        = RS("strDateTypeView")
	CONF_strDateTypeComment = RS("strDateTypeComment")
	CONF_bitPrevNext        = RS("bitPrevNext")
	CONF_bitListReple       = RS("bitListReple")
	CONF_bitListBoard       = RS("bitListBoard")
	CONF_bitUseUpload       = RS("bitUseUpload")
	CONF_bitThrum           = RS("bitThrum")
	CONF_bitUseLink1        = RS("bitUseLink1")
	CONF_bitUseLink2        = RS("bitUseLink2")
	CONF_bitUseReple        = RS("bitUseReple")
	CONF_intNewIconTime     = RS("intNewIconTime")
	CONF_strIconFolder      = RS("strIconFolder")
	CONF_strIconNew         = RS("strIconNew")
	CONF_strIconReple       = RS("strIconReple")
	CONF_strIconLine        = RS("strIconLine")
	CONF_strIconSecret      = RS("strIconSecret")
	CONF_intLineHeight      = RS("intLineHeight")
	CONF_bitMouseOver       = RS("bitMouseOver")
	CONF_strMouseOverColor  = RS("strMouseOverColor")
	CONF_strDateListType    = RS("strDateType")
	CONF_intCutSubject      = RS("intCutSubject")
	CONF_intCutContent      = RS("intCutContent")
	CONF_intCutName         = RS("intCutName")
	CONF_intListImgWidth    = RS("intListImgWidth")
	CONF_intListImgHeight   = RS("intListImgHeight")
	CONF_bitCommentEdit     = RS("bitCommentEdit")
	CONF_bitCommentReply    = RS("bitCommentReply")
	CONF_bitUseEditor       = RS("bitUseEditor")
	CONF_strEditorWidth     = RS("strEditorWidth")
	CONF_strEditorHeight    = RS("strEditorHeight")
	CONF_bitEditorSource    = RS("bitEditorSource")
	CONF_bitEditorPrev      = RS("bitEditorPrev")
	CONF_strEditorBgColor   = RS("strEditorBgColor")
	CONF_bitEditorZoom      = RS("bitEditorZoom")
	CONF_intEditorZoomSize  = SPLIT(RS("intEditorZoomSize"), "|")
	CONF_bitUseSign         = RS("bitUseSign")
	CONF_bitViewSign        = RS("bitViewSign")

	IF CONF_bitUseReple = False THEN CONF_bitRepleLevel = False
	IF CONF_bitImgLightbox = True THEN CONF_bitImgViewAll = True
	IF CONF_bitUseSign = "1" THEN CONF_bitUseSign = True ELSE CONF_bitUseSign = False
	IF CONF_bitViewSign = False THEN CONF_bitUseSign = False
%>
<form name="theCmtForm" method="post" style="margin:0px;">
<input type="hidden" name="strBoardBg">
<input type="hidden" name="comment_intThread" value="">
<input type="hidden" name="comment_id" value="">
<input type="hidden" name="comment_html" value="<% IF CONF_bitUseEditor = True THEN %>1<% ELSE %>0<% END IF %>">
<input type="hidden" name="comment_name" value="">
<input type="hidden" name="comment_pwd" value="">
<input type="hidden" name="comment_content" value="">
<input type="hidden" name="comment_intScore" value="">
<input type="hidden" name="comment_intIcon" value="">
</form>
<%
	DIM checkIntSeq, intSeq
	checkIntSeq = GetReplaceInput(REQUEST.QueryString("checkIntSeq"), "S")
	intSeq      = GetReplaceInput(REQUEST.QueryString("intSeq"), "S")

	DIM READ_COUNT, READ_LIST

	IF checkIntSeq = "" THEN
		checkIntSeq = intSeq
		checkIntSeq = SPLIT(checkIntSeq, ",")
		READ_COUNT  = UBOUND(checkIntSeq)
	ELSE
		checkIntSeq = SPLIT(checkIntSeq, ",")
		READ_COUNT  = UBOUND(checkIntSeq) - 1
	END IF

	IF READ_COUNT > 0 THEN CONF_bitCommentWriteLevel = False

	FOR READ_LIST = 0 TO READ_COUNT
	intSeq = checkIntSeq(READ_LIST)

	SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.Command")
	SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RecordSet")

	AdRs_GetRows_Count = ""
	WITH AdCmd

		.ActiveConnection = DbConnect
		.CommandText      = "MPLUS_GET_BOARD_READ"
		.CommandTimeOut   = 10
		.CommandType      = adCmdStoredProc
		.Parameters.Append	.CreateParameter("intSeq",	adInteger,	adParamInput,	,	intSeq)
		.Parameters.Append	.CreateParameter("strBoardID",	adVarchar,	adParamInput,	20,	strBoardID)
		.Parameters.Append	.CreateParameter("strLoginID",	adVarchar,	adParamInput,	20,	strLoginID)
		.Parameters.Append	.CreateParameter("intCategory",	adInteger,	adParamInput,	,	intCategory)

		AdRs.Open .Execute
		IF (NOT (AdRs.EOF OR AdRs.BOF)) THEN
			AdRs_GetRows 		= AdRs.GetRows
			AdRs_GetRows_Count	= UBOUND(AdRs_GetRows, 2)
		ELSE
			RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(25), 0)
			RESPONSE.End()
		END IF
		AdRs.Close
			
	END WITH

	DIM AdRs_intSeq, AdRs_intIndex, AdRs_intThread, AdRs_intDepth, AdRs_strLoginID, AdRs_intCategory, AdRs_strName
	DIM AdRs_strPassword, AdRs_strEmail, AdRs_strHomepage, AdRs_strSubject, AdRs_strSubjectStyle, AdRs_strContent
	DIM AdRs_strLink1, AdRs_strLink2, AdRs_strBoardBg, AdRs_strIpAddr, AdRs_bitDelete, AdRs_bitHtml
	DIM AdRs_bitText, AdRs_bitNotice, AdRs_bitReMail, AdRs_bitSecret, AdRs_strSecretID, AdRs_intRead, AdRs_intVote
	DIM AdRs_intComment, AdRs_intFileCount, AdRs_strFileCode, AdRs_dateRegDate, AdRs_strMarkImage, AdRs_strUserImage
	DIM AdRs_strFileImage, AdRs_strCategory
%>
<!-- #include file = "BoardIncludeReadDefault.asp" -->
<%
	DIM AdRs_intPrevSeq, AdRs_strPrevSubject, AdRs_strPrevName, AdRs_intPrevComment, AdRs_bitPrevSecret, AdRs_datePrevRegDate
	DIM AdRs_intNextSeq, AdRs_strNextSubject, AdRs_strNextName, AdRs_intNextComment, AdRs_bitNextSecret, AdRs_dateNextRegDate
	DIM AdRs_strPhotoFile, AdRs_strPrevNick, AdRs_strNextNick, AdRs_strUserSign

	AdRs_bitCheck        = AdRs_GetRows(50, tmpFor)
	AdRs_intPrevSeq      = AdRs_GetRows(51, tmpFor)
	AdRs_strPrevSubject  = AdRs_GetRows(52, tmpFor)
	AdRs_strPrevName     = AdRs_GetRows(53, tmpFor)
	AdRs_intPrevComment  = AdRs_GetRows(54, tmpFor)
	AdRs_bitPrevSecret   = AdRs_GetRows(55, tmpFor)
	AdRs_datePrevRegDate = AdRs_GetRows(56, tmpFor)
	AdRs_intNextSeq      = AdRs_GetRows(57, tmpFor)
	AdRs_strNextSubject  = AdRs_GetRows(58, tmpFor)
	AdRs_strNextName     = AdRs_GetRows(59, tmpFor)
	AdRs_intNextComment  = AdRs_GetRows(60, tmpFor)
	AdRs_bitNextSecret   = AdRs_GetRows(61, tmpFor)
	AdRs_dateNextRegDate = AdRs_GetRows(62, tmpFor)
	AdRs_strPrevNick     = AdRs_GetRows(63, tmpFor)
	AdRs_strNextNick     = AdRs_GetRows(64, tmpFor)
	AdRs_strUserSign     = AdRs_GetRows(65, tmpFor)

	IF CONF_bitAdminCheck = True AND AdRs_bitCheck = False AND CONF_bitBoardAdmin = False THEN
		RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(26), 0)
		RESPONSE.End()
	END IF

	DIM READ_intSeq, READ_intIndex, READ_intThread, READ_intDepth, READ_strLoginID, READ_intCategory, READ_strName
	DIM READ_strNickName, READ_strPassword, READ_strEmail, READ_strHomepage, READ_strSubject, READ_strContent
	DIM READ_strSmallSubject, READ_strSmallContent, READ_strLink1, READ_strLink2, READ_strLinkTarget1, READ_strLinkTarget2
	DIM READ_strLinkTemp1, READ_strLinkTemp2, READ_strBoardBg, READ_strIpAddr, READ_bitDelete, READ_bitHtml, READ_bitHtmlBr
	DIM READ_bitText, READ_bitNotice, READ_bitReMail, READ_bitSecret, READ_strSecretID, READ_bitBad, READ_intRead, READ_intVote
	DIM READ_intComment, READ_intFileCount, READ_intImgCount, READ_strFileCode, READ_dateRegDate, READ_strMarkImage
	DIM READ_strNameImage, READ_strFileImage, READ_strFileImageSplit, READ_strFileImageWidth, READ_strFileImageHeight
	DIM READ_strFileImageSize, READ_strFileImageLink, READ_strCategory, READ_iConFolder, READ_strPhotoFile, READ_intPrevSeq
	DIM READ_strPrevSubject
	DIM READ_strPrevName, READ_intPrevComment, READ_bitPrevSecret, READ_datePrevRegDate, READ_intNextSeq, READ_strNextSubject
	DIM READ_strNextName, READ_intNextComment, READ_bitNextSecret, READ_dateNextRegDate
	DIM READ_strPrintLink, READ_strBadLink, READ_strUserSign
	DIM READ_strAddData1, READ_strAddData2, READ_strAddData3, READ_strAddData4, READ_strAddData5
	DIM READ_strAddData6, READ_strAddData7, READ_strAddData8, READ_strAddData9, READ_strAddData10

	READ_intSeq          = AdRs_intSeq
	READ_intIndex        = AdRs_intIndex
	READ_intThread       = AdRs_intThread
	READ_intDepth        = AdRs_intDepth
	READ_strLoginID      = AdRs_strLoginID
	READ_intCategory     = AdRs_intCategory
	READ_strName         = GetCutSubject(AdRs_strName, CONF_intCutName)
	READ_strNickName     = AdRs_strNickName

	IF CONF_bitUseNickName = True THEN
		IF READ_strLoginID <> "guest" AND AdRs_strNickName <> "" AND ISNULL(AdRs_strNickName) = False THEN READ_strName = AdRs_strNickName
	END IF

	READ_strPassword     = AdRs_strPassword
	READ_strEmail        = AdRs_strEmail
	READ_strHomepage     = AdRs_strHomepage

	READ_strSubject = GetReplaceTag2Text(READ_strSubject)
	READ_strSubject = READ_strSubject & "<span style="""
	IF AdRs_strSubjectStyle(0) <> "" THEN READ_strSubject = READ_strSubject & "font-family:" & AdRs_strSubjectStyle(0) & ";"
	IF AdRs_strSubjectStyle(1) <> "" THEN READ_strSubject = READ_strSubject & "color:" & AdRs_strSubjectStyle(1) & ";"
	IF AdRs_strSubjectStyle(2) <> "" THEN READ_strSubject = READ_strSubject & "background:" & AdRs_strSubjectStyle(2) & ";"
	IF AdRs_strSubjectStyle(3) <> "" THEN READ_strSubject = READ_strSubject & "font-weight:" & AdRs_strSubjectStyle(3) & ";"
	READ_strSubject = READ_strSubject & """>"

	READ_strSubject      = READ_strSubject & GetReplaceTag2Html(AdRs_strSubject)
	READ_strSubject      = READ_strSubject & "</span>"

	READ_strContent      = getAutoLink(CONF_bitAutoLink, AdRs_strContent)

	IF AdRs_bitHtml   = True THEN READ_strContent = GetReplaceTag2Html(READ_strContent)
	IF AdRs_bitText   = True THEN READ_strContent = GetReplaceTag2Text(READ_strContent)
	IF AdRs_bitHtmlBr = True THEN READ_strContent = GetReplaceTag2HtmlBr(READ_strContent)

	IF AdRs_bitHtml = False AND AdRs_bitText = False AND AdRs_bitHtmlBr = False THEN READ_strContent = GetReplaceTag2Html(READ_strContent)

	READ_strSmallSubject = GetCutSubject(AdRs_strSmallSubject, CONF_intCutSubject)
	READ_strSmallContent = GetCutSubject(AdRs_strSmallContent, CONF_intCutContent)

	IF CONF_bitUseLink1 = True THEN
		READ_strLinkTemp1 = SPLIT(AdRs_strLink1, "|")
		IF READ_strLinkTemp1(0) = "" THEN
			READ_strLink1 = False
		ELSE
			READ_strLink1       = READ_strLinkTemp1(0)
			READ_strLinkTarget1 = READ_strLinkTemp1(1)
		END IF
	ELSE
		READ_strLink1 = False
	END IF

	IF CONF_bitUseLink2 = True THEN
		READ_strLinkTemp2 = SPLIT(AdRs_strLink2, "|")
		IF READ_strLinkTemp2(0) = "" THEN
			READ_strLink2 = False
		ELSE
			READ_strLink2       = READ_strLinkTemp2(0)
			READ_strLinkTarget2 = READ_strLinkTemp2(1)
		END IF
	ELSE
		READ_strLink2 = False
	END IF

	IF AdRs_strBoardBg = "" OR ISNULL(AdRs_strBoardBg) = True THEN
		READ_strBoardBg = False
	ELSE
		IF LEN(AdRs_strBoardBg) = 7 THEN
			READ_strBoardBg = " bgcolor=""" & AdRs_strBoardBg & """"
		ELSE
			READ_strBoardBg = " background=""" & AdRs_strBoardBg & """"
		END IF
	END IF

	READ_strIpAddr           = AdRs_strIpAddr
	READ_bitDelete           = AdRs_bitDelete
	READ_bitHtml             = AdRs_bitHtml
	READ_bitText             = AdRs_bitText
	READ_bitNotice           = AdRs_bitNotice
	READ_bitReMail           = AdRs_bitReMail
	READ_bitSecret           = AdRs_bitSecret
	READ_strSecretID         = AdRs_strSecretID
	READ_bitBad              = AdRs_bitBad
	READ_intRead             = AdRs_intRead
	READ_intVote             = AdRs_intVote
	READ_intComment          = AdRs_intComment
	READ_intFileCount        = AdRs_intFileCount
	READ_intImgCount         = AdRs_intImgCount
	READ_strFileCode         = AdRs_strFileCode
	READ_dateRegDate         = GetDateType(CONF_strDateType, AdRs_dateRegDate)

	IF CONF_bitUseMarkAvata = True THEN
		IF AdRs_strMarkImage = "" OR ISNULL(AdRs_strMarkImage) = True THEN READ_strMarkImage = False ELSE READ_strMarkImage = "<img src='Pds/Member/GroupIcon/" & AdRs_strMarkImage & "' align='absmiddle'>"
	END IF

	IF AdRs_strUserImage = "" OR ISNULL(AdRs_strUserImage) = True THEN AdRs_strUserImage = "|"
	AdRs_strUserImage = SPLIT(AdRs_strUserImage, "|")

	IF CONF_bitUseNameAvata = True THEN
		IF AdRs_strUserImage(0) = "" OR ISNULL(AdRs_strUserImage(0)) = True THEN READ_strNameImage = False ELSE READ_strNameImage = "<img src='Pds/Member/Name/" & AdRs_strUserImage(0) & "' align='absmiddle'>"
	END IF

	READ_strFileImage = AdRs_strFileImage

	IF READ_strFileImage <> "" AND ISNULL(READ_strFileImage) = False THEN
		READ_strFileImageSplit = SPLIT(READ_strFileImage, "|")
		READ_strFileImage       = READ_strFileImageSplit(0)
		READ_strFileImageWidth  = READ_strFileImageSplit(1)
		READ_strFileImageHeight = READ_strFileImageSplit(2)
		READ_strFileImageSize   = GetFilesize(READ_strFileImageSplit(3))
		READ_strFileImageLink   = "javascript:OnZoomGallery('" & READ_strFileImage & "','" & strBoardID & "');"
	ELSE
		READ_strFileImage       = False
		READ_strFileImageWidth  = ""
		READ_strFileImageHeight = ""
		READ_strFileImageSize   = ""
		READ_strFileImageLink   = ""
	END IF

	READ_strCategory     = AdRs_strCategory
	
	IF AdRs_strUserImage(1) = "" OR ISNULL(AdRs_strUserImage(1)) = True THEN READ_strPhotoFile = False ELSE READ_strPhotoFile = "<img src='Pds/Member/Photo/" & AdRs_strUserImage(1) & "' align='absmiddle'>"
	
	READ_intPrevSeq      = AdRs_intPrevSeq
	READ_strPrevSubject  = GetCutSubject(StripTags(AdRs_strPrevSubject), CONF_intCutSubject)

	IF CONF_bitUseNickName = True THEN
		IF AdRs_strPrevNick = "" OR ISNULL(AdRs_strPrevNick) = True THEN
			READ_strPrevName     = AdRs_strPrevName
		ELSE
			READ_strPrevName     = AdRs_strPrevNick
		END IF
	ELSE
		READ_strPrevName     = AdRs_strPrevName
	END IF

	READ_intPrevComment  = AdRs_intPrevComment
	READ_bitPrevSecret   = AdRs_bitPrevSecret
	IF READ_bitPrevSecret = 0 THEN READ_bitPrevSecret = False ELSE READ_bitPrevSecret = True
	READ_datePrevRegDate = AdRs_datePrevRegDate
	READ_intNextSeq      = AdRs_intNextSeq
	READ_strNextSubject  = GetCutSubject(StripTags(AdRs_strNextSubject), CONF_intCutSubject)

	IF CONF_bitUseNickName = True THEN
		IF AdRs_strNextNick = "" OR ISNULL(AdRs_strNextNick) = True THEN
			READ_strNextName     = AdRs_strNextName
		ELSE
			READ_strNextName     = AdRs_strNextNick
		END IF

	ELSE
		READ_strNextName     = AdRs_strNextName
	END IF

	READ_intNextComment  = AdRs_intNextComment
	READ_bitNextSecret   = AdRs_bitNextSecret
	IF READ_bitNextSecret = 0 THEN READ_bitNextSecret = False ELSE READ_bitNextSecret = True
	READ_dateNextRegDate = AdRs_dateNextRegDate
	READ_strPrintLink    = "javascript:OnBoardPrint('" & READ_intSeq & "', '" & strBoardID & "');"
	READ_strBadLink      = "javascript:OnBoardBad('" & READ_intSeq & "', '" & strBoardID & "');"

	IF READ_bitSecret = True THEN
		IF CONF_bitBoardAdmin = False THEN
			IF SESSION("strLoginiD") = "" THEN
				IF GetReplaceInput(REQUEST.FORM("strPassword"), "S") = "" THEN
					RESPONSE.REDIRECT "mboard.asp?Action=password&strBoardID=" & strBoardID & "&intPage=" & intPage & "&intCategory=" & intCategory & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intSeq=" & READ_intSeq & "&strPassMode=secret"
					RESPONSE.End()
				ELSE
					SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_REPLY] '" & strBoardID & "', '" & intSeq & "', '" & GetTrueFalse(CONF_bitBoardAdmin) & "' ")
					IF RS("strPassword") <> REQUEST.FORM("strPassword") THEN
						RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(18), 0)
						RESPONSE.End()
					END IF
				END IF
			ELSE
				IF READ_intDepth = 0 THEN
					IF READ_strLoginID <> SESSION("strLoginID") THEN
						RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(18), 0)
						RESPONSE.End()
					END IF
				ELSE
					SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_REPLY] '" & strBoardID & "', '" & intSeq & "', '" & GetTrueFalse(CONF_bitBoardAdmin) & "' ")
					IF RS("strLoginID") <> SESSION("strLoginID") THEN
						RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(18), 0)
						RESPONSE.End()
					END IF
				END IF
			END IF
		END IF
	END IF

	IF READ_bitBad = True THEN
		IF CONF_bitBoardAdmin = False THEN
			IF CONF_strBadErrMsg = "" THEN CONF_strBadErrMsg = DIM_strBoardMsg(10)
			RESPONSE.WRITE ExecJavaAlert(CONF_strBadErrMsg, 0)
			RESPONSE.End()
		END IF
	END IF

	DIM READ_strPrevReadLink, READ_strNextReadLink, READ_iConPrevNew, READ_iConNextNew, READ_iConPrevSecret, READ_iConNextSecret
	DIM READ_iConNewPrev, READ_iConNewNext, READ_iConSecretPrev, READ_iConSecretNext, READ_strFIleDonwLink1, READ_strFIleDonwLink2

	IF CONF_bitPrevNext = False THEN
		READ_intPrevSeq = 0
		READ_intNextSeq = 0
	END IF

	IF READ_intPrevSeq = 0 THEN READ_strPrevReadLink = False ELSE READ_strPrevReadLink = "javascript:OnReadArticle('" & READ_intPrevSeq & "','0');"
	IF READ_intNextSeq = 0 THEN READ_strNextReadLink = False ELSE READ_strNextReadLink = "javascript:OnReadArticle('" & READ_intNextSeq & "','0');"

	IF GetNewBoardTime(CONF_intNewIconTime, READ_datePrevRegDate) = True THEN READ_iConNewPrev = GetListIcon("New", CONF_strIconNew) ELSE READ_iConNewPrev = False
	IF GetNewBoardTime(CONF_intNewIconTime, READ_dateNextRegDate) = True THEN READ_iConNewNext = GetListIcon("New", CONF_strIconNew) ELSE READ_iConNewNext = False
	
	IF READ_bitPrevSecret = True THEN READ_iConSecretPrev = GetListIcon("Secret", CONF_strIconSecret) ELSE READ_iConSecretPrev = False
	IF READ_bitNextSecret = True THEN READ_iConSecretNext = GetListIcon("Secret", CONF_strIconSecret) ELSE READ_iConSecretNext = False

	READ_iConFolder = GetListIcon("Folder", CONF_strIconFolder)

	IF CONF_bitBoardAdmin = True THEN
		CONF_bitEditLevel = True
	ELSE
		IF READ_strLoginID = "guest" THEN
			CONF_bitEditLevel = True
		ELSE
			IF UCASE(SESSION("strLoginID")) = UCASE(READ_strLoginID) THEN CONF_bitEditLevel = True ELSE CONF_bitEditLevel = False
		END IF
	END IF

	IF CONF_bitBoardAdmin = True THEN
		CONF_bitRemoveLevel = True
	ELSE
		IF READ_strLoginID = "guest" THEN
			CONF_bitRemoveLevel = True
		ELSE
			IF UCASE(SESSION("strLoginID")) = UCASE(READ_strLoginID) THEN CONF_bitRemoveLevel = True ELSE CONF_bitRemoveLevel = False
		END IF
	END IF

	IF CONF_bitBoardAdmin = False THEN
		IF CONF_bitUsePoint = True THEN
			IF SESSION("strLoginID") <> READ_strLoginID THEN
				IF CONF_intReadPoint <> 0 THEN
					IF SESSION("strLoginID") = "" THEN
						RESPONSE.WRITE ExecFormSubmit("로그인 후 이용해 주시기 바랍니다.", "Mboard.asp?strBoardID=" & strBoardID, "")
						RESPONSE.End()
					ELSE
						SET RS = DBCON.EXECUTE("SELECT [intNum] FROM [MPLUS_MEMBER_POINT] WHERE [intSeq] = '" & intSeq & "' AND [strCode] = 'P001' AND [strLoginID] = '" & SESSION("strLoginID") & "' ")
						IF RS.EOF THEN
							IF CONF_intReadPoint < 0 THEN
								SET RS = DBCON.EXECUTE("EXEC MPLUS_GET_MEMBER_READ '" & SESSION("strLoginID") & "' ")
								IF RS("intPoint") < CONF_intReadPoint THEN
									RESPONSE.WRITE ExecJavaAlert("글읽기 포인트가 부족합니다.", 0)
									RESPONSE.End()
								END IF
							END IF
							DBCON.EXECUTE("EXEC [MPLUS_PUT_MEMBER_POINT] '1', '" & strBoardID & "', '" & intSeq & "', '', '" & SESSION("strLoginID") & "', '', '', 'P001', " & CONF_intReadPoint & ", '게시글 읽기 포인트' ")
						END IF
					END IF
				END IF
			END IF
		END IF
	END IF

	IF CONF_bitReadInsert = True THEN
		DIM SQL, strCheckUserID
		SQL = "SELECT [strLoginID] FROM [MPLUS_BOARD_READ_CHECK] WHERE [intSeq] = '" & intSeq & "' "

		IF SESSION("strLoginID") = "" THEN SQL = SQL & " AND [strLoginID] = 'guest' AND [strUserIp] = '" & Request.Servervariables("REMOTE_ADDR") & "' " ELSE SQL = SQL & " AND [strLoginID] = '" & SESSION("strLoginID") & "' "
		SET RS = DBCON.EXECUTE(SQL)

		IF RS.EOF THEN
			DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [intRead] = [intRead] + 1 WHERE [intSeq] = '" & intSeq & "' ")
			IF SESSION("strLoginID") = "" THEN strCheckUserID = "guest" ELSE strCheckUserID = SESSION("strLoginID")
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_READ_CHECK] ([strBoardID], [intSeq], [strLoginID], [strUserIp]) VALUES ('" & strBoardID & "', '" & intSeq & "', '" & strCheckUserID & "', '" & Request.Servervariables("REMOTE_ADDR") & "') ")
		END IF
	ELSE
		DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [intRead] = [intRead] + 1 WHERE [intSeq] = '" & intSeq & "' ")
	END IF

	READ_strUserSign  = AdRs_strUserSign
	READ_strAddData1  = AdRs_strAddData1
	READ_strAddData2  = AdRs_strAddData2
	READ_strAddData3  = AdRs_strAddData3
	READ_strAddData4  = AdRs_strAddData4
	READ_strAddData5  = AdRs_strAddData5
	READ_strAddData6  = AdRs_strAddData6
	READ_strAddData7  = AdRs_strAddData7
	READ_strAddData8  = AdRs_strAddData8
	READ_strAddData9  = AdRs_strAddData9
	READ_strAddData10 = AdRs_strAddData10

	SET	AdRS	= Nothing : SET	AdCmd	= Nothing

	IF CONF_bitCommentReply = False THEN CONF_bitCommentReplyLevel = False
	IF READ_strLoginID = "guest" THEN CONF_bitUseSign = False

	DIM intThrumListCount, bitViewImageAll

	IF CONF_bitImgLightbox = False THEN
		IF GetReplaceInput(REQUEST.QueryString("bitViewImageAll"),"S") = "" THEN bitViewImageAll = CONF_bitImgViewAll ELSE bitViewImageAll = GetReplaceInput(REQUEST.QueryString("bitViewImageAll"),"S")
		IF READ_COUNT > 0 THEN bitViewImageAll = True
	ELSE
		bitViewImageAll = True
	END IF
%>
<script type="text/javascript" language="javascript" src="Editor/utils/imageUtil.js"></script>
<script type="text/javascript" language="javascript" src="Editor/utils/lightbox.js"></script>
<div id="lightbox-container"></div>
<script language="javascript">
	var SET_Action = "<%=Action%>";
	var SET_bitUseEditor = "<%=CONF_bitUseEditor%>";
</script>