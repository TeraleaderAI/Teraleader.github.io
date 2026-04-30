<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Member/MemberSendMail.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM strMailType, bitSend, strName, strMail, strSubject, strContent, strContentBg

	strMailType = REQUEST.QueryString("strMailType")

	WITH REQUEST
	
		bitSend      = .FORM("bitSend")
		strName      = GetReplaceInput(.FORM("strName"), "")
		strMail      = GetReplaceInput(.FORM("strMail"), "")
		strSubject   = GetReplaceInput(.FORM("strSubject"), "")
		strContent   = GetReplaceInput(.FORM("strContent"), "")
		strContentBg = GetReplaceInput(.FORM("strContentBg"),"")
	
	END WITH

	DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_MAIL] SET [bitSend] = '" & bitSend & "', [strName] = '" & strName & "', [strMail] = '" & strMail & "', [strSubject] = '" & strSubject & "', [strContent] = '" & strContent & "', [strContentBg] = '" & strContentBg & "' WHERE [strMailType] = '" & strMailType & "' ")

	RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "MemberSendMail.asp?strMailType=" & strMailType, "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>