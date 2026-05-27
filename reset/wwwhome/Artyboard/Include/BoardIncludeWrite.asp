<!-- #include file = "BoardInclude.asp" -->
<%
	IF UCASE(Action) = "WRITE" THEN
		IF CONF_bitWriteLevel = False THEN
			IF SESSION("strLoginID") = "" AND CONF_bitWriteLevelLogin = True THEN
				RESPONSE.WRITE "<script language=javascript>" & vbcrlf
				RESPONSE.WRITE "location.href=LINK_LOGIN;" & vbcrlf
				RESPONSE.WRITE "</script>" & vbcrlf
				RESPONSE.End()
			ELSE
				IF CONF_strWriteLevelUrl <> "" AND ISNULL(CONF_strWriteLevelUrl) = False THEN
					CONF_strWriteLevelUrl = CONF_strWriteLevelUrl & "?strPrevUrl=" & Request.ServerVariables("url") & "?" & Replace(Request.ServerVariables("QUERY_STRING"), "&", "--**--" )
					RESPONSE.WRITE ExecFormSubmit(CONF_strWriteLevelMsg, CONF_strWriteLevelUrl, "")
					RESPONSE.End()
				ELSE
					IF INSTR(1, UCASE(Request.ServerVariables("HTTP_REFERER")), "Action=LOGIN_OK") = "0" THEN
						RESPONSE.WRITE ExecJavaAlert(CONF_strListLevelMsg, 0)
						RESPONSE.End()
					ELSE
						RESPONSE.WRITE ExecJavaAlert(CONF_strWriteLevelMsg, 0)
						RESPONSE.End()
					END IF
				END IF
			END IF
		END IF
	END IF

	DIM WRITE_strLoginID, LINK_BOARD_ADD, intSeq
	IF SESSION("strLoginID") = "" THEN WRITE_strLoginID = "guest" ELSE WRITE_strLoginID = SESSION("strLoginID")
	intSeq = GetReplaceInput(REQUEST.QueryString("intSeq"), "S")

	LINK_BOARD_ADD = "BoardWrite.asp?Action=" & Action & "&strBoardID=" & strBoardID & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intPage=" & intPage & "&intSeq=" & intSeq

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_WRITE] '" & strBoardID & "' ")

	DIM CONF_strWriteDefault, CONF_bitUseLink1, CONF_bitUseLink2, CONF_bitUseReple, CONF_strReplePreview, CONF_bitUseSecret
	DIM CONF_bitUseSecretReple, CONF_bitUseRepleMail, CONF_bitUseEditor, CONF_strEditorWidth, CONF_strEditorHeight
	DIM CONF_bitEditorSource, CONF_bitEditorPrev, CONF_strEditorBgColor, CONF_bitEditorZoom, CONF_intEditorZoomSize
	DIM CONF_bitEditorHostName
	DIM CONF_bitWriteAdmin, CONF_bitWriteAdminMsg, CONF_bitUseCaptcha, CONF_bitUseUpload, CONF_intUploadCount
	DIM CONF_bitUseUploadLarge, CONF_bitUploadAdmin, CONF_intUploadSize, CONF_intNowUploadSize, CONF_bitSubjectStyle

	CONF_strWriteDefault   = GetReplaceTag2Text(RS("strWriteDefault"))
	CONF_bitUseLink1       = RS("bitUseLink1")
	CONF_bitUseLink2       = RS("bitUseLink2")
	CONF_bitUseReple       = RS("bitUseReple")
	CONF_strReplePreview   = RS("strReplePreview")
	CONF_bitUseSecret      = RS("bitUseSecret")
	CONF_bitUseSecretReple = RS("bitUseSecretReple")
	CONF_bitUseRepleMail   = RS("bitUseRepleMail")
	CONF_bitUseEditor      = RS("bitUseEditor")
	CONF_strEditorWidth    = RS("strEditorWidth")
	CONF_strEditorHeight   = RS("strEditorHeight")
	CONF_bitEditorSource   = RS("bitEditorSource")
	CONF_bitEditorPrev     = RS("bitEditorPrev")
	CONF_strEditorBgColor  = RS("strEditorBgColor")
	CONF_bitEditorZoom     = RS("bitEditorZoom")
	CONF_intEditorZoomSize = SPLIT(RS("intEditorZoomSize"), "|")
	CONF_bitEditorHostName = RS("bitEditorHostName")
	CONF_bitWriteAdmin     = RS("bitWriteAdmin")
	CONF_bitWriteAdminMsg  = RS("bitWriteAdminMsg")
	CONF_bitUseCaptcha     = RS("bitUseCaptcha")
	CONF_bitUseUpload      = RS("bitUseUpload")
	CONF_intUploadCount    = RS("intUploadCount")
	CONF_bitUseUploadLarge = RS("bitUseUploadLarge")
	CONF_bitUploadAdmin    = RS("bitUploadAdmin")
	CONF_intUploadSize     = RS("intUploadSize")
	CONF_intNowUploadSize  = 0
	CONF_bitSubjectStyle   = ""

	IF SESSION("strLoginID") = "" THEN CONF_bitUseSecretReple = True ELSE CONF_bitUseCaptcha = False
	IF UCASE(Action) = "EDIT" THEN CONF_bitUseCaptcha = False

	DIM WRITE_intCategory, WRITE_strName, WRITE_strPassword, WRITE_strEmail, WRITE_strHomepage, WRITE_strSubject
	DIM WRITE_strSubjectStyle, WRITE_strContent, WRITE_bitHtml, WRITE_bitText, WRITE_bitNotice
	DIM WRITE_bitReMail, WRITE_bitSecret, WRITE_bitCook, WRITE_strLinkTemp1, WRITE_strLinkTemp2, WRITE_strLink1
	DIM WRITE_strLink2, WRITE_strLink1Target, WRITE_strLink2Target, WRITE_strBoardBg, WRITE_strFileCode
	DIM WRITE_intFileCount, WRITE_intImgCount, WRITE_IMG_LIST, WRITE_dateRegDate, WRITE_strAddData1
	DIM WRITE_strAddData2, WRITE_strAddData3, WRITE_strAddData4, WRITE_strAddData5, WRITE_strAddData6
	DIM WRITE_strAddData7, WRITE_strAddData8, WRITE_strAddData9, WRITE_strAddData10, WRITE_strUploadDelete

	IF UCASE(Action) = "REPLY" THEN
		IF CONF_bitUseReple = False THEN
			RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(19), 0)
			RESPONSE.End()
		ELSE
			IF SESSION("strLoginID") = "" AND CONF_bitWriteLevelLogin = True THEN
				RESPONSE.WRITE "<script language=javascript>" & vbcrlf
				RESPONSE.WRITE "location.href=LINK_LOGIN;" & vbcrlf
				RESPONSE.WRITE "</script>" & vbcrlf
				RESPONSE.End()
			ELSE
				IF CONF_bitRepleLevel = False THEN
					IF CONF_strRepleLevelUrl <> "" AND ISNULL(CONF_strRepleLevelUrl) = False THEN
						CONF_strRepleLevelUrl = CONF_strRepleLevelUrl & "?strPrevUrl=" & Request.ServerVariables("url") & "?" & Replace(Request.ServerVariables("QUERY_STRING"), "&", "--**--" )
						RESPONSE.WRITE ExecFormSubmit(CONF_strRepleLevelMsg, CONF_strRepleLevelUrl, "")
						RESPONSE.End()
					ELSE
						IF INSTR(1, UCASE(Request.ServerVariables("HTTP_REFERER")), "Action=LOGIN_OK") = "0" THEN
							RESPONSE.WRITE ExecJavaAlert(CONF_strListLevelMsg, 0)
							RESPONSE.End()
						ELSE
							RESPONSE.WRITE ExecJavaAlert(CONF_strRepleLevelMsg, 0)
							RESPONSE.End()
						END IF
					END IF
				END IF
			END IF
		END IF
	END IF

	IF CONF_bitWriteAdmin = True THEN
		IF CONF_bitBoardAdmin = False THEN
			RESPONSE.WRITE ExecJavaAlert(CONF_bitWriteAdminMsg, 0)
			RESPONSE.End()			
		END IF
	END IF

	IF CONF_bitUseUpload = True THEN
		IF CONF_bitUploadAdmin = True THEN
			IF CONF_bitBoardAdmin = False THEN CONF_bitUseUpload = False
		END IF
	END IF

	IF CONF_bitUploadLevel      = False THEN CONF_bitUseUpload  = False
	IF CONF_bitUploadImageLevel = False THEN CONF_bitUseImgFile = False

	SELECT CASE UCASE(Action)
	CASE "WRITE", "REPLY"

		WRITE_strContent = CONF_strWriteDefault
		IF SESSION("strLoginID") <> "" THEN
			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & SESSION("strLoginID") & "', '" & SESSION("strAdmin") & "' ")
			IF CONF_bitUseNickName = True THEN
				IF RS("strNick") <> "" AND ISNULL(RS("strNick")) = False THEN WRITE_strName = RS("strNick") ELSE WRITE_strName = RS("strLoginName")
			ELSE
				WRITE_strName = RS("strLoginName")
			END IF
			WRITE_strEmail        = RS("strEmail")
			WRITE_strHomepage     = RS("strHomepage")
		ELSE
			WRITE_strName         = REQUEST.COOKIES("MPLUS_WRITE_NAME")
			WRITE_strEmail        = REQUEST.COOKIES("MPLUS_WRITE_MAIL")
			WRITE_strHomepage     = REQUEST.COOKIES("MPLUS_WRITE_HOMEPAGE")
		END IF

		IF CONF_bitBoardAdmin = False THEN
			IF CONF_bitUsePoint = True THEN
				SELECT CASE UCASE(Action)
				CASE "WRITE"
					IF CONF_intWritePoint <> 0 THEN
						IF SESSION("strLoginID") = "" THEN
							RESPONSE.WRITE ExecJavaAlert("로그인 후 이용해 주시기 바랍니다.", 0)
							RESPONSE.End()
						ELSE
							IF CONF_intWritePoint < 0 THEN
								SET RS = DBCON.EXECUTE("EXEC MPLUS_GET_MEMBER_READ '" & SESSION("strLoginID") & "' ")
								IF RS("intPoint") < CONF_intWritePoint THEN
									RESPONSE.WRITE ExecJavaAlert("글쓰기 포인트가 부족합니다.", 0)
									RESPONSE.End()
								END IF
							END IF
						END IF
					END IF
				CASE "REPLY"
					IF CONF_intReplePoint <> 0 THEN
						IF SESSION("strLoginID") = "" THEN
							RESPONSE.WRITE ExecJavaAlert("로그인 후 이용해 주시기 바랍니다.", 0)
							RESPONSE.End()
						ELSE
							IF CONF_intReplePoint < 0 THEN
								SET RS = DBCON.EXECUTE("EXEC MPLUS_GET_MEMBER_READ '" & SESSION("strLoginID") & "' ")
								IF RS("intPoint") < CONF_intReplePoint THEN
									RESPONSE.WRITE ExecJavaAlert("답변글쓰기 포인트가 부족합니다.", 0)
									RESPONSE.End()
								END IF
							END IF
						END IF
					END IF
				END SELECT
			END IF
		END IF

	CASE "EDIT"

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_READ] '" & intSeq & "', '" & strBoardID & "' ")

		WRITE_intCategory         = RS("intCategory")
		WRITE_strLoginID          = RS("strLoginID")
		WRITE_strName             = GetReplaceTag2Text(RS("strName"))
		WRITE_strPassword         = RS("strPassword")
		WRITE_strEmail            = GetReplaceTag2Text(RS("strEmail"))
		WRITE_strHomepage         = GetReplaceTag2Text(RS("strHomepage"))
		WRITE_strSubject          = GetReplaceTag2Text(RS("strSubject"))
		WRITE_strSubjectStyle     = RS("strSubjectStyle")
		WRITE_strContent          = RS("strContent")
		WRITE_bitHtml             = RS("bitHtml")
		WRITE_bitText             = RS("bitText")
		WRITE_bitNotice           = RS("bitNotice")
		WRITE_bitReMail           = RS("bitReMail")
		WRITE_bitSecret           = RS("bitSecret")
		WRITE_strLinkTemp1        = SPLIT(RS("strLink1"), "|")
		WRITE_strLinkTemp2        = SPLIT(RS("strLink2"), "|")
		WRITE_strLink1            = WRITE_strLinkTemp1(0)
		WRITE_strLink2            = WRITE_strLinkTemp2(0)
		WRITE_strLink1Target      = WRITE_strLinkTemp1(1)
		WRITE_strLink2Target      = WRITE_strLinkTemp2(1)
		WRITE_strBoardBg          = RS("strBoardBg")
		WRITE_strFileCode         = RS("strFileCode")
		WRITE_intFileCount        = RS("intFileCount")
		WRITE_intImgCount         = RS("intImgCount")
		WRITE_dateRegDate         = RS("dateRegDate")
		WRITE_strAddData1         = RS("strAddData1")
		WRITE_strAddData2         = RS("strAddData2")
		WRITE_strAddData3         = RS("strAddData3")
		WRITE_strAddData4         = RS("strAddData4")
		WRITE_strAddData5         = RS("strAddData5")
		WRITE_strAddData6         = RS("strAddData6")
		WRITE_strAddData7         = RS("strAddData7")
		WRITE_strAddData8         = RS("strAddData8")
		WRITE_strAddData9         = RS("strAddData9")
		WRITE_strAddData10        = RS("strAddData10")

		IF CONF_bitBoardAdmin = True THEN
			WRITE_strUploadDelete = "2"
		ELSE
			IF WRITE_strLoginID = "guest" THEN
				WRITE_strUploadDelete = "1"
			ELSE
				IF SESSION("strLoginID") = WRITE_strLoginID THEN WRITE_strUploadDelete = "2" ELSE WRITE_strUploadDelete = "0"
			END IF
		END IF

		IF CONF_bitBoardAdmin = False THEN
			IF WRITE_strLoginID = "guest" THEN
				IF GetReplaceInput(REQUEST.FORM("strPassword"), "S") = "" THEN
					RESPONSE.REDIRECT "mboard.asp?Action=password&strBoardID=" & strBoardID & "&intCategory=" & intCategory & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intPage=" & intPage & "&intSeq=" & intSeq & "&strPassMode=edit"
					RESPONSE.End()
				ELSE
					IF WRITE_strPassword <> GetReplaceInput(REQUEST.FORM("strPassword"), "S") THEN
						RESPONSE.wRITE ExecJavaAlert(DIM_strBoardMsg(7), 0)
						RESPONSE.End()
					END IF
				END IF
			END IF
		END IF

		DIM CONF_bitEditLevel

		IF WRITE_bitSecret = True THEN
			IF CONF_bitBoardAdmin = False THEN
				IF SESSION("strLoginID") <> WRITE_strLoginID THEN CONF_bitEditLevel = False
			END IF
		END IF

		IF Action = "EDIT" THEN
			strScYear   = YEAR(WRITE_dateRegDate)
			strScMonth  = MONTH(WRITE_dateRegDate)
			strScDay    = DAY(WRITE_dateRegDate)
			strScHour   = HOUR(WRITE_dateRegDate)
			strScMinute = MINUTE(WRITE_dateRegDate)
		END IF

		IF CONF_bitBoardAdmin = True THEN 
			CONF_bitEditLevel = True
		ELSE
			IF WRITE_strLoginID = "guest" THEN
				CONF_bitEditLevel = True
			ELSE
				IF WRITE_strLoginID = SESSION("strLoginID") THEN CONF_bitEditLevel = True ELSE CONF_bitEditLevel = False
			END IF
		END IF

		IF CONF_bitEditLevel = False THEN
			RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(20), 0)
			RESPONSE.End()
		END IF

		DIM iCount

		REDIM WRITE_REDIM_intImageFileNum(WRITE_intFileCount)
		REDIM WRITE_REDIM_strImageFileName(WRITE_intFileCount)
		REDIM WRITE_REDIM_intFileSize(WRITE_intFileCount)

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_FILE] '" & WRITE_strFileCode & "', '' ")
		iCount = 0
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			WRITE_REDIM_intImageFileNum(iCount)  = RS("intNum")
			WRITE_REDIM_strImageFileName(iCount) = RS("strFileName")
			WRITE_REDIM_intFileSize(iCount)      = RS("intFileSize")
			CONF_intNowUploadSize = CONF_intNowUploadSize + RS("intFileSize")
		RS.MOVENEXT
		WEND
	END SELECT

	IF CONF_intNowUploadSize > 0 THEN CONF_intNowUploadSize = GetFilesize(CONF_intNowUploadSize)

	IF UCASE(Action) = "REPLY" THEN
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_READ] '" & intSeq & "', '" & strBoardID & "' ")

		IF RS("bitSecret") = True THEN
			IF CONF_bitBoardAdmin = False THEN
				IF CONF_bitUseSecretReple = False THEN
				RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(19), 0)
				RESPONSE.End()
				END IF
			ELSE
				WRITE_bitSecret = True
			END IF
		END IF

		IF CONF_strReplePreview <> "" AND ISNULL(CONF_strReplePreview) = False THEN
			CONF_strReplePreview = REPLACE(CONF_strReplePreview, "{{strName}}", RS("strName"))
			CONF_strReplePreview = REPLACE(CONF_strReplePreview, "{{strSubject}}", RS("strSubject"))
			CONF_strReplePreview = REPLACE(CONF_strReplePreview, "{{strContent}}", RS("strContent"))
			CONF_strReplePreview = REPLACE(CONF_strReplePreview, chr(13)&chr(10), "<br>")
			WRITE_strContent = CONF_strReplePreview
		END IF

		WRITE_intCategory = RS("intCategory")

	END IF

	IF CONF_bitUseCategory = True THEN
		SELECT CASE Action
		CASE "WRITE"
			strCategoryForm = GetBoardCategory(strBoardID, intCategory, 0)
		CASE "EDIT"
			strCategoryForm = GetBoardCategory(strBoardID, WRITE_intCategory, 0)
		CASE "REPLY"
			strCategoryForm = GetBoardCategory(strBoardID, WRITE_intCategory, 2)
		END SELECT
	END IF

	IF Action = "EDIT" THEN WRITE_strContent = GetReplaceTag2Editor(WRITE_strContent)
	IF WRITE_strSubjectStyle = "" OR ISNULL(WRITE_strSubjectStyle) = True THEN WRITE_strSubjectStyle = ",,,"

	WRITE_strSubjectStyle = SPLIT(WRITE_strSubjectStyle, ",")

	IF CONF_bitUseUploadLarge = True THEN
		IF setUploadComponet <> "2" THEN CONF_bitUseUploadLarge = False
	END IF

	IF CONF_bitUseUploadLarge = True THEN
		CONF_strUploadLink = "Library/chxupload/chxUpload.asp?strBoardID=" & strBoardID & "&strSessionID=" & SESSION.SESSIONID & "&intUploadSize=" & CONF_intUploadSize & "&intUploadCount=" & CONF_intUploadCount
	ELSE
		CONF_strUploadLink = "Library/defaultUpload.asp?strBoardID=" & strBoardID & "&strSessionID=" & SESSION.SESSIONID & "&intUploadSize=" & CONF_intUploadSize & "&intUploadCount=" & CONF_intUploadCount
	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>
