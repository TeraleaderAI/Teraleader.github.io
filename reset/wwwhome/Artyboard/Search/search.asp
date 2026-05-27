<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<LINK HREF="style.css" REL="stylesheet" TYPE="text/css">
<title>아티보드 통합검색</title>
</head>
<body>
<table width="180" border="0" cellspacing="0" cellpadding="0">
<form name="mainSearch" method="post" action="searchResult.asp" onSubmit="return OnMainSearch();">
<input type="hidden" name="intSearchType1" value="0">
<input type="hidden" name="intSearchType2" value="0">
<input type="hidden" name="intSearchType3" value="1">
<input type="hidden" name="intSearchType4" value="0">
	<tr>
		<td width="49"><img src="images/search_text.gif" width="41" height="15"></td>
		<td><input name="searchWord" type="text" class="text" id="searchWord" size="15"></td>
		<td width="40" align="right"><input type="image" name="imageField" src="images/search_btn.gif">
		</td>
	</tr>
</form>
</table>
<script language="javascript">
	function OnMainSearch(){
		str = document.mainSearch.searchWord;
		if (str.value == ""){alert("검색단어를 입력해 주시기 바랍니다.");str.focus();return false;}
	}
</script>
</body>
</html>