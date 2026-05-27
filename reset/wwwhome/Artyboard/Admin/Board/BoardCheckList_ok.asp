<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 1
	isAdminPopup    = False
	strAdminPrevUrl = "Board/BoardCheckList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM Action, strBoardID, strMsg, I, strSplitTemp

	Action     = UCASE(REQUEST.QueryString("Action"))
	strBoardID = REQUEST.FORM("strBoardID")

	strHidden = "<input type=hidden name=strBoardID value=" & strBoardID & ">"

	SELECT CASE Action
	CASE "REMOVE"

		CALL ExecBoardDelete(rootPath, REQUEST.QueryString("strBoardID"), REQUEST.QueryString("intThread") & ",")
		strMsg = "게시글 삭제가 완료되었습니다."

	CASE "CHECK"

		DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [bitCheck] = '1' WHERE [strBoardID] = '" & REQUEST.QueryString("strBoardID") & "' AND [intThread] = '" & REQUEST.QueryString("intThread") & "' ")

		strMsg = "게시글 승인이 완료되었습니다."

	CASE "SELECTREMOVE"

		intThread = ""

		FOR I = 1 TO REQUEST.FORM("intSeq").COUNT
			IF REQUEST.FORM("intSeq")(I) <> "" THEN
				strSplitTemp = SPLIT(REQUEST.FORM("intSeq")(I), ";")
				intThread = intThread & strSplitTemp(1) & ","
			END IF
		NEXT

		CALL ExecBoardDelete(rootPath, strBoardID, intThread)
	
		strMsg = "게시글 삭제가 완료되었습니다."

	CASE "SELECTCHECK"

		FOR I = 1 TO REQUEST.FORM("intSeq").COUNT
			IF REQUEST.FORM("intSeq")(I) <> "" THEN
				strSplitTemp = SPLIT(REQUEST.FORM("intSeq")(I), ";")
				DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [bitCheck] = '1' WHERE [strBoardID] = '" & strSplitTemp(0) & "' AND [intThread] = '" & strSplitTemp(1) & "' ")
			END IF
		NEXT

		strMsg = "게시글 승인이 완료되었습니다."

	END SELECT

	RESPONSE.WRITE ExecFormSubmitHidden(strMsg, strHidden, "BoardCheckList.asp", "")
	RESPONSE.End()

	DBCON.CLOSE
%>