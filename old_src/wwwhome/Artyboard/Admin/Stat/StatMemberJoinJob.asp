<%
	DIM intTopMenu, intLeftMenu, isAdminMenu
	intTopMenu  = 6
	intLeftMenu = 5
	isAdminMenu = 2
%>
<!-- #include file = "Head.asp" -->
<%
	DIM Query, I, strSearchType, sDateS, sDateE, iCount

	strSearchType = REQUEST.FORM("strSearchType")
	IF strSearchType = "" THEN strSearchType = "1"

	DIM sDateYear, sDateMonth
	sDateYear  = REQUEST.FORM("sDateYear")
	sDateMonth = REQUEST.FORM("sDateMonth")
	
	IF sDateYear  = "" THEN sDateYear  = YEAR(NOW)
	IF sDateMonth = "" THEN sDateMonth = MONTH(NOW)

	sDateS = REQUEST.FORM("sDateS")
	IF sDateS = "" THEN
		sDateS = YEAR(NOW)
		sDateS = sDateS & "-"
		IF LEN(MONTH(NOW)) = 1 THEN sDateS = sDateS & "0" & MONTH(NOW) ELSE sDateS = sDateS & MONTH(NOW)
		sDateS = sDateS & "-01"
	END IF

	sDateE = REQUEST.FORM("sDateE")
	IF sDateE = "" THEN
		sDateE = YEAR(NOW)
		sDateE = sDateE & "-"
		IF LEN(MONTH(NOW)) = 1 THEN sDateE = sDateE & "0" & MONTH(NOW) ELSE sDateE = sDateE & MONTH(NOW)
		sDateE = sDateE & "-"
		IF LEN(DAY(NOW)) = 1 THEN sDateE = sDateE & "0" & DAY(NOW) ELSE sDateE = sDateE & DAY(NOW)
	END IF

	Query = " AND [strAdmin]!= '2' "

	SELECT CASE strSearchType
	CASE "2" : Query = Query & " AND [dateRegDate] BETWEEN '" & sDateS & "' AND '" & DATEADD("d", 1, sDateE) & "' "
	CASE "3" : Query = Query & " AND DATEPART(yy, [dateRegDate]) = '" & sDateYear & "' "
	CASE "4" : Query = Query & " AND DATEPART(mm, [dateRegDate]) = '" & sDateMonth & "' "
	CASE "5" : Query = Query & " AND DATEPART(yy, [dateRegDate]) = '" & YEAR(NOW) & "' AND DATEPART(mm, [dateRegDate]) = '" & MONTH(NOW) & "' AND DATEPART(mm, [dateRegDate]) = '" & DAY(NOW) & "' "
	END SELECT
%>
						<script language="javascript" src="../../Js/Calendar.js"></script>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title31.gif" width="121" height="19"></td>
                      <td align="right">관리자 홈 &gt; 통계자료 &gt; <b>직업별 회원통계</b></td>
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
											<td class="table_SelecttdLeft1">검색조건</td>
											<td>
											<input type="radio" name="strSearchType" id="strSearchType1" value="1" class="no_Line"<% IF strSearchType = "1" THEN %> CHECKED<% END IF %> onClick="OnSearchType('1');">
											<LABEL FOR="strSearchType1" style="cursor:hand">전체</LABEL>
											<input type="radio" name="strSearchType" id="strSearchType2" value="2" class="no_Line"<% IF strSearchType = "2" THEN %> CHECKED<% END IF %> onClick="OnSearchType('2');">
											<LABEL FOR="strSearchType2" style="cursor:hand">기간별</LABEL>
											<input type="radio" name="strSearchType" id="strSearchType3" value="3" class="no_Line"<% IF strSearchType = "3" THEN %> CHECKED<% END IF %> onClick="OnSearchType('3');">
											<LABEL FOR="strSearchType3" style="cursor:hand">년도별</LABEL>
											<input type="radio" name="strSearchType" id="strSearchType4" value="4" class="no_Line"<% IF strSearchType = "4" THEN %> CHECKED<% END IF %> onClick="OnSearchType('4');">
											<LABEL FOR="strSearchType4" style="cursor:hand">월별</LABEL>
											<input type="radio" name="strSearchType" id="strSearchType5" value="5" class="no_Line"<% IF strSearchType = "5" THEN %> CHECKED<% END IF %> onClick="OnSearchType('5');">
											<LABEL FOR="strSearchType5" style="cursor:hand">금일</LABEL></td>
										</tr>
										<tr id="tr_Search2" style="display:<% IF strSearchType = "2" THEN %>block<% ELSE %>none<% END IF %>">
											<td class="table_SelecttdLeft1">기간선택</td>
											<td><input name="sDateS" type="text" id="sDateS" onClick="Calendar_D(document.all.sDateS);" value="<%=sDateS%>" size="10" maxlength="10" readonly>
											<img src="../images/calendar.gif" width="24" height="22" align="absmiddle" onClick="Calendar_D(document.all.sDateS);" style="cursor:hand;">
											~
											<input name="sDateE" type="text" id="sDateE" onClick="Calendar_D(document.all.sDateE);" value="<%=sDateE%>" size="10" maxlength="10" readonly>
											<img src="../images/calendar.gif" width="24" height="22" align="absmiddle" onClick="Calendar_D(document.all.sDateE);" style="cursor:hand">
