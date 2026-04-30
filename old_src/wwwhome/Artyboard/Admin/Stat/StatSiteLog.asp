<%
	DIM intTopMenu, intLeftMenu, isAdminMenu
	intTopMenu  = 6
	intLeftMenu = 10
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
                      <td height="35"><img src="../images/main_title36.gif" width="121" height="19"></td>
                      <td align="right">관리자 홈 &gt; 통계자료 &gt; <b>접속로그 데이타</b></td>
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
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount, Query, I, strOrder
	intPage     = REQUEST.QueryString("intPage") : IF intPage     = "" THEN intPage     = 1
	intPageSize = REQUEST.FORM("intPageSize")    : IF intPageSize = "" THEN intPageSize = 20
	strOrder    = REQUEST.FORM("strOrder")       : IF strOrder    = "" THEN strOrder    = "[strConnDate] DESC"

	SET RS = DBCON.EXECUTE("SELECT COUNT([intNum]) AS [RecCount] FROM [MPLUS_STAT] WHERE [strConnDate] BETWEEN '" & sDateS & "' AND DATEADD(d, 1, '" & sDateE & "')")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [strConnIP], [strAgent], [strReferer], [strBrowser], [strOs], [strConnDate] FROM [MPLUS_STAT] WHERE [strConnDate] BETWEEN '" & sDateS & "' AND DATEADD(d, 1, '" & sDateE & "') AND [intNum] NOT IN (SELECT TOP " & (intPage - 1) * intPageSize & " [intNum] FROM [MPLUS_STAT] WHERE [strConnDate] BETWEEN '" & sDateS & "' AND DATEADD(d, 1, '" & sDateE & "') ORDER BY [strConnDate] DESC) ORDER BY [strConnDate] DESC ")
%>
							<tr>
								<td height="40" align="center"><a href="javascript:;" onclick="OnStatSearch();return false;"><img src="../images/btn_search_m.gif" width="69" height="25" border="0" /></a></td>
							</tr>
							<tr>
								<td height="30">전체 : <font color="#C6325B"><b><%=GetMoneyComma(intTotalCount)%></b></font>&nbsp;&nbsp;<%=intPage%>/<%=intPageCount%> 페이지 </td>
							</tr>
							<tr>
								<td>
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
						<tr align="center" bgcolor="EB766F">
						  <td colspan="4" class="table_Round1"></td>
					  </tr>
						<tr align="center" bgcolor="EB766F">
						  <td width="60" class="table_Txt1">번호</td>
						  <td width="120" class="table_Txt1">접속일시</td>
						  <td width="100" height="30" nowrap class="table_Txt1">IP</td>
							<td nowrap class="table_Txt1">접속경로</td>
							</tr>
						<tr align="center" bgcolor="EB766F">
						  <td colspan="4" class="table_Round1"></td>
					  </tr>
<% IF RS.EOF THEN %>
						<tr bgcolor="#FFFFFF" align="center">
						  <td colspan="4" class="table_ListSubText1">등록된 접속로그가 없습니다.</td>
						</tr>
						<tr>
							<td colspan="4" class="table_ListSubLine1"></td>
						</tr>
<%
	ELSE
		DIM iCount, intNumber
		iCount = 0
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
						<tr bgcolor="#FFFFFF" align="center">
						  <td class="table_ListSubText1"><%=intNumber%></td>
						  <td class="table_ListSubText1"><%=FORMATDATETIME(RS("strConnDate"),2)%>&nbsp;<%=FORMATDATETIME(RS("strConnDate"),4)%></td>
						  <td class="table_ListSubText1"><%=RS("strConnIP")%></td>
							<td align="left" class="table_ListSubText1" style="word-break:break-all;"><a href="<%=RS("strReferer")%>" target="_blank"><%=RS("strReferer")%></a></td>
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
<%
	END IF
%>
						<tr>
							<td colspan="4" height="1"></td>
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
											<LI>사이트에 접속한 세부 정보를 확인하실 수 있으며, 접속경로를 통해 어떤 경로로 접속을 했는지 확인이 가능합니다.</LI>
											<LI>접속경로가 없는 경우에는 인터넷 주소창의 도메인을 직접입력해서 접속한 경우 입니다.</LI>
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

	function OnPageMove(str){
		document.theForm.action = "StatSiteLog.asp?intPage=" + str;
		document.theForm.submit();
	}

	function OnStatSearch(){
		document.theForm.action = "StatSiteLog.asp";
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