<%
	DIM intTopMenu, intLeftMenu, isAdminMenu
	intTopMenu  = 6
	intLeftMenu = 7
	isAdminMenu = 2
%>
<!-- #include file = "Head.asp" -->
<%
	DIM sDateS, sDateE

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
%>
						<script language="javascript" src="../../Js/Calendar.js"></script>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title33.gif" width="121" height="19"></td>
                      <td align="right">관리자 홈 &gt; 통계자료 &gt; <b>요일별 접속통계</b></td>
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
														<td class="table_SelecttdLeft1">접속통계 기간선택</td>
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
											<td colspan="5" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td width="150" nowrap class="table_Txt1">날짜</td>
											<td width="100" nowrap class="table_Txt1">접속수</td>
											<td width="100" height="30" nowrap class="table_Txt1">기간평균</td>
											<td width="100" nowrap class="table_Txt1">비율</td>
											<td nowrap class="table_Txt1">그래프</td>
											</tr>
										<tr align="center" bgcolor="EB766F">
											<td colspan="5" class="table_Round1"></td>
										</tr>
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_STAT] '3', '" & sDateS & "', '" & sDateE & "' ")

	IF (RS.EOF) OR RS("totalCount") = 0 THEN
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td colspan="5" class="table_ListSubText1">등록된 접속정보가 없습니다.</td>
										</tr>
										<tr>
											<td colspan="5" class="table_ListSubLine1"></td>
										</tr>
<%
	ELSE
		DIM iCount, intMaxCount, intTotalCount, intListCount, intAvrCount

		IF NOT(RS.EOF) THEN
			AdRs_GetRows = RS.GetRows
			intListCount = UBOUND(AdRs_GetRows, 2)
			RS.MOVEFIRST
		END IF

		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			IF iCount = 1 THEN
				intMaxCount   = RS("intCount")
				intTotalCount = RS("totalCount")
				intAvrCount   = RS("totalCount") / intListCount
			ELSE
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td align="center" class="table_ListSubText1">
<%
	SELECT CASE RS("strConnDate")
	CASE "1" : RESPONSE.WRITE "<font color=#FF0000>일요일</font>"
	CASE "2" : RESPONSE.WRITE "월요일"
	CASE "3" : RESPONSE.WRITE "화요일"
	CASE "4" : RESPONSE.WRITE "수요일"
	CASE "5" : RESPONSE.WRITE "목요일"
	CASE "6" : RESPONSE.WRITE "금요일"
	CASE "7" : RESPONSE.WRITE "<font color=#0000FF>토요일</font>"
	END SELECT
%>
											</td>
											<td align="right" class="table_ListSubText1" style="padding-right:10;"><%=GetMoneyComma(RS("intCount"))%></td>
											<td align="right" class="table_ListSubText1" style="padding-right:10;"><%=ROUND(intAvrCount,2)%></td>
											<td align="right" class="table_ListSubText1" style="padding-right:10;"><%=FormatPercent(RS("intCount")/intTotalCount)%>&nbsp;<% IF intAvrCount < RS("intCount") THEN %><font color="#0000FF">↑</font><% ELSE %><font color="#FF0000">↓</font><% END IF %></td>
											<td align="left" class="table_ListSubText1" style="padding-left:10;"><img src="../images/grp1.gif" width="<%=GetCeil(REPLACE(FormatPercent(RS("intCount")/intTotalCount),"%",""))%>%" height="10"></td>
											</tr>
										<tr>
											<td colspan="5" class="table_ListSubLine1"></td>
										</tr>
<%
			END IF
		RS.MOVENEXT
		WEND
%>
										<tr>
											<td colspan="5" class="table_ListSubLine1" height="2"></td>
										</tr>
										<tr bgcolor="#FFFFFF" align="center">
											<td align="center" class="table_ListSubText1"><b>합계</b></td>
											<td align="right" class="table_ListSubText1" style="padding-right:10;"><b><%=GetMoneyComma(intTotalCount)%></b></td>
											<td align="right" class="table_ListSubText1" style="padding-right:10;"><b><%=ROUND(intAvrCount,2)%></b></td>
											<td align="right" class="table_ListSubText1" style="padding-right:10;"><b>100%</b></td>
											<td align="right" class="table_ListSubText1" style="padding-right:10;">&nbsp;</td>
											</tr>
										<tr>
											<td colspan="5" class="table_ListSubLine1"></td>
										</tr>
<%
	END IF
%>
										<tr>
											<td colspan="5" height="1"></td>
										</tr>
										<tr>
											<td colspan="5" class="table_ListSubBLine1"></td>
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
											<LI>검색 기간내에 접속 정보를 요일별로 구분지어 통계를 확인할 수 있습니다.</LI>
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

	function OnStatSearch(){
		document.theForm.action = "StatSiteWeek.asp";
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