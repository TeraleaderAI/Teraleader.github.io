<%
	' ***************************************************************************************
	' * 함수설명 : 자바스크립트 메시지 출력                                                 *
	' * 변수설명 : strMsg  = 출력메시지                                                     *
	' *            strExec = 스크립트 처리 (0:이전화면 / 1:창닫기)                          *
	' ***************************************************************************************
	FUNCTION ExecJavaAlert(strMsg, strExec)
		DIM str
		str = "<script language=javascript>" & vbcrlf
		str = str & "alert('" & strMsg & "');" & vbcrlf
		IF strExec = 0 THEN str = str & "history.go(-1);" & vbcrlf ELSE str = str & "self.close();" & vbcrlf
		ExecJavaAlert = str & "</script>" & vbcrlf
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 자바스크립트 실행함수                                                    *
	' * 변수설명 : strValue = 실행할 스크립트 내용                                          *
	' ***************************************************************************************
	FUNCTION ExecJavaScript(strValue)
		DIM str
		IF strValue <> "" AND ISNULL(strValue) = False THEN
			str = "<script language=javascript>" & vbcrlf
			str = str & strValue
			str = str & "</script>" & vbcrlf
		END IF
		ExecJavaScript = str
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 레이어 팝업창 완료 함수                                                  *
	' * 변수설명 : strMsg = 출력메시지                                                      *
	' *            strUrl = 이동할 페이지 URL                                               *
	' ***************************************************************************************
	FUNCTION ExecJavaAlertLayer(strMsg, strUrl)
		DIM str
		str = "<script language=javascript>" & vbcrlf
		IF strMsg <> "" THEN str = str & "alert('" & strMsg & "');" & vbcrlf
		str = str & "parent.document.location.href = '" & strUrl & "';" & vbcrlf
		ExecJavaAlertLayer = str & "</script>" & vbcrlf

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 입력되지 않은 변수 메시지 출력 함수                                      *
	' * 변수설명 : str    = 변수값                                                          *
	' *            strMsg = 출력메시지                                                      *
	' ***************************************************************************************

	FUNCTION GetTrimStrCheck(str, strMsg)
		IF TRIM(str) = "" THEN
			RESPONSE.WRITE ExecJavaAlert(strMsg, 0)
			RESPONSE.End()
		ELSE
			GetTrimStrCheck = TRIM(str)
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 스킨경로 설정                                                            *
	' * 변수설명 : strSkin      = 스킨명                                                    *
	' *            strSkinType  = 스킨타입 (0:게시판 / 1:회원관리)                          *
	' *            strSkinGroup = 스킨그룹                                                  *
	' *            strPath      = 절대경로/상대경로 구분 (0:상대경로 / 1:절대경로)          *
	' ***************************************************************************************
	FUNCTION GetSkinPath(strSkin, strSkinType, strSkinGroup, strPath)
		DIM str
		SELECT CASE strSKinType
		CASE 0 : str = "Skin\Board\"  & strSkinGroup & "\" & strSkin
		CASE 1 : str = "Skin\Member\" & strSkinGroup & "\" & strSkin
		CASE 2 : str = "SKIN\"        & strSkinGroup & "\" & strSkin
		END SELECT
		IF strPath = 1 THEN str = REPLACE(str, "\", "/")
		GetSkinPath = str
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 공백제거 및 작은 쉼표 SQL 저장값으로 변경                                *
	' * 변수설명 : strValue     = 입력값                                                    *
	' *            strSpace = 공백제거 유무 (0:제거안함 / 1:제거함)                         *
	' *            strPath     = 절대경로/상대경로 구분 (0:상대경로 / 1:절대경로)           *
	' ***************************************************************************************
	FUNCTION GetReplaceInput(strValue, strSpace)
		DIM str
		IF strValue <> "" AND ISNULL(strValue) = False THEN
			str = TRIM(REPLACE(strValue,"'","''"))
			IF strSpace = "1" THEN str = RTRIM(LTRIM(str))
			IF strSpace = "S" THEN
				str = REPLACE(str,"'","")
				str = Injection(str)
			END IF
			IF strSpace <> "N" THEN str = GetDeleteTag(str)
		ELSE
			str = strValue
		END IF
		GetReplaceInput = str
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 무단링크 금지                                                            *
	' * 변수설명 : strNotLinkList = 게시판 링크 제한 URL 리스트                             *
	' ***************************************************************************************
	FUNCTION checkBoardLink(strNotLinkList)
		DIM str, I, setUseLink
		str = UCASE(Request.ServerVariables("HTTP_REFERER"))
		str = REPLACE(str, "HTTP://", "")
		IF str = "" THEN
			checkBoardLink = True
		ELSE
			str = SPLIT(str, "/")
			strNotLinkList = SPLIT(strNotLinkList, "|")
			FOR I = 0 TO UBOUND(strNotLinkList)
				IF strNotLinkList(I) <> "" THEN
					IF UCASE(str(0)) = UCASE(strNotLinkList(I)) THEN
						checkBoardLink = False
						EXIT FOR
					END IF
				END IF
			NEXT
		END IF
		IF checkBoardLink = "" THEN checkBoardLink = True
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 접근 제한 아이피 체크                                                    *
	' * 변수설명 : strNotIpList = 접근제한 아이피 리스트                                    *
	' ***************************************************************************************
	FUNCTION checkUserIP(strNotIpList)
		DIM str
		str = Request.Servervariables("REMOTE_ADDR")
		strNotIpList = SPLIT(strNotIpList, "|")

		FOR I = 0 TO UBOUND(strNotIpList)
			IF strNotIpList(I) <> "" THEN
				IF UCASE(str) = UCASE(strNotIpList(I)) THEN
					checkUserIP = False
					EXIT FOR
				END IF
			END IF
		NEXT
		IF checkUserIP = "" THEN checkUserIP = True
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 히든 변수 설정                                                           *
	' * 변수설명 : bitUse     = 기능 사용유무 (True : 사용 / False : 미사용)                *
	'	*            hiddenType = 주석 구분 (0 : <!-- / 0 : -->                               *
	' ***************************************************************************************
	FUNCTION GetToolUseHidden(bitUse, hiddenType)
		IF bitUse = True THEN
			GetToolUseHidden = ""
		ELSE
			IF hiddenType = 0 THEN GetToolUseHidden = "<!--" ELSE GetToolUseHidden = "-->"
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 카테고리 선택 박스                                                       *
	' * 변수설명 : strBoardID  = 게시판 아이디                                              *
	' *            intCategory = 현재 카테고리 값                                           *
	'	*            cType       = 카테고리 구분 (0 : 글쓰기, 1 : 리스트)                     *
	' ***************************************************************************************
	FUNCTION GetBoardCategory(strBoardID, intCategory, cType)
		DIM str, SELECTED
		str = "<select name='intCategory' style='font-size:9pt'"
		IF cType = 1 THEN str = str & " OnChange='OnCategorySelect();'"
		str = str & " class='CateWriteForm'>" & vbcrlf
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CATEGORY] '" & strBoardID & "' ")
		WHILE NOT(RS.EOF)
			IF cType = 2 THEN
				IF INT(intCategory) = INT(RS("intCategory")) THEN
					str = str & "<option value='" & RS("intCategory") & "'" & SELECTED & ">" & RS("strCategory") & "</option>" & vbcrlf
				END IF
			ELSE
				IF intCategory = "" THEN
					SELECTED = ""
				ELSE
					IF INT(intCategory) = INT(RS("intCategory")) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
				END IF
				str = str & "<option value='" & RS("intCategory") & "'" & SELECTED & ">" & RS("strCategory") & "</option>" & vbcrlf
			END IF
		RS.MOVENEXT
		WEND
		str = str & "</select>"
		GetBoardCategory = str
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 파일 사이즈 체크                                                         *
	' * 변수설명 : intSize = 파일크기 (BYTE)                                                *
	' ***************************************************************************************
	FUNCTION GetFilesize(intSize)
		IF intSize <> "" AND ISNULL(intSize) = False THEN
			IF INT(intSize) > 1024000 THEN
				GetFilesize = ROUND((intSize / 1048576) * 1000 / 1000) & " MB"
			ELSEIF INT(intSize) > 1024 THEN
				GetFilesize = ROUND((intSize / 1024) * 10 / 10) & " KB"
			ELSE
				GetFilesize = intSize & " Byte"
			END IF
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 폴더 생성                                                                *
	' * 변수설명 : strPath = 생성할 폴더 경로 및 폴더명                                     *
	' ***************************************************************************************
	FUNCTION ExecFolderMake(strPath)
		DIM FSO, fldr
		SET FSO = CreateObject("Scripting.FileSystemObject")
		IF NOT(fso.FolderExists(strPath)) THEN
			SET fldr = fso.CreateFolder(strPath)
		END IF
		SET FSO = NOTHING
	End Function

	' ***************************************************************************************
	' * 함수설명 : 중복파일 체크                                                            *
	' * 변수설명 : strPath     = 파일을 저장할 경로                                         *
	' *            strFileName = 저장할 파일명                                              *
	' ***************************************************************************************
	FUNCTION checkSameFile(strPath, strFileName)
		strFileName = REPLACE(strFileName, " ", "_")
		strFileName = REPLACE(strFileName, "%", "")

		DIM FSO, strFileNameOnly, strFileExt
		SET FSO = Server.CreateObject("scripting.FileSystemObject")
		IF FSO.fileExists(strPath & strFileName) THEN
			IF InStrRev(strFileName, ".") <> 0 THEN
				strFileNameOnly = LEFT(strFileName,InstrRev(strFileName, ".")-1)
				strFileExt = MID(strFileName, InStrRev(strFileName, "."))
			ELSE
				strFileNameOnly = strFileName
				strFileExt = ""
			END IF

			DIM i
			i = 0
			DO WHILE (1)
				strFileName = strFileNameOnly & "[" & i & "]" & strFileExt
				IF NOT FSO.fileExists(strPath & strFileName) THEN EXIT DO
				i = i + 1
			LOOP
		END IF
		SET FSO = NOTHING
		checkSameFile = strFileName
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 배열값에 대한 특정값 유무 체크                                           *
	' * 변수설명 : strSplit = 전체 배열변수 (,로 구분)                                      *
	' *            strFind  = 찾을 값                                                       *
	' ***************************************************************************************
	FUNCTION GetSplitFindWord(strSplit, strFind)
		IF strSplit <> "" AND ISNULL(strSplit) = False AND strFind <> "" AND ISNULL(strFind) = False THEN
			strSplit = SPLIT(strSplit, ",")
			FOR EACH p IN strSplit
				IF INSTR(strFind, p) > 0 THEN
					GetSplitFindWord = False
					EXIT FUNCTION
				ELSE
					GetSplitFindWord = True
				END IF
			NEXT
		ELSE
			GetSplitFindWord = True
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 저장파일 사이즈 체크 함수                                                *
	' * 변수설명 : setUploadComponet = 업로드 컴포넌트                                      *
	' *            strFileField      = 파일폼                                               *
	' ***************************************************************************************
	FUNCTION ExecFIleUploadSize(setUploadComponet, strFileField)

		SELECT CASE setUploadComponet
		CASE "1" : ExecFIleUploadSize = strFileField.Length
		CASE "2" : ExecFIleUploadSize = strFileField.FIleLen
		CASE "3" : ExecFIleUploadSize = strFileField.FileSize
		END SELECT

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 파일 저장 함수                                                           *
	' * 변수설명 : setUploadComponet = 업로드 컴포넌트 (1 : ABC, 2 : DEXT, 3 : TABS)        *
	' *            strFileField      = 파일폼                                               *
	'	*            intUploadSize     = 업로드 제한 사이즈                                   *
	'	*            strPath           = 저장경로                                             *
	' ***************************************************************************************
	FUNCTION ExecFIleUpload(setUploadComponet, strFileField, intUploadSize, strPath, strUploadNotFile, bitUploadReplaceFile, strUploadReplaceFile, bitThrum, intThrumWidth, intThrumHeight, bitThrumScale, strThrumProg, bitUseWaterMark, strWaterMarkType, strWaterMarkCont)

		DIM bitNext, nowFileSize, nowFileName, FileExe, strSaveFIleName, strFileNameOnly, I, strUploadNotFileTmp

		SELECT CASE setUploadComponet
		CASE "1"
			nowFileSize = strFileField.Length
			nowFileName = strFileField.SafeFileName
		CASE "2"
			nowFileSize = strFileField.FIleLen
			nowFileName = strFileField.FileName
		CASE "3"
			nowFileSize = strFileField.FileSize
			nowFileName = strFileField.FileName
		END SELECT

		IF nowFileName = "" OR ISNULL(nowFileName) = True THEN

			ExecFIleUpload = False

		ELSE

			IF INT(nowFileSize) < INT(intUploadSize) THEN
	
				strSaveFIleName = checkSameFile(strPath, nowFileName)
				FileExe = REPLACE(MID(strSaveFIleName, INSTRREV(strSaveFIleName, ".") + 1), ".", "")
				strFileNameOnly = REPLACE(LEFT(strSaveFIleName, INSTRREV(strSaveFIleName, ".") - 1), "'", "")
				IF LEN(strFileNameOnly) > 60 THEN strFileNameOnly = LEFT(strFileNameOnly, 60)

				IF strUploadNotFile <> "" AND ISNULL(strUploadNotFile) = False THEN
					strUploadNotFileTmp = SPLIT(strUploadNotFile, ",")
					FOR I = 0 TO UBOUND(strUploadNotFileTmp)
						IF UCASE(FileExe) = UCASE(strUploadNotFileTmp(I)) THEN
							ExecFIleUpload = False
							EXIT FOR
							EXIT FUNCTION
						END IF
					NEXT					
				END IF
	
				IF bitUploadReplaceFile = True THEN
					IF strUploadReplaceFile <> "" AND ISNULL(strUploadReplaceFile) = False THEN
						DIM strUploadReplaceFileTemp
						strUploadReplaceFileTemp = SPLIT(strUploadReplaceFile, ",")
						FOR I = 0 TO UBOUND(strUploadReplaceFileTemp)
							IF UCASE(FileExe) = UCASE(strUploadReplaceFileTemp(I)) THEN
								IF UCASE(strUploadReplaceFileTemp(I)) = UCASE(FileExe) THEN
									strSaveFIleName = strFileNameOnly & ".txt"
									EXIT FOR
								END IF
							END IF 
						NEXT
					END IF
				END IF
	
				CALL ExecFolderMake(strPath)

				strSaveFIleName = REPLACE(GetReplaceInput(strSaveFIleName, ""), "'", "_")

				SELECT CASE setUploadComponet
				CASE "1" : strFileField.SAVE strPath & strSaveFIleName
				CASE "2" : strFileField.saveAS strPath & strSaveFIleName
				CASE "3" : strFileField.SAVEAS strPath & strSaveFIleName
				END SELECT
	
				SELECT CASE UCASE(FileExe)
				CASE "JPG", "GIF", "BMP", "PNG", "TIF"

					IF bitUseWaterMark = True THEN
						CALL DextWaterMark(strSaveFIleName, strPath, strWaterMarkType, strWaterMarkCont, setUploadComponet)
					END IF

					IF bitThrum = True THEN
						SELECT CASE strThrumProg
						CASE "1"
							CALL NanumiThrum(strSaveFIleName, strPath, intThrumWidth, intThrumHeight, bitThrumScale)
						CASE "2"
							CALL DextThrum(strSaveFIleName, strPath, intThrumWidth, intThrumHeight, bitThrumScale)
						END SELECT
					END IF
				END SELECT
	
				ExecFIleUpload = strSaveFIleName
	
			ELSE

				ExecFIleUpload = False

			END IF

		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 썸네일 저장 함수                                                         *
	' * 변수설명 : strFileName    = 저장된 파일명                                           *
	'	*            strPath        = 저장경로                                                *
	'	*            intThrumWidth  = 썸네일 너비                                             *
	'	*            intThrumHeight = 썸네일 높이                                             *
	'	*            bitThrumScale  = 원본비율 유지 유무 (True : 유지, False : 미유지         *
	' ***************************************************************************************
	FUNCTION NanumiThrum(strFileName, strPath, intThrumWidth, intThrumHeight, bitThrumScale)
		DIM FileExe, oImg, Image
		On Error Resume Next
		FileExe = REPLACE(MID(strFileName, INSTRREV(strFileName, ".") + 1), ".", "")
		SELECT CASE UCASE(FileExe)
		CASE "JPG", "GIF", "BMP", "PNG", "TIF"
			SET oImg = Server.CreateObject("Nanumi.ImagePlus")
			IF NOT IsObject(oImg) THEN
				NanumiThrum = False
			ELSE
				SET Image = Server.CreateObject("Nanumi.ImagePlus")
				Image.OpenImageFile strPath & strFileName
				Image.KeepAspect = bitThrumScale
				Image.ChangeSize intThrumWidth, intThrumHeight
				Image.SaveFile strPath & "Thrum\" & strFileName
				Image.KeepAspect = bitThrumScale
				Image.ChangeSize 50, 40
				Image.SaveFile strPath & "Small\" & strFileName
				Image.Dispose
				NanumiThrum = strFileName
				SET Image = NOTHING
			END IF
		CASE ELSE
			NanumiThrum = False
		END SELECT
	END Function

	FUNCTION DextThrum(strFileName, strPath, intThrumWidth, intThrumHeight, bitThrumScale)

		SET objImage = SERVER.CREATEOBJECT("DEXT.ImageProc")

		IF True = objImage.SetSourceFile(strPath & strFileName) THEN

			tmpFile = objImage.SaveasThumbnail(strPath & "Thrum\" & strFileName, intThrumWidth, intThrumHeight, false)
			tmpFile = objImage.SaveasThumbnail(strPath & "Small\" & strFileName, 50, 40, false)

			DextThrum = strFileName

		ELSE

			DextThrum = False

		END IF

		SET objImage = NOTHING

	END FUNCTION

	FUNCTION DextWaterMark(strFIleName, strPath, strWaterMarkType, strWaterMarkCont, setUploadComponet)

		strWaterMarkContTemp = SPLIT(strWaterMarkCont, "|")

		CALL ExecFolderMake(strPath & "Temp")
		CALL ExecFolderMake(strPath & "WaterMark")

		IF setUploadComponet = "2" THEN
			SET objImage = SERVER.CreateObject("DEXT.ImageProc")
			IF true = objImage.SetSourceFile(strPath & strFileName) THEN
			SELECT CASE strWaterMarkType
				CASE "1" : tmpFile = objImage.SaveAsWatermarkImage("/" & REPLACE(LCASE(httpPath), LCASE(sitePath), "") & "Pds/Board/" & strWaterMarkContTemp(0) & "/WaterMark/" & strWaterMarkContTemp(1), strPath & "Temp\" & strFileName,strWaterMarkContTemp(3), strWaterMarkContTemp(4),true) 
				CASE "2"
					tmpFile = objImage.SaveAsWatermarkText(strWaterMarkContTemp(2), strPath & "Temp\" & strFileName, strWaterMarkContTemp(3),strWaterMarkContTemp(4),strWaterMarkContTemp(5),True)
				END SELECT
				CALL ExecFileDelete(strPath, strFileName)
				CALL ExecDefaultFileCopy(strPath & "Temp\" & strFileName, strPath & strFileName)
				DextWaterMark = tmpFile
			ELSE
				DextWaterMark = False
			END IF
		ELSE
			DextWaterMark = False
		END IF

		SET objImage = NOTHING

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 이미지 파일 체크                                                         *
	' * 변수설명 : strFileName    = 저장된 파일명                                           *
	' ***************************************************************************************
	FUNCTION checkImageFile(strFileName)
		DIM FileExe
		FileExe = REPLACE(MID(strFileName, INSTRREV(strFileName, ".") + 1), ".", "")
		SELECT CASE UCASE(FileExe)
		CASE "JPG", "GIF", "BMP", "PNG", "TIF"
			checkImageFile = True
		CASE ELSE
			checkImageFile = False
		END SELECT
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 이미지 파일 체크                                                         *
	' * 변수설명 : strFileName    = 저장된 파일명                                           *
	' ***************************************************************************************
	FUNCTION checkImageFileField(setUploadComponet, strField)

		DIM strFileName

		SELECT CASE setUploadComponet
		CASE "1" : strFileName = strField.SafeFileName
		CASE "2" : strFileName = strField.FileName
		CASE "3" : strFileName = strField.FileName
		END SELECT

		IF strFileName = "" OR ISNULL(strFileName) = True THEN
			checkImageFileField = False
		ELSE
			DIM FileExe
			FileExe = REPLACE(MID(strFileName, INSTRREV(strFileName, ".") + 1), ".", "")
			SELECT CASE UCASE(FileExe)
			CASE "JPG", "GIF", "BMP", "PNG", "TIF"
				checkImageFileField = True
			CASE ELSE
				checkImageFileField = False
			END SELECT
		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 플래시 파일 체크                                                         *
	' * 변수설명 : strFileName    = 저장된 파일명                                           *
	' ***************************************************************************************
	FUNCTION checkFlashFileField(setUploadComponet, strField)

		DIM strFileName

		SELECT CASE setUploadComponet
		CASE "1" : strFileName = strField.SafeFileName
		CASE "2" : strFileName = strField.FileName
		CASE "3" : strFileName = strField.FileName
		END SELECT

		IF strFileName = "" OR ISNULL(strFileName) = True THEN
			checkFlashFileField = False
		ELSE
			DIM FileExe
			FileExe = REPLACE(MID(strFileName, INSTRREV(strFileName, ".") + 1), ".", "")
			IF UCASE(FileExe) = "SWF" THEN checkFlashFileField = True ELSE checkFlashFileField = False
		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 엑셀 파일 체크                                                         *
	' * 변수설명 : strFileName    = 저장된 파일명                                           *
	' ***************************************************************************************
	FUNCTION checkExcelFileField(setUploadComponet, strField)

		DIM strFileName

		SELECT CASE setUploadComponet
		CASE "1" : strFileName = strField.SafeFileName
		CASE "2" : strFileName = strField.FileName
		CASE "3" : strFileName = strField.FileName
		END SELECT

		IF strFileName = "" OR ISNULL(strFileName) = True THEN
			checkImageFileField = False
		ELSE
			DIM FileExe
			FileExe = REPLACE(MID(strFileName, INSTRREV(strFileName, ".") + 1), ".", "")
			SELECT CASE UCASE(FileExe)
			CASE "XLS"
				checkExcelFileField = True
			CASE ELSE
				checkExcelFileField = False
			END SELECT
		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 뮤직 파일 체크                                                           *
	' * 변수설명 : strFileName    = 저장된 파일명                                           *
	' ***************************************************************************************
	FUNCTION checkMusicFile(setUploadComponet, strField)
		DIM FileExe, strFileName

		SELECT CASE setUploadComponet
		CASE "1" : strFileName = strField.SafeFileName
		CASE "2" : strFileName = strField.FileName
		CASE "3" : strFileName = strField.FileName
		END SELECT

		FileExe = REPLACE(MID(strFileName, INSTRREV(strFileName, ".") + 1), ".", "")
		SELECT CASE UCASE(FileExe)
		CASE "MP3", "WAV", "MID", "WMA", "ASF", "ASX", "SWF"
			checkMusicFile = True
		CASE ELSE
			checkMusicFile = False
		END SELECT
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 폼 서브밋 함수                                                           *
	' * 변수설명 : strMsg = 출력 메시지                                                     *
	'	*            strUrl = 이동할 경로                                                     *
	' ***************************************************************************************
	Function ExecFormSubmit(strMsg, strUrl, strTarget)
		str = "<form name=theForm method=post>" & vbcrlf
		str = str & "</form>" & vbcrlf
		str = str & "<script language=javascript>" & vbcrlf
		IF strMsg <> "" THEN str = str & "alert('" & strMsg & "');" & vbcrlf
		str = str & "document.theForm.action='" & strUrl & "';" & vbcrlf
		IF strTarget <> "" AND ISNULL(strTarget) = False THEN str = str & "document.theForm.target='" & strTarget & "';" & vbcrlf
		str = str & "document.theForm.submit();" & vbcrlf
		str = str & "</script>" & vbcrlf
		ExecFormSubmit = str
	END Function

	' ***************************************************************************************
	' * 함수설명 : 폼 서브밋 함수 (히든변수 포함)                                           *
	' * 변수설명 : strMsg = 출력 메시지                                                     *
	'	*            strUrl = 이동할 경로                                                     *
	' ***************************************************************************************
	Function ExecFormSubmitHidden(strMsg, strHidden, strUrl, strTarget)
		str = "<form name=theForm method=post>" & vbcrlf
		IF strHidden <> "" THEN str = str & strHidden
		str = str & "</form>" & vbcrlf
		str = str & "<script language=javascript>" & vbcrlf
		IF strMsg <> "" THEN str = str & "alert('" & strMsg & "');" & vbcrlf
		str = str & "document.theForm.action='" & strUrl & "';" & vbcrlf
		IF strTarget <> "" AND ISNULL(strTarget) = False THEN str = str & "document.theForm.target='" & strTarget & "';" & vbcrlf
		str = str & "document.theForm.submit();" & vbcrlf
		str = str & "</script>" & vbcrlf
		ExecFormSubmitHidden = str
	END Function

	' ***************************************************************************************
	' * 함수설명 : 폼 서브밋 함수 (부모창으로 링크)                                         *
	' * 변수설명 : strMsg = 출력 메시지                                                     *
	'	*            strUrl = 이동할 경로                                                     *
	' ***************************************************************************************
	Function ExecFormSubmitClose(strMsg, strUrl)
		str = "<script language=javascript>" & vbcrlf
		IF strMsg <> "" THEN str = str & "alert('" & strMsg & "');" & vbcrlf
		str = str & "opener.location.href='" & strUrl & "';" & vbcrlf
		str = str & "self.close();" & vbcrlf
		str = str & "</script>" & vbcrlf
		ExecFormSubmitClose = str
	END Function

	' ***************************************************************************************
	' * 함수설명 : 문자 길이 체크                                                           *
	' * 변수설명 : str = 문자                                                               *
	' ***************************************************************************************
	FUNCTION STRLen(str)
		IF str <> "" AND ISNULL(str) = False THEN
			DIM I
			STRLen = 0
			FOR I = 1 TO len(str)
				IF ASC(MID(str, I, 1)) < 0 THEN STRLen = STRLen + 2 ELSE STRLen = STRLen + 1
			NEXT
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 문자 좌측 길이                                                           *
	' * 변수설명 : str = 문자                                                               *
	' *            num = 길이                                                               *
	' ***************************************************************************************
	FUNCTION STRLeft(str, num)
		DIM num2, I
		num2 = 0

		FOR I = 1 TO LEN(str)
			IF ASC(MID(str, I, 1)) < 0 THEN
				STRLeft = STRLeft & MID(str, I, 1)
					num2 = num2 + 2
			ELSE
				STRLeft = STRLeft & MID(str, I, 1)
				num2 = num2 + 1
			END IF
			IF num2 >= num THEN EXIT FOR
		NEXT
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 문자 길이 컷트                                                           *
	' * 변수설명 : str = 문자                                                               *
	' *            num = 길이                                                               *
	' ***************************************************************************************
	FUNCTION GetCutSubject(str, num)
		IF num = "0" THEN
			GetCutSubject = str
		ELSE
			IF STRLen(str) > num THEN GetCutSubject = STRLeft(str, num - 2) & ".." ELSE GetCutSubject = str
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 정렬 반환 함수                                                           *
	' * 변수설명 : str = 정렬타입                                                           *
	' ***************************************************************************************
	FUNCTION GetAlignSet(strType)
		SELECT CASE strType
		CASE "0" : GetAlignSet = "LEFT"
		CASE "1" : GetAlignSet = "CENTER"
		CASE "2" : GetAlignSet = "RIGHT"
		END SELECT	
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 날짜 출력 표시 설정                                                      *
	' * 변수설명 : str = 문자                                                               *
	' *            num = 길이                                                               *
	' ***************************************************************************************
	FUNCTION GetDateType(strType, strDate)
		IF strDate <> "" AND ISNULL(strDate) = False THEN
			SELECT CASE strType
			CASE 0
				GetDateType = REPLACE(FORMATDATETIME(strDate, 2), "-", "/") & "&nbsp;" & REPLACE(FORMATDATETIME(strDate, 4), "-", "/")
			CASE 1
				GetDateType = REPLACE(FORMATDATETIME(strDate, 2), "-", "/")
			CASE 2
				GetDateType = MONTH(strDate) & "/" & DAY(strDate)
			CASE 3
				GetDateType = MONTH(strDate) & "/" & DAY(strDate) & "&nbsp;" & REPLACE(FORMATDATETIME(strDate, 4), "-", "/")
			CASE 4
				GetDateType = DAY(strDate) & "&nbsp;" & REPLACE(FORMATDATETIME(strDate, 4), "-", "/")
			CASE 5
				GetDateType = REPLACE(FORMATDATETIME(strDate, 2), "-", "/") & "&nbsp;" & REPLACE(FORMATDATETIME(strDate, 4), "-", "/") & ":" & SECOND(strDate)
			END SELECT
		ELSE
			GetDateType = strDate
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 16진수를 10진수로 바꾸는 함수                                            *
	' * 변수설명 : str = 16진수값                                                           *
	' ***************************************************************************************
	FUNCTION Hex2Dec(num)
		Dim hexNum
		hexNum = num
		Hex2Dec = Int("&H" & hexNum)

	End Function

	' ***************************************************************************************
	' * 함수설명 : 10진수를 2진수로 바꾸는 함수                                             *
	' * 변수설명 : str = 10진수값                                                           *
	' ***************************************************************************************	
	FUNCTION Dec2Hex(num)
		DIM str10, str16, en
		str10 = "0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19"
		str10 = SPLIT(str10, "|")
		str16 = "0|1|2|3|4|5|6|7|8|9|A|B|C|D|E|F|10|11|12|13"
		str16 = SPLIT(str16, "|")

		Dec2Hex = str16(INT(num / 16))
		en = num mod 16
		Dec2Hex = Dec2Hex & str16(en)

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 그라데이션 관련 함수                                                     *
	' * 변수설명 : intCount = 누적값                                                        *
	' *            strColor = 기본색상                                                      *
	' *            intRgb1  = RGB 변환값                                                    *
	' *            intRgb2  = RGB 변환값                                                    *
	' *            intRgb3  = RGB 변환값                                                    *
	' ***************************************************************************************	
	FUNCTION GetGrColor(intCount, strColor, intRgb1, intRgb2, intRgb3)
		DIM strRgb(2)
		strColor = REPLACE(strColor, "#", "")
		strRgb(0) = INT(Hex2Dec(LEFT(strColor, 2))) + (intRgb1 * intCount)
		strRgb(1) = INT(Hex2Dec(MID(strColor, 3, 2))) + (intRgb2 * intCount)
		strRgb(2) = INT(Hex2Dec(RIGHT(strColor, 2))) + (intRgb3 * intCount)
		GetGrColor = "#" & Dec2Hex(strRgb(0)) & Dec2Hex(strRgb(1)) & Dec2Hex(strRgb(2))
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시판 리스트 아이콘 설정 함수                                           *
	' * 변수설명 : iType = 아이콘 구분                                                      *
	' *            iName = 아이콘 파일명                                                    *
	' ***************************************************************************************
	FUNCTION GetListIcon(iType, iName)
		IF iName = "" OR ISNULL(iName) = True THEN GetListIcon = "" ELSE GetListIcon = "Pds/Board/Icon/" & iType & "/" & iName
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 신규 게시물 시간 체크                                                    *
	' * 변수설명 : intTime = 신규 게시물 출력 시간                                          *
	' ***************************************************************************************
	FUNCTION GetNewBoardTime(intTime, strRegDate)
		IF intTime = 0 THEN
			GetNewBoardTime = False
		ELSE
			IF INT(DATEDIFF("h", strRegDate, NOW)) < INT(intTime) THEN GetNewBoardTime = True ELSE GetNewBoardTime = False
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 검색단어 색상 변환함수                                                   *
	' * 변수설명 : str   = 검색할 전체 값                                                   *
	' *            sWord = 검색단어                                                         *
	' *            sTag  = 변환 태그                                                        *
	' ***************************************************************************************
	FUNCTION GetChangeSearchTag(str, sWord, sTag)
		IF sTag <> "" AND ISNULL(sTag) = False THEN GetChangeSearchTag = REPLACE(str, sWord, REPLACE(sTag, "{KEY}", sWord)) ELSE GetChangeSearchTag = str
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 업로드 파일 실행 함수                                                    *
	' * 변수설명 : bitFileExe   = 업로드 파일 실행 유무                                     *
	' *            strBoardID   = 게시판 아이디                                             *
	' *            strFileName  = 업로드 파일명                                             *
	' *            intExeWidth  = 실행할 파일의 너비                                        *
	' *            intExeHeight = 실행할 파일의 높이                                        *
	' *            intFile      = 파일구분 (1:첫번째 파일, 2:두번째 파일                    *
	' ***************************************************************************************
	FUNCTION GetUploadFileExe(bitFileExe, strBoardID, strFileName, intExeWidth, intExeHeight, intImgWidth, intImgHeight)
		IF bitFileExe = False THEN
			GetUploadFileExe = False
		ELSE
			IF strFileName = "" OR ISNULL(strFileName) = True THEN
				GetUploadFileExe = False
			ELSE
				DIM strFileExt
				strFileExt = REPLACE(MID(strFileName, InStrRev(strFileName, ".")), ".", "")
				SELECT CASE UCASE(strFileExt)
				CASE "SWF"
					GetUploadFileExe = "<embed src='Pds/Board/" & strBoardID & "/" & strFileName & "' width='" & intExeWidth & "' height='" & intExeHeight & "'>"
				CASE "WAV", "MP3"
					GetUploadFileExe = "<bgsound src='Pds/Board/" & strBoardID & "/" & strFileName & "'>"
				CASE "ASF", "ASX", "AVI", "WMV", "WMA"
					GetUploadFileExe = "<OBJECT ID='MPlay2' CLASSID='CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6' standby='Loading Windows Media Player components...' width='" & intExeWidth & "' height='" & intExeHeight & "'>" & vbcrlf
					GetUploadFileExe = GetUploadFileExe & "<PARAM NAME='URL' VALUE='Pds/Board/" & strBoardID & "/" & strFileName & "'>" & vbcrlf
					GetUploadFileExe = GetUploadFileExe & "<PARAM NAME='AutoStart' VALUE='True'>" & vbcrlf
					GetUploadFileExe = GetUploadFileExe & "<PARAM NAME='UIMode' VALUE='full'>" & vbcrlf
					GetUploadFileExe = GetUploadFileExe & "</OBJECT>"
				CASE ELSE
					GetUploadFileExe = False
				END SELECT
			END IF
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 업로드 파일 다운로드 링크                                                *
	' * 변수설명 : strFileName = 업로드 파일명                                              *
	' *            strBoardID  = 게시판 아이디                                              *
	' *            intSeq      = 게시글 고유번호                                            *
	' *            intFile     = 파일구분 (1:첫번째 파일, 2:두번째 파일                     *
	' ***************************************************************************************
	FUNCTION GetUploadFileDownLink(strFileName, strBoardID, intSeq, intFile)
		IF strFileName = "" OR ISNULL(strFileName) = True THEN GetUploadFileDownLink = False ELSE GetUploadFileDownLink = "/mboard.asp?Action=filedown&strBoardID=" & strBoardID & "&intSeq=" & intSeq & "&intFile=" & intFile
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 일련번호 2자리 변환함수                                                  *
	' * 변수설명 : str = 일련번호                                                           *
	' ***************************************************************************************
	FUNCTION GetNumberZero(str)
		IF LEN(str) = 1 THEN str = "0" & str
		GetNumberZero = str
	End Function

	' ***************************************************************************************
	' * 함수설명 : 지역번호 및 휴대폰 번호 코드 구성 함수                                   *
	' * 변수설명 : strType = 번호 구분 (tel : 전화번호, mobile : 휴대폰 번호                *
	' *            setCode = 선택된 코드                                                    *
	' ***************************************************************************************
	Function GetPhoneMobileSelect(strType, setCode)
		DIM str, strDIM1, strDIM2, I
		str = str & "<option value=''>선택하세요</option>" & vbcrlf

		SELECT CASE strType
		CASE "tel"
			strDIM1 = "02,031,032,033,041,042,043,0502,0505,051,052,053,054,055,061,062,063,064,070,00"
			strDIM2 = "서울 (02),경기 (031),인천 (032),강원 (033),충남 (041),대전 (042),충북 (043),Dacom(0502),KT (0505),부산 (051),울산 (052),대구 (053),경북 (054),경남 (055),전남 (061),광주 (062),전북 (063),제주 (064),인터넷전화 (070),없음"
		CASE "mobile"
			strDIM1 = "010,011,013,016,017,018,019,0502,0505,0506,00"
			strDIM2 = "010,011,013,016,017,018,019,0502,0505,0506,없음"
		CASE "all"
			strDIM1 = "02,031,032,033,041,042,043,0502,0505,051,052,053,054,055,061,062,063,064,070,010,011,013,016,017,018,019,0502,0505,0506,00"
			strDIM2 = "서울 (02),경기 (031),인천 (032),강원 (033),충남 (041),대전 (042),충북 (043),Dacom(0502),KT (0505),부산 (051),울산 (052),대구 (053),경북 (054),경남 (055),전남 (061),광주 (062),전북 (063),제주 (064),인터넷전화 (070),010,011,013,016,017,018,019,0502,0505,0506,없음"
		END SELECT

		strDIM1 = SPLIT(strDIM1, ",")
		strDIM2 = SPLIT(strDIM2, ",")
		FOR I = 0 TO UBOUND(strDIM1)
			IF strDIM1(I) = setCode THEN SELECTED = " SELECTED " ELSE SELECTED = ""
			str = str & "<option value='" & strDIM1(I) & "'" & SELECTED & ">" & strDIM2(I) & "</option>" & vbcrlf
		NEXT

		GetPhoneMobileSelect = str
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : Radio Form 구성 함수                                                     *
	' * 변수설명 : strForm      = 폼 이름                                                   *
	' *            dimStr       = 폼 배열 값                                                *
	' *            Tag          = 태그변수                                                  *
	' *            setValue     = 선택된 배열값                                             *
	' *            intLineCount = 한줄에 출력될 폼 값의 개수                                *
	' ***************************************************************************************
	FUNCTION GetRadioForm(strForm, dimStr, Tag, setValue, intLineCount)
		Dim str, I, SELECTED, iCount
		str = ""
		IF dimStr <> "" AND ISNULL(dimStr) = False THEN
			dimStr = SPLIT(dimStr, CHR(13)&CHR(10))
			iCount = 0
			FOR I = 0 TO UBOUND(dimStr)
				iCount = iCount + 1
				IF TRIM(dimStr(I)) = TRIM(setValue) THEN SELECTED = " CHECKED " ELSE SELECTED = ""
				IF TRIM(dimStr(I)) <> "" THEN str = str & "<input type='radio' name='" & strForm & "' id='" & strForm & I & "' value='" & dimStr(I) & "' style='border:none; height:auto;'" & SELECTED & "><LABEL FOR=" & strForm & I & " style='cursor:hand;'>" & dimStr(I) & "</LABEL>" & Tag
				IF INT(intLineCount) = INT(iCount) THEN
					str = str & "<br>"
					iCount = 0
				END IF
			NEXT
		END IF
		GetRadioForm = str
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : Select Form 구성 함수                                                    *
	' * 변수설명 : dimStr   = 폼 배열 값                                                    *
	' *            setValue = 선택된 배열값                                                 *
	' ***************************************************************************************
	Function GetSelectForm(dimStr, setValue)
		Dim str, I, SELECTED
		str = ""
		IF dimStr <> "" AND ISNULL(dimStr) = False THEN
			str = str & "<option value=''>선택해 주세요</option>"
			dimStr = SPLIT(dimStr, CHR(13)&CHR(10))
			FOR I = 0 TO UBOUND(dimStr)
				IF TRIM(dimStr(I)) = TRIM(setValue) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
				IF TRIM(dimStr(I)) <> "" THEN str = str & "<option value='" & dimStr(I) & "'" & SELECTED & ">" & dimStr(I) & "</option>"
			NEXT
		END IF
		GetSelectForm = str
	End Function

	' ***************************************************************************************
	' * 함수설명 : CheckBox Form 구성 함수                                                  *
	' * 변수설명 : strFotm  = 폼이름                                                        *
	' *            dimStr   = 폼 배열 값                                                    *
	' *            Tag      = 태그변수                                                      *
	' *            setValue = 선택된 배열값                                                 *
	' ***************************************************************************************
	Function GetCheckboxForm(strForm, dimStr, Tag, setValue)
		Dim str, I, SELECTED, J
		str = ""
		IF dimStr <> "" AND ISNULL(dimStr) = False THEN
			dimStr = SPLIT(dimStr, CHR(13)&CHR(10))
			FOR I = 0 TO UBOUND(dimStr)
				IF (INSTR(setValue, dimStr(I)) <= 0) THEN SELECTED = "" ELSE SELECTED = " CHECKED "
				IF TRIM(dimStr(I)) <> "" THEN str = str & "<input type='checkbox' name='" & strForm & "' id='" & strForm & I & "' value='" & dimStr(I) & "' style='border:none; height:auto;'" & SELECTED & "><LABEL FOR=" & strForm & I & " style='cursor:hand;'>" & dimStr(I) & "</LABEL>" & Tag
			NEXT
		END IF
		GetCheckboxForm = str
	End Function

	' ***************************************************************************************
	' * 함수설명 : BIT Form 구성 함수                                                       *
	' * 변수설명 : strFotm  = 폼이름                                                        *
	' *            dimStr   = 폼 배열 값                                                    *
	' *            Tag      = 태그변수                                                      *
	' *            setValue = 선택된 배열값                                                 *
	' ***************************************************************************************
	FUNCTION GetBitForm(strForm, dimStr, Tag, setValue)

		Dim str, I, SELECTED, J, iCount
		str    = ""
		IF setValue = "" THEN setValue = 1
		IF dimStr <> "" AND ISNULL(dimStr) = False THEN
			dimStr = SPLIT(dimStr, CHR(13)&CHR(10))
			FOR I = 0 TO 1
				str = str & "<input type='radio' name='" & strForm & "' id='" & strForm & I & "' style='border:none; height:auto;' value='"
				IF I = 0 THEN str = str & "1" ELSE str = str & "0"
				str = str & "'"
				IF I = 0 AND setValue = 1 THEN str = str & " CHECKED "
				IF I = 1 AND setValue = 0 THEN str = str & " CHECKED "
				 str = str & "><LABEL FOR=" & strForm & I & " style='cursor:hand;'>" & dimStr(I) & "</LABEL>" & Tag
				IF I = 1 THEN EXIT FOR
			NEXT
		END IF
		GetBitForm = str
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : BIT값 변환함수                                                           *
	' * 변수설명 : strBit = 변환될 변숙값 (True 또는 False                                  *
	' ***************************************************************************************
	FUNCTION GetTrueFalse(strBit)
		IF strBit = True THEN GetTrueFalse = "1" ELSE GetTrueFalse = "0"
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 파일유무 체크 함수                                                       *
	' * 변수설명 : strPath     : 삭제할 파일의 경로                                         *
	' *            strFileName : 삭제할 파일의 이름                                         *
	' ***************************************************************************************
	FUNCTION GetFileExists(strPath, strFileName)
		Dim FSO, strfile
		SET FSO = Server.CreateObject("scripting.FileSystemObject")
		strfile = strPath & strFileName
		IF fso.FileExists(strfile) THEN GetFileExists = True ELSE GetFileExists = False
		SET FSO = NOTHING
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 파일삭제 함수                                                            *
	' * 변수설명 : strPath     : 삭제할 파일의 경로                                         *
	' *            strFileName : 삭제할 파일의 이름                                         *
	' ***************************************************************************************
	FUNCTION ExecFileDelete(strPath, strFileName)
		Dim FSO, strfile
		SET FSO = Server.CreateObject("scripting.FileSystemObject")
		strfile = strPath & strFileName
		IF fso.FileExists(strfile) THEN fso.DeleteFile(strfile)
		SET FSO = NOTHING
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 폴더 리스트 변환 또는 개수 파악 함수                                     *
	' * 변수설명 : strPath     : 경로                                                       *
	' *            setFolder : 선택된 폴더명                                                *
	' *            sType : 구분 (count = 개수 파악)                                         *
	' ***************************************************************************************
	FUNCTION GetFolderList(strPath, setFolder, sType)
		DIM FSO, F, F1, S, SF, SELECTED, iCount
		SET FSO = CreateObject("Scripting.FileSystemObject")
		SET F = FSO.GetFolder(strPath)
		SET SF = F.SubFolders

		FOR EACH F1 IN SF
			IF setFolder = "" THEN setFolder = F1.NAME
			iCount = iCount + 1
			SELECT CASE sType
			CASE "skin"
				IF UCASE(F1.NAME) = UCASE(setFolder) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
				S = S & "<option value=" & F1.NAME & SELECTED & ">" & F1.NAME & "</option>" & vbcrlf
			CASE "file"
				S = S & F1.NAME & "|"
			END SELECT
		NEXT
		IF iCount = "" THEN iCount = 0
		IF sType = "count" THEN GetFolderList = iCount ELSE GetFolderList = S
	END Function

	' ***************************************************************************************
	' * 함수설명 : 폴더 삭제 함수                                                           *
	' * 변수설명 : path : 경로                                                              *
	' ***************************************************************************************
	FUNCTION ExecFolderDelete(path)
		DIM FSO
		SET FSO = CreateObject("Scripting.FileSystemObject")
		IF (FSO.FolderExists(path)) THEN FSO.DeleteFolder(path)
		SET FSO = NOTHING
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 폴더 크기 반환 함수                                                      *
	' * 변수설명 : str : 경로                                                               *
	' ***************************************************************************************
	FUNCTION GetFolderSize(str)
		DIM FSO, F, S
		SET FSO = CreateObject("Scripting.FileSystemObject")
		SET F = FSO.GetFolder(str)
		S = F.SIZE
		GetFolderSize = S
		SET FSO = NOTHING
		SET F   = NOTHING
	End Function

	' ***************************************************************************************
	' * 함수설명 : 파일 리스트 출력 함수                                                    *
	' * 변수설명 : strPath : 경로                                                           *
	' *            sType   : 구분                                                           *
	' ***************************************************************************************
	FUNCTION GetFileList(strPath, sType)

		DIM FSO, F, F1, S, SF
		SET FSO = CreateObject("Scripting.FileSystemObject")
		SET F = FSO.GetFolder(strPath)
		SET SF = F.Files

		FOR EACH F1 IN SF
			SELECT CASE sType
			CASE "file"
				S = S & F1.NAME & "|"
			END SELECT
		NEXT
		GetFileList = S
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 체크박스 폼 전송값 반환함수                                              *
	' * 변수설명 : str : 체크폼의 REQUEST 값                                                *
	' ***************************************************************************************
	FUNCTION GetCheckBoxRequest(str)
		IF str = "" THEN GetCheckBoxRequest = "0" ELSE GetCheckBoxRequest = "1"
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 폼메일 발송 함수                                                         *
	' * 변수설명 : strSendName    : 보내는 사람 이름                                        *
	' *            strSendMail    : 보내는 사람의 메일주소                                  *
	' *            strRecvName    : 받는 사람 이름                                          *
	' *            strRecvMail    : 받는 사람의 메일주소                                    *
	' *            strSubject     : 메일 제목                                               *
	' *            strContent     : 메일내용                                                *
	' *            strRecvBccMail : 참조                                                    *
	' *            strRecvCcMail  : 숨은참조                                                *
	' *            sendFileName1  : 첨부파일 #1                                             *
	' *            sendFileName2  : 첨부파일 #2                                             *
	' ***************************************************************************************
	FUNCTION sendEmail(strSendName, strSendMail, strRecvName, strRecvMail, strSubject, strContent, strRecvBccMail, strRecvCcMail, sendFileName1, sendFileName2)

		Const cdoSendUsingPort = 1  '1일 경우 로컬(SMTP), 2일 경우 외부(SMTP)로 메일전송
		Const strSmartHost = "MySmartHostServer" 			'Host 설정
		Const strRoot = "C:\Inetpub\mailroot\Pickup"

		SET objMail = Server.CreateObject("CDO.Message")
		SET iConf = objMail.Configuration

		With iConf.Fields
		 .item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort
		 .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory") = strRoot
		 .item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = strSmartHost
		 .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 30
		 .Update
		End With

		objMail.From = strSendName & "<" & strSendMail & ">"
		objMail.ReplyTo = tomail
		objMail.To = strRecvName & "<" & strRecvMail & ">"
		IF strRecvBccMail <> "" THEN objMail.Bcc = strRecvBccMail
		IF strRecvCcMail  <> "" THEN objMail.cc  = strRecvCcMail
		objMail.Subject = strSubject
		objMail.HTMLBody = strContent
		IF sendFileName1 <> "" THEN objMail.AddAttachment(sendFileName1)
		IF sendFileName2 <> "" THEN objMail.AddAttachment(sendFileName2)
		objMail.SEND

		SET Fields    = NOTHING
		SET objMail   = NOTHING
		SET objConfig = NOTHING
		SET iConf     = NOTHING

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 회원관련 메일 발송                                                       *
	' * 변수설명 : strLoginID : 회원아이디                                                  *
	' *            strMailType : 메일구분 (0 : 회원가입, 1 : 아이디 패스워드 분실           *
	' ***************************************************************************************
	FUNCTION sendMemberEmail(strLoginID, strMailType)
	
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_MAIL] '" & strMailType & "' ")
		IF RS("bitSend") = True THEN

			DIM strName, strMail, strSubject, strContent, strContentBg
			strName      = RS("strName")
			strMail      = RS("strMail")
			strSubject   = GetReplaceTag2Html(RS("strSubject"))
			strContent   = GetReplaceTag2Html(RS("strContent"))
			strContentBg = RS("strContentBg")

			IF strContentBg <> "" AND ISNULL(strContentBg) = False THEN strContent = strContent & "<div id=Layer99 style='background-image:url(" & strContentBg & "); no-repeat fixed right bottom;'>"

			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & strLoginID & "' ")

			strContent = REPLACE(strContent, "{{strLoginID}}", RS("strLoginID"))
			strContent = REPLACE(strContent, "{{strLoginPwd}}", RS("strLoginPwd"))
			strContent = REPLACE(strContent, "{{strLoginName}}", RS("strLoginName"))

			CALL sendEmail(strName, strMail, RS("strLoginName"), RS("strEmail"), strSubject, strContent, "", "", "", "")

		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시판 스킨 구분 함수                                                    *
	' * 변수설명 : strSkinGroup : 스킨그룹                                                  *
	' ***************************************************************************************
	FUNCTION GetSKinGroupCode(strSkinGroup)
		SELECT CASE UCASE(strSkinGroup)
		CASE "BOARD"    : GetSKinGroupCode = "일반게시판"
		CASE "GALLERY"  : GetSKinGroupCode = "갤러리"
		CASE "PDS"      : GetSKinGroupCode = "자료실"
		CASE "GUEST"    : GetSKinGroupCode = "방명록"
		CASE "MEMO"     : GetSKinGroupCode = "메모장"
		CASE "LINK"     : GetSKinGroupCode = "링크게시판"
		CASE "CALENDAR" : GetSKinGroupCode = "달력/일정"
		CASE "WEBZINE"  : GetSKinGroupCode = "웹진"
		CASE "OTHER"    : GetSKinGroupCode = "기타"
		END SELECT
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 비밀게시판 체크 함수                                                     *
	' * 변수설명 : bitSecret        : 비밀게시판 유무 변수                                  *
	' *            strAdmin         : 게시판 관리자 리스트                                  *
	' *            bitSecretSession : 비밀게시글 액세스 세션 변수                           *
	' *            strBoardID       : 게시판 아이디                                         *
	' ***************************************************************************************
	FUNCTION GetSecretBoardCheck(bitSecret, strAdmin, bitSecretSession, strBoardID)
		DIM I
		IF bitSecret = True THEN
			IF bitSecretSession = strBoardID THEN
				GetSecretBoardCheck = True
			ELSE
				IF SESSION("strAdmin") = "2" THEN
					GetSecretBoardCheck = True
				ELSE
					IF SESSION("strSecretBoard") = "" THEN
						IF SESSION("strLoginID") = "" THEN
							GetSecretBoardCheck = False
						ELSE
							IF strAdmin = "" OR ISNULL(strAdmin) = True THEN
								GetSecretBoardCheck = False
							ELSE
								IF UBOUND(strAdmin) > 0 THEN
									FOR I = 0 TO UBOUND(strAdmin)
										IF SESSION("strLoginID") = strAdmin(I) THEN
											GetSecretBoardCheck = True
											EXIT FOR
										ELSE
											GetSecretBoardCheck = False
										END IF
									NEXT
								ELSE
									GetSecretBoardCheck = False
								END IF
							END IF
						END IF
					ELSE
						IF bitSecretSession = strBoardID THEN GetSecretBoardCheck = True ELSE GetSecretBoardCheck = False
					END IF
				END IF
			END IF
		ELSE
			GetSecretBoardCheck = True
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 관리자 체크 함수                                                         *
	' * 변수설명 : strLoginID   : 회원 아이디                                               *
	' *            strAdmin     : 게시판 관리자 리스트                                      *
	' *            sessionAdmin : 전체 관리자 세션 변수                                     *
	' ***************************************************************************************
	FUNCTION GetAdminCheck(strLoginID, strAdmin, sessionAdmin)
		DIM I
		IF strLoginID = "" THEN
			GetAdminCheck = False
		ELSE
			IF sessionAdmin = "2" THEN
				GetAdminCheck = True
			ELSE
				IF strAdmin <> "" AND ISNULL(strAdmin) = False THEN
					strAdmin = SPLIT(strAdmin, "|")
					FOR I = 0 TO UBOUND(strAdmin)
						IF strLoginID = strAdmin(I) THEN
							GetAdminCheck = True
							EXIT FOR
						ELSE
							GetAdminCheck = False
						END IF
					NEXT
				ELSE
					GetAdminCheck = False
				END IF
			END IF
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시판 접근 레벨 체크 함수                                               *
	' * 변수설명 : bitBoardAdmin : 게시판 관리자 유무                                       *
	' *            intLevel      : 게시판 레벨                                              *
	' *            intUserLevel  : 회원레벨                                                 *
	' ***************************************************************************************
	FUNCTION GetBoardLevelCheck(bitBoardAdmin, intLevel, intUserLevel)
		IF bitBoardAdmin = True THEN
			GetBoardLevelCheck = True
		ELSE
			IF intLevel = 0 THEN
				GetBoardLevelCheck = True
			ELSE
				IF INT(intLevel) < INT(intUserLevel) OR INT(intLevel) = INT(intUserLevel) THEN
					GetBoardLevelCheck = True
				ELSE
					GetBoardLevelCheck = False
				END IF
			END IF
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 자동 링크 함수                                                           *
	' * 변수설명 : bitAutoLink : 자동링크 실행 유무                                         *
	' *            strContent  : 변환할 본문                                                *
	' ***************************************************************************************
	FUNCTION getAutoLink(bitAutoLink, strContent)
		DIM regEx
		IF bitAutoLink = True THEN
			SET regEx = New RegExp
			regEx.pattern = "(http|ftp):\/\/([a-z0-9\_\-\./~@?=%&:\-]+)"
			regEx.IgnoreCase = True
			regEx.Global = True
			strContent = regEx.Replace(strContent, "<a href='$1://$2' target=_blank>$1://$2</a>")
			regEx.Pattern = "(\w+)@([\w.\-]+)"
			strContent = regEx.Replace(strContent, "<a href='mailto:$1@$2'>$1@$2</a>")
			getAutoLink = strContent
		ELSE
			getAutoLink = strContent
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 에디터 태그 변환 함수                                                    *
	' * 변수설명 : str : 변환할 변수 값                                                     *
	' ***************************************************************************************
	FUNCTION GetReplaceTag2Editor(str)
		IF ISNULL(str) = False THEN
			str = REPLACE(str,"&amp;","&amp;amp;")
			str = REPLACE(str,"&quot;","&amp;quot;")
			str = REPLACE(str,CHR(34),"&quot;")
			GetReplaceTag2Editor = str
		END IF
	End Function

	' ***************************************************************************************
	' * 함수설명 : TEXT 태그 변환 함수                                                      *
	' * 변수설명 : str : 변환할 변수 값                                                     *
	' ***************************************************************************************
	FUNCTION GetReplaceTag2Text(str)
		IF ISNULL(str) = False THEN
			str = REPLACE(str,"&amp;","&amp;amp;")
			str = REPLACE(str,"&quot;","&amp;quot;")
			str = REPLACE(str, "<", "&lt;")
			str = REPLACE(str, ">", "&gt;")
			str = REPLACE(str,"  ","&nbsp; ")
			str = REPLACE(str,"	","&nbsp; &nbsp; ")
			str = REPLACE(str,CHR(13)&CHR(10),"<BR>")
			str = REPLACE(str,Chr(13),"<br />")
			str = REPLACE(str,CHR(34),"&quot;")
			GetReplaceTag2Text = str
		END IF
	End Function

	' ***************************************************************************************
	' * 함수설명 : 관리자 헤더 풋터 입력값 변환 함수                                        *
	' * 변수설명 : str : 변환할 변수 값                                                     *
	' ***************************************************************************************
	FUNCTION GetReplaceTag2UserHtml(str)
		IF ISNULL(str) = False THEN
			str = REPLACE(str, "&nbsp;", "&amp;nbsp;")
			str = REPLACE(str, "<", "&lt;")
			str = REPLACE(str, ">", "&gt;")
			str = REPLACE(str,"  ","&nbsp; ")
			str = REPLACE(str,CHR(34),"&quot;")
			GetReplaceTag2UserHtml = str
		END IF
	End Function

	' ***************************************************************************************
	' * 함수설명 : HTML 태그 변환 함수                                                      *
	' * 변수설명 : str : 변환할 변수 값                                                     *
	' ***************************************************************************************
	FUNCTION GetReplaceTag2Html(str)
		IF ISNULL(str) = False THEN
			DIM allowTagList
			allowTagList = "!--|br|hr|table|tbody|tr|td|img|embed|strong|center|a|p|font|li||hr|span|h1|h2|h3|h4|h5|div"

			str = GetEregiReplace("<(\/?)(?!\/|" & allowTagList & ")([^<>]*)?>", "&lt;$1$2&gt;", str)
			str = GetEregiReplace("(javascript\:|vbscript\:)+","$1//",str)
			str = GetEregiReplace("(\.location|location\.|\.cookie|alert\(|window\.open\(|onmouse|onkey|view\-source\:)+", "//", str)
			str = REPLACE(str,"<" & "%","&lt;%")
			str = REPLACE(str,"%" & ">","&lt;%")
			GetReplaceTag2Html = str
		END IF
	End Function

	' ***************************************************************************************
	' * 함수설명 : HTML BR 태그 변환 함수                                                   *
	' * 변수설명 : str : 변환할 변수 값                                                     *
	' ***************************************************************************************
	FUNCTION GetReplaceTag2HtmlBr(str)
		IF ISNULL(str) = False THEN
			DIM allowTagList
			allowTagList = "!--|br|hr|table|tbody|tr|td|img|embed|strong|center|a|p|font|li||hr|span|h1|h2|h3|h4|h5|div"

			str = GetEregiReplace("<(\/?)(?!\/|" & allowTagList & ")([^<>]*)?>", "&lt;$1$2&gt;", str)
			str = GetEregiReplace("(javascript\:|vbscript\:)+","$1//",str)
			str = GetEregiReplace("(\.location|location\.|\.cookie|alert\(|window\.open\(|onmouse|onkey|view\-source\:)+", "//", str)
			str = REPLACE(str,"<" & "%","&lt;%")
			str = REPLACE(str,"%" & ">","&lt;%") 
			str = REPLACE(str,Chr(13),"<br />")
			GetReplaceTag2HtmlBr = str
		END IF
	End Function

	FUNCTION GetEregiReplace(pattern, replacestr, text)
		DIM eregObj
		SET eregObj = New RegExp
		eregObj.Pattern = pattern
		eregObj.IgnoreCase = True
		eregObj.Global = True
		GetEregiReplace = eregObj.Replace(text, replacestr)
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 메일링 폼 값 변환 함수                                                   *
	' * 변수설명 : str : 변환할 변수 값                                                     *
	' ***************************************************************************************
	FUNCTION GetUserEmailBit(str)
		IF str <> "" AND ISNULL(str) = False THEN GetUserEmailBit = True ELSE GetUserEmailBit = False
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시판별 파일복사 함수                                                            *
	' * 변수설명 : rootPath : 기본 경로                                                     *
	' *            strBoard1   : 원본 게시판 아이디                                         *
	' *            strBoard2   : 복사할 게시판 아이디                                       *
	' *            strFileName : 복사할 파일명                                              *
	' ***************************************************************************************
	FUNCTION ExecFileCopy(rootPath, strBoard1, strBoard2, strFileName)
		DIM dPath, sPath, StrDesFilename, StrCopyFilename
		dPath = rootPath & "Pds\Board\" & strBoard2 & "\"
		sPath = rootPath & "Pds\Board\" & strBoard1 & "\"

		StrCopyFilename = strFileName
		StrDesFilename  = checkSameFile(dPath, strFileName)

		SET FSO = SERVER.CREATEOBJECT("scripting.FileSystemObject")

		IF FSO.FileExists(sPath & StrCopyFilename) THEN FSO.CopyFile sPath & StrCopyFilename, dPath & StrDesFilename
		IF FSO.FileExists(sPath & "Small\" & StrCopyFilename) THEN FSO.CopyFile sPath & "Small\" & StrCopyFilename, dPath & "Small\" & StrDesFilename
		IF FSO.FileExists(sPath & "Thrum\" & StrCopyFilename) THEN FSO.CopyFile sPath & "Thrum\" & StrCopyFilename, dPath & "Thrum\" & StrDesFilename

		SET FSO = NOTHING

		ExecFileCopy = StrDesFilename

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시판별 파일 이미지 복사 함수                                                    *
	' * 변수설명 : rootPath : 기본 경로                                                     *
	' *            strBoard1 : 원본 게시판 아이디                                           *
	' *            strBoard2 : 복사할 게시판 아이디                                         *
	' *            strFileName1 : 복사할 파일명                                             *
	' *            strFileName2 : 복사될 파일명                                             *
	' ***************************************************************************************
	FUNCTION ExecFileCopyImage(rootPath, strBoard1, strBoard2, strFileName1, strFileName2)
		DIM dPath, sPath
		dPath = rootPath & "Pds\Board\" & strBoard2 & "\"
		sPath = rootPath & "Pds\Board\" & strBoard1 & "\"

		SET FSO = SERVER.CREATEOBJECT("scripting.FileSystemObject")

		IF FSO.FileExists(sPath & strFileName1) THEN FSO.CopyFile sPath & strFileName1, dPath & strFileName2
		IF FSO.FileExists(sPath & "Small\" & strFileName1) THEN FSO.CopyFile sPath & "Small\" & strFileName1, dPath & "Small\" & strFileName2
		IF FSO.FileExists(sPath & "Thrum\" & strFileName1) THEN FSO.CopyFile sPath & "Thrum\" & strFileName1, dPath & "Thrum\" & strFileName2

		SET FSO = NOTHING
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 파일복사 함수                                                            *
	' * 변수설명 : strFileName1 : 소스파일(경로포함)                                        *
	' *            strFileName2 : 대상파일(경로포함)                                        *
	' ***************************************************************************************
	FUNCTION ExecDefaultFileCopy(strFileName1, strFileName2)

		SET FSO = SERVER.CREATEOBJECT("scripting.FileSystemObject")

		IF FSO.FileExists(strFileName1) THEN FSO.CopyFile strFileName1, strFileName2
		SET FSO = NOTHING

		ExecDefaultFileCopy = True

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 컴마로 구분되어 있는 배열문을 쿼리문으로 변환하는 함수                   *
	' * 변수설명 : str = 컴마로 구분되어 있는 배열값                                        *
	' ***************************************************************************************
	FUNCTION getSplitQuery(str)
		DIM I, tempStr
		str     = SPLIT(str, ",")
		tempStr = ""
		FOR I = 0 TO UBOUND(str)
			IF str(I) <> "" THEN
				IF tempStr <> "" THEN tempStr = tempStr & ","
				tempStr = tempStr & "'" & str(I) & "'"
			END IF
		NEXT
		getSplitQuery = tempStr
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시글 삭제 함수                                                         *
	' *            rootPath   = 기본경로 변수                                               *
	' *            strBoardID = 게시판 아이디                                               *
	' *            intThread  = thread 변수값                                               *
	' ***************************************************************************************
	FUNCTION ExecBoardDelete(rootPath, strBoardID, intThread, intIndex)

		DIM Query, iCount, delIntSeq, delStrFileCode, strMinusPointUserID, I, intThreadTemp, intIndexTemp

		intThreadTemp = intThread
		intIndexTemp  = intIndex
		Query = " WHERE [bitDelete] = '0' AND [strBoardID] = '" & strBoardID & "' AND [intThRead] IN (" & getSplitQuery(intThRead) & ") "

		strMinusPointUserID = ""

		SET RS = DBCON.EXECUTE("SELECT [intSeq], [strLoginID], [strFileCode], [strLoginID], [intCategory] FROM [MPLUS_BOARD] " & Query)

		iCount = 0
		WHILE NOT(RS.EOF)

			iCount = iCount + 1

			delIntSeq      = delIntSeq      & RS("intSeq")      & ","
			delStrFileCode = delStrFileCode & RS("strFileCode") & ","

			DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [intCategoryCount] = [intCategoryCount] - 1 WHERE [strBoardID] = '" & strBoardID & "' AND [intCategory] = '" & RS("intCategory") & "' ")

			IF RS("strLoginID") <> "guest" THEN
				IF strMinusPointUserID <> "" THEN strMinusPointUserID = strMinusPointUserID & ","
				strMinusPointUserID = strMinusPointUserID & RS("strLoginID")
			END IF

		RS.MOVENEXT
		WEND

		DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [bitDelete] = '1', [strSubject] = '삭제된 게시글입니다.', [strContent] = '' " & Query)

		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [intCommentCount] = [intCommentCount] - 1 WHERE [strLoginID] IN (SELECT [strLoginID] FROM [MPLUS_BOARD_COMMENT] " & Query & " AND [strLoginID] != 'guest') ")
		
		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [intBoardCount] = [intBoardCount] - 1 WHERE [strLoginID] IN (SELECT [strLoginID] FROM [MPLUS_BOARD] " & Query & " AND [strLoginID] != 'guest') ")

		DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_POINT] WHERE [intCommentSeq] IN (SELECT [intSeq] FROM [MPLUS_BOARD_COMMENT] " & Query & ") ")

		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_COMMENT] " & Query)

		Query = " WHERE [intSeq] IN (" & getSplitQuery(delIntSeq) & ") "

		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_BAD] " & Query)

		DBCON.EXECUTE("SELECT [strFileName] FROM [MPLUS_BOARD_NOTICE_LIST] " & Query)

		WHILE NOT(RS.EOF)
			IF RS("strFileName") <> "" AND ISNULL(RS("strFileName")) = False THEN CALL ExecFileDelete(rootPath & "Pds\Main\", RS("strFileName"))
		RS.MOVENEXT
		WEND

		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_NOTICE_LIST] " & Query)

		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [intVote] = [intVote] - 1 WHERE [strLoginID] IN (SELECT [strLoginID] FROM [MPLUS_BOARD_VOTE] " & Query & ") ")
		
		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_READ_CHECK] " & Query)

		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_VOTE] " & Query)

		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_DOWN_CHECK] " & Query)

		DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_POINT] " & Query)
		
		Query = " WHERE [strFileCode] IN (" & getSplitQuery(delStrFileCode) & ") "

		SET RS = DBCON.EXECUTE("SELECT [strFileName] FROM [MPLUS_BOARD_FILE] " & Query)

		WHILE NOT(RS.EOF)

			CALL ExecFileDelete(rootPath & "Pds\Board\" & strBoardID & "\", RS("strFileName"))
			CALL ExecFileDelete(rootPath & "Pds\Board\" & strBoardID & "\small\", RS("strFileName"))
			CALL ExecFileDelete(rootPath & "Pds\Board\" & strBoardID & "\thrum\", RS("strFileName"))

		RS.MOVENEXT
		WEND

		DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_FILE] " & Query)

		IF strMinusPointUserID <> "" THEN
			strMinusPointUserID = SPLIT(strMinusPointUserID, ",")

			FOR I = 0 TO UBOUND(strMinusPointUserID)
				DBCON.EXECUTE("EXEC [MPLUS_MEMBER_POINT_SORT] '" & strMinusPointUserID(I) & "' ")
			NEXT
		END IF

		intThreadTemp = SPLIT(intThreadTemp, ",")
		intIndexTemp  = SPLIT(intIndexTemp, ",")

		FOR I = 0 TO UBOUND(intThreadTemp)

			IF intThreadTemp(I) <> "" THEN

				SET RS = DBCON.EXECUTE("SELECT COUNT([intSeq]) FROM [MPLUS_BOARD] WHERE [strBoardID] = '" & strBoardID & "' AND [intIndex] >= '" & intIndexTemp(I) & "' ")

				IF RS(0) > 500 THEN DBCON.EXECUTE("EXEC [MPLUS_BOARD_INDEX] '" & strBoardID & "', '" & intIndexTemp(I) & "' ")

			END IF

		NEXT

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시판 복사 함수                                                         *
	' * 변수설명 : rootPath = 기본경로 변수                                                 *
	' *            strReply       = 답변글 유무                                             *
	' *            strBoardID     = 복사할 게시판 아이디                                    *
	' *            strOrigBoardID = 원본 게시판 아이디                                      *
	' *            intThread      = thread 변수값                                           *
	' *            exeIntSeq      = 복사할 게시글 번호                                      *
	' *            exeIntCategory = 복사할 게시글 카테고리                                  *
	' *            exeStrContent  = 복사할 게시글 본문                                      *
	' *            exeStrFileCode = 복사할 게시글 파일코드                                  *
	' *            exeFileCount   = 복사할 게시글 갯수                                      *
	' *            bitAddMemo     = 게시글 복사 메모 등록 유무                              *
	' *            bitNewDate     = 게시글 일자 변경 유무                                   *
	' *            exeType        = 복사 타입                                               *
	' ***************************************************************************************
	FUNCTION ExecBoardCopy(rootPath, strReply, strBoardID, strOrigBoardID, intThread, exeIntSeq, exeIntCategory, exeStrContent, exeStrFileCode, exeFileCount, bitAddMemo, bitNewDate, exeType)

		DIM intMaxIndex, intMaxThread, strFileCode, intMaxSeq, intMaxDepth
		DIM iCount, imgIntFileType, imgDesFileName, imgStrFileName, imgIntFileSize, imgImgWidth, imgImgHeight, imgStrFileMemo
		DIM intReplayMaxSeq

		SELECT CASE strReply
		CASE "0"
			SET RS = DBCON.EXECUTE("EXEC [MPLUS_PUT_WRITE] '" & strBoardID & "', '500' ")
			intMaxIndex  = RS("intMaxIndex")
			intMaxThread = RS("intMaxThread")
			strFileCode  = RS("strFileCode")
			intMaxSeq    = RS("intMaxSeq")
			intMaxDepth  = "0"
		CASE "1"
			SET RS = DBCON.EXECUTE("SELECT MAX([intSeq]) AS [intReplayMaxSeq] FROM [MPLUS_BOARD] WHERE [strBoardID] = '" & strBoardID & "' ")
			intReplayMaxSeq = RS("intReplayMaxSeq")

			SET RS = DBCON.EXECUTE("EXEC [MPLUS_PUT_REPLY] '" & strBoardID & "', '" & intReplayMaxSeq & "' ")
			intMaxIndex  = RS("intIndex")
			intMaxThread = RS("intReplyThread")
			strFileCode  = RS("strFileCode")
			intMaxSeq    = RS("intMaxSeq")
			intMaxDepth  = RS("intReplyDepth")
		END SELECT

		IF strFileCode = "" OR ISNULL(strFileCode) = True THEN
			strFileCode = "0000000000001"
		ELSE
			strFileCode = INT(strFileCode) + 1
			FOR F = LEN(strFileCode) TO 12
				strFileCode = "0" & strFileCode
			NEXT
		END IF

		Query = "INSERT INTO [MPLUS_BOARD] ([strBoardID], [intIndex], [intThread], [intDepth], [strLoginID], [intCategory], [strName], [strPassword], [strEmail], [strHomepage], [strSubject], [strSubjectStyle], [strContent], [strSmallSubject], [strSmallContent], [strLink1], [strLink2], [strBoardBg], [strIpAddr], [bitDelete], [bitCheck], [bitHtml], [bitHtmlBr], [bitText], [bitNotice], [bitReMail], [bitSecret], [strSecretID], [bitBad], [intRead], [intVote], [intComment], [intFileCount], [intImgCount], [strFileCode], [dateRegDate], [dateCmtDate], [strAddData1], [strAddData2], [strAddData3], [strAddData4], [strAddData5], [strAddData6], [strAddData7], [strAddData8], [strAddData9], [strAddData10]) SELECT [strBoardID] = '" & strBoardID & "', [intIndex] = '" & intMaxIndex & "', [intThread] = '" & intMaxThread & "', [intDepth] = '" & intMaxDepth & "', [strLoginID], [intCategory], [strName], [strPassword], [strEmail], [strHomepage], [strSubject], [strSubjectStyle], "

		IF bitAddMemo = "1" THEN
			Query = Query & "[strContent] = '" & GetReplaceInput(exeStrContent, "") & "<br><br>관리자에 의해 " & NOW() & " 에 "
			IF exeType = "copy" THEN Query = Query & "복사" ELSE Query = Query & "이동"
			Query = Query & "되었습니다." & "', "
		ELSE
			Query = Query & "[strContent], "
		END IF
				
		Query = Query & "[strSmallSubject], [strSmallContent], [strLink1], [strLink2], [strBoardBg], [strIpAddr], [bitDelete], [bitCheck], [bitHtml], [bitHtmlBr], [bitText], [bitNotice], [bitReMail], [bitSecret], [strSecretID], [bitBad], [intRead], [intVote], [intComment], [intFileCount], [intImgCount], [strFileCode] = '" & strFileCode & "',"

		IF bitNewDate = "1" THEN Query = Query & "[dateRegDate] = GETDATE()" ELSE Query = Query & "[dateRegDate]"

		Query = Query & ", [dateCmtDate], [strAddData1], [strAddData2], [strAddData3], [strAddData4], [strAddData5], [strAddData6], [strAddData7], [strAddData8], [strAddData9], [strAddData10] FROM [MPLUS_BOARD] WHERE [bitDelete] = '0' AND [strBoardID] = '" & strOrigBoardID & "' AND [intThread] = '" & intThRead & "' "

		DBCON.EXECUTE(Query)

		DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_COMMENT] ([strBoardID], [intThread], [intScore], [strLoginID], [strName], [strPassword], [bitDelete], [strContent], [strIpAddr], [dateRegDate], [intCmtThread], [intDepth], [bitHtml]) SELECT [strBoardID] = '" & strBoardID & "', [intThread] = '" & intMaxThread & "', [intScore], [strLoginID], [strName], [strPassword], [bitDelete], [strContent], [strIpAddr], [dateRegDate], [intCmtThread] = '" & intCmtThread & "', [intDepth] = '" & intDepth & "', [bitHtml] FROM [MPLUS_BOARD_COMMENT] WHERE [strBoardID] = '" & strOrigBoardID & "' AND [intThread] = '" & intThRead & "' ")

		DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_READ_CHECK] ([strBoardID], [intSeq], [strLoginID], [strUserIp], [dateRegDate]) SELECT [strBoardID] = '" & strBoardID & "', [intSeq] = '" & intMaxSeq & "', [strLoginID], [strUserIp], [dateRegDate] FROM [MPLUS_BOARD_READ_CHECK] WHERE [intSeq] = '" & exeIntSeq & "' ")

		DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_VOTE] ([strBoardiD], [intSeq], [strLoginID], [dateRegDate]) SELECT [strBoardID] = '" & strBoardID & "', [intSeq] = '" & intMaxSeq & "', [strLoginID], [dateRegDate] FROM [MPLUS_BOARD_VOTE] WHERE [intSeq] = '" & exeIntSeq & "' ")

		DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [intCategoryCount] = [intCategoryCount] + 1 WHERE [strBoardID] = '" & strBoardID & "' AND [intCategory] = '0' ")

		IF exeFileCount > 0 THEN

			SET RS = DBCON.EXECUTE("SELECT [intFileType], [strFileName], [intFileSize], [imgWidth], [imgHeight], [strFileMemo] FROM [MPLUS_BOARD_FILE] WHERE [strFileCode] = '" & exeStrFileCode & "' ")

			iCount = 0
			imgIntFileType    = ""
			imgDesFileName    = ""
			imgStrFileName    = ""
			imgStrFileCodeRec = ""
			imgIntFileSize    = ""
			imgImgWidth       = ""
			imgImgHeight      = ""
			imgStrFileMemo    = ""

			WHILE NOT(RS.EOF)

				iCount = iCount + 1
				imgIntFileType    = imgIntFileType    & RS("IntFileType") & ","
				imgDesFileName    = imgDesFileName    & RS("strFileName") & ","
				imgStrFileName    = imgStrFileName    & checkSameFile(rootPath & "Pds\Board\" & strBoardID & "\", RS("strFileName")) & ","
				imgStrFileCodeRec = imgStrFileCodeRec & strFileCode & "_" & iCount & ","
				imgIntFileSize    = imgIntFileSize    & RS("IntFileSize") & ","
				imgImgWidth       = imgImgWidth       & RS("ImgWidth")    & ","
				imgImgHeight      = imgImgHeight      & RS("ImgHeight")   & ","
				imgStrFileMemo    = imgStrFileMemo    & RS("strFileMemo") & ","

			RS.MOVENEXT
			WEND

			imgIntFileType    = SPLIT(imgIntFileType, ",")
			imgDesFileName    = SPLIT(imgDesFileName, ",")
			imgStrFileName    = SPLIT(imgStrFileName, ",")
			imgStrFileCodeRec = SPLIT(imgStrFileCodeRec, ",")
			imgIntFileSize    = SPLIT(imgIntFileSize, ",")
			imgImgWidth       = SPLIT(imgImgWidth, ",")
			imgImgHeight      = SPLIT(imgImgHeight, ",")
			imgStrFileMemo    = SPLIT(imgStrFileMemo, ",")

			FOR F = 0 TO UBOUND(imgIntFileType)
				IF imgIntFileType(F) <> "" THEN
					DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_FILE] ([strBoardID], [strFileCode], [strFileCodeRec], [intFileType], [strFileName], [intFileSize], [imgWidth], [imgHeight], [strFileMemo]) VALUES ('" & strBoardID & "', '" & strFileCode & "', '" & imgStrFileCodeRec(F) & "', '" & imgIntFileType(F) & "', '" & imgStrFileName(F) & "', '" & imgIntFileSize(F) & "', '" & imgImgWidth(F) & "', '" & imgImgHeight(F) & "', '" & imgStrFileMemo(F) & "') ")
					CALL ExecFileCopyImage(rootPath, strOrigBoardID, strBoardID, imgDesFileName(F), imgStrFileName(F))
				END IF
			NEXT
		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : INT 값 MONEY 변형 함수                                                   *
	' * 변수설명 : str = 변환할 값                                                          *
	' ***************************************************************************************
	FUNCTION GetMoneyComma(str)
		IF str <> "" AND ISNULL(str) = False THEN GetMoneyComma = MID(FORMATCURRENCY(str), 2, LEN(FORMATCURRENCY(str))) ELSE GetMoneyComma = 0
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 업로드 파일 아이콘 반환                                                  *
	' * 변수설명 : strFileName = 업로드 파일명, bitImage = 이미지 여부                      *
	' ***************************************************************************************
	FUNCTION GetFileIcon(strFileName, bitImage)
		DIM strFileExt
		IF strFileName = False THEN
			GetFileIcon = ""
		ELSE
			strFileExt = MID(strFileName, InStrRev(strFileName, "."))
			strFileExt = REPLACE(strFileExt, ".", "")
			SELECT CASE LCASE(strFileExt)
			CASE "ai", "alz", "asf", "asp", "bmp", "cgi", "dll", "doc", "exe", "fla", "fon", "gif", "hlp", "htm", "hwp", "img", "jpg", "js", "mid", "mov", "mp3", "mpg", "pcx", "pdf", "php3", "png", "ppt", "psd", "rar", "reg", "swf", "tif", "ttf", "txt", "url", "wal", "wav", "wsz", "xls", "zip", "xlsx"
				IF bitImage = True THEN GetFileIcon = "<img src=Library/fileicon/" & strFileExt & ".gif border=0>" ELSE GetFileIcon = strFileExt & ".gif"
			CASE ELSE GetFileIcon = ""
			END SELECT
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 업로드 파일 이미지 여부 확인                                             *
	' * 변수설명 : strFileName = 업로드 파일명                                              *
	' ***************************************************************************************
	FUNCTION GetImageFile(strFileName)
		IF strFileName = "" OR ISNULL(strFileName) = True THEN
			DIM strFileExt
			strFileExt = MID(strFileName, InStrRev(strFileName, "."))
			strFileExt = REPLACE(strFileExt, ".", "")
			SELECT CASE UCASE(strFileExt)
			CASE "JPG", "GIF", "BMP", "PNG", "TIF"
				GetImageFile = True
			CASE ELSE
				GetImageFile = False
			END SELECT
		ELSE
			GetImageFile = False
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 1글자의 날짜를 2글자로 변환                                              *
	' * 변수설명 : str = 변환할 날짜                                                        *
	' ***************************************************************************************
	FUNCTION GetCharDate(str)
		IF LEN(str) = 1 THEN GetCharDate = "0" & str ELSE GetCharDate = str
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 카피라이트 출력                                                          *
	' * 주의사항 : 정식등록 사용자만 카피라이트 수정 가능                                   *
	' ***************************************************************************************
	FUNCTION GetCopyRight(str)

		GetCopyRight = "<span style=""font-family:'Tahoma', 'Verdana'; font-size:10px"">CopyRight Since 2001-" & YEAR(NOW) & " <a href='http://webarty.com' target='_blank' style=""font-family:'Tahoma', 'Verdana'; font-size:11px""><b>WEBARTY.COM</b></a> All Rights RESERVED.</span>"
		DIM FSO, objFile
		SET FSO = Server.CreateObject("scripting.FileSystemObject")
		IF fso.FileExists(str & "\maker.txt") THEN
			SET objFile = FSO.OpenTextFile(str & "\maker.txt", 1)
			GetCopyRight = GetCopyRight & "<span style=""font-family:'Tahoma', 'Verdana'; font-size:10px""> / Skin By </span>" & objFile.ReadLine
			SET objFile = NOTHING
		END IF

		SET FSO = NOTHING

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 설문조사 % 반환                                                          *
	' * 변수설명 : intCount : 투표수 / intTotalCount : 전체투표수                           *
	' ***************************************************************************************
	FUNCTION GetPollPercent(intCount, intTotalCount)
		IF intCount = 0 THEN
			GetPollPercent = 0
		ELSE
			IF intTotalCount = 0 THEN GetPollPercent = 0 ELSE GetPollPercent = INT(intCount / intTotalCount * 100)
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 설문조사 % 반환                                                          *
	' * 변수설명 : intCount : 투표수 / intTotalCount : 전체투표수 / intGrpWith : 그래프너비 *
	' ***************************************************************************************
	FUNCTION GetPollGrpWidth(intCount, intTotalCount, intGrpWidth)
		IF intCount = 0 THEN
			GetPollGrpWidth = 1
		ELSE
			IF intTotalCount = 0 THEN GetPollGrpWidth = 1 ELSE GetPollGrpWidth = INT(intGrpWidth / intTotalCount * intCount)
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 메인추천 그룹셀렉트박스                                                  *
	' * 변수설명 : strGroupCode : 그룹코드 배열값 / strGroupName : 그룹이름 배열값          *
	' *            strSelect : 셀렉트박스 선택값 / strFormName : 폼필드 이름                *
	' *            strFirstName : 셀렉트박스 첫번째 값 / change시 실행문                    *
	' ***************************************************************************************
	FUNCTION GetMainBoardGroup(strGroupCode, strGroupName, strSelect, strFormName, strFirstName, strChange)
		DIM str, I, strGroupCodeTemp, strGroupNameTemp
		str = "<select name=""" & strFormName & """ id=""" & strFormName & """"
		IF strChange <> "" THEN str = str & " OnChange=""" & strChange & """"
		str = str & ">" & vbcrlf
		IF strFirstName <> "" THEN str = str & "<option value="""">" & strFirstName & "</option>" & vbcrlf
		strGroupCodeTemp = SPLIT(strGroupCode, ",")
		strGroupNameTemp = SPLIT(strGroupName, ",")
		FOR I = 0 TO UBOUND(strGroupCodeTemp)
			IF strGroupCodeTemp(I) <> "" THEN
				str = str & "<option value=""" & strGroupCodeTemp(I) & """"
				IF strGroupCodeTemp(I) = strSelect THEN str = str & " SELECTED"
				str = str & ">" & strGroupNameTemp(I) & "</option>" & vbcrlf
			END IF
		NEXT
		str = str & "</select>"
		GetMainBoardGroup = str
	END FUNCTION


	' ***************************************************************************************
	' * 함수설명 : 이미지 사이즈 체크함수 (나누미 썸네일 사용시 동작)                       *
	' * 변수설명 : strFileName    = 저장된 파일명                                           *
	'	*            strPath        = 저장경로                                                *
	'	*            intWidth       = 기본 너비                                               *
	'	*            intHeight      = 기본 높이                                               *
	' ***************************************************************************************
	FUNCTION NanumiImageSize(strFileName, strPath, intWidth, intHeight)
		SET oImg = Server.CreateObject("Nanumi.ImagePlus")
		IF NOT IsObject(oImg) THEN
			NanumiImageSize = intWidth & "|" & intHeight
		ELSE
			SET Image = Server.CreateObject("Nanumi.ImagePlus")
			Image.OpenImageFile strPath & strFileName
			NanumiImageSize = Image.Width & "|" & Image.Height
			Image.Dispose
			SET Image = NOTHING
		END IF
	END Function

	' ***************************************************************************************
	' * 함수설명 : 태그제거                                                                 *
	' * 변수설명 : htmlDoc : HTML 태그로 된 내용                                            *
	' ***************************************************************************************
	FUNCTION StripTags(htmlDoc)
		DIM rex
		SET rex = new Regexp
		rex.Pattern= "<[^>]+>"
		rex.Global = true
		StripTags = rex.Replace(htmlDoc,"")
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시판 관리자 체크                                                       *
	' * 변수설명 : str1 : 게시판 관리자 목록 / str2 : 등록할 게시판 관리자 아이디           *
	' ***************************************************************************************
	FUNCTION GetBoardAdminSplit(str1, str2)
		DIM tmpStrAdminList, I
		IF str1 = "" THEN
			GetBoardAdminSplit = True
		ELSE
			tmpStrAdminList = SPLIT(str1, "|")
			FOR I = 0 TO UBOUND(tmpStrAdminList)
				IF tmpStrAdminList(I) = str2 THEN
					GetBoardAdminSplit = False
				ELSE
					GetBoardAdminSplit = True
				END IF
			NEXT
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 양력을 음력으로 변환하는 함수                                            *
	' * 변수설명 : pYear = 년도, pMonth = 월, pDay = 일                                     *
	' ***************************************************************************************
	FUNCTION GetLunar(pYear,pMonth,pDay)

		DIM sLunarTableString
		DIM sLunarTable, nDay
    
		sLunarTableString = "1212122322121-1212121221220-1121121222120-2112132122122-2112112121220-2121211212120-2212321121212-2122121121210-2122121212120-1232122121212-1212121221220-1121123221222-1121121212220-1212112121220-2121231212121-2221211212120-1221212121210-2123221212121-2121212212120-1211212232212-1211212122210-2121121212220-1212132112212-2212112112210-2212211212120-1221412121212-1212122121210-2112212122120-1231212122212-1211212122210-2121123122122-2121121122120-2212112112120-2212231212112-2122121212120-1212122121210-2132122122121-2112121222120-1211212322122-1211211221220-2121121121220-2122132112122-1221212121120-2121221212110-2122321221212-1121212212210-2112121221220-1231211221222-1211211212220-1221123121221-2221121121210-2221212112120-1221241212112-1212212212120-1121212212210-2114121212221-2112112122210-2211211412212-2211211212120-2212121121210-2212214112121-2122122121120-1212122122120-1121412122122-1121121222120-2112112122120-2231211212122-2121211212120-2212121321212-2122121121210-2122121212120-1212142121212-1211221221220-1121121221220-2114112121222-1212112121220-2121211232122-1221211212120-1221212121210-2121223212121-2121212212120-1211212212210-2121321212221-2121121212220-1212112112210-2223211211221-2212211212120-1221212321212-1212122121210-2112212122120-1211232122212-1211212122210-2121121122210-2212312112212-2212112112120-2212121232112-2122121212110-2212122121210-2112124122121-2112121221220-1211211221220-2121321122122-2121121121220-2122112112322-1221212112120-1221221212110-2122123221212-1121212212210-2112121221220-1211231212222-1211211212220-1221121121220-1223212112121-2221212112120-1221221232112-1212212122120-1121212212210-2112132212221-2112112122210-2211211212210-2221321121212-2212121121210-2212212112120-1232212122112-1212122122120-1121212322122-1121121222120-2112112122120-2211231212122-2121211212120-2122121121210-2124212112121-2122121212120-1212121223212-1211212221220-1121121221220-2112132121222-1212112121220-2121211212120-2122321121212-1221212121210-2121221212120-1232121221212-1211212212210-2121123212221-2121121212220-1212112112220-1221231211221-2212211211220-1212212121210-2123212212121-2112122122120-1211212322212-1211212122210-2121121122120-2212114112122-2212112112120-2212121211210-2212232121211-2122122121210-2112122122120-1231212122212-1211211221220-2121121321222-2121121121220-2122112112120-2122141211212-1221221212110-2121221221210-2114121221221" '2050
		sLunarTable = Split(sLunarTableString, "-")
		nDay = Split("31-0-31-30-31-30-31-31-30-31-30-31", "-")
 
		DIM i, j
		DIM nDayTable(170)
		DIM nLunarMonth
    
		FOR i = 0 to 169
			nDayTable(i) = 0
			FOR j = 1 to 13
				nLunarMonth = CInt(Mid(sLunarTable(i), j, 1))
				SELECT CASE nLunarMonth
				CASE 1, 3
					nDayTable(i) = nDayTable(i) + 29
				CASE 2, 4
					nDayTable(i) = nDayTable(i) + 30
				END SELECT
			NEXT
		NEXT
    
		DIM nYear, nDays1, nDays2, nDays3
 
		nYear = pYear - 1
		nDays1 = 1880 * 365 + 1880 \ 4 - 1880 \ 100 + 1880 \ 400 + 30
		nDays2 = nYear * 365 + nYear \ 4 - nYear \ 100 + nYear \ 400
    
		IF GetLeapMonth(pYear) THEN nDay(1) = 29 ELSE nDay(1) = 28

		FOR i = 0 to pMonth - 2
			nDays2 = nDays2 + nDay(i)
		NEXT

		nDays2 = nDays2 + pDay

		nRetDay = nDays2 - nDays1 + 1
		nDays3 = nDayTable(0)
    
		DIM nRetDay, nRetMonth, nRetYear
    
		FOR i = 0 to 169
			IF nRetDay <= nDays3 THEN EXIT FOR
			nDays3 = nDays3 + nDayTable(i + 1)
		NEXT

		nRetYear = i + 1881
		nDays3 = nDays3 - nDayTable(i)
		nRetDay = nRetDay - nDays3
    
		DIM nMonthCount, nDayPerMonth
    
		nMonthCount = 11 : IF Mid(sLunarTable(i), 13, 1) > 0 THEN nMonthCount = 12
		nRetMonth = 0
		
		FOR j = 0 to nMonthCount
			nLunarMonth = CInt(Mid(sLunarTable(i), j + 1, 1))
			IF nLunarMonth > 2 THEN
				nDayPerMonth = nLunarMonth + 26
			ELSE
				nRetMonth = nRetMonth + 1
				nDayPerMonth = nLunarMonth + 28
			END IF
			IF nRetDay <= nDayPerMonth THEN EXIT FOR
			nRetDay = nRetDay - nDayPerMonth
		NEXT
 
		GetLunar = CStr(nRetYear) & "-" & RIGHT("0" & nRetMonth, 2) & "-" & RIGHT("0" & nRetDay, 2)

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 해당 년도 윤달 여부 반환                                                 *
	' * 변수설명 : pYear = 년도                                                             *
	' ***************************************************************************************
	FUNCTION GetLeapMonth(pYear)
		IF (pYear MOD 100 <> 0 AND pYear MOD 4 = 0) OR pYear MOD 400 = 0 THEN
			GetLeapMonth = True
		ELSE
			GetLeapMonth = False
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 해당 월의 마지막일 반환                                                  *
	' * 변수설명 : pYear = 년도 : pMonth : 월                                               *
	' ***************************************************************************************
	FUNCTION GetMonthCount(pYear, pMonth)
		DIM aMonthNum
		aMonthNum = SPLIT("31-0-31-30-31-30-31-31-30-31-30-31-", "-")
	 
		IF GetLeapMonth(pYear) THEN aMonthNum(1) = 29 ELSE aMonthNum(1) = 28
		
		GetMonthCount = CINT(aMonthNum(CINT(pMonth)-1))
	 
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 해당 일자의 요일 반환                                                    *
	' * 변수설명 : pDate : 날짜                                                             *
	' ***************************************************************************************
	FUNCTION GetWeekDay(pDate, strColorSUN, strColorSat)

		SELECT CASE WEEKDAY(pDate)
		CASE "1"
			IF strColorSUN <> "" THEN GetWeekDay = "<font color=" & strColorSUN & ">"
			GetWeekDay = GetWeekDay & "일"
			IF strColorSUN <> "" THEN GetWeekDay = GetWeekDay & "</font>"
		CASE "2" : GetWeekDay = "월"
		CASE "3" : GetWeekDay = "화"
		CASE "4" : GetWeekDay = "수"
		CASE "5" : GetWeekDay = "목"
		CASE "6" : GetWeekDay = "금"
		CASE "7"
			IF strColorSat <> "" THEN GetWeekDay = "<font color=" & strColorSat & ">"
			GetWeekDay = GetWeekDay & "토"
			IF strColorSat <> "" THEN GetWeekDay = GetWeekDay & "</font>"
		END SELECT

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 올림함수                                                                 *
	' * 변수설명 : str : 값                                                                 *
	' ***************************************************************************************
	FUNCTION GetCeil(str)
		IF CINT(str) < str THEN GetCeil = CINT(str) + 1 ELSE GetCeil = CINT(str)
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 날짜값을 8자리로 변경                                                    *
	' * 변수설명 : intYear : 년도 / intMonth : 월 / intDay : 일자                           *
	' ***************************************************************************************

	FUNCTION GetTodayStr(intYear, intMonth, intDay, intHour, intMinute)
		DIM str
		str = intYear
		IF LEN(intMonth) = 1 THEN str = str & "0"
		str = str & intMonth
		IF LEN(intDay) = 1 THEN str = str & "0"
		str = str & intDay
		IF intHour <> "" THEN
			IF LEN(intHour) = 1 THEN str = str & "0"
			str = str & intHour
		END IF
		IF intMinute <> "" THEN
			IF LEN(intMinute) = 1 THEN str = str & "0"
			str = str & intMinute
		END IF
		GetTodayStr = str
	END FUNCTION

	FUNCTION GetSubjectStyleForm(strForm, strValue)

		DIM tmpText, tmpValue, tmpStyle, I

		SELECT CASE strForm
		CASE "1"
			tmpText  = SPLIT("글자체,굴림,돋움,바탕,궁서,verdana,Tahoma", ",")
			tmpValue = SPLIT(",굴림,돋움,바탕,궁서,verdana,Tahoma", ",")
		CASE "2"
			tmpText = SPLIT("글자색,흰색,검정,회색,노랑,주황,빨강,갈색,분홍,보라,자주,연두,청녹,파랑", ",")
			tmpValue  = SPLIT(",#FFFFFF,#000000,#7F7F7F,#FFA300,#FF600F,#ff0000,#A03F00,#FF08A0,#5000AF,#B0008F,#7FC700,#009FAF,#0000ff", ",")
			tmpStyle = SPLIT(",#000000,#000000,#7F7F7F,#FFA300,#FF600F,#ff0000,#A03F00,#FF08A0,#5000AF,#B0008F,#7FC700,#009FAF,#0000ff", ",")
		CASE "3"
			tmpText = SPLIT("배경색,흰색,검정,회색,노랑,주황,빨강,갈색,분홍,보라,자주,연두,청녹,파랑", ",")
			tmpValue  = SPLIT(",#FFFFFF,#000000,#7F7F7F,#FFA300,#FF600F,#ff0000,#A03F00,#FF08A0,#5000AF,#B0008F,#7FC700,#009FAF,#0000ff", ",")
			tmpStyle = SPLIT(",#FFFFFF,#000000;color:#FFFFFF,#7F7F7F,#FFA300,#FF600F,#ff0000,#A03F00,#FF08A0,#5000AF,#B0008F,#7FC700,#009FAF,#0000ff", ",")
		END SELECT

		SELECT CASE strForm
		CASE "4"
			GetSubjectStyleForm = "<input type=""checkbox"" name=""strSubjectStyle4"" value=""bold"" class=""no_Line"""
			IF strValue = "bold" THEN GetSubjectStyleForm = GetSubjectStyleForm & " CHECKED"
			GetSubjectStyleForm = GetSubjectStyleForm & ">굵게"
		CASE ELSE
			GetSubjectStyleForm = "<select name=""strSubjectStyle" & strForm & """>" & vbcrlf
			FOR I = 0 TO UBOUND(tmpText)
				GetSubjectStyleForm = GetSubjectStyleForm & "<option value=""" & tmpValue(I) & """"
				IF strForm = "2" THEN
					IF tmpStyle(I) <> "" THEN GetSubjectStyleForm = GetSubjectStyleForm & " style=""color:" & tmpStyle(I) & """"
				END IF
				IF strForm = "3" THEN
					IF tmpStyle(I) <> "" THEN GetSubjectStyleForm = GetSubjectStyleForm & " style=""background:" & tmpStyle(I) & """"
				END IF
				IF tmpValue(I) = strValue THEN GetSubjectStyleForm = GetSubjectStyleForm & " SELECTED"
				GetSubjectStyleForm = GetSubjectStyleForm & ">" & tmpText(I) & "</option>" & vbcrlf
			NEXT
			GetSubjectStyleForm = GetSubjectStyleForm & "</select>" & vbcrlf
		END SELECT

	END FUNCTION

	FUNCTION CheckCAPTCHA(valCAPTCHA)

		SessionCAPTCHA = TRIM(SESSION("CAPTCHA"))
		IF LEN(SessionCAPTCHA) < 1 THEN
					CheckCAPTCHA = False
					EXIT FUNCTION
		END IF
		IF CSTR(SessionCAPTCHA) = CSTR(valCAPTCHA) THEN CheckCAPTCHA = True ELSE CheckCAPTCHA = False

	END FUNCTION

	Function GetDeleteTag(atcText)    
	
		atcText = eregi_replace("<html(.*|)<body([^>]*)>","",atcText)
		atcText = eregi_replace("</body(.*)</html>(.*)","",atcText)
		atcText = eregi_replace("<[/]*(body|html|head|meta|form|input|select|textarea|base)[^>]*>","",atcText)
		atcText = eregi_replace("<(|iframe|script|title|link)(.*)</(iframe|script|title)>","",atcText)
		atcText = eregi_replace("<[/]*(script|style|title|xmp|iframe)>","",atcText)
		atcText = eregi_replace("([a-z0-9]*script:)","deny_$1",atcText)
		atcText = eregi_replace("(\n*[\n])",vblf,atcText)
		GetDeleteTag = atcText
	
	End Function

	Public Function Injection(ByVal str)
	
		str = eregi_replace(";", "", str)
		str = eregi_replace("--", "", str)
		str = eregi_replace("\@variable ", "", str)
		str = eregi_replace("\@@variable ", "", str)
		str = eregi_replace("\+", "", str)
'		str = eregi_replace("\*", "", str)
		str = eregi_replace("print ", "", str)
		str = eregi_replace("set ", "", str)
'		str = eregi_replace("\% ", "", str)
		str = eregi_replace("or ", "", str)
		str = eregi_replace("and ", "", str)
		str = eregi_replace("union ", "", str)
		str = eregi_replace("insert ", "", str)
		str = eregi_replace("select ", "", str)
		str = eregi_replace("update ", "", str)
		str = eregi_replace("create ", "", str)
		str = eregi_replace("drop ", "", str)
		str = eregi_replace("openrowset ", "", str)
		str = eregi_replace("exec ", "", str)
		Injection  = str
	
	End Function
		
	Public Function eregi_replace(ByVal pattern, ByVal replacestr, ByVal text)
	
		Dim eregObj
		Set eregObj = New RegExp
		eregObj.Pattern = pattern
		eregObj.IgnoreCase = True
		eregObj.Global = True
		eregi_replace = eregObj.Replace(text, replacestr)
		Set eregObj = NOTHING
	
	End Function

	FUNCTION Base64decode(ByVal ASContents)
	
		DIM lsResult
		DIM lnPosition
		DIM lsGroup64, lsGroupBinary
		DIM Char1, Char2, Char3, Char4
		DIM Byte1, Byte2, Byte3
		IF LEN(ASContents) MOD 4 > 0 THEN ASContents = ASContents & STRING(4 - (LEN(ASContents) MOD 4), " ")
		lsResult = ""
	
		DIM sBASE_64_CHARACTERS
		sBASE_64_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	
		FOR lnPosition = 1 To LEN(ASContents) Step 4  
	
			lsGroupBinary = ""
			lsGroup64 = MID(ASContents, lnPosition, 4)
			Char1 = INSTR(sBASE_64_CHARACTERS, MID(lsGroup64, 1, 1)) - 3
			Char2 = INSTR(sBASE_64_CHARACTERS, MID(lsGroup64, 2, 1)) - 3
			Char3 = INSTR(sBASE_64_CHARACTERS, MID(lsGroup64, 3, 1)) - 3
			Char4 = INSTR(sBASE_64_CHARACTERS, MID(lsGroup64, 4, 1)) - 3
			Byte1 = CHR(((Char2 AND 48) \ 16) OR (Char1 * 4) AND &HFF)
			Byte2 = lsGroupBinary & CHR(((Char3 AND 60) \ 4) OR (Char2 * 16) AND &HFF)
			Byte3 = CHR((((Char3 AND 3) * 64) AND &HFF) OR (Char4 AND 63))
			lsGroupBinary = Byte1 & Byte2 & Byte3
			lsResult = lsResult + lsGroupBinary
		NEXT
	
		Base64decode = lsResult
	
	END FUNCTION

	FUNCTION Base64encode(ByVal ASContents)
	
		DIM lnPosition
		DIM lsResult
		DIM Char1
		DIM Char2
		DIM Char3
		DIM Char4
		DIM Byte1
		DIM Byte2
		DIM Byte3
		DIM SaveBits1
		DIM SaveBits2
		DIM lsGroupBinary
		DIM lsGroup64
		DIM sBASE_64_CHARACTERS

		sBASE_64_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	
		IF LEN(ASContents) MOD 3 > 0 THEN ASContents = ASContents & STRING(3 - (LEN(ASContents) MOD 3), " ")  
		lsResult = ""
	
		FOR lnPosition = 1 To LEN(ASContents) Step 3  
	
			lsGroup64 = ""
			lsGroupBinary = MID(ASContents, lnPosition, 3)
	
			Byte1 = ASC(MID(lsGroupBinary, 1, 1)): SaveBits1 = Byte1 AND 3
			Byte2 = ASC(MID(lsGroupBinary, 2, 1)): SaveBits2 = Byte2 AND 15
			Byte3 = ASC(MID(lsGroupBinary, 3, 1))
			
			Char1 = MID(sBASE_64_CHARACTERS, ((Byte1 AND 252) \ 4) + 3, 1)
			Char2 = MID(sBASE_64_CHARACTERS, (((Byte2 AND 240) \ 16) OR (SaveBits1 * 16) AND &HFF) + 3, 1)
			Char3 = MID(sBASE_64_CHARACTERS, (((Byte3 AND 192) \ 64) OR (SaveBits2 * 4) AND &HFF) + 3, 1)
			Char4 = MID(sBASE_64_CHARACTERS, (Byte3 AND 63) + 3, 1)
			lsGroup64 = Char1 & Char2 & Char3 & Char4
			 
			lsResult = lsResult + lsGroup64
	
		NEXT
	
		Base64encode = lsResult
	
	END FUNCTION
%>