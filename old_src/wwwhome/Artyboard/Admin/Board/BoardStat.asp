<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardList.asp"
%>
<!-- #include file = "../Head.asp" -->
<!-- #include file = "../Other/FunctionSchedule.asp" -->
<%
	DIM strBoardID, strBoardName, strStat, intYear, intMonth, intDay

	strBoardID = REQUEST.QueryString("strBoardID")
	strStat    = REQUEST.QueryString("strStat")
	intYear    = REQUEST.QueryString("intYear")
	intMonth   = REQUEST.QueryString("intMonth")
	intDay     = REQUEST.QueryString("intDay")

	IF strStat  = "" THEN strStat  = 1
	IF intYear  = "" THEN intYear  = YEAR(NOW)
	IF intMonth = "" THEN intMonth = MONTH(NOW)
	IF intDay   = "" THEN intDay   = DAY(NOW)

	IF LEN(intMonth) = 1 THEN intMonth = "0" & intMonth
	IF LEN(intDay)   = 1 THEN intDay   = "0" & intDay

	SET RS = DBCON.EXECUTE("SELECT [strName] FROM [MPLUS_BOARD_CONFIG_DEFAULT] WHERE [strBoardID] = '" & strBoardID & "' ")
	
	strBoardName = RS("strName")

	DIM strPrevDate, intPrevYear, strNextDate, intNextYear

	strPrevDate  = DATEADD("yyyy", -1, intYear & "-" & intMonth & "-" & intDay)
	intPrevYear  = YEAR(strPrevDate)

	strNextDate  = DATEADD("yyyy", 1, intYear & "-" & intMonth & "-" & intDay)
	intNextYear  = YEAR(strNextDate)

	DIM intTodayCount(7), intTodayTotalCount, intTodayGrpWidth, intTodayPercent

	SET RS = DBCON.EXECUTE("SELECT [intConnCount] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_STAT] WHERE [strBoardID] = '" & strBoardID & "' AND DATEPART(yy, [dateRegDate]) = '" & intYear & "' AND DATEPART(mm, [dateRegDate]) = '" & intMonth & "' AND DATEPART(dd, [dateRegDate]) = '" & intDay & "'), [intReadCount] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_READ_CHECK] WHERE [strBoardID] = '" & strBoardID & "' AND DATEPART(yy, [dateRegDate]) = '" & intYear & "' AND DATEPART(mm, [dateRegDate]) = '" & intMonth & "' AND DATEPART(dd, [dateRegDate]) = '" & intDay & "'), [intWriteCount] = (SELECT COUNT([intSeq]) FROM [MPLUS_BOARD] WHERE [strBoardID] = '" & strBoardID & "' AND [bitDelete] = '0' AND [intDepth] = '0' AND DATEPART(yy, [dateRegDate]) = '" & intYear & "' AND DATEPART(mm, [dateRegDate]) = '" & intMonth & "' AND DATEPART(dd, [dateRegDate]) = '" & intDay & "'), [intReplyCount] = (SELECT COUNT([intSeq]) FROM [MPLUS_BOARD] WHERE [strBoardID] = '" & strBoardID & "' AND [bitDelete] = '0' AND [intDepth] > '0' AND DATEPART(yy, [dateRegDate]) = '" & intYear & "' AND DATEPART(mm, [dateRegDate]) = '" & intMonth & "' AND DATEPART(dd, [dateRegDate]) = '" & intDay & "'), [intCmtCount] = (SELECT COUNT([intSeq]) FROM [MPLUS_BOARD_COMMENT] WHERE [strBoardID] = '" & strBoardID & "' AND [bitDelete] = '0' AND DATEPART(yy, [dateRegDate]) = '" & intYear & "' AND DATEPART(mm, [dateRegDate]) = '" & intMonth & "' AND DATEPART(dd, [dateRegDate]) = '" & intDay & "'), [intDownCount] = (SELECT COUNT([intSeq]) FROM [MPLUS_BOARD_DOWN_CHECK] WHERE [strBoardID] = '" & strBoardID & "' AND DATEPART(yy, [dateRegDate]) = '" & intYear & "' AND DATEPART(mm, [dateRegDate]) = '" & intMonth & "' AND DATEPART(dd, [dateRegDate]) = '" & intDay & "'), [intTotalConn] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_STAT] WHERE [strBoardID] = '" & strBoardID & "') ")

	intTodayCount(1) = RS(0)
	intTodayCount(2) = RS(1)
	intTodayCount(3) = RS(2)
	intTodayCount(4) = RS(3)
	intTodayCount(5) = RS(4)
	intTodayCount(6) = RS(5)
	intTodayCount(7) = RS(6)

	intTodayTotalCount = intTodayCount(1) + intTodayCount(2) + intTodayCount(3) + intTodayCount(4) + intTodayCount(5) + intTodayCount(6)

	DIM intMonthTotalCount, intMonthCount(12), intMonthGrpWidth, intMonthPercent

	SELECT CASE strStat
	CASE "1"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_ALL_STAT] '3', '" & strBoardID & "', '" & intYear & "-" & intMonth & "-" & intDay & "', '[MPLUS_BOARD_STAT]', '6' ")
	CASE "2"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_ALL_STAT] '3', '" & strBoardID & "', '" & intYear & "-" & intMonth & "-" & intDay & "', '[MPLUS_BOARD_READ_CHECK]', '2' ")
	CASE "3"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_ALL_STAT] '3', '" & strBoardID & "', '" & intYear & "-" & intMonth & "-" & intDay & "', '[MPLUS_BOARD]', '0' ")
	CASE "4"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_ALL_STAT] '3', '" & strBoardID & "', '" & intYear & "-" & intMonth & "-" & intDay & "', '[MPLUS_BOARD]', '5' ")
	CASE "5"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_ALL_STAT] '3', '" & strBoardID & "', '" & intYear & "-" & intMonth & "-" & intDay & "', '[MPLUS_BOARD_COMMENT]', '1' ")
	CASE "6"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_ALL_STAT] '3', '" & strBoardID & "', '" & intYear & "-" & intMonth & "-" & intDay & "', '[MPLUS_BOARD_DOWN_CHECK]', '4' ")
	END SELECT

	intMonthTotalCount = RS("stat_total")
	RS.MOVENEXT

	FOR I = 1 TO 12
		intMonthCount(I) = 0
	NEXT

	WHILE NOT(RS.EOF)
		intMonthCount(RS("stat_index")) = RS("stat_count")
	RS.MOVENEXT
	WEND

	DIM intDayTotalCount, intDayCount(31), intDayGrpWidth, intDayPercent

	SELECT CASE strStat
	CASE "1"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_ALL_STAT] '0', '" & strBoardID & "', '" & intYear & "-" & intMonth & "-" & intDay & "', '[MPLUS_BOARD_STAT]', '6' ")
	CASE "2"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_ALL_STAT] '0', '" & strBoardID & "', '" & intYear & "-" & intMonth & "-" & intDay & "', '[MPLUS_BOARD_READ_CHECK]', '2' ")
	CASE "3"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_ALL_STAT] '0', '" & strBoardID & "', '" & intYear & "-" & intMonth & "-" & intDay & "', '[MPLUS_BOARD]', '0' ")
	CASE "4"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_ALL_STAT] '0', '" & strBoardID & "', '" & intYear & "-" & intMonth & "-" & intDay & "', '[MPLUS_BOARD]', '5' ")
	CASE "5"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_ALL_STAT] '0', '" & strBoardID & "', '" & intYear & "-" & intMonth & "-" & intDay & "', '[MPLUS_BOARD_COMMENT]', '1' ")
	CASE "6"
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_ALL_STAT] '0', '" & strBoardID & "', '" & intYear & "-" & intMonth & "-" & intDay & "', '[MPLUS_BOARD_DOWN_CHECK]', '4' ")
	END SELECT

	intDayTotalCount = RS("stat_total")
	RS.MOVENEXT

	FOR I = 1 TO 31
		intDayCount(I) = 0
	NEXT

	WHILE NOT(RS.EOF)
		intDayCount(RS("stat_index")) = RS("stat_count")
	RS.MOVENEXT
	WEND
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="24">게시판 통계 - <b><%=strBoardName%></b></td>
				</tr>
				<tr>
					<td height="1" bgcolor="#DFDFDF"></td>
				</tr>
				<tr>
					<td height="24">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>전체방문 : <%=intTodayCount(7)%> 명 </td>
								<td align="right"><a href="BoardStat.asp?strBoardID=<%=strBoardID%>&intYear=<%=intYear%>&intMonth=<%=intMonth%>&intDay=<%=intDay%>&strStat=1"><% IF strStat = "1" THEN %><b><% END IF %>방문수<% IF strStat = "1" THEN %></b><% END IF %></a> | <a href="BoardStat.asp?strBoardID=<%=strBoardID%>&intYear=<%=intYear%>&intMonth=<%=intMonth%>&intDay=<%=intDay%>&strStat=2">
								  <% IF strStat = "2" THEN %><b><% END IF %>글읽기<% IF strStat = "2" THEN %></b><% END IF %></a> | <a href="BoardStat.asp?strBoardID=<%=strBoardID%>&intYear=<%=intYear%>&intMonth=<%=intMonth%>&intDay=<%=intDay%>&strStat=3">
								  <% IF strStat = "3" THEN %><b><% END IF %>글쓰기<% IF strStat = "3" THEN %></b><% END IF %></a> | <a href="BoardStat.asp?strBoardID=<%=strBoardID%>&intYear=<%=intYear%>&intMonth=<%=intMonth%>&intDay=<%=intDay%>&strStat=4">
								  <% IF strStat = "4" THEN %><b><% END IF %>답변글<% IF strStat = "4" THEN %></b><% END IF %></a> | <a href="BoardStat.asp?strBoardID=<%=strBoardID%>&intYear=<%=intYear%>&intMonth=<%=intMonth%>&intDay=<%=intDay%>&strStat=5">
								  <% IF strStat = "5" THEN %><b><% END IF %>댓글등록<% IF strStat = "5" THEN %></b><% END IF %></a> | <a href="BoardStat.asp?strBoardID=<%=strBoardID%>&intYear=<%=intYear%>&intMonth=<%=intMonth%>&intDay=<%=intDay%>&strStat=6">
								  <% IF strStat = "6" THEN %><b><% END IF %>다운회수<% IF strStat = "6" THEN %></b><% END IF %></a></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
				<tr>
					<td bgcolor="#FFFFFF" style="padding:10 10 10 10" width="250" valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="center" style="padding:5 5 5 5">
									<table width="220" border="0" cellpadding="1" cellspacing="1" bgcolor="#EFEFEF">
										<tr>
											<td height="24" bgcolor="#FFFFFF" style="font-size:11px">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td style="padding-left:10;"><b><%=intYear%>. <%=intMonth%>. <%=intDay%>.</b></td>
														<td align="right">
														<select name="intYear" id="intYear" onChange="OnCalDate('<%=strBoardID%>', '<%=strStat%>');">
