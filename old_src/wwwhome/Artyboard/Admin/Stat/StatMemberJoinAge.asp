<%
	DIM intTopMenu, intLeftMenu, isAdminMenu
	intTopMenu  = 6
	intLeftMenu = 2
	isAdminMenu = 2
%>
<!-- #include file = "Head.asp" -->
<%
	DIM Query, I, strSearchType, sDateS, sDateE, iCount

	strSearchType = REQUEST.FORM("strSearchType")
	IF strSearchType = "" THEN strSearchType = "1"

	DIM intAge1, intAge2, intAge3, intAge4, intAge5, intAge6
	intAge1 = REQUEST.FORM("intAge1")
	intAge2 = REQUEST.FORM("intAge2")
	intAge3 = REQUEST.FORM("intAge3")
	intAge4 = REQUEST.FORM("intAge4")
	intAge5 = REQUEST.FORM("intAge5")
	intAge6 = REQUEST.FORM("intAge6")


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
                      <td height="35"><img src="../images/main_title28.gif" width="165" height="19"></td>
                      <td align="right">관리자 홈 &gt; 통계자료 &gt; <b>연령대별 회원가입 통계</b></td>
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
													<tr>
														<td class="table_SelecttdLeft1">세부나이</td>
														<td>
														<input name="intAge1" type="checkbox" id="intAge1" value="1" class="no_Line"<% IF intAge1 = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="intAge1" style="cursor:hand">10대</LABEL>
														<input name="intAge2" type="checkbox" id="intAge2" value="1" class="no_Line"<% IF intAge2 = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="intAge2" style="cursor:hand">20대</LABEL>
														<input name="intAge3" type="checkbox" id="intAge3" value="1" class="no_Line"<% IF intAge3 = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="intAge3" style="cursor:hand">30대</LABEL>
														<input name="intAge4" type="checkbox" id="intAge4" value="1" class="no_Line"<% IF intAge4 = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="intAge4" style="cursor:hand">40대</LABEL>
														<input name="intAge5" type="checkbox" id="intAge5" value="1" class="no_Line"<% IF intAge5 = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="intAge5" style="cursor:hand">50대</LABEL>
														<input name="intAge6" type="checkbox" id="intAge6" value="1" class="no_Line"<% IF intAge6 = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="intAge6" style="cursor:hand">60대</LABEL></td>
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
<%
	SET RS = DBCON.EXECUTE("SELECT COUNT(CASE WHEN(CASE WHEN SUBSTRING([strSSN], 7, 1) < 3 THEN YEAR(GETDATE()) - CAST ('19' + SUBSTRING([strSSN], 1, 2) AS INT) ELSE YEAR(GETDATE()) - CAST('20' + SUBSTRING ([strSSN], 1, 2) AS INT) END) / 10 = 0 THEN 1 ELSE NULL END) AS 'aCount', COUNT(CASE WHEN(CASE WHEN SUBSTRING([strSSN], 7, 1) < 3 THEN YEAR(GETDATE()) - CAST ('19' + SUBSTRING([strSSN], 1, 2) AS INT) ELSE YEAR(GETDATE()) - CAST('20' + SUBSTRING ([strSSN], 1, 2) AS INT) END) / 10 = 1 THEN 1 ELSE NULL END) AS 'bCount', COUNT(CASE WHEN(CASE WHEN SUBSTRING([strSSN], 7, 1) < 3 THEN YEAR(GETDATE()) - CAST ('19' + SUBSTRING([strSSN], 1, 2) AS INT) ELSE YEAR(GETDATE()) - CAST('20' + SUBSTRING ([strSSN], 1, 2) AS INT) END) / 10 = 2 THEN 1 ELSE NULL END) AS 'cCount', COUNT(CASE WHEN(CASE WHEN SUBSTRING([strSSN], 7, 1) < 3 THEN YEAR(GETDATE()) - CAST ('19' + SUBSTRING([strSSN], 1, 2) AS INT) ELSE YEAR(GETDATE()) - CAST('20' + SUBSTRING ([strSSN], 1, 2) AS INT) END) / 10 = 3 THEN 1 ELSE NULL END) AS 'dCount', COUNT(CASE WHEN(CASE WHEN SUBSTRING([strSSN], 7, 1) < 3 THEN YEAR(GETDATE()) - CAST ('19' + SUBSTRING([strSSN], 1, 2) AS INT) ELSE YEAR(GETDATE()) - CAST('20' + SUBSTRING ([strSSN], 1, 2) AS INT) END) / 10 = 4 THEN 1 ELSE NULL END) AS 'eCount', COUNT(CASE WHEN(CASE WHEN SUBSTRING([strSSN], 7, 1) < 3 THEN YEAR(GETDATE()) - CAST ('19' + SUBSTRING([strSSN], 1, 2) AS INT) ELSE YEAR(GETDATE()) - CAST('20' + SUBSTRING ([strSSN], 1, 2) AS INT) END) / 10 = 5 THEN 1 ELSE NULL END) AS 'fCount', COUNT(CASE WHEN(CASE WHEN SUBSTRING([strSSN], 7, 1) < 3 THEN YEAR(GETDATE()) - CAST ('19' + SUBSTRING([strSSN], 1, 2) AS INT) ELSE YEAR(GETDATE()) - CAST('20' + SUBSTRING ([strSSN], 1, 2) AS INT) END) / 10 = 6 THEN 1 ELSE NULL END) AS 'gCount', COUNT(CASE WHEN(CASE WHEN SUBSTRING([strSSN], 7, 1) < 3 THEN YEAR(GETDATE()) - CAST ('19' + SUBSTRING([strSSN], 1, 2) AS INT) ELSE YEAR(GETDATE()) - CAST('20' + SUBSTRING ([strSSN], 1, 2) AS INT) END) / 10 NOT IN(0,1,2,3,4,5,6) THEN 1 ELSE NULL END) AS 'hCount' FROM [MPLUS_MEMBER_LIST] WHERE [bitSecession] = '0' " & Query)
