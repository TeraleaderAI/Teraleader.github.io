<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	RESPONSE.EXPIRES     = 0
	SERVER.SCRIPTTIMEOUT = 2000

	DIM intSeq
	intSeq = GetReplaceInput(REQUEST.QueryString("intSeq"), "S")
%>
<!-- #include file = "../Include/UploadInclude.asp" -->
<%
	DIM recvEamilCc, recvEamilBcc, sendName, sendMail, strSubject, strOption, strLetter, strContent

	WITH UPLOAD

		recvEamilCc  = UPLOAD("recvEamilCc")
		recvEamilBcc = UPLOAD("recvEamilBcc")
		sendName     = GetReplaceInput(UPLOAD("sendName"), "")
		sendMail     = UPLOAD("sendMail")
		strSubject   = GetReplaceInput(UPLOAD("strSubject"), "")
		strOption    = UPLOAD("strOption")
		strLetter    = UPLOAD("strLetter")
		strContent   = GetReplaceInput(UPLOAD("strContent"), "")

	END WITH

	IF strOption = "text" THEN strContent = GetReplaceTag2Text(strContent) ELSE strContent = GetReplaceTag2Html(strContent)

	DIM strPath, strFileCode
	strPath     = rootPath & "Pds\Mail\"

	DIM theField1, theField2
	SET theField1 = UPLOAD("sendFileName1")(1)
	SET theField2 = UPLOAD("sendFileName2")(1)

	sendFileName1 = ExecFIleUpload(setUploadComponet, theField1, 10485760, strPath, "", False, "", False, "", "", False, "0", False, "0", "")
	sendFileName2 = ExecFIleUpload(setUploadComponet, theField2, 10485760, strPath, "", False, "", False, "", "", False, "0", False, "0", "")

	IF sendFileName1 = False OR ISNULL(sendFileName1) = True THEN sendFileName1 = "" ELSE sendFileName1 = strPath & sendFileName1
	IF sendFileName2 = False OR ISNULL(sendFileName2) = True THEN sendFileName2 = "" ELSE sendFileName2 = strPath & sendFileName2

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_READ_DEFAULT] '" & intSeq & "' ")
	
	CALL sendEmail(sendName, sendMail, RS("strName"), RS("strEmail"), strSubject, GetReplaceTag2Html(strContent), recvEamilBcc, recvEamilCc, sendFileName1, sendFileName2)

	SET RS = NOTHING : DBCON.CLOSE

	RESPONSE.WRITE ExecJavaAlert("메일 발송이 완료되었습니다.", 1)
	RESPONSE.End()
%>