<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 8
	intLeftMenu  = 1
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount, I
	intPage     = REQUEST("intPage")     : IF intPage = "" THEN intPage = 1
	intPageSize = REQUEST("intPageSize") : IF intPageSize = "" THEN intPageSize = 10

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_POPUP] '2', '', '', '', '' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_POPUP] '1', '" & intPage & "', '" & intPageSize & "', '', '' ")
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title44.gif" width="93" height="19"></td>
                      <td align="right">관리자 홈 &gt; 기타관리 &gt; <b>팝업창 관리</b></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>팝업창 정보</strong></span></td>
              </tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr align="center" bgcolor="EB766F">
											<td colspan="8" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td height="30" class="table_Txt1" nowrap>번호</td>
											<td class="table_Txt1" nowrap>제목</td>
											<td height="30" class="table_Txt1" nowrap>출력기간</td>
											<td height="30" class="table_Txt1" nowrap>등록일자</td>
											<td height="30" class="table_Txt1" nowrap>조회</td>
											<td class="table_Txt1" nowrap>상태</td>
											<td class="table_Txt1" nowrap>수정</td>
											<td height="30" nowrap class="table_Txt1">삭제</td>
											</tr>
										<tr bgcolor="EB766F">
											<td colspan="8" class="table_Round1"></td>
										</tr>
<%
	IF RS.EOF THEN
%>
										<tr align="center" bgcolor="#FFFFFF">
											<td colspan="8" class="table_ListSubText1">등록된 내역이 없습니다.</td>
										</tr>
										<tr>
											<td colspan="8" class="table_ListSubLine1"></td>
										</tr>
<%
	ELSE
		DIM iCount, intPopupNum
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intPopupNum = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1"><%=intPopupNum%></td>
											<td align="left" class="table_ListSubText1"><%=RS("strSubject")%></td>
											<td class="table_ListSubText1"><%=LEFT(RS("strStartDate"),4)%>/<%=MID(RS("strStartDate"),5,2)%>/<%=RIGHT(RS("strStartDate"),2)%>~<%=LEFT(RS("strEndDate"),4)%>/<%=MID(RS("strEndDate"),5,2)%>/<%=RIGHT(RS("strEndDate"),2)%></td>
											<td class="table_ListSubText1"><%=REPLACE(FORMATDATETIME(RS("dateRegDate"),2),"-","/")%></td>
											<td class="table_ListSubText1"><%=RS("intVisit")%></td>
											<td class="table_ListSubText1">
<%
	SELECT CASE RS("bitUsage")
	CASE True  : RESPONSE.WRITE "사용"
	CASE False : RESPONSE.WRITE "중지"
	END SELECT
%>
											</td>
											<td class="table_ListSubText1"><a href="PopupAdd.asp?Action=edit&intNum=<%=RS("intNum")%>"><img src="../images/btn_edit_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:;" onClick="OnRemove('<%=RS("intNum")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0"></a></td>
											</tr>
										<tr>
											<td colspan="8" class="table_ListSubLine1"></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
										<tr>
											<td colspan="8" height="1"></td>
										</tr>
										<tr>
											<td colspan="8" class="table_ListSubBLine1"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td height="40">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="95"><a href="PopupAdd.asp?Action=add"><img src="../images/btn_add_popup_m.gif" width="95" height="25" border="0"></a></td>
											<td align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
											<td width="95" align="center"><a href="javascript:popupLayer('PopupSample.asp',600,280);"><img src="../images/btn_popup_source_view_m.gif" width="95" height="25" border="0"></a></td>
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
											<LI>등록된 팝업창을 웹사이트에서 출력하시려면 메인 페이지에 아래 코드를 삽입하시면 됩니다.</LI>
											<LI>&lt;!-- #include file = "<%=REPLACE(httpPath, "http://" & Request.ServerVariables("SERVER_NAME") & "/", "")%>Library/popup.asp" --&gt;</LI>
											<LI>레이어 팝업을 사용하실 경우 위의 인클루드 파일을 &lt;body&gt안에 삽입하셔야 합니다.</LI>
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

	function OnPageMove(intPage){
		document.theForm.action = "PopupList.asp?intPage=" + intPage;
		document.theForm.submit();
	}

	function OnRemove(intNum){
		if (confirm("선택된 팝업창 정보를 삭제하시겠습니까?")){
			document.theForm.action = "Popup_ok.asp?Action=remove&intNum=" + intNum;
			document.theForm.submit();
		}
	}

</script>
<!-- #include file = "Foot.asp" -->