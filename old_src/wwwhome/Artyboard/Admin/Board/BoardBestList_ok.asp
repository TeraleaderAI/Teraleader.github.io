<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Board/BoardBestList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM Action, strMsg, strSelectGroup, intPage, intPageSize, I
	
	Action         = REQUEST.QueryString("Action")
	strSelectGroup = REQUEST.FORM("strSelectGroup")
	intPage        = REQUEST.FORM("intPage")
	intPageSize    = REQUEST.FORM("intPageSize")

	DIM intNum, strFileName

	SELECT CASE UCASE(Action)
	CASE "SELECTREMOVE"
		FOR I = 1 TO REQUEST.FORM("intNum").COUNT
			SET RS = DBCON.EXECUTE("SELECT [strFileName] FROM [MPLUS_BOARD_NOTICE_LIST] WHERE [intNum] = '" & REQUEST.FORM("intNum")(I) & "' ")
		IF RS("strFileName") <> "" AND ISNULL(RS("strFileName")) = False THEN CALL ExecFileDelete(rootPath & "Pds\Main\", RS("strFileName"))
		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_NOTICE_LIST] WHERE [intNum] = '" & REQUEST.FORM("intNum")(I) & "' ")
		NEXT

		strMsg = "메인추천글 삭제가 완료되었습니다."

	CASE "REMOVE"

		SET RS = DBCON.EXECUTE("SELECT [strFileName] FROM [MPLUS_BOARD_NOTICE_LIST] WHERE [intNum] = '" & REQUEST.QueryString("intNum") & "' ")
		IF RS("strFileName") <> "" AND ISNULL(RS("strFileName")) = False THEN CALL ExecFileDelete(rootPath & "Pds\Main\", RS("strFileName"))
		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_NOTICE_LIST] WHERE [intNum] = '" & REQUEST.QueryString("intNum") & "' ")

		strMsg = "메인추천글 삭제가 완료되었습니다."

	CASE "EDIT"
		FOR I = 1 TO REQUEST.FORM("intNumH").COUNT
			DBCON.EXECUTE("UPDATE [MPLUS_BOARD_NOTICE_LIST] SET [strCode] = '" & REQUEST.FORM("strCode")(I) & "', [intStep] = '" & REQUEST.FORM("intStep")(I) & "', [bitUsage] = '" & REQUEST.FORM("bitUsage")(I) & "' WHERE [intNum] = '" & REQUEST.FORM("intNumH")(I) & "' ")
		NEXT

		strMsg = "메인추천글 일괄수정이 완료되었습니다."

	END SELECT

	RESPONSE.WRITE ExecFormSubmitHidden(strMsg, "<input type=hidden name=intPageSize value=" & intPageSize & "><input type=hidden name=strSelectGroup value=" & strSelectGroup & ">", "BoardBestList.asp", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>