<HTML>
<HEAD>
<TITLE>▒▒▒ 이미지 파일삭제 ▒▒▒</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"></HEAD>
<BODY bgcolor="#FFFFFF">
<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM stLoginID
	strLoginID = REQUEST.QueryString("strLoginID")

	IF SESSION("strAdmin") = "" THEN
		RESPONSE.WRITE ExecJavaAlert("로그인 후 이용하시기 바랍니다.", 1)
		RESPONSE.End()
	END IF

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & strLoginID & "', '0' ")

	SELECT CASE GetReplaceInput(REQUEST.QueryString("sType"), "S")
	CASE "1"
		IF RS("strPhotoFile") <> "" AND ISNULL(RS("strPhotoFile")) = False THEN
			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strPhotoFile] = '' WHERE [strLoginID] = '" & strLoginID & "' ")
			CALL ExecFileDelete(rootPath & "Pds\Member\Photo\", RS("strPhotoFile"))
		END IF
	CASE "2"
		IF RS("strNameFile") <> "" AND ISNULL(RS("strNameFile")) = False THEN
			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strNameFile] = '' WHERE [strLoginID] = '" & strLoginID & "' ")
			CALL ExecFileDelete(rootPath & "Pds\Member\Name\", RS("strNameFile"))
		END IF
	END SELECT

	RESPONSE.WRITE "<script language=javascript>" & vbcrlf
	RESPONSE.WRITE "alert('삭제되었습니다');" & vbcrlf
	RESPONSE.WRITE "window.returnValue=1;" & vbcrlf
	RESPONSE.WRITE "self.close();" & vbcrlf
	RESPONSE.WRITE "</script>" & vbcrlf
%>
<% SET RS = NOTHING : DBCON.CLOSE %>
</BODY>
</HTML>