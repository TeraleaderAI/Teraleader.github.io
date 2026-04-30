<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 1
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM Action, strBoardID, selectBoardID, I, J, strField, SQL, tempField

	Action        = REQUEST.FORM("Action")
	strBoardID    = REQUEST.FORM("strBoardID")
	selectBoardID = SPLIT(REQUEST.FORM("selectBoardID"), ",")

	IF Action = "5" THEN
		tempField  = SPLIT(REQUEST.FORM("strField"),"$")
		strField   = SPLIT(tempField(0), ",")
		strFieldRe = SPLIT(tempField(1), ",")
	ELSE
		strField = SPLIT(REQUEST.FORM("strField"), ",")
	END IF

	FOR I = 0 TO UBOUND(selectBoardID)
		IF selectBoardID(I) <> "" THEN

			SQL = "UPDATE [a] SET "

			IF Action <> "5" THEN
				FOR J = 0 TO UBOUND(strField)
					IF strField(J) <> "" THEN SQL = SQL & " [a].[" & strField(J) & "] = [b].[" & strField(J) & "],"
				NEXT
				SQL = LEFT(SQL, LEN(SQL) - 1)
			END IF

			SELECT CASE Action
			CASE "1"

				SQL = SQL & "FROM [MPLUS_BOARD_CONFIG_DEFAULT][a], [MPLUS_BOARD_CONFIG_DEFAULT][b] WHERE [a].[strBoardID] = '" & selectBoardID(I) & "' AND [b].[strBoardID] = '" & strBoardID & "' "
				DBCON.EXECUTE(SQL)

			CASE "2"

				SQL = SQL & "FROM [MPLUS_BOARD_CONFIG_LIST][a], [MPLUS_BOARD_CONFIG_LIST][b] WHERE [a].[strBoardID] = '" & selectBoardID(I) & "' AND [b].[strBoardID] = '" & strBoardID & "' "
				DBCON.EXECUTE(SQL)

			CASE "3"

				SQL = SQL & "FROM [MPLUS_BOARD_CONFIG_READ][a], [MPLUS_BOARD_CONFIG_READ][b] WHERE [a].[strBoardID] = '" & selectBoardID(I) & "' and [b].[strBoardID] = '" & strBoardID & "' "
				DBCON.EXECUTE(SQL)

			CASE "4"

				SQL = SQL & "FROM [MPLUS_BOARD_CONFIG_WRITE][a], [MPLUS_BOARD_CONFIG_WRITE][b] WHERE [a].[strBoardID] = '" & selectBoardID(I) & "' and [b].[strBoardID] = '" & strBoardID & "' "
				DBCON.EXECUTE(SQL)

			CASE "5"

				IF UBOUND(strField) > 0 THEN

					FOR J = 0 TO UBOUND(strField)
						IF strField(J) <> "" THEN SQL = SQL & " [a].[" & strField(J) & "] = [b].[" & strField(J) & "],"
					NEXT
		
					SQL = LEFT(SQL, LEN(SQL) - 1)
					SQL = SQL & "FROM [MPLUS_GROUP_BOARD][a], [MPLUS_GROUP_BOARD][b] WHERE [a].[strBoardID] = '" & selectBoardID(I) & "' and [b].[strBoardID] = '" & strBoardID & "' "
					DBCON.EXECUTE(SQL)

				END IF

				IF UBOUND(strFieldRe) > 0 THEN
					SQL = "UPDATE [a] SET "
					FOR J = 0 TO UBOUND(strFieldRe)
						IF strFieldRe(J) <> "" THEN SQL = SQL & " [a].[" & strFieldRe(J) & "] = [b].[" & strFieldRe(J) & "],"
					NEXT
					SQL = LEFT(SQL, LEN(SQL) - 1)
					SQL = SQL & "FROM [MPLUS_BOARD_POINT][a], [MPLUS_BOARD_POINT][b] WHERE [a].[strBoardID] = '" & selectBoardID(I) & "' and [b].[strBoardID] = '" & strBoardID & "' "
					DBCON.EXECUTE(SQL)
				END IF

			END SELECT
		END IF
	NEXT

	DIM strMoveUrl

	SELECT CASE UCASE(Action)
	CASE "1" : strMoveUrl = "BoardDefaultConfig.asp?strBoardID=" & strBoardID
	CASE "2" : strMoveUrl = "boardListConfig.asp?strBoardID=" & strBoardID
	CASE "3" : strMoveUrl = "BoardReadConfig.asp?strBoardID=" & strBoardID
	CASE "4" : strMoveUrl = "BoardWriteConfig.asp?strBoardID=" & strBoardID
	CASE "5" : strMoveUrl = "BoardPointConfig.asp?strBoardID=" & strBoardID
	END SELECT

	RESPONSE.WRITE ExecJavaAlertLayer("게시판 설정이 완료되었습니다.", strMoveUrl)
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>