<script language="javascript">
	var WRITE_MODE            = "<%=UCASE(Action)%>";
	var WRITE_USE_EDITOR      = "<%=CONF_bitUseEditor%>";
	var CATEGORY_WRITE_METHOD = "<%=CONF_bitUseCategory%>";
	var WRITE_BOARD_ID        = "<%=strBoardID%>";
	var WRITE_BOARD_BG        = "";
	var WRITE_BOARD_ADMIN     = "<%=CONF_bitBoardAdmin%>";
	var WRITE_USE_CAPTCHA     = "<%=CONF_bitUseCaptcha%>";
	var WRITE_USE_UPLOAD      = "<%=CONF_bitUseUpload%>";
	var WRITE_USE_UPLOAD_FLEX = "<%=CONF_bitUseUploadLarge%>";

	var appName		      = navigator.appName;
	var appVersion	    = parseFloat(navigator.appVersion.split("MSIE")[1]);
	var bitUseEditor

	if(WRITE_USE_EDITOR == "True"){
		if(appName != "Microsoft Internet Explorer" || appVersion < 5.5){
			WRITE_USE_EDITOR = false;
		}else{
			WRITE_USE_EDITOR = true;
		}
	}else{
		WRITE_USE_EDITOR = false;
	}

	function list_move(){
		document.location.href = LINK_LIST_QUERY;
	}
