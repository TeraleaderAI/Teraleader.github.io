<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM Action, strBoardID, intPage, intCategory, strSearchCategory, strSearchWord, intSeq, checkIntSeq

	WITH REQUEST

		Action                 = GetReplaceInput(.QueryString("Action"), "S")
		strBoardID             = GetReplaceInput(.QueryString("strBoardID"), "S")
		intPage                = GetReplaceInput(.QueryString("intPage"), "S")
		intCategory            = GetReplaceInput(.QueryString("intCategory"), "S")
		strSearchCategory      = GetReplaceInput(.QueryString("strSearchCategory"), "S")
		strSearchWord          = GetReplaceInput(.QueryString("strSearchWord"), "S")
		checkIntSeq            = GetReplaceInput(.QueryString("checkIntSeq")	, "S")
		intSeq                 = GetReplaceInput(.QueryString("intSeq"), "S")

	END WITH

	IF SESSION("strLoginID") = "" THEN
		RESPONSE.WRITE ExecJavaAlert("로그인 후 이용하시기 바랍니다.", 0)
		RESPONSE.End()
	ELSE
	
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_READ] '" & strBoardID & "' ")

		DIM execVote

		IF RS("bitVoteInsert") = False THEN

			execVote = True

		ELSE

			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_VOTE] '" & intSeq & "', '" & SESSION("strLoginID") & "' ")

			IF RS.EOF THEN execVote = True ELSE execVote = False

		END IF

		IF execVote = True THEN

			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_VOTE] ([strBoardID], [intSeq], [strLoginID]) VALUES ('" & strBoardID & "', '" & intSeq & "', '" & SESSION("strLoginID") & "') ")

			DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [intVote] = [intVote] + 1 WHERE [intSeq] = '" & intSeq & "' ")

			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_READ_DEFAULT] '" & intSeq & "' ")

			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [intVote] = [intVote] + 1 WHERE [strLoginID] = '" & RS("strLoginID") & "' ")

			DIM moveUrl

			moveUrl = "../mboard.asp?Action=view&strBoardID=" & strBoardID & "&intPage=" & intPage & "&intCategory=" & intCategory & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord

			IF checkIntSeq = "" THEN moveUrl = moveUrl & "&intSeq=" & intSeq ELSE moveUrl = moveUrl & "&checkIntSeq=" & checkIntSeq

			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_POINT] '" & strBoardID & "' ")
			
			DIM bitUsePoint, intVotePoint
			bitUsePoint  = RS("bitUsePoint")
			intVotePoint = RS("intVotePoint")

			IF bitUsePoint = True THEN
				IF intVotePoint <> 0 THEN
					IF SESSION("strLoginID") = "" THEN
						RESPONSE.WRITE ExecJavaAlert("로그인 후 이용해 주시기 바랍니다.", 0)
						RESPONSE.End()
					ELSE
						SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_READ_DEFAULT] '" & intSeq & "' ")
						IF RS("strLoginID") <> "guest" THEN
							IF intVotePoint < 0 THEN
								SET RS = DBCON.EXECUTE("EXEC MPLUS_GET_MEMBER_READ '" & SESSION("strLoginID") & "' ")
								IF RS("intPoint") < intVotePoint THEN
									RESPONSE.WRITE ExecJavaAlert("추천 포인트가 부족합니다.", 0)
									RESPONSE.End()
								END IF
							END IF
							DBCON.EXECUTE("EXEC [MPLUS_PUT_MEMBER_POINT] '1', '" & strBoardiD & "', '" & intSeq & "', '', '" & RS("strLoginID") & "', '', '', 'P003', " & intVotePoint & ", '게시글 추천 포인트' ")
						END IF
					END IF
				END IF
			END IF

			RESPONSE.WRITE ExecFormSubmit("추천 되었습니다.", moveUrl , "")
			RESPONSE.End()

		ELSE

			RESPONSE.WRITE ExecJavaAlert("이미 추천한 게시글입니다.", 0)
			RESPONSE.End()

		END IF
	END IF
	SET RS = NOTHING : DBCON.CLOSE
%>