<%
	FOR I = 2007 TO YEAR(NOW) + 1
		RESPONSE.WRITE "<option value='" & I & "'"
		IF INT(I) = INT(intYear) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "년</option>" & vbcrlf
	NEXT
%>
														</select>
														<select name="intMonth" id="intMonth" onChange="OnCalDate('<%=strBoardID%>', '<%=strStat%>');">
<%
	FOR I = 1 TO 12
		RESPONSE.WRITE "<option value='" & I & "'"
		IF INT(I) = INT(intMonth) THEN RESPONSE.WRITE " SELECTED"
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
								<td align="center">
									<table width="210" border="0" cellpadding="0" cellspacing="1" bgcolor="#F6F6F6">
										<tr>
											<td width="30" height="22" align="center" bgcolor="#EBD3C1" style="font-family:tahoma;font-size:8pt; color:#FF0000">Sun</td>
											<td width="30" height="22" align="center" bgcolor="#EBD3C1" style="font-family:tahoma;font-size:8pt; color:#000000">Mon</td>
											<td width="30" height="22" align="center" bgcolor="#EBD3C1" style="font-family:tahoma;font-size:8pt; color:#000000">Tue</td>
											<td width="30" height="22" align="center" bgcolor="#EBD3C1" style="font-family:tahoma;font-size:8pt; color:#000000">Wed</td>
											<td width="30" height="22" align="center" bgcolor="#EBD3C1" style="font-family:tahoma;font-size:8pt; color:#000000">Thu</td>
											<td width="30" height="22" align="center" bgcolor="#EBD3C1" style="font-family:tahoma;font-size:8pt; color:#000000">Fri</td>
											<td width="30" height="22" align="center" bgcolor="#EBD3C1" style="font-family:tahoma;font-size:8pt; color:#0000FF">Sat</td>
										</tr>
