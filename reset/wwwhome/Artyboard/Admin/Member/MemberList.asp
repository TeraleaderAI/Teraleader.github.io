<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu  = 3
	intLeftMenu = 7
	isAdminMenu = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount, strOrder
	intPage     = REQUEST.QueryString("intPage") : IF intPage     = "" THEN intPage     = 1
	intPageSize = REQUEST.FORM("intPageSize")    : IF intPageSize = "" THEN intPageSize = 20
	strOrder    = REQUEST.FORM("strOrder")       : IF strOrder = "" THEN strOrder = "[dateRegDate] DESC"

	DIM strSearchCategory1, strSearchCategory2, strSearchCategory3, strSearchCategory4, strSearchCategory5, strSearchCategory6
	DIM strSearchCategory7, strSearchCategory8, strSearchCategory9, Query

	DIM strSearchGroup, bitAuth, strSearchCategory, strSearchWord, intSex, sYear, sMonth, sDay, eYear, eMonth, eDay, intPoint
	DIM intAge, strBirthday, dateSignDate

	Query = " WHERE [strAdmin] != '2' AND [bitSecession] = '0' "

	WITH REQUEST

		strSearchCategory1 = GetReplaceInput(.FORM("strSearchCategory1"),"")
		strSearchCategory2 = GetReplaceInput(.FORM("strSearchCategory2"),"")
		strSearchCategory3 = GetReplaceInput(.FORM("strSearchCategory3"),"")
		strSearchCategory4 = GetReplaceInput(.FORM("strSearchCategory4"),"")
		strSearchCategory5 = GetReplaceInput(.FORM("strSearchCategory5"),"")
		strSearchCategory6 = GetReplaceInput(.FORM("strSearchCategory6"),"")
		strSearchCategory7 = GetReplaceInput(.FORM("strSearchCategory7"),"")
		strSearchCategory8 = GetReplaceInput(.FORM("strSearchCategory8"),"")
		strSearchCategory9 = GetReplaceInput(.FORM("strSearchCategory9"),"")

		strSearchGroup     = .FORM("strSearchGroup")
		bitAuth            = .FORM("bitAuth")
		strSearchCategory  = .FORM("strSearchCategory")
		strSearchWord      = GetReplaceInput(.FORM("strSearchWord"), "")
		intSex             = .FORM("intSex")
		sYear              = .FORM("sYear")
		sMonth             = .FORM("sMonth")
		sDay               = .FORM("sDay")
		eYear              = .FORM("eYear")
		eMonth             = .FORM("eMonth")
		eDay               = .FORM("eDay")
		intPoint           = .FORM("intPoint")
		intAge             = .FORM("intAge")
		strBirthday        = .FORM("strBirthday")
		dateSignDate       = .FORM("dateSignDate")

	END WITH

	DIM strGroupOption
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_GROUP] ")
	WHILE NOT(RS.EOF)
		strGroupOption = strGroupOption & "<option value='" & RS("strGroupCode") & "'"
		IF strSearchGroup = RS("strGroupCode") THEN strGroupOption = strGroupOption & " SELECTED"
		strGroupOption = strGroupOption & ">" & RS("strGroupName") & " [Lv." & RS("intLevel") & "]</option>" & vbcrlf
	RS.MOVENEXT
	WEND

	IF sYear = "" AND sMonth = "" AND sDay = "" THEN
		sYear  = YEAR(NOW)
		sMonth = MONTH(NOW)   : IF LEN(sMonth) = 1 THEN sMonth = "0" & sMonth
		sDay   = DAY(NOW)     : IF LEN(sDay)   = 1 THEN sDay   = "0" & sDay
	END IF

	IF eYear = "" AND eMonth = "" AND eDay = "" THEN
		eYear  = YEAR(NOW)
		eMonth = MONTH(NOW)   : IF LEN(eMonth) = 1 THEN eMonth = "0" & eMonth
		eDay   = DAY(NOW)     : IF LEN(eDay)   = 1 THEN eDay   = "0" & eDay
	END IF

	IF strSearchCategory1 = "1" AND strSearchGroup <> "" THEN Query = Query & " AND [strGroup] = '" & strSearchGroup & "' "
	IF strSearchCategory2 = "1" AND bitAuth <> "" THEN Query = Query & " AND [bitAuth] = '" & bitAuth & "' "
	IF strSearchCategory3 = "1" AND strSearchCategory <> "" AND strSearchWord <> "" THEN Query = Query & " AND [" & strSearchCategory & "] LIKE '%" & strSearchWord & "%' "
	IF strSearchCategory4 = "1" AND intSex <> "" THEN Query = Query & " AND SUBSTRING([strSSN], 7, 1) = '" & intSex & "' "
	IF strSearchCategory5 = "1" THEN Query = Query & " AND [dateRegDate] BETWEEN '" & sYear & "-" & sMonth & "-" & sDay & "' AND '" & DATEADD("d", 1, eYear & "-" & eMonth & "-" & eDay) & "' "
	IF strSearchCategory6 = "1" AND intPoint <> "" THEN Query = Query & " AND [intPoint] >= " & intPoint

	IF strSearchCategory7 = "1" AND intAge <> "" THEN Query = Query & " AND LEFT(YEAR(getdate()),4) - CONVERT(INT,((CONVERT(VARCHAR,CASE SUBSTRING([strSSN],1,1) WHEN '0' THEN '20' ELSE '19' END))) +  CONVERT(VARCHAR,SUBSTRING([strSSN],1,2))) >= " & intAge & " AND LEFT(YEAR(getdate()),4) - CONVERT(INT,((CONVERT(VARCHAR,CASE SUBSTRING([strSSN],1,1) WHEN '0' then '20' ELSE '19' END))) +  CONVERT(VARCHAR,SUBSTRING([strSSN],1,2))) <= " & INT(intAge) + 9

	IF strSearchCategory8 = "1" AND strBirthday <> "" THEN

		DIM nowYear, nowMonth, nowDay, umDate, umYear, umMonth, umDay, nowWeekDay, nowWeekStartDate, nowWeekEndDate
		DIM nowWeekStartMonth, nowWeekStartDay, nowWeekEndMonth, nowWeekEndDay, nowWeekUmStartDate, nowWeekUmEndDate
		DIM nowWeekUmStartMonth, nowWeekUmStartDay, nowWeekUmEndMonth, nowWeekUmEndDay
		
		nowYear  = YEAR(NOW)
		nowMonth = MONTH(NOW)   : IF LEN(nowMonth) = 1 THEN nowMonth = "0" & nowMonth
		nowDay   = DAY(NOW)     : IF LEN(nowDay)   = 1 THEN nowDay   = "0" & nowDay

		umDate  = GetLunar(nowYear, nowMonth, nowDay)
		umYear  = YEAR(umDate)
		umMonth = MONTH(umDate)   : IF LEN(umMonth) = 1 THEN umMonth = "0" & umMonth
		umDay   = DAY(umDate)     : IF LEN(umDay)   = 1 THEN umDay   = "0" & umDay

		SELECT CASE strBirthday
		CASE "1"
			Query = Query & " AND ((SUBSTRING([strBirthday], 5, 4) = '" & nowMonth & nowDay & "' AND SUBSTRING([strBirthday], 9, 1) = '1') OR (SUBSTRING([strBirthday], 5, 4) = '" & umMonth & umDay & "' AND SUBSTRING([strBirthday], 9, 1) = '0')) "
		CASE "2"
			nowWeekDay = WEEKDAY(NOW)
			nowWeekStartDate = DATEADD("d", 1 - nowWeekDay, NOW)
			nowWeekEndDate   = DATEADD("d", 7 - nowWeekDay, NOW)

			nowWeekStartMonth = MONTH(nowWeekStartDate)
			nowWeekStartDay   = DAY(nowWeekStartDate)
			nowWeekEndMonth   = MONTH(nowWeekEndDate)
			nowWeekEndDay     = DAY(nowWeekEndDate)

			IF LEN(nowWeekStartMonth) = 1 THEN nowWeekStartMonth = "0" & nowWeekStartMonth
			IF LEN(nowWeekStartDay)   = 1 THEN nowWeekStartDay   = "0" & nowWeekStartDay
			IF LEN(nowWeekEndMonth)   = 1 THEN nowWeekEndMonth   = "0" & nowWeekEndMonth
			IF LEN(nowWeekEndDay)     = 1 THEN nowWeekEndDay     = "0" & nowWeekEndDay

			nowWeekUmStartDate = GetLunar(YEAR(nowWeekStartDate), nowWeekStartMonth, nowWeekStartDay)
			nowWeekUmEndDate   = GetLunar(YEAR(nowWeekEndDate), nowWeekEndMonth, nowWeekEndDay)

			nowWeekUmStartMonth = MONTH(nowWeekUmStartDate)
			nowWeekUmStartDay   = DAY(nowWeekUmStartDate)
			nowWeekUmEndMonth   = MONTH(nowWeekUmEndDate)
			nowWeekUmEndDay     = DAY(nowWeekUmEndDate)

			IF LEN(nowWeekUmStartMonth) = 1 THEN nowWeekUmStartMonth = "0" & nowWeekUmStartMonth
			IF LEN(nowWeekUmStartDay)   = 1 THEN nowWeekUmStartDay   = "0" & nowWeekUmStartDay
			IF LEN(nowWeekUmEndMonth)   = 1 THEN nowWeekUmEndMonth   = "0" & nowWeekUmEndMonth
			IF LEN(nowWeekUmEndDay)     = 1 THEN nowWeekUmEndDay     = "0" & nowWeekUmEndDay

			Query = Query & " AND ((SUBSTRING([strBirthday], 5, 4) >= '" & nowWeekStartMonth & nowWeekStartDay & "' AND SUBSTRING([strBirthday], 5, 4) <= '" & nowWeekEndMonth & nowWeekEndDay & "' AND SUBSTRING([strBirthday], 9, 1) = '1') OR (SUBSTRING([strBirthday], 5, 4) >= '" & nowWeekUmStartMonth & nowWeekUmStartDay & "' AND SUBSTRING([strBirthday], 5, 4) <= '" & nowWeekUmEndMonth & nowWeekUmEndDay & "' AND SUBSTRING([strBirthday], 9, 1) = '0')) "

		CASE "3"

			DIM nowStartDateMonth, nowStartDateDay, nowStartDate, nowEndDate, nowEndDateMonth, nowEndDateDay
			DIM nowStartUmDate, nowEndUmDate, nowStartDateUmMonth, nowStartDateUmDay, nowEndDateUmMonth, nowEndDateUmDay
	
			nowStartDateMonth = MONTH(NOW)   : IF LEN(nowStartDateMonth) = 1 THEN nowStartDateMonth = "0" & nowStartDateMonth
			nowStartDateDay   = "01"
			nowStartDate      = YEAR(NOW) & "-" & nowStartDateMonth & "-" & nowStartDateDay
			nowEndDate        = YEAR(NOW) & "-" & nowStartDateMonth & "-" & GetMonthCount(YEAR(NOW), nowStartDateMonth)
			nowEndDateMonth   = nowStartDateMonth
			nowEndDateDay     = GetMonthCount(YEAR(NOW), nowStartDateMonth)
	
			nowStartUmDate = GetLunar(YEAR(NOW), nowStartDateMonth, "01")
			nowEndUmDate   = GetLunar(YEAR(NOW), nowStartDateMonth, nowEndDateDay)
	
			nowStartDateUmMonth = MONTH(nowStartUmDate)
			nowStartDateUmDay   = DAY(nowStartUmDate)
			nowEndDateUmMonth   = MONTH(nowEndUmDate)
			nowEndDateUmDay     = DAY(nowEndUmDate)

			IF LEN(nowStartDateUmMonth) = 1 THEN nowStartDateUmMonth = "0" & nowStartDateUmMonth
			IF LEN(nowStartDateUmDay)   = 1 THEN nowStartDateUmDay   = "0" & nowStartDateUmDay
			IF LEN(nowEndDateUmMonth)   = 1 THEN nowEndDateUmMonth   = "0" & nowEndDateUmMonth
			IF LEN(nowEndDateUmDay)     = 1 THEN nowEndDateUmDay     = "0" & nowEndDateUmDay

			Query = Query & " AND ((SUBSTRING([strBirthday], 5, 4) >= '" & nowStartDateMonth & nowStartDateDay & "' AND SUBSTRING([strBirthday], 5, 4) <= '" & nowEndDateMonth & nowEndDateDay & "' AND SUBSTRING([strBirthday], 9, 1) = '1') OR (SUBSTRING([strBirthday], 5, 4) >= '" & nowStartDateUmMonth & nowStartDateUmDay & "' AND SUBSTRING([strBirthday], 5, 4) <= '" & nowEndDateUmMonth & nowEndDateUmDay & "' AND SUBSTRING([strBirthday], 9, 1) = '0')) "

		END SELECT

	END IF

	IF strSearchCategory9 = "1" AND dateSignDate <> "" THEN Query = Query & " AND DATEDIFF(day, [dateSignDate], '" & dateSignDate & "') = 0 "

	SET RS = DBCON.EXECUTE("SELECT COUNT([intNum]) AS [RecCount] FROM [MPLUS_MEMBER_LIST] " & Query)

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [intNum], [strLoginID], [strLoginName], [intPoint], [intBoardCount], [intCommentCount], [intVote], [intVisit], [dateSignDate], [dateRegDate], [bitAuth], [intLevel] = (SELECT [intLevel] FROM [MPLUS_GROUP] WHERE [strGroupCode] = [MPLUS_MEMBER_LIST].[strGroup]) FROM [MPLUS_MEMBER_LIST] " & Query & " AND [intNum] NOT IN (SELECT TOP " & (intPage - 1) * intPageSize & " [intNum] FROM [MPLUS_MEMBER_LIST] " & Query & " ORDER BY " & strOrder & ") ORDER BY " & strOrder)
%>
						<script language="javascript" src="../../Js/Calendar.js"></script>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
						<form name="theForm" method="post">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="35"><img src="../images/main_title11.gif" width="121" height="19"></td>
											<td align="right">관리자 홈 &gt; 회원관리 &gt; <b>회원가입 리스트</b></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>회원정보 검색</strong></span></td>
							</tr>
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="10" cellspacing="0" class="table_Select1">
										<tr>
											<td class="table_SelecttdIn1">
												<table width="100%" border="0" cellpadding="2" cellspacing="0">
													<tr>
														<td width="13%" nowrap class="table_SelecttdLeft1"><input name="strSearchCategory1" type="checkbox" class="no_Line" id="strSearchCategory1" value="1"<% IF strSearchCategory1 = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="strSearchCategory1" style="cursor:hand">회원구분</LABEL></td>
														<td width="37%">
														<select name="strSearchGroup" id="strSearchGroup">
														<option value="">그룹선택</option>
														<%=strGroupOption%>
														</select>
														</td>
														<td width="13%" nowrap class="table_SelecttdLeft1"><input name="strSearchCategory2" type="checkbox" class="no_Line" id="strSearchCategory2" value="1"<% IF strSearchCategory2 = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="strSearchCategory2" style="cursor:hand">가입승인</LABEL></td>
														<td width="37%"><input type="radio" name="bitAuth" id="bitAuth1" value="1"<% IF bitAuth = "1" THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitAuth1" style="cursor:hand">승인</LABEL>
														<input type="radio" name="bitAuth" id="bitAuth2" value="0"<% IF bitAuth = "0" THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitAuth2" style="cursor:hand">미승인</LABEL></td>
													</tr>
													<tr>
														<td nowrap class="table_SelecttdLeft1"><input name="strSearchCategory3" type="checkbox" class="no_Line" id="strSearchCategory3" value="1"<% IF strSearchCategory3 = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="strSearchCategory3" style="cursor:hand">키워드검색</LABEL></td>
														<td>
														<select name="strSearchCategory" id="strSearchCategory">
														<option value="" selected="selected">검색항목</option>
														<option value="strLoginName"<% IF strSearchCategory = "strLoginName" THEN %> SELECTED<% END IF %>>회원이름</option>
														<option value="strLoginID"<% IF strSearchCategory = "strLoginID" THEN %> SELECTED<% END IF %>>회원아이디</option>
														<option value="strNick"<% IF strSearchCategory = "strNick" THEN %> SELECTED<% END IF %>>회원닉네임</option>
														<option value="strEmail"<% IF strSearchCategory = "strEmail" THEN %> SELECTED<% END IF %>>회원이메일</option>
														</select>
														<input name="strSearchWord" type="text" class="input" id="strSearchWord" value="<%=strSearchWord%>" size="29" maxlength="128" />											</td>
														<td nowrap class="table_SelecttdLeft1"><input name="strSearchCategory4" type="checkbox" class="no_Line" id="strSearchCategory4" value="1"<% IF strSearchCategory4 = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="strSearchCategory4" style="cursor:hand">성별</LABEL></td>
														<td><input type="radio" name="intSex" id="intSex1" value="1"<% IF intSex = "1" THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="intSex1" style="cursor:hand">남성</LABEL>
														<input type="radio" name="intSex" id="intSex2" value="2"<% IF intSex = "2" THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="intSex2" style="cursor:hand">여성</LABEL></td>
													</tr>
													<tr>
														<td nowrap class="table_SelecttdLeft1"><input name="strSearchCategory5" type="checkbox" class="no_Line" id="strSearchCategory5" value="1"<% IF strSearchCategory5 = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="strSearchCategory5" style="cursor:hand">가입기간</LABEL></td>
														<td colspan="3">
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td height="28"><select name="sYear" id="sYear">
<%
	FOR I = YEAR(NOW) - 2 TO YEAR(NOW) + 2
		RESPONSE.WRITE "<option value='" & I & "'"
		IF INT(sYear) = INT(I) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "</option>" & vbcrlf
	NEXT
