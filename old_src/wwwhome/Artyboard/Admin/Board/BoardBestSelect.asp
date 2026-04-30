<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardBestList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount, strSelectBoardID, strBoardID, strBoardName
	intPage          = REQUEST.QueryString("intPage") : IF intPage     = "" THEN intPage     = 1
	intPageSize      = REQUEST("intPageSize")    : IF intPageSize = "" THEN intPageSize = 10
	strSelectBoardID = REQUEST.FORM("strSelectBoardID")

	SET RS = DBCON.EXECUTE("SELECT [strBoardID], [strName] FROM [MPLUS_BOARD_CONFIG_DEFAULT] ")

	IF NOT(RS.EOF) THEN
		WHILE NOT(RS.EOF)
			IF strBoardID   <> "" THEN strBoardID   = strBoardID   & ","
			IF strBoardName <> "" THEN strBoardName = strBoardName & ","
			strBoardID   = strBoardID & RS("strBoardID")
			strBoardName = strBoardName & RS("strName") & " [" & RS("strBoardID") & "]"
		RS.MOVENEXT
		WEND
	END IF

	DIM strGroupCode, strGroupName

	SET RS = DBCON.EXECUTE("SELECT [strCode], [strName] FROM [MPLUS_BOARD_NOTICE] ")
	IF NOT(RS.EOF) THEN
		WHILE NOT(RS.EOF)
			IF strGroupCode <> "" THEN strGroupCode = strGroupCode & ","
			IF strGroupName <> "" THEN strGroupName = strGroupName & ","
			strGroupCode = strGroupCode & RS("strCode")
			strGroupName = strGroupName & RS("strName")
		RS.MOVENEXT
		WEND
	END IF

	DIM Query
	IF strSelectBoardID <> "" THEN Query = " AND [strBoardID] = '" & strSelectBoardID & "' "

	DIM bitNotice, strSearchCategory, strSearchWord

	bitNotice         = REQUEST.FORM("bitNotice")   : IF bitNotice = "" THEN bitNotice = "0"
	strSearchCategory = REQUEST.FORM("strSearchCategory")
	strSearchWord     = GetReplaceInput(REQUEST.FORM("strSearchWord"), "")

	IF strSearchWord <> "" THEN Query = Query & " AND [" & strSearchCategory & "] LIKE '%" & strSearchWord & "%' "

	SET RS = DBCON.EXECUTE("SELECT COUNT([intSeq]) AS [RecCount] FROM [MPLUS_BOARD] WHERE [bitDelete] = '0' AND [bitNotice] = '" & bitNotice & "' " & Query)

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [intSeq], [bitNotice], [strBoardID], [strSubject], [strName], [intRead], [intVote], [dateRegDate] FROM [MPLUS_BOARD] WHERE [bitDelete] = '0' AND [bitNotice] = '" & bitNotice & "' " & Query & " AND [intSeq] NOT IN (SELECT TOP " & (intPage - 1) * intPageSize & " [intSeq] FROM [MPLUS_BOARD] WHERE [bitDelete] = '0' AND [bitNotice] = '" & bitNotice & "' " & Query & " ORDER BY [intSeq] DESC) ORDER BY [intSeq] DESC ")
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<form name="theForm" method="post" action="BoardBestSelect.asp">
	<tr>
		<td height="44" background="../images/pop_title_bg.gif"><img src="../images/pop_title_best_board.gif" width="200" height="44"></td>
	</tr>
	<tr>
		<td height="8"></td>
	</tr>
	<tr>
		<td height="33">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>게시글 : <b><%=intTotalCount%></b>, 페이지 <b><%=intPage%></b>/<b><%=intPageCount%></b> Page</td>
					<td align="right">
						<select name="bitNotice" id="bitNotice" onChange="document.theForm.submit();">
						<option value="0"<% IF bitNotice = "0" THEN %> SELECTED<% END IF %>>일반 게시글</option>
						<option value="1"<% IF bitNotice = "1" THEN %> SELECTED<% END IF %>>공지 게시글</option>
						</select>
						<%=GetMainBoardGroup(strBoardID, strBoardName, strSelectBoardID, "strSelectBoardID", "게시판 선택", "document.theForm.submit();")%>
						<select name="intPageSize" id="intPageSize" onChange="document.theForm.submit();">
						<option value="10"<% IF INT(intPageSize) = 10 THEN %> SELECTED<% END IF %>>10 개씩출력</option>
						<option value="20"<% IF INT(intPageSize) = 20 THEN %> SELECTED<% END IF %>>20 개씩출력</option>
						<option value="30"<% IF INT(intPageSize) = 30 THEN %> SELECTED<% END IF %>>30 개씩출력</option>
						<option value="50"<% IF INT(intPageSize) = 50 THEN %> SELECTED<% END IF %>>50 개씩출력</option>
						<option value="100"<% IF INT(intPageSize) = 100 THEN %> SELECTED<% END IF %>>100 개씩출력</option>
						</select>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr align="center" bgcolor="EB766F">
					<td colspan="9" class="table_Round1"></td>
				</tr>
				<tr align="center" bgcolor="EB766F">
					<td height="30" nowrap bgcolor="EB766F" class="table_Txt1">번호</td>
					<td height="30" nowrap bgcolor="EB766F" class="table_Txt1">선택</td>
					<td nowrap bgcolor="EB766F" class="table_Txt1">공지</td>
					<td height="30" nowrap bgcolor="EB766F" class="table_Txt1">게시판 아이디</td>
					<td height="30" nowrap bgcolor="EB766F" class="table_Txt1">글제목</td>
					<td nowrap bgcolor="EB766F" class="table_Txt1">등록자</td>
					<td nowrap bgcolor="EB766F" class="table_Txt1">조회수</td>
					<td height="30" nowrap bgcolor="EB766F" class="table_Txt1">추천수</td>
					<td align="center" nowrap bgcolor="EB766F" class="table_Txt1">등록일자</td>
				</tr>
				<tr bgcolor="EB766F">
					<td colspan="9" class="table_Round1"></td>
				</tr>