<%
	aCal = fn_CalMain(intYear,intMonth)
	DIM colorcode
	FOR I = 1 TO UBOUND(aCal, 1)
%>
										<tr>
<%
	FOR J = 1 TO UBOUND(aCal, 2)
		IF NOT ISNULL(aCal(i,j)) THEN
			IF fn_holiday(intYear,intMonth,aCal(i,j)) THEN		'// 공휴일
%>
											<td height="24" align="center" bgcolor="<% IF INT(YEAR(NOW)) = INT(intYear) AND INT(MONTH(NOW)) = INT(intMonth) AND INT(DAY(NOW)) = INT(aCal(i,j)) THEN %>#FFFFE0<% ELSE %>#FFFFFF<% END IF %>"><a href="BoardStat.asp?strBoardID=<%=strBoardID%>&intYear=<%=intYear%>&intMonth=<%=intMonth%>&intDay=<%=aCal(i,j)%>"><span style="font-size:11px; color:#FF0000;"><%=aCal(i,j)%></span></a></td>
<%
			ELSEIF fn_nowweek(intYear,intMonth,aCal(i,j))=1 THEN		'// 일요일
%>
											<td height="24" align="center" bgcolor="<% IF INT(YEAR(NOW)) = INT(intYear) AND INT(MONTH(NOW)) = INT(intMonth) AND INT(DAY(NOW)) = INT(aCal(i,j)) THEN %>#FFFFE0<% ELSE %>#FFFFFF<% END IF %>"><a href="BoardStat.asp?strBoardID=<%=strBoardID%>&intYear=<%=intYear%>&intMonth=<%=intMonth%>&intDay=<%=aCal(i,j)%>"><span style="font-size:11px; color:#FF0000;"><%=aCal(i,j)%></span></a></td>
