<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 8
	intLeftMenu  = 4
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount, I
	intPage     = REQUEST("intPage")     : IF intPage = "" THEN intPage = 1
	intPageSize = REQUEST("intPageSize") : IF intPageSize = "" THEN intPageSize = 10

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_POLL] '0', '', '" & intPage & "', '" & intPageSize & "' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_POLL] '1', '', '" & intPage & "', '" & intPageSize & "' ")
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title47.gif" width="121" height="19"></td>
                      <td align="right">관리자 홈 &gt; 기타관리 &gt; <b>설문조사 리스트</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>설문조사 정보</strong></span></td>
              </tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr align="center" bgcolor="EB766F">
											<td colspan="11" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td width="45" height="30" nowrap class="table_Txt1">번호</td>
											<td height="30" nowrap class="table_Txt1">설문제목</td>
										  <td width="45" height="30" nowrap class="table_Txt1">항목</td>
											<td width="45" height="30" nowrap class="table_Txt1">참여</td>
											<td width="50" nowrap class="table_Txt1">상태</td>
											<td width="70" nowrap class="table_Txt1">등록일자</td>
											<td width="45" nowrap class="table_Txt1">결과</td>
											<td width="45" nowrap class="table_Txt1">링크</td>
											<td width="45" nowrap class="table_Txt1">항목</td>
											<td width="45" nowrap class="table_Txt1">수정</td>
											<td width="45" height="30" nowrap class="table_Txt1">삭제</td>
											</tr>
										<tr bgcolor="EB766F">
											<td colspan="11" class="table_Round1"></td>
										</tr>
<%
	IF RS.EOF THEN
%>
										<tr align="center" bgcolor="#FFFFFF">
											<td colspan="11" class="table_ListSubText1">등록된 내역이 없습니다.</td>
										</tr>
										<tr>
											<td colspan="11" class="table_ListSubLine1"></td>
										</tr>
<%
	ELSE

		DIM iCount, intPollNum, intNowDate

		intNowDate     = YEAR(NOW)
		IF LEN(MONTH(NOW)) = 1 THEN intNowDate = intNowDate & "0"
		intNowDate     = intNowDate & MONTH(NOW)
		IF LEN(DAY(NOW)) = 1 THEN intNowDate = intNowDate & "0"
		intNowDate     = intNowDate & DAY(NOW)
		IF LEN(HOUR(NOW)) = 1 THEN intNowDate = intNowDate & "0"
		intNowDate     = intNowDate & HOUR(NOW)
		IF LEN(MINUTE(NOW)) = 1 THEN intNowDate = intNowDate & "0"
		intNowDate     = intNowDate & MINUTE(NOW)

		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intPollNum = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1

			IF (INT(RS("strStartDate")) < INT(intNowDate) OR INT(RS("strStartDate")) = INT(intNowDate)) AND (INT(RS("strEndDate")) > INT(intNowDate) OR INT(RS("strEndDate")) = INT(intNowDate)) THEN strState = "진행중" ELSE strState = "마감"
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td align="center" class="table_ListSubText1"><%=intPollNum%></td>
											<td align="left" class="table_ListSubText1"><%=GetCutSubject(RS("strSubject"), 34)%></td>
											<td align="center" class="table_ListSubText1"><%=RS("intItemCount")%></td>
											<td align="center" class="table_ListSubText1"><%=RS("intVoteCount")%></td>
											<td align="center" class="table_ListSubText1"><%=strState%></td>
											<td align="center" class="table_ListSubText1"><%=REPLACE(FORMATDATETIME(RS("dateRegDate"), 2), "-", "/")%></td>
											<td align="center" class="table_ListSubText1"><a href="javascript:popupLayer('PollResult.asp?intNum=<%=RS("intNum")%>',800,500);"><img src="../images/btn_view_s.gif" width="38" height="16" border="0"></a></td>
											<td align="center" class="table_ListSubText1"><a href="javascript:popupLayer('PollLink.asp?strPollCode=<%=RS("strPollCode")%>',700,200);"><img src="../images/btn_view_s.gif" width="38" height="16" border="0"></a></td>
											<td align="center" class="table_ListSubText1"><a href="javascript:popupLayer('PollItemList.asp?strPollCode=<%=RS("strPollCode")%>',800,580);"><img src="../images/btn_setup_s.gif" width="38" height="16" border="0"></a></td>
											<td align="center" class="table_ListSubText1"><a href="PollAdd.asp?Action=EDIT&strPollCode=<%=RS("strPollCode")%>"><img src="../images/btn_edit_s.gif" width="38" height="16" border="0"></a></td>
											<td align="center" class="table_ListSubText1"><a href="javascript:;" onClick="OnRemove('<%=RS("strPollCode")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0"></a></td>
											</tr>
										<tr>
											<td colspan="11" class="table_ListSubLine1"></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
										<tr>
											<td colspan="11" height="1"></td>
										</tr>
										<tr>
											<td colspan="11" class="table_ListSubBLine1"></td>
										</tr>
									</table>
				  </td>
              </tr>
              <tr>
                <td height="40">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="86"><a href="PollAdd.asp?Action=add"><img src="../images/btn_new_poll_m.gif" width="86" height="25" border="0"></a></td>
											<td align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
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
											<LI>설문조사를 등록하거나 수정하실 수 있으며, 설문조사의 등록 개수는 제한이 없습니다.</LI>
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

	function OnRemove(str){
		if(confirm("설문조사를 삭제하시면 복구가 불가능합니다.\n\n설문조사를 삭제하시겠습니까?")){
			document.theForm.action = "poll_ok.asp?Action=REMOVE&strPollCode=" + str;
			document.theForm.submit();
		}
	}

	function OnPageMove(intPage){
		document.theForm.action = "PollList.asp?intPage=" + intPage;
		document.theForm.submit();
	}

</script>
<!-- #include file = "Foot.asp" -->