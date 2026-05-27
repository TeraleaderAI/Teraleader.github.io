<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 6
	intLeftMenu  = 6
	isAdminMenu  = 1
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount, Query, I, strBoardID
	intPage     = REQUEST("intPage")     : IF intPage = "" THEN intPage = 1
	intPageSize = REQUEST("intPageSize") : IF intPageSize = "" THEN intPageSize = 20

	IF SESSION("strAdmin") = "1" THEN
		SET RS = DBCON.EXECUTE("SELECT [strBoardID], [strAdmin] FROM [MPLUS_BOARD_CONFIG_DEFAULT] ")
		IF RS.EOF THEN
			Query = " AND [strBoardID] = '' "
		ELSE
			Query = ""
			WHILE NOT(RS.EOF)
				IF RS("strAdmin") <> "" AND ISNULL(RS("strAdmin")) = False THEN
					SplitStrAdmin = SPLIT(RS("strAdmin"), "|")
					FOR I = 0 TO UBOUND(SplitStrAdmin)
						IF SplitStrAdmin(I) = SESSION("strLoginID") THEN Query = Query & RS("strBoardID") & ","
					NEXT
				END IF
			RS.MOVENEXT
			WEND
			IF Query <> "" THEN Query = " AND [strBoardID] IN (" & getSplitQuery(Query) & ") "
		END IF
	ELSE
		Query = ""
	END IF

	strBoardID = REQUEST.FORM("strBoardID")
	IF strBoardID <> "" THEN Query = " AND [strBoardID] = '" & strBoardID & "' "

	SET RS = DBCON.EXECUTE("SELECT COUNT([intSeq]) AS [RecCount] FROM [MPLUS_BOARD] WHERE [bitCheck] = '0' AND [bitDelete] = '0' " & Query)
	
	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title41.gif" width="153" height="19"></td>
                      <td align="right">관리자 홈 &gt; 게시판관리 &gt; <b>미승인 게시글 리스트</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>미승인 게시글 정보</strong></span></td>
											<td align="right">
											<select name="strBoardID" onChange="OnBoardID();">
											<option value="">게시판을 선택하세요</option>
<%
	SET RS = DBCON.EXECUTE("SELECT [strBoardID], [strName] FROM [MPLUS_BOARD_CONFIG_DEFAULT] " & Query1)
	WHILE NOT(RS.EOF)
		RESPONSE.WRITE "					<option value='" & RS("strBoardID") & "'"
		IF REQUEST.FORM("strBoardID") = RS("strBoardID") THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & RS("strBoardID") & " [" & RS("strName") & "]</option>" & vbcrlf
	RS.MOVENEXT
	WEND
%>
											</select>											</td>
										</tr>
									</table>								</td>
              </tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr align="center" bgcolor="EB766F">
											<td colspan="10" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
										  <td class="table_Txt1" nowrap>선택</td>
											<td height="30" class="table_Txt1" nowrap>번호</td>
											<td height="30" nowrap class="table_Txt1">게시판 ID</td>
											<td height="30" class="table_Txt1" nowrap>글제목</td>
											<td class="table_Txt1" nowrap>등록자</td>
											<td class="table_Txt1" nowrap>조회수</td>
											<td class="table_Txt1" nowrap>등록일자</td>
											<td width="45" nowrap class="table_Txt1">보기</td>
											<td width="45" height="30" nowrap class="table_Txt1">승인</td>
											<td width="45" align="center" class="table_Txt1" nowrap>삭제</td>
										</tr>
										<tr bgcolor="EB766F">
											<td colspan="10" class="table_Round1"></td>
										</tr>
<%
	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [intSeq], [intThread], [strBoardID], [strLoginID], [strName], [strSubject], [intRead], [DateRegDate] FROM [MPLUS_BOARD] WHERE [intSeq] NOT IN (SELECT TOP " & (intPage - 1) * intPageSize & " [intSeq] FROM [MPLUS_BOARD] WHERE [bitCheck] = '0' AND [bitDelete] = '0' " & Query & " ORDER BY [intSeq] DESC) " & Query & " AND [bitCheck] = '0' AND [bitDelete] = '0' ORDER BY [intSeq] DESC ")

	IF RS.EOF THEN
%>
										<tr align="center" bgcolor="#FFFFFF">
											<td colspan="10" class="table_ListSubText1">등록된 내역이 없습니다.</td>
										</tr>
										<tr>
											<td colspan="10" class="table_ListSubLine1"></td>
										</tr>
