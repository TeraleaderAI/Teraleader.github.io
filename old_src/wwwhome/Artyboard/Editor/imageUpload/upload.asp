<% 
Response.Expires = -1
Server.ScriptTimeout = 600
%>
<!-- #include file="fileUploadClass.asp" -->
<!-- #include file = "../../DBConnect/DBconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM strPath
	strPath = rootPath & REPLACE(REQUEST.QueryString("strPath"), "/", "\")

	CALL ExecFolderMake(strPath)

	SELECT CASE setUploadComponet
	CASE "2"
%>
<!-- #include file = "../../Include/UploadInclude.asp" -->
<%
		UPLOAD.CodePage      = 65001
		Server.ScriptTimeout = 100000
	
		SET strFileField = UPLOAD("file")
	
		DIM intFileType, intFileSize, imgWidth, imgHeight
	
		IF checkImageFileField(setUploadComponet, strFileField) = True THEN
			strFileName = ExecFIleUpload(setUploadComponet, strFileField, 104857600000, strPath, "", False, "", False, 0, 0, False, "", False, "", "")
			intFileType = "0"
			intFileSize = ExecFIleUploadSize(setUploadComponet, strFileField)
			imgWidth    = strFileField.ImageWidth
			imgHeight   = strFileField.ImageHeight
		END IF
	
		RESPONSE.WRITE "{ fileUrl: '" & httpPath & REQUEST.QueryString("strPath") & strFileName & "', filePath: '" & REQUEST.QueryString("strPath") & strFileName & "', origName: '" & strFileName & "', fileName: '" & strFileName & "', fileSize: '" & intFileSize & "' }"
		RESPONSE.End()
	
		SET UPLOAD = NOTHING : SET RS = NOTHING : DBCON.CLOSE

	CASE ELSE

		Dim UPLOAD_PATH, UPLOAD_URL
		
		UPLOAD_PATH = strPath
		UPLOAD_URL = httpPath & REQUEST.QueryString("strPath")
	
		SaveFiles()
		
		function SaveFiles
				Dim Upload, fileName, fileSize, K, i
		
				Set Upload = New fileUploadClass
				Upload.Save(UPLOAD_PATH)
		
			If Err.Number <> 0 then Exit function
				
				K = Upload.UploadedFiles.keys
				if (UBound(K) <> -1) then
						for each i in Upload.UploadedFiles.keys

							response.write "{ fileUrl:  '" & httpPath & REQUEST.QueryString("strPath") & Upload.UploadedFiles(i).FileName 
							response.write "',filePath: '" & REQUEST.QueryString("strPath") & Upload.UploadedFiles(i).FileName 
							response.write "',origName: '" & Upload.UploadedFiles(i).origName 
							response.write "',fileName: '" & Upload.UploadedFiles(i).FileName 
							response.write "',fileSize: '" & Upload.UploadedFiles(i).Length & "'}"

						next
				end if
			
		end function
	END SELECT
%>