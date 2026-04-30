<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Member/MemberGroupSet.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM bitMemberInfo, intMemberInfoLevel, bitMemberAvata, intMemberAvataLevel, bitMemoUse, intMemoUseLevel, bitMemoSend, intMemoSendLevel
	DIM bitMemoRead, intMemoReadLevel, bitBoardScrap, intBoardScrapLevel, strErrorUrl, strErrorUrlTarget, strErrorMsg

	WITH REQUEST
	
		bitMemberInfo       = .FORM("bitMemberInfo")
		intMemberInfoLevel  = .FORM("intMemberInfoLevel")
		bitMemberAvata      = .FORM("bitMemberAvata")
		intMemberAvataLevel = .FORM("intMemberAvataLevel")
		bitMemoUse          = .FORM("bitMemoUse")
		intMemoUseLevel     = .FORM("intMemoUseLevel")
		bitMemoSend         = .FORM("bitMemoSend")
		intMemoSendLevel    = .FORM("intMemoSendLevel")
		bitMemoRead         = .FORM("bitMemoRead")
		intMemoReadLevel    = .FORM("intMemoReadLevel")
		bitBoardScrap       = .FORM("bitBoardScrap")
		intBoardScrapLevel  = .FORM("intBoardScrapLevel")
		strErrorUrl         = GetReplaceInput(.FORM("strErrorUrl"), "")
		strErrorUrlTarget   = GetReplaceInput(.FORM("strErrorUrlTarget"), "")
		strErrorMsg         = GetReplaceInput(.FORM("strErrorMsg"), "")

		IF bitMemberInfo  = "" THEN bitMemberInfo  = "0"
		IF bitMemberAvata = "" THEN bitMemberAvata = "0"
		IF bitMemoUse     = "" THEN bitMemoUse     = "0"
		IF bitMemoSend    = "" THEN bitMemoSend    = "0"
		IF bitMemoRead    = "" THEN bitMemoRead    = "0"
		IF bitBoardScrap  = "" THEN bitBoardScrap  = "0"

	END WITH

	DBCON.EXECUTE("UPDATE [MPLUS_GROUP_MEMBER] SET [bitMemberInfo] = '" & bitMemberInfo & "', [intMemberInfoLevel] = '" & intMemberInfoLevel & "', [bitMemberAvata] = '" & bitMemberAvata & "', [intMemberAvataLevel] = '" & intMemberAvataLevel & "', [bitMemoUse] = '" & bitMemoUse & "', [intMemoUseLevel] = '" & intMemoUseLevel & "', [bitMemoSend] = '" & bitMemoSend & "', [intMemoSendLevel] = '" & intMemoSendLevel & "', [bitMemoRead] = '" & bitMemoRead & "', [intMemoReadLevel] = '" & intMemoReadLevel & "', [bitBoardScrap] = '" & bitBoardScrap & "', [intBoardScrapLevel] = '" & intBoardScrapLevel & "', [strErrorUrl] = '" & strErrorUrl & "', [strErrorUrlTarget] = '" & strErrorUrlTarget & "', [strErrorMsg] = '" & strErrorMsg & "' ")

	RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "MemberGroupSet.asp", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>