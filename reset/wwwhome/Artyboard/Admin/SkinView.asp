<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title></title>
</head>
<body>
<%
	DIM strFileName
	strFileName = REQUEST.QueryString("strFileName")
%>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center"><a href="javascript:parent.closeLayer();"><img src="<%=strFileName%>" border="0"></a></td>
	</tr>
</table>
</body>
</html>