<%
	IF RS.EOF THEN
%>
				<tr align="center" bgcolor="#FFFFFF">
					<td colspan="9" class="table_ListSubText1">등록된 게시글이 없습니다.</td>
				</tr>
				<tr>
					<td colspan="9" class="table_ListSubLine1"></td>
				</tr>
<%
	ELSE
		DIM iCount, intNumber
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="#FFFFFF" class="table_ListSubText1"><%=intNumber%></td>
					<td bgcolor="#FFFFFF" class="table_ListSubText1"><input name="intSeq" type="checkbox" id="intSeq" value="<%=RS("intSeq")%>|<%=RS("strBoardID")%>" class="no_Line"></td>
					<td bgcolor="#FFFFFF" class="table_ListSubText1"><% IF RS("bitNotice") = True THEN %>O<% ELSE %>X<% END IF %></td>
					<td bgcolor="#FFFFFF" class="table_ListSubText1"><%=RS("strBoardID")%></td>
					<td align="left" bgcolor="#FFFFFF" class="table_ListSubText1"><a href="../../Mboard.asp?Action=view&strBoardID=<%=RS("strBoardID")%>&intSeq=<%=RS("intSeq")%>" target="_blank"><%=RS("strSubject")%></a></td>
					<td bgcolor="#FFFFFF" class="table_ListSubText1"><%=RS("strName")%></td>
					<td bgcolor="#FFFFFF" class="table_ListSubText1"><%=RS("intRead")%></td>
					<td bgcolor="#FFFFFF" class="table_ListSubText1"><%=RS("intVote")%></td>
					<td bgcolor="#FFFFFF" class="table_ListSubText1"><%=REPLACE(FORMATDATETIME(RS("dateRegDate"),2), "-", "/")%></td>
				</tr>
				<tr>
					<td colspan="9" class="table_ListSubLine1"></td>
				</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
				<tr>
					<td colspan="9" height="1"></td>
				</tr>
				<tr>
					<td colspan="9" class="table_ListSubBLine1"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="40">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><a href="javascript:;" onClick="OnBoardSelect();return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0"></a></td>
					<td align="right">
					<select name="strSearchCategory" id="strSearchCategory">
					<option value="strLoginID"<% IF strSearchCategory = "strLoginID" THEN %> SELECTED<% END IF %>>회원아이디</option>
					<option value="strName"<% IF strSearchCategory = "strName" THEN %> SELECTED<% END IF %>>게시글 등록자</option>
					<option value="strSubject"<% IF strSearchCategory = "strSubject" THEN %> SELECTED<% END IF %>>게시글 제목</option>
					<option value="strContent"<% IF strSearchCategory = "strContent" THEN %> SELECTED<% END IF %>>게시글 내용</option>
					</select>
					<input name="strSearchWord" type="text" id="strSearchWord" value="<%=strSearchWord%>" size="30"> 
					<a href="javascript:;" onClick="OnSearch();return false;"><img src="../images/btn_search_w.gif" width="68" height="19" border="0" align="absmiddle"></a>
					<a href="javascript:;" onClick="OnSearchCancel();return false;"><img src="../images/btn_search_cancel_w.gif" width="68" height="19" border="0" align="absmiddle"></a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="40" align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="10" cellspacing="0" class="table_Select1">
				<tr>
					<td class="table_SelecttdIn1">
						<table width="100%" border="0" cellpadding="2" cellspacing="0">
							<tr>
								<td width="10%" nowrap class="table_SelecttdLeft2">추천글 그룹</td>
								<td width="40%"><%=GetMainBoardGroup(strGroupCode, strGroupName, "", "strSelectGroup", "그룹선택", "")%></td>
								<td width="10%" nowrap class="table_SelecttdLeft2">출력정보</td>
								<td width="40%">
								<input type="radio" name="bitMemoInfo" id="bitMemoInfo1" value="1" CHECKED class="no_Line"><LABEL FOR="bitMemoInfo1" style="cursor:hand">간략정보출력</LABEL>
								<input type="radio" name="bitMemoInfo" id="bitMemoInfo2" value="0" class="no_Line"><LABEL FOR="bitMemoInfo2" style="cursor:hand">기본정보출력</LABEL>														</td>
							</tr>
							<tr>
								<td nowrap class="table_SelecttdLeft2">글자색</td>
								<td>
								<input name="strFontColor" type="text" id="strFontColor" onBlur="OnColorSet(document.all['strFontColorPrev'], this);" value="#000000" size="8" maxlength="7">
								<input type="text" style="BACKGROUND: #000000; CURSOR: hand" onClick="popupLayer('../../Library/setColor.asp?target=strFontColor',410,430);" size="2" name="strFontColorPrev"></td>
								<td nowrap class="table_SelecttdLeft2">글자 스타일</td>
								<td><input name="bitBold" type="checkbox" id="bitBold" value="1"<% IF bitBold = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitBold" style="cursor:hand">굵은제목</LABEL></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="40" align="center"><a href="javascript:;" onClick="OnBoardAdd('<%=intPage%>');return false;"><img src="../images/btn_board_add_m.gif" width="95" height="25" border="0"></a></td>
	</tr>