<a href="javascript:;" onClick="OnSearchDate('<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');return false;"><img src="../images/btn_day1.gif" width="35" height="15" border="0"></a>
										  <a href="javascript:;" onClick="OnSearchDate('<%=YEAR(DATEADD("d", -1, NOW()))%>','<%=MONTH(DATEADD("d", -1, NOW()))%>','<%=DAY(DATEADD("d", -1, NOW()))%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');"><img src="../images/btn_day2.gif" width="35" height="15" border="0"></a>
										  <a href="javascript:;" onClick="OnSearchDate('<%=YEAR(DATEADD("d", -3, NOW()))%>','<%=MONTH(DATEADD("d", -3, NOW()))%>','<%=DAY(DATEADD("d", -3, NOW()))%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');"><img src="../images/btn_day3.gif" width="35" height="15" border="0"></a>
										  <a href="javascript:;" onClick="OnSearchDate('<%=YEAR(DATEADD("d", -7, NOW()))%>','<%=MONTH(DATEADD("d", -7, NOW()))%>','<%=DAY(DATEADD("d", -7, NOW()))%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');"><img src="../images/btn_day4.gif" width="35" height="15" border="0"></a>
										  <a href="javascript:;" onClick="OnSearchDate('<%=YEAR(DATEADD("d", -10, NOW()))%>','<%=MONTH(DATEADD("d", -10, NOW()))%>','<%=DAY(DATEADD("d", -10, NOW()))%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');"><img src="../images/btn_day5.gif" width="35" height="15" border="0"></a>
										  <a href="javascript:;" onClick="OnSearchDate('<%=YEAR(DATEADD("d", -20, NOW()))%>','<%=MONTH(DATEADD("d", -20, NOW()))%>','<%=DAY(DATEADD("d", -20, NOW()))%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');"><img src="../images/btn_day6.gif" width="35" height="15" border="0"></a>
										  <a href="javascript:;" onClick="OnSearchDate('<%=YEAR(DATEADD("d", -30, NOW()))%>','<%=MONTH(DATEADD("d", -30, NOW()))%>','<%=DAY(DATEADD("d", -30, NOW()))%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');"><img src="../images/btn_day7.gif" width="35" height="15" border="0"></a>
										  <a href="javascript:;" onClick="OnSearchDate('<%=YEAR(DATEADD("d", -60, NOW()))%>','<%=MONTH(DATEADD("d", -60, NOW()))%>','<%=DAY(DATEADD("d", -60, NOW()))%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');"><img src="../images/btn_day8.gif" width="35" height="15" border="0"></a></td>
										</tr>
										<tr id="tr_Search3" style="display:<% IF strSearchType = "3" THEN %>block<% ELSE %>none<% END IF %>">
											<td class="table_SelecttdLeft1">년도선택</td>
											<td>
											<select name="sDateYear" id="sDateYear">
<%
	FOR I = YEAR(NOW) - 2 TO YEAR(NOW) + 2
		RESPONSE.WRITE "<option value='" & I & "'"
		IF INT(I) = INT(sDateYear) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "년</option>" & vbcrlf
	NEXT
%>
											</select>
											</td>
										</tr>
										<tr id="tr_Search4" style="display:<% IF strSearchType = "4" THEN %>block<% ELSE %>none<% END IF %>">
											<td class="table_SelecttdLeft1">월선택</td>
											<td>
											<select name="sDateMonth" id="sDateMonth">
<%
	FOR I = 1 TO 12
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0"
		RESPONSE.WRITE I & "'"
		IF INT(I) = INT(sDateMonth) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "월</option>" & vbcrlf
	NEXT
%>
											</select>
											</td>
										</tr>
									</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="40" align="center"><a href="javascript:;" onclick="OnStatSearch();return false;"><img src="../images/btn_search_m.gif" width="69" height="25" border="0" /></a></td>
							</tr>
							<tr>
								<td>
					<table width="100%"  border="0" cellpadding="0" cellspacing="0">
						<tr align="center" bgcolor="EB766F">
						  <td colspan="4" class="table_Round1"></td>
					  </tr>
						<tr align="center" bgcolor="EB766F">
						  <td width="140" nowrap class="table_Txt1">직업</td>
						  <td width="140" nowrap class="table_Txt1">회원수</td>
						  <td width="140" height="30" nowrap class="table_Txt1">비율</td>
							<td nowrap class="table_Txt1">그래프</td>
							</tr>
						<tr align="center" bgcolor="EB766F">
						  <td colspan="4" class="table_Round1"></td>
					  </tr>
