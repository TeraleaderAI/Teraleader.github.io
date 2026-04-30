<!--METADATA TYPE="typelib" NAME="ADODB Type Library" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"-->
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM Action, intPage, strPollCode, searchCategory, searchWord, strState, intNowDate
	Action         = GetReplaceInput(REQUEST.QueryString("Action"), "S")
	intPage        = GetReplaceInput(REQUEST("intPage"), "S")     : IF intPage = "" THEN intPage = 1
	strPollCode    = GetReplaceInput(REQUEST.QueryString("strPollCode"), "S")
	searchCategory = GetReplaceInput(REQUEST.FORM("searchCategory"), "S")
	searchWord     = GetReplaceInput(REQUEST.FORM("searchWord"), "S")
	strState       = GetReplaceInput(REQUEST.QueryString("strState"), "S")

	intNowDate     = YEAR(NOW)
	IF LEN(MONTH(NOW)) = 1 THEN intNowDate = intNowDate & "0"
	intNowDate     = intNowDate & MONTH(NOW)
	IF LEN(DAY(NOW)) = 1 THEN intNowDate = intNowDate & "0"
	intNowDate     = intNowDate & DAY(NOW)
	IF LEN(HOUR(NOW)) = 1 THEN intNowDate = intNowDate & "0"
	intNowDate     = intNowDate & HOUR(NOW)
	IF LEN(MINUTE(NOW)) = 1 THEN intNowDate = intNowDate & "0"
	intNowDate     = intNowDate & MINUTE(NOW)

	IF SESSION("strLoginID") = "" THEN strLoginID = "guest" ELSE strLoginID = SESSION("strLoginID")

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_POLL_CONFIG] ")

	DIM CONF_strSkin, CONF_strSkinGroup, skinPath, CONF_strWidth, CONF_strAlign, CONF_intPageCount, CONF_intLineCount
	DIM CONF_strPagePrevGroup, CONF_strPageNextGroup, CONF_strPageFirstPage, CONF_strPageEndPage, CONF_strPageNow
	DIM CONF_strPageDefault

	CONF_strSkin          = RS("strSkin")
	CONF_strSkinGroup     = RS("strSkinGroup")
	skinPath              = GetSkinPath(CONF_strSkin, 2, CONF_strSkinGroup, 1) & "/"
	CONF_strWidth         = RS("strWidth")
	CONF_strAlign         = GetAlignSet(RS("strAlign"))
	CONF_intPageCount     = RS("intPageCount")
	CONF_intLineCount     = RS("intLineCount")
	CONF_strPagePrevGroup = RS("strPagePrevGroup")
	CONF_strPageNextGroup = RS("strPageNextGroup")
	CONF_strPageFirstPage = RS("strPageFirstPage")
	CONF_strPageEndPage   = RS("strPageEndPage")
	CONF_strPageNow       = RS("strPageNow")
	CONF_strPageDefault   = RS("strPageDefault")
%>
<script language="javascript">

	var SET_intPage = <%=intPage%>;
	var SET_Action = "<%=UCASE(Action)%>";
	var SET_strState = "<%=strState%>";
	var SET_strPollCode = "<%=GetReplaceInput(REQUEST.QueryString("strPollCode"),"S")%>";

</script>