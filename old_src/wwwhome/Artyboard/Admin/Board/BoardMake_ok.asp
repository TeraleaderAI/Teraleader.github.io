<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Board/BoardList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM strBoardID, strName, strSkinGroup, strSkin, strCopyBoardID, bitBoardCopy, strMemo, strTitle, I

	FOR I = 1 TO REQUEST.FORM("strBoardID").COUNT
	
		WITH REQUEST
	
			strBoardID     = .FORM("strBoardID")(I)
			strName        = GetReplaceInput(.FORM("strName")(I), 1)
			strSkinGroup   = GetReplaceInput(.FORM("strSkinGroup"),"")
			strSkin        = GetReplaceInput(.FORM("strSkin"),"")
			strCopyBoardID = GetReplaceInput(.FORM("strCopyBoardID"),"")
			bitBoardCopy   = GetReplaceInput(.FORM("bitBoardCopy"),"")
			strMemo        = GetReplaceInput(.FORM("strMemo"), "")
			strTitle       = GetReplaceInput(.FORM("strTitle"), "")
	
		END WITH
	
		IF strName = "" THEN
			RESPONSE.WRITE ExecJavaAlert("게시판 이름을 입력해 주시기 바랍니다.", 0)
			RESPONSE.End()
		END IF
	
		ON ERROR RESUME NEXT
	
		CALL ExecFolderMake(rootPath & "Pds\Board\" & strBoardID)
		CALL ExecFolderMake(rootPath & "Pds\Board\" & strBoardID & "\Editor")
		CALL ExecFolderMake(rootPath & "Pds\Board\" & strBoardID & "\Small")
		CALL ExecFolderMake(rootPath & "Pds\Board\" & strBoardID & "\Thrum")
		CALL ExecFolderMake(rootPath & "Pds\Board\" & strBoardID & "\Category")
		CALL ExecFolderMake(rootPath & "Pds\Board\" & strBoardID & "\Temp")
		CALL ExecFolderMake(rootPath & "Pds\Board\" & strBoardID & "\WaterMark")
	
		IF err.Number <> 0 THEN
			RESPONSE.WRITE ExecJavaAlert("게시판 신규 생성시 오류가 발생되었습니다.\n\nERR:" & err.Number & ":" & err.Description, 0)
			RESPONSE.End()
		END IF
	
		IF bitBoardCopy = "1" THEN
	
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_CATEGORY] ([strBoardID], [intCategory], [strCategory], [intCategoryCount], [intStep]) SELECT [strBoardID] = '" & strBoardID & "', [intCategory], [strCategory], [intCategoryCount] = '0', [intStep] FROM [MPLUS_BOARD_CATEGORY] WHERE [strBoardID] = '" & strCopyBoardID & "' ")
	
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_CONFIG_DEFAULT] ([strBoardID], [strName], [strTitle], [strMemo], [strSkin], [strSkinGroup], [strAdmin], [strCharset], [strKeyword], [strDescription], [strLanguage], [strBrowser], [strFont], [strFontSize], [strWidth], [strBodyTag], [intTopMargin], [intLeftMargin], [intRightMargin], [strAlign], [strColorBg], [strColorActive], [strColorHover], [strColorVisited], [strColorLink], [strUserCss], [strHeadFile], [strTailFile], [strHeadText], [strTailText], [bitSecret], [strSecretPassword], [bitNotLink], [strNotLinkMsg], [strNotLinkList], [bitNotIp], [strNotIpMsg], [strNotIpList], [bitUseCategory], [bitUseVote], [bitUseComment], [bitUsePoint], [bitUseBad], [bitUseScrap], [bitUseNickName], [bitUseStat], [bitStatCheck], [bitBoardGroup], [bitAdminCheck], [bitUseRss]) SELECT [strBoardID] = '" & strBoardID & "', [strName] = '" & strName & "', [strTitle] = '" & strTitle & "', [strMemo] = '" & strMemo & "', [strSkin] = '" & strSkin & "', [strSkinGroup], [strAdmin], [strCharset], [strKeyword], [strDescription], [strLanguage], [strBrowser], [strFont], [strFontSize], [strWidth], [strBodyTag], [intTopMargin], [intLeftMargin], [intRightMargin], [strAlign], [strColorBg], [strColorActive], [strColorHover], [strColorVisited], [strColorLink], [strUserCss], [strHeadFile], [strTailFile], [strHeadText], [strTailText], [bitSecret], [strSecretPassword], [bitNotLink], [strNotLinkMsg], [strNotLinkList], [bitNotIp], [strNotIpMsg], [strNotIpList], [bitUseCategory], [bitUseVote], [bitUseComment], [bitUsePoint], [bitUseBad], [bitUseScrap], [bitUseNickName], [bitUseStat], [bitStatCheck], [bitBoardGroup], [bitAdminCheck], [bitUseRss] FROM [MPLUS_BOARD_CONFIG_DEFAULT] WHERE [strBoardID] = '" & strCopyBoardID & "' ")
	
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_CONFIG_LIST] ([strBoardID], [intRowCount], [intLineCount], [intLineHeight], [intListImgWidth], [intListImgHeight], [bitMouseOver], [strMouseOverColor], [bitPreview], [intPreviewCut], [intPreviewWidth], [intCutSubject], [intCutContent], [intCutName], [strNameClick], [strViewType], [intPopViewWidth], [intPopViewHeight], [strDateType], [strColorNoticeBg], [strColorNoticeFont], [strColorRepleBg], [strColorRepleFont], [strColorListOddBg], [strColorListEvenBg], [bitColorListBgGrd], [strColorListOddFont], [strColorListEvenFont], [bitColorListFontGrd], [strColorListReadBg], [strColorListReadFont], [strIconFolder], [strIconNotice], [strIconNew], [strIconReple], [strIconLine], [strIconSecret], [strIconRead], [strIconNewCmt], [bitUseSelectView], [intNewIconTime], [strBadSubject], [strLinkHomepage], [strLinkHomepageTarget], [intPageCount], [strPagePrevGroup], [strPageNextGroup], [strPageFirstPage], [strPageEndPage], [strPageNow], [strPageDefault], [bitUseSearch], [intSearchCount], [strSeaechTag]) SELECT [strBoardID] = '" & strBoardID & "', [intRowCount], [intLineCount], [intLineHeight], [intListImgWidth], [intListImgHeight], [bitMouseOver], [strMouseOverColor], [bitPreview], [intPreviewCut], [intPreviewWidth], [intCutSubject], [intCutContent], [intCutName], [strNameClick], [strViewType], [intPopViewWidth], [intPopViewHeight], [strDateType], [strColorNoticeBg], [strColorNoticeFont], [strColorRepleBg], [strColorRepleFont], [strColorListOddBg], [strColorListEvenBg], [bitColorListBgGrd], [strColorListOddFont], [strColorListEvenFont], [bitColorListFontGrd], [strColorListReadBg], [strColorListReadFont], [strIconFolder], [strIconNotice], [strIconNew], [strIconReple], [strIconLine], [strIconSecret], [strIconRead], [strIconNewCmt], [bitUseSelectView], [intNewIconTime], [strBadSubject], [strLinkHomepage], [strLinkHomepageTarget], [intPageCount], [strPagePrevGroup], [strPageNextGroup], [strPageFirstPage], [strPageEndPage], [strPageNow], [strPageDefault], [bitUseSearch], [intSearchCount], [strSeaechTag] FROM [MPLUS_BOARD_CONFIG_LIST] WHERE [strBoardID] = '" & strCopyBoardID & "' ")
	
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_CONFIG_READ] ([strBoardID], [strNameClick], [bitImgView], [intImgWidth], [intImgHeight], [intImgScare], [bitImgLightbox], [bitImgViewAll], [bitFileExe], [intExeWidth], [intExeHeight], [bitAutoLink], [bitWordBreak], [strBadErrMsg], [bitReadInsert], [bitVoteInsert], [bitContentIp], [bitCommentIp], [strDateTypeView], [strDateTypeComment], [bitCommentEdit], [bitCommentReply], [bitUseEditor], [strEditorWidth], [strEditorHeight], [strEditorWidthReply], [strEditorHeightReply], [bitEditorSource], [bitEditorPrev], [strEditorBgColor], [bitEditorZoom], [intEditorZoomSize], [bitPrevNext], [bitListReple], [bitListBoard], [bitViewSign]) SELECT [strBoardID] = '" & strBoardID & "', [strNameClick], [bitImgView], [intImgWidth], [intImgHeight], [intImgScare], [bitImgLightbox], [bitImgViewAll], [bitFileExe], [intExeWidth], [intExeHeight], [bitAutoLink], [bitWordBreak], [strBadErrMsg], [bitReadInsert], [bitVoteInsert], [bitContentIp], [bitCommentIp], [strDateTypeView], [strDateTypeComment], [bitCommentEdit], [bitCommentReply], [bitUseEditor], [strEditorWidth], [strEditorHeight], [strEditorWidthReply], [strEditorHeightReply], [bitEditorSource], [bitEditorPrev], [strEditorBgColor], [bitEditorZoom], [intEditorZoomSize], [bitPrevNext], [bitListReple], [bitListBoard], [bitViewSign] FROM [MPLUS_BOARD_CONFIG_READ] WHERE [strBoardID] = '" & strCopyBoardID & "' ")
			
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_CONFIG_WRITE] ([strBoardID], [strWriteDefault], [bitUseLink1], [bitUseLink2], [bitUseReple], [strReplePreview], [bitUseSecret], [bitUseSecretReple], [bitUseRepleMail], [bitUseWriteAdminMail], [strWriteMailList], [bitUseEditor], [strEditorWidth], [strEditorHeight], [bitEditorSource], [bitEditorPrev], [strEditorBgColor], [bitEditorZoom], [intEditorZoomSize], [bitEditorHostName], [strWriteOkLink], [strWriteCustLink], [bitWriteAdmin], [bitWriteAdminMsg], [bitUseCaptcha], [strBadContent], [strBadContentReplace], [strBadContentMsg], [strBadContentList], [bitAdminContent], [strAdminContentMsg], [strAdminContentList], [bitUseUpload], [intUploadCount], [bitUseUploadLarge], [bitUploadAdmin], [intUploadSize], [strUploadNotFile], [bitUploadReplaceFile], [strUploadReplaceFile], [bitThrum], [intThrumWidth], [intThrumHeight], [bitThrumScale], [strThrumProg], [bitUseWaterMark], [strWaterMarkType], [strWaterMarkCont], [bitUseExif]) SELECT [strBoardID] = '" & strBoardID & "', [strWriteDefault], [bitUseLink1], [bitUseLink2], [bitUseReple], [strReplePreview], [bitUseSecret], [bitUseSecretReple], [bitUseRepleMail], [bitUseWriteAdminMail], [strWriteMailList], [bitUseEditor], [strEditorWidth], [strEditorHeight], [bitEditorSource], [bitEditorPrev], [strEditorBgColor], [bitEditorZoom], [intEditorZoomSize], [bitEditorHostName], [strWriteOkLink], [strWriteCustLink], [bitWriteAdmin], [bitWriteAdminMsg], [bitUseCaptcha], [strBadContent], [strBadContentReplace], [strBadContentMsg], [strBadContentList], [bitAdminContent], [strAdminContentMsg], [strAdminContentList], [bitUseUpload], [intUploadCount], [bitUseUploadLarge], [bitUploadAdmin], [intUploadSize], [strUploadNotFile], [bitUploadReplaceFile], [strUploadReplaceFile], [bitThrum], [intThrumWidth], [intThrumHeight], [bitThrumScale], [strThrumProg], [bitUseWaterMark], [strWaterMarkType], [strWaterMarkCont], [bitUseExif] FROM [MPLUS_BOARD_CONFIG_WRITE] WHERE [strBoardID] = '" & strCopyBoardID & "' ")
	
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_POINT] ([strBoardID], [bitUsePoint], [intReadPoint], [intDownPoint], [intVotePoint], [intWritePoint], [intReplePoint], [intUploadPoint], [intCommentPoint]) SELECT [strBoardID] = '" & strBoardID & "', [bitUsePoint], [intReadPoint], [intDownPoint], [intVotePoint], [intWritePoint], [intReplePoint], [intUploadPoint], [intCommentPoint] FROM [MPLUS_BOARD_POINT] WHERE [strBoardID] = '" & strCopyBoardID & "' ")
	
			DBCON.EXECUTE("INSERT INTO [MPLUS_GROUP_BOARD] ([strBoardID], [strListLevel], [strListLevelUrl], [bitListLevelLogin], [strReadLevel], [strReadLevelUrl], [bitReadLevelLogin], [strWriteLevel], [strWriteLevelUrl], [bitWriteLevelLogin], [strRepleLevel], [strRepleLevelUrl], [bitRepleLevelLogin], [strWriteCommentLevel], [strReplyCommentLevel], [strReadCommentLevel], [strSubjectStyleLevel], [strUploadLevel], [strDownLevel]) SELECT [strBoardID] = '" & strBoardID & "', [strListLevel], [strListLevelUrl], [bitListLevelLogin], [strReadLevel], [strReadLevelUrl], [bitReadLevelLogin], [strWriteLevel], [strWriteLevelUrl], [bitWriteLevelLogin], [strRepleLevel], [strRepleLevelUrl], [bitRepleLevelLogin], [strWriteCommentLevel], [strReplyCommentLevel], [strReadCommentLevel], [strSubjectStyleLevel], [strUploadLevel], [strDownLevel] FROM [MPLUS_GROUP_BOARD] WHERE [strBoardID] = '" & strCopyBoardID & "' ")
	
		ELSE
	
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_CATEGORY] ([strBoardID], [strCategory]) VALUES ('" & strBoardID & "', '분류') ")
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_CONFIG_DEFAULT] ([strBoardID], [strName], [strTitle], [strMemo], [strSkin], [strSkinGroup]) VALUES ('" & strBoardID & "', '" & strName & "', '" & strTitle & "', '" & strMemo & "', '" & strSkin & "', '" & strSkinGroup & "') ")
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_CONFIG_LIST] ([strBoardID]) VALUES ('" & strBoardID & "') ")
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_CONFIG_READ] ([strBoardID]) VALUES ('" & strBoardID & "') ")
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_CONFIG_WRITE] ([strBoardID], [strBadContent], [strBadContentList], [strWaterMarkCont]) VALUES ('" & strBoardID & "','2','onmouse,meta,onclick,onsubmit,object,applet,caption,noscript,textarea,xmp,XMP,iframe,plaintext,title,script,body', '" & strBoardID & "||WaterMark|10|10|10" & "') ")
	
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_POINT] ([strBoardID]) VALUES ('" & strBoardID & "') ")
			DBCON.EXECUTE("INSERT INTO [MPLUS_GROUP_BOARD] ([strBoardID]) VALUES ('" & strBoardID & "') ")
	
			DIM strPagePrevGroup, strPageNextGroup, strPageFirstPage, strPageEndPage, strPageNow, strPageDefault, strSeaechTag
	
			strPagePrevGroup = "<a href='{LINK}' style='font-size:8pt; font-family:굴림;'>◀</a>"
			strPagePrevGroup = GetReplaceInput(strPagePrevGroup, "")
			strPageNextGroup = "<a href='{LINK}' style='font-size:8pt; font-family:굴림;'>▶</a>"
			strPageNextGroup = GetReplaceInput(strPageNextGroup, "")
			strPageFirstPage = "<a href='{LINK}' style='font-size:8pt; font-family:굴림;'>[{PAGE}]</a>.."
			strPageFirstPage = GetReplaceInput(strPageFirstPage, "")
			strPageEndPage   = "..<a href='{LINK}' style='font-size:8pt; font-family:굴림;'>[{PAGE}]</a>"
			strPageEndPage   = GetReplaceInput(strPageEndPage, "")
			strPageNow       = "<font style=&#39;font-size:8pt; font-family:굴림;&#39;><b>[{PAGE}]</b></font>"
			strPageNow       = GetReplaceInput(strPageNow, "")
			strPageDefault   = "<a href=&#39;{LINK}&#39; style=&#39;font-size:8pt; font-family:굴림;&#39;>[{PAGE}]</a>"
			strPageDefault   = GetReplaceInput(strPageDefault, "")
			strSeaechTag     = "<font color='#CCCCCC'>{KEY}</font>"
			strSeaechTag     = GetReplaceInput(strSeaechTag, "")
	
			DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CONFIG_LIST] SET [strPagePrevGroup] = '" & strPagePrevGroup & "', [strPageNextGroup] = '" & strPageNextGroup & "', [strPageFirstPage] = '" & strPageFirstPage & "', [strPageEndPage] = '" & strPageEndPage & "', [strPageNow] = '" & strPageNow & "', [strPageDefault] = '" & strPageDefault & "' WHERE [strBoardID] = '" & strBoardID & "' ")
	
		END IF
	
	NEXT
	
	RESPONSE.WRITE ExecFormSubmit("정상적으로 게시판이 생성되었습니다.", "BoardList.asp", "")
	RESPONSE.End()
%>
<% SET RS = NOTHING : DBCON.CLOSE %>