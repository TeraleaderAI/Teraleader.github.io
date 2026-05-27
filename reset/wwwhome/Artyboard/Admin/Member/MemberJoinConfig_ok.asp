<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Member/MemberJoinConfig.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM strSkin, strDefaultGroupCode, intJoinPoint, intRecPoint, bitJoinEmail, strJoinType, strHeadFile, strTailFile, strHeadText
	DIM strTailText, strWidth, strAlign, strJoinNotMsg, strJoinMsg, bitJoinResult, strJoinScript, strJoinUrl, strJoinUrlTarget
	DIM strEditMsg, strEditScript, strEditUrl, strEditUrlTarget, bitOutType, strOutMsg, strOutScript, strOutUrl, strOutUrlTarget
	DIM strJoinNotEmail, SELECTED, bitJoinEmailActivate, strActivateSubject, strActivateContent

	WITH REQUEST

		strSkin              = GetReplaceInput(.FORM("strSkin"), "")
		strDefaultGroupCode  = GetReplaceInput(.FORM("strDefaultGroupCode"), "")
		intJoinPoint         = .FORM("intJoinPoint")
		IF intJoinPoint = "" THEN intJoinPoint = 0
		intRecPoint          = .FORM("intRecPoint")
		IF intRecPoint = "" THEN intRecPoint = 0
		bitJoinEmail         = .FORM("bitJoinEmail")
		IF bitJoinEmail = "" THEN bitJoinEmail = 0
		strJoinType          = GetReplaceInput(.FORM("strJoinType"), "")
		bitJoinEmailActivate = .FORM("bitJoinEmailActivate")
		IF bitJoinEmailActivate = "" THEN bitJoinEmailActivate = 0
		strActivateSubject   = GetReplaceInput(.FORM("strActivateSubject"), "")
		strActivateContent   = GetReplaceInput(.FORM("strActivateContent"), "")
		strHeadFile          = GetReplaceInput(.FORM("strHeadFile"), "")
		strTailFile          = GetReplaceInput(.FORM("strTailFile"), "")
		strHeadText          = GetReplaceInput(.FORM("strHeadText"), "")
		strTailText          = GetReplaceInput(.FORM("strTailText"), "")
		strWidth             = GetReplaceInput(.FORM("strWidth"), "")
		strAlign             = GetReplaceInput(.FORM("strAlign"), "")
		strJoinNotMsg        = GetReplaceInput(.FORM("strJoinNotMsg"), "")
		bitJoinResult        = .FORM("bitJoinResult")
		strJoinMsg           = GetReplaceInput(.FORM("strJoinMsg"), "")
		strJoinScript        = GetReplaceInput(.FORM("strJoinScript"), "N")
		strJoinUrl           = GetReplaceInput(.FORM("strJoinUrl"), "")
		strJoinUrlTarget     = .FORM("strJoinUrlTarget")
		strEditMsg           = GetReplaceInput(.FORM("strEditMsg"), "")
		strEditScript        = GetReplaceInput(.FORM("strEditScript"), "N")
		strEditUrl           = GetReplaceInput(.FORM("strEditUrl"), "")
		strEditUrlTarget     = .FORM("strEditUrlTarget")
		bitOutType           = .FORM("bitOutType")
		strOutMsg            = GetReplaceInput(.FORM("strOutMsg"), "")
		strOutScript         = GetReplaceInput(.FORM("strOutScript"), "N")
		strOutUrl            = GetReplaceInput(.FORM("strOutUrl"), "")
		strOutUrlTarget      = .FORM("strOutUrlTarget")
		strJoinNotEmail      = GetReplaceInput(.FORM("strJoinNotEmail"), "")

	END WITH

	DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_CONFIG_JOIN] SET [strSkin] = '" & strSkin & "', [strDefaultGroupCode] = '" & strDefaultGroupCode & "', [intJoinPoint] = " & intJoinPoint & ", [intRecPoint] = " & intRecPoint & ", [bitJoinEmail] = '" & bitJoinEmail & "', [strJoinType] = '" & strJoinType & "', [bitJoinEmailActivate] = '" & bitJoinEmailActivate & "', [strActivateSubject] = '" & strActivateSubject & "', [strActivateContent] = '" & strActivateContent & "', [strHeadFile] = '" & strHeadFile & "', [strTailFile] = '" & strTailFile & "', [strHeadText] = '" & strHeadText & "', [strTailText] = '" & strTailText & "', [strWidth] = '" & strWidth & "', [strAlign] = '" & strAlign & "', [strJoinNotMsg] = '" & strJoinNotMsg  & "', [bitJoinResult] = '" & bitJoinResult & "', [strJoinMsg] = '" & strJoinMsg & "', [strJoinScript] = '" & strJoinScript & "', [strJoinUrl] = '" & strJoinUrl & "', [strJoinUrlTarget] = '" & strJoinUrlTarget & "', [strEditMsg] = '" & strEditMsg & "', [strEditScript] = '" & strEditScript & "', [strEditUrl] = '" & strEditUrl & "', [strEditUrlTarget] = '" & strEditUrlTarget & "', [bitOutType] = '" & bitOutType & "', [strOutMsg] = '" & strOutMsg & "', [strOutScript] = '" & strOutScript & "', [strOutUrl] = '" & strOutUrl & "', [strOutUrlTarget] = '" & strOutUrlTarget & "', [strJoinNotEmail] = '" & strJoinNotEmail & "' ")

	RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "MemberJoinConfig.asp", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>