<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<%
	Response.Buffer = False
	RESPONSE.EXPIRES = 0
%>
<!-- #include file = "../DBConnect/DBConnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM intSeq, intNum, strBoardID, strLoginID
	intSeq     = GetReplaceInput(REQUEST.QueryString("intSeq"), "S")
	intNum     = GetReplaceInput(REQUEST.QueryString("intNum"), "S")
	strBoardID = GetReplaceInput(REQUEST.QueryString("strBoardID"), "S")

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '" & strBoardID & "', '" & SESSION("strLoginID") & "' ")

	DIM CONF_intUserLevel, CONF_bitBoardAdmin, CONF_intDownLevel, CONF_bitDownLevel

	CONF_intUserLevel = RS("intUserLevel")
	IF CONF_intUserLevel = "" OR ISNULL(CONF_intUserLevel) = True THEN CONF_intUserLevel = 0

	CONF_bitBoardAdmin = GetAdminCheck(SESSION("strLoginID"), RS("strAdmin"), SESSION("strAdmin"))

	CONF_strDownLevel  = SPLIT(RS("strDownLevel"), "|")
	IF CONF_strDownLevel(0) = 1 THEN CONF_intDownLevel = 0 ELSE CONF_intDownLevel = CONF_strDownLevel(1)

	CONF_bitDownLevel = GetBoardLevelCheck(CONF_bitBoardAdmin, CONF_intDownLevel, CONF_intUserLevel)

	DIM CONF_bitUsePoint, CONF_intDownPoint
	CONF_bitUsePoint  = RS("bitUsePoint")
	CONF_intDownPoint = RS("intDownPoint")

	IF CONF_bitDownLevel = False THEN
		RESPONSE.WRITE ExecJavaAlert("다운로드 권한이 없습니다.", 0)
		RESPONSE.End()
	END IF

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_READ_DEFAULT] '" & intSeq & "' ")

	IF RS("bitSecret") = True THEN
		IF CONF_bitBoardAdmin = False THEN
			IF SESSION("strLoginID") = "" THEN
				IF UCASE(RS("strLoginID")) = "GUEST" THEN
					IF INSTR(1, UCASE(Request.ServerVariables("HTTP_REFERER")), "Action=VIEW") = "0" THEN
						RESPONSE.WRITE ExecJavaAlert("비밀글은 본인만 다운이 가능합니다.", 0)
						RESPONSE.End()
					END IF
				ELSE
					RESPONSE.WRITE ExecJavaAlert("비밀글은 본인만 다운이 가능합니다.", 0)
					RESPONSE.End()
				END IF
			ELSE
				IF UCASE(RS("strLoginID")) <> UCASE(SESSION("strLoginID")) AND UCASE(RS("strSecretID")) <> UCASE(SESSION("strLoginID")) THEN
					RESPONSE.WRITE ExecJavaAlert("비밀글은 본인만 다운이 가능합니다.", 0)
					RESPONSE.End()
				END IF
			END IF
		END IF
	END IF

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_FILE] '" & intNum & "', '1' ")

	DIM strFileName
	strFileName = RS("strFileName")

	IF CONF_bitBoardAdmin = False THEN	
		IF CONF_bitUsePoint = True THEN
			IF CONF_intDownPoint <> 0 THEN
				IF SESSION("strLoginID") = "" THEN
					RESPONSE.WRITE ExecJavaAlert("로그인 후 이용해 주시기 바랍니다.", 0)
					RESPONSE.End()
				ELSE
					SET RS = DBCON.EXECUTE("SELECT [intNum] FROM [MPLUS_BOARD_DOWN_CHECK] WHERE [strBoardID] = '" & strBoardID & "' AND [intSeq] = '" & intSeq & "' AND [intFileNum] = '" & intNum & "' AND [strLoginID] = '" & SESSION("strLoginID") & "' ")
					IF RS.EOF THEN
						IF CONF_intDownPoint < 0 THEN
							SET RS = DBCON.EXECUTE("EXEC MPLUS_GET_MEMBER_READ '" & SESSION("strLoginID") & "' ")
							IF RS("intPoint") < CONF_intDownPoint THEN
								RESPONSE.WRITE ExecJavaAlert("다운로드 포인트가 부족합니다.", 0)
								RESPONSE.End()
							END IF
						END IF
						DBCON.EXECUTE("EXEC [MPLUS_PUT_MEMBER_POINT] '1', '" & strBoardiD & "', '" & intSeq & "', '', '" & SESSION("strLoginID") & "', '', '', 'P002', " & CONF_intDownPoint & ", '첨부파일 다운로드 포인트' ")
					END IF
				END IF
			END IF
		END IF
	END IF

	IF SESSION("strLoginID") = "" THEN strLoginID = "guest" ELSE strLoginID = SESSION("strLoginID")

	DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_DOWN_CHECK] ([strBoardID], [intSeq], [intFileNum], [strLoginID], [strUserIP]) VALUES ('" & strBoardID & "', '" & intSeq & "', '" & intNum & "', '" & strLoginID & "', '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "') ")

	DIM strUserAgent, strContentDisp, strContentType

	strUserAgent = Request.ServerVariables("HTTP_USER_AGENT")
	IF InStr(strUserAgent, "MSIE") > 0 THEN
	    IF InStr(strUserAgent, "MSIE 5.0") > 0 THEN
					strContentDisp = "attachment;filename="
	        strContentType = "application/x-msdownload"
	    ELSE
					strContentDisp = "attachment;filename="
	        strContentType = "application/unknown"
	    END IF
	ELSE
	    strContentDisp = "attachment;filename="
	    strContentType = "application/unknown"
	END IF

	SELECT CASE setUploadComponet
	CASE "2"

		DIM objFS, objF, objDownload

		RESPONSE.AddHeader "Content-Disposition", strContentDisp & strFileName
		SET objFS = Server.CreateObject("Scripting.FileSystemObject")
		SET objF = objFS.GetFile(rootPath & "Pds\Board\" & strBoardID & "\" & strFileName)
		RESPONSE.AddHeader "Content-Length", objF.Size
		SET objF = NOTHING
		SET objFS = NOTHING
		RESPONSE.ContentType = strContentType
		RESPONSE.CacheControl = "public"
		 
		SET objDownload = Server.CreateObject("DEXT.FileDownload")
		objDownload.Download rootPath & "Pds\Board\" & strBoardID & "\" & strFileName
		SET objDownload = NOTHING

	CASE "1"

		DIM objstream, download

		RESPONSE.AddHeader "Content-Disposition", strContentDisp & strFileName
		RESPONSE.ContentType  = strContentType
		RESPONSE.CacheControl = "public"
	 
		SET objStream = Server.CreateObject("ADODB.Stream")
		objStream.Open
		objStream.Type = 1
		objStream.LoadFromFile rootPath & "Pds\Board\" & strBoardID & "\" & strFileName

    download = objStream.Read
    RESPONSE.BinaryWrite download
		
		SET objstream = NOTHING

	CASE "3"

		SET objDownload = Server.CreateObject("TABS.Download")

		objDownload.FilePath = rootPath & "Pds\Board\" & strBoardID & "\" & strFileName
		objDownload.TransferFile True, True
		SET objDownload = NOTHING

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>