</script>
<input type="hidden" name="strEditorBackground">
<script language="javascript">
	var SET_Editor_FilePath = "Pds/Board/<%=strBoardID%>/Editor/";
</script>
<script type="text/javascript" language="javascript" src="Editor/cheditor.js"></script>
<script language="javascript">

	var myeditor = new cheditor("myeditor");

	myeditor.config.editorWidth = '<%=CONF_strEditorWidth%>';
	myeditor.config.editorHeight = '<%=CONF_strEditorHeight%>';
	myeditor.config.toolBarSplit = true;
	myeditor.config.ieEnterMode = 'br';
	myeditor.config.useBodyAttribute = true;

<%
	IF CONF_bitEditorHostName = True THEN
		RESPONSE.WRITE "	myeditor.config.includeHostname = true;" & vbcrlf
	ELSE
		RESPONSE.WRITE "	myeditor.config.includeHostname = false;" & vbcrlf
	END IF

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
	myeditor.inputForm = 'strContent';

</script>
<div id='mb_waiting' style='position:absolute; left:50px; top:120px; width:292; height: 91; z-index:1; visibility: hidden'>
<table border=0 width=310 cellspacing=1 cellpadding=0 bgcolor=black align="center">
<tr bgcolor=white>
	<td>
	<table border=0 cellspacing=0 cellpadding=0 width=100%>
	<tr>
		<td align="center"><img src="Library/images/loadingBar.gif" width="320" height="100"></td>
		</tr>
	</table>
	</td>
</tr>
</table>
</div>
<form name="tmp_upload_form" method="post">
<input type="hidden" name="upload_strLoginID" value="<%=SESSION("strLoginID")%>">
<input type="hidden" name="upload_strPwd">
</form>
<iframe name="tmp_upload_iframe" width="0" height="0" style="display:none"></iframe>