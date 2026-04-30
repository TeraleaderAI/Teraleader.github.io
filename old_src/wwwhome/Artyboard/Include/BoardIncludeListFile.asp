<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_FILE] '" & READ_strFileCode & "', '' ")

	REDIM FILE_REDIM_FileName(READ_intFileCount)
	REDIM FILE_REDIM_FileSize(READ_intFileCount)
	REDIM FILE_REDIM_FileDown(READ_intFileCount)
	REDIM FILE_REDIM_FileLink(READ_intFileCount)
	REDIM FILE_REDIM_FileExe(READ_intFileCount)
	REDIM FILE_REDIM_FileType(READ_intFileCount)
	REDIM FILE_REDIM_ImageWidth(READ_intFileCount)
	REDIM FILE_REDIM_ImageHeight(READ_intFileCount)
	REDIM FILE_REDIM_ImageZoomLink(READ_intFileCount)
	REDIM FILE_REDIM_ImageSmallLink(READ_intFileCount)
	REDIM FILE_REDIM_strPhotoInfo(READ_intFileCount)

	iCount = 0
	WHILE NOT(RS.EOF)

		iCount = iCount + 1
		FILE_REDIM_FileName(iCount)     = RS("strFileName")
		FILE_REDIM_FileSize(iCount)     = RS("intFileSIze")
		FILE_REDIM_FileDown(iCount)     = RS("intFileDown")
		FILE_REDIM_FileLink(iCount)     = "Library/fileDown.asp?strBoardID=" & strBoardID & "&intNum=" & RS("intNum") & "&intSeq=" & intSeq
		FILE_REDIM_FileExe(iCount)      = GetUploadFileExe(CONF_bitFileExe, strBoardID, RS("strFileName"), CONF_intExeWidth, CONF_intExeHeight, RS("imgWidth"), RS("imgHeight"))
		FILE_REDIM_FileType(iCount)     = RS("intFileType")
		FILE_REDIM_ImageWidth(iCount)   = RS("imgWidth")
		FILE_REDIM_ImageHeight(iCount)  = RS("imgHeight")
		FILE_REDIM_strPhotoInfo(iCount) = RS("strPhotoInfo")

		IF RS("intFileType") = "0" THEN

			IF strImgFirstFile = "" THEN strImgFirstFile = RS("strFileName")

			IF CONF_bitImgLightbox = False THEN
				IF bitViewImageAll = "True" THEN FILE_REDIM_ImageZoomLink(iCount) = "javascript:OnZoomGallery('" & FILE_REDIM_FileName(iCount) & "', '" & strBoardID & "');" ELSE FILE_REDIM_ImageZoomLink(iCount) = "javascript:OnZoomGallery(SET_GALLERY_NOW_IMG, '" & strBoardID & "');"
			ELSE
				FILE_REDIM_ImageZoomLink(iCount) = "Pds/Board/" & strBoardID & "/" & FILE_REDIM_FileName(iCount)
			END IF

				IF CONF_intImgWidth = 0 AND CONF_intImgHeight = 0 THEN
				ELSE
					IF CONF_intImgScare = True THEN
						IF FILE_REDIM_ImageWidth(iCount) > CONF_intImgWidth THEN
							IF CONF_intImgWidth <> 0 THEN
								FILE_REDIM_ImageHeight(iCount) = INT(FILE_REDIM_ImageHeight(iCount) * CONF_intImgWidth / FILE_REDIM_ImageWidth(iCount))
								FILE_REDIM_ImageWidth(iCount) = CONF_intImgWidth
							END IF
						END IF
						IF FILE_REDIM_ImageHeight(iCount) > CONF_intImgHeight THEN
							IF CONF_intImgHeight <> 0 THEN
								FILE_REDIM_ImageWidth(iCount)  = INT(FILE_REDIM_ImageWidth(iCount) * CONF_intImgHeight / FILE_REDIM_ImageHeight(iCount))
								FILE_REDIM_ImageHeight(iCount) = CONF_intImgHeight
							END IF
						END IF
					ELSE
						IF FILE_REDIM_ImageWidth(iCount)  > CONF_intImgWidth  THEN FILE_REDIM_ImageWidth(iCount)  = CONF_intImgWidth
						IF FILE_REDIM_ImageHeight(iCount) > CONF_intImgHeight THEN FILE_REDIM_ImageHeight(iCount) = CONF_intImgHeight
					END IF
				END IF

				FILE_REDIM_ImageSmallLink(iCount) = "javascript:OnGalleryChange('" & intSeq & "','" & FILE_REDIM_FileName(iCount) & "','" & FILE_REDIM_ImageWidth(iCount) & "','" & FILE_REDIM_ImageHeight(iCount) & "','" & strBoardID & "');"

		END IF

	RS.MOVENEXT
	WEND
%>