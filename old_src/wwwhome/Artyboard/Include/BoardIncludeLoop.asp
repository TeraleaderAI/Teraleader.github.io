<!-- #include file = "BoardIncludeReadDefault.asp" -->
<%
	LIST_intSeq          = AdRs_intSeq
	LIST_intIndex        = AdRs_intIndex
	LIST_intThread       = AdRs_intThread
	LIST_intDepth        = AdRs_intDepth
	LIST_strLoginID      = AdRs_strLoginID
	LIST_intCategory     = AdRs_intCategory
	LIST_strName         = GetCutSubject(AdRs_strName, CONF_intCutName)
	LIST_strNickName     = AdRs_strNickName
	IF CONF_bitUseNickName = True THEN
		IF LIST_strLoginID <> "guest" AND AdRs_strNickName <> "" AND ISNULL(AdRs_strNickName) = False THEN LIST_strName = AdRs_strNickName
	END IF
	LIST_strPassword     = AdRs_strPassword
	LIST_strEmail        = AdRs_strEmail
	LIST_strHomepage     = AdRs_strHomepage

	LIST_strSubject      = "<span style="""
	IF AdRs_strSubjectStyle(0) <> "" THEN LIST_strSubject = LIST_strSubject & "font-family:" & AdRs_strSubjectStyle(0) & ";"
	IF AdRs_strSubjectStyle(1) <> "" THEN LIST_strSubject = LIST_strSubject & "color:" & AdRs_strSubjectStyle(1) & ";"
	IF AdRs_strSubjectStyle(2) <> "" THEN LIST_strSubject = LIST_strSubject & "background:" & AdRs_strSubjectStyle(2) & ";"
	IF AdRs_strSubjectStyle(3) <> "" THEN LIST_strSubject = LIST_strSubject & "font-weight:" & AdRs_strSubjectStyle(3) & ";"
	LIST_strSubject = LIST_strSubject & """>"

	LIST_strSubject      = LIST_strSubject & GetCutSubject(GetReplaceTag2Html(AdRs_strSubject), CONF_intCutSubject)
	LIST_strSubject      = LIST_strSubject & "</span>"

	LIST_strContent      = GetCutSubject(AdRs_strContent, CONF_intCutContent)
	LIST_strContentPrev  = REPLACE(GetReplaceTag2Text(GetCutSubject(StripTags(AdRs_strContent), CONF_intPreviewCut)), CHR(10)&CHR(13), "<br>")

	IF AdRs_strBoardBg = "" OR ISNULL(AdRs_strBoardBg) = True THEN LIST_strBoardBg = False
	LIST_strIpAddr       = AdRs_strIpAddr
	LIST_bitDelete       = AdRs_bitDelete
	LIST_bitHtml         = AdRs_bitHtml

	IF LIST_bitHtml = True THEN
		LIST_strContent     = GetReplaceTag2Html(LIST_strContent)
		LIST_strContentPrev = GetReplaceTag2Html(LIST_strContentPrev)
	END IF

	LIST_bitHtmlBr       = AdRs_bitHtmlBr
	IF LIST_bitHtmlBr = True THEN
		LIST_strContent     = GetReplaceTag2HtmlBr(LIST_strContent)
		LIST_strContentPrev = GetReplaceTag2HtmlBr(LIST_strContentPrev)
	END IF

	LIST_bitText         = AdRs_bitText
	IF LIST_bitText = True THEN
		LIST_strContent     = GetReplaceTag2Text(LIST_strContent)
		LIST_strContentPrev = GetReplaceTag2Text(LIST_strContentPrev)
	END IF

	LIST_bitNotice       = AdRs_bitNotice
	LIST_bitReMail       = AdRs_bitReMail
	LIST_bitSecret       = AdRs_bitSecret
	LIST_strSecretID     = AdRs_strSecretID
	LIST_bitBad          = AdRs_bitBad
	LIST_intRead         = AdRs_intRead
	LIST_intVote         = AdRs_intVote
	LIST_intComment      = AdRs_intComment

	IF CONF_bitUseLink1 = True THEN
		IF ISNULL(AdRs_strLink1) = False AND AdRs_strLink1 <> "" THEN
			LIST_strLink        = SPLIT(AdRs_strLink1, "|")
			IF LIST_strLink(0) = "" THEN
				LIST_strLink1       = False
			ELSE
				LIST_strLink1       = LIST_strLink(0)
				LIST_strLinkTarget1 = LIST_strLink(1)
			END IF
		ELSE
			LIST_strLink1 = False
		END IF
	ELSE
		LIST_strLink1 = False
	END IF

	IF CONF_bitUseLink2 = True THEN
		IF ISNULL(AdRs_strLink2) = False AND AdRs_strLink2 <> "" THEN
			LIST_strLink        = SPLIT(AdRs_strLink2, "|")
			IF LIST_strLink(0) = "" THEN
				LIST_strLink2       = False
			ELSE
				LIST_strLink2       = LIST_strLink(0)
				LIST_strLinkTarget2 = LIST_strLink(1)
			END IF
		ELSE
			LIST_strLink2 = False
		END IF
	ELSE
		LIST_strLink2 = False
	END IF

	LIST_intFileCount    = AdRs_intFileCount
	LIST_intImgCount     = AdRs_intImgCount
	LIST_strFileCode     = AdRs_strFileCode
	LIST_dateCmtDate     = AdRs_dateCmtDate
	LIST_dateRegDate     = GetDateType(CONF_strDateType, AdRs_dateRegDate)

	IF CONF_bitUseMarkAvata = True THEN
		IF AdRs_strMarkImage = "" OR ISNULL(AdRs_strMarkImage) = True THEN LIST_strMarkImage = False ELSE LIST_strMarkImage = "<img src='Pds/Member/GroupIcon/" & AdRs_strMarkImage & "' align='absmiddle'>"
	END IF
	IF CONF_bitUseNameAvata = True THEN
		IF AdRs_strUserImage = "" OR ISNULL(AdRs_strUserImage) = True THEN
			LIST_strNameImage  = False
			LIST_strPhotoImage = False
		ELSE
			List_strUserImage = SPLIT(AdRs_strUserImage, "|")
			IF List_strUserImage(0) = "" OR ISNULL(List_strUserImage(0)) = True THEN
				LIST_strNameImage  = False
			ELSE
				LIST_strNameImage  = "<img src='Pds/Member/Name/" & List_strUserImage(0) & "' align='absmiddle'>"
			END IF
			IF List_strUserImage(1) = "" OR ISNULL(List_strUserImage(1)) = True THEN
				LIST_strPhotoImage = False
			ELSE
				LIST_strPhotoImage = "<img src='Pds/Member/Photo/" & List_strUserImage(1) & "' align='absmiddle'>"
			END IF
		END IF
	END IF

	IF LIST_intFileCount = 0 THEN
		LIST_strFileName      = False
		LIST_strFileLink      = ""
	ELSE
		LIST_strFileName      = AdRs_strFileName
		IF CONF_bitDownLevel = True THEN
			LIST_strFileLink = "javascript:openWindows('Library/fileList.asp?strBoardID=" & strBoardID & "&intSeq=" & LIST_intSeq & "','fileList','480','500','3');"
		ELSE
			LIST_strFileLink = "javascript:;"
		END IF
	END IF

	LIST_strFileImage    = AdRs_strFileImage
	IF LIST_strFileImage <> "" AND ISNULL(LIST_strFileImage) = False THEN
		LIST_strFileImageSplit = SPLIT(LIST_strFileImage, "|")
		LIST_strFileImage       = LIST_strFileImageSplit(0)
		LIST_strFileImageWidth  = LIST_strFileImageSplit(1)
		LIST_strFileImageHeight = LIST_strFileImageSplit(2)
		LIST_strFileImageSize   = GetFilesize(LIST_strFileImageSplit(3))
		LIST_strFileImageLink   = "javascript:OnZoomGallery('" & LIST_strFileImage & "', '" & strBoardID & "');"
'		LIST_strFileImageLink   = "Pds/Board/" & strBoardID & "/" & LIST_strFileImage
	ELSE
		LIST_strFileImage       = False
		LIST_strFileImageWidth  = ""
		LIST_strFileImageHeight = ""
		LIST_strFileImageSize   = ""
		LIST_strFileImageLink   = ""
	END IF

	IF LIST_intCategory = "0" THEN
		LIST_strCategory = "정보없음"
	ELSE
		LIST_strCategory = AdRs_strCategory
	END IF

	IF LIST_bitBad = True THEN
		IF CONF_strBadSubject <> "" THEN LIST_strSubject = CONF_strBadSubject
	END IF

	CONF_intColorListCount = CONF_intColorListCount + 1

	IF CONF_bitColorListBgGrd = True THEN
		CONF_strColorListBg = GetGrColor(CONF_intColorListCount, CONF_strColorListOddBg, intStepRgb1, intStepRgb2, intStepRgb3)
	ELSE
		IF AdRs_intDepth = 0 THEN
			IF (CONF_intColorListCount mod 2) = 1 THEN CONF_strColorListBg = CONF_strColorListOddBg ELSE CONF_strColorListBg = CONF_strColorListEvenBg
		ELSE
			CONF_strColorListFont = CONF_strColorRepleFont
			CONF_strColorListBg   = CONF_strColorRepleBg
		END IF
	END IF

	IF CONF_bitColorListFontGrd = True THEN
		CONF_strColorListFont = GetGrColor(CONF_intColorListCount, CONF_strColorListOddFont, intStepRgbFont1, intStepRgbFont2, intStepRgbFont3)
	ELSE
		IF AdRs_intDepth = 0 THEN
			IF (CONF_intColorListCount mod 2) = 1 THEN CONF_strColorListFont = CONF_strColorListOddFont ELSE CONF_strColorListFont = CONF_strColorListEvenFont
		ELSE
			CONF_strColorListFont = CONF_strColorRepleFont
			CONF_strColorListBg   = CONF_strColorRepleBg
		END IF
	END IF

	LIST_iConFolder = CONF_strIconFolder
	LIST_iConNotice = CONF_strIconNotice

	IF GetNewBoardTime(CONF_intNewIconTime, AdRs_dateRegDate) = True THEN LIST_iConNew = GetListIcon("New", CONF_strIconNew) ELSE LIST_iConNew = False

	IF GetNewBoardTime(CONF_intNewIconTime, AdRs_dateCmtDate) = True THEN LIST_iConNewCmt = GetListIcon("NewCmt", CONF_strIconNewCmt) ELSE LIST_iConNewCmt = False

	LIST_strAddData1  = AdRs_strAddData1
	LIST_strAddData2  = AdRs_strAddData2
	LIST_strAddData3  = AdRs_strAddData3
	LIST_strAddData4  = AdRs_strAddData4
	LIST_strAddData5  = AdRs_strAddData5
	LIST_strAddData6  = AdRs_strAddData6
	LIST_strAddData7  = AdRs_strAddData7
	LIST_strAddData8  = AdRs_strAddData8
	LIST_strAddData9  = AdRs_strAddData9
	LIST_strAddData10 = AdRs_strAddData10

	IF AdRs_intDepth = 0 THEN
		LIST_iConReply = False
	ELSE
		LIST_iConReply = ""
		FOR I = 1 TO AdRs_intDepth
			LIST_iConReply = LIST_iConReply & "&nbsp;&nbsp;"
		NEXT
		IF GetListIcon("Reple", CONF_strIconReple) = False THEN LIST_iConReply = LIST_iConReply & "Re: " ELSE LIST_iConReply = LIST_iConReply & "<img src=" & GetListIcon("Reple", CONF_strIconReple) & " align=absmiddle>"
	END IF
	LIST_iConLine   = CONF_strIconLine
	IF LIST_bitSecret = True THEN LIST_iConSecret = GetListIcon("Secret", CONF_strIconSecret) ELSE LIST_iConSecret = False

	IF GetReplaceInput(REQUEST.QueryString("intSeq"),"S") = "" THEN
		LIST_iConRead = FalseCONF_strIconRead
	ELSE
		IF INT(List_intSeq) = INT(GetReplaceInput(REQUEST.QueryString("intSeq"),"S")) THEN
			LIST_iConRead = GetListIcon("Read", CONF_strIconRead)
			CONF_strColorListFont = CONF_strColorListReadFont
			CONF_strColorListBg   = CONF_strColorListReadBg
		ELSE
			LIST_iConRead = False
		END IF
	END IF

	IF isSearch = True AND LIST_bitNotice = False THEN
		IF CONF_strSeaechTag <> "" AND ISNULL(CONF_strSeaechTag) = False THEN
			IF bitSearchType01 = 1 THEN LIST_strLoginID = GetChangeSearchTag(LIST_strLoginID, strSearchWord, REPLACE(CONF_strSeaechTag, "&#39;", "'"))
			IF bitSearchType02 = 1 THEN LIST_strName    = GetChangeSearchTag(LIST_strName   , strSearchWord, REPLACE(CONF_strSeaechTag, "&#39;", "'"))
			IF bitSearchType03 = 1 THEN LIST_strSubject = GetChangeSearchTag(LIST_strSubject, strSearchWord, REPLACE(CONF_strSeaechTag, "&#39;", "'"))
			IF bitSearchType04 = 1 THEN LIST_strContent = GetChangeSearchTag(LIST_strContent, strSearchWord, REPLACE(CONF_strSeaechTag, "&#39;", "'"))
		END IF
	END IF

	LIST_strReadLink = "javascript:OnReadArticle('" & LIST_intSeq & "');"

	IF LIST_bitNotice = False THEN
		LIST_intViewNumTemp = LIST_intViewNumTemp + 1
		LIST_intViewNum = INT(LIST_intTotalCount) - ((CONF_intLineCount * CONF_intRowCount) * (INT(intPage) - 1)) - INT(LIST_intViewNumTemp) + 1
	END IF

	IF CONF_bitBoardAdmin = True THEN
		CONF_bitEditLevel = True
	ELSE
		IF LIST_strLoginID = "guest" THEN
			CONF_bitEditLevel = True
		ELSE
			IF SESSION("strLoginID") = LIST_strLoginID THEN CONF_bitEditLevel = True ELSE CONF_bitEditLevel = False
		END IF
	END IF

	IF CONF_bitBoardAdmin = True THEN
		CONF_bitRemoveLevel = True
	ELSE
		IF LIST_strLoginID = "guest" THEN
			CONF_bitRemoveLevel = True
		ELSE
			IF SESSION("strLoginID") = LIST_strLoginID THEN CONF_bitRemoveLevel = True ELSE CONF_bitRemoveLevel = False
		END IF
	END IF

	IF CONF_bitBoardAdmin = False THEN
		IF LIST_bitSecret = True THEN
			IF LIST_strLoginID = "guest" THEN
				LIST_strContentPrev = DIM_strBoardMsg(16)
				LIST_strContent     = DIM_strBoardMsg(16)
			ELSE
				IF SESSION("strLoginID") = "" THEN
					LIST_strContentPrev = DIM_strBoardMsg(16)
					LIST_strContent     = DIM_strBoardMsg(16)
				ELSE
					IF SESSION("strLoginID") <> LIST_strSecretID THEN
						LIST_strContentPrev = DIM_strBoardMsg(16)
						LIST_strContent     = DIM_strBoardMsg(16)
					END IF
				END IF
			END IF
		END IF
	END IF
%>