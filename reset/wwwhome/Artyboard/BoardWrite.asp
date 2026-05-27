<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "Dbconnect/Dbconnect.asp" -->
<!-- #include file = "Library/Function.asp" -->
<%
	RESPONSE.EXPIRES     = 0
	SERVER.SCRIPTTIMEOUT = 2000

	DIM strBoardID, Action, strSearchCategory, strSearchWord, intPage, intSeq

	WITH REQUEST

		strBoardID        = GetReplaceInput(.QueryString("strBoardID"), "S")
		Action            = UCASE(GetReplaceInput(.QueryString("Action"), "S"))
		strSearchCategory = GetReplaceInput(.QueryString("strSearchCategory"), "S")
		strSearchWord     = GetReplaceInput(.QueryString("strSearchWord"), "S")
		intPage           = GetReplaceInput(.QueryString("intPage"), "S")
		intSeq            = GetReplaceInput(.QueryString("intSeq"), "S")

	END WITH

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_LIST] '" & strBoardID & "' ")

	DIM CONF_strViewType
	CONF_strViewType = RS("strViewType")

	DIM bitUsePoint, intWritePoint, intReplePoint, intUploadPoint, insertIntSeq

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_POINT] '" & strBoardID & "' ")
	
	bitUsePoint         = RS("bitUsePoint")
	intWritePoint       = RS("intWritePoint")
	intReplePoint       = RS("intReplePoint")
	intUploadPoint      = RS("intUploadPoint")

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '" & strBoardID & "', '" & SESSION("strLoginID") & "' ")

	DIM strAdmin, bitBoardAdmin, bitAdminCheck, CONF_strLanguage
	strAdmin         = RS("strAdmin")
	bitBoardAdmin    = GetAdminCheck(SESSION("strLoginID"), RS("strAdmin"), SESSION("strAdmin"))
	bitAdminCheck    = RS("bitAdminCheck")
	CONF_strLanguage = RS("strLanguage")
