<%
	DIM intTopMenu, intLeftMenu, isAdminMenu
	intTopMenu  = 6
	intLeftMenu = 11
	isAdminMenu = 2
%>
<!-- #include file = "Head.asp" -->
<%
	DIM Action, sType, SELECTED, I, intYear, intMonth, intDay, prevYear, prevMonth, nextYear, nextMonth

	Action   = REQUEST.FORM("Action")
	sType    = REQUEST.FORM("sType")
	intYear  = REQUEST.FORM("intYear")
	intMonth = REQUEST.FORM("intMonth")
	intDay   = REQUEST.FORM("intDay")

	IF Action   = "" THEN Action     = "0"
	IF sType    = "" THEN sType    = "0"

	IF intYear  = "" THEN intYear  = YEAR(NOW)
	IF intMonth = "" THEN intMonth = MONTH(NOW)
	IF intDay   = "" THEN intDay   = DAY(NOW)

	IF LEN(intMonth) = 1 THEN intMonth = "0" & intMonth
	IF LEN(intDay)   = 1 THEN intDay   = "0" & intDay

	prevYear  =  YEAR(DATEADD("y", -1, intYear & "-" & intMonth & "-01"))
	prevMonth = MONTH(DATEADD("m", -1, intYear & "-" & intMonth & "-01")) : IF LEN(prevMonth) = 1 THEN prevMonth = "0" & prevMonth
	nextYear  =  YEAR(DATEADD("m",  1, intYear & "-" & intMonth & "-01"))
	nextMonth = MONTH(DATEADD("m",  1, intYear & "-" & intMonth & "-01")) : IF LEN(nextMonth) = 1 THEN nextMonth = "0" & nextMonth
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title37.gif" width="138" height="19"></td>
                      <td align="right">관리자 홈 &gt; 통계자료 &gt; <b>게시판 데이타 분석</b></td>
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
														<select name="Action" id="Action">
														<option value="3"<% IF Action = "3" THEN %> SELECTED<% END IF %>>월별 통계</option>
														<option value="0"<% IF Action = "0" THEN %> SELECTED<% END IF %>>일자별 통계</option>
														<option value="1"<% IF Action = "1" THEN %> SELECTED<% END IF %>>요일별 통계</option>
														<option value="2"<% IF Action = "2" THEN %> SELECTED<% END IF %>>시간대별 통계</option>
														</select>
														<select name="sType" id="sType">
														<option value="6"<% IF sType = "6" THEN %> SELECTED<% END IF %>>게시판 방문수</option>
														<option value="0"<% IF sType = "0" THEN %> SELECTED<% END IF %>>게시글 등록수</option>
														<option value="5"<% IF sType = "5" THEN %> SELECTED<% END IF %>>답변글 등록수</option>
														<option value="1"<% IF sType = "1" THEN %> SELECTED<% END IF %>>댓글 등록수</option>
														<option value="2"<% IF sType = "2" THEN %> SELECTED<% END IF %>>조회수</option>
														<option value="3"<% IF sType = "3" THEN %> SELECTED<% END IF %>>추천수</option>
														<option value="4"<% IF sType = "4" THEN %> SELECTED<% END IF %>>다운수</option>
														</select>
														</td>
													</tr>
													<tr>
													  <td class="table_SelecttdLeft1">&nbsp;</td>
													  <td>
														<select name="intYear" id="intYear">
<%
	FOR I = 2000 TO YEAR(NOW)
		RESPONSE.WRITE "<option value='" & I & "'"
		IF INT(I) = INT(intYear) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "년</option>" & vbcrlf
	NEXT
%>
														</select>
														<select name="intMonth" id="intMonth">
<%
	FOR I = 1 TO 12
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0"
		RESPONSE.WRITE I & "'"
		IF INT(I) = INT(intMonth) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "월</option>" & vbcrlf
	NEXT
%>
														</select>
														<select name="intDay" id="intDay">
<%
	FOR I = 1 TO 31
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0"
		RESPONSE.WRITE I & "'"
		IF INT(I) = INT(intDay) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "일</option>" & vbcrlf
	NEXT
%>
														</select>
														<a href="javascript:;" onClick="OnSearchDate('<%=prevYear%>','<%=prevMonth%>');return false;"><img src="../images/btn_prev_month_w.gif" width="58" height="19" align="absmiddle" border="0"></a>
														<a href="javascript:;" onClick="OnSearchDate('<%=nextYear%>','<%=nextMonth%>');return false;"><img src="../images/btn_next_month_w.gif" width="58" height="19" align="absmiddle" border="0"></a>
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
											<td width="100" height="30" nowrap class="table_Txt1">
<%
	SELECT CASE Action
	CASE "0" : RESPONSE.WRITE "일자"
	CASE "1" : RESPONSE.WRITE "요일"
	CASE "2" : RESPONSE.WRITE "시간"
	END SELECT
%></td>
											<td width="100" height="30" nowrap class="table_Txt1">수치</td>
											<td width="100" nowrap class="table_Txt1">비율</td>
											<td nowrap class="table_Txt1">그래프</td>
										</tr>
										<tr bgcolor="EB766F">
											<td colspan="4" class="table_Round1"></td>
										</tr>
<%
	DIM totalMonth, MaxCount, perc, grpWidth, MaxPerc, strStatIndex, strTable

	SELECT CASE sType
	CASE "0", "5" : strTable = "[MPLUS_BOARD]"
	CASE "1" : strTable = "[MPLUS_BOARD_COMMENT]"
	CASE "2" : strTable = "[MPLUS_BOARD_READ_CHECK]"
	CASE "3" : strTable = "[MPLUS_BOARD_VOTE]"
	CASE "4" : strTable = "[MPLUS_BOARD_DOWN_CHECK]"
	CASE "6" : strTable = "[MPLUS_BOARD_STAT]"
	END SELECT

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_ALL_STAT] '" & Action & "', '" & strBoardID & "', '" & intYear & "-" & intMonth & "-01', '" & strTable & "', '" & sType & "' ")

	IF NOT(RS.EOF) THEN totalMonth = RS("stat_total")   : MaxCount = RS("stat_count")   : RS.MOVENEXT

	IF RS.EOF THEN
%>
										<tr align="center" bgcolor="#FFFFFF">
											<td colspan="4" class="table_ListSubText1">등록된 정보가 없습니다.</td>
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
			CASE 3 : strStatIndex = RS("stat_index") & " 월"
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
											<LI>각 항목별 일자별, 요일별, 시간대별로 진행된 통계를 확인하실 수 있습니다.</LI>
											<LI>게시글 조회수 통계는 게시판의 조회수 증가를 한번만 증가함으로 설정을 하셔야 통계값이 저장됩니다.</LI>
											<LI>추천기능을 사용하지 않는 경우 추천에 대한 통계값은 저장되지 않습니다.</LI>
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

	function OnSearchDate(str1, str2){
		document.theForm.intYear.value = str1;
		document.theForm.intMonth.value = str2;
		document.theForm.action = "StatBoard.asp";
		document.theForm.submit();
	}

	function OnStatSearch(){
		document.theForm.action = "StatBoard.asp";
		document.theForm.submit();
	}

</script>
<!-- #include file = "Foot.asp" -->