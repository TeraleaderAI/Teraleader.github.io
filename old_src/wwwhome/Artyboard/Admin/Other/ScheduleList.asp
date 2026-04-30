<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 7
	intLeftMenu  = 7
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<!-- #include file = "FunctionSchedule.asp" -->
<%
	DIM strScYear, strScMonth, strScDay, iNowDate, iNowYear, iNowMonth, iNowDay

	strScYear  = REQUEST.QueryString("strScYear")
	strScMonth = REQUEST.QueryString("strScMonth")
	strScDay   = REQUEST.QueryString("strScDay")

	IF strScYear  = "" THEN strScYear  = YEAR(NOW)
	IF strScMonth = "" THEN strScMonth = MONTH(NOW)
	IF strScDay   = "" THEN strScDay   = DAY(NOW)

	IF LEN(strScMonth) = 1 THEN strScMonth = "0" & strScMonth
	IF LEN(strScDay)   = 1 THEN strScDay   = "0" & strScDay
%>
<table width="750" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="35"><img src="../images/main_title56.gif" width="120" height="19"></td>
					<td align="right">관리자 홈 &gt; 기타관리 &gt; <b>관리자 일정관리</b></td>
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
					<td width="210" valign="top"><iframe name="calendar" src="ScheduleCalendar.asp?strScYear=<%=strScYear%>&strScMonth=<%=strScMonth%>&strScDay=<%=strScDay%>" width="210" height="210" frameborder="0" scrolling="no"></iframe></td>
					<td style="padding-left:10; padding-bottom:5;" valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="5"><img src="../images/box_topl.gif" width="5" height="5"></td>
								<td width="774" background="../images/box_topc.gif"></td>
								<td width="10"><img src="../images/box_topr.gif" width="5" height="5"></td>
							</tr>
							<tr>
								<td width="5" background="../images/box_middlel.gif"></td>
								<td style="padding:5 5 5 5">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="30" align="center" bgcolor="#F5F5F5"><b><%=strScYear%>년 <%=strScMonth%>월 <%=strScDay%>일</b></td>
										</tr>
<%
	SET RS = DBCON.EXECUTE("SELECT [intSeq], [intYear], [intMonth], [intDay], [intHour], [intMinute], [strSubject], [strContent], [strFileName1], [intFileSize1], [strFileName2], [intFileSize2], [strFileName3], [intFileSize3] FROM [MPLUS_SCHEDULE] WHERE [intYear] = '" & strScYear & "' AND [intMonth] = '" & strScMonth & "' AND [intDay] = '" & strScDay & "' ORDER BY [intYear], [intMonth], [intDay], [intHour], [intMinute] ASC ")

	IF RS.EOF THEN
%>
										<tr>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>
												<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#EFEFEF">
													<tr>
														<td bgcolor="#FFFFFF" style="padding:5 5 5 5" align="center">등록된 일정이 없습니다.</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF" height="1"></td>
										</tr>
										<tr>
											<td height="30" align="right"><a href="ScheduleAdd.asp?Action=add&strScYear=<%=strScYear%>&strScMonth=<%=strScMonth%>&strScDay=<%=strScDay%>"><img src="../images/btn_add_schedule_w.gif" width="68" height="19" border="0"></a></td>
										</tr>
<%
	ELSE
		WHILE NOT(RS.EOF)
%>
										<tr>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>
												<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#EFEFEF">
													<tr>
														<td bgcolor="#FFFFFF" style="padding:5 5 5 5">
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td height="30">
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td><img src="../images/iconc203.gif" width="15" height="15" align="absmiddle">&nbsp;<%=RS("strSubject")%></td>
																				<td align="right" style="font-size:11px"><%=RS("intYear")%>-<%=RS("intMonth")%>-<%=RS("intDay")%>&nbsp;<%=RS("intHour")%>:<%=RS("intMinute")%></td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr>
																	<td align="center">
																		<table width="99%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="1" bgcolor="#EFEFEF"></td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr>
																	<td style="padding-top:5; padding-bottom:5"><%=GetReplaceTag2Html(RS("strContent"))%></td>
																</tr>
																<tr>
																	<td height="30">
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
<% IF RS("strFileName1") <> "" AND ISNULL(RS("strFileName1")) = False THEN %>
																			<tr>
																				<td height="20"><img src="../images/icon_file.gif" width="13" height="12" align="absmiddle">&nbsp;<%=RS("strFileName1")%>&nbsp;(<%=GetFilesize(RS("intFileSize1"))%>)</td>
																			</tr>
<% END IF %>
<% IF RS("strFileName2") <> "" AND ISNULL(RS("strFileName2")) = False THEN %>
																			<tr>
																				<td height="20"><img src="../images/icon_file.gif" width="13" height="12" align="absmiddle">&nbsp;<%=RS("strFileName2")%>&nbsp;(<%=GetFilesize(RS("intFileSize2"))%>)</td>
																			</tr>
<% END IF %>
<% IF RS("strFileName3") <> "" AND ISNULL(RS("strFileName3")) = False THEN %>
																			<tr>
																				<td height="20"><img src="../images/icon_file.gif" width="13" height="12" align="absmiddle">&nbsp;<%=RS("strFileName3")%>&nbsp;(<%=GetFilesize(RS("intFileSize3"))%>)</td>
																			</tr>
<% END IF %>
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
											<td bgcolor="#EFEFEF" height="1"></td>
										</tr>
										<tr>
											<td height="30" align="right"><a href="ScheduleAdd.asp?Action=add&strScYear=<%=strScYear%>&strScMonth=<%=strScMonth%>&strScDay=<%=strScDay%>"><img src="../images/btn_add_schedule_s_w.gif" width="47" height="19" border="0" align="absmiddle"></a> <a href="ScheduleAdd.asp?Action=edit&intSeq=<%=RS("intSeq")%>"><img src="../images/btn_edit_schedule_w.gif" width="46" height="19" border="0" align="absmiddle"></a> <a href="javascript:;" onClick="OnRemove('<%=RS("intSeq")%>','<%=strScYear%>','<%=strScMonth%>','<%=strScDay%>');return false;"><img src="../images/btn_delete_schedule_w.gif" width="46" height="19" border="0" align="absmiddle"></a></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
									</table>
								</td>
								<td width="10" background="../images/box_middler.gif"></td>
							</tr>
							<tr>
								<td width="5"><img src="../images/box_bottoml.gif" width="5" height="5"></td>
								<td background="../images/box_bottomc.gif"></td>
								<td width="10"><img src="../images/box_bottomr.gif" width="5" height="5"></td>
							</tr>
						</table>
					</td>
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
					<LI>일정관리는 전체 관리자만 이용이 가능하며, 일정이 등록된 날짜는 진하게 표시 됩니다.</LI>
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

	function OnRemove(intSeq, strScYear, strScMonth, strScDay){

		if (confirm("선택한 일정정보를 삭제하시겠습니까?")){
			document.theForm.action = "Schedule_ok.asp?Action=remove&intSeq=" + intSeq + "&strScYear=" + strScYear + "&strScMonth=" + strScMonth + "&strScDay=" + strScDay;
			document.theForm.submit();
		}
	}

</script>
<!-- #include file = "Foot.asp" -->