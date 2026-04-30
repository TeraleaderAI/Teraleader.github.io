<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 6
	intLeftMenu  = 4
	isAdminMenu  = 1
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount, Query1, Query2, I
	intPage     = REQUEST("intPage")     : IF intPage = "" THEN intPage = 1
	intPageSize = REQUEST("intPageSize") : IF intPageSize = "" THEN intPageSize = 10

	IF SESSION("strAdmin") = "1" THEN
		SET RS = DBCON.EXECUTE("SELECT [strBoardID], [strAdmin] FROM [MPLUS_BOARD_CONFIG_DEFAULT] ")
		IF RS.EOF THEN
			Query1 = " WHERE [strBoardID] = '' "
			Query2 = " AND [strBoardID] = '' "
		ELSE
			Query1 = ""
			Query2 = ""
			WHILE NOT(RS.EOF)
				IF RS("strAdmin") <> "" AND ISNULL(RS("strAdmin")) = False THEN
					SplitStrAdmin = SPLIT(RS("strAdmin"), "|")
					FOR I = 0 TO UBOUND(SplitStrAdmin)
						IF SplitStrAdmin(I) = SESSION("strLoginID") THEN
							Query1 = Query1 & RS("strBoardID") & ","
							Query2 = Query2 & RS("strBoardID") & ","
						END IF
					NEXT
				END IF
			RS.MOVENEXT
			WEND
			IF Query1 <> "" THEN Query1 = " WHERE [strBoardID] IN (" & getSplitQuery(Query1) & ") "
			IF Query2 <> "" THEN Query2 = " AND [strBoardID] IN (" & getSplitQuery(Query2) & ") "
		END IF
	ELSE
		Query1 = ""
		Query2 = ""
	END IF

	SET RS = DBCON.EXECUTE("SELECT COUNT([intNum]) AS [RecCount] FROM [MPLUS_BOARD_BAD] " & Query1)

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [intNum], [strLoginID], [strBoardID], [intSeq], [strContent], [dateRegDate], [strWriteID] = (SELECT [strLoginID] FROM [MPLUS_BOARD] WHERE [intSeq] = [MPLUS_BOARD_BAD].[intSeq]), [strSubject] = (SELECT [strSubject] FROM [MPLUS_BOARD] WHERE [intSeq] = [MPLUS_BOARD_BAD].[intSeq]) FROM [MPLUS_BOARD_BAD] WHERE [intNum] NOT IN (SELECT TOP " & (intPage - 1) * intPageSize & " [intNum] FROM [MPLUS_BOARD_BAD] " & Query1 & " ORDER BY [intNum] DESC) " & Query2 & " ORDER BY [intNum] DESC ")
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title39.gif" width="171" height="19"></td>
                      <td align="right">관리자 홈 &gt; 게시판관리 &gt; <b>불량 게시글 신고 리스트</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>불량 게시글 신고내역</strong></span></td>
              </tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr align="center" bgcolor="EB766F">
											<td colspan="12" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
										  <td class="table_Txt1" nowrap>선택</td>
											<td height="30" class="table_Txt1" nowrap>번호</td>
											<td height="30" class="table_Txt1" nowrap>게시판 ID </td>
											<td height="30" class="table_Txt1" nowrap>글번호</td>
											<td height="30" class="table_Txt1" nowrap>등록자</td>
											<td class="table_Txt1" nowrap>신고자</td>
											<td class="table_Txt1" nowrap>글제목</td>
											<td class="table_Txt1" nowrap>신고일자</td>
											<td width="45" height="30" nowrap class="table_Txt1">사유</td>
											<td width="45" nowrap class="table_Txt1">보기</td>
											<td width="45" nowrap class="table_Txt1">등록</td>
											<td width="45" align="center" class="table_Txt1" nowrap>삭제</td>
										</tr>
										<tr bgcolor="EB766F">
											<td colspan="12" class="table_Round1"></td>
										</tr>
<%
	IF RS.EOF THEN
%>
										<tr align="center" bgcolor="#FFFFFF">
											<td colspan="12" class="table_ListSubText1">등록된 내역이 없습니다.</td>
										</tr>
										<tr>
											<td colspan="12" class="table_ListSubLine1"></td>
										</tr>
