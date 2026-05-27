<!--METADATA TYPE="typelib" NAME="ADODB Type Library" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"-->
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_SCRAP_CONFIG] ")

	DIM CONF_strSkin, CONF_strSkinGroup, skinPath, CONF_intLineCount, CONF_intPageCount, CONF_strPagePrevGroup
	DIM CONF_strPageNextGroup, CONF_strPageFirstPage, CONF_strPageEndPage, CONF_strPageNow, CONF_strPageDefault
	DIM intPage

	CONF_strSkin          = RS("strSkin")
	CONF_strSkinGroup     = RS("strSkinGroup")
	skinPath              = GetSkinPath(CONF_strSkin, 2, CONF_strSkinGroup, 1) & "/"
	CONF_strWidth         = RS("strWidth")
	CONF_strAlign         = GetAlignSet(RS("strAlign"))
	CONF_intLineCount     = RS("intLineCount")
	CONF_intPageCount     = RS("intPageCount")

	CONF_strPagePrevGroup = RS("strPagePrevGroup")
	CONF_strPageNextGroup = RS("strPageNextGroup")
	CONF_strPageFirstPage = RS("strPageFirstPage")
	CONF_strPageEndPage   = RS("strPageEndPage")
	CONF_strPageNow       = RS("strPageNow")
	CONF_strPageDefault   = RS("strPageDefault")

	intPage = GetReplaceInput(REQUEST.QueryString("intPage"), "S")   : IF intPage = "" THEN intPage = 1
%>