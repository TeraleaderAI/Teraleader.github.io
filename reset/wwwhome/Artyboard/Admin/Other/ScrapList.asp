<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 8
	intLeftMenu  = 6
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM strBoardID, intYear, intMonth, intDay, strSearchCategory, strSearchWord, Query1, Query2

	WITH REQUEST

		strBoardID        = GetReplaceInput(.FORM("strBoardID"),"")
		intYear           = .FORM("intYear")
		intMonth          = .FORM("intMonth")
		intDay            = .FORM("intDay")
		strSearchCategory = GetReplaceInput(.FORM("strSearchCategory"),"")
		strSearchWord     = GetReplaceInput(.FORM("strSearchWord"), "")
		isSearch          = .QueryString("isSearch")

	END WITH

	DIM intPage, intPageSize, intTotalCount, intPageCount
	intPage     = REQUEST.QueryString("intPage") : IF intPage     = "" THEN intPage     = 1
	intPageSize = REQUEST.FORM("intPageSize")    : IF intPageSize = "" THEN intPageSize = 20

	Query1 = ""
	Query2 = ""

	IF strBoardID    <> "" THEN
		IF Query1 = "" THEN Query1 = Query1 & " WHERE " ELSE Query1 = Query1 & " AND "
		Query1 = Query1 & " [strBoardID] = '" & strBoardID & "' "
		Query2 = Query2 & " AND [strBoardID] = '" & strBoardID & "' "
	END IF

	IF strSearchWord <> "" THEN
		SELECT CASE strSearchCategory
		CASE "strSubject"
			IF Query1 = "" THEN Query1 = Query1 & " WHERE " ELSE Query1 = Query1 & " AND "
			Query1 = Query1 & " [intBoardNum] IN (SELECT [strSubject] FROM [MPLUS_BOARD] WHERE [bitDelete] = '0' AND [strSubject] LIKE %'" & strSearchWord & "') "
			Query2 = Query2 & " AND [intBoardNum] IN (SELECT [strSubject] FROM [MPLUS_BOARD] WHERE [bitDelete] = '0' AND [strSubject] LIKE %'" & strSearchWord & "') "
		CASE "strLoginID"
			IF Query1 = "" THEN Query1 = Query1 & " WHERE " ELSE Query1 = Query1 & " AND "
			Query1 = Query1 & " [strLoginID] = '" & strSearchWord & "' "
			Query2 = Query2 & " AND [strLoginID] = '" & strSearchWord & "' "
		CASE "strLoginName"
			IF Query1 = "" THEN Query1 = Query1 & " WHERE " ELSE Query1 = Query1 & " AND "
			Query1 = Query1 & " [strLoginID] IN (SELECT [strLoginID] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginName] = '" & strSearchWord & "') "
			Query2 = Query2 & " AND [strLoginID] IN (SELECT [strLoginID] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginName] = '" & strSearchWord & "') "
		END SELECT
	END IF

	IF intYear       <> "" THEN
		IF Query1 = "" THEN Query1 = Query1 & " WHERE " ELSE Query1 = Query1 & " AND "
		Query1 = Query1 & " DATEDIFF(yy,'2007-06-18', [dateRegDate]) = 0 "
		Query2 = Query2 & " AND DATEDIFF(yy,'2007-06-18', [dateRegDate]) = 0 "
	END IF

	IF intMonth      <> "" THEN
		IF Query1 = "" THEN Query1 = Query1 & " WHERE " ELSE Query1 = Query1 & " AND "
		Query1 = Query1 & " DATEDIFF(mm,'2007-06-18', [dateRegDate]) = 0 "
		Query2 = Query2 & " AND DATEDIFF(mm,'2007-06-18', [dateRegDate]) = 0 "
	END IF

	IF intDay        <> "" THEN
		IF Query1 = "" THEN Query1 = Query1 & " WHERE " ELSE Query1 = Query1 & " AND "
		Query1 = Query1 & " DATEDIFF(dd,'2007-06-18', [dateRegDate]) = 0 "
		Query2 = Query2 & " AND DATEDIFF(dd,'2007-06-18', [dateRegDate]) = 0 "
	END IF
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" action="ScrapList.asp">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title50.gif" width="108" height="19"></td>
                      <td align="right">관리자 홈 &gt; 기타관리 &gt; <b>스크랩 리스트</b></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="10" cellspacing="0" class="table_Select1">
										<tr>
											<td class="table_SelecttdIn1">
												<table width="100%" border="0" cellpadding="2" cellspacing="0">
													<tr>
														<td>
														<select name="strBoardID" id="strBoardID">
														<option value="">모든 게시판</option>
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '', '' ")
	WHILE NOT(RS.EOF)
		IF RS("strBoardID") = strBoardID THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		RESPONSE.WRITE "<option value='" & RS("strBoardID") & "'" & SELECTED & ">" & RS("strBoardID") & "</oprion>" & vbcrlf
	RS.MOVENEXT
	WEND
