<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title></title>
</head>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">
<script language="javascript" src="../Js/valId.js"></script>
<style type="text/css">
	input {FONT-FAMILY:돋움;  FONT-SIZE:12px; BORDER:#C7C7C7 1px solid; COLOR:#525252; HEIGHT:20px;}
</style>
<%
	DIM strBoardID, strSessionID, intUploadSize, intUploadCount, I

	WITH REQUEST

		strBoardID       = .QueryString("strBoardID")
		strSessionID     = .QueryString("strSessionID")
		intUploadSize    = .QueryString("intUploadSize")
		intUploadCount   = .QueryString("intUploadCount")

	END WITH
%>
<div id='fileUploadDiv' style='position:absolute; width:300; height: 52; z-index:1; visibility: hidden'>
<script language="javascript">playflash('progress.swf',300,52,'#FFFFFF','high','progress');</script>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="theUpload" method="post" action="../Include/BoardUploadDefault.asp?strBoardID=<%=strBoardID%>&strSessionID=<%=strSessionID%>" enctype="multipart/form-data">
<% FOR I = 1 TO intUploadCount %>
	<tr>
		<td height="26"><input type="file" name="strFileName" id="strFileName" style="width:98%"></td>
	</tr>
<% NEXT %>
	<tr>
		<td height="26"><span style="font-size:12px">업로드 제한 사이즈 : <%=intUploadSize%>&nbsp;MB</span></td>
	</tr>
</form>
</table>
</body>
</html>