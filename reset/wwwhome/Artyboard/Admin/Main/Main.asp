<%
	DIM isAdminMenu
	isAdminMenu = 1
%>
<!-- #include file = "Head.asp" -->
<!-- #include file = "../../Library/version.asp" -->
<style type="text/css">
<!--
.style1 {
	font-family: "굴림체", "돋움체", Seoul;
	font-size: 12px;
	color: 2587de;
}
.style2 {
	font-family: "굴림체", "돋움체", Seoul;
	font-size: 12px;
	color: 5f5f5f;
}
-->
</style>
<%
	DIM nowYear, nowMonth, nowDay
	nowYear = YEAR(NOW)
	nowMonth = MONTH(NOW)   : IF LEN(nowMonth) = 1 THEN nowMonth = "0" & nowMonth
	nowDay   = DAY(NOW)     : IF LEN(nowDay)   = 1 THEN nowDay   = "0" & nowDay
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><img src="../images/title_01.gif" width="766" height="17"></td>
	</tr>
	<tr>
		<td height="10"></td>
	</tr>
<%
	SET RS = DBCON.EXECUTE("SELECT [strLoginName], [strEmail], [intVisit], [dateSignDate], [strSignIP] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & SESSION("strLoginID") & "' ")
%>
	<tr>
		<td>
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td valign="top">
						<table width="364" cellpadding="0" cellspacing="0" border="0" class="style1" style="padding: 0 0 0 10">
							<tr height="30"><td><img src="../images/admininfo.gif"></td></tr>
							<tr><td height="2" colspan="2" bgcolor="2c8ee5"></td></tr>
							<tr>
								<td width="120" height="26" bgcolor="ebf3fa">아이디</td>
								<td class="style2" height="26" bgcolor="#FFFFFF"><%=SESSION("strLoginID")%>&nbsp;(<% IF SESSION("strAdmin") = 2 THEN %>전체<% ELSE %>게시판<% END IF %>관리자)</td>
							</tr>
							<tr><td height="1" colspan="2" bgcolor="a5c8e7"></td></tr>
							<tr>
								<td width="120" height="26" bgcolor="ebf3fa"> 이름
								  (E-MAIL) </td>
								<td class="style2" height="26" bgcolor="#FFFFFF"><%=RS("strLoginName")%>&nbsp;(<%=RS("strEmail")%>)</td>
							</tr>
							<tr><td height="1" colspan="2" bgcolor="a5c8e7"></td></tr>
							<tr>
								<td width="120" height="26" bgcolor="ebf3fa"> 최근접속
								  정보 </td>
								<td class="style2" height="26" bgcolor="#FFFFFF"><%=RS("intVisit")%>회 방문 ()<%=GetDateType(0, RS("dateSignDate"))%></td>
							</tr>
							<tr><td height="1" colspan="2" bgcolor="a5c8e7"></td></tr>
							<tr>
								<td width="120" height="26" bgcolor="ebf3fa"> 최종접속
								  아이피</td>
								<td class="style2" height="26" bgcolor="#FFFFFF"><%=RS("strSignIP")%></td>
							</tr>
							<tr><td height="1" colspan="2" bgcolor="2c8ee5"></td></tr>
						</table>
					</td>
					<td width="38"></td>
					<td>
						<table width="364" cellpadding="0" cellspacing="0" border="0" class="style1" style="padding: 0 0 0 10">
							<tr height="30"><td><img src="../images/boardbasicinfo.gif" width="83" height="12"></td>
							</tr>
							<tr>
								<td height="2" colspan="2" bgcolor="2c8ee5"></td>
							</tr>
							<tr>
								<td width="120" height="26" bgcolor="ebf3fa">현재 게시판 버전</td>
								<td class="style2" height="26" bgcolor="#FFFFFF"><%=strVersion%></td>
							</tr>
							<tr>
								<td height="1" colspan="2" bgcolor="a5c8e7"></td>
							</tr>
							<tr>
								<td width="120" height="26" bgcolor="ebf3fa">도메인정보</td>
								<td class="style2" height="26" bgcolor="#FFFFFF"><%=httpPath%></td>
							</tr>
							<tr><td height="1" colspan="2" bgcolor="a5c8e7"></td></tr>
							<tr>
								<td width="120" height="26" bgcolor="ebf3fa">설치경로</td>
								<td class="style2" height="26" bgcolor="#FFFFFF" style="word-break:break-all;"><%=rootPath%></td>
							</tr>
							<tr><td height="1" colspan="2" bgcolor="a5c8e7"></td></tr>
							<tr>
								<td width="120" height="26" bgcolor="ebf3fa">최근 업데이트</td>
								<td class="style2" height="26" bgcolor="#FFFFFF"><%=LastUpdateDate%></td>
							</tr>
							<tr><td height="1" colspan="2" bgcolor="a5c8e7"></td></tr>
<%
	SET RS = DBCON.EXECUTE("sp_helpdb '" & strConnectDbName & "'")
%>
							<tr>
								<td width="120" height="26" bgcolor="ebf3fa">HDD / DB 사용량</td>
								<td class="style2" height="26" bgcolor="#FFFFFF"><%=GetFilesize(GetFolderSize(rootPath))%> / <%=RS("db_size")%></td>
							</tr>
							<tr>
								<td height="1" colspan="2" bgcolor="2c8ee5"></td>
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
	<tr>
		<td><img src="../images/title_02.gif" width="765" height="16"></td>
	</tr>
	<tr>
		<td height="10"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td valign="top">
						<table width="364" cellpadding="0" cellspacing="0" border="0">
							<tr height="30">
								<td style="padding: 0 0 0 10"><img src="../images/notice.gif"></td>
								<td align="right"><a href="http://webarty.com/mboard.asp?strBoardID=notice" target="_blank"><img src="../images/more.gif" border="0"></a></td>
							</tr>
							<tr><td colspan="2"><img src="../images/noticebox_top.gif"></td></tr>
							<tr height="103"><td background="../images/noticebox_bg.gif" colspan="2" style="padding-left:10; padding-top:10;"><iframe name="boardNotice" src="http://webarty.com/artyboard/boardNotice.asp" width="350" height="100" frameborder="0"></iframe></td></tr>
							<tr><td colspan="2"><img src="../images/noticebox_bottom.gif"></td></tr>
						</table>
					</td>
					<td width="38"></td>
					<td>
						<table width="364" cellpadding="0" cellspacing="0" border="0">
							<tr height="30">
								<td style="padding: 0 0 0 10"><img src="../images/newskin.gif"></td>
								<td align="right"><a href="http://webarty.com/mboard.asp?Action=list&strBoardID=ArtyBoard_skin" target="_blank"><img src="../images/more.gif" border="0"></a></td>
							</tr>
							<tr><td colspan="2"><img src="../images/noticebox_top.gif"></td></tr>
							<tr height="103"><td background="../images/noticebox_bg.gif" colspan="2" style="padding-left:10; padding-top:10;"><iframe name="boardSkin" src="http://webarty.com/artyboard/boardSkin.asp" width="350" height="100" frameborder="0"></iframe></td></tr>
							<tr><td colspan="2"><img src="../images/noticebox_bottom.gif"></td></tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><img src="../images/title_03.gif" width="765" height="17"></td>
	</tr>
	<tr>
		<td height="10"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top">
						<table width="364" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="30" style="padding-left:10;"><img src="../images/boardskin.gif" width="65" height="12"></td>
							</tr>
							<tr>
								<td>
									<table width="364" border="0" cellspacing="0" cellpadding="5" style="border:3 solid #489ae3" class="style1">
										<tr>
											<td width="120"  bgcolor="ebf3fa"> 일반게시판</td>
											<td class="style2"  align="right" style="padding-right:10"><%=GetFolderList(rootPath & "Skin\Board\Board\", "", "count")%>개</td>
											<td width="120"  bgcolor="ebf3fa"> 갤러리</td>
											<td class="style2"  align="right" style="padding-right:10"><%=GetFolderList(rootPath & "Skin\Board\Gallery\", "", "count")%>개</td>
										</tr>
										<tr>
											<td height="1" colspan="4" bgcolor="a5c8e7"></td>
										</tr>
										<tr>
											<td width="120"  bgcolor="ebf3fa"> 자료실</td>
											<td class="style2"  align="right" style="padding-right:10"><%=GetFolderList(rootPath & "Skin\Board\Pds\", "", "count")%>개</td>
											<td width="120"  bgcolor="ebf3fa"> 방명록</td>
											<td class="style2"  align="right" style="padding-right:10"><%=GetFolderList(rootPath & "Skin\Board\Guest\", "", "count")%>개</td>
										</tr>
										<tr>
											<td height="1" colspan="4" bgcolor="a5c8e7"></td>
										</tr>
										<tr>
											<td width="120"  bgcolor="ebf3fa"> 메모장</td>
											<td class="style2"  align="right" style="padding-right:10"><%=GetFolderList(rootPath & "Skin\Board\Memo\", "", "count")%>개</td>
											<td width="120"  bgcolor="ebf3fa"> 링크게시판</td>
											<td class="style2"  align="right" style="padding-right:10"><%=GetFolderList(rootPath & "Skin\Board\Link\", "", "count")%>개</td>
										</tr>
										<tr>
											<td height="1" colspan="4" bgcolor="a5c8e7"></td>
										</tr>
										<tr>
											<td width="120"  bgcolor="ebf3fa"> 일정/스케줄</td>
											<td class="style2"  align="right" style="padding-right:10"><%=GetFolderList(rootPath & "Skin\Board\Calendar\", "", "count")%>개</td>
											<td width="120"  bgcolor="ebf3fa"> 기타</td>
											<td class="style2"  align="right" style="padding-right:10"><%=GetFolderList(rootPath & "Skin\Board\Other\", "", "count")%>개</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td width="38">&nbsp;</td>
					<td valign="top">
						<table width="364" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="30" style="padding-left:10;"><img src="../images/boardinfo.gif" width="65" height="12"></td>
							</tr>
							<tr>
								<td>
									<table width="364" border="0" cellspacing="0" cellpadding="5" style="border:3 solid #489ae3" class="style1">
<%
	SET RS = DBCON.EXECUTE("SELECT [intNowBoard] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_CONFIG_DEFAULT]), [intTodayMakeBoard] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_CONFIG_DEFAULT] WHERE DATEDIFF(day, [dateRegDate], getdate()) = 0) ")
%>
										<tr>
											<td width="140" bgcolor="ebf3fa"> 현재 게시판 수</td>
											<td  align="right" class="style2" style="padding-right:10"><%=RS("intNowBoard")%>개</td>
											</tr>
										<tr>
											<td height="1" colspan="2" bgcolor="a5c8e7"></td>
										</tr>
										<tr>
											<td bgcolor="ebf3fa">오늘 생성된 게시판 수</td>
											<td  align="right" class="style2" style="padding-right:10"><%=RS("intTodayMakeBoard")%>개</td>
											</tr>
										<tr>
											<td height="1" colspan="2" bgcolor="a5c8e7"></td>
										</tr>
<%
	SET RS = DBCON.EXECUTE("SELECT [intTotalBoardCount] = (SELECT COUNT([intSeq]) FROM [MPLUS_BOARD] WHERE [bitDelete] = '0'), [intTodayBoardCount] = (SELECT COUNT([intSeq]) FROM [MPLUS_BOARD] WHERE [bitDelete] = '0' AND DATEDIFF(day, [dateRegDate], getdate()) = 0) ")
%>
										<tr>
											<td bgcolor="ebf3fa">전체 게시글 수</td>
											<td  align="right" class="style2" style="padding-right:10"><%=GetMoneyComma(RS("intTotalBoardCount"))%>개</td>
											</tr>
										<tr>
											<td height="1" colspan="2" bgcolor="a5c8e7"></td>
										</tr>
										<tr>
											<td bgcolor="ebf3fa">오늘 등록된 게시글 수</td>
											<td  align="right" class="style2" style="padding-right:10"><%=RS("intTodayBoardCount")%>개</td>
											</tr>
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
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top">
						<table width="364" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="30" style="padding-left:10;"><img src="../images/memberskin.gif" width="97" height="12"></td>
							</tr>
							<tr>
								<td>
									<table width="364" border="0" cellspacing="0" cellpadding="5" style="border:3 solid #489ae3" class="style1">
<%
	SET RS = DBCON.EXECUTE("SELECT [intNowBoard] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_CONFIG_DEFAULT]), [intTodayMakeBoard] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_CONFIG_DEFAULT] WHERE DATEDIFF(day, [dateRegDate], getdate()) = 0) ")
%>
										<tr>
											<td width="120"  bgcolor="ebf3fa">회원가입</td>
											<td class="style2"  align="right" style="padding-right:10"><%=GetFolderList(rootPath & "Skin\Member\Join\", "", "count")%>개</td>
											<td width="120"  bgcolor="ebf3fa"> 로그인 </td>
											<td class="style2"  align="right" style="padding-right:10"><%=GetFolderList(rootPath & "Skin\Member\Login\", "", "count")%>개</td>
										</tr>
										<tr>
											<td height="1" colspan="4" bgcolor="a5c8e7"></td>
										</tr>
										<tr>
											<td width="120"  bgcolor="ebf3fa">쪽지 및 메모</td>
											<td class="style2"  align="right" style="padding-right:10"><%=GetFolderList(rootPath & "Skin\Member\Memo\", "", "count")%>개</td>
											<td width="120"  bgcolor="ebf3fa">프로파일</td>
											<td class="style2"  align="right" style="padding-right:10"><%=GetFolderList(rootPath & "Skin\Member\Profile\", "", "count")%>개</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td width="38">&nbsp;</td>
					<td valign="top">
						<table width="364" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="30" style="padding-left:10;"><img src="../images/memberinfo.gif" width="56" height="12"></td>
							</tr>
							<tr>
								<td>
									<table width="364" border="0" cellspacing="0" cellpadding="5" style="border:3 solid #489ae3" class="style1">
<%
	SET RS = DBCON.EXECUTE("SELECT [intTotalMember] = (SELECT COUNT([intNum]) FROM [MPLUS_MEMBER_LIST] WHERE [strAdmin] != '2' AND [bitSecession] = '0'), [intTodayMember] = (SELECT COUNT([intNum]) FROM [MPLUS_MEMBER_LIST] WHERE DATEDIFF(day, [dateRegDate], getdate()) = 0) ") 
%>
										<tr>
											<td width="140" bgcolor="ebf3fa"> 전체 회원수</td>
											<td  align="right" class="style2" style="padding-right:10"><%=GetMoneyComma(RS("intTotalMember"))%>명</td>
											</tr>
										<tr>
											<td height="1" colspan="2" bgcolor="a5c8e7"></td>
										</tr>
										<tr>
											<td bgcolor="ebf3fa"> 오늘 가입한 회원수</td>
											<td  align="right" class="style2" style="padding-right:10"><%=RS("intTodayMember")%>개</td>
											</tr>
									</table>								</td>
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
	<tr>
		<td><img src="../images/title_04.gif"></td>
	</tr>
	<tr>
		<td height="10"></td>
	</tr>
	<tr>
		<td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top">
						<table width="364" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="30" style="padding-left:10;"><img src="../images/weeksite.gif"></td>
							</tr>
							<tr>
								<td>
									<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_STAT] '3', '" & nowYear & "-" & nowMonth & "-01', '" & nowYear & "-" & nowMonth & "-" & nowDay & "' ")

	Dim Total_Month, MaxCount
	Total_Month = RS("totalCount")
	MaxCount    = RS("intCount")
	RS.MOVENEXT

	Dim statCount(7), statPerc(7), statHeight(7)
	IF RS.EOF THEN
		DIM i
		FOR I = 0 TO 6
			statCount(i) = "0"
		NEXT
	ELSE
		WHILE NOT(RS.EOF)
			statCount(RS("strConnDate")) = RS("intCount")
			IF statCount(RS("strConnDate")) = 0 THEN
				statPerc(RS("strConnDate"))   = 0
				statHeight(RS("strConnDate")) = 1
			ELSE
				statPerc(RS("strConnDate")) = INT(statCount(RS("strConnDate")) / Total_Month * 100)
				statHeight(RS("strConnDate")) = INT(RS("intCount") / MaxCount * 60)
			END IF
		RS.MOVENEXT
		WEND
	END IF

	FOR I = 1 TO 7
		IF statCount(I) = "" AND statPerc(I) = "" THEN
		statCount(I) = 0
		statPerc(I)  = 0
		END IF
	NEXT
%>
										<tr align="center">
											<td width="14%" height="20" style="font-size:8pt"><%=GetMoneyComma(statCount(1))%> (<%=statPerc(1)%>%)</td>
											<td width="14%" height="20" style="font-size:8pt"><%=GetMoneyComma(statCount(2))%> (<%=statPerc(2)%>%)</td>
											<td width="14%" height="20" style="font-size:8pt"><%=GetMoneyComma(statCount(3))%> (<%=statPerc(3)%>%)</td>
											<td width="14%" height="20" style="font-size:8pt"><%=GetMoneyComma(statCount(4))%> (<%=statPerc(4)%>%)</td>
											<td width="14%" height="20" style="font-size:8pt"><%=GetMoneyComma(statCount(5))%> (<%=statPerc(5)%>%)</td>
											<td width="14%" height="20" style="font-size:8pt"><%=GetMoneyComma(statCount(6))%> (<%=statPerc(6)%>%)</td>
											<td width="14%" height="20" style="font-size:8pt"><%=GetMoneyComma(statCount(7))%> (<%=statPerc(7)%>%)</td>
										</tr>
										<tr align="center" valign="bottom">
											<td width="14%" height="85"><img src="../images/graph.gif" width="10" height="<%=statHeight(1)%>"></td>
											<td width="14%" height="85"><img src="../images/graph.gif" width="10" height="<%=statHeight(2)%>"></td>
											<td width="14%" height="85"><img src="../images/graph.gif" width="10" height="<%=statHeight(3)%>"></td>
											<td width="14%" height="85"><img src="../images/graph.gif" width="10" height="<%=statHeight(4)%>"></td>
											<td width="14%" height="85"><img src="../images/graph.gif" width="10" height="<%=statHeight(5)%>"></td>
											<td width="14%" height="85"><img src="../images/graph.gif" width="10" height="<%=statHeight(6)%>"></td>
											<td width="14%" height="85"><img src="../images/graph.gif" width="10" height="<%=statHeight(7)%>"></td>
										</tr>
										<tr bgcolor="#CCCCCC">
											<td height="1" colspan="7"></td>
										</tr>
										<tr align="center">
											<td width="14%" height="20"><span style="color: #b02832">일요일</span></td>
											<td width="14%" height="20"><span style="color: #b02832">월요일</span></td>
											<td width="14%" height="20"><span style="color: #b02832">화요일</span></td>
											<td width="14%" height="20"><span style="color: #b02832">수요일</span></td>
											<td width="14%" height="20"><span style="color: #b02832">목요일</span></td>
											<td width="14%" height="20"><span style="color: #b02832">금요일</span></td>
											<td width="14%" height="20"><span style="color: #b02832">토요일</span></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td width="38">&nbsp;</td>
					<td valign="top">
						<table width="364" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="30" style="padding-left:10;"><img src="../images/weekmember.gif"></td>
							</tr>
							<tr>
								<td>
									<table width="98%"  border="0" cellspacing="0" cellpadding="0">
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_STAT] '1','" & nowYear & "-" & nowMonth & "-" & nowDay & "' ")

	Total_Month = RS("stat_total")
	MaxCount    = RS("stat_count")
	RS.MOVENEXT

	FOR I = 1 TO 7
		statCount(I)  = ""
		statPerc(I)   = ""
		statHeight(I) = ""
	NEXT

	IF RS.EOF THEN
		FOR I = 1 TO 7
			statCount(i)  = 0
			statPerc(I)   = 0
			statHeight(I) = 0
		NEXT
	ELSE
		WHILE NOT(RS.EOF)
			statCount(RS("stat_index")) = RS("stat_count")
			IF statCount(RS("stat_index")) = 0 THEN
				statPerc(RS("stat_index"))   = 0
				statHeight(RS("stat_index")) = 1
			ELSE
				statPerc(RS("stat_index")) = INT(statCount(RS("stat_index")) / Total_Month * 100)
				statHeight(RS("stat_index")) = INT(RS("stat_count") / MaxCount * 60)
			END IF
		RS.MOVENEXT
		WEND
	END IF

	FOR I = 1 TO 7
		IF statCount(I) = "" AND statPerc(I) = "" THEN
		statCount(I) = 0
		statPerc(I)  = 0
		END IF
	NEXT
%>
										<tr align="center">
											<td width="14%" height="20" style="font-size:8pt"><%=statCount(1)%> (<%=statPerc(1)%>%)</td>
											<td width="14%" height="20" style="font-size:8pt"><%=statCount(2)%> (<%=statPerc(2)%>%)</td>
											<td width="14%" height="20" style="font-size:8pt"><%=statCount(3)%> (<%=statPerc(3)%>%)</td>
											<td width="14%" height="20" style="font-size:8pt"><%=statCount(4)%> (<%=statPerc(4)%>%)</td>
											<td width="14%" height="20" style="font-size:8pt"><%=statCount(5)%> (<%=statPerc(5)%>%)</td>
											<td width="14%" height="20" style="font-size:8pt"><%=statCount(6)%> (<%=statPerc(6)%>%)</td>
											<td width="14%" height="20" style="font-size:8pt"><%=statCount(7)%> (<%=statPerc(7)%>%)</td>
										</tr>
										<tr align="center" valign="bottom">
											<td width="14%" height="85"><img src="../images/graph.gif" width="10" height="<%=statHeight(1)%>"></td>
											<td width="14%" height="85"><img src="../images/graph.gif" width="10" height="<%=statHeight(2)%>" /></td>
											<td width="14%" height="85"><img src="../images/graph.gif" width="10" height="<%=statHeight(3)%>"></td>
											<td width="14%" height="85"><img src="../images/graph.gif" width="10" height="<%=statHeight(4)%>"></td>
											<td width="14%" height="85"><img src="../images/graph.gif" width="10" height="<%=statHeight(5)%>"></td>
											<td width="14%" height="85"><img src="../images/graph.gif" width="10" height="<%=statHeight(6)%>"></td>
											<td width="14%" height="85"><img src="../images/graph.gif" width="10" height="<%=statHeight(7)%>"></td>
										</tr>
										<tr bgcolor="#CCCCCC">
											<td height="1" colspan="7"></td>
										</tr>
										<tr align="center">
											<td width="14%" height="20"><span style="color: #b02832">일요일</span></td>
											<td width="14%" height="20"><span style="color: #b02832">월요일</span></td>
											<td width="14%" height="20"><span style="color: #b02832">화요일</span></td>
											<td width="14%" height="20"><span style="color: #b02832">수요일</span></td>
											<td width="14%" height="20"><span style="color: #b02832">목요일</span></td>
											<td width="14%" height="20"><span style="color: #b02832">금요일</span></td>
											<td width="14%" height="20"><span style="color: #b02832">토요일</span></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- #include file = "Foot.asp" -->