%>
														</select>
														<select name="intYear" id="intYear">
														<option value="">년도</option>
<%
	FOR I = 2000 TO YEAR(NOW)
		RESPONSE.WRITE "<option value='" & I & "'"
		IF intYear <> "" THEN
			IF INT(I) = INT(intYear) THEN RESPONSE.WRITE " SELECTED"
		END IF
		RESPONSE.WRITE ">" & I & "년</option>" & vbcrlf
	NEXT
%>
														</select>
														<select name="intMonth" id="intMonth">
														<option value="">월</option>
<%
	FOR I = 1 TO 12
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0"
		RESPONSE.WRITE I & "'"
		IF intMonth <> "" THEN
			IF INT(I) = INT(intMonth) THEN RESPONSE.WRITE " SELECTED"
		END IF
		RESPONSE.WRITE ">" & I & "월</option>" & vbcrlf
	NEXT
%>
														</select>
														<select name="intDay" id="intDay">
														<option value="">일</option>
<%
	FOR I = 1 TO 31
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0"
		RESPONSE.WRITE I & "'"
		IF intDay <> "" THEN
			IF INT(I) = INT(intDay) THEN RESPONSE.WRITE " SELECTED"
		END IF
		RESPONSE.WRITE ">" & I & "일</option>" & vbcrlf
	NEXT
%>
														</select>
														<select name="strSearchCategory" id="strSearchCategory">
														<option value="strLoginName"<% IF strSearchCategory = "strLoginName" THEN %> SELECTED<% END IF %>>회원이름</option>
														<option value="strLoginID"<% IF strSearchCategory = "strLoginID" THEN %> SELECTED<% END IF %>>회원아이디</option>
														<option value="strSubject"<% IF strSearchCategory = "strSubject" THEN %> SELECTED<% END IF %>>글제목</option>
														</select>
														<input name="strSearchWord" type="text" id="strSearchWord" value="<%=strSearchWord%>" size="26">
														<a href="javascript:;" onClick="OnSearch();return false;"><img src="../images/btn_scrap_search_w.gif" width="83" height="19" align="absmiddle" border="0"></a>
														<a href="BoardSearch.asp"><img src="../images/btn_search_cancel_w.gif" width="68" height="19" align="absmiddle" border="0"></a></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
              </tr>
<%
	SET RS = DBCON.EXECUTE("SELECT COUNT([intSeq]) AS [RecCount] FROM [MPLUS_SCRAP_LIST] " & Query1)
	
	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
							<tr>
								<td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>전체 : <font color="#C6325B"><b><%=intTotalCount%></b></font>&nbsp;&nbsp;<%=intPage%>/<%=intPageCount%> 페이지 </td>
											<td align="right"><b>출력개수설정</b>
											<select name="intPageSize" id="intPageSize" onchange="document.theForm.submit();">
											<option value="10"<% IF intPageSize = 10 THEN %> SELECTED<% END IF %>>10</option>
											<option value="15"<% IF intPageSize = 15 THEN %> SELECTED<% END IF %>>15</option>
											<option value="20"<% IF intPageSize = 20 THEN %> SELECTED<% END IF %>>20</option>
											<option value="50"<% IF intPageSize = 50 THEN %> SELECTED<% END IF %>>50</option>
											<option value="100"<% IF intPageSize = 100 THEN %> SELECTED<% END IF %>>100</option>
											<option value="300"<% IF intPageSize = 300 THEN %> SELECTED<% END IF %>>300</option>
											<option value="500"<% IF intPageSize = 500 THEN %> SELECTED<% END IF %>>500</option>
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
											<td colspan="8" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td height="30" class="table_Txt1" nowrap>번호</td>
											<td class="table_Txt1" nowrap>게시판ID</td>
											<td height="30" class="table_Txt1" nowrap>게시글번호</td>
											<td height="30" class="table_Txt1" nowrap>게시글제목</td>
											<td height="30" class="table_Txt1" nowrap>스크랩ID</td>
											<td class="table_Txt1" nowrap>코멘트</td>
											<td class="table_Txt1" nowrap>등록일자</td>
											<td height="30" nowrap class="table_Txt1">삭제</td>
											</tr>
										<tr bgcolor="EB766F">
											<td colspan="8" class="table_Round1"></td>
										</tr>
