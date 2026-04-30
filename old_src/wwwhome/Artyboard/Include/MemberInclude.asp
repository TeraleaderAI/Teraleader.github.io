<!--METADATA TYPE="typelib" NAME="ADODB Type Library" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"-->
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM Action
	Action = UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_GROUP_MEMBER] ")

	DIM bitMemberInfo, intMemberInfoLevel, bitMemberAvata, intMemberAvataLevel, bitMemoUse, intMemoUseLevel, bitMemoSend, intMemoSendLevel
	DIM bitMemoRead, intMemoReadLevel, strErrorUrl, strErrorUrlTarget, strErrorMsg

	bitMemberInfo       = RS("bitMemberInfo")
	intMemberInfoLevel  = RS("intMemberInfoLevel")
	bitMemberAvata      = RS("bitMemberAvata")
	intMemberAvataLevel = RS("intMemberAvataLevel")
	bitMemoUse          = RS("bitMemoUse")
	intMemoUseLevel     = RS("intMemoUseLevel")
	bitMemoSend         = RS("bitMemoSend")
	intMemoSendLevel    = RS("intMemoSendLevel")
	bitMemoRead         = RS("bitMemoRead")
	intMemoReadLevel    = RS("intMemoReadLevel")
	strErrorUrl         = RS("strErrorUrl")
	strErrorUrlTarget   = RS("strErrorUrlTarget")
	strErrorMsg         = RS("strErrorMsg")
%>