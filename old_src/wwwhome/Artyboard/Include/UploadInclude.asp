<%
	DIM UPLOAD
	SELECT CASE setUploadComponet
	CASE "1"
		SET UPLOAD = SERVER.CREATEOBJECT("ABCUpload4.XForm")
		UPLOAD.AbsolutePath = True
		UPLOAD.MaxUploadSize = 524288000
		UPLOAD.Overwrite = False
	CASE "2"
		SET UPLOAD = SERVER.CREATEOBJECT("DEXT.FileUpload")
		UPLOAD.DefaultPath = rootPath & "Pds\"
	CASE "3"
		SET UPLOAD = SERVER.CREATEOBJECT("TABS.Upload")
		UPLOAD.START rootPath & "Pds\"
	END SELECT
%>