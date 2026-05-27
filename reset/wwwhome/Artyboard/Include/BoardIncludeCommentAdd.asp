<!-- #include file = "BoardInclude.asp" -->
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_READ] '" & strBoardID & "' ")

	DIM CONF_strNameClick, CONF_bitCommentIp, CONF_bitCommentEdit, CONF_bitCommentReply, CONF_bitUseEditor, CONF_strEditorWidth
	DIM CONF_strEditorHeight, CONF_bitEditorSource, CONF_bitEditorPrev, CONF_strEditorBgColor, CONF_bitEditorZoom
	DIM CONF_intEditorZoomSize, LINK_COMMENT_OK, LINK_COMMENT_BACK

	DIM isCommentAdd, intSeq, intCmtSeq

	isCommentAdd = False
	intSeq       = GetReplaceInput(REQUEST.QueryString("intSeq"), "S")
	intCmtSeq    = GetReplaceInput(REQUEST.QueryString("intCmtSeq"), "S")

	CONF_strNameClick       = RS("strNameClick")
	CONF_bitCommentIp       = RS("bitCommentIp")
	CONF_bitCommentEdit     = RS("bitCommentEdit")
	CONF_bitCommentReply    = RS("bitCommentReply")
	CONF_bitUseEditor       = RS("bitUseEditor")
	CONF_strEditorWidth     = RS("strEditorWidthReply")
	CONF_strEditorHeight    = RS("strEditorHeightReply")
	CONF_bitEditorSource    = RS("bitEditorSource")
	CONF_bitEditorPrev      = RS("bitEditorPrev")
	CONF_strEditorBgColor   = RS("strEditorBgColor")
	CONF_bitEditorZoom      = RS("bitEditorZoom")
	CONF_intEditorZoomSize  = SPLIT(RS("intEditorZoomSize"), "|")

	DIM CMT_intCmtThread, CMT_intDepth, CMT_bitHtml, CMT_intScore, CMT_intIcon, CMT_strLoginID, CMT_strName, CMT_strReplyName
	DIM CMT_strPassword, CMT_strContent, CMT_strMarkName, CMT_strNameImage, CMT_strPhotoImage, CMT_strIpAddr
	DIM CMT_dateRegDate
	DIM EDIT_intScore, EDIT_intIcon, EDIT_strLoginID, EDIT_strName, EDIT_strContent

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_COMMENT] '" & strBoardID & "', '', '" & intCmtSeq & "' ")

	CMT_intCmtThread  = RS("intCmtThread")
	CMT_intDepth      = RS("intDepth")
	CMT_bitHtml       = RS("bitHtml")
	CMT_intScore      = RS("intScore")
	CMT_intIcon       = RS("intIcon")
	IF SESSION("strLoginID") = "" THEN CMT_strLoginID = "guest" ELSE CMT_strLoginID = SESSION("strLoginID")
	CMT_strReplyName  = RS("strName")
	CMT_strName       = RS("strName")
	CMT_strPassword   = RS("strPassword")
	IF CMT_bitHtml = True THEN CMT_strContent = GetReplaceTag2Html(RS("strContent")) ELSE CMT_strContent = GetReplaceTag2Text(RS("strContent"))
	CMT_strMarkName   = RS("strMarkImage")
	CMT_strNameImage  = RS("strNameImage")
	CMT_strPhotoImage = RS("strPhotoImage")

	IF RS("strIpAddr") <> "" AND ISNULL(RS("strIpAddr")) = False THEN
		CMT_strIpAddr = REPLACE(RS("strIpAddr"), MID(RS("strIpAddr"), InStrRev(RS("strIpAddr"), ".")), ".*")
	ELSE
		CMT_strIpAddr = "none"
	END IF

	CMT_dateRegDate   = RS("dateRegDate")

	IF UCASE(Action) = "CMTEDIT" THEN

		EDIT_intScore     = RS("intScore")
		EDIT_intIcon      = RS("intIcon")
		EDIT_strLoginID   = RS("strLoginID")
		EDIT_strName      = RS("strName")
		EDIT_strContent   = RS("strContent")

	END IF

	IF CONF_bitUseMarkAvata = True THEN
		IF CMT_strMarkName = "" OR ISNULL(CMT_strMarkName) = True THEN CMT_strMarkName = False ELSE CMT_strMarkName = "<img src='Pds/Member/GroupIcon/" & CMT_strMarkName & "' align='absmiddle'>"
	ELSE
		CMT_strMarkName = False
	END IF

	IF CONF_bitUseNameAvata = True THEN
		IF CMT_strNameImage = "" OR ISNULL(CMT_strNameImage) = True THEN CMT_strNameImage = False ELSE CMT_strNameImage = "<img src='Pds/Member/Name/" & CMT_strNameImage & "' align='absmiddle'>"
		ELSE
			CMT_strNameImage = False
	END IF

	IF CMT_strPhotoImage = "" OR ISNULL(CMT_strPhotoImage) = True THEN CMT_strPhotoImage = False ELSE CMT_strPhotoImage = "<img src='Pds/Member/Photo/" & CMT_strPhotoImage & "' align='absmiddle'>"

	IF UCASE(Action) = "CMTEDIT" THEN
		IF CONF_bitCommentEdit = False THEN
			isCommentAdd = False
		ELSE
			IF CONF_bitCommentWriteLevel = True THEN isCommentAdd = True ELSE isCommentAdd = False
	
			IF CONF_bitBoardAdmin = True THEN
				isCommentAdd = True
			ELSE
				IF CMT_strLoginID = "guest" THEN
					isCommentAdd = True
				ELSE
					IF SESSION("strLoginID") = CMT_strLoginID THEN isCommentAdd = True ELSE isCommentAdd = False
				END IF
			END IF
		END IF

		IF isCommentAdd = False THEN

			RESPONSE.WRITE ExecJavaAlert(CONF_strWriteCommentMsg, 0)
			RESPONSE.End()

		END IF

	END IF

	IF UCASE(Action) = "CMTREPLY" THEN

		CMT_strName = SESSION("strLoginName")

		IF CONF_bitCommentReply = False THEN
			isCommentAdd = False
		ELSE
			IF CONF_bitCommentReplyLevel = True THEN isCommentAdd = True ELSE isCommentAdd = False
			IF CONF_bitBoardAdmin = True THEN isCommentAdd = True
		END IF

		IF isCommentAdd = False THEN

			RESPONSE.WRITE ExecJavaAlert(CONF_strReplyCommentMsg, 0)
			RESPONSE.End()

		END IF

	END IF

	SELECT CASE UCASE(Action)
	CASE "CMTEDIT"  : LINK_COMMENT_OK = "javascript:OnSubmitComment('" & SESSION("strLoginID") & "','E');"
	CASE "CMTREPLY" : LINK_COMMENT_OK = "javascript:OnSubmitComment('" & SESSION("strLoginID") & "','R');"
	END SELECT

	LINK_COMMENT_BACK = "mboard.asp?Action=view&strBoardID=" & strBoardID & "&intPage=" & intPage & "&intCategory=" & intCategory & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intSeq=" & intSeq & "&strScYear=" & strScYear & "&strScMonth=" & strScMonth & "&strScDay=" & strScDay

	SET RS = NOTHING : DBCON.CLOSE
