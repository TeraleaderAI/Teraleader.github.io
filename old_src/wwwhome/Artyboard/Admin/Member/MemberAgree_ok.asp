<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Member/MemberAgree.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM strType, strCssLink, strCssContent, strContent

	strType       = REQUEST.FORM("strType")
	strCssLink    = GetReplaceInput(REQUEST.FORM("strCssLink"), "")
	strCssContent = GetReplaceInput(REQUEST.FORM("strCssContent"), "")
	strContent    = GetReplaceInput(REQUEST.FORM("strContent"), "")

	DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_AGREE] SET [strCssLink] = '" & strCssLink & "', [strCssContent] = '" & strCssContent & "', [strContent] = '" & strContent & "' WHERE [strType] = '" & strType & "' ")

	RESPONSE.WRITE ExecFormSubmitHidden("정상적으로 적용되었습니다.", "<input type=hidden name=strType value=" & strType & ">", "MemberAgree.asp", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>