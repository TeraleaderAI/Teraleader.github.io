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
	DIM strScYear, strScMonth, strScDay, intHour, intMinute, Action, intSeq, I

	strScYear  = REQUEST.QueryString("strScYear")
	strScMonth = REQUEST.QueryString("strScMonth")
	strScDay   = REQUEST.QueryString("strScDay")

	Action     = UCASE(REQUEST.QueryString("Action"))
	intSeq     = REQUEST.QueryString("intSeq")

	DIM strSubject, strContent, strFileName1, strFileName2, strFileName3

	IF Action = "EDIT" THEN

		SET RS = DBCON.EXECUTE("SELECT [intYear], [intMonth], [intDay], [intHour], [intMinute], [strSubject], [strContent], [strFileName1], [strFileName2], [strFileName3] FROM [MPLUS_SCHEDULE] WHERE [intSeq] = '" & intSeq & "' ")

		strScYear    = RS("intYear")
		strScMonth   = RS("intMonth")
		strScDay     = RS("intDay")
		intHour      = RS("intHour")
		intMinute    = RS("intMinute")
		strSubject   = RS("strSubject")
		strContent   = GetReplaceTag2Editor(RS("strContent"))
		strFileName1 = RS("strFileName1")
		strFileName2 = RS("strFileName2")
		strFileName3 = RS("strFileName3")

	ELSE

		intHour      = HOUR(NOW)
		intMinute    = MINUTE(NOW)

		IF LEN(intHour)   = 1 THEN intHour   = "0" & intHour
		IF LEN(intMinute) = 1 THEN intMinute = "0" & intMinute

	END IF
%>
<script language="javascript">
	var SET_Editor_FilePath = "Pds/Schedule/Editor/";
</script>
<script type="text/javascript" language="javascript" src="../../Editor/cheditor.js"></script>
<script language="javascript">

	var myeditor = new cheditor("myeditor");

	myeditor.config.editorHeight = '300px';
	myeditor.config.editorWidth = '100%';
	myeditor.config.includeHostname = false;
	myeditor.config.editorBgcolor = "";
	myeditor.inputForm = 'strContent';

</script>
<table width="750" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="Schedule_ok.asp?Action=<%=Action%>&intSeq=<%=intSeq%>" onSubmit="return OnSubmitAction();" enctype="multipart/form-data">
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
								<td width="5"><img src="../images/box_topl.gif" width="5" height="5"></td>
								<td width="774" background="../images/box_topc.gif"></td>
								<td width="5"><img src="../images/box_topr.gif" width="5" height="5"></td>
							</tr>
							<tr>
								<td width="5" background="../images/box_middlel.gif"></td>
								<td style="padding:5 5 5 5">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="30" align="center" bgcolor="#F5F5F5"><b><% IF Action = "ADD" THEN %>신규일정 등록<% ELSE %>일정정보 수정<% END IF %></b></td>
										</tr>
										<tr>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>
												<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#EFEFEF">
													<tr>
														<td bgcolor="#FFFFFF" style="padding:5 5 5 5" align="center">
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td class="table_Left1">날짜선택</td>
																	<td class="table_Right1">
																	<select name="strScYear" id="strScYear">
<%
	FOR I = 2007 TO YEAR(NOW) + 1
		RESPONSe.WRITE "<option value='" & I & "'"
		IF INT(strScYear) = INT(I) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "년</option>" & vbcrlf
	NEXT
%>
																	</select>
																	<select name="strScMonth" id="strScMonth">
<%
	FOR I = 1 TO 12
		RESPONSe.WRITE "<option value='" & I & "'"
		IF INT(strScMonth) = INT(I) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "월</option>" & vbcrlf
	NEXT
%>
																	</select>
																	<select name="strScDay" id="strScDay">
<%
	FOR I = 1 TO 31
		RESPONSe.WRITE "<option value='" & I & "'"
		IF INT(strScDay) = INT(I) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "일</option>" & vbcrlf
	NEXT
%>
																	</select>
																	<select name="intHour" id="intHour">
<%
	FOR I = 0 TO 23
		RESPONSe.WRITE "<option value='" & I & "'"
		IF INT(intHour) = INT(I) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "시</option>" & vbcrlf
	NEXT
%>
																	</select>
																	<select name="intMinute" id="intMinute">
