<!-- #include file = "../DBConnect/DBconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<!-- #include file = "../Include/UploadInclude.asp" -->
<%
	DIM strPath, strFileName, strParmData, strBoardID, strSessionID

	tmpParData   = SPLIT(REQUEST.QueryString("strParmData"), "|")
	strBoardID   = tmpParData(0)
	strSessionID = tmpParData(1)

	strPath = rootPath & "Pds\Board\" & strBoardID & "\"

	UPLOAD.CodePage      = 65001
	Server.ScriptTimeout = 100000

	SET strFileField = UPLOAD("file")

	DIM strUploadNotFile, bitUploadReplaceFile, strUploadReplaceFile, bitThrum, intThrumWidth, intThrumHeight, bitThrumScale
	DIM strThrumProg, bitUseWaterMark, strWaterMarkType, strWaterMarkCont, bitUseExif, strPhotoInfo

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_WRITE] '" & strBoardID & "' ")

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

	IF checkImageFileField(setUploadComponet, strFileField) = True THEN

		strFileName = ExecFIleUpload(setUploadComponet, strFileField, 104857600000, strPath, "", False, "", bitThrum, intThrumWidth, intThrumHeight, bitThrumScale, strThrumProg, bitUseWaterMark, strWaterMarkType, strWaterMarkCont)
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
		strFileName = ExecFileUpload(setUploadComponet, strFileField, 104857600000, strPath, strUploadNotFile, bitUploadReplaceFile, strUploadReplaceFile, False, 0, 0, False, "2", False, "", "")
		intFileType = "1"
		intFileSize = ExecFIleUploadSize(setUploadComponet, strFileField)
		imgWidth    = 0
		imgHeight   = 0
	END IF

	IF strFileName = False THEN
		RESPONSE.WRITE "False"
		RESPONSE.End()
	ELSE
		DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_FILE_TEMP] ([sessionID], [strBoardID], [intFileType], [strFileName], [intFileSize], [imgWidth], [imgHeight], [strPhotoInfo]) VALUES ('" & strSessionID & "', '" & strBoardID & "', '" & intFileType & "', '" & strFileName & "', '" & intFileSize & "', '" & imgWidth & "', '" & imgHeight & "', '" & strPhotoInfo & "') ")
		RESPONSE.WRITE strSessionID
		RESPONSE.End()
	END IF

	SET UPLOAD = NOTHING : SET RS = NOTHING : DBCON.CLOSE
%>