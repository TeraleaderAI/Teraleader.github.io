<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu  = 2
	isAdminPopup = True
%>
<!-- #include file = "../Head.asp" -->
<!-- #include file = "FunctionSchedule.asp" -->
<style type="text/css">
	BODY {margin-left:0px; margin-top:0px; margin-right: 0px; margin-bottom:0px;}
</style>
<%
	DIM strScYear, strScMonth, strScDay, iNowDate, iNowYear, iNowMonth, iNowDay

	strScYear  = REQUEST.QueryString("strScYear")
	strScMonth = REQUEST.QueryString("strScMonth")
	strScDay   = REQUEST.QueryString("strScDay")

	IF strScYear  = "" THEN strScYear  = YEAR(NOW)
	IF strScMonth = "" THEN strScMonth = MONTH(NOW) : IF LEN(strScMonth) = 1 THEN strScMonth = "0" & strScMonth
	IF strScDay   = "" THEN strScDay   = DAY(NOW)   : IF LEN(strScDay)   = 1 THEN strScDay   = "0" & strScDay
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding:5 5 5 5">
			<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#EFEFEF">
				<tr>
					<td height="24" bgcolor="#FFFFFF" style="font-size:11px">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><b><%=strScYear%>. <%=strScMonth%>.</b></td>
								<td>
								<select name="intYear" id="intYear" onChange="OnDateChange();">
<%
	FOR I = 2005 TO YEAR(NOW) + 2
		RESPONSE.WRITE "<option value='" & I & "'"
		IF INT(strScYear) = INT(I) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "년</option>" & vbcrlf
	NEXT
%>
								</select>
								<select name="intMonth" id="intMonth" onChange="OnDateChange();">
<%
	FOR I = 1 TO 12
		RESPONSE.WRITE "<option value='" & I & "'"
		IF INT(strScMonth) = INT(I) THEN RESPONSE.WRITE " SELECTED"
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
			<table width="196" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="28" height="22" align="center" bgcolor="#EBD3C1" style="font-size:10px; color:#FF0000">Sun</td>
					<td width="28" height="22" align="center" bgcolor="#EBD3C1" style="font-size:10px; color:#000000">Mon</td>
					<td width="28" height="22" align="center" bgcolor="#EBD3C1" style="font-size:10px; color:#000000">Tue</td>
					<td width="28" height="22" align="center" bgcolor="#EBD3C1" style="font-size:10px; color:#000000">Wed</td>
					<td width="28" height="22" align="center" bgcolor="#EBD3C1" style="font-size:10px; color:#000000">Thu</td>
					<td width="28" height="22" align="center" bgcolor="#EBD3C1" style="font-size:10px; color:#000000">Fri</td>
					<td width="28" height="22" align="center" bgcolor="#EBD3C1" style="font-size:10px; color:#0000FF">Sat</td>
				</tr>
<%
	iNowDate = strScYear & "-" & strScMonth & "-" & strScDay
	iNowYear  = strScYear
	iNowMonth = strScMonth
	iNowDay   = strScDay

	DIM strCalendarIntSeq(42), Temp, TempStrSubject, TempStrIntSeq

	FOR I = 0 TO 42
		strCalendarIntSeq(I)  = ""
	NEXT

	SET RS = DBCON.EXECUTE("SELECT [intSeq], [intDay] FROM [MPLUS_SCHEDULE] WHERE [intYear] = '" & iNowYear & "' AND [intMonth] = '" & iNowMonth & "' ")

	WHILE NOT(RS.EOF)
		strCalendarIntSeq(RS("intDay")) = strCalendarIntSeq(RS("intDay"))  & RS("intSeq") & ","
	RS.MOVENEXT
	WEND

	aCal = fn_CalMain(iNowYear,iNowMonth)
	DIM colorcode
	FOR I = 1 TO UBOUND(aCal, 1)
%>
				<tr>
