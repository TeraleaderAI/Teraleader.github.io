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
	DIM Action, intSeq, intPage, I, strMsg
	
	Action  = REQUEST.QueryString("Action")
	intSeq  = REQUEST.QueryString("intSeq")
	intPage = REQUEST.QueryString("intPage")

	SELECT CASE UCASE(Action)
	CASE "SELECTBAD"

		intSeq = SPLIT(intSeq, ",")
		FOR I = 0 TO UBOUND(intSeq)
			IF intSeq(I) <> "" THEN
				DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [bitBad] = '1' WHERE [intSeq] = '" & intSeq(I) & "' ")
				DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_BAD] WHERE [intSeq] = '" & intSeq(I) & "' ")
			END IF
		NEXT
		strMsg = "불량게시글 등록이 완료되었습니다."

	CASE "BAD"

		DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [bitBad] = '1' WHERE [intSeq] = '" & intSeq & "' ")
		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_BAD] WHERE [intSeq] = '" & intSeq & "' ")
		strMsg = "불량게시글 등록이 완료되었습니다."

	CASE "SELECTREMOVE"

		intSeq = SPLIT(intSeq, ",")
		FOR I = 0 TO UBOUND(intSeq)
			IF intSeq(I) <> "" THEN
				DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_BAD] WHERE [intSeq] = '" & intSeq(I) & "' ")
			END IF
		NEXT
		strMsg = "불량게시글 신고내역 삭제가 완료되었습니다."

	CASE "REMOVE"

		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_BAD] WHERE [intSeq] = '" & intSeq & "' ")
		strMsg = "불량게시글 신고내역 삭제가 완료되었습니다."

	END SELECT

	RESPONSE.WRITE ExecFormSubmit(strMsg, "BoardBadAsk.asp?intPage=" & intPage, "")
	RESPONSE.End()
	
	SET RS = NOTHING : DBCON.CLOSE
%>