<%
	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [intSeq], [strLoginID], [strBoardID], [intBoardNum], [strSubject] = (SELECT [strSubject] FROM [MPLUS_BOARD] WHERE [intSeq] = [MPLUS_SCRAP_LIST].[intBoardNum]), [strLoginID], [strComment], [dateRegDate] FROM [MPLUS_SCRAP_LIST] WHERE [intSeq] NOT IN (SELECT TOP " & (intPage - 1) * intPageSize & " [intSeq] FROM [MPLUS_SCRAP_LIST] " & Query1 & " ORDER BY [intSeq] DESC)" & Query2 & " ORDER BY [intSeq] DESC")
	
	IF RS.EOF THEN
%>
										<tr align="center" bgcolor="#FFFFFF">
											<td colspan="8" class="table_ListSubText1">검색된 게시글이 없습니다.</td>
										</tr>
										<tr>
											<td colspan="8" class="table_ListSubLine1"></td>
										</tr>
<%
	ELSE
		DIM iCount, intNumber
		WHILE NOT(RS.EOF)
			iCount    = iCount + 1
			intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td align="center" class="table_ListSubText1"><%=intNumber%></td>
											<td align="center" class="table_ListSubText1"><%=RS("strBoardID")%></td>
											<td class="table_ListSubText1"><%=RS("intBoardNum")%></td>
											<td align="left" class="table_ListSubText1"><a href="../../Mboard.asp?Action=view&strBoardID=<%=RS("strBoardID")%>&intSeq=<%=RS("intBoardNum")%>" target="_blank"><%=RS("strSubject")%></a></td>
											<td align="center" class="table_ListSubText1"><%=RS("strLoginID")%></td>
											<td align="center" class="table_ListSubText1"><a href="javascript:;" onClick="OnViewComment('<%=RS("intSeq")%>');return false;"><img src="../images/btn_view_s.gif" width="38" height="16" border="0" /></a></td>
											<td align="center" class="table_ListSubText1"><%=REPLACE(FORMATDATETIME(RS("dateRegDate"),2),"-","/")%></td>
											<td align="center" class="table_ListSubText1"><a href="javascript:;" onClick="OnRemove('<%=RS("intSeq")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0" /></a></td>
											</tr>
										<tr>
											<td colspan="8" class="table_ListSubLine1"></td>
										</tr>
										<tr bgcolor="#FFFFFF" align="center" id="tr_<%=RS("intSeq")%>" style="display:none">
											<td colspan="8" align="left" class="table_ListSubText1" style="padding:5;"><%=GetReplaceTag2Text(RS("strComment"))%></td>
											</tr>
										<tr id="tr_<%=RS("intSeq")%>" style="display:none">
											<td colspan="8" class="table_ListSubLine1"></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
										<tr>
											<td colspan="8" height="1"></td>
										</tr>
										<tr>
											<td colspan="8" class="table_ListSubBLine1"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td height="40" align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
              </tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>등록된 스크립 내역을 확인할 수 있으며, 필요에 따라 다양한 검색으로 검색이 가능합니다.</LI>
											</td>
										</tr>
									</table>
									</fieldset>
								</td>
							</tr>
              <tr>
                <td>&nbsp;</td>
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

	function OnViewComment(intSeq){
		if (document.all['tr_' + intSeq][0].style.display == "block"){
			document.all['tr_' + intSeq][0].style.display = "none";
			document.all['tr_' + intSeq][1].style.display = "none";
		}else{
			document.all['tr_' + intSeq][0].style.display = "block";
			document.all['tr_' + intSeq][1].style.display = "block";
		}
	}

	function OnSearch(){
		document.theForm.action = "ScrapList.asp";
		document.theForm.submit();
	}

	function OnPageMove(intPage){
		document.theForm.action = "ScrapList.asp?intPage=" + intPage;
		document.theForm.submit();
	}

	function OnRemove(intSeq){
		if (confirm("선택된 스크랩 정보를 삭제하시겠습니까?")){
			document.theForm.action = "ScrapList_ok.asp?intSeq=" + intSeq;
			document.theForm.submit();
		}
	}

</script>
<!-- #include file = "Foot.asp" -->