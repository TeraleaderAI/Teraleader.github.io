<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	RESPONSE.EXPIRES     = 0
	SERVER.SCRIPTTIMEOUT = 2000

	DIM Action, intThRead, I, F, J, Query, strBoardID, intCategory, strOrigBoardID, bitNewDate, bitAddMemo, iCount, strMsg, intIndex
	Action         = GetReplaceInput(REQUEST.QueryString("Action"), "S")
	intThRead      = GetReplaceInput(REQUEST.FORM("intThRead"), "")
	strBoardID     = GetReplaceInput(REQUEST.FORM("strBoardID"), "")
	intCategory    = GetReplaceInput(REQUEST.FORM("intCategory"), "")
	strOrigBoardID = GetReplaceInput(REQUEST.FORM("strOrigBoardID"), "")
	bitNewDate     = REQUEST.FORM("bitNewDate")
	bitAddMemo     = REQUEST.FORM("bitAddMemo")

	DIM intMaxIndex, intMaxThread, strFileCode, intMaxSeq
	DIM exeIntThread, exeIntSeq, exeIntCategory, exeStrContent, exeStrFileCode, exeReplyCount, exeFileCount
	DIM imgIntFileType, imgDesFileName, imgStrFileName, imgIntFileSize, imgIntFileDown, imgImgWidth, imgImgHeight

	SELECT CASE Action
	CASE "isNotice", "isBoard"

		Query = " AND [intThRead] IN (" & getSplitQuery(intThRead) & ")"

		SET RS = DBCON.EXECUTE("SELECT [a].[intThRead], [intReplyCount] = (SELECT COUNT([intSeq]) FROM [MPLUS_BOARD] WHERE [strBoardID] = '" & strOrigBoardID & "' AND [intThRead] < [a].[intThread] AND [intThRead] > [a].[intThread] - 99) FROM [MPLUS_BOARD][a] WHERE [bitDelete] = '0' AND [strBoardID] = '" & strOrigBoardID & "' " & Query)

		intThRead = ""
		iCount    = 0

		WHILE NOT(RS.EOF)
			IF RS("intReplyCount") = "0" THEN
				intThRead = intThRead & RS("intThRead") & ","
				iCount = iCount + 1
			END IF
		RS.MOVENEXT
		WEND

		IF iCount = 0 THEN
			RESPONSE.WRITE ExecJavaAlert("게시글 변경이 가능한 게시글이 없습니다.", 1)
			RESPONSE.End()
		ELSE
			IF Action = "isNotice" THEN
				DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [bitNotice] = '1' WHERE [strBoardID] = '" & strOrigBoardID & "' AND [intThRead] IN (" & getSplitQuery(intThRead) & ") ")
				strMsg = "게시글 변경이 완료되었습니다."
			END IF
	
			IF Action = "isBoard"  THEN
				DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [bitNotice] = '0' WHERE [strBoardID] = '" & strOrigBoardID & "' AND [intThRead] IN (" & getSplitQuery(intThRead) & ") ")
				strMsg = "게시글 변경이 완료되었습니다."
			END IF
		END IF

	CASE "remove"

		Query = " AND [intThRead] IN (" & getSplitQuery(intThRead) & ")"

		SET RS = DBCON.EXECUTE("SELECT [a].[intIndex], [a].[intThRead], [intReplyCount] = (SELECT COUNT([intSeq]) FROM [MPLUS_BOARD] WHERE [bitDelete] = '0' AND [strBoardID] = '" & strOrigBoardID & "' AND [intThRead] < [a].[intThread] AND [intThRead] > [a].[intThread] - 99) FROM [MPLUS_BOARD][a] WHERE [bitDelete] = '0' AND [strBoardID] = '" & strOrigBoardID & "' " & Query)

		intThRead = ""
		intIndex  = ""
		iCount    = 0

		WHILE NOT(RS.EOF)
			IF RS("intReplyCount") = 0 THEN
				intThRead = intThRead & RS("intThRead") & ","
				intIndex  = intIndex  & RS("intIndex") & ","
				iCount = iCount + 1
			END IF
		RS.MOVENEXT
		WEND

		IF iCount = 0 THEN
			RESPONSE.WRITE ExecJavaAlert("삭제가 가능한 게시글이 없습니다.\n답변글이 있는 게시글은 답변글 삭제후 삭제가 가능합니다.", 1)
			RESPONSE.End()
		END IF

		CALL ExecBoardDelete(rootPath, strOrigBoardID, intThread, intIndex)

		strMsg = "게시글 삭제가 완료되었습니다."

	CASE "move"

		DIM intThReadDelete, intIndexDelete

		intThReadDelete = intThRead
		intThRead       = SPLIT(intThRead, ",")
		intIndexDelete  = ""

		FOR I = 0 TO UBOUND(intThRead)

			IF intThRead(I) <> "" THEN

				SET RS = DBCON.EXECUTE("SELECT [a].[strBoardID], [a].[intIndex], [a].[intSeq], [a].[intCategory], [a].[strContent], [a].[strFileCode], [intReplyCount] = (SELECT COUNT([intSeq]) FROM [MPLUS_BOARD] WHERE [intThRead] < [a].[intThread] AND [intThRead] > [a].[intThread] - 99), [intFileCount] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_FILE] WHERE [strFileCode] = [a].[strFileCode]) FROM [MPLUS_BOARD][a] WHERE [strBoardID] = '" & strOrigBoardID & "' AND [bitDelete] = '0' AND [intThRead] = '" & intThRead(I) & "' ")

				exeIntSeq      = RS("intSeq")
				exeIntCategory = RS("intCategory")
				exeStrContent  = RS("strContent")
				exeStrFileCode = RS("strFileCode")
				exeReplyCount  = RS("intReplyCount")
				exeFileCount   = RS("intFileCount")

				IF intIndexDelete <> "" THEN intIndexDelete = intIndexDelete & ","
				intIndexDelete = intIndexDelete & RS("intIndex")

				CALL ExecBoardCopy(rootPath, "0", strBoardID, strOrigBoardID, intThRead(I), exeIntSeq, exeIntCategory, exeStrContent, exeStrFileCode, exeFileCount, bitAddMemo, bitNewDate, "move")

				IF exeReplyCount > 0 THEN

					SET RS2 = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_REPLY] '" & strOrigBoardID & "', '" & exeIntSeq & "', '0' ")

					WHILE NOT(RS2.EOF)

						IF INT(RS2("intThread")) <> INT(intThRead(I)) THEN

							exeIntThread   = RS2("intThread")
							exeIntIndex    = RS2("intIndex")
							exeIntSeq      = RS2("intSeq")
							exeIntCategory = RS2("intCategory")
							exeStrContent  = RS2("strContent")
							exeStrFileCode = RS2("strFileCode")
							exeFileCount   = RS2("intFileCount")

							CALL ExecBoardCopy(rootPath, "1", strBoardID, strOrigBoardID, exeIntThread, exeIntSeq, exeIntCategory, exeStrContent, exeStrFileCode, exeFileCount, bitAddMemo, bitNewDate, "move")

							CALL ExecBoardDelete(rootPath, strOrigBoardID, exeIntThread, exeIntIndex)

						END IF
					RS2.MOVENEXT
					WEND

				END IF
			END IF
		NEXT

		CALL ExecBoardDelete(rootPath, strOrigBoardID, intThReadDelete, intIndexDelete)

		strMsg = "게시글 이동이 완료되었습니다."

	CASE "copy"

		intThRead = SPLIT(intThRead, ",")

		FOR I = 0 TO UBOUND(intThRead)

			IF intThRead(I) <> "" THEN

				SET RS = DBCON.EXECUTE("SELECT [a].[strBoardID], [a].[intSeq], [a].[intCategory], [a].[strContent], [a].[strFileCode], [intReplyCount] = (SELECT COUNT([intSeq]) FROM [MPLUS_BOARD] WHERE [bitDelete] = '0' AND [intThRead] < [a].[intThread] AND [intThRead] > [a].[intThread] - 99), [intFileCount] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_FILE] WHERE [strFileCode] = [a].[strFileCode]) FROM [MPLUS_BOARD][a] WHERE [bitDelete] = '0' AND [strBoardID] = '" & strOrigBoardID & "' AND [intThRead] = '" & intThRead(I) & "' ")

				exeIntSeq      = RS("intSeq")
				exeIntCategory = RS("intCategory")
				exeStrContent  = RS("strContent")
				exeStrFileCode = RS("strFileCode")
				exeReplyCount  = RS("intReplyCount")
				exeFileCount   = RS("intFileCount")

				CALL ExecBoardCopy(rootPath, "0", strBoardID, strOrigBoardID, intThRead(I), exeIntSeq, exeIntCategory, exeStrContent, exeStrFileCode, exeFileCount, bitAddMemo, bitNewDate, "copy")

				IF exeReplyCount > 0 THEN

					SET RS2 = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_REPLY] '" & strOrigBoardID & "', '" & exeIntSeq & "', '0' ")

					WHILE NOT(RS2.EOF)

						IF INT(RS2("intThread")) <> INT(intThRead(I)) THEN

							exeIntThread   = RS2("intThread")
							exeIntSeq      = RS2("intSeq")
							exeIntCategory = RS2("intCategory")
							exeStrContent  = RS2("strContent")
							exeStrFileCode = RS2("strFileCode")
							exeFileCount   = RS2("intFileCount")

							CALL ExecBoardCopy(rootPath, "1", strBoardID, strOrigBoardID, exeIntThread, exeIntSeq, exeIntCategory, exeStrContent, exeStrFileCode, exeFileCount, bitAddMemo, bitNewDate, "copy")
						END IF

					RS2.MOVENEXT
					WEND

				END IF
			END IF
		NEXT

		strMsg = "게시글 복사가 완료되었습니다."

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE : SET RS2 = NOTHING

	RESPONSE.WRITE "<script language=javascript>" & vbcrlf
	RESPONSE.WRITE "alert('" & strMsg & "');" & vbcrlf
	RESPONSE.WRITE "opener.location.reload();" & vbcrlf
	RESPONSE.WRITE "self.close();" & vbcrlf
	RESPONSE.WRITE "</script>" & vbcrlf
	RESPONSE.End()
%>