<%
	DIM intTotalCount
	SET RS = DBCON.EXECUTE("SELECT COUNT([intNum]) FROM [MPLUS_MEMBER_LIST] WHERE [bitSecession] = '0' " & Query)
	intTotalCount = RS(0)

	SET RS = DBCON.EXECUTE("SELECT [strJob], COUNT([strJob]) AS [intCount] FROM [MPLUS_MEMBER_LIST] WHERE [bitSecession] = '0' " & Query & " GROUP BY [strJob] ORDER BY [strJob] ASC ")

	IF RS.EOF THEN
%>
						<tr bgcolor="#FFFFFF" align="center">
						  <td colspan="4" align="center" class="table_ListSubText1">검색된 회원이 없습니다. </td>
						  </tr>
						<tr>
							<td colspan="4" class="table_ListSubLine1"></td>
						</tr>
<%
	ELSE
		WHILE NOT(RS.EOF)
%>
						<tr bgcolor="#FFFFFF" align="center">
						  <td align="center" class="table_ListSubText1"><% IF RS("strJob") <> "" AND ISNULL(RS("strJob")) = False THEN %><%=RS("strJob")%><% ELSE %>정보없음<% END IF %></td>
						  <td align="center" class="table_ListSubText1"><%=GetMoneyComma(RS("intCount"))%></td>
						  <td align="center" class="table_ListSubText1"><% IF RS("intCount") = "0" THEN %>0%<% ELSE %><%=FormatPercent(RS("intCount")/intTotalCount)%><% END IF %></td>
							<td align="left" class="table_ListSubText1"><img src="../images/grp1.gif" width="<% IF RS("intCount") = "0" THEN %>0<% ELSE %><%=GetCeil(REPLACE(FormatPercent(RS("intCount")/intTotalCount),"%",""))%><% END IF %>%" height="10"></td>
							</tr>
						<tr>
							<td colspan="4" class="table_ListSubLine1"></td>
						</tr>
<%
		RS.MOVENEXT
		WEND
%>
						<tr>
							<td colspan="4" class="table_ListSubLine1" height="2"></td>
						</tr>
						<tr bgcolor="#FFFFFF" align="center">
						  <td align="center" class="table_ListSubText1"><b>합계</b></td>
						  <td align="center" class="table_ListSubText1"><b><%=GetMoneyComma(intTotalCount)%></b></td>
						  <td class="table_ListSubText1"><b>100%</b></td>
							<td class="table_ListSubText1">&nbsp;</td>
							</tr>
						<tr>
							<td colspan="4" class="table_ListSubLine1"></td>
						</tr>
<% END IF %>
						<tr>
							<td colspan="4" height="1"></td>
						</tr>
						<tr>
							<td colspan="4" class="table_ListSubBLine1"></td>
						</tr>
				  </table>
								</td>
							</tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>다양한 검색조건을 이용해서 직업별 회원가입 통계를 확인할 수 있습니다.</LI>
											<LI>직업정보는 회원가입시 선택한 직업에 대해서 통계를 처리합니다.</LI>
											<LI>직업별 통계를 확인하시려면 회원가입 항목설정에서 <font color="#FD8402"><b>직업정보</b></font>를 필수로 입력받아야 합니다.</LI>
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
<script language="javascript">

	function OnSearchType(str){
		document.all['tr_Search2'].style.display = "none";
		document.all['tr_Search3'].style.display = "none";
		document.all['tr_Search4'].style.display = "none";

		switch (str){
			case "2" :
			document.all['tr_Search2'].style.display = "block";
			break;
			case "3" :
			document.all['tr_Search3'].style.display = "block";
			break;
			case "4" :
			document.all['tr_Search4'].style.display = "block";
			break;
		}

	}

	function OnStatSearch(){
		document.theForm.action = "StatMemberJoinJob.asp";
		document.theForm.submit();
	}

	function OnSearchDate(sy, sm, sd, ey, em, ed){

		if (sm.length == 1){sm = "0" + sm;}
		if (sd.length == 1){sd = "0" + sd;}
		if (em.length == 1){em = "0" + em;}
		if (ed.length == 1){ed = "0" + ed;}

		document.all['sDateS'].value = sy + "-" + sm + "-" + sd;
		document.all['sDateE'].value = ey + "-" + em + "-" + ed;

	}
</script>
<!-- #include file = "Foot.asp" -->