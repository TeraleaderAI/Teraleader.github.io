<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 4
	intLeftMenu  = 14
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM intPage, intPageSize, intTotalRecCount, intPageCount
			
	intPage = REQUEST.QueryString("intPage") : IF intPage = "" THEN intPage = 1
	intPageSize = REQUEST.QueryString("intPageSize") : IF intPageSize = "" THEN intPageSize = 10
			
	SET RS = DBCON.EXECUTE("SELECT COUNT(intNum) AS RecCount FROM [MPLUS_MEMO_ADMIN_SEND] ")
				
	intTotalRecCount = RS(0)
	intPageCount = INT((intTotalRecCount - 1) / intPageSize) + 1
			
	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [intNum], [strGroup], [strMailingGroup], [strContent], [intMember], [intReadCount] = (SELECT COUNT([intNum]) FROM [MPLUS_MEMO] WHERE [intNumAdminSend] = [MPLUS_MEMO_ADMIN_SEND].[intNum] AND [bitRead] = '1'), [dateRegDate] FROM [MPLUS_MEMO_ADMIN_SEND] WHERE [intNum] NOT IN (SELECT TOP " & ((intPage - 1) * intPageSize) & " [intNum] FROM [MPLUS_MEMO_ADMIN_SEND] ORDER BY [intNum] DESC) ORDER BY [intNum] DESC ")
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title58.gif" width="113" height="19"></td>
                      <td align="right">관리자 홈 &gt; 회원관리 &gt; <b>일괄 쪽지 발송</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>발송된 쪽지 리스트</strong></span></td>
              </tr>
              <tr>
                <td>
									<table width="100%"  border="0" cellpadding="0" cellspacing="0">
										<tr align="center" bgcolor="EB766F">
											<td colspan="6" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td height="30" class="table_Txt1" nowrap>번호</td>
											<td height="30" class="table_Txt1" nowrap>발송된 그룹</td>
											<td height="30" class="table_Txt1" nowrap>발송된 메일링 그룹</td>
											<td class="table_Txt1" nowrap>발송건수 / 수신자</td>
											<td height="30" nowrap class="table_Txt1">발송일자</td>
											<td height="30" nowrap class="table_Txt1">삭제</td>
											</tr>
										<tr bgcolor="EB766F">
											<td colspan="6" class="table_Round1"></td>
										</tr>
<%
	IF RS.EOF THEN
%>
										<tr align="center" bgcolor="#FFFFFF">
											<td colspan="6" class="table_ListSubText1">등록된 일괄발송 쪽지 정보가 없습니다.</td>
										</tr>
										<tr>
											<td colspan="6" class="table_ListSubLine1"></td>
										</tr>
<%
	ELSE
		DIM iCount, intNumber
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intNumber = INT(intTotalRecCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1"><%=intNumber%></td>
											<td align="left" class="table_ListSubText1" style="padding-left:5;"><%=RS("strGroup")%></td>
											<td align="left" class="table_ListSubText1"><%=RS("strMailingGroup")%></td>
											<td class="table_ListSubText1"><%=RS("intMember")%> / <%=RS("intReadCount")%></td>
											<td class="table_ListSubText1"><%=REPLACE(FORMATDATETIME(RS("dateRegDate"), 2),"-","/")%></td>
											<td class="table_ListSubText1"><a href="javascript:;" onclick="OnRemove('<%=RS("intNum")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0"></a></td>
											</tr>
										<tr>
											<td colspan="6" class="table_ListSubLine1"></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
										<tr>
											<td colspan="6" height="1"></td>
										</tr>
										<tr>
											<td colspan="6" class="table_ListSubBLine1"></td>
										</tr>
								</table>								</td>
              </tr>
              <tr>
                <td height="40">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="86"><a href="MemberMemoAdd.asp"><img src="../images/btn_send_memo_m.gif" width="86" height="25" border="0"></a></td>
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
											<LI>일괄적으로 발송된 쪽지 리스트 내역을 확인 할 수 있습니다.</LI>
											<LI>일괄적으로 쪽지를 발송하려면 신규쪽지발송 버튼을 클릭해서 쪽지를 발송합니다.</LI>
											</td>
										</tr>
									</table>
									</fieldset>								</td>
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

	function OnRemove(intNum){
		if(confirm("선택한 발송 쪽지정보를 삭제하시겠습니까?")){
			document.theForm.action = "MemberMemo_ok.asp?Action=remove&intNum=" + intNum;
			document.theForm.submit();
		}
	}

	function OnPageMove(intPage){
		document.theForm.action = "MemberMemoList.asp?intPage=" + intPage;
		document.theForm.submit();
	}

</script>
<!-- #include file = "Foot.asp" -->