%>
																	</select>
																	년
																	<select name="sMonth" id="sMonth">
<%
	FOR I = 1 TO 12
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I ELSE RESPONSE.WRITE I
		RESPONSE.WRITE "'"
		IF INT(sMonth) = INT(I) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "</option>" & vbcrlf
	NEXT
%>
																	</select>
																	월
																	<select name="sDay" id="sDay">
<%
	FOR I = 1 TO 31
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I ELSE RESPONSE.WRITE I
		RESPONSE.WRITE "'"
		IF INT(sDay) = INT(I) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "</option>" & vbcrlf
	NEXT
%>
																	</select>
																	일
																	~
																	<select name="eYear" id="eYear">
<%
	FOR I = YEAR(NOW) - 2 TO YEAR(NOW) + 2
		RESPONSE.WRITE "<option value='" & I & "'"
		IF INT(eYear) = INT(I) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "</option>" & vbcrlf
	NEXT
%>
																	</select>
																	년
																	<select name="eMonth" id="eMonth">
<%
	FOR I = 1 TO 12
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I ELSE RESPONSE.WRITE I
		RESPONSE.WRITE "'"
		IF INT(eMonth) = INT(I) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "</option>" & vbcrlf
	NEXT
%>
																	</select>
																	월
																	<select name="eDay" id="eDay">