%>
<!-- #include file = "Include/BoardIncludeLanguage.asp" -->
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_WRITE] '" & strBoardID & "' ")

	DIM bitUseWriteAdminMail, strWriteMailList, strWriteOkLink, strWriteCustLink, strBadContent, strBadContentReplace
	DIM strBadContentMsg, strBadContentList, bitAdminContent, strAdminContentMsg, strAdminContentList, bitUseEditor
	DIM bitUseCaptcha

	bitUseWriteAdminMail = RS("bitUseWriteAdminMail")
	strWriteMailList     = RS("strWriteMailList")
	strWriteOkLink       = RS("strWriteOkLink")
	strWriteCustLink     = RS("strWriteCustLink")
	strBadContent        = RS("strBadContent")
	strBadContentReplace = RS("strBadContentReplace")
	strBadContentMsg     = RS("strBadContentMsg")
	strBadContentList    = RS("strBadContentList")
	bitAdminContent      = RS("bitAdminContent")
	strAdminContentMsg   = RS("strAdminContentMsg")
	strAdminContentList  = RS("strAdminContentList")
	bitUseEditor         = RS("bitUseEditor")
	bitUseCaptcha        = RS("bitUseCaptcha")

	DIM strPath, strFileCode
	strPath     = rootPath & "Pds\Board\" & strBoardID & "\"

	DIM strLoginID, intCategory, strName, strPassword, strEmail, strHomepage, strSubject, strSubjectStyle, strContent
	DIM strLink1, strLink2, strBoardBg, bitHtml, bitHtmlBr, bitText, bitNotice, bitReMail, bitSecret, bitCook, strSecretID
	DIM intFileCount, intImgCount, I, strScYear, strScMonth, strScDay, strScHour, strScMinute, bitCheck, strSessionID

	WITH REQUEST

		strLoginID          = GetReplaceInput(.FORM("strLoginID"), "")
		intCategory         = GetReplaceInput(.FORM("intCategory"), "")
		strName             = GetReplaceInput(.FORM("strName"), 1)
		strPassword         = GetReplaceInput(.FORM("strPassword"), 1)
		strEmail            = GetReplaceInput(.FORM("strEmail"), 1)
		strHomepage         = GetReplaceInput(.FORM("strHomepage"), 1)
	
		IF strHomepage <> "" AND ISNULL(strHomepage) = False THEN
			IF UCASE(LEFT(strHomepage, 7)) <> "HTTP://" THEN strHomepage = "http://" & strHomepage
		END IF
	
		strSubject          = GetReplaceInput(.FORM("strSubject"), 1)
		strSubjectStyle     = .FORM("strSubjectStyle1") & "," & .FORM("strSubjectStyle2") & "," & .FORM("strSubjectStyle3") & "," & .FORM("strSubjectStyle4")
		strContent          = GetReplaceInput(.FORM("strContent"), 0)
		strSmallSubject     = GetReplaceInput(.FORM("strSmallSubject"), 0)
		strSmallContent     = GetReplaceInput(.FORM("strSmallContent"), 0)
		strLink1            = GetReplaceInput(.FORM("strLink1"), 1) & "|" & .FORM("strLink1Target")
		strLink2            = GetReplaceInput(.FORM("strLink2"), 1) & "|" & .FORM("strLink2Target")
		strBoardBg          = .FORM("strBoardBg")
		bitHtml             = .FORM("bitHtml")
		bitHtmlBr           = .FORM("bitHtmlBr")
		bitText             = .FORM("bitText")
		bitNotice           = .FORM("bitNotice")
		bitReMail           = .FORM("bitReMail")
		bitSecret           = .FORM("bitSecret")
		bitCook             = .FORM("bitCook")
		strScYear           = GetReplaceInput(.FORM("strScYear"), "")
		strScMonth          = GetReplaceInput(.FORM("strScMonth"), "")
		strScDay            = GetReplaceInput(.FORM("strScDay"), "")
		strScHour           = GetReplaceInput(.FORM("strScHour"), "")
		strScMinute         = GetReplaceInput(.FORM("strScMinute"), "")
		strAddData1         = GetReplaceInput(.FORM("strAddData1"), "")
		strAddData2         = GetReplaceInput(.FORM("strAddData2"), "")
		strAddData3         = GetReplaceInput(.FORM("strAddData3"), "")
		strAddData4         = GetReplaceInput(.FORM("strAddData4"), "")
		strAddData5         = GetReplaceInput(.FORM("strAddData5"), "")
		strAddData6         = GetReplaceInput(.FORM("strAddData6"), "")
		strAddData7         = GetReplaceInput(.FORM("strAddData7"), "")
		strAddData8         = GetReplaceInput(.FORM("strAddData8"), "")
		strAddData9         = GetReplaceInput(.FORM("strAddData9"), "")
		strAddData10        = GetReplaceInput(.FORM("strAddData10"), "")
		strSessionID        = .FORM("strSessionID")

	END WITH

	IF strName = "" THEN
		RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(0), 0)
		RESPONSE.End()
	END IF

	IF bitBoardAdmin = False AND strLoginID = "guest" AND strPassword = "" THEN
		RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(1), 0)
		RESPONSE.End()
	END IF

	IF strSubject = "" THEN
		RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(2), 0)
		RESPONSE.End()
	END IF

	IF intCategory = "" THEN intCategory = 0
	IF bitHtml     = "" THEN bitHtml     = 0
	IF bitText     = "" THEN bitText     = 0
	IF bitNotice   = "" THEN bitNotice   = 0
	IF bitReMail   = "" THEN bitReMail   = 0
	IF bitSecret   = "" THEN bitSecret   = 0
	IF bitCook     = "" THEN bitCook     = 0

	IF strScMonth <> "" THEN
		IF LEN(strScMonth) = 1 THEN strScMonth = "0" & strScMonth
	END IF

	IF strScDay <> "" THEN
		IF LEN(strScDay) = 1 THEN strScDay = "0" & strScDay
	END IF

	IF bitAdminCheck = True THEN
		IF bitBoardAdmin = True THEN bitCheck = 1 ELSE bitCheck = 0
	ELSE
		bitCheck = 1
	END IF

	IF bitUseEditor = True THEN
		IF strBadContentList <> "" AND ISNULL(strBadContentList) = False THEN strBadContentList = REPLACE(LCASE(strBadContentList), "onclick,", "")
	END IF

	SELECT CASE strBadContent
	CASE "1"
		IF strBadContentList <> "" AND ISNULL(strBadContentList) = False THEN
			DIM badWords
			badWords = SPLIT(strBadContentList, ",")
			FOR I = 0 TO UBOUND(badWords)
				IF badWords(I) <> "" THEN
					strSubject = REPLACE(strSubject, badWords(I), strBadContentReplace)
					strContent = REPLACE(strContent, badWords(I), strBadContentReplace)
					IF strSmallSubject <> "" AND ISNULL(strSmallSubject) = False THEN strSmallSubject = REPLACE(strSmallSubject, badWords(I), strBadContentReplace)
					IF strSmallContent <> "" AND ISNULL(strSmallContent) = False THEN strSmallContent = REPLACE(strSmallContent, badWords(I), strBadContentReplace)
				END IF
			NEXT
		END IF
	CASE "2"
		IF GetSplitFindWord(strBadContentList, strSubject & strContent & strSmallSubject & strSmallContent) = False THEN
			RESPONSE.WRITE ExecJavaAlert(strBadContentMsg, 0)
			RESPONSE.End()
		END IF
	END SELECT

	IF bitBoardAdmin = False THEN
		IF bitAdminContent = True THEN
			IF GetSplitFindWord(strAdminContentList, strName) = False THEN
				RESPONSE.WRITE ExecJavaAlert(strAdminContentMsg, 0)
				RESPONSE.End()
			END IF
		END IF
	END IF

	IF bitHtml = "1" OR bitHtmlBr = "1" THEN


		DIM html_word, J
		html_word = SPLIT("onmouse,meta,onclick,onsubmit,object,applet,caption,noscript,textarea,xmp,iframe,plaintext,title,body,style,scruot,iframe,frameset,fieldset,xml,html,head", ",")
	
		FOR EACH J IN html_word
			strContent=REPLACE(strContent,"&lt;"&TRIM(j)&" ","<"&TRIM(j)&" ")
			strContent=REPLACE(strContent,"&lt;"&TRIM(j)&">","<"&TRIM(j)&">")
			strContent=REPLACE(strContent,"&lt;/"&TRIM(j),"</"&TRIM(j))
		NEXT

	END IF

	DIM theField, strUploadFile, intUploadCount, strImageUploadFIle, intImageUploadCount, intImageUploadCountTemp, intUploadFileSize
	DIM intFileImgWidth, intFileImgHeight

	SELECT CASE Action
	CASE "WRITE", "REPLY"
		DIM intMaxIndex, intMaxThread, intDepth, prevBoardReply, prevBoardReplyMail, prevBoardReplyName

		IF Action = "WRITE" THEN
			SET RS = DBCON.EXECUTE("EXEC [MPLUS_PUT_WRITE] '" & strBoardID & "' ")
			intMaxIndex  = RS("intMaxIndex")
			intMaxThread = RS("intMaxThread")
			intDepth     = 0
			strFileCode  = RS("strFileCode")
			strSecretID  = strLoginID
		ELSE
			SET RS = DBCON.EXECUTE("EXEC [MPLUS_PUT_REPLY] '" & strBoardID & "', '" & intSeq & "' ")
			intMaxIndex        = RS("intIndex")
			intMaxThread       = RS("intReplyThread")
			intDepth           = RS("intReplyDepth")
			strFileCode        = RS("strFileCode")
			strSecretID        = RS("strSecretID")
			prevBoardReply     = RS("replyBitMail")
			prevBoardReplyMail = RS("replyEmail")
			prevBoardReplyName = RS("replyName")
		END IF

		IF strFileCode = "" OR ISNULL(strFileCode) = True THEN
			strFileCode = "0000000000001"
		ELSE
			strFileCode = INT(strFileCode) + 1
			FOR I = LEN(strFileCode) TO 12
				strFileCode = "0" & strFileCode
			NEXT
		END IF

		DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_FILE] ([strBoardID], [strFileCode], [intFileType], [strFileName], [intFileSize], [imgWidth], [imgHeight], [strPhotoInfo]) SELECT '" & strBoardID & "', '" & strFileCode & "', [intFileType], [strFileName], [intFileSize], [imgWidth], [imgHeight], [strPhotoInfo] FROM [MPLUS_BOARD_FILE_TEMP] WHERE [sessionID] = '" & strSessionID & "' ORDER BY [intSeq] ASC ")

		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_FILE_TEMP] WHERE [sessionID] = '" & strSessionID & "' ")

		SET RS = DBCON.EXECUTE("SELECT COUNT([intNum]) AS [intFileCount], COUNT(CASE WHEN [intFileType] = 0 THEN 1 END) AS [intImgCount] FROM [MPLUS_BOARD_FILE] WHERE [strBoardID] = '" & strBoardID & "' AND [strFileCode] = '" & strFileCode & "' ")

		intFileCount = RS("intFileCount")
		intImgCount  = RS("intImgCount")

		DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD] ([strBoardID], [intIndex], [intThread], [intDepth], [strLoginID], [intCategory], [strName], [strPassword], [strEmail], [strHomepage], [strSubject], [strSubjectStyle], [strContent], [strSmallSubject], [strSmallContent], [strLink1], [strLink2], [strIpAddr], [bitCheck], [strBoardBg], [bitHtml], [bitHtmlBr], [bitText], [bitNotice], [bitReMail], [bitSecret], [strSecretID], [strFileCode], [intFileCount], [intImgCount], [strAddData1], [strAddData2], [strAddData3], [strAddData4], [strAddData5], [strAddData6], [strAddData7], [strAddData8], [strAddData9], [strAddData10]) VALUES ('" & strBoardID & "', '" & intMaxIndex & "', '" & intMaxThread & "', '" & intDepth & "', '" & strLoginID & "', '" & intCategory & "', '" & strName & "', '" & strPassword & "', '" & strEmail & "', '" & strHomepage & "', '" & strSubject & "', '" & strSubjectStyle & "', '" & strContent & "', '" & strSmallSubject & "', '" & strSmallContent & "', '" & strLink1 & "', '" & strLink2 & "', '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "', '" & bitCheck & "', '" & strBoardBg & "', '" & bitHtml & "', '" & bitHtmlBr & "', '" & bitText & "', '" & bitNotice & "', '" & bitReMail & "', '" & bitSecret & "', '" & strSecretID & "', '" & strFileCode & "', '" & intFileCount & "', '" & intImgCount & "', '" & strAddData1 & "', '" & strAddData2 & "', '" & strAddData3 & "', '" & strAddData4 & "', '" & strAddData5 & "', '" & strAddData6 & "', '" & strAddData7 & "', '" & strAddData8 & "', '" & strAddData9 & "', '" & strAddData10 & "') ")

		IF strScYear <> "" AND strScMonth <> "" AND strScDay <> "" THEN DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [dateRegDate] = '" & strScYear & "-" & strScMonth & "-" & strScDay & " " & strScHour & ":" & strScMinute & ":" & SECOND(NOW) & "' WHERE [strBoardID] = '" & strBoardID & "' AND [intThread] = '" & intMaxThread & "' ")

	CASE "EDIT"

		DIM bitEditLevel, SQL_Query

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_READ_DEFAULT] '" & intSeq & "' ")
		strFileCode = RS("strFileCode")

		DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_FILE] ([strBoardID], [strFileCode], [intFileType], [strFileName], [intFileSize], [imgWidth], [imgHeight]) SELECT '" & strBoardID & "', '" & strFileCode & "', [intFileType], [strFileName], [intFileSize], [imgWidth], [imgHeight] FROM [MPLUS_BOARD_FILE_TEMP] WHERE [sessionID] = '" & strSessionID & "' ORDER BY [intSeq] ASC ")

		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_FILE_TEMP] WHERE [sessionID] = '" & strSessionID & "' ")

		IF bitBoardAdmin = True THEN
			bitEditLevel = True
		ELSE
			IF RS("strLoginID") = "guest" THEN
				IF RS("strPassword") = strPassword THEN bitEditLevel = True ELSE bitEditLevel = False
			ELSE
				IF RS("strLoginID") = SESSION("strLoginID") THEN bitEditLevel = True ELSE bitEditLevel = False
			END IF
		END IF

		IF bitEditLevel = False THEN
			RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(20), 0)
			RESPONSE.End()
		END IF

		IF intCategory <> "0" THEN
			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_READ_DEFAULT] '" & intSeq & "' ")
			IF INT(RS("intCategory")) <> INT(intCategory) THEN
				DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [intCategoryCount] = [intCategoryCount] + 1 WHERE [strBoardID] = '" & strBoardID & "' AND [intCategory] = '" & intCategory & "' ")
				DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [intCategoryCount] = [intCategoryCount] - 1 WHERE [strBoardID] = '" & strBoardID & "' AND [intCategory] = '" & RS("intCategory") & "' ")
			END IF
		END IF

		DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [intCategory] = '" & intCategory & "', [strName] = '" & strName & "', [strEmail] = '" & strEmail & "', [strHomepage] = '" & strHomepage & "', [strSubject] = '" & strSubject & "', [strSubjectStyle] = '" & strSubjectStyle & "', [strContent] = '" & strContent & "', [strSmallSubject] = '" & strSmallSubject & "', [strSmallContent] = '" & strSmallContent & "', [strLink1] = '" & strLink1 & "', [strLink2] = '" & strLink2 & "', [strIpAddr] = '" & strIpAddr & "', [strBoardBg] = '" & strBoardBg & "', [bitHtml] = '" & bitHtml & "', [bitHtmlBr] = '" & bitHtmlBr & "', [bitText] = '" & bitText & "', [bitNotice] = '" & bitNotice & "', [bitReMail] = '" & bitReMail & "', [bitSecret] = '" & bitSecret & "', [intFileCount] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_FILE] WHERE [strBoardID] = [MPLUS_BOARD].[strBoardID] AND [strFileCode] = [MPLUS_BOARD].[strFileCode]), [intImgCount] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_FILE] WHERE [strBoardID] = [MPLUS_BOARD].[strBoardID] AND [strFileCode] = [MPLUS_BOARD].[strFileCode] AND [intFileType] = '0'), [strAddData1] = '" & strAddData1 & "', [strAddData2] = '" & strAddData2 & "', [strAddData3] = '" & strAddData3 & "', [strAddData4] = '" & strAddData4 & "', [strAddData5] = '" & strAddData5 & "', [strAddData6] = '" & strAddData6 & "', [strAddData7] = '" & strAddData7 & "', [strAddData8] = '" & strAddData8 & "', [strAddData9] = '" & strAddData9 & "', [strAddData10] = '" & strAddData10 & "' WHERE [intSeq] = '" & intSeq & "' ")

		IF strScYear <> "" AND strScMonth <> "" AND strScDay <> "" THEN DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [dateRegDate] = '" & strScYear & "-" & strScMonth & "-" & strScDay & " " & strScHour & ":" & strScMinute & ":" & SECOND(NOW) & "' WHERE [intSeq] = '" & intSeq & "' ")

	END SELECT

	IF Action = "WRITE" OR Action = "REPLY" THEN

		IF strLoginID <> "guest" THEN DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [intBoardCount] = [intBoardCount] + 1 WHERE [strLoginID] = '" & strLoginID & "' ")

		DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [intCategoryCount] = [intCategoryCount] + 1 WHERE [strBoardID] = '" & strBoardID & "' AND [intCategory] = '" & intCategory & "' ")
