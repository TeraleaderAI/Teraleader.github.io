<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "Function.asp" -->
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_POPUP] '4', '', '', '', '" & GetReplaceInput(REQUEST.QueryString("intNum"), "S") & "' ")

	DIM strSubject, strContent, intNum, nowDay, nowEngMonth, strScriptDate
	strSubject = RS("strSubject")
	strContent = RS("strContent")
	intNum     = RS("intNum")
	nowDay     = DAY(NOW)
	IF LEN(nowDay) = 1 THEN nowDay = "0" & nowDay

	SELECT CASE MONTH(NOW)
	CASE 1  : nowEngMonth = "Jan"
	CASE 2  : nowEngMonth = "Feb"
	CASE 3  : nowEngMonth = "Mar"
	CASE 4  : nowEngMonth = "Apr"
	CASE 5  : nowEngMonth = "May"
	CASE 6  : nowEngMonth = "Jun"
	CASE 7  : nowEngMonth = "Jul"
	CASE 8  : nowEngMonth = "Aug"
	CASE 9  : nowEngMonth = "Sep"
	CASE 10 : nowEngMonth = "Oct"
	CASE 11 : nowEngMonth = "Nov"
	CASE 12 : nowEngMonth = "Dec"
	END SELECT

	strScriptDate = nowEngMonth & " " & nowDay & ", " & YEAR(NOW) & " 23:59:59"

	SET RS = NOTHING : DBCON.CLOSE
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title><%=strSubject%></title>
</head>
<LINK REL="StyleSheet" HREF="/Admin/Css/style.css" TYPE="text/css" MEDIA="screen">
<style TYPE="text/css">
BODY {background-color: transparent
}
</style> 
<body BGCOLOR="transparent" STYLE="margin:0;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><%=strContent%></td>
	</tr>
	<tr>
		<td height="30" align="center"><input name="notTodayOpen" type="checkbox" id="notTodayOpen" checked>
		오늘 하루동안 이창을 열지않음
		&nbsp;&nbsp;&nbsp;<a href="javascript:;" onClick="OnWindowClose();return false;"><img src="images/btn_popup_close.gif" width="32" height="17" border="0" align="absmiddle"></a></td>
	</tr>
</table>
<script language="javascript">
function setCookie(name, value, expire){
	var expire_date = new Date(expire)
	document.cookie = name + "=" + escape(value) + "; expires=" + expire_date.toGMTString()+"; path=/"; 
}

function controlCookie(elemnt){
	if (document.all['notTodayOpen'].checked == true){
		setCookie( "ps_popup_<%=intNum%>", "true", "<%=strScriptDate%>")
	}
	self.close();
}


function OnWindowClose(){
	controlCookie();
	window.close();
}
</script>
</body>
</html>