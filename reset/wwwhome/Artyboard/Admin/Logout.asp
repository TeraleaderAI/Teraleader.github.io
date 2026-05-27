<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	SESSION("strLoginID")   = ""
	SESSION("strLoginName") = ""
	SESSION("strAdmin")     = ""

	RESPONSE.WRITE ExecFormSubmit("로그아웃 되었습니다.", "Login.asp", "")
	RESPONSE.End()
	
	SET RS = NOTHING : DBCON.CLOSE
%>