%>
							<tr>
								<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>전체회원</strong></span></td>
							</tr>
							<tr>
								<td>
									<table width="100%"  border="0" cellpadding="0" cellspacing="0">
										<tr align="center" bgcolor="EB766F">
											<td colspan="4" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td width="140" nowrap class="table_Txt1">구분</td>
											<td width="140" nowrap class="table_Txt1">회원수</td>
											<td width="140" height="30" nowrap class="table_Txt1">비율</td>
											<td nowrap class="table_Txt1">그래프</td>
											</tr>
										<tr align="center" bgcolor="EB766F">
											<td colspan="4" class="table_Round1"></td>
										</tr>
<%
	DIM intTotalCount
	intTotalCount = RS("aCount") + RS("bCount") + RS("cCount") + RS("dCount") + RS("eCount") + RS("fCount") + RS("gCount") + RS("hCount")
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td align="center" class="table_ListSubText1">10대 이하</td>
											<td align="center" class="table_ListSubText1"><%=GetMoneyComma(RS("aCount"))%></td>
											<td align="center" class="table_ListSubText1"><% IF RS("aCount") = 0 THEN %>0%<% ELSE %><%=FormatPercent(RS("aCount")/intTotalCount)%><% END IF %></td>
											<td align="left" class="table_ListSubText1"><img src="../images/grp1.gif" width="<% IF RS("aCount") = 0 THEN %>0<% ELSE %><%=GetCeil(REPLACE(FormatPercent(RS("aCount")/intTotalCount),"%",""))%><% END IF %>%" height="10"></td>
											</tr>
										<tr>
											<td colspan="4" class="table_ListSubLine1"></td>
										</tr>
										<tr bgcolor="#FFFFFF" align="center">
											<td align="center" class="table_ListSubText1">10대</td>
											<td align="center" class="table_ListSubText1"><%=GetMoneyComma(RS("bCount"))%></td>
											<td align="center" class="table_ListSubText1"><% IF RS("bCount") = 0 THEN %>0%<% ELSE %><%=FormatPercent(RS("bCount")/intTotalCount)%><% END IF %></td>
											<td align="left" class="table_ListSubText1"><img src="../images/grp2.gif" width="<% IF RS("bCount") = 0 THEN %>0<% ELSE %><%=GetCeil(REPLACE(FormatPercent(RS("bCount")/intTotalCount),"%",""))%><% END IF %>%" height="10"></td>
											</tr>
										<tr>
											<td colspan="4" class="table_ListSubLine1"></td>
										</tr>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1">20대</td>
											<td align="center" class="table_ListSubText1"><%=GetMoneyComma(RS("cCount"))%></td>
											<td align="center" class="table_ListSubText1"><% IF RS("cCount") = 0 THEN %>0%<% ELSE %><%=FormatPercent(RS("cCount")/intTotalCount)%><% END IF %></td>
											<td align="left" class="table_ListSubText1"><img src="../images/grp3.gif" width="<% IF RS("cCount") = 0 THEN %>0<% ELSE %><%=GetCeil(REPLACE(FormatPercent(RS("cCount")/intTotalCount),"%",""))%><% END IF %>%" height="10"></td>
											</tr>
										<tr>
											<td colspan="4" class="table_ListSubLine1"></td>
										</tr>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1">30대</td>
											<td align="center" class="table_ListSubText1"><%=GetMoneyComma(RS("dCount"))%></td>
											<td align="center" class="table_ListSubText1"><% IF RS("dCount") = 0 THEN %>0%<% ELSE %><%=FormatPercent(RS("dCount")/intTotalCount)%><% END IF %></td>
											<td align="left" class="table_ListSubText1"><img src="../images/grp4.gif" width="<% IF RS("dCount") = 0 THEN %>0<% ELSE %><%=GetCeil(REPLACE(FormatPercent(RS("dCount")/intTotalCount),"%",""))%><% END IF %>%" height="10"></td>
											</tr>
										<tr>
											<td colspan="4" class="table_ListSubLine1"></td>
										</tr>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1">40대</td>
											<td align="center" class="table_ListSubText1"><%=GetMoneyComma(RS("eCount"))%></td>
											<td align="center" class="table_ListSubText1"><% IF RS("eCount") = 0 THEN %>0%<% ELSE %><%=FormatPercent(RS("eCount")/intTotalCount)%><% END IF %></td>
											<td align="left" class="table_ListSubText1"><img src="../images/grp5.gif" width="<% IF RS("eCount") = 0 THEN %>0<% ELSE %><%=GetCeil(REPLACE(FormatPercent(RS("eCount")/intTotalCount),"%",""))%><% END IF %>%" height="10"></td>
											</tr>
										<tr>
											<td colspan="4" class="table_ListSubLine1"></td>
										</tr>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1">50대</td>
											<td align="center" class="table_ListSubText1"><%=GetMoneyComma(RS("fCount"))%></td>
											<td align="center" class="table_ListSubText1"><% IF RS("fCount") = 0 THEN %>0%<% ELSE %><%=FormatPercent(RS("fCount")/intTotalCount)%><% END IF %></td>
											<td align="left" class="table_ListSubText1"><img src="../images/grp6.gif" width="<% IF RS("fCount") = 0 THEN %>0<% ELSE %><%=GetCeil(REPLACE(FormatPercent(RS("fCount")/intTotalCount),"%",""))%><% END IF %>%" height="10"></td>
											</tr>
										<tr>
											<td colspan="4" class="table_ListSubLine1"></td>
										</tr>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1">60대</td>
											<td align="center" class="table_ListSubText1"><%=GetMoneyComma(RS("gCount"))%></td>
											<td align="center" class="table_ListSubText1"><% IF RS("gCount") = 0 THEN %>0%<% ELSE %><%=FormatPercent(RS("gCount")/intTotalCount)%><% END IF %></td>
											<td align="left" class="table_ListSubText1"><img src="../images/grp7.gif" width="<% IF RS("gCount") = 0 THEN %>0<% ELSE %><%=GetCeil(REPLACE(FormatPercent(RS("gCount")/intTotalCount),"%",""))%><% END IF %>%" height="10"></td>
											</tr>
										<tr>
											<td colspan="4" class="table_ListSubLine1"></td>
										</tr>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1">60대 이상</td>
											<td align="center" class="table_ListSubText1"><%=GetMoneyComma(RS("hCount"))%></td>
											<td align="center" class="table_ListSubText1"><% IF RS("hCount") = 0 THEN %>0%<% ELSE %><%=FormatPercent(RS("hCount")/intTotalCount)%><% END IF %></td>
											<td align="left" class="table_ListSubText1"><img src="../images/grp8.gif" width="<% IF RS("hCount") = 0 THEN %>0<% ELSE %><%=GetCeil(REPLACE(FormatPercent(RS("hCount")/intTotalCount),"%",""))%><% END IF %>%" height="10"></td>
											</tr>
										<tr>
											<td colspan="4" class="table_ListSubLine1"></td>
										</tr>
										<tr>
											<td colspan="4" class="table_ListSubLine1" height="2"></td>
										</tr>
										<tr bgcolor="#FFFFFF" align="center">
											<td align="center" class="table_ListSubText1"><b>합계</b></td>
											<td align="center" class="table_ListSubText1"><b><%=GetMoneyComma(intTotalCount)%></b></td>
											<td class="table_ListSubText1"><b>100%</b></td>
											<td align="right" class="table_ListSubText1">&nbsp;</td>
											</tr>
										<tr>
											<td colspan="4" class="table_ListSubLine1"></td>
										</tr>
										<tr>
											<td colspan="4" height="1"></td>
										</tr>
										<tr>
											<td colspan="4" class="table_ListSubBLine1"></td>
										</tr>
									</table>
								</td>
							</tr>
