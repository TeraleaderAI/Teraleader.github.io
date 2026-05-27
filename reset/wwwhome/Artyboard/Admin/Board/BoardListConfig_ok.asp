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
	DIM strBoardID, intRowCount, intLineCount, intListImgWidth, intListImgHeight, intLineHeight, bitMouseOver, strMouseOverColor
	DIM bitPreview, intPreviewCut, intPreviewWidth, intCutSubject, intCutContent, intCutName, strNameClick, strViewType
	DIM intPopViewWidth, intPopViewHeight, strDateType, strColorNoticeBg, strColorNoticeFont, strColorRepleBg, strColorRepleFont
	DIM strColorListOddBg, strColorListEvenBg, bitColorListBgGrd, strColorListOddFont, strColorListEvenFont, bitColorListFontGrd
	DIM strColorListReadBg, strColorListReadFont, strIconFolder, strIconNotice, strIconNew, strIconReple, strIconLine, strIconSecret
	DIM strIconRead, bitUseSelectView, intNewIconTime, strBadSubject, strLinkHomepage, strLinkHomepageTarget, intPageCount
	DIM strPagePrevGroup, strPageNextGroup, strPageFirstPage, strPageEndPage, strPageNow, strPageDefault, bitUseSearch
	DIM intSearchCount, strSeaechTag

	WITH REQUEST

	strBoardID            = GetReplaceInput(.FORM("strBoardID"),"")
	intRowCount           = .FORM("intRowCount")
	intLineCount          = .FORM("intLineCount")
	intListImgWidth       = .FORM("intListImgWidth")
	intListImgHeight      = .FORM("intListImgHeight")
	intLineHeight         = .FORM("intLineHeight")
	bitMouseOver          = .FORM("bitMouseOver")
	strMouseOverColor     = GetReplaceInput(.FORM("strMouseOverColor"),"")
	bitPreview            = .FORM("bitPreview")
	intPreviewCut         = .FORM("intPreviewCut")
	intPreviewWidth       = .FORM("intPreviewWidth")
	intCutSubject         = .FORM("intCutSubject")
	intCutContent         = .FORM("intCutContent")
	intCutName            = .FORM("intCutName")
	strNameClick          = GetReplaceInput(.FORM("strNameClick"),"")
	strViewType           = GetReplaceInput(.FORM("strViewType"),"")
	intPopViewWidth       = .FORM("intPopViewWidth")
	intPopViewHeight      = .FORM("intPopViewHeight")
	strDateType           = .FORM("strDateType")
	strColorNoticeBg      = GetReplaceInput(.FORM("strColorNoticeBg"),"")
	strColorNoticeFont    = GetReplaceInput(.FORM("strColorNoticeFont"),"")
	strColorRepleBg       = GetReplaceInput(.FORM("strColorRepleBg"),"")
	strColorRepleFont     = GetReplaceInput(.FORM("strColorRepleFont"),"")
	strColorListOddBg     = GetReplaceInput(.FORM("strColorListOddBg"),"")
	strColorListEvenBg    = GetReplaceInput(.FORM("strColorListEvenBg"),"")
	bitColorListBgGrd     = GetReplaceInput(.FORM("bitColorListBgGrd"),"")
	strColorListOddFont   = GetReplaceInput(.FORM("strColorListOddFont"),"")
	strColorListEvenFont  = GetReplaceInput(.FORM("strColorListEvenFont"),"")
	bitColorListFontGrd   = GetReplaceInput(.FORM("bitColorListFontGrd"),"")
	strColorListReadBg    = GetReplaceInput(.FORM("strColorListReadBg"),"")
	strColorListReadFont  = GetReplaceInput(.FORM("strColorListReadFont"),"")
	strIconFolder         = GetReplaceInput(.FORM("strIconFolder"),"")
	strIconNotice         = GetReplaceInput(.FORM("strIconNotice"),"")
	strIconNew            = GetReplaceInput(.FORM("strIconNew"),"")
	strIconReple          = GetReplaceInput(.FORM("strIconReple"),"")
	strIconLine           = GetReplaceInput(.FORM("strIconLine"),"")
	strIconSecret         = GetReplaceInput(.FORM("strIconSecret"),"")
	strIconRead           = GetReplaceInput(.FORM("strIconRead"),"")
	strIconNewCmt         = GetReplaceInput(.FORM("strIconNewCmt"),"")
	intNewIconTime        = .FORM("intNewIconTime")
	bitUseSelectView      = .FORM("bitUseSelectView")
	strBadSubject         = GetReplaceInput(.FORM("strBadSubject"), "")
	strLinkHomepage       = GetReplaceInput(.FORM("strLinkHomepage"), "")
	strLinkHomepageTarget = GetReplaceInput(.FORM("strLinkHomepageTarget"),"")
	intPageCount          = .FORM("intPageCount")
	strPagePrevGroup      = GetReplaceInput(.FORM("strPagePrevGroup"), "")
	strPageNextGroup      = GetReplaceInput(.FORM("strPageNextGroup"), "")
	strPageFirstPage      = GetReplaceInput(.FORM("strPageFirstPage"), "")
	strPageEndPage        = GetReplaceInput(.FORM("strPageEndPage"), "")
	strPageNow            = GetReplaceInput(.FORM("strPageNow"), "")
	strPageDefault        = GetReplaceInput(.FORM("strPageDefault"), "")
	bitUseSearch          = .FORM("bitUseSearch")
	intSearchCount        = .FORM("intSearchCount")
	strSeaechTag          = GetReplaceInput(.FORM("strSeaechTag"), "")

	IF intListImgWidth    = "" THEN intListImgWidth  = 80
	IF intListImgHeight   = "" THEN intListImgHeight = 80

	END WITH

	DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CONFIG_LIST] SET [intRowCount] = '" & intRowCount & "', [intLineCount] = '" & intLineCount & "', [intListImgWidth] = '" & intListImgWidth & "', [intListImgHeight] = '" & intListImgHeight & "', [intLineHeight] = '" & intLineHeight & "', [bitMouseOver] = '" & bitMouseOver & "', [strMouseOverColor] = '" & strMouseOverColor & "', [bitPreview] = '" & bitPreview & "', [intPreviewCut] = '" & intPreviewCut & "', [intPreviewWidth] = '" & intPreviewWidth & "', [intCutSubject] = '" & intCutSubject & "', [intCutContent] = '" & intCutContent & "', [intCutName] = '" & intCutName & "', [strNameClick] = '" & strNameClick & "', [strViewType] = '" & strViewType & "', [intPopViewWidth] = '" & intPopViewWidth & "', [intPopViewHeight] = '" & intPopViewHeight & "', [strDateType] = '" & strDateType & "', [strColorNoticeBg] = '" & strColorNoticeBg & "', [strColorNoticeFont] = '" & strColorNoticeFont & "', [strColorRepleBg] = '" & strColorRepleBg & "', [strColorRepleFont] = '" & strColorRepleFont & "', [strColorListOddBg] = '" & strColorListOddBg & "', [strColorListEvenBg] = '" & strColorListEvenBg & "', [bitColorListBgGrd] = '" & bitColorListBgGrd & "', [strColorListOddFont] = '" & strColorListOddFont & "', [strColorListEvenFont] = '" & strColorListEvenFont & "', [bitColorListFontGrd] = '" & bitColorListFontGrd & "', [strColorListReadBg] = '" & strColorListReadBg & "', [strColorListReadFont] = '" & strColorListReadFont & "', [strIconFolder] = '" & strIconFolder & "', [strIconNotice] = '" & strIconNotice & "', [strIconNew] = '" & strIconNew & "', [strIconReple] = '" & strIconReple & "', [strIconLine] = '" & strIconLine & "', [strIconSecret] = '" & strIconSecret & "', [strIconRead] = '" & strIconRead & "', [strIconNewCmt] = '" & strIconNewCmt & "', [bitUseSelectView] = '" & bitUseSelectView & "', [intNewIconTime] = '" & intNewIconTime & "', [strBadSubject] = '" & strBadSubject & "', [strLinkHomepage] = '" & strLinkHomepage & "', [strLinkHomepageTarget] = '" & strLinkHomepageTarget & "', [intPageCount] = '" & intPageCount & "', [strPagePrevGroup] = '" & strPagePrevGroup & "', [strPageNextGroup] = '" & strPageNextGroup & "', [strPageFirstPage] = '" & strPageFirstPage & "', [strPageEndPage] = '" & strPageEndPage & "', [strPageNow] = '" & strPageNow & "', [strPageDefault] = '" & strPageDefault & "', [bitUseSearch] = '" & bitUseSearch & "', [intSearchCount] = '" & intSearchCount & "', [strSeaechTag] = '" & strSeaechTag & "' WHERE [strBoardID] = '" & strBoardID & "' ")

	RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "BoardListConfig.asp?strBoardID=" & strBoardID, "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>