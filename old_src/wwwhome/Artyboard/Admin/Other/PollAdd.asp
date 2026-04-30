<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 8
	intLeftMenu  = 4
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM Action
	Action = UCASE(REQUEST.QueryString("Action"))
	IF Action = "" THEN Action = "ADD"

	DIM strGroupCode, strGroupNamem, intLevel
	DIM strPollCode, strSubject, strMemo, bitMember, strReadLevel, strWriteLevel, bitPollPK, intTimePK
	DIM strStartDate, strEndDate, bitResultWindow, intResultWidth, intResultHeight, bitComment, bitCommentMember, dateRegDate

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_GROUP] ")

	WHILE NOT(RS.EOF)

		IF strGroupCode <> "" THEN strGroupCode = strGroupCode & "$$$"
		IF strGroupName <> "" THEN strGroupName = strGroupName & "$$$"
		IF intLevel     <> "" THEN intLevel     = intLevel & "$$$"

		strGroupCode = strGroupCode & RS("strGroupCode")
		strGroupName = strGroupName & RS("strGroupName")
		intLevel     = intLevel     & RS("intLevel")

	RS.MOVENEXT
	WEND

	strGroupCode = SPLIT(strGroupCode, "$$$")
	strGroupName = SPLIT(strGroupName, "$$$")
	intLevel     = SPLIT(intLevel, "$$$")

	IF Action = "ADD" THEN

		bitMember    = False
		bitPollPK    = True
		intTimePK    = "24"
		strStartDate = YEAR(NOW)
		strEndDate   = YEAR(DATEADD("m", 1, NOW))

		IF LEN(MONTH(NOW)) = 1 THEN strStartDate = strStartDate & "0" & MONTH(NOW) ELSE strStartDate = strStartDate & MONTH(NOW)
		IF LEN(DAY(NOW)) = 1 THEN strStartDate = strStartDate & "0" & DAY(NOW) ELSE strStartDate = strStartDate & DAY(NOW)
		IF LEN(MONTH(DATEADD("m", 1, NOW))) = 1 THEN strEndDate   = strEndDate   & "0" & MONTH(DATEADD("m", 1, NOW)) ELSE strEndDate   = strEndDate   & MONTH(DATEADD("m", 1, NOW))
		IF LEN(DAY(DATEADD("m", 1, NOW))) = 1 THEN strEndDate   = strEndDate   & "0" & DAY(DATEADD("m", 1, NOW)) ELSE strEndDate   = strEndDate   & DAY(DATEADD("m", 1, NOW))

		strStartDate = strStartDate & "0000"
		strEndDate   = strEndDate   & "0000"

		bitResultWindow = False
		intResultWidth  = 500
		intResultHeight = 600
		bitComment      = True
		bitCommentMember = False

	ELSE

		strPollCode = REQUEST.QueryString("strPollCode")
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_POLL] '2', '" & strPollCode & "', '', '' ")

		strSubject       = RS("strSubject")
		strMemo          = RS("strMemo")
		bitMember        = RS("bitMember")
		strReadLevel     = RS("strReadLevel")
		strWriteLevel    = RS("strWriteLevel")
		bitPollPK        = RS("bitPollPK")
		intTimePK        = RS("intTimePK")
		strStartDate     = RS("strStartDate")
		strEndDate       = RS("strEndDate")
		bitResultWindow  = RS("bitResultWindow")
		intResultWidth   = RS("intResultWidth")
		intResultHeight  = RS("intResultHeight")
		bitComment       = RS("bitComment")
		bitCommentMember = RS("bitCommentMember")
		dateRegDate      = RS("dateRegDate")

	END IF
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" action="poll_ok.asp?Action=<%=Action%>&strPollCode=<%=strPollCode%>" onSubmit="return OnSubmitAction();">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title48.gif" width="140" height="19"></td>
                      <td align="right">관리자 홈 &gt; 기타관리 &gt; <b>설문조사 등록/수정</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong><% IF Action = "ADD" THEN %>신규 설문조사 등록<% ELSE %>설문조사 정보수정<% END IF %></strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">설문조사 제목</td>
											<td class="table_Right1"><input name="strSubject" type="text" id="strSubject" style="width:100%" value="<%=strSubject%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">설문조사 설명(메모)</td>
											<td class="table_Right1"><input name="strMemo" type="text" id="strMemo" style="width:100%" value="<%=strMemo%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">회원전용</td>
											<td class="table_Right1"><input type="radio" name="bitMember" id="bitMember1" value="1"<% IF bitMember = True THEN %> CHECKED<% END IF %> class="no_Line" onClick="OnPollGroup();"><LABEL FOR="bitMember1" style="cursor:hand">회원만 참여가능</LABEL>
											<input type="radio" name="bitMember" id="bitMember2" value="0"<% IF bitMember = False THEN %> CHECKED<% END IF %> class="no_Line" onClick="OnPollGroup();"><LABEL FOR="bitMember2" style="cursor:hand">비회원 참여가능</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr id="pollGroup" style="display:<% IF bitMember = True THEN %>block<% ELSE %>none<% END IF %>">
											<td class="table_Left1">회원권한</td>
											<td class="table_Right1">
											결과보기권한 :
											<select name="strReadLevel" id="strReadLevel">
