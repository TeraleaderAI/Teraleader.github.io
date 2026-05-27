<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 1
	isAdminPopup    = False
	strAdminPrevUrl = "Board/BoardList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM strBoardID, bitImgView, strNameClick, intImgWidth, intImgHeight, intImgScare, bitImgViewAll, bitImgLightbox, bitFileExe
	DIM intExeWidth, intExeHeight, bitAutoLink, bitWordBreak, bitReadInsert, bitVoteInsert, strBadErrMsg, bitContentIp
	DIM bitCommentIp, strDateTypeView, strDateTypeComment, bitPrevNext, bitListReple, bitListBoard, bitCommentEdit
	DIM bitCommentReply, bitUseEditor, strEditorWidth, strEditorHeight, strEditorWidthReply, strEditorHeightReply
	DIM bitEditorSource, bitEditorPrev, strEditorBgColor, bitEditorZoom, intEditorZoomSize, bitViewSign

	WITH REQUEST

		strBoardID           = GetReplaceInput(.FORM("strBoardID"), "")
		strNameClick         = GetReplaceInput(.FORM("strNameClick"), "")
		bitImgView           = .FORM("bitImgView")
		intImgWidth          = .FORM("intImgWidth")
		intImgHeight         = .FORM("intImgHeight")
		intImgScare          = .FORM("intImgScare")
		bitImgLightbox       = .FORM("bitImgLightbox")
		bitImgViewAll        = .FORM("bitImgViewAll")
		bitFileExe           = .FORM("bitFileExe")
		intExeWidth          = .FORM("intExeWidth")
		intExeHeight         = .FORM("intExeHeight")
		bitAutoLink          = .FORM("bitAutoLink")
		bitWordBreak         = .FORM("bitWordBreak")
		bitReadInsert        = .FORM("bitReadInsert")
		bitVoteInsert        = .FORM("bitVoteInsert")
		strBadErrMsg         = GetReplaceInput(.FORM("strBadErrMsg"), "")
		bitContentIp         = .FORM("bitContentIp")
		bitCommentIp         = .FORM("bitCommentIp")
		strDateTypeView      = GetReplaceInput(.FORM("strDateTypeView"), "")
		strDateTypeComment   = GetReplaceInput(.FORM("strDateTypeComment"), "")
		bitPrevNext          = .FORM("bitPrevNext")
		bitListReple         = .FORM("bitListReple")
		bitListBoard         = .FORM("bitListBoard")
		bitCommentEdit       = .FORM("bitCommentEdit")
		bitCommentReply      = .FORM("bitCommentReply")
		bitUseEditor         = .FORM("bitUseEditor")
		strEditorWidth       = GetReplaceInput(.FORM("strEditorWidth"), "")
		strEditorHeight      = GetReplaceInput(.FORM("strEditorHeight"), "")
		strEditorWidthReply  = GetReplaceInput(.FORM("strEditorWidthReply"), "")
		strEditorHeightReply = GetReplaceInput(.FORM("strEditorHeightReply"), "")
		bitEditorSource      = .FORM("bitEditorSource")
		bitEditorPrev        = .FORM("bitEditorPrev")
		strEditorBgColor     = GetReplaceInput(.FORM("strEditorBgColor"), "")
		bitEditorZoom        = .FORM("bitEditorZoom")
		intEditorZoomSize    = .FORM("intEditorZoomSize1") & "|" & .FORM("intEditorZoomSize2")
		bitViewSign          = .FORM("bitViewSign")

	END WITH

	IF bitImgView = "" THEN bitImgView = "0"
	IF intImgScare = "" THEN intImgScare = "0"

	DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CONFIG_READ] SET [strNameClick] = '" & strNameClick & "', [bitImgView] = '" & bitImgView & "', [intImgWidth] = '" & intImgWidth & "', [intImgHeight] = '" & intImgHeight & "', [intImgScare] = '" & intImgScare & "', [bitImgLightbox] = '" & bitImgLightbox & "', [bitImgViewAll] = '" & bitImgViewAll & "', [bitFileExe] = '" & bitFileExe & "', [intExeWidth] = '" & intExeWidth & "', [intExeHeight] = '" & intExeHeight & "', [bitAutoLink] = '" & bitAutoLink & "', [bitWordBreak] = '" & bitWordBreak & "', [bitReadInsert] = '" & bitReadInsert & "', [bitVoteInsert] = '" & bitVoteInsert & "', [strBadErrMsg] = '" & strBadErrMsg & "', [bitContentIp] = '" & bitContentIp & "', [bitCommentIp] = '" & bitCommentIp & "', [strDateTypeView] = '" & strDateTypeView & "', [strDateTypeComment] = '" & strDateTypeComment & "', [bitPrevNext] = '" & bitPrevNext & "', [bitListReple] = '" & bitListReple & "', [bitListBoard] = '" & bitListBoard & "', [bitCommentEdit] = '" & bitCommentEdit & "', [bitCommentReply] = '" & bitCommentReply & "', [bitUseEditor] = '" & bitUseEditor & "', [strEditorWidth] = '" & strEditorWidth & "', [strEditorHeight] = '" & strEditorHeight & "', [strEditorWidthReply] = '" & strEditorWidthReply & "', [strEditorHeightReply] = '" & strEditorHeightReply & "', [bitEditorSource] = '" & bitEditorSource & "', [bitEditorPrev] = '" & bitEditorPrev & "', [strEditorBgColor] = '" & strEditorBgColor & "', [bitEditorZoom] = '" & bitEditorZoom & "', [intEditorZoomSize] = '" & intEditorZoomSize & "', [bitViewSign] = '" & bitViewSign & "' WHERE [strBoardID] = '" & strBoardID & "' ")

	RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "BoardReadConfig.asp?strBoardID=" & strBoardID, "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>