</form>
</table>
<%
	SUB GotoPageHTML(intPage, intPageCount)

		RESPONSE.WRITE "<table border='0' cellpadding='0' cellspacing='0'>" & vbcrlf
		RESPONSE.WRITE "	<tr>" & vbcrlf

		DIM intBlockPage, I
		intBlockPage = INT((intPage - 1) / 10) * 10 + 1

		IF intBlockPage = 1 THEN
		ELSE
    	RESPONSE.WRITE "<td id='mytd'><img src='../images/page_allow1.gif' vspace='2'>&nbsp;<a href=""javascript:;"" OnClick=""OnPageMove('" & intBlockPage - 10 & "','" & topMenu & "','" & leftMenu & "');return false;"" class='brn01'>이전</a></td>"
		END IF

		RESPONSE.WRITE "		<td  width='1' nowrap bgcolor='#cccccc'></td>" & vbcrlf

		i = 1
		
		DO UNTIL i > 10 OR intBlockPage > intPageCount

			RESPONSE.WRITE "		<td id='mytd' onMouseOver=""this.style.background='#f7f7f7'"" onMouseOut=""this.style.background=''"" align=center onClick=""OnPageMove('" & intBlockPage & "','" & topMenu & "','" & leftMenu & "');return false;"">"
		
			IF INT(intBlockPage) = INT(intPage) THEN RESPONSE.WRITE "<font color='#ff7635'><b>" & intBlockPage & "</b></font>" ELSE RESPONSE.WRITE "<b>" & intBlockPage & "</b>"

			RESPONSE.WRITE "</td>" & vbcrlf
			RESPONSE.WRITE "<td  width=1 nowrap bgcolor='#cccccc'></td>" & vbcrlf

			intBlockPage = intBlockPage + 1
			I = I + 1
		
		LOOP

    IF intBlockPage > intPageCount THEN
		ELSE
			RESPONSE.WRITE "<td id='mytd'>&nbsp;<a href=""javascript:;"" OnClick=""OnPageMove('" & intBlockPage & "','" & topMenu & "','" & leftMenu & "');return false;"" class='brn01'>다음</a>&nbsp;<img src='../images/page_allow2.gif' vspace='2'></td>"
		END IF

		RESPONSE.WRITE "	</tr>" & vbcrlf
		RESPONSE.WRITE "</table>" & vbcrlf

	END SUB