<%
	FOR I = 0 TO UBOUND(strGroupCode)
		RESPONSE.WRITE "											<option value=""" & strGroupCode(I) & """"
		IF strReadLevel = strGroupCode(I) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & strGroupName(I) & " [Lv." & intLevel(I) & "]</option>" & vbcrlf
	NEXT
%>
											</select>
											설문참여권한 :
											<select name="strWriteLevel" id="strWriteLevel">
<%
	FOR I = 0 TO UBOUND(strGroupCode)
		RESPONSE.WRITE "											<option value=""" & strGroupCode(I) & """"
		IF strWriteLevel = strGroupCode(I) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & strGroupName(I) & " [Lv." & intLevel(I) & "]</option>" & vbcrlf
	NEXT
%>
											</select>
											</td>
										</tr>
										<tr id="pollGroup" style="display:<% IF bitMember = True THEN %>block<% ELSE %>none<% END IF %>">
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">중복참여</td>
											<td class="table_Right1"><input type="radio" name="bitPollPK" id="bitPollPK1" value="0" onClick="OnPollPK();"<% IF bitPollPK = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitPollPK1" style="cursor:hand">중복참여 가능</LABEL>
											<input type="radio" name="bitPollPK" id="bitPollPK2" value="1" onClick="OnPollPK();"<% IF bitPollPK = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitPollPK2" style="cursor:hand">중복참여 불가</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr id="tr_bitPollPK" style="display:<% IF bitPollPK = True THEN %>none<% ELSE %>block<% END IF %>">
											<td class="table_Left1">중복참여 제한</td>
											<td class="table_Right1"><input type="radio" name="intTimePK" id="intTimePK1" value="1"<% IF intTimePK = "1" THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="intTimePK1" style="cursor:hand">1시간 간격</LABEL>
											<input type="radio" name="intTimePK" id="intTimePK2" value="24"<% IF intTimePK = "24" THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="intTimePK2" style="cursor:hand">1일간격</LABEL>
											<input type="radio" name="intTimePK" id="intTimePK3" value="168"<% IF intTimePK = "168" THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="intTimePK3" style="cursor:hand">1주일간격</LABEL>
											<input type="radio" name="intTimePK" id="intTimePK4" value="720"<% IF intTimePK = "720" THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="intTimePK4" style="cursor:hand">1개월간격</LABEL></td>
										</tr>
										<tr id="tr_bitPollPK" style="display:<% IF bitPollPK = True THEN %>none<% ELSE %>block<% END IF %>">
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">시작일자 / 종료일자</td>
											<td class="table_Right1">
                      <select name="strStartDate" id="strStartDate">
<%
	FOR I = 2001 TO YEAR(NOW) + 1
		RESPONSE.WRITE "<option value='" & I & "'"
		IF INT(I) = INT(LEFT(strStartDate, 4)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">" & I & "년</option>" & vbcrlf
	NEXT
%>
											</select>
											<select name="strStartDate" id="strStartDate">
<%
	FOR I = 1 TO 12
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I & "'" ELSE RESPONSE.WRITE I & "'"
		IF INT(I) = INT(MID(strStartDate, 5, 2)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I ELSE RESPONSE.WRITE I
		RESPONSE.WRITE "월</option>" & vbcrlf
	NEXT
%>
											</select>
											<select name="strStartDate" id="strStartDate">
<%
	FOR I = 1 TO 31
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I & "'" ELSE RESPONSE.WRITE I & "'"
		IF INT(I) = INT(MID(strStartDate, 7, 2)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I ELSE RESPONSE.WRITE I
		RESPONSE.WRITE "일</option>" & vbcrlf
	NEXT
%>
											</select>
											<select name="strStartDate" id="strStartDate">
<%
	FOR I = 0 TO 23
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I & "'" ELSE RESPONSE.WRITE I & "'"
		IF INT(I) = INT(MID(strStartDate, 9, 2)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I ELSE RESPONSE.WRITE I
		RESPONSE.WRITE "시</option>" & vbcrlf
	NEXT
%>
											</select>
											<select name="strStartDate" id="strStartDate">
<%
	FOR I = 0 TO 59
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I & "'" ELSE RESPONSE.WRITE I & "'"
		IF INT(I) = INT(RIGHT(strStartDate, 2)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I ELSE RESPONSE.WRITE I
		RESPONSE.WRITE "분</option>" & vbcrlf
	NEXT
%>
											</select> ~
											<select name="strEndDate" id="strEndDate">
<%
	FOR I = 2001 TO YEAR(NOW) + 1
		RESPONSE.WRITE "<option value='" & I & "'"
		IF INT(I) = INT(LEFT(strEndDate, 4)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">" & I & "년</option>" & vbcrlf
	NEXT
%>
											</select>
											<select name="strEndDate" id="strEndDate">
<%
	FOR I = 1 TO 12
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I & "'" ELSE RESPONSE.WRITE I & "'"
		IF INT(I) = INT(MID(strEndDate, 5, 2)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I ELSE RESPONSE.WRITE I
		RESPONSE.WRITE "월</option>" & vbcrlf
	NEXT
%>
											</select>
											<select name="strEndDate" id="strEndDate">
<%
	FOR I = 1 TO 31
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I & "'" ELSE RESPONSE.WRITE I & "'"
		IF INT(I) = INT(MID(strEndDate, 7, 2)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I ELSE RESPONSE.WRITE I
		RESPONSE.WRITE "일</option>" & vbcrlf
	NEXT
%>
											</select>
											<select name="strEndDate" id="strEndDate">
<%
	FOR I = 0 TO 23
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I & "'" ELSE RESPONSE.WRITE I & "'"
		IF INT(I) = INT(MID(strEndDate, 9, 2)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I ELSE RESPONSE.WRITE I
		RESPONSE.WRITE "시</option>" & vbcrlf
	NEXT
%>
											</select>
											<select name="strEndDate" id="strEndDate">
<%
	FOR I = 0 TO 59
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I & "'" ELSE RESPONSE.WRITE I & "'"
		IF INT(I) = INT(RIGHT(strEndDate, 2)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I ELSE RESPONSE.WRITE I
		RESPONSE.WRITE "분</option>" & vbcrlf
	NEXT
%>
											</select>
                      </td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">결과 페이지</td>
											<td class="table_Right1"><input type="radio" name="bitResultWindow" id="bitResultWindow1" value="1" onClick="OnResult();"<% IF bitResultWindow = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitResultWindow1" style="cursor:hand">새창으로 출력</LABEL>
											<input type="radio" name="bitResultWindow" id="bitResultWindow2" value="0" onClick="OnResult();"<% IF bitResultWindow = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitResultWindow2" style="cursor:hand">현재창으로 출력</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr id="tr_bitResultWindow" style="display:<% IF bitResultWindow = True THEN %>block<% ELSE %>none<% END IF %>">
											<td class="table_Left1">결과페이지 윈도우</td>
											<td class="table_Right1">가로 : <input name="intResultWidth" type="text" id="intResultWidth" onBlur="onlynum(this, 1);" value="<%=intResultWidth%>" size="6" maxlength="4"> px / 세로 : <input name="intResultHeight" type="text" id="intResultHeight" onBlur="onlynum(this, 1);" value="<%=intResultHeight%>" size="6" maxlength="4"> px</td>
										</tr>
										<tr id="tr_bitResultWindow" style="display:<% IF bitResultWindow = True THEN %>block<% ELSE %>none<% END IF %>">
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">댓글 기능</td>
											<td class="table_Right1"><input type="radio" name="bitComment" id="bitComment1" value="1"<% IF bitComment = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitComment1" style="cursor:hand">댓글 기능 사용</LABEL>
											<input type="radio" name="bitComment" id="bitComment2" value="0"<% IF bitComment = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitComment2" style="cursor:hand">댓글 기능 사용안함</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">댓글 등록 권한</td>
											<td class="table_Right1"><input type="radio" name="bitCommentMember" id="bitCommentMember1" value="1"<% IF bitCommentMember = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitCommentMember1" style="cursor:hand">회원전용</LABEL>
											<input type="radio" name="bitCommentMember" id="bitCommentMember2" value="0"<% IF bitCommentMember = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitCommentMember2" style="cursor:hand">비회원 가능</LABEL>
						</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							<tr>
								<td align="right" style="padding-right:20;"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
							</tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>설문조사의 종료일자가 지나면, 자동적으로 설문조사가 종료 처리 됩니다.</LI>
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
	var SET_Action = "<%=Action%>";

	function OnPollPK(){
		if (document.all['bitPollPK'][0].checked == true){
			document.all['tr_bitPollPK'][0].style.display = "block";
			document.all['tr_bitPollPK'][1].style.display = "block";
		}else{
			document.all['tr_bitPollPK'][0].style.display = "none";
			document.all['tr_bitPollPK'][1].style.display = "none";
		}
	}

	function OnResult(){
		if (document.all['bitResultWindow'][0].checked == true){
			document.all['tr_bitResultWindow'][0].style.display = "block";
			document.all['tr_bitResultWindow'][1].style.display = "block";
		}else{
			document.all['tr_bitResultWindow'][0].style.display = "none";
			document.all['tr_bitResultWindow'][1].style.display = "none";
		}
	}

	function OnSubmitAction(){

		str = document.all['strSubject'];
		if (str.value == ""){alert("설문조사 제목을 입력해 주시기 바랍니다.");str.focus();return false;}

		var str1 = (document.all['strStartDate'][0].value + document.all['strStartDate'][1].value + document.all['strStartDate'][2].value) * 1;
		var str2 = (document.all['strEndDate'][0].value + document.all['strEndDate'][1].value + document.all['strEndDate'][2].value) * 1;

		if (document.all['bitMember'][0].checked == true){

			str = document.all['strReadLevel'];
			if (str.value == ""){alert("결과보기 권한을 설정해 주시기 바랍니다.");str.focus();return false;}

			str = document.all['strWriteLevel'];
			if (str.value == ""){alert("참여하기 권한을 설정해 주시기 바랍니다.");str.focus();return false;}

		}

		if (str1 > str2){alert("시작일자가 종료일자보다 큽니다.");document.all['strStartDate'][0].focus();return false;}

		if (document.all['bitResultWindow'][0].checked == true){
			str = document.all['intResultWidth'];
			if (str.value == ""){alert("결과페이지 윈도우 가로너비를 입력해 주시기 바랍니다.");str.focus();return false;}
			str = document.all['intResultHeight'];
			if (str.value == ""){alert("결과페이지 윈도우 세로너비를 입력해 주시기 바랍니다.");str.focus();return false;}
		}

	}
	
	function OnPollGroup(){

		if (document.all['bitMember'][0].checked == true){
			document.all['pollGroup'][0].style.display = "block";
			document.all['pollGroup'][1].style.display = "block";
		}else{
			document.all['pollGroup'][0].style.display = "none";
			document.all['pollGroup'][1].style.display = "none";
		}

	}
	
</script>
<!-- #include file = "Foot.asp" -->