<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "Function.asp" -->
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_POPUP] '4', '', '', '', '" & GetReplaceInput(REQUEST.QueryString("popid"), "S") & "' ")

	DIM strSubject, strContent, intNum, nowDay, nowEngMonth, strScriptDate, strPopupBox
	strSubject  = RS("strSubject")
	strContent  = GetReplaceTag2Html(RS("strContent"))
	intNum      = RS("intNum")
	strPopupBox = RS("strPopupBox")
	nowDay      = DAY(NOW)
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
<style TYPE="text/css">
a:link		{font-family:µ¸¿ò; font-size:12px; color:#545454; text-decoration:none; line-height:12pt;}
a:visited	{font-family:µ¸¿ò; font-size:12px; color:#545454; text-decoration:none; line-height:12pt;}
a:active	{font-family:µ¸¿ò; font-size:12px; color:#545454; text-decoration:none; line-height:12pt;}
a:hover		{font-family:µ¸¿ò; font-size:12px; color:#545454; text-decoration:underline; line-height:12pt;}

table, tr, td, body	{
	font-family: "µ¸¿ò", "Arial", "sans-serif", "helvetica"; font-size:12px; color: #545454; scrollbar-face-color: #f7f7f7; scrollbar-highlight-color: #ffffff; scrollbar-shadow-color: #cccccc; scrollbar-3dlight-color: #ffffff; scrollbar-arrow-color: #cccccc; scrollbar-track-color: #ffffff; scrollbar-darkshadow-color: #ffffff;
}
</style> 
<body BGCOLOR="transparent" STYLE="margin:0;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="FormPopup" target="_self">
	<tr>
		<td><%=strContent%></td>
	</tr>
	<tr>
		<td height="30" align="center" bgcolor="#EAEAEA"><input name="oPopupLimit" type="checkbox" id="oPopupLimit" checked>
		¿À´Ã ÇÏ·çµ¿¾È ÀÌÃ¢À» ¿­Áö¾ÊÀ½
		&nbsp;&nbsp;&nbsp;<a href="javascript:;" onClick="OnWindowClose();return false;"><img src="images/btn_popup_close.gif" width="32" height="17" border="0" align="absmiddle"></a></td>
	</tr>
</form>
</table>
<script language="javascript">

function setCookie(name, value, expire){
	var expire_date = new Date(expire)
	document.cookie = name + "=" + escape(value) + "; expires=" + expire_date.toGMTString()+"; path=/"; 
}

function controlCookie(elemnt){
	if (elemnt.checked){
		setCookie( "ps_popup<%=intNum%>", "true", "<%=strScriptDate%>")
	}
	self.close();
}

<% IF strPopupBox = "2" THEN %>
function OnWindowClose(){
	var objForm = document.FormPopup;
	controlCookie( objForm.oPopupLimit );	
	parent.document.all('objId_LayerId_<%=intNum%>').style.display = 'none'; 
}

function OnLayerClose(){
	parent.document.all('objId_LayerId_<%=intNum%>').style.display = 'none';
}
<% ELSE %>
function OnWindowClose(){
	var objForm = document.FormPopup;
	controlCookie(objForm.oPopupLimit);	
	window.close(); 
}

function OnLayerClose(){
	window.close();
}
<% END IF %>
</script>
</body>
</html>