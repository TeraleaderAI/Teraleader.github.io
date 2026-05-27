<%
	DIM intTopMenu, intLeftMenu, isAdminMenu
	intTopMenu  = 6
	intLeftMenu = 1
	isAdminMenu = 2
%>
<!-- #include file = "Head.asp" -->
<%
	DIM Action, nowYear, nowMonth, prevYear, prevMonth, nextYear, nextMonth, iCount
	Action     = REQUEST.FORM("Action")
	nowYear    = REQUEST.FORM("sYear")
	nowMonth   = REQUEST.FORM("sMonth")

	IF Action   = "" THEN Action     = "0"
	IF nowYear  = "" THEN nowYear  = YEAR(NOW)
	IF nowMonth = "" THEN nowMonth = MONTH(NOW)
	IF LEN(nowMonth) = 1 THEN nowMonth = "0" & nowMonth

	prevYear  =  YEAR(DATEADD("y", -1, nowYear & "-" & nowMonth & "-01"))
	prevMonth = MONTH(DATEADD("m", -1, nowYear & "-" & nowMonth & "-01")) : IF LEN(prevMonth) = 1 THEN prevMonth = "0" & prevMonth
	nextYear  =  YEAR(DATEADD("m",  1, nowYear & "-" & nowMonth & "-01"))
	nextMonth = MONTH(DATEADD("m",  1, nowYear & "-" & nowMonth & "-01")) : IF LEN(nextMonth) = 1 THEN nextMonth = "0" & nextMonth

	DIM I, SELECTED, iDate

	DIM TotalMembers, MonthTotalMembers
	SET RS = DBCON.EXECUTE("SELECT [TotalMembers] = (SELECT COUNT([intNum]) FROM [MPLUS_MEMBER_LIST] WHERE [strAdmin] != '2'), [MonthTotalMembers] = (SELECT COUNT([intNum]) FROM [MPLUS_MEMBER_LIST] WHERE [strAdmin] != '2' AND DATEDIFF(m, '" & nowYear & "-" & nowMonth & "-01', [dateRegDate]) = 0) ")
	TotalMembers      = RS("TotalMembers")
	MonthTotalMembers = RS("MonthTotalMembers")
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title27.gif" width="152" height="19"></td>
                      <td align="right">관리자 홈 &gt; 통계자료 &gt; <b>기간별 회원가입 통계</b></td>
                    </tr>
                  </table>                </td>
              </tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="10" cellspacing="0" class="table_Select1">
										<tr>
											<td class="table_SelecttdIn1"><table width="100%" border="0" cellpadding="2" cellspacing="0">
                        <tr>
                          <td nowrap class="table_SelecttdLeft1">기간선택</td>
                          <td>
													<select name="sYear" id="sYear">
													<%
														FOR I = YEAR(NOW) - 2 TO YEAR(NOW) + 2
															IF INT(nowYear) = INT(I) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
															RESPONSE.WRITE "<option value='" & I & "'" & SELECTED & ">" & I & "년</option>" & vbcrlf
														NEXT
													%>
													</select>
													<select name="sMonth" id="sMonth">
													<%
														FOR I = 1 TO 12
															IF INT(nowMonth) = INT(I) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
															IF LEN(I) = 1 THEN iDate = "0" & I ELSE iDate = I
															RESPONSE.WRITE "<option value='" & iDate & "'" & SELECTED & ">" & iDate & "월</option>" & vbcrlf
														NEXT
													%>
													</select>
													<select name="Action" id="Action">
													<option value="0"<% IF Action = "0" THEN %> SELECTED<% END IF %>>일자별 가입통계</option>
													<option value="1"<% IF Action = "1" THEN %> SELECTED<% END IF %>>요일별 가입통계</option>
													<option value="2"<% IF Action = "2" THEN %> SELECTED<% END IF %>>시간대별 가입통계</option>
                          </select>
													<a href="javascript:;" onClick="OnSearchDate('<%=prevYear%>','<%=prevMonth%>');return false;"><img src="../images/btn_prev_month_w.gif" width="58" height="19" align="absmiddle" border="0"></a>
													<a href="javascript:;" onClick="OnSearchDate('<%=nextYear%>','<%=nextMonth%>');return false;"><img src="../images/btn_next_month_w.gif" width="58" height="19" align="absmiddle" border="0"></a>													</td>
                        </tr>
                      </table></td>
										</tr>
									</table>								</td>
							</tr>
							<tr>
								<td height="40" align="center"><a href="javascript:;" onclick="OnStatSearch();return false;"><img src="../images/btn_search_m.gif" width="69" height="25" border="0" /></a></td>
							</tr>
              <tr>
                <td style="padding-top:5; padding-bottom:5;">전체 : <font color="#C6325B"><b><%=TotalMembers%></b></font>&nbsp;&nbsp;<%=nowYear%>년 <%=nowMonth%>월 가입 : <%=MonthTotalMembers%> 명</td>
              </tr>
							<tr>
								<td>
									<table width="100%"  border="0" cellpadding="0" cellspacing="0">
										<tr align="center" bgcolor="EB766F">
											<td colspan="4" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td width="100" height="30" nowrap class="table_Txt1">
