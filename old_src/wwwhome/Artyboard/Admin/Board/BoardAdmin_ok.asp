<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Main/Main.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM strBoardID, Action, strAdminList, tmpStrAdminList, strAdminInput, strMsg, I, strQuery, strNotAddLoginID, SQL

	Action        = UCASE(REQUEST.Form("Action"))
	strBoardID    = REQUEST.QueryString("strBoardID")
	strAdminList  = REQUEST.Form("strAdminList")
	strAdminInput = GetReplaceInput(REQUEST.Form("strAdminInput"), "")

	SELECT CASE Action
	CASE "ADD"

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '" & strBoardID & "' ")

		tmpStrAdminList  = RS("strAdmin")
		strNotAddLoginID = RS("strAdmin")

		IF tmpStrAdminList = "" OR ISNULL(tmpStrAdminList) = True THEN
			tmpStrAdminList  = ""
			strQuery         = ""
			strNotAddLoginID = ""
		ELSE
			strQuery         = tmpStrAdminList
			strNotAddLoginID = REPLACE(strNotAddLoginID, "|", ",")
		END IF

		SQL = "SELECT [strLoginID] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] IN (" & getSplitQuery(strAdminInput) & ") AND [bitSecession] = '0' AND [strAdmin] != '2' "

		IF strNotAddLoginID <> "" THEN SQL = SQL & " AND [strLoginID] NOT IN (" & getSplitQuery(strNotAddLoginID) & ") "

		SET RS = DBCON.EXECUTE(SQL)

		WHILE NOT(RS.EOF)
			IF GetBoardAdminSplit(tmpStrAdminList, RS("strLoginID")) = True THEN strQuery = strQuery & RS("strLoginID") & "|"
		RS.MOVENEXT
		WEND

		DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CONFIG_DEFAULT] SET [strAdmin] = '" & strQuery & "' WHERE [strBoardID] = '" & strBoardID & "' ")

		strQuery = SPLIT(strQuery, "|")
		FOR I = 0 TO UBOUND(strQuery)
			IF strQuery(I) <> "" THEN DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strAdmin] = '1' WHERE [strLoginID] = '" & strQuery(I) & "' ")
		NEXT

		strMsg = "관리자 등록이 완료되었습니다."

	CASE "REMOVE"

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '" & strBoardID & "' ")

		strAdminList = REPLACE(RS("strAdmin"), strAdminList & "|", "")

		DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CONFIG_DEFAULT] SET [strAdmin] = '" & strAdminList & "' WHERE [strBoardID] = '" & strBoardID & "' ")

		SET RS = DBCON.EXECUTE("SELECT [strAdmin] FROM [MPLUS_BOARD_CONFIG_DEFAULT] ")

		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strAdmin] = '0' WHERE [strLoginID] = '" & REQUEST.Form("strAdminList") & "' ")

		strAdminList = ""

		WHILE NOT(RS.EOF)
			IF RS("strAdmin") <> "" AND ISNULL(RS("strAdmin")) = False THEN strAdminList = strAdminList & RS("strAdmin")
		RS.MOVENEXT
		WEND

		strAdminList = SPLIT(strAdminList, "|")
		strQuery     = ""

		FOR I = 0 TO UBOUND(strAdminList)
			IF strAdminList(I) <> "" THEN
				IF strQuery <> "" THEN strQuery = strQuery & ","
				strQuery = strQuery & "'" & strAdminList(I) & "'"
			END IF
		NEXT

		IF strQuery <> "" THEN DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strAdmin] = '1' WHERE [strLoginID] IN (" & strQuery & ") ")

		strMsg = "관리자 삭제가 완료되었습니다."

	END SELECT

	RESPONSE.WRITE ExecFormSubmit(strMsg, "BoardAdmin.asp?strBoardID=" & strBoardID, "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>