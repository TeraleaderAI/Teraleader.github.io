<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM strBoardID
	strBoardID = REQUEST.QueryString("strBoardID")

	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_BAD] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_CATEGORY] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_COMMENT] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_CONFIG_DEFAULT] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_CONFIG_LIST] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_CONFIG_READ] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_CONFIG_WRITE] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_DOWN_CHECK] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_GROUP_BOARD] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_NOTICE_LIST] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_FILE] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_POINT] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_READ_CHECK] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_STAT] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_VOTE] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_GROUP_BOARD] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_POINT] WHERE [strBoardID] = '" & strBoardID & "' ")
	DBCON.EXECUTE("DELETE FROM [MPLUS_SCRAP_LIST] WHERE [strBoardID] = '" & strBoardID & "' ")

	CALL ExecFolderDelete(rootPath & "Pds\Board\" & strBoardID & "\Editor")
	CALL ExecFolderDelete(rootPath & "Pds\Board\" & strBoardID & "\Small")
	CALL ExecFolderDelete(rootPath & "Pds\Board\" & strBoardID & "\Thrum")
	CALL ExecFolderDelete(rootPath & "Pds\Board\" & strBoardID & "\Temp")
	CALL ExecFolderDelete(rootPath & "Pds\Board\" & strBoardID & "\WaterMark")
	CALL ExecFolderDelete(rootPath & "Pds\Board\" & strBoardID)

	RESPONSE.WRITE ExecFormSubmit("게시판 삭제가 완료되었습니다.", "BoardList.asp", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>