%>
<!-- #include file = "Library/mail.asp" -->
<%
		SET RS = DBCON.EXECUTE("SELECT [strLoginName], [strEmail] FROM [MPLUS_MEMBER_LIST] WHERE [strAdmin] = '2' ")

		DIM setDefaultName, setDefaultEmail

		setDefaultName  = RS("strLoginName")
		setDefaultEmail = RS("strEmail")

		IF prevBoardReply = "1" THEN CALL sendEmail(setDefaultName, setDefaultEmail, prevBoardReplyName, prevBoardReplyMail, "[게시글배달] " & strSubject, strMailContent, "", "", "", "")

		IF bitUseWriteAdminMail = True THEN
			DIM strSendMailList
			IF strAdmin <> "" AND ISNULL(strAdmin) = False THEN
				strAdmin  = SPLIT(strAdmin, "|")
				SQL_Query = ""
				FOR I = 0 TO UBOUND(strAdmin)
					IF strAdmin(I) <> "" THEN SQL_Query = SQL_Query & "'" & strAdmin(I) & "',"
				NEXT
			END IF
			IF SQL_Query <> "" THEN
				IF bitHtml = "1" THEN strContent = GetReplaceTag2Html(strContent)
				IF bitText = "1" THEN strContent = GetReplaceTag2Text(strContent)

				SQL_Query = LEFT(SQL_Query, LEN(SQL_Query) - 1)
				SET RS = DBCON.EXECUTE("SELECT [strLoginName], [strEmail] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] IN (" & SQL_Query & ")")
				WHILE NOT(RS.EOF)
					IF RS("strEmail") <> "" AND ISNULL(RS("strEmail")) = False THEN CALL sendEmail(setDefaultName, setDefaultEmail, RS("strLoginName"), RS("strEmail"), DIM_strBoardMsg(21), strMailContent, "", "", "", "")
				RS.MOVENEXT
				WEND
			END IF

			IF strWriteMailList <> "" AND ISNULL(strWriteMailList) = False THEN
				strWriteMailList = REPLACE(strWriteMailList, CHR(13)&CHR(10), "|")
				strWriteMailList = SPLIT(strWriteMailList, "|")

				FOR I = 0 TO UBOUND(strWriteMailList)
					IF strWriteMailList(I) <> "" THEN CALL sendEmail(setDefaultName, setDefaultEmail, "자동메일", TRIM(strWriteMailList(I)), DIM_strBoardMsg(21), strMailContent, "", "", "", "")
				NEXT

			END IF
		END IF
	END IF

	IF bitCook = "1" THEN
		RESPONSE.COOKIES("MPLUS_WRITE_NAME") = strName
		RESPONSE.COOKIES("MPLUS_WRITE_NAME").EXPIRES = DATE + 30
		RESPONSE.COOKIES("MPLUS_WRITE_MAIL") = strEmail
		RESPONSE.COOKIES("MPLUS_WRITE_MAIL").EXPIRES = DATE + 30
		RESPONSE.COOKIES("MPLUS_WRITE_HOMEPAGE") = strHomepage
		RESPONSE.COOKIES("MPLUS_WRITE_HOMEPAGE").EXPIRES = DATE + 30
	END IF

	SELECT CASE Action
	CASE "WRITE", "REPLY"

		IF bitUsePoint = True THEN
			IF strLoginID <> "guest" THEN
				SET RS = DBCON.EXECUTE("SELECT TOP 1 [intSeq] FROM [MPLUS_BOARD] WHERE [strBoardID] = '" & strBoardID & "' ORDER BY [intSeq] DESC ")
				insertIntSeq = RS("intSeq")
				IF Action = "WRITE" THEN
					IF intWritePoint <> 0 THEN DBCON.EXECUTE("EXEC [MPLUS_PUT_MEMBER_POINT] '1', '" & strBoardiD & "', '" & insertIntSeq & "', '', '" & strLoginID & "', '', '', 'P004', " & intWritePoint & ", '게시글 등록시 지급한 포인트' ")
				ELSE
					IF intReplePoint <> 0 THEN DBCON.EXECUTE("EXEC [MPLUS_PUT_MEMBER_POINT] '1', '" & strBoardiD & "', '" & insertIntSeq & "', '', '" & strLoginID & "', '', '', 'P005', " & intReplePoint & ", '답변글 등록시 지급한 포인트' ")
				END IF

				IF intUploadPoint <> 0 THEN
					IF intUploadPoint > 0 THEN
						SET RS = DBCON.EXECUTE("SELECT COUNT([intNum]) FROM [MPLUS_BOARD_FILE] WHERE [strFileCode] = '" & strFileCode & "' ")
						IF RS(0) > 0 THEN DBCON.EXECUTE("EXEC [MPLUS_PUT_MEMBER_POINT] '1', '" & strBoardiD & "', '" & insertIntSeq & "', '', '" & strLoginID & "', '1', '" & strFileCode & "', 'P006', " & intUploadPoint & ", '첨부파일 업로드 포인트' ")
					END IF
				END IF

				DBCON.EXECUTE("EXEC [MPLUS_MEMBER_POINT_SORT] '" & strLoginID & "' ")

			END IF
		END IF

		DIM strWriteMsg
		strWriteMsg = strSaveFileError & DIM_strBoardMsg(4)
		IF bitCheck = 0 THEN strWriteMsg = strWriteMsg & "\n" & DIM_strBoardMsg(5)

		IF CONF_strViewType = "1" THEN

			RESPONSE.WRITE ExecFormSubmitClose(strWriteMsg, "mboard.asp?Action=list&strBoardID=" & strBoardID & "&intCategory=" & intCategory & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intPage=" & intPage)
			RESPONSE.End()

		ELSE

			SELECT CASE strWriteOkLink
			CASE "0"
				strWriteOKUrl = "mboard.asp?Action=view&strBoardID=" & strBoardID & "&intCategory=" & REQUEST.QueryString("intCategory") & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intPage=" & intPage
			CASE "1"
				strWriteOKUrl = "mboard.asp?Action=list&strBoardID=" & strBoardID & "&intCategory=" & REQUEST.QueryString("intCategory") & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intPage=" & intPage
			CASE "2"
				strWriteOKUrl = "mboard.asp?Action=write&strBoardID=" & strBoardID & "&intCategory=" & REQUEST.QueryString("intCategory") & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intPage=" & intPage
			CASE "3"
				strWriteOKUrl = strWriteCustLink
			END SELECT

			IF strScYear <> "" AND strScMonth <> "" AND strScDay <> "" THEN strWriteOKUrl = strWriteOKUrl & "&strScYear=" & strScYear & "&strScMonth=" & strScMonth & "&strScDay=" & strScDay
	
			IF strWriteOkLink = "0" THEN
				SET RS = DBCON.EXECUTE("SELECT TOP 1 [intSeq] FROM [MPLUS_BOARD] WHERE [strBoardID] = '" & strBoardID & "' ORDER BY [intSeq] DESC ")
				intSeq = RS("intSeq")
				strWriteOKUrl = strWriteOKUrl & "&intSeq=" & intSeq
			END IF

			RESPONSE.WRITE ExecFormSubmit(strWriteMsg, strWriteOKUrl, "")
			RESPONSE.End()

		END IF

	CASE "EDIT"

		IF CONF_strViewType = "1" THEN
			RESPONSE.WRITE ExecFormSubmit(strSaveFileError & DIM_strBoardMsg(22), "mboard.asp?Action=Popview&strBoardID=" & strBoardID & "&intCategory=" & intCategory & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intPage=" & intPage & "&intSeq=" & intSeq, "")
		ELSE
			RESPONSE.WRITE ExecFormSubmit(strSaveFileError & DIM_strBoardMsg(22), "mboard.asp?Action=view&strBoardID=" & strBoardID & "&intCategory=" & intCategory & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intPage=" & intPage & "&intSeq=" & intSeq, "")
		END IF

		RESPONSE.End()

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>