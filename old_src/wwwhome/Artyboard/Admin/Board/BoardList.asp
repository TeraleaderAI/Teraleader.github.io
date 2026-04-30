<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 5
	intLeftMenu  = 2
	isAdminMenu  = 1
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount, Query1, Query2, I, strOrder
	intPage     = REQUEST.QueryString("intPage")     : IF intPage = "" THEN intPage = 1
	intPageSize = REQUEST.FORM("intPageSize") : IF intPageSize = "" THEN intPageSize = 20

	IF SESSION("strAdmin") = "1" THEN
		SET RS = DBCON.EXECUTE("SELECT [strBoardID], [strAdmin] FROM [MPLUS_BOARD_CONFIG_DEFAULT] ")
		IF RS.EOF THEN
			Query1 = " WHERE [strBoardID] = '' "
			Query2 = " AND [strBoardID] = '' "
		ELSE
			Query1 = ""
			Query2 = ""
			WHILE NOT(RS.EOF)
				IF RS("strAdmin") <> "" AND ISNULL(RS("strAdmin")) = False THEN
					SplitStrAdmin = SPLIT(RS("strAdmin"), "|")
					FOR I = 0 TO UBOUND(SplitStrAdmin)
						IF SplitStrAdmin(I) = SESSION("strLoginID") THEN
							Query1 = Query1 & RS("strBoardID") & ","
							Query2 = Query2 & RS("strBoardID") & ","
						END IF
					NEXT
				END IF
			RS.MOVENEXT
			WEND
			IF Query1 <> "" THEN Query1 = " WHERE [strBoardID] IN (" & getSplitQuery(Query1) & ") "
			IF Query2 <> "" THEN Query2 = " AND [strBoardID] IN (" & getSplitQuery(Query2) & ") "
		END IF
	ELSE
		Query1 = ""
		Query2 = ""
	END IF

	strOrder = REQUEST.FORM("strOrder")
	IF strOrder = "" THEN strOrder = "[intNum] DESC"

	SET RS = DBCON.EXECUTE("SELECT COUNT([intNum]) AS [RecCount] FROM [MPLUS_BOARD_CONFIG_DEFAULT] " & Query1)

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [strBoardID], [strName], [strMemo], [strAdmin], [strSkin], [strSKinGroup], [dateRegDate], [intTodayBoardCount] = (SELECT COUNT([intSeq]) FROM [MPLUS_BOARD] WHERE [strBoardID] = [MPLUS_BOARD_CONFIG_DEFAULT].[strBoardID] AND DATEDIFF(day, [dateRegDate], GETDATE()) = 0 AND [bitDelete] = '0'), [intTotalBoardCount] = (SELECT COUNT([intSeq]) FROM [MPLUS_BOARD] WHERE [strBoardID] = [MPLUS_BOARD_CONFIG_DEFAULT].[strBoardID] AND [bitDelete] = '0') FROM [MPLUS_BOARD_CONFIG_DEFAULT] WHERE [intNum] NOT IN (SELECT TOP " & (intPage - 1) * intPageSize & " [intNum] FROM [MPLUS_BOARD_CONFIG_DEFAULT] " & Query1 & " ORDER BY " & strOrder & ") " & Query2 & " ORDER BY " & strOrder)
%>						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" action="BoardList.asp">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title20.gif" width="108" height="19"></td>
                      <td align="right">관리자 홈 &gt; 게시판관리 &gt; <b>게시판 리스트</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>등록된 게시판 리스트</strong></span></td>
              </tr>
              <tr>
                <td style="padding-top:5; padding-bottom:5;">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>전체 : <font color="#C6325B"><b><%=intTotalCount%></b></font>&nbsp;&nbsp;<%=intPage%>/<%=intPageCount%> 페이지 </td>
											<td align="right">
											<b>정렬방식</b>
											<select name="strOrder" id="strOrder" onChange="document.theForm.submit();">
											<option value="[intNum] DESC"<% IF strOrder = "[intNum] DESC" THEN %> SELECTED<% END IF %>>- 게시판 생성일↑</option>
											<option value="[intNum] ASC"<% IF strOrder = "[intNum] ASC" THEN %> SELECTED<% END IF %>>- 게시판 생성일↓</option>
											<option value="[strBoardID] DESC"<% IF strOrder = "[strBoardID] DESC" THEN %> SELECTED<% END IF %>>- 게시판 아이디↑</option>
											<option value="[strBoardID] ASC"<% IF strOrder = "[strBoardID] ASC" THEN %> SELECTED<% END IF %>>- 게시판 아이디↓</option>
											<option value="[strName] DESC"<% IF strOrder = "[strName] DESC" THEN %> SELECTED<% END IF %>>- 게시판 이름↑</option>
											<option value="[strName] ASC"<% IF strOrder = "[strName] ASC" THEN %> SELECTED<% END IF %>>- 게시판 이름↓</option>
											</select>
											<b>출력개수설정</b>
											<select name="intPageSize" id="intPageSize" onchange="document.theForm.submit();">
											<option value="10"<% IF intPageSize = 10 THEN %> SELECTED<% END IF %>>10</option>
											<option value="15"<% IF intPageSize = 15 THEN %> SELECTED<% END IF %>>15</option>
											<option value="20"<% IF intPageSize = 20 THEN %> SELECTED<% END IF %>>20</option>
											<option value="50"<% IF intPageSize = 50 THEN %> SELECTED<% END IF %>>50</option>
											<option value="100"<% IF intPageSize = 100 THEN %> SELECTED<% END IF %>>100</option>
											<option value="300"<% IF intPageSize = 300 THEN %> SELECTED<% END IF %>>300</option>
											<option value="500"<% IF intPageSize = 500 THEN %> SELECTED<% END IF %>>500</option>
											</select>											</td>
										</tr>
									</table>								</td>
              </tr>
              <tr>
                <td>
									<table width="100%"  border="0" cellpadding="0" cellspacing="0">
										<tr align="center" bgcolor="EB766F">
											<td colspan="11" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td height="30" class="table_Txt1" nowrap>번호</td>
											<td height="30" class="table_Txt1" nowrap>게시판 아이디</td>
											<td height="30" class="table_Txt1" nowrap>게시판 이름 </td>
											<td height="30" class="table_Txt1" nowrap>관리자</td>
											<td class="table_Txt1" nowrap>오늘 / 전체</td>
											<td class="table_Txt1" nowrap>정보</td>
											<td class="table_Txt1" nowrap>통계</td>
											<td class="table_Txt1" nowrap>게시글</td>
											<td class="table_Txt1" nowrap>댓글</td>
											<td height="30" nowrap class="table_Txt1">설정</td>
											<td width="45" align="center" class="table_Txt1" nowrap>삭제</td>
										</tr>
										<tr bgcolor="EB766F">
											<td colspan="11" class="table_Round1"></td>
										</tr>
