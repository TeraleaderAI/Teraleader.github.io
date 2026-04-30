<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Other/ScrapList.asp"
%>
<%
	DBCON.EXECUTE("DELETE FROM [MPLUS_SCRAP_LIST] WHERE [intSeq] = '" & REQUEST.QueryString("intSeq") & "' ")

	RESPONSE.WRITE ExecFormSubmit("정상적으로 삭제되었습니다.", "ScrapList.asp", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>