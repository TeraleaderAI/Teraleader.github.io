<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 1
	isAdminPopup    = False
	strAdminPrevUrl = "Main/Main.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM Action, intSeq, intPage, I, strMsg, strDeleteThread, strDeleteStrBoardID
	
	Action = REQUEST.QueryString("Action")
	intSeq = REQUEST.QueryString("intSeq")
	intPage = REQUEST.QueryString("intPage")

	SELECT CASE UCASE(Action)
	CASE "SELECTBAD"

		intSeq = SPLIT(intSeq, ",")
		FOR I = 0 TO UBOUND(intSeq)
			IF intSeq(I) <> "" THEN
				DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [bitBad] = '0' WHERE [intSeq] = '" & intSeq(I) & "' ")
			END IF
		NEXT
		strMsg = "불량 게시글 취소가 완료되었습니다."

	CASE "BAD"

		DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [bitBad] = '0' WHERE [intSeq] = '" & intSeq & "' ")
		strMsg = "불량 게시글 취소가 완료되었습니다."

	CASE "SELECTREMOVE"

		SET RS = DBCON.EXECUTE("SELECT [intThRead], [strBoardID] FROM [MPLUS_BOARD] WHERE [intSeq] IN (" & getSplitQuery(intSeq) & ") ")

		strDeleteThread     = ""
		strDeleteStrBoardID = ""
		WHILE NOT(RS.EOF)
			strDeleteThread = strDeleteThread & RS("intThread") & ","
			strDeleteStrBoardID = strDeleteStrBoardID & RS("strBoardID") & ","
		RS.MOVENEXT
		WEND

		strDeleteThread     = SPLIT(strDeleteThread, ",")
		strDeleteStrBoardID = SPLIT(strDeleteStrBoardID, ",")
		
		FOR I = 0 TO UBOUND(strDeleteThread)
			IF strDeleteThread(I) <> "" THEN CALL ExecBoardDelete(rootPath, strDeleteStrBoardID(I), strDeleteThread(I))
		NEXT

		strMsg = "불량게시글 삭제가 완료되었습니다."

	CASE "REMOVE"

		SET RS = DBCON.EXECUTE("SELECT [intThRead], [strBoardID] FROM [MPLUS_BOARD] WHERE [intSeq] = '" & intSeq & "' ")

		strDeleteThread     = RS("intThRead")
		strDeleteStrBoardID = RS("strBoardID")
		
		CALL ExecBoardDelete(rootPath, strDeleteStrBoardID, strDeleteThread)

		strMsg = "불량게시글 삭제가 완료되었습니다."

	END SELECT

	RESPONSE.WRITE ExecFormSubmit(strMsg, "BoardBadList.asp?intPage=" & intPage, "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>