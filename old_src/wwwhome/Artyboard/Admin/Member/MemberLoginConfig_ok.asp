<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Member/MemberLoginConfig.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM intLogOutTime, intLoginPoint, strLoginType, strLoginLinkTarget, strLoginMsg, strLoginScript, strLoginUrl
	DIM strLoginUrlTarget, strLoginErrorMsg1, strLoginErrorMsg2, strLoginErrorScript, strLoginErrorUrl, strLoginErrorUrlTarget
	DIM strLogOutMsg, strLogOutScript, strLogOutUrl, strLogOutUrlTarget, strWidth, strAlign, strSkin

	WITH REQUEST

		strSkin                = GetReplaceInput(.FORM("strSkin"), "")
		strHeadFile            = GetReplaceInput(.FORM("strHeadFile"), "")
		strTailFile            = GetReplaceInput(.FORM("strTailFile"), "")
		strHeadText            = GetReplaceInput(.FORM("strHeadText"), "")
		strTailText            = GetReplaceInput(.FORM("strTailText"), "")
		strWidth               = GetReplaceInput(.FORM("strWidth"), "")
		strAlign               = GetReplaceInput(.FORM("strAlign"), "")
		intLogOutTime          = .FORM("intLogOutTime")
		IF intLogOutTime = "" THEN intLogOutTime = 0
		intLoginPoint          = .FORM("intLoginPoint")
		IF intLoginPoint = "" THEN intLoginPoint = 0
		strLoginType           = GetReplaceInput(.FORM("strLoginType"), "")
		strLoginLinkTarget     = GetReplaceInput(.FORM("strLoginLinkTarget"), "")
		strLoginMsg            = GetReplaceInput(.FORM("strLoginMsg"), "")
		strLoginScript         = GetReplaceInput(.FORM("strLoginScript"), "N")
		strLoginUrl            = GetReplaceInput(.FORM("strLoginUrl"), "")
		strLoginUrlTarget      = .FORM("strLoginUrlTarget")
		strLoginErrorMsg1      = GetReplaceInput(.FORM("strLoginErrorMsg1"), "")
		strLoginErrorMsg2      = GetReplaceInput(.FORM("strLoginErrorMsg2"), "")
		strLoginErrorScript    = GetReplaceInput(.FORM("strLoginErrorScript"), "N")
		strLoginErrorUrl       = GetReplaceInput(.FORM("strLoginErrorUrl"), "")
		strLoginErrorUrlTarget = .FORM("strLoginErrorUrlTarget")
		strLogOutMsg           = GetReplaceInput(.FORM("strLogOutMsg"), "")
		strLogOutScript        = GetReplaceInput(.FORM("strLogOutScript"), "N")
		strLogOutUrl           = GetReplaceInput(.FORM("strLogOutUrl"), "")
		strLogOutUrlTarget     = .FORM("strLogOutUrlTarget")
		bitUseSsnFindID        = .FORM("bitUseSsnFindID")
		IF bitUseSsnFindID = "" THEN bitUseSsnFindID = "0"
		bitUseSsnFindPW        = .FORM("bitUseSsnFindPW")
		IF bitUseSsnFindPW = "" THEN bitUseSsnFindPW = "0"
		bitFindEmail           = .FORM("bitFindEmail")
		IF bitFindEmail    = "" THEN bitFindEmail    = "0"

	END WITH

	DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_CONFIG_LOGIN] SET [intLogOutTime] = '" & intLogOutTime & "', [intLoginPoint] = " & intLoginPoint & ", [strLoginType] = '" & strLoginType & "', [strLoginLinkTarget] = '" & strLoginLinkTarget & "', [strLoginMsg] = '" & strLoginMsg & "', [strLoginScript] = '" & strLoginScript & "', [strLoginUrl] = '" & strLoginUrl & "', [strLoginUrlTarget] = '" & strLoginUrlTarget & "', [strLoginErrorMsg1] = '" & strLoginErrorMsg1 & "', [strLoginErrorMsg2] = '" & strLoginErrorMsg2 & "', [strLoginErrorScript] = '" & strLoginErrorScript & "', [strLoginErrorUrl] = '" & strLoginErrorUrl & "', [strLoginErrorUrlTarget] = '" & strLoginErrorUrlTarget & "', [strLogOutMsg] = '" & strLogOutMsg & "', [strLogOutScript] = '" & strLogOutScript & "', [strLogOutUrl] = '" & strLogOutUrl & "', [strLogOutUrlTarget] = '" & strLogOutUrlTarget & "', [strWidth] = '" & strWidth & "', [strAlign] = '" & strAlign & "', [strSkin] = '" & strSkin & "', [bitUseSsnFindID] = '" & bitUseSsnFindID & "', [bitUseSsnFindPW] = '" & bitUseSsnFindPW & "', [bitFindEmail] = '" & bitFindEmail & "', [strHeadFile] = '" & strHeadFile & "', [strTailFile] = '" & strTailFile & "', [strHeadText] = '" & strHeadText & "', [strTailText] = '" & strTailText & "' ")

	RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "MemberLoginConfig.asp", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>