<%
	FOR I = 1 TO 31
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I ELSE RESPONSE.WRITE I
		RESPONSE.WRITE "'"
		IF INT(eDay) = INT(I) THEN RESPONSE.WRITE " SELECTED"

		RESPONSE.WRITE ">" & I & "</option>" & vbcrlf
	NEXT
%>
																	</select>
																	일</td>
																</tr>
																<tr>
																	<td height="28"><a href="javascript:;" onClick="OnSearchDate('<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');return false;"><img src="../images/btn_day1.gif" width="35" height="15" border="0"></a>
																	<a href="javascript:;" onClick="OnSearchDate('<%=YEAR(DATEADD("d", -1, NOW()))%>','<%=MONTH(DATEADD("d", -1, NOW()))%>','<%=DAY(DATEADD("d", -1, NOW()))%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');"><img src="../images/btn_day2.gif" width="35" height="15" border="0"></a>
																	<a href="javascript:;" onClick="OnSearchDate('<%=YEAR(DATEADD("d", -3, NOW()))%>','<%=MONTH(DATEADD("d", -3, NOW()))%>','<%=DAY(DATEADD("d", -3, NOW()))%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');"><img src="../images/btn_day3.gif" width="35" height="15" border="0"></a>
																	<a href="javascript:;" onClick="OnSearchDate('<%=YEAR(DATEADD("d", -7, NOW()))%>','<%=MONTH(DATEADD("d", -7, NOW()))%>','<%=DAY(DATEADD("d", -7, NOW()))%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');"><img src="../images/btn_day4.gif" width="35" height="15" border="0"></a>
																	<a href="javascript:;" onClick="OnSearchDate('<%=YEAR(DATEADD("d", -10, NOW()))%>','<%=MONTH(DATEADD("d", -10, NOW()))%>','<%=DAY(DATEADD("d", -10, NOW()))%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');"><img src="../images/btn_day5.gif" width="35" height="15" border="0"></a>
																	<a href="javascript:;" onClick="OnSearchDate('<%=YEAR(DATEADD("d", -20, NOW()))%>','<%=MONTH(DATEADD("d", -20, NOW()))%>','<%=DAY(DATEADD("d", -20, NOW()))%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');"><img src="../images/btn_day6.gif" width="35" height="15" border="0"></a>
																	<a href="javascript:;" onClick="OnSearchDate('<%=YEAR(DATEADD("d", -30, NOW()))%>','<%=MONTH(DATEADD("d", -30, NOW()))%>','<%=DAY(DATEADD("d", -30, NOW()))%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');"><img src="../images/btn_day7.gif" width="35" height="15" border="0"></a>
																	<a href="javascript:;" onClick="OnSearchDate('<%=YEAR(DATEADD("d", -60, NOW()))%>','<%=MONTH(DATEADD("d", -60, NOW()))%>','<%=DAY(DATEADD("d", -60, NOW()))%>','<%=YEAR(NOW)%>','<%=MONTH(NOW)%>','<%=DAY(NOW)%>');"><img src="../images/btn_day8.gif" width="35" height="15" border="0"></a>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td nowrap class="table_SelecttdLeft1"><input name="strSearchCategory6" type="checkbox" class="no_Line" id="strSearchCategory6" value="1"<% IF strSearchCategory6 = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="strSearchCategory6" style="cursor:hand">보유 포인트 </LABEL></td>
														<td width="30%"><input name="intPoint" type="text" id="intPoint" value="<%=intPoint%>" size="10" maxlength="10" onblur="onlynum(this, 1);">
														포인트 이상</td>
														<td nowrap class="table_SelecttdLeft1"><input name="strSearchCategory7" type="checkbox" class="no_Line" id="strSearchCategory7" value="1"<% IF strSearchCategory7 = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="strSearchCategory7" style="cursor:hand">연령대</LABEL></td>
														<td><select name="intAge" id="intAge">
														<option value="">=== 연령대 선택 ===</option>
														<option value="10"<% IF intAge = "10" THEN %> SELECTED<% END IF %>>10대</option>
														<option value="20"<% IF intAge = "20" THEN %> SELECTED<% END IF %>>20대</option>
														<option value="30"<% IF intAge = "30" THEN %> SELECTED<% END IF %>>30대</option>
														<option value="40"<% IF intAge = "40" THEN %> SELECTED<% END IF %>>40대</option>
														<option value="50"<% IF intAge = "50" THEN %> SELECTED<% END IF %>>50대</option>
														<option value="60"<% IF intAge = "60" THEN %> SELECTED<% END IF %>>60대</option>
														<option value="70"<% IF intAge = "70" THEN %> SELECTED<% END IF %>>60대 이후</option>
														</select></td>
													</tr>
													<tr>
														<td nowrap class="table_SelecttdLeft1"><input name="strSearchCategory8" type="checkbox" class="no_Line" id="strSearchCategory8" value="1"<% IF strSearchCategory8 = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="strSearchCategory8" style="cursor:hand">생일자</LABEL></td>
														<td><input type="radio" name="strBirthday" id="strBirthday1" value="1"<% IF strBirthday = "1" THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strBirthday1" style="cursor:hand">오늘</LABEL>
														<input type="radio" name="strBirthday" id="strBirthday2" value="2"<% IF strBirthday = "2" THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strBirthday2" style="cursor:hand">이번주</LABEL>
														<input type="radio" name="strBirthday" id="strBirthday3" value="3"<% IF strBirthday = "3" THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strBirthday3" style="cursor:hand">이달</LABEL></td>
														<td nowrap class="table_SelecttdLeft1"><input name="strSearchCategory9" type="checkbox" class="no_Line" id="strSearchCategory9" value="1"<% IF strSearchCategory9 = "1" THEN %> CHECKED<% END IF %>>
														<LABEL FOR="strSearchCategory9" style="cursor:hand">최근방문일자</LABEL>											  </td>
														<td><input name="dateSignDate" type="text" id="dateSignDate" value="<%=dateSignDate%>" size="10" maxlength="10">
														<img src="../images/calendar.gif" width="24" height="22" align="absmiddle" onClick="Calendar_D(document.all.dateSignDate);" style="cursor:hand;">
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="40" align="center"><a href="javascript:;" onclick="OnMemberSearch();return false;"><img src="../images/btn_search_m.gif" width="69" height="25" border="0" /></a></td>
							</tr>
							<tr>
								<td style="padding-top:5; padding-bottom:5;">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>전체 : <font color="#C6325B"><b><%=intTotalCount%></b></font>&nbsp;&nbsp;<%=intPage%>/<%=intPageCount%> 페이지 </td>
											<td align="right">
											<b>정렬방식</b>
											<select name="strOrder" id="strOrder" onChange="document.theForm.submit();">
											<option value="[dateRegDate] DESC"<% IF strOrder = "[dateRegDate] DESC" THEN %> SELECTED<% END IF %>>- 회원가입일↑</option>
											<option value="[dateRegDate] ASC"<% IF strOrder = "[dateRegDate] ASC" THEN %> SELECTED<% END IF %>>- 회원가입일↓</option>
											<option value="[strLoginID] DESC"<% IF strOrder = "[strLoginID] DESC" THEN %> SELECTED<% END IF %>>- 회원아이디↑</option>
											<option value="[strLoginID] ASC"<% IF strOrder = "[strLoginID] ASC" THEN %> SELECTED<% END IF %>>- 회원아이디↓</option>
											<option value="[strLoginName] DESC"<% IF strOrder = "[strLoginName] DESC" THEN %> SELECTED<% END IF %>>- 회원이름↑</option>
											<option value="[strLoginName] ASC"<% IF strOrder = "[strLoginName] ASC" THEN %> SELECTED<% END IF %>>- 회원이름↓</option>
											<optgroup label="------------"></optgroup>
											<option value="[bitAuth] DESC"<% IF strOrder = "[bitAuth] DESC" THEN %> SELECTED<% END IF %>>- 승인유무</option>
											<option value="[bitAuth] ASC"<% IF strOrder = "[bitAuth] ASC" THEN %> SELECTED<% END IF %>>- 승인유무</option>
											<option value="[strGroup] DESC"<% IF strOrder = "[strGroup] DESC" THEN %> SELECTED<% END IF %>>- 회원 그룹별 정렬↑</option>
											<option value="[strGroup] ASC"<% IF strOrder = "[strGroup] ASC" THEN %> SELECTED<% END IF %>>- 회원 그룹별 정렬↓</option>
											<optgroup label="------------"></optgroup>
											<option value="[intPoint] DESC"<% IF strOrder = "[intPoint] DESC" THEN %> SELECTED<% END IF %>>- 포인트순 정렬↑</option>
											<option value="[intPoint] ASC"<% IF strOrder = "[intPoint] ASC" THEN %> SELECTED<% END IF %>>- 포인트순 정렬↓</option>
											<option value="[intVisit] DESC"<% IF strOrder = "[intVisit] DESC" THEN %> SELECTED<% END IF %>>- 방문순 정렬↑</option>
											<option value="[intVisit] ASC"<% IF strOrder = "[intVisit] ASC" THEN %> SELECTED<% END IF %>>- 방문순 정렬↓</option>
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
											</select>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%"  border="0" cellpadding="0" cellspacing="0">
										<tr align="center" bgcolor="EB766F">
											<td colspan="13" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td height="30" class="table_Txt1" nowrap>선택</td>
											<td height="30" class="table_Txt1" nowrap>번호</td>
											<td height="30" class="table_Txt1" nowrap>아이디</td>
											<td height="30" class="table_Txt1" nowrap>이름</td>
											<td class="table_Txt1" nowrap>포인트</td>
											<td class="table_Txt1" nowrap>접속</td>
											<td class="table_Txt1" nowrap>최근접속</td>
											<td class="table_Txt1" nowrap>게시글/댓글/추천</td>
											<td class="table_Txt1" nowrap>가입일</td>
											<td class="table_Txt1" nowrap>등급</td>
											<td width="45" nowrap class="table_Txt1">승인</td>
											<td width="45" height="30" nowrap class="table_Txt1">수정</td>
											<td width="45" align="center" class="table_Txt1" nowrap>삭제</td>
										</tr>
										<tr bgcolor="EB766F">
											<td colspan="13" class="table_Round1"></td>
										</tr>