<%
	DIM isReturn, strAgeQuery1, strAgeQuery2
	FOR I = 1 TO 6
	SELECT CASE I
	CASE "1"
		IF intAge1 = "1" THEN
			isReturn = True
			strAgeQuery1 = 10
			strAgeQuery2 = 19
		ELSE
			isReturn = False
		END IF
	CASE "2"
		IF intAge2 = "1" THEN
			isReturn = True
			strAgeQuery1 = 20
			strAgeQuery2 = 29
		ELSE
			isReturn = False
		END IF
	CASE "3"
		IF intAge3 = "1" THEN
			isReturn = True
			strAgeQuery1 = 30
			strAgeQuery2 = 39
		ELSE
			isReturn = False
		END IF
	CASE "4"
		IF intAge4 = "1" THEN
			isReturn = True
			strAgeQuery1 = 40
			strAgeQuery2 = 49
		ELSE
			isReturn = False
		END IF
	CASE "5"
		IF intAge5 = "1" THEN
			isReturn = True
			strAgeQuery1 = 50
			strAgeQuery2 = 59
		ELSE
			isReturn = False
		END IF
	CASE "6"
		IF intAge6 = "1" THEN
			isReturn = True
			strAgeQuery1 = 60
			strAgeQuery2 = 69
		ELSE
			isReturn = False
		END IF
	END SELECT

	IF isReturn = True THEN