%>
<script language="javascript">

	function OnPageMove(intPage){
		document.theForm.action = "BoardBestSelect.asp?intPage=" + intPage;
		document.theForm.submit();
	}

	function OnSearch(){
		str = document.all['strSearchWord'];
		if (str.value == ""){alert("검색단어를 입력해 주시기 바랍니다.");str.focus();return false;}

		document.theForm.submit();
	}

	function OnSearchCancel(){
		document.all['strSearchWord'].value = "";
		document.theForm.submit();
	}

	var SET_intTotalCount = "<%=intTotalCount%>";

	function OnBoardSelect(){
		obj = document.all['intSeq'];
		if(!obj) return false;
		if (SET_intTotalCount == "1"){
			if (document.all['intSeq'].checked == true){
				document.all['intSeq'].checked = false;
			}else{
				document.all['intSeq'].checked = true
			}
		}else{
			var cntBox = obj.length - 1;
			for(var i = 0; i <= cntBox; i++){
				if (obj[i].checked == false){
					obj[i].checked=true;
				}else{
					obj[i].checked=false;
				}
			}
		}
	}

	function OnBoardAdd(str){

		if (document.all['strSelectGroup'].value == ""){
			alert("그룹을 선택해 주시기 바랍니다.");document.all['strSelectGroup'].focus();return false;
		}

		obj = document.all['intSeq'];
		var k = 0;
		if(!obj) return false;
		if (SET_intTotalCount == "1"){
			if (document.all['intSeq'].checked == true){
				k++;
			}
		}else{
			var cntBox = obj.length - 1;
			for(var i = 0; i <= cntBox; i++){
				if (obj[i].checked == true){
					k++;
				}
			}
		}
		if (k == "0"){alert("게시글을 선택해 주시기 바랍니다.");return false;}

		document.theForm.action = "BoardBestSelect_ok.asp?intPage=" + str;
		document.theForm.submit();
	}

</script>
<!-- #include file = "../Foot.asp" -->