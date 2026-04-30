<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM Action, strBoardID, intPage, intCategory, strSearchCategory, strSearchWord, intSeq, checkIntSeq
	DIM strScYear, strScMonth, strScDay, intCmtSeq

	WITH REQUEST

		Action            = GetReplaceInput(.QueryString("Action"), "S")
		strBoardID        = GetReplaceInput(.QueryString("strBoardID"), "S")
		intPage           = GetReplaceInput(.QueryString("intPage"), "S")
		intCategory       = GetReplaceInput(.QueryString("intCategory"), "S")
		strSearchCategory = GetReplaceInput(.QueryString("strSearchCategory"), "S")
		strSearchWord     = GetReplaceInput(.QueryString("strSearchWord"), "S")
		checkIntSeq       = GetReplaceInput(.QueryString("checkIntSeq")	, "S")
		intSeq            = GetReplaceInput(.QueryString("intSeq")	, "S")
		strScYear         = GetReplaceInput(.QueryString("strScYear")	, "S")
		strScMonth        = GetReplaceInput(.QueryString("strScMonth")	, "S")
		strScDay          = GetReplaceInput(.QueryString("strScDay")	, "S")
		intCmtSeq         = GetReplaceInput(.QueryString("intCmtSeq")	, "S")

	END WITH

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '" & strBoardID & "', '" & SESSION("strLoginID") & "' ")

	DIM strAdmin, bitBoardAdmin, bitAdminCheck, CONF_strLanguage
	strAdmin         = RS("strAdmin")
	bitBoardAdmin    = GetAdminCheck(SESSION("strLoginID"), RS("strAdmin"), SESSION("strAdmin"))
	bitAdminCheck    = RS("bitAdminCheck")
	CONF_strLanguage = RS("strLanguage")
