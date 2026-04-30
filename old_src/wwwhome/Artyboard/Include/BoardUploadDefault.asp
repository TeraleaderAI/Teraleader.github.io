<!-- #include file = "../DBConnect/DBconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<!-- #include file = "../Include/UploadInclude.asp" -->
<%
	Server.ScriptTimeout = 100000

	DIM strPath, strFileName, strBoardID, strSessionID, I, strFileField

	strBoardID   = REQUEST.QueryString("strBoardID")
	strSessionID = REQUEST.QueryString("strSessionID")

	strPath = rootPath & "Pds\Board\" & strBoardID & "\"

	IF UPLOAD("strFileName").COUNT > 0 THEN

		DIM intUploadSize, strUploadNotFile, bitUploadReplaceFile, strUploadReplaceFile, bitThrum, intThrumWidth
		DIM intThrumHeight, bitThrumScale, strThrumProg, bitUseWaterMark, strWaterMarkType, strWaterMarkCont, bitUseExif

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_WRITE] '" & strBoardID & "' ")

		intUploadSize        = INT(RS("intUploadSize") * 1048576)
		strUploadNotFile     = RS("strUploadNotFile")
		bitUploadReplaceFile = RS("bitUploadReplaceFile")
		strUploadReplaceFile = RS("strUploadReplaceFile")
		bitThrum             = RS("bitThrum")
		intThrumWidth        = RS("intThrumWidth")
		intThrumHeight       = RS("intThrumHeight")
		bitThrumScale        = RS("bitThrumScale")
		strThrumProg         = RS("strThrumProg")
		bitUseWaterMark      = RS("bitUseWaterMark")
		strWaterMarkType     = RS("strWaterMarkType")
		strWaterMarkCont     = RS("strWaterMarkCont")
		bitUseExif           = RS("bitUseExif")

		DIM intFileType, intFileSize, imgWidth, imgHeight

		FOR I = 1 TO UPLOAD("strFileName").COUNT

			SET strFileField = UPLOAD("strFileName")(I)

			IF checkImageFileField(setUploadComponet, strFileField) = True THEN

				strFileName = ExecFIleUpload(setUploadComponet, strFileField, intUploadSize, strPath, "", False, "", bitThrum, intThrumWidth, intThrumHeight, bitThrumScale, strThrumProg, bitUseWaterMark, strWaterMarkType, strWaterMarkCont)
				intFileType = "0"
				intFileSize = ExecFIleUploadSize(setUploadComponet, strFileField)
				imgWidth    = strFileField.ImageWidth
				imgHeight   = strFileField.ImageHeight

				IF bitUseExif = True AND setUploadComponet = "2" THEN
		
					SET objImage = SERVER.CreateObject("DEXT.ImageProc")
					IF True = objImage.SetSourceFile(strPath & strFileName) THEN
		
						strPhotoInfo = ""
						strPhotoInfo = strPhotoInfo & "Image Format:" & objimage.ImageFormat & "$"
						strPhotoInfo = strPhotoInfo & "VerticalResolution:" & objimage.VerticalResolution & "$"
						strPhotoInfo = strPhotoInfo & "HorizontalResolution:" & objImage.VerticalResolution & "$"
						strPhotoInfo = strPhotoInfo & "Image Height:" & objimage.ImageHeight & "$"
						strPhotoInfo = strPhotoInfo & "Image Width:" & objimage.ImageWidth & "$"
						strPhotoInfo = strPhotoInfo & "Pixel Format:" & objimage.PixelFormat & "$"
						strPhotoInfo = strPhotoInfo & "Equipment Maker(제조사):" & objImage.MDEquipMake & "$"
						strPhotoInfo = strPhotoInfo & "Equipment Model(모델):" & objImage.MDEquipModel & "$"
						strPhotoInfo = strPhotoInfo & "Image Description:" & objImage.MDImageDescription & "$"
						strPhotoInfo = strPhotoInfo & "Image Document Name:" & objImage.MDDocumentName & "$"
						strPhotoInfo = strPhotoInfo & "Software Used:" & objImage.MDSoftwareUsed & "$"
						strPhotoInfo = strPhotoInfo & "Artist:" & objImage.MDArtist & "$"
						strPhotoInfo = strPhotoInfo & "Date Time:" & objImage.MDDateTime & "$"
						strPhotoInfo = strPhotoInfo & "Color Space:" & objImage.MDExifColorSpace & "$"
						strPhotoInfo = strPhotoInfo & "Exposed Time:" & objImage.MDExifExposureTime & "$"
						strPhotoInfo = strPhotoInfo & "Flash:" & objImage.MDExifFlash & "$"
						strPhotoInfo = strPhotoInfo & "Shutter Speed" & objImage.MDExifShutterSpeed & "$"
						strPhotoInfo = strPhotoInfo & "조리개 값:" & objImage.MDExifFNumber & "$"
						strPhotoInfo = strPhotoInfo & "ISO 속도:" & objImage.MDExifISOSpeed & "$"
						strPhotoInfo = strPhotoInfo & "초점 거리:" & objImage.MDExifFocalLength & "$"
						strPhotoInfo = strPhotoInfo & "노출 모드:" & objImage.MDExifExposureProg
						SET objImage = NOTHING
					
					END IF
		
				END IF

			ELSE
				strFileName = ExecFileUpload(setUploadComponet, strFileField, intUploadSize, strPath, strUploadNotFile, bitUploadReplaceFile, strUploadReplaceFile, False, 0, 0, False, "2", False, "", "")
				intFileType = "1"
				intFileSize = ExecFIleUploadSize(setUploadComponet, strFileField)
				imgWidth    = 0
				imgHeight   = 0
			END IF

			IF strFileName <> False THEN DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_FILE_TEMP] ([sessionID], [strBoardID], [intFileType], [strFileName], [intFileSize], [imgWidth], [imgHeight], [strPhotoInfo]) VALUES ('" & strSessionID & "', '" & strBoardID & "', '" & intFileType & "', '" & strFileName & "', '" & intFileSize & "', '" & imgWidth & "', '" & imgHeight & "', '" & strPhotoInfo & "') ")

		NEXT

	END IF

	RESPONSE.WRITE "<script language=javascript>" & vbcrlf
	RESPONSE.WRITE "	parent.show_waiting();" & vbcrlf
	RESPONSE.WRITE "	parent.document.theForm.submit();" & vbcrlf
	RESPONSE.WRITE "</script>" & vbcrlf
	RESPONSE.End()

	SET UPLOAD = NOTHING : SET RS = NOTHING : DBCON.CLOSE
%>