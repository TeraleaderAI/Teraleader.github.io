<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Member/MemberMailingList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM Action, intNum, strName, strMail, strSubject, strContent, strContentBg, strMsg

	WITH REQUEST
	
		Action       = .QueryString("Action")
		intNum       = .QueryString("intNum")
		strName      = GetReplaceInput(.FORM("strName"), "")
		strMail      = GetReplaceInput(.FORM("strMail"), "")
		strSubject   = GetReplaceInput(.FORM("strSubject"), "")
		strContent   = GetReplaceInput(.FORM("strContent"), "")
		strContentBg = .FORM("strContentBg")
	
	END WITH

	SELECT CASE UCASE(Action)
	CASE "ADD"
		DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_MAIL] ([strMailType], [bitSend], [strName], [strMail], [strSubject], [strContent], [strContentBg]) VALUES ('2', '0', '" & strName & "', '" & strMail & "', '" & strSubject & "', '" & strContent & "', '" & strContentBg & "') ")
		strMsg = "메일링 등록이 완료되었습니다."
	CASE "EDIT"
		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_MAIL] SET [strName] = '" & strName & "', [strMail] = '" & strMail & "', [strSubject] = '" & strSubject & "', [strContent] = '" & strContent & "', [strContentBg] = '" & strContentBg & "' WHERE [intNum] = '" & intNum & "' ")
		strMsg = "메일링 정보수정이 완료되었습니다."
	CASE "REMOVE"
		DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_MAIL] WHERE [intNum] = '" & intNum & "' ")
		strMsg = "메일링 삭제가 완료되었습니다."
	END SELECT

	RESPONSE.WRITE ExecFormSubmit(strMsg, "MemberMailingList.asp", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>