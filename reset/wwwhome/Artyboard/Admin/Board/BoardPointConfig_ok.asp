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
	DIM strBoardID
	DIM strListLevel, strListLevelUrl, strReadLevel, strReadLevelUrl, strWriteLevel, strWriteLevelUrl, strRepleLevel, strRepleLevelUrl
	DIM strWriteCommentLevel, strReplyCommentLevel, strReadCommentLevel, strUploadLevel, strSubjectStyleLevel, strDownLevel
	DIM bitUsePoint, intReadPoint, intDownPoint, intVotePoint, intWritePoint, intReplePoint, intUploadPoint, bitUploadCount
	DIM intUploadPointImage, bitUploadImgCount, intCommentPoint
	
	WITH REQUEST

		strBoardID = .FORM("strBoardID")

		strListLevel         = GetCheckBoxRequest(.FORM("strListLevel2"))         & "|" & .FORM("strListLevel1")         & "|" & GetReplaceInput(.FORM("strListLevel3"), "")
		strReadLevel         = GetCheckBoxRequest(.FORM("strReadLevel2"))         & "|" & .FORM("strReadLevel1")         & "|" & GetReplaceInput(.FORM("strReadLevel3"), "")
		strWriteLevel        = GetCheckBoxRequest(.FORM("strWriteLevel2"))        & "|" & .FORM("strWriteLevel1")        & "|" & GetReplaceInput(.FORM("strWriteLevel3"), "")
		strRepleLevel        = GetCheckBoxRequest(.FORM("strRepleLevel2"))        & "|" & .FORM("strRepleLevel1")        & "|" & GetReplaceInput(.FORM("strRepleLevel3"), "")
		strWriteCommentLevel = GetCheckBoxRequest(.FORM("strWriteCommentLevel2")) & "|" & .FORM("strWriteCommentLevel1") & "|" & GetReplaceInput(.FORM("strWriteCommentLevel3"), "")
		strReplyCommentLevel = GetCheckBoxRequest(.FORM("strReplyCommentLevel2")) & "|" & .FORM("strReplyCommentLevel1") & "|" & GetReplaceInput(.FORM("strReplyCommentLevel3"), "")
		strReadCommentLevel  = GetCheckBoxRequest(.FORM("strReadCommentLevel2"))  & "|" & .FORM("strReadCommentLevel1")
		strUploadLevel       = GetCheckBoxRequest(.FORM("strUploadLevel2"))       & "|" & .FORM("strUploadLevel1")
		strSubjectStyleLevel = GetCheckBoxRequest(.FORM("strSubjectStyleLevel2"))  & "|" & .FORM("strSubjectStyleLevel1")
		strDownLevel         = GetCheckBoxRequest(.FORM("strDownLevel2"))         & "|" & .FORM("strDownLevel1")

		strListLevelUrl  = GetReplaceInput(.FORM("strListLevelUrl"), "")
		strReadLevelUrl  = GetReplaceInput(.FORM("strReadLevelUrl"), "")
		strWriteLevelUrl = GetReplaceInput(.FORM("strWriteLevelUrl"), "")
		strRepleLevelUrl = GetReplaceInput(.FORM("strRepleLevelUrl"), "")		

		bitUsePoint         = GetCheckBoxRequest(.FORM("bitUsePoint"))
		intReadPoint        = .FORM("intReadPoint")        : IF intReadPoint        = "" THEN intReadPoint        = 0
		intDownPoint        = .FORM("intDownPoint")        : IF intDownPoint        = "" THEN intDownPoint        = 0
		intVotePoint        = .FORM("intVotePoint")        : IF intVotePoint        = "" THEN intVotePoint        = 0
		intWritePoint       = .FORM("intWritePoint")       : IF intWritePoint       = "" THEN intWritePoint       = 0
		intReplePoint       = .FORM("intReplePoint")       : IF intReplePoint       = "" THEN intReplePoint       = 0
		intUploadPoint      = .FORM("intUploadPoint")      : IF intUploadPoint      = "" THEN intUploadPoint      = 0
		intCommentPoint     = .FORM("intCommentPoint")     : IF intCommentPoint     = "" THEN intCommentPoint     = 0

		bitListLevelLogin   = .FORM("bitListLevelLogin")
		bitReadLevelLogin   = .FORM("bitReadLevelLogin")
		bitWriteLevelLogin  = .FORM("bitWriteLevelLogin")
		bitRepleLevelLogin  = .FORM("bitRepleLevelLogin")

	END WITH

	IF bitListLevelLogin  = "" THEN bitListLevelLogin  = "0"
	IF bitReadLevelLogin  = "" THEN bitReadLevelLogin  = "0"
	IF bitWriteLevelLogin = "" THEN bitWriteLevelLogin = "0"
	IF bitRepleLevelLogin = "" THEN bitRepleLevelLogin = "0"

	DBCON.EXECUTE("UPDATE [MPLUS_GROUP_BOARD] SET [strListLevel] = '" & strListLevel & "', [strListLevelUrl] = '" & strListLevelUrl & "', [bitListLevelLogin] = '" & bitListLevelLogin & "', [strReadLevel] = '" & strReadLevel & "', [strReadLevelUrl] = '" & strReadLevelUrl & "', [bitReadLevelLogin] = '" & bitReadLevelLogin & "', [strWriteLevel] = '" & strWriteLevel & "', [strWriteLevelUrl] = '" & strWriteLevelUrl & "', [bitWriteLevelLogin] = '" & bitWriteLevelLogin & "', [strRepleLevel] = '" & strRepleLevel & "', [strRepleLevelUrl] = '" & strRepleLevelUrl & "', [bitRepleLevelLogin] = '" & bitRepleLevelLogin & "', [strWriteCommentLevel] = '" & strWriteCommentLevel & "', [strReplyCommentLevel] = '" & strReplyCommentLevel & "', [strReadCommentLevel] = '" & strReadCommentLevel & "', [strUploadLevel] = '" & strUploadLevel & "', [strSubjectStyleLevel] = '" & strSubjectStyleLevel & "', [strDownLevel] = '" & strDownLevel & "' WHERE [strBoardID] = '" & strBoardID & "' ")

	DBCON.EXECUTE("UPDATE [MPLUS_BOARD_POINT] SET [bitUsePoint] = '" & bitUsePoint & "', [intReadPoint] = " & intReadPoint & ", [intDownPoint] = " & intDownPoint & ", [intVotePoint] = " & intVotePoint & ", [intWritePoint] = " & intWritePoint & ", [intReplePoint] = " & intReplePoint & ", [intUploadPoint] = " & intUploadPoint & ", [intCommentPoint] = " & intCommentPoint & " WHERE [strBoardID] = '" & strBoardID & "' ")

	RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "BoardPointConfig.asp?strBoardID=" & strBoardID, "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>