<%
	IF RS.EOF THEN
%>
										<tr align="center" bgcolor="#FFFFFF">
											<td colspan="11" class="table_ListSubText1">등록된 게시판이 없습니다.</td>
										</tr>
										<tr>
											<td colspan="11" class="table_ListSubLine1"></td>
										</tr>
<%
	ELSE
		DIM iCount, intBoardNum, strAdmin, strAdminTemp, intAdminCount
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intBoardNum = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
			strAdmin = RS("strAdmin")
			IF strAdmin = "" OR ISNULL(strAdmin) = True THEN
				strAdmin = "없음"
			ELSE
				strAdmin      = SPLIT(strAdmin, "|")
				intAdminCount = 0
				strAdminTemp  = ""
				FOR I = 0 TO UBOUND(strAdmin)
					IF strAdmin(I) <> "" THEN
						strAdminTemp = strAdminTemp & "<option>" & strAdmin(I) & "</option>" & vbcrlf
						intAdminCount = intAdminCount + 1
					END IF
				NEXT
				IF intAdminCount = 0 THEN
					strAdmin = "없음"
				ELSE
					strAdmin = "<select name=strAdminList>" & vbcrlf & strAdminTemp & "</select>"
				END IF
			END IF
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1"><%=intBoardNum%></td>
											<td class="table_ListSubText1"><a href="../../mboard.asp?strBoardID=<%=RS("strBoardID")%>" target="_blank"><b><font color="#C6325B"><%=RS("strBoardID")%></font></b></a></td>
											<td class="table_ListSubText1"><%=RS("strName")%></td>
											<td class="table_ListSubText1"><%=strAdmin%></td>
											<td class="table_ListSubText1"><%=RS("intTodayBoardCount")%> / <%=RS("intTotalBoardCount")%></td>
											<td class="table_ListSubText1"><a href="javascript:popupLayer('BoardInfo.asp?strBoardID=<%=RS("strBoardID")%>',720,220);"><img src="../images/btn_view_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:popupLayer('BoardStat.asp?strBoardID=<%=RS("strBoardID")%>',800,632);"><img src="../images/btn_view_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:;" onClick="OnBoardSort('<%=RS("strBoardID")%>');return false;"><img src="../images/btn_sort_s.gif" width="38" height="16" border="0" /></a></td>
											<td class="table_ListSubText1"><a href="javascript:;" onClick="OnCmtSort('<%=RS("strBoardID")%>');return false;"><img src="../images/btn_sort_s.gif" width="38" height="16" border="0" /></a></td>
											<td class="table_ListSubText1"><a href="BoardDefaultConfig.asp?strBoardID=<%=RS("strBoardID")%>"><img src="../images/btn_setup2_s.gif" width="38" height="16" border="0" /></a></td>
											<td class="table_ListSubText1"><a href="javascript:;" onclick="OnBoardRemove('<%=RS("strBoardID")%>','<%=SESSION("strAdmin")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0"></a></td>
										</tr>
										<tr>
											<td colspan="11" class="table_ListSubLine1"></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
										<tr>
											<td colspan="11" height="1"></td>
										</tr>
										<tr>
											<td colspan="11" class="table_ListSubBLine1"></td>
										</tr>
									</table>								</td>
              </tr>
              <tr>
                <td height="40">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100"><a href="BoardMake.asp"><img src="../images/btn_board_make_m.gif" width="100" height="25" border="0"></a></td>
											<td align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
										</tr>
									</table>								</td>
              </tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>설정 버튼을 클릭하면 게시판별 다양한 기능을 추가적으로 설정이 가능합니다.</LI>
											<LI>게시판을 삭제하면 복구가 불가능하오니 주의하시기 바랍니다.</td>
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

	function OnPageMove(intPage){
		document.theForm.action = "BoardList.asp?intPage=" + intPage;
		document.theForm.submit();
	}

	function OnBoardRemove(str1, str2){
		if (str2 == "1"){alert("게시판을 삭제할 권한이 없습니다.");return false;}
		if(confirm("게시판을 삭제하시면 복구가 불가능합니다.\n\n게시판을 삭제하시겠습니까?")){
			document.theForm.action = "BoardDelete.asp?strBoardID=" + str1;
			document.theForm.submit();
		}
	}

	function OnBoardSort(strBoardID){

		if (confirm("게시글이 많은 경우 시간이 오래걸릴 수 있습니다.\n인덱스를 재 구성하시겠습니까?")){
			var arr = showModalDialog('boardIndex.asp?strBoardID=' + strBoardID, 'boardIndex', 'dialogWidth:300px; dialogHeight: 300px; resizable: no; help: no; status: no; scroll: no;');
		}

	}

	function OnCmtSort(strBoardID){

		if (confirm("댓글이 많은 경우 시간이 오래걸릴 수 있습니다.\n인덱스를 재 구성하시겠습니까?")){
			var arr = showModalDialog('cmtIndex.asp?strBoardID=' + strBoardID, 'boardIndex', 'dialogWidth:300px; dialogHeight: 300px; resizable: no; help: no; status: no; scroll: no;');
		}

	}

</script>
<!-- #include file = "Foot.asp" -->