<%
	IF RS.EOF THEN
%>
										<tr align="center" bgcolor="#FFFFFF">
											<td colspan="13" class="table_ListSubText1">등록된 회원이 없습니다.</td>
										</tr>
										<tr>
											<td colspan="13" class="table_ListSubLine1"></td>
										</tr>
<%
	ELSE
		DIM iCount, intMemberNum
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intMemberNum = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1"><input name="strLoginID" type="checkbox" id="strLoginID" value="<%=RS("strLoginID")%>" class="no_Line"></td>
											<td class="table_ListSubText1"><%=intMemberNum%></td>
											<td class="table_ListSubText1"><%=RS("strLoginID")%></td>
											<td class="table_ListSubText1"><%=RS("strLoginName")%></td>
											<td class="table_ListSubText1"><a href="javascript:popupLayer('MemberPoint.asp?strLoginID=<%=RS("strLoginID")%>',810,535);"><%=GetMoneyComma(RS("intPoint"))%></a></td>
											<td class="table_ListSubText1"><%=RS("intVisit")%></td>
											<td class="table_ListSubText1"><%=GetDateType(0, RS("dateSignDate"))%></td>
											<td class="table_ListSubText1"><%=RS("intBoardCount")%> / <%=RS("intCommentCount")%> / <%=RS("intVote")%></td>
											<td class="table_ListSubText1"><%=REPLACE(FORMATDATETIME(RS("dateRegDate"),2), "-", "/")%></td>
											<td class="table_ListSubText1">Lv.<%=RS("intLevel")%></td>
											<td class="table_ListSubText1"><% IF RS("bitAuth") = True THEN %><a href="javascript:;" onclick="OnMemberAuth('0','<%=RS("strLoginId")%>');return false;"><img src="../images/btn_cancel_s.gif" width="38" height="16" border="0" /></a><% ELSE %><a href="javascript:;" onclick="OnMemberAuth('1','<%=RS("strLoginId")%>');return false;"><img src="../images/btn_check_s.gif" width="38" height="16" border="0" /></a><% END IF %></td>
											<td class="table_ListSubText1"><a href="javascript:;" onclick="OnMemberEdit('<%=RS("strLoginID")%>');return false;"><img src="../images/btn_edit_s.gif" width="38" height="16" border="0" /></a></td>
											<td class="table_ListSubText1"><a href="javascript:;" onclick="OnMemberRemove('<%=RS("strLoginID")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0" /></a></td>
										</tr>
										<tr>
											<td colspan="13" class="table_ListSubLine1"></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
										<tr>
											<td colspan="13" height="1"></td>
										</tr>
										<tr>
											<td colspan="13" class="table_ListSubBLine1"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="40" align="center">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="30"><a href="javascript:;" onclick="OnMemberSelect();return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0" style="margin-right:5px;"></a><a href="javascript:;" onClick="OnMemberJoin();return false;"><img src="../images/btn_member_join_w.gif" width="95" height="19" border="0"></a></td>
											<td width="131"><a href="javascript:popupLayer('MemberPointList.asp',620,730);"><img src="../images/btn_member_ranking_w.gif" width="131" height="19" border="0"></a></td>
										</tr>
										<tr>
											<td height="40" colspan="2" align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="table_Select2" style="padding-top:5; padding-bottom:5;">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="120" height="24" style="padding-left:10;"><b>회원레벨 변경</b></td>
											<td height="24"><select name="strGroup" id="strGroup">
											<option value="">그룹선택</option>
											<%=strGroupOption%>
											</select>
											<a href="javascript:;" onclick="OnGroupChange();return false;"><img src="../images/btn_select_member_level_w.gif" width="116" height="19" border="0" align="absmiddle"></a></td>
										</tr>
										<tr>
											<td width="120" height="24" style="padding-left:10;"><b>회원정보 액셀저장 </b></td>
											<td height="24"><a href="javascript:;" onclick="OnMemberExcel('s');return false;"><img src="../images/btn_select_member_excel_w.gif" width="129" height="19" border="0"></a>
											<a href="javascript:;" onclick="OnMemberExcel('a');return false;"><img src="../images/btn_all_member_excel_w.gif" width="129" height="19" border="0"></a></td>
										</tr>
										<tr>
											<td width="120" height="24" style="padding-left:10;"><b>선택회원 일괄처리 </b></td>
											<td height="24">
											<a href="javascript:;" onclick="OnSelectRemove();return false;"><img src="../images/btn_select_member_delete_w.gif" width="116" height="19" border="0"></a>
											<a href="javascript:;" onclick="OnSecession();return false;"><img src="../images/btn_select_member_out_w.gif" width="116" height="19" border="0"></a>
											<a href="javascript:;" onclick="OnMemberPoint();return false;"><img src="../images/btn_select_member_point_w.gif" width="158" height="19" border="0"></a>
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
	var SET_NOW_PAGE = "<%=intPage%>";
	var SET_intTotalCount = "<%=intTotalCount%>";

	function OnSearchDate(sy, sm, sd, ey, em, ed){
		var slyoption	= chkop( document.all['sYear'], (sy * 1) );
		var slmoption	= chkop( document.all['sMonth'], (sm * 1) );
		var sldoption	= chkop( document.all['sDay'], (sd * 1) );
		var elyoption	= chkop( document.all['eYear'], (ey * 1) );
		var elmoption	= chkop( document.all['eMonth'], (em * 1) );
		var eldoption	= chkop( document.all['eDay'], (ed * 1) );
	
		document.all['sYear'].selectedIndex = slyoption;
		document.all['sMonth'].selectedIndex = slmoption;
		document.all['sDay'].selectedIndex = sldoption;
		document.all['eYear'].selectedIndex = elyoption;
		document.all['eMonth'].selectedIndex = elmoption;
		document.all['eDay'].selectedIndex = eldoption;
	}

	function chkop(obj, num){
		var mx = obj.length;
		var getchknums = "";
	
		for ( ic = 0; ic < mx; ic++ ){
			getchknums = obj.options[ic].value;
			if ( getchknums == num ){
				var changeid = ic;
			}
		}
		return changeid;
	}

	function OnMemberSearch(){
		document.theForm.action = "MemberList.asp";
		document.theForm.submit();
	}

	function OnMemberSelect(){
		if (SET_intTotalCount != "0"){

			obj = document.all['strLoginID'];

			if (SET_intTotalCount == "1"){
				if (obj.checked == true){obj.checked = false;}else{obj.checked = true}
			}else{
				var cntBox = obj.length - 1;
				for(var i = 0; i <= cntBox; i++){
					if (obj[i].checked == false){obj[i].checked=true;}else{obj[i].checked=false;}
				}
			}
		}
	}

	function OnMemberAuth(str, userID){
		switch (str){
			case "0":
				var strMsg = "회원승인을 취소하시겠습니까?";
				break;
			case "1":
				var strMsg = "회원승인을 실행하시겠습니까?";
				break;
		}
		if(confirm(strMsg)){
			document.theForm.action = "MemberList_ok.asp?Action=auth&bitAuth=" + str + "&strLoginID=" + userID + "&intPage=" + SET_NOW_PAGE;
			document.theForm.submit();
		}
	}

	function OnMemberSelectCheck(){
		var sMember = "";
		if (SET_intTotalCount == "0"){
			return false;
		}else{
			obj = document.all['strLoginID'];
			if (SET_intTotalCount == "1"){
				if (obj.checked == true){
					sMember = sMember + obj.value + ",";
				}
			}else{
				var cntBox = obj.length - 1;
				for(var i = 0; i <= cntBox; i++){
					if (obj[i].checked == true){
						sMember = sMember + obj[i].value + ",";
					}
				}
			}
			return sMember;
		}
	}

	function OnGroupChange(){

		if (document.all['strGroup'].value == ""){
			alert("변경할 회원 그룹을 선택해 주시기 바랍니다.");
			document.all['strGroup'].focus();
			return false;
		}

		var sMember = "";
		sMember = OnMemberSelectCheck();
		if (!sMember || sMember == ""){
			alert("그룹을 변경할 회원을 선택해 주시기 바랍니다.");
			return false;
		}

		if (confirm("선택된 회원의 레벨을 변경하시겠습니까?")){
			document.theForm.action = "MemberList_ok.asp?Action=group&strMemberList=" + sMember + "&intPage=" + SET_NOW_PAGE;
			document.theForm.submit();
		}
	}

	function OnSelectRemove(){

		var sMember = "";
		sMember = OnMemberSelectCheck();
		if (!sMember || sMember == ""){
			alert("회원을 선택해 주시기 바랍니다.");
			return false;
		}

		if (confirm("선택된 회원을 삭제하시겠습니까?")){
			document.theForm.action = "MemberList_ok.asp?Action=selectremove&intPage=" + SET_NOW_PAGE;
			document.theForm.submit();
		}
	}

	function OnSecession(){

		var sMember = "";
		sMember = OnMemberSelectCheck();
		if (!sMember || sMember == ""){
			alert("회원을 선택해 주시기 바랍니다.");
			return false;
		}

		if (confirm("선택된 회원을 탈퇴처리 하시겠습니까?")){
			document.theForm.action = "MemberList_ok.asp?Action=secession&strMemberList=" + sMember + "&intPage=" + SET_NOW_PAGE;
			document.theForm.submit();
		}
	}

	function OnMemberPoint(){

		var sMember = "";
		sMember = OnMemberSelectCheck();
		if (!sMember || sMember == ""){
			alert("회원을 선택해 주시기 바랍니다.");
			return false;
		}

		popupLayer('MemberPointAction.asp?sMember=' + sMember, 610, 260);

	}

	function OnMemberExcel(str){

		if (SET_intTotalCount == "0"){
			alert("등록된 회원이 없습니다.");
			return false;
		}

		switch (str){
			case "a" :
				if(confirm("회원정보를 EXCEL 파일로 저장하시겠습니까?")){
					document.theForm.action = "MemberList_ok.asp?Action=excel&sType=a" + "&intPage=" + SET_NOW_PAGE;
					document.theForm.submit();
				}
				break;
			case "s" :

				var sMember = "";
				sMember = OnMemberSelectCheck();
				if (!sMember || sMember == ""){
					alert("회원을 선택해 주시기 바랍니다.");
					return false;
				}

				if(confirm("회원정보를 EXCEL 파일로 저장하시겠습니까?")){
					document.theForm.action = "MemberList_ok.asp?Action=excel&sType=s" + "&intPage=" + SET_NOW_PAGE + "&strMemberList=" + sMember;
					document.theForm.submit();
				}

				break;
		}
	}

	function OnMemberEdit(str){
		document.theForm.action = "MemberEdit.asp?Action=EDIT&strLoginID=" + str + "&intPage=" + SET_NOW_PAGE;
		document.theForm.submit();
	}

	function OnMemberJoin(){
		document.theForm.action = "MemberEdit.asp?Action=JOIN&intPage=" + SET_NOW_PAGE;
		document.theForm.submit();
	}

	function OnPageMove(str){
		document.theForm.action = "MemberList.asp?intPage=" + str;
		document.theForm.submit();
	}

	function OnMemberRemove(str){
		if (confirm("선택된 회원을 삭제하시겠습니까?")){
			document.theForm.action = "MemberList_ok.asp?Action=remove&strLoginID=" + str + "&intPage=" + SET_NOW_PAGE;
			document.theForm.submit();
		}
	}


</script>
<!-- #include file = "Foot.asp" -->