<%
	ELSE
		DIM iCount, intBoardNum
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intBoardNum = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
										<tr bgcolor="#FFFFFF" align="center">
										  <td class="table_ListSubText1"><input name="intSeq" type="checkbox" id="intSeq" value="<%=RS("strBoardID")%>;<%=RS("intThread")%>" class="no_Line"></td>
											<td class="table_ListSubText1"><%=intBoardNum%></td>
											<td class="table_ListSubText1"><a href="../../Mboard.asp?strBoardID=<%=RS("strBoardID")%>" target="_blank"><b><font color="#C6325B"><%=RS("strBoardID")%></font></b></a></td>
											<td align="left" class="table_ListSubText1"><%=RS("strSubject")%></td>
											<td class="table_ListSubText1"><%=RS("strName")%>(<%=RS("strLoginID")%>)</td>
											<td class="table_ListSubText1"><%=RS("intRead")%></td>
											<td class="table_ListSubText1"><%=GetDateType(0, RS("dateRegDate"))%></td>
											<td class="table_ListSubText1"><a href="../../Mboard.asp?Action=view&strBoardID=<%=RS("strBoardID")%>&intSeq=<%=RS("intSeq")%>" target="_blank"><img src="../images/btn_view_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:;" onclick="OnCheck('<%=RS("strBoardID")%>', '<%=RS("intThread")%>');return false;"><img src="../images/btn_check_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:;" onclick="OnRemove('<%=RS("strBoardID")%>', '<%=RS("intThread")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0"></a></td>
										</tr>
										<tr>
											<td colspan="10" class="table_ListSubLine1"></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
										<tr>
											<td colspan="10" height="1"></td>
										</tr>
										<tr>
											<td colspan="10" class="table_ListSubBLine1"></td>
										</tr>
									</table>								</td>
              </tr>
              <tr>
                <td height="40">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
											<a href="javascript:;" onClick="OnSelectAll();return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0"></a></td>
											<td align="right">
											<a href="javascript:;" onClick="OnSelectCheck();return false;"><img src="../images/btn_select_check_w.gif" width="109" height="19" border="0"></a>
											<a href="javascript:;" onClick="OnSelectRemove();return false;"><img src="../images/btn_select_board_delete_w.gif" width="109" height="19" border="0"></a>
											</td>
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
											<LI>관리자 승인 후 게시글을 게시하는 기능을 사용할 경우 등록된 미승인된 게시글 목록이 출력됩니다.</LI>
											<LI>관리자가 해당 글을 승인해야 게시글이 사용자에게 출력되며, 게시판 설정에서 게시글 승인 기능을 사용하면 됩니다.</LI>
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

	var SET_intTotalCount = "<%=intTotalCount%>";

	function OnPageMove(intPage){
		document.theForm.action = "BoardCheckList.asp?intPage=" + intPage;
		document.theForm.submit();
	}

	function OnBoardID(){
		document.theForm.action = "BoardCheckList.asp";
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

	function OnCheck(str1, str2){

		if (confirm("게시글을 승인하시겠습니까?")){
			document.theForm.action = "BoardCheckList_ok.asp?Action=check&strBoardID=" + str1 + "&intThread=" + str2;
			document.theForm.submit();
		}

	}

	function OnRemove(str1, str2){

		if (confirm("게시글을 삭제하시겠습니까?")){
			document.theForm.action = "BoardCheckList_ok.asp?Action=remove&strBoardID=" + str1 + "&intThread=" + str2;
			document.theForm.submit();
		}

	}

	function OnSelectReturn(){
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

	function OnSelectCheck(){

		var sIntseq = "";
		sIntseq = OnSelectReturn();
		if (!sIntseq || sIntseq == ""){
			alert("승인할 게시글을 선택해 주시기 바랍니다.");
			return false;
		}

		if (confirm("선택한 게시글을 승인하시겠습니까?")){
			document.theForm.action = "BoardCheckList_ok.asp?Action=selectcheck";
			document.theForm.submit();
		}

	}

	function OnSelectRemove(){

		if (document.all['strBoardID'].value == ""){
			alert("게시판을 먼저 선택해 주시기 바랍니다.");
			document.all['strBoardID'].focus();
			return false;
		}

		var sIntseq = "";
		sIntseq = OnSelectReturn();
		if (!sIntseq || sIntseq == ""){
			alert("삭제할 게시글을 선택해 주시기 바랍니다.");
			return false;
		}

		if (confirm("선택한 게시글을 삭제하시겠습니까?")){
			document.theForm.action = "BoardCheckList_ok.asp?Action=selectremove";
			document.theForm.submit();
		}
	}

</script>
<!-- #include file = "Foot.asp" -->