%>
<!-- #include file = "../Include/BoardIncludeLanguage.asp" -->
<%
	DIM moveUrl

	moveUrl = "../mboard.asp?Action=view&strBoardID=" & strBoardID & "&intPage=" & intPage & "&intCategory=" & intCategory & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord

	IF checkIntSeq = "" THEN moveUrl = moveUrl & "&intSeq=" & intSeq ELSE moveUrl = moveUrl & "&checkIntSeq=" & checkIntSeq

	IF strScYear <> "" AND strScMonth <> "" AND strScDay <> "" THEN moveUrl = moveUrl & "&strScYear=" & strScYear & "&strScMonth=" & strScMonth & "&strScDay=" & strScDay

	SELECT CASE UCASE(Action)
	CASE "CMTADD", "CMTEDIT", "CMTREPLY"

		DIM comment_intThread, comment_intDepth, comment_id, comment_bitHtml, comment_name, comment_pwd, comment_content
		DIM comment_intScore, comment_intIcon, comment_strBoardBg, bitEditComment

		WITH REQUEST
	
			comment_intThread      = GetReplaceInput(.FORM("comment_intThread"), "")
			comment_intDepth       = GetReplaceInput(.FORM("comment_intDepth"), "")
			comment_id             = GetReplaceInput(.FORM("comment_id"), "")
			comment_bitHtml        = GetReplaceInput(.FORM("comment_html"), "")
			comment_name           = GetReplaceInput(.FORM("comment_name"), 1)
			comment_pwd            = GetReplaceInput(.FORM("comment_pwd"), 1)
			comment_content        = GetReplaceInput(.FORM("comment_content"), 1)
			comment_intScore       = GetReplaceInput(.FORM("comment_intScore"), "")
			comment_intIcon        = GetReplaceInput(.FORM("comment_intIcon"), "")
			comment_strBoardBg     = GetReplaceInput(.FORM("strBoardBg"), "")
	
		END WITH

		IF comment_name = "" THEN
			RESPONSE.WRITE ExecJavaAlert("등록자 이름을 입력해 주시기 바랍니다.", 0)
			RESPONSE.End()
		END IF

		IF bitBoardAdmin = False THEN
			IF comment_id = "guest" AND comment_pwd = "" THEN
				RESPONSE.WRITE ExecJavaAlert("비밀번호를 입력해 주시기 바랍니다.", 0)
				RESPONSE.End()
			END IF
		END IF
	
		IF comment_content = "" THEN
			RESPONSE.WRITE ExecJavaAlert("내용을 입력해 주시기 바랍니다.", 0)
			RESPONSE.End()
		END IF

		DIM strBadContent, strBadContentReplace, strBadContentMsg

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_WRITE] '" & strBoardID & "' ")

		strBadContent        = RS("strBadContent")
		strBadContentReplace = RS("strBadContentReplace")
		strBadContentMsg     = RS("strBadContentMsg")
		strBadContentList    = RS("strBadContentList")

		SELECT CASE strBadContent
		CASE "1"
			IF strBadContentList <> "" AND ISNULL(strBadContentList) = False THEN
				DIM badWords
				badWords = SPLIT(strBadContentList, ",")
				FOR I = 0 TO UBOUND(badWords)
					IF badWords(I) <> "" THEN comment_content = REPLACE(comment_content, badWords(I), strBadContentReplace)
				NEXT
			END IF
		CASE "2"
			IF GetSplitFindWord(strBadContentList, comment_name & comment_content) = False THEN
				RESPONSE.WRITE ExecJavaAlert(strBadContentMsg, 0)
				RESPONSE.End()
			END IF
		END SELECT

	END SELECT

	SELECT CASE UCASE(Action)
	CASE "CMTADD", "CMTEDIT", "CMTREPLY"

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_POINT] '" & strBoardID & "' ")
						
		DIM bitUsePoint, intCommentPoint
		bitUsePoint     = RS("bitUsePoint")
		intCommentPoint = RS("intCommentPoint")

		comment_name    = GetTrimStrCheck(comment_name, "이름을 올바르게 입력해 주시기 바랍니다.")
		IF comment_id = "guest" AND bitBoardAdmin = False THEN comment_pwd = GetTrimStrCheck(comment_pwd, "비밀번호를 올바르게 입력해 주시기 바랍니다.")
		comment_content = GetTrimStrCheck(comment_content, "내용을 올바르게 입력해 주시기 바랍니다.")

		SELECT CASE UCASE(Action)
		CASE "CMTADD"

			SET RS = DBCON.EXECUTE("EXEC [MPLUS_PUT_COMMENT_WRITE] '" & strBoardID & "', '" & comment_intThread & "', '" & comment_intSeq & "', '0' ")

			comment_intCmtThread = RS(0)

			IF bitUsePoint = True THEN
				IF intCommentPoint <> 0 THEN
					IF comment_id = "guest" THEN
						RESPONSE.WRITE ExecJavaAlert("로그인 후 이용해 주시기 바랍니다.", 0)
						RESPONSE.End()
					ELSE
						IF intCommentPoint < 0 THEN
							SET RS = DBCON.EXECUTE("EXEC MPLUS_GET_MEMBER_READ '" & SESSION("strLoginID") & "' ")
							IF RS("intPoint") < intCommentPoint THEN
								RESPONSE.WRITE ExecJavaAlert("댓글쓰기 포인트가 부족합니다.", 0)
								RESPONSE.End()
							END IF
						END IF
						DBCON.EXECUTE("EXEC [MPLUS_PUT_MEMBER_POINT] '1', '" & strBoardiD & "', '" & comment_boardIntSeqNum & "', '" & intSeq & "', '" & comment_id & "', '', '', 'P009', " & intCommentPoint & ", '댓글 등록 포인트' ")
					END IF
				END IF
			END IF

			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_COMMENT] ([strBoardID], [strName], [intThread], [intCmtThread], [intDepth], [bitHtml], [intScore], [intIcon], [strLoginID], [strPassword], [strContent], [strBgColor], [strIpAddr]) VALUES ('" & strBoardID & "', '" & comment_name & "', '" & comment_intThread & "', '" & comment_intCmtThread & "', '0', '" & comment_bitHtml & "', '" & comment_intScore & "', '" & comment_intIcon & "', '" & comment_id & "', '" & comment_pwd & "', '" & comment_content & "', '" & comment_strBoardBg & "', '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "') ")
			DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [intComment] = [intComment] + 1, [dateCmtDate] = getdate() WHERE [intSeq] = '" & intSeq & "' ")
	
			IF comment_id <> "guest" THEN DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [intCommentCount] = [intCommentCount] + 1 WHERE [strLoginID] = '" & comment_id & "' ")
	
			RESPONSE.WRITE ExecFormSubmit("등록되었습니다.", moveUrl , "")
			RESPONSE.End()

		CASE "CMTEDIT"

			IF bitBoardAdmin = True THEN
				bitEditComment = True
			ELSE
				IF comment_pwd = "" THEN
					SET RS = DBCON.EXECUTE("SELECT [intSeq], [strLoginID] FROM [MPLUS_BOARD_COMMENT] WHERE [intSeq] = '" & intCmtSeq & "' AND [strLoginID] = '" & SESSION("strLoginID") & "' ")
					IF RS.EOF THEN bitEditComment = False ELSE bitEditComment = True
				ELSE
					SET RS = DBCON.EXECUTE("SELECT [intSeq] FROM [MPLUS_BOARD_COMMENT] WHERE [intSeq] = '" & intCmtSeq & "' AND [strPassword] = '" & comment_pwd & "' ")
					IF RS.EOF THEN bitEditComment = False ELSE bitEditComment = True
				END IF
			END IF

			IF bitEditComment = True THEN

				DBCON.EXECUTE("UPDATE [MPLUS_BOARD_COMMENT] SET [bitHtml] = '" & comment_bitHtml & "', [strContent] = '" & comment_content & "', [intScore] = '" & comment_intScore & "', [intIcon] = '" & comment_intIcon & "', [strBgColor] = '" & comment_strBoardBg & "' WHERE [intSeq] = '" & intCmtSeq & "' ")

				RESPONSE.WRITE ExecFormSubmit("수정이 완료되었습니다.", moveUrl , "")
				RESPONSE.End()

			ELSE

				RESPONSE.WRITE ExecJavaAlert("댓글 수정 오류가 발생되었습니다.\n잘못된 비밀번호거나 본인의 댓글이 아닙니다.", 0)
				RESPONSE.End()

			END IF

		CASE "CMTREPLY"

			SET RS = DBCON.EXECUTE("EXEC [MPLUS_PUT_COMMENT_WRITE] '" & strBoardID & "', '" & comment_intThread & "', '" & intCmtSeq & "', '1' ")
			DIM comment_intBoardThread, comment_intThreadReply
			comment_intBoardThread = RS(0)
			comment_intThreadReply = RS(1)

			IF bitUsePoint = True THEN
				IF intCommentPoint <> 0 THEN
					IF comment_id = "guest" THEN
						RESPONSE.WRITE ExecJavaAlert("로그인 후 이용해 주시기 바랍니다.", 0)
						RESPONSE.End()
					ELSE
						IF intCommentPoint < 0 THEN
							SET RS = DBCON.EXECUTE("EXEC MPLUS_GET_MEMBER_READ '" & SESSION("strLoginID") & "' ")
							IF RS("intPoint") < intCommentPoint THEN
								RESPONSE.WRITE ExecJavaAlert("댓글쓰기 포인트가 부족합니다.", 0)
								RESPONSE.End()
							END IF
						END IF
						SET RS = DBCON.EXECUTE("SELECT TOP 1 [intSeq] FROM [MPLUS_BOARD_COMMENT] WHERE [intThread] = '" & comment_intThread & "' ORDER BY [intSeq] DESC ")
						DBCON.EXECUTE("EXEC [MPLUS_PUT_MEMBER_POINT] '1', '" & strBoardiD & "', '" & comment_boardIntSeqNum & "', '" & RS("intSeq") & "', '" & comment_id & "', '', '', 'P009', " & intCommentPoint & ", '댓글 답변 포인트' ")
					END IF
				END IF
			END IF

			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_COMMENT] ([strBoardID], [strName], [intThread], [intCmtThread], [intDepth], [bitHtml], [intScore], [intIcon], [strLoginID], [strPassword], [strContent], [strBgColor], [strIpAddr]) VALUES ('" & strBoardID & "', '" & comment_name & "', '" & comment_intBoardThread & "', '" & comment_intThreadReply & "', '" & comment_intDepth + 1 & "', '" & comment_bitHtml & "', '" & comment_intScore & "', '" & comment_intIcon & "', '" & comment_id & "', '" & comment_pwd & "', '" & comment_content & "', '" & comment_strBoardBg & "', '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "') ")

			DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [intComment] = [intComment] + 1, [dateCmtDate] = getdate() WHERE [intSeq] = '" & intSeq & "' ")
	
			IF comment_id <> "guest" THEN DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [intCommentCount] = [intCommentCount] + 1 WHERE [strLoginID] = '" & comment_id & "' ")

			RESPONSE.WRITE ExecFormSubmit("등록되었습니다.", moveUrl , "")
			RESPONSE.End()

		END SELECT

	CASE "CMTREMOVE"

		DIM bitRemoveComment, strPassword

		strPassword = GetReplaceInput(REQUEST.FORM("strPassword"), "S")

		IF bitBoardAdmin = True THEN
			bitRemoveComment = True
		ELSE
			IF strPassword = "" THEN
				SET RS = DBCON.EXECUTE("SELECT [intSeq], [strLoginID] FROM [MPLUS_BOARD_COMMENT] WHERE [intSeq] = '" & intCmtSeq  & "' AND [strLoginID] = '" & SESSION("strLoginID") & "' ")
				IF RS.EOF THEN bitRemoveComment = False ELSE bitRemoveComment = True
			ELSE
				SET RS = DBCON.EXECUTE("SELECT [intSeq] FROM [MPLUS_BOARD_COMMENT] WHERE [intSeq] = '" & intCmtSeq & "' AND [strPassword] = '" & strPassword & "' ")
				IF RS.EOF THEN bitRemoveComment = False ELSE bitRemoveComment = True
			END IF
		END IF

		IF bitRemoveComment = True THEN

			DIM intThread, intCmtThread
			SET RS = DBCON.EXECUTE("SELECT [intThread], [intCmtThread], [intDepth] FROM [MPLUS_BOARD_COMMENT] WHERE [intSeq] = '" & intCmtSeq  & "' ")

			intThread    = RS("intThread")
			intCmtThread = RS("intCmtThread")
			intDepth     = RS("intDepth")

			SET RS = DBCON.EXECUTE("SELECT COUNT([intCmtThread]) FROM [MPLUS_BOARD_COMMENT] WHERE [strBoardID] = '" & strBoardID & "' AND [intCmtThread] < " & intCmtThread & " AND [intCmtThread] > (SELECT TOP 1 [intCmtThread] FROM [MPLUS_BOARD_COMMENT] WHERE [strBoardID] = '" & strBoardID & "' AND [intCmtThread] < " & intCmtThread & " AND [intDepth] <= " & intDepth & " ORDER BY [intCmtThread] DESC) ")

			IF RS(0) > 1 THEN

				RESPONSE.WRITE ExecJavaAlert("댓글의 답변글이 존재하기 때문에 삭제가 되지 않습니다.", 0)
				RESPONSE.End()

			ELSE

				DBCON.EXECUTE("UPDATE [MPLUS_BOARD_COMMENT] SET [bitDelete] = '1' WHERE [intSeq] = '" & intCmtSeq  & "' ")
				DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [intComment] = [intComment] - 1 WHERE [intSeq] = '" & intSeq & "' ")

				SET RS = DBCON.EXECUTE("SELECT [intSeq] FROM [MPLUS_BOARD_COMMENT] WHERE [strBoardID] = '" & strBoardID & "' AND [intThread] = '" & intThread & "' AND [bitDelete] = '0' ")

				IF RS.EOF THEN
					DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [dateCmtDate] = null WHERE [intSeq] = '" & intSeq & "' ")

				ELSE
					DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [dateCmtDate] = (SELECT TOP 1 [dateRegDate] FROM [MPLUS_BOARD_COMMENT] WHERE [strBoardID] = '" & strBoardID & "' AND [intThread] = '" & intThread & "' AND [bitDelete] = '0' ORDER BY [dateRegDate] DESC) WHERE [intSeq] = '" & intSeq & "' ")
				END IF

				DBCON.EXECUTE("DELETE [MPLUS_MEMBER_POINT] WHERE [intCommentSeq] = '" & intCmtSeq  & "' ")
	
				SET RS = DBCON.EXECUTE("SELECT [strLoginID] FROM [MPLUS_BOARD_COMMENT] WHERE [intSeq] = '" & intCmtSeq  & "' ")
	
				IF RS("strLoginID") <> "guest" THEN
					DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [intCommentCount] = [intCommentCount] - 1 WHERE [strLoginID] = '" & RS("strLoginID") & "' ")
					DBCON.EXECUTE("EXEC [MPLUS_MEMBER_POINT_SORT] '" & RS("strLoginID") & "' ")
				END IF

				RESPONSE.WRITE ExecFormSubmit("삭제가 완료되었습니다.", moveUrl , "")
				RESPONSE.End()

			END IF

		ELSE

			RESPONSE.WRITE ExecJavaAlert("댓글 삭제 오류가 발생되었습니다.\n잘못된 비밀번호거나 본인의 댓글이 아닙니다.", 0)
			RESPONSE.End()

		END IF		

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>