<%
	FOR J = 1 TO UBOUND(aCal, 2)
		IF NOT ISNULL(aCal(i,j)) THEN
			IF fn_holiday(iNowYear,iNowMonth,aCal(i,j)) THEN		'// 공휴일
%>
					<td height="24" align="center" style="<% IF strCalendarIntSeq(aCal(i,j)) <> "" THEN %> font-weight:bold;<% END IF %>"<% IF INT(YEAR(NOW)) = INT(iNowYear) AND INT(MONTH(NOW)) = INT(iNowMonth) AND INT(DAY(NOW)) = INT(aCal(i,j)) THEN %> bgcolor="#FFFFE0"<% END IF %>><a href="javascript:;" onClick="OnRead('<%=iNowYear%>','<%=iNowMonth%>','<%=aCal(i,j)%>');return false;"><span style="font-size:11px; color:#FF0000;"><%=aCal(i,j)%></span></a></td>
<%
			ELSEIF fn_nowweek(iNowYear,iNowMonth,aCal(i,j))=1 THEN		'// 일요일
%>
					<td height="24" align="center" style="<% IF strCalendarIntSeq(aCal(i,j)) <> "" THEN %> font-weight:bold;<% END IF %>"<% IF INT(YEAR(NOW)) = INT(iNowYear) AND INT(MONTH(NOW)) = INT(iNowMonth) AND INT(DAY(NOW)) = INT(aCal(i,j)) THEN %> bgcolor="#FFFFE0"<% END IF %>><a href="javascript:;" onClick="OnRead('<%=iNowYear%>','<%=iNowMonth%>','<%=aCal(i,j)%>');return false;"><span style="font-size:11px; color:#FF0000;"><%=aCal(i,j)%></span></a></td>
<%
			ELSEIF fn_nowweek(iNowYear,iNowMonth,aCal(i,j)) = 7  THEN		'// 토요일
%>
					<td height="24" align="center" style="<% IF strCalendarIntSeq(aCal(i,j)) <> "" THEN %> font-weight:bold;<% END IF %>"<% IF INT(YEAR(NOW)) = INT(iNowYear) AND INT(MONTH(NOW)) = INT(iNowMonth) AND INT(DAY(NOW)) = INT(aCal(i,j)) THEN %> bgcolor="#FFFFE0"<% END IF %>><a href="javascript:;" onClick="OnRead('<%=iNowYear%>','<%=iNowMonth%>','<%=aCal(i,j)%>');return false;"><span style="font-size:11px; color:#0000FF;"><%=aCal(i,j)%></span></a></td>
<%
			ELSE		'// 평일
%>
					<td height="24" align="center" style="<% IF strCalendarIntSeq(aCal(i,j)) <> "" THEN %> font-weight:bold;<% END IF %>"<% IF INT(YEAR(NOW)) = INT(iNowYear) AND INT(MONTH(NOW)) = INT(iNowMonth) AND INT(DAY(NOW)) = INT(aCal(i,j)) THEN %> bgcolor="#FFFFE0"<% END IF %>><a href="javascript:;" onClick="OnRead('<%=iNowYear%>','<%=iNowMonth%>','<%=aCal(i,j)%>');return false;"><span style="font-size:11px; color:#000000;"><%=aCal(i,j)%></span></a></td>
<%
			END IF
		ELSE	'// 공백
%>
					<td height="24" align="center">&nbsp;</td>
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
<script language="javascript">

	function OnRead(iYear, iMonth, iDay){

		parent.location.href = "ScheduleList.asp?strScYear=" + iYear + "&strScMonth=" + iMonth + "&strScDay=" + iDay;

	}

	function OnDateChange(){
		parent.location.href = "ScheduleList.asp?strScYear=" + document.all['intYear'].value + "&strScMonth=" + document.all['intMonth'].value + "&strScDay=1";
	}

</script>
<!-- #include file = "../Foot.asp" -->