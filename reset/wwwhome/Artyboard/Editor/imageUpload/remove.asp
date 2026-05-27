<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../DBConnect/DBconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM strPath, strFileName, strRemoveFile

	strPath       = rootPath & REPLACE(REQUEST.QueryString("strPath"), "/", "\")
	strFileName   = SPLIT(REQUEST.QueryString("img"), "/")
	strRemoveFile = strFileName(UBOUND(strFileName))

	CALL ExecFileDelete(strPath, strRemoveFile)

	RESPONSE.WRITE strRemoveFile
	RESPONSE.End()
%>