<%
	ELSE
		DIM iCount, intBoardNum
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intBoardNum = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
										<tr bgcolor="#FFFFFF" align="center">
										  <td class="table_ListSubText1"><input name="intSeq" type="checkbox" id="intSeq" value="<%=RS("intSeq")%>" class="no_Line"></td>
											<td class="table_ListSubText1"><%=intBoardNum%></td>
											<td class="table_ListSubText1"><a href="../../Mboard.asp?strBoardID=<%=RS("strBoardID")%>" target="_blank"><b><font color="#C6325B"><%=RS("strBoardID")%></font></b></a></td>
											<td class="table_ListSubText1"><%=RS("intSeq")%></td>
											<td class="table_ListSubText1"><%=RS("strWriteID")%></td>
											<td class="table_ListSubText1"><%=RS("strLoginID")%></td>
											<td class="table_ListSubText1" align="left"><%=RS("strSubject")%></td>
											<td class="table_ListSubText1"><%=GetDateType(0, RS("dateRegDate"))%></td>
											<td class="table_ListSubText1"><a href="javascript:;" onClick="OnBoardInfo('<%=intBoardNum%>');return false;"><img src="../images/btn_view_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="../../Mboard.asp?Action=view&amp;strBoardID=<%=RS("strBoardID")%>&amp;intSeq=<%=RS("intSeq")%>" target="_blank"><img src="../images/btn_view_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:;" onclick="OnBad('<%=RS("intSeq")%>');return false;"><img src="../images/btn_add2_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:;" onclick="OnRemove('<%=RS("intSeq")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0"></a></td>
										</tr>
										<tr>
											<td colspan="12" class="table_ListSubLine1"></td>
										</tr>
										<tr bgcolor="#FFFFFF" align="center" id="strBoardList<%=intBoardNum%>" style="display:none">
										  <td colspan="12" align="left" class="table_ListSubText1" style="padding-left:5; padding-top:5; padding-bottom:5;"><%=RS("strContent")%></td>
											</tr>
										<tr id="strBoardList<%=intBoardNum%>" style="display:none">
											<td colspan="12" class="table_ListSubLine1"></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
										<tr>
											<td colspan="12" height="1"></td>
										</tr>
										<tr>
											<td colspan="12" class="table_ListSubBLine1"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td height="40">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
											<a href="javascript:;" onClick="OnSelectAll();return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0"></a>
											<a href="javascript:;" onClick="OnSelectBad();return false;"><img src="../images/btn_select_add_bad_w.gif" width="147" height="19" border="0"></a> </td>
											<td align="right"><a href="javascript:;" onClick="OnSelectRemove();return false;"><img src="../images/btn_select_board_delete_w.gif" width="109" height="19" border="0"></a></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td height="30" align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
              </tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>등록된 게시글 중 사용자가 불량한 게시글을 신고된 내역을 확인 할 수 있습니다.</LI>
											<LI>관리자는 신고된 게시글을 확인 후 불량 게시글로 등록을 하거나 신고내역을 삭제할 수 있습니다.</LI>
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

	var SET_NOW_PAGE      = "<%=intPage%>";
	var SET_intTotalCount = "<%=intTotalCount%>";

	function OnPageMove(str){
		document.theForm.action = "BoardBadAsk.asp?intPage=" + str;
		document.theForm.submit();
	}

	function OnSelectAll(){
		if (SET_intTotalCount != "0"){
			obj = document.all['intSeq'];
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

	function OnBoardSelectCheck(){
		var sIntseq = "";
		if (SET_intTotalCount == "0"){
			return false;
		}else{
			obj = document.all['intSeq'];
			if (SET_intTotalCount == "1"){
				if (obj.checked == true){
					sIntseq = sIntseq + obj.value + ",";
				}
			}else{
				var cntBox = obj.length - 1;
				for(var i = 0; i <= cntBox; i++){
					if (obj[i].checked == true){
						sIntseq = sIntseq + obj[i].value + ",";
					}
				}
			}
			return sIntseq;
		}
	}

	function OnSelectBad(){

		var sIntseq = "";
		sIntseq = OnBoardSelectCheck();
		if (!sIntseq || sIntseq == ""){
			alert("등록할 게시글을 선택해 주시기 바랍니다.");
			return false;
		}

		if (confirm("선택된 신고내역의 게시글을 불량게시글로 등록하시겠습니까?")){
			document.theForm.action = "BoardBadAsk_ok.asp?Action=selectbad&intSeq=" + sIntseq + "&intPage=" + SET_NOW_PAGE;
			document.theForm.submit();
		}
	}

	function OnBad(intSeq){
		if (confirm("선택된 신고내역의 게시글을 불량게시글로 등록하시겠습니까?")){
			document.theForm.action = "BoardBadAsk_ok.asp?Action=bad&intSeq=" + intSeq + "&intPage=" + SET_NOW_PAGE;
			document.theForm.submit();
		}
	}

	function OnSelectRemove(){

		var sIntseq = "";
		sIntseq = OnBoardSelectCheck();
		if (!sIntseq || sIntseq == ""){
			alert("삭제할 게시글을 선택해 주시기 바랍니다.");
			return false;
		}

		if (confirm("선택된 게시글의 신고내역을 삭제하시겠습니까?")){
			document.theForm.action = "BoardBadAsk_ok.asp?Action=selectremove&intSeq=" + sIntSeq + "&intPage=" + SET_NOW_PAGE;
			document.theForm.submit();
		}
	}

	function OnRemove(intSeq){
		if (confirm("선택된 신고내역을 삭제하시겠습니까?")){
			document.theForm.action = "BoardBadAsk_ok.asp?Action=remove&intSeq=" + intSeq + "&intPage=" + SET_NOW_PAGE;
			document.theForm.submit();
		}
	}

	function OnBoardInfo(str){
		if (document.all['strBoardList' + str][0].style.display == "block"){
			document.all['strBoardList' + str][0].style.display = "none";
			document.all['strBoardList' + str][1].style.display = "none";
		}else{
			document.all['strBoardList' + str][0].style.display = "block";
			document.all['strBoardList' + str][1].style.display = "block";
		}
	}
</script>
<!-- #include file = "Foot.asp" -->