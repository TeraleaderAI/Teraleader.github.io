<%
	DIM intTopMenu, intLeftMenu, isAdminMenu
	intTopMenu  = 6
	intLeftMenu = 6
	isAdminMenu = 2
%>
<!-- #include file = "Head.asp" -->
<%
	DIM Query, I

	DIM strSearchType
	strSearchType = REQUEST.FORM("strSearchType")
	IF strSearchType = "" THEN strSearchType = "1"

	DIM sDateYear, sDateMonth

	sDateYear  = REQUEST.FORM("sDateYear")
	sDateMonth = REQUEST.FORM("sDateMonth")

	IF sDateYear  = "" THEN sDateYear = YEAR(NOW)
	IF sDateMonth = "" THEN sDateMonth = MONTH(NOW)
	IF LEN(sDateMonth) = 1 THEN sDateMonth = "0" & sDateMonth

	DIM strNowDate
	strNowDate = sDateYear & "-" & sDateMonth & "-01"
%>
						<script language="javascript" src="../../Js/Calendar.js"></script>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title32.gif" width="140" height="19"></td>
                      <td align="right">관리자 홈 &gt; 통계자료 &gt; <b>월/일자별 접속통계</b></td>
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
														<td nowrap class="table_SelecttdLeft1">
														<input type="radio" name="strSearchType" id="strSearchType1" value="1" class="no_Line"<% IF strSearchType = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="strSearchType1" style="cursor:hand">월별 접속통계</LABEL></td>
														<td>
														<select name="sDateYear" id="sDateYear" style="width:80">
<%
	FOR I = YEAR(NOW) - 2 TO YEAR(NOW)
		RESPONSE.WRITE "<option value='" & I & "'"
		IF INT(sDateYear) = INT(I) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & " 년</option>" & vbcrlf
	NEXT
%>
														</select>
														</td>
													</tr>
													<tr>
														<td nowrap class="table_SelecttdLeft1">
														<input type="radio" name="strSearchType" id="strSearchType2" value="2" class="no_Line"<% IF strSearchType = "2" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="strSearchType2" style="cursor:hand">일자별 접속통계</LABEL></td>
														<td>
														<select name="sDateMonth" id="sDateMonth" style="width:80">
<%
	FOR I = 1 TO 12
		RESPONSE.WRITE "<option value='" & I & "'"
		IF INT(sDateMonth) = INT(I) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & " 월</option>" & vbcrlf
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
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_STAT] '" & strSearchType & "', '" & strNowDate & "' ")

	IF RS.EOF THEN
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
				IF RS("totalCount") = 0 THEN intAvrCount = 0 ELSE intAvrCount = RS("totalCount") / intListCount
			ELSE
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td align="center" class="table_ListSubText1"><% IF strSearchType = "1" THEN %><%=sDateYear%>년 <%=RS("strConnDate")%>월<% ELSE %><%=sDateYear%>년 <%=sDateMonth%>월 <%=RS("strConnDate")%>일
											  <% END IF %></td>
											<td align="right" class="table_ListSubText1" style="padding-right:10;"><%=GetMoneyComma(RS("intCount"))%></td>
											<td align="right" class="table_ListSubText1" style="padding-right:10;"><%=ROUND(intAvrCount,2)%></td>
											<td align="right" class="table_ListSubText1" style="padding-right:10;"><%=FormatPercent(RS("intCount")/intTotalCount)%>&nbsp;<% IF intAvrCount < RS("intCount") THEN %><font color="#0000FF">↑</font>
											  <% ELSE %><font color="#FF0000">↓</font><% END IF %></td>
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
											<LI>월별 또는 일자별로 접속한 통계를 확인할 수 있으며, 해당연도 및 월별로 검색이 가능합니다.</LI>
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
		document.theForm.action = "StatSiteMonth.asp";
		document.theForm.submit();
	}

</script>
<!-- #include file = "Foot.asp" -->