<script language="javascript">
<%
	IF READ_intImgCount = 0 THEN RESPONSE.WRITE "	var SET_GALLERY_NOW_IMG = """";" ELSE RESPONSE.WRITE "	var SET_GALLERY_NOW_IMG = """ & strImgFirstFile & """;"
%>
	var SET_READ_TYPE = "0";
</script>