<%
			ELSEIF fn_nowweek(intYear,intMonth,aCal(i,j)) = 7  THEN		'// 토요일
%>
											<td height="24" align="center" bgcolor="<% IF INT(YEAR(NOW)) = INT(intYear) AND INT(MONTH(NOW)) = INT(intMonth) AND INT(DAY(NOW)) = INT(aCal(i,j)) THEN %>#FFFFE0<% ELSE %>#FFFFFF<% END IF %>"><a href="BoardStat.asp?strBoardID=<%=strBoardID%>&intYear=<%=intYear%>&intMonth=<%=intMonth%>&intDay=<%=aCal(i,j)%>"><span style="font-size:11px; color:#0000FF;"><%=aCal(i,j)%></span></a></td>
<%
			ELSE		'// 평일
%>
											<td height="24" align="center" bgcolor="<% IF INT(YEAR(NOW)) = INT(intYear) AND INT(MONTH(NOW)) = INT(intMonth) AND INT(DAY(NOW)) = INT(aCal(i,j)) THEN %>#FFFFE0<% ELSE %>#FFFFFF<% END IF %>"><a href="BoardStat.asp?strBoardID=<%=strBoardID%>&intYear=<%=intYear%>&intMonth=<%=intMonth%>&intDay=<%=aCal(i,j)%>"><span style="font-size:11px; color:#000000;"><%=aCal(i,j)%></span></a></td>
<%
			END IF
		ELSE	'// 공백
%>
											<td height="24" align="center" bgcolor="#FFFFFF">&nbsp;</td>
<%
		END IF
		IF J = ubound(aCal,2) THEN
%>
										</tr>
<%
		END IF
	NEXT
NEXT
%>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td bgcolor="#FFFFFF" valign="top" style="padding:10 10 10 10;">
						<table cellspacing="0" cellpadding="1" border="0" background="../images/log_bg.gif">
							<tr height="8">
								<td bgcolor="f7f7f7"></td>
								<td></td>
							</tr>
<%
	FOR I = 1 TO 6
		IF intTodayTotalCount = 0 THEN
			intTodayGrpWidth = 2
			intTodayPercent  = 0
		ELSE
			IF intTodayCount(I) = 0 THEN
				intTodayGrpWidth = 2
				intTodayPercent  = 0
			ELSE
				intTodayGrpWidth = INT(280 * REPLACE(FORMATPERCENT(intTodayCount(I) / intTodayTotalCount), "%", "") / 100)
				intTodayPercent  = 0
			END IF
		END IF