<%
	SELECT CASE Action
	CASE "0" : RESPONSE.WRITE "일자"
	CASE "1" : RESPONSE.WRITE "요일"
	CASE "2" : RESPONSE.WRITE "시간"
	END SELECT
%></td>
											<td width="100" height="30" nowrap class="table_Txt1">가입수</td>
											<td width="100" nowrap class="table_Txt1">비율</td>
											<td nowrap class="table_Txt1">그래프</td>
										</tr>
										<tr bgcolor="EB766F">
											<td colspan="4" class="table_Round1"></td>
										</tr>
<%
	DIM totalMonth, MaxCount, perc, grpWidth, MaxPerc, strStatIndex

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_STAT] '" & Action & "', '" & nowYear & "-" & nowMonth & "-01' ")
	IF NOT(RS.EOF) THEN totalMonth = RS("stat_total")   : MaxCount = RS("stat_count")   : RS.MOVENEXT

	IF RS.EOF THEN
%>
										<tr align="center" bgcolor="#FFFFFF">
											<td colspan="4" class="table_ListSubText1">등록된 회원정보가 없습니다.</td>
										</tr>
										<tr>
											<td colspan="4" class="table_ListSubLine1"></td>
										</tr>
<%
	ELSE
		WHILE NOT(RS.EOF)
			perc = INT(RS("stat_count") / totalMonth *100)
			grpWidth = RS("stat_count") / MaxCount * 60
			IF INT(RS("stat_count") / MaxCount *100) = 100 THEN MaxPerc = "max!" ELSE MaxPerc = ""
	
			SELECT CASE Action
			CASE 0 : strStatIndex = RS("stat_index") & " 일"
			CASE 1
				SELECT CASE RS("stat_index")
					CASE "1" : strStatIndex = "일요일"
					CASE "2" : strStatIndex = "월요일"
					CASE "3" : strStatIndex = "화요일"
					CASE "4" : strStatIndex = "수요일"
					CASE "5" : strStatIndex = "목요일"
					CASE "6" : strStatIndex = "금요일"
					CASE "7" : strStatIndex = "토요일"
				END SELECT
			CASE 2 : strStatIndex = RS("stat_index") & " 시"
			END SELECT
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td align="center" class="table_ListSubText1"><%=strStatIndex%></td>
											<td align="center" class="table_ListSubText1"><%=RS("stat_count")%></td>
											<td class="table_ListSubText1"><%=perc%>%</td>
											<td align="left" class="table_ListSubText1"><img src="../Images/grp1.gif" width="<%=perc%>%" height="10"></td>
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
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>기간별로 가입된 회원의 통계를 확인하실 수 있습니다.</LI>
											<LI>일자별, 요일별, 시간대별로 구분지어 가입현황을 확인하실 수 있습니다.</LI></td>
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

	function OnSearchDate(str1, str2){
		document.theForm.sYear.value = str1;
		document.theForm.sMonth.value = str2;
		document.theForm.action = "StatMemberJoin.asp";
		document.theForm.submit();
	}

	function OnStatSearch(){
		document.theForm.action = "StatMemberJoin.asp";
		document.theForm.submit();
	}

</script>
<!-- #include file = "Foot.asp" -->