%>
							<tr>
								<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong><%=strAgeQuery1%>대 정보</strong></span></td>
							</tr>
							<tr>
								<td>
									<table width="100%"  border="0" cellpadding="0" cellspacing="0">
										<tr align="center" bgcolor="EB766F">
											<td colspan="4" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td width="140" nowrap class="table_Txt1">구분</td>
											<td width="140" nowrap class="table_Txt1">회원수</td>
											<td width="140" height="30" nowrap class="table_Txt1">비율</td>
											<td nowrap class="table_Txt1">그래프</td>
											</tr>
										<tr align="center" bgcolor="EB766F">
											<td colspan="4" class="table_Round1"></td>
										</tr>
<%
	SET RS = DBCON.EXECUTE("SELECT COUNT([intNum]) FROM [MPLUS_MEMBER_LIST] WHERE [bitSecession] = '0' " & Query & " AND LEFT(YEAR(GETDATE()),4) - CONVERT(INT,((CONVERT(VARCHAR,CASE SUBSTRING([strSSN],1,1) WHEN '0' THEN '20' ELSE '19' END))) + CONVERT(VARCHAR, SUBSTRING([strSSN],1,2))) BETWEEN " & strAgeQuery1 & " AND " & strAgeQuery2)

	intTotalCount = RS(0)

	SET RS = DBCON.EXECUTE("SELECT LEFT(YEAR(GETDATE()),4) - CONVERT(INT,((CONVERT(VARCHAR, CASE SUBSTRING([strSSN],1,1) WHEN '0' THEN '20' ELSE '19' END))) +  CONVERT(VARCHAR, SUBSTRING([strSSN],1,2))) AS [intAge], COUNT(LEFT(YEAR(GETDATE()),4) - CONVERT(INT,((CONVERT(VARCHAR,CASE SUBSTRING([strSSN],1,1) WHEN '0' THEN '20' ELSE '19' END))) +  CONVERT(VARCHAR, SUBSTRING([strSSN],1,2)))) AS [intCount] FROM [MPLUS_MEMBER_LIST] WHERE [bitSecession] = '0' " & Query & " AND LEFT(YEAR(GETDATE()),4) - CONVERT(INT,((CONVERT(VARCHAR,CASE SUBSTRING([strSSN],1,1) WHEN '0' THEN '20' ELSE '19' END))) + CONVERT(VARCHAR, SUBSTRING([strSSN],1,2))) BETWEEN " & strAgeQuery1 & " AND " & strAgeQuery2 & " GROUP BY LEFT(YEAR(GETDATE()),4) - CONVERT(INT,((CONVERT(VARCHAR,CASE SUBSTRING([strSSN],1,1) WHEN '0' THEN '20' ELSE '19' END))) +  CONVERT(VARCHAR, SUBSTRING([strSSN],1,2))) ")

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
		iCount = 0
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td align="center" class="table_ListSubText1"><%=RS("intAge")%>세</td>
											<td align="center" class="table_ListSubText1"><%=GetMoneyComma(RS("intCount"))%></td>
											<td align="center" class="table_ListSubText1"><%=FormatPercent(RS("intCount")/intTotalCount)%></td>
											<td align="left" class="table_ListSubText1"><img src="../images/grp<%=iCount%>.gif" width="<%=GetCeil(REPLACE(FormatPercent(RS("intCount")/intTotalCount),"%",""))%>%" height="10"></td>
											</tr>
										<tr>
											<td colspan="4" class="table_ListSubLine1"></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
										<tr>
											<td colspan="4" height="1"></td>
										</tr>
										<tr>
											<td colspan="4" class="table_ListSubBLine1"></td>
										</tr>
									</table>
								</td>
							</tr>
<%
		END IF
	NEXT
%>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>다양한 검색조건을 이용해서 연령대별로 회원가입 통계를 확인할 수 있습니다.</LI>
											<LI>세부나이에서 통계를 확인하고 싶은 나이대를 선택 후 검색을 하시면 해당 나이대의 세부통계 확인이 가능합니다.</LI>
											<LI>연령대별 통계를 확인하시려면 회원가입 항목설정에서 <font color="#FD8402"><b>주민등록번호</b></font>를 필수로 입력받아야 합니다.</LI>
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
		document.theForm.action = "StatMemberJoinAge.asp";
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