<%
	FOR I = 0 TO 59
		RESPONSe.WRITE "<option value='" & I & "'"
		IF INT(intMinute) = INT(I) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "분</option>" & vbcrlf
	NEXT
%>
																	</select>
																	</td>
																</tr>
																<tr>
																	<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
																</tr>
																<tr>
																	<td class="table_Left1">제목</td>
																	<td class="table_Right1"><input name="strSubject" type="text" id="strSubject" style="width:98%" value="<%=strSubject%>"></td>
																</tr>
																<tr>
																	<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
																</tr>
																<tr>
																	<td class="table_Left1">내용</td>
																	<td class="table_Right1">
																	<textarea id="strContent" name="strContent" style="display:none"><%=strContent%></textarea>
																	<script type="text/javascript" language="javascript">myeditor.run();</script>
																	</td>
																</tr>
																<tr>
																	<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
																</tr>
<% IF Action = "EDIT" AND strFileName1 <> "" AND ISNULL(strFileName1) = False THEN %>
																<tr>
																	<td class="table_Left1">등록파일 #1 </td>
																	<td class="table_Right1"><b><%=strFileName1%></b>&nbsp;의 파일이 등록되어 있습니다.&nbsp;<input type="checkbox" name="bitFileDelete1" id="bitFileDelete1" value="1" class="no_Line"><LABEL FOR="bitFileDelete1" style="cursor:hand">파일삭제</LABEL></td>
																</tr>
																<tr>
																	<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
																</tr>
<% END IF %>
																<tr>
																	<td class="table_Left1">첨부파일 #1</td>
																	<td class="table_Right1"><input name="strFilename1" type="file" id="strFilename1" size="60" /></td>
																</tr>
																<tr>
																	<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
																</tr>
<% IF Action = "EDIT" AND strFileName2 <> "" AND ISNULL(strFileName2) = False THEN %>
																<tr>
																	<td class="table_Left1">등록파일 #2 </td>
																	<td class="table_Right1"><b><%=strFileName2%></b>&nbsp;의 파일이 등록되어 있습니다.&nbsp;<input type="checkbox" name="bitFileDelete2" id="bitFileDelete2" value="1" class="no_Line"><LABEL FOR="bitFileDelete2" style="cursor:hand">파일삭제</LABEL></td>
																</tr>
																<tr>
																	<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
																</tr>
<% END IF %>
																<tr>
																	<td class="table_Left1">첨부파일 #2</td>
																	<td class="table_Right1"><input name="strFilename2" type="file" id="strFilename2" size="60" /></td>
																</tr>
																<tr>
																	<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
																</tr>
<% IF Action = "EDIT" AND strFileName3 <> "" AND ISNULL(strFileName3) = False THEN %>
																<tr>
																	<td class="table_Left1">등록파일 #3 </td>
																	<td class="table_Right1"><b><%=strFileName3%></b>&nbsp;의 파일이 등록되어 있습니다.&nbsp;<input type="checkbox" name="bitFileDelete3" id="bitFileDelete3" value="1" class="no_Line"><LABEL FOR="bitFileDelete3" style="cursor:hand">파일삭제</LABEL></td>
																</tr>
																<tr>
																	<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
																</tr>
<% END IF %>
																<tr>
																	<td class="table_Left1">첨부파일 #3</td>
																	<td class="table_Right1"><input name="strFilename3" type="file" id="strFilename3" size="60" /></td>
																</tr>
																<tr>
																	<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
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
											<td height="30" align="right"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
										</tr>
									</table>
								</td>
								<td width="5" background="../images/box_middler.gif"></td>
							</tr>
							<tr>
								<td width="5"><img src="../images/box_bottoml.gif" width="5" height="5"></td>
								<td background="../images/box_bottomc.gif"></td>
								<td width="5"><img src="../images/box_bottomr.gif" width="5" height="5"></td>
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
					<LI>일정관리에 대한 첨부파일은 3개까지만 등록이 가능합니다.</LI>
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

	function OnSubmitAction(){

		str = document.all['strSubject'];
		if (str.value == ""){alert("제목을 입력해 주시기 바랍니다.");str.focus();return false;}

		document.getElementById("strContent").value = myeditor.outputBodyHTML();

		if (document.getElementById("strContent").value == ""){
			alert("내용을 입력하여 주세요.");myeditor.editArea.focus();return false;
		}

	}

</script>
<!-- #include file = "Foot.asp" -->