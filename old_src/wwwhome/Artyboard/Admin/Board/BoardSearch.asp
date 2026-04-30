<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 6
	intLeftMenu  = 7
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM strBoardID, intYear, intMonth, intDay, strSearchCategory, strSearchWord, Query

	WITH REQUEST

		strBoardID        = .FORM("strBoardID")
		intYear           = .FORM("intYear")
		intMonth          = .FORM("intMonth")
		intDay            = .FORM("intDay")
		strSearchCategory = .FORM("strSearchCategory")
		strSearchWord     = GetReplaceInput(.FORM("strSearchWord"), "")
		isSearch          = .QueryString("isSearch")

	END WITH

	DIM intPage, intPageSize, intTotalCount, intPageCount
	intPage     = REQUEST.QueryString("intPage") : IF intPage     = "" THEN intPage     = 1
	intPageSize = REQUEST.FORM("intPageSize")    : IF intPageSize = "" THEN intPageSize = 20

	Query = " WHERE [bitDelete] = '0' "

	IF strBoardID    <> "" THEN Query = Query & " AND [strBoardID] = '" & strBoardID & "' "
	IF strSearchWord <> "" THEN Query = Query & " AND [" & strSearchCategory & "] LIKE '%" & strSearchWord & "' "
	IF intYear       <> "" THEN Query = Query & " AND DATEDIFF(yy,'2007-06-18', [dateRegDate]) = 0 "
	IF intMonth      <> "" THEN Query = Query & " AND DATEDIFF(mm,'2007-06-18', [dateRegDate]) = 0 "
	IF intDay        <> "" THEN Query = Query & " AND DATEDIFF(dd,'2007-06-18', [dateRegDate]) = 0 "
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" action="BoardSearch.asp">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title42.gif" width="139" height="19"></td>
                      <td align="right">관리자 홈 &gt; 통계자료 &gt; <b>게시글 데이타 추적</b></td>
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
														<option value="strName"<% IF strSearchCategory = "strName" THEN %> SELECTED<% END IF %>>이름</option>
														<option value="strLoginID"<% IF strSearchCategory = "strLoginID" THEN %> SELECTED<% END IF %>>회원아이디</option>
														<option value="strEmail"<% IF strSearchCategory = "strEmail" THEN %> SELECTED<% END IF %>>메일주소</option>
														<option value="strSubject"<% IF strSearchCategory = "strSubject" THEN %> SELECTED<% END IF %>>글제목</option>
														<option value="strContent"<% IF strSearchCategory = "strContent" THEN %> SELECTED<% END IF %>>글내용</option>
														<option value="strIpAddr"<% IF strSearchCategory = "strIpAddr" THEN %> SELECTED<% END IF %>>아이피</option>
														</select>
														<input name="strSearchWord" type="text" id="strSearchWord" value="<%=strSearchWord%>" size="26">
														<a href="javascript:;" onClick="OnSearch();return false;"><img src="../images/btn_board_search_w.gif" width="83" height="19" align="absmiddle" border="0"></a>
														<a href="BoardSearch.asp"><img src="../images/btn_board_search_cancel_w.gif" width="105" height="19" align="absmiddle" border="0"></a></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
              </tr>
<%
	SET RS = DBCON.EXECUTE("SELECT COUNT([intSeq]) AS [RecCount] FROM [MPLUS_BOARD] " & Query)
	
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
											<td colspan="9" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td height="30" class="table_Txt1" nowrap>번호</td>
											<td class="table_Txt1" nowrap>게시판ID</td>
											<td height="30" class="table_Txt1" nowrap>제목</td>
											<td height="30" class="table_Txt1" nowrap>이름</td>
											<td height="30" class="table_Txt1" nowrap>아이디</td>
											<td class="table_Txt1" nowrap>IP</td>
											<td class="table_Txt1" nowrap>등록일자</td>
											<td class="table_Txt1" nowrap>파일</td>
											<td height="30" nowrap class="table_Txt1">링크</td>
											</tr>
										<tr bgcolor="EB766F">
											<td colspan="9" class="table_Round1"></td>
										</tr>
<%
	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [intSeq], [strBoardID], [strLoginID], [strName], [strSubject], [strIpAddr], [intFileCount], [strLink1], [strLink2], [dateRegDate] FROM [MPLUS_BOARD] " & Query & " AND [intSeq] NOT IN (SELECT TOP " & (intPage - 1) * intPageSize & " [intSeq] FROM [MPLUS_BOARD] " & Query & " ORDER BY [intSeq] DESC) ORDER BY [intSeq] DESC")
	
	IF RS.EOF THEN
%>
										<tr align="center" bgcolor="#FFFFFF">
											<td colspan="9" class="table_ListSubText1">검색된 게시글이 없습니다.</td>
										</tr>
										<tr>
											<td colspan="9" class="table_ListSubLine1"></td>
										</tr>
<%
	ELSE
		DIM iCount, intNumber, strLink, strLinkTemp
		WHILE NOT(RS.EOF)
			iCount    = iCount + 1
			intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
			strLink   = ""

			IF RS("strLink1") = "|" THEN
				IF RS("strLink2") = "|" THEN strLink = "" ELSE strLink = RS("strLink2")
			ELSE
				strLink = RS("strLink1")
			END IF

			IF strLink <> "" AND ISNULL(strLink) = False THEN
				strLinkTemp = SPLIT(strLink, "|")
				strLink = "<a href='" & strLinkTemp(0) & "' target='" & strLinkTemp(1) & "'>L</a>"
			END IF
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1"><%=intNumber%></td>
											<td class="table_ListSubText1"><%=RS("strBoardID")%></td>
											<td align="left" class="table_ListSubText1"><a href="../../Mboard.asp?Action=view&strBoardID=<%=RS("strBoardID")%>&intSeq=<%=RS("intSeq")%>" target="_blank"><%=GetReplaceTag2Html(RS("strSubject"))%></a></td>
											<td class="table_ListSubText1"><%=RS("strName")%></td>
											<td class="table_ListSubText1"><%=RS("strLoginID")%></td>
											<td class="table_ListSubText1"><%=RS("strIpAddr")%></td>
											<td class="table_ListSubText1"><%=REPLACE(FORMATDATETIME(RS("dateRegDate"),2),"-","/")%></td>
											<td class="table_ListSubText1"><%=RS("intFileCount")%></td>
											<td class="table_ListSubText1"><%=strLink%></td>
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
                <td height="40" align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
              </tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>등록된 전체 게시글을 다양한 검색방법을 이용해서 검색할 수 있는 기능입니다.</LI>
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

	function OnSearch(){
		document.theForm.action = "BoardSearch.asp";
		document.theForm.submit();
	}

	function OnPageMove(intPage){
		document.theForm.action = "BoardSearch.asp?intPage=" + intPage;
		document.theForm.submit();
	}

</script>
<!-- #include file = "Foot.asp" -->