%>
<form name="theCmtForm" method="post" style="margin:0px;">
<input type="hidden" name="comment_intThread" value="<%=CMT_intCmtThread%>">
<input type="hidden" name="comment_intDepth" value="<%=CMT_intDepth%>">
<input type="hidden" name="comment_id" value="<%=CMT_strLoginID%>">
<input type="hidden" name="comment_html" value="<%=GetTrueFalse(CMT_bitHtml)%>">
<input type="hidden" name="comment_name" value="<%=CMT_strName%>">
<input type="hidden" name="comment_pwd" value="">
<input type="hidden" name="comment_content" value="">
<input type="hidden" name="comment_intScore" value="">
<input type="hidden" name="comment_intIcon" value="">
<input type="hidden" name="strBoardBg">
</form>
<script language="javascript">
	var SET_Editor_FilePath = "Pds/Board/<%=strBoardID%>/Editor/";
</script>
<script type="text/javascript" language="javascript" src="Editor/cheditor.js"></script>
<script language="javascript">

	var SET_intCmtSeq = "<%=intCmtSeq%>";

	var myeditor = new cheditor("myeditor");
	var SET_bitUseEditor = "<%=CONF_bitUseEditor%>";

	myeditor.config.editorWidth = '<%=CONF_strEditorWidth%>';
	myeditor.config.editorHeight = '<%=CONF_strEditorHeight%>';
	myeditor.config.ieEnterMode = 'br';
<%
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
	myeditor.inputForm = 'cmtContent';

</script>