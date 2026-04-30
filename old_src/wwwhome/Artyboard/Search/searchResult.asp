<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<LINK HREF="style.css" REL="stylesheet" TYPE="text/css">
<title>아티보드 통합검색</title>
</head>
<body>
<!-- #include file = "../DBConnect/DBConnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM intSearchType1, intSearchType2, intSearchType3, intSearchType4, searchWord

	intSearchType1 = REQUEST.FORM("intSearchType1")
	intSearchType2 = REQUEST.FORM("intSearchType2")
	intSearchType3 = REQUEST.FORM("intSearchType3")
	intSearchType4 = REQUEST.FORM("intSearchType4")
	searchWord     = GetReplaceInput(REQUEST.FORM("searchWord"), "")

	DIM intPage, intPageSize, intTotalCount, intPageCount
	intPage     = REQUEST.QueryString("intPage") : IF intPage = "" THEN intPage = 1
	intPageSize = REQUEST.FORM("intPageSize")    : IF intPageSize = "" THEN intPageSize = 10

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_SEARCH_COUNT] '" & intSearchType1 & "', '" & intSearchType2 & "', '" & intSearchType3 & "', '" & intSearchType4 & "', '" & searchWord & "' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_SEARCH] '500', '" & intPageSize & "', '" & intPage & "', '" & intSearchType1 & "', '" & intSearchType2 & "', '" & intSearchType3 & "', '" & intSearchType4 & "', '" & searchWord & "' ")
%>
<form name="mainSearch" method="post" action="searchResult.asp" onSubmit="return OnMainSearch();">
<input type="hidden" name="intSearchType1" value="<%=intSearchType1%>">
<input type="hidden" name="intSearchType2" value="<%=intSearchType2%>">
<input type="hidden" name="intSearchType3" value="<%=intSearchType3%>">
<input type="hidden" name="intSearchType4" value="<%=intSearchType4%>">
<input type="hidden" name="searchWord" value="<%=searchWord%>">
</form>
<table width="830"  border="0" align="center" cellpadding="0" cellspacing="0">
<form name="theForm" method="post" action="searchResult.asp" onSubmit="return OnSearch();">
	<tr>
		<td>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="30" class="small3"><select name="intPageSize" id="intPageSize">
					<option value="10"<% IF intPageSize = "10" THEN %> SELECTED<% END IF %>>10개씩 검색</option>
					<option value="20"<% IF intPageSize = "20" THEN %> SELECTED<% END IF %>>20개씩 검색</option>
					<option value="30"<% IF intPageSize = "30" THEN %> SELECTED<% END IF %>>30개씩 검색</option>
					</select>
					<input name="intSearchType1" type="checkbox" id="intSearchType1" value="1"<% IF intSearchType1 = "1" THEN %> CHECKED<% END IF %>>
					<LABEL FOR="intSearchType1" style="cursor:hand">아이디</LABEL>
					<input name="intSearchType2" type="checkbox" id="intSearchType2" value="1"<% IF intSearchType2 = "1" THEN %> CHECKED<% END IF %>>
					<LABEL FOR="intSearchType2" style="cursor:hand">이름</LABEL>
					<input name="intSearchType3" type="checkbox" id="intSearchType3" value="1"<% IF intSearchType3 = "1" THEN %> CHECKED<% END IF %>>
					<LABEL FOR="intSearchType3" style="cursor:hand">제목</LABEL>
					<input name="intSearchType4" type="checkbox" id="intSearchType4" value="1"<% IF intSearchType4 = "1" THEN %> CHECKED<% END IF %>>
					<LABEL FOR="intSearchType4" style="cursor:hand">내용</LABEL>
					<input name="searchWord" type="text" class="text" id="searchWord" value="<%=searchWord%>"> 
					<input type="image" name="imageField" src="images/search_btn.gif" align="absmiddle">
					</td>
				</tr>
				<tr>
					<td height="1" bgcolor="E5E5E2"></td>
				</tr>
			</table>
		</td>
	</tr>
<%
	DIM strContent
	WHILE NOT(RS.EOF)
		strContent = GetReplaceTag2Text(GetCutSubject(StripTags(RS("strContent")), 200))
		IF intSearchType4 = "1" THEN strContent = REPLACE(strContent, searchWord, "<font color=#000000><b>" & searchWord & "</b></font>")
%>
	<tr>
		<td height="10"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3">
				<tr>
					<td><span style="color: #022368; font-weight: bold">[<%=RS("strBoardName")%>]&nbsp;<%=RS("strSubject")%></span>&nbsp;<a href="../Mboard.asp?Action=view&strBoardID=<%=RS("strBoardID")%>&intSeq=<%=RS("intSeq")%>">[현재창]</a>&nbsp;<a href="../Mboard.asp?Action=view&strBoardID=<%=RS("strBoardID")%>&intSeq=<%=RS("intSeq")%>" target="_blank">[새창]</a></td>
				</tr>
				<tr>
					<td><%=strContent%></td>
				</tr>
				<tr>
					<td><span style="color: #608B14"><span style="font-weight: bold"><%=RS("strName")%></span> | <%=GetDateType(0, RS("dateRegDate"))%></span></td>
				</tr>
			</table>
		</td>
	</tr>
<%
	RS.MOVENEXT
	WEND
%>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="40" align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
	</tr>
</form>
</table>
<%
	SUB GotoPageHTML(intPage, intPageCount)
	
	DIM blockpage, i
	blockpage = INT((intPage - 1) / 10) * 10 + 1

	IF blockpage = 1 THEN RESPONSE.WRITE "[이전10개] "	ELSE RESPONSE.WRITE "<a href=""javascript:;"" OnClick=""OnPageMove('" & blockpage - 10 & "');return false;"">[이전 10개]</a> "

	i = 1
	
	DO UNTIL i > 10 OR blockpage > intPageCount
		IF INT(blockpage) = INT(intPage) THEN RESPONSE.WRITE " <b>" & blockpage & "</b> " ELSE RESPONSE.WRITE "[<a href=""javascript:;"" OnClick=""OnPageMove('" & blockpage & "');return false;"">" & blockpage & "</a>]"

		blockpage = blockpage + 1
		i = i + 1
	LOOP

	IF blockpage > intPageCount THEN RESPONSE.WRITE " [다음 10개]"	ELSE RESPONSE.WRITE " <a href=""javascript:;"" OnClick=""OnPageMove('" & blockpage - 10 & "');return false;"">[다음 10개]</a>"

	END SUB
%>
<script language="javascript">

	function OnPageMove(str){
		document.mainSearch.action = "searchResult.asp?intPage=" + str;
		document.mainSearch.submit();
	}

	function OnSearch(){
		var k = 0;
		if (document.theForm.intSearchType1.checked == true){k++;}
		if (document.theForm.intSearchType2.checked == true){k++;}
		if (document.theForm.intSearchType3.checked == true){k++;}
		if (document.theForm.intSearchType4.checked == true){k++;}

		if (k == 0){
			alert("검색항목을 선택해 주시기 바랍니다.");document.theForm.intSearchType1.focus();return false;
		}

		str = document.theForm.searchWord;
		if (str.value == ""){alert("검색단어를 입력해 주시기 바랍니다.");str.focus();return false;}
	}
</script>
<%
	SET RS = NOTHING : DBCON.CLOSE
%>
</body>
</html>