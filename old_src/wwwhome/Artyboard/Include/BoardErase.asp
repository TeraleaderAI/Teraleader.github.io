<!-- #include file = "BoardInclude.asp" -->
<%
	DIM intSeq, strMoveUrl, strBoardDeleteMode
	intSeq = GetReplaceInput(REQUEST.QueryString("intSeq"), "S")

	DIM intThread, strLoginID, strPassword, bitExecRemoveBoard, strFileCode

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_READ_DEFAULT] '" & intSeq & "' ")

	intThread    = RS("intThread")
	strLoginID   = RS("strLoginID")
	strPassword  = RS("strPassword")
	strFileCode  = RS("strFileCode")

	IF CONF_bitBoardAdmin = True THEN
		bitExecRemoveBoard = True
	ELSE
		IF strLoginID = "guest" THEN
			IF GetReplaceInput(REQUEST.FORM("strPassword"), "S") = strPassword THEN
				bitExecRemoveBoard = True
			ELSE
				RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(7) , 0)
				RESPONSE.End()
			END IF
		ELSE
			IF SESSION("strLoginID") = strLoginID THEN bitExecRemoveBoard = True ELSE bitExecRemoveBoard = False
		END IF
	END IF

	IF bitExecRemoveBoard = False THEN
		RESPONSE.WRITE ExecJavaAlert(DIM_strBoardMsg(6) , 0)
		RESPONSE.End()
	ELSE
		DIM intDepth, intIndex

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_DELETE] '" & strBoardID & "', '" & intThread & "', '0', '1' ")
		intDepth = RS("intDepth")
		intIndex = RS("intIndex")

		DIM isRemove

		IF RS("intDepth") = 0 THEN
			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_DELETE] '" & strBoardID & "', '" & intThread & "', '0', '2' ")
			IF RS(0) = 1 THEN isRemove = True ELSE isRemove = False
		ELSE
			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_DELETE] '" & strBoardID & "', '" & intThread & "', '" & intDepth & "', '3' ")
			IF RS(0) = 0 THEN isRemove = True ELSE isRemove = False
		END IF

		IF isRemove = True THEN
			CALL ExecBoardDelete(rootPath, strBoardID, intThread & ",", intIndex & ",")
			strMoveUrl = "../mboard.asp?Action=list&strBoardID=" & strBoardID & "&intCategory=" & intCategory & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intPage=" & intPage
			IF GetReplaceInput(REQUEST.QueryString("strScYear"),"S") <> "" AND GetReplaceInput(REQUEST.QueryString("strScMonth"),"S") <> "" AND GetReplaceInput(REQUEST.QueryString("strScDay"),"S") THEN strMoveUrl = strMoveUrl & " &strScYear=" & GetReplaceInput(REQUEST.QueryString("strScYear"),"S") & "&strScMonth=" & GetReplaceInput(REQUEST.QueryString("strScMonth"),"S") & "&strScDay=" & GetReplaceInput(REQUEST.QueryString("strScDay"),"S")

			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_LIST] '" & strBoardID & "' ")
			IF RS("strViewType") = "1" THEN
				RESPONSE.WRITE ExecFormSubmitClose(DIM_strBoardMsg(8), strMoveUrl)
				RESPONSE.End()
			ELSE
				RESPONSE.WRITE ExecFormSubmit(DIM_strBoardMsg(8), strMoveUrl, "")
				RESPONSE.End()
			END IF
		ELSE
			strMoveUrl = "../mboard.asp?Action=view&strBoardID=" & strBoardID & "&intPage=" & intPage & "&intCategory=" & intCategory & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intSeq=" & intSeq
			IF GetReplaceInput(REQUEST.QueryString("strScYear"),"S") <> "" AND GetReplaceInput(REQUEST.QueryString("strScMonth"),"S") <> "" AND GetReplaceInput(REQUEST.QueryString("strScDay"),"S") THEN strMoveUrl = strMoveUrl & " &strScYear=" & GetReplaceInput(REQUEST.QueryString("strScYear"),"S") & "&strScMonth=" & GetReplaceInput(REQUEST.QueryString("strScMonth"),"S") & "&strScDay=" & GetReplaceInput(REQUEST.QueryString("strScDay"),"S")

			RESPONSE.WRITE ExecFormSubmit(DIM_strBoardMsg(9), strMoveUrl, "")
			RESPONSE.End()
		END IF
	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>