%>
							<tr>
								<td align="right" bgcolor="#f7f7f7" width="72" height="28">
<%
	SELECT CASE I
	CASE "1" : RESPONSE.WRITE "방문수"
	CASE "2" : RESPONSE.WRITE "글읽기"
	CASE "3" : RESPONSE.WRITE "글쓰기"
	CASE "4" : RESPONSE.WRITE "답변글"
	CASE "5" : RESPONSE.WRITE "댓글등록"
	CASE "6" : RESPONSE.WRITE "다운회수"
	END SELECT
%>
								&nbsp;</td>
								<td width="299" style="color:gray; font-size:11px; font-family:돋움,Tahoma;"><img height="10" src="../images/b_grp1.gif" width="1" iwidth="<%=intTodayGrpWidth%>" alt="&nbsp;<%=intTodayPercent%>%&nbsp;" id="day_grp_<%=I-1%>"> <span id="day_num_<%=I-1%>" style="display:none;"><%=intTodayCount(I)%></span></td>
							</tr>
<%
	NEXT
%>
							<tr height="9">
								<td bgcolor="f7f7f7"></td>
								<td></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top" bgcolor="#FFFFFF" style="padding:10 10 10 10;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table cellspacing="2" cellpadding="1" width="100%" border="0">
										<tr>
											<td width="3"></td>
											<td align="left">
											<a href="BoardStat.asp?strBoardID=<%=strBoardID%>&intYear=<%=intPrevYear%>&intMonth=<%=intMonth%>&intDay=1&strStat=<%=strStat%>"><font color="gray">◁</font></a>
											<font color=#2c2c2c size=2><b><%=intYear%>년</b></font>
											<a href="BoardStat.asp?strBoardID=<%=strBoardID%>&intYear=<%=intNextYear%>&intMonth=<%=intMonth%>&intDay=1&strStat=<%=strStat%>"><font color=gray>▷</font></a>&nbsp;&nbsp;&nbsp;
<%
	SELECT CASE strStat
	CASE "1" : RESPONSE.wRITE "방문자 통계"
	CASE "2" : RESPONSE.WRITE "글읽기 통계"
	CASE "3" : RESPONSE.WRITE "글쓰기 통계"
	CASE "4" : RESPONSE.WRITE "답변글 통계"
	CASE "5" : RESPONSE.WRITE "댓글등록 통계"
	CASE "6" : RESPONSE.WRITE "다운회수 통계"
	END SELECT
%>
											</td>
											<td align=right><font color=#2c2c2c size=2>합계:<%=intMonthTotalCount%></font></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table cellspacing="0" cellpadding="2" width="100%" border="0" background="../images/log_bg.gif">
										<tr height="3">
											<td bgcolor="#f7f7f7" width="40"></td>
											<td></td>
										</tr>
<%
	FOR I = 1 TO 12

	IF intMonthTotalCount = 0 THEN
		intMonthGrpWidth = 2
		intMonthPercent  = 0
	ELSE
		IF intMonthCount(I) = 0 THEN
			intMonthGrpWidth = 2
			intMonthPercent  = 0
		ELSE
			intMonthGrpWidth = INT(150 * REPLACE(FORMATPERCENT(intMonthCount(I) / intMonthTotalCount), "%", "") / 100)
			intMonthPercent  = 0
		END IF
	END IF
%>
										<tr height="16">
											<td align="center" bgcolor="#f7f7f7"><a href="BoardStat.asp?strBoardID=<%=strBoardID%>&intYear=<%=intYear%>&intMonth=<%=intMonth%>&intDay=1&strStat=<%=strStat%>"><u><% IF LEN(I) = 1 THEN %>0<% END IF %><%=I%>월</u></a></td>
											<td style="color:gray; font-size:11px; font-family:돋움,Tahoma;"><img width="1" iwidth="<%=intMonthGrpWidth%>" height="10" src="../images/b_grp2.gif" alt="&nbsp;<%=intMonthPercent%>%&nbsp;" id="mon_grp_<%=I%>"> <span id="mon_num_<%=I%>" style="display:none;"><%=intMonthCount(I)%></span></td>
										</tr>
										<tr height="2">
											<td bgcolor="#f7f7f7"></td>
											<td></td>
										</tr>
<%
	NEXT
%>
										<tr height="18" bgcolor="#f7f7f7">
											<td colspan="2"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF" style="padding:10 10 10 10">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table cellspacing="2" cellpadding="1" width="100%" border="0">
										<tr>
											<td width="1"></td>
											<td align="left"><font color="#2c2c2c" size="2">monthly : <b>
<%
	SELECT CASE strStat
	CASE "1" : RESPONSE.WRITE "방문수"
	CASE "2" : RESPONSE.WRITE "글읽기"
	CASE "3" : RESPONSE.WRITE "글쓰기"
	CASE "4" : RESPONSE.WRITE "답변글"
	CASE "5" : RESPONSE.WRITE "댓글등록"
	CASE "6" : RESPONSE.WRITE "다운회수"
	END SELECT
%>
											</b> &nbsp; <%=intYear%>년 <%=intMonth%>월</font></td>
											<td align="right"><font color="#2c2c2c" size="2">합계:<%=intDayTotalCount%></font>&nbsp;&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
<table cellspacing="0" cellpadding="0" border="0" background="../images/log_bg.gif">
	<tr valign="bottom" align="middle" height="265">
<%
	FOR I = 1 TO 31

	IF intDayTotalCount = 0 THEN
		intDayGrpWidth = 2
		intDayPercent  = 0
	ELSE
		IF intDayCount(I) = 0 THEN
			intDayGrpWidth = 2
			intDayPercent  = 0
		ELSE
			intDayGrpWidth = INT(240 * REPLACE(FORMATPERCENT(intDayCount(I) / intDayTotalCount), "%", "") / 100)
			intDayPercent  = 0
		END IF
	END IF
%>
		<td style="color:gray; font-size:11px; font-family:돋움,Tahoma;" align="center"><img width="9" height="1" iheight="<%=intDayGrpWidth%>" src="../images/b_grp3.gif" alt="&nbsp;<<%=intMonth%>월<%=I%>일> <%=intDayCount(I)%>건 (<%=intDayPercent%>%)&nbsp;" id='day_grp1_<%=I%>'></td>
<%
	NEXT
%>
		<td></td>
	</tr>
	<tr align="middle" height="14" bgcolor="#f7f7f7">
<%
	FOR I = 1 TO 31
%>
		<td valign=bottom width='20' onMouseOver="this.style.background='gold'" onMouseOut="this.style.background='f7f7f7'" style='color:#666666; font-size:11px; font-family:돋움,Tahoma;cursor:pointer;' title="<<%=intMonth%>월<%=I%>일>"><%=I%></td>
<%
	NEXT
%>
		<td width="3"></td>
	</tr>
	<tr height="6" bgcolor="#f7f7f7"><td colspan="32"></td></tr>
</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</form>
</table>
<script language="javascript">

	function OnCalDate(str1, str2){

		document.theForm.action = "BoardStat.asp?strBoardID=" + str1 + "&intYear=" + document.all['intYear'].value + "&intMonth=" + document.all['intMonth'].value + "&intDay=1&strStat=" + str2;
		document.theForm.submit();

	}

	function day_grp_draw(n){
		var i;
		var grp;
		n++;
		for (i = 0; i < 6; i++)
		{
			grp = document.getElementById('day_grp_' + i);
			if (grp.width+n < grp.iwidth) grp.width = grp.width + n;
			else {
				document.getElementById('day_num_' + i).style.display = 'inline';
			}
		}
	
		for (i = 1; i < 13; i++)
		{
			grp = document.getElementById('mon_grp_' + i);
			if (grp.width+n < grp.iwidth) grp.width = grp.width + n;
			else {
				document.getElementById('mon_num_' + i).style.display = 'inline';
			}
		}
	
		for (i = 1; i < 31; i++)
		{
			grp = document.getElementById('day_grp1_' + i);
			if (grp.height+n < grp.iheight) grp.height = grp.height + n;
		}
	
		if(n < 300) setTimeout("day_grp_draw("+n+")",1);
	}

	window.onLoad = day_grp_draw(10);
</script>
<!-- #include file = "../Foot.asp" -->