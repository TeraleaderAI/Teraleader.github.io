<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 5
	intLeftMenu  = 3
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount, I, strGroupCode, strGroupName, strSelectGroup, Query1, Query2
	intPage     = REQUEST.QueryString("intPage")     : IF intPage = "" THEN intPage = 1
	intPageSize = REQUEST.Form("intPageSize") : IF intPageSize = "" THEN intPageSize = 10

	SET RS = DBCON.EXECUTE("SELECT [strCode], [strName] FROM [MPLUS_BOARD_NOTICE] ")
	IF NOT(RS.EOF) THEN
		WHILE NOT(RS.EOF)
			IF strGroupCode <> "" THEN strGroupCode = strGroupCode & ","
			IF strGroupName <> "" THEN strGroupName = strGroupName & ","
			strGroupCode = strGroupCode & RS("strCode")
			strGroupName = strGroupName & RS("strName")
		RS.MOVENEXT
		WEND
	END IF

	strSelectGroup = REQUEST("strSelectGroup")
	IF strSelectGroup <> "" THEN
		Query1 = " WHERE [strCode] = '" & strSelectGroup & "' "
		Query2 = " AND [strCode] = '" & strSelectGroup & "' "
	END IF

	SET RS = DBCON.EXECUTE("SELECT COUNT([intNum]) AS [RecCount] FROM [MPLUS_BOARD_NOTICE_LIST] " & Query1)

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [intNum], [strCode], [strBoardID], [intSeq], [strSubject] = (SELECT [strSubject] FROM [MPLUS_BOARD] WHERE [intSeq] = [MPLUS_BOARD_NOTICE_LIST].[intSeq]), [strFileName], [intStep], [bitUsage], [bitMemoInfo], [strFontColor], [bitBold], [dateRegDate] FROM [MPLUS_BOARD_NOTICE_LIST] WHERE [intNum] NOT IN (SELECT TOP " & (intPage - 1) * intPageSize & " [intNum] FROM [MPLUS_BOARD_NOTICE_LIST] " & Query1 & " ORDER BY [intNum] DESC) " & Query2 & " ORDER BY [intNum] DESC ")
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title38.gif" width="126" height="19"></td>
                      <td align="right">관리자 홈 &gt; 통계자료 &gt; <b>메인 추천 게시글</b></td>
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
											<td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>메인 추천글 목록</strong></span></td>
											<td align="right">
												<%=GetMainBoardGroup(strGroupCode, strGroupName, strSelectGroup, "strSelectGroup", "그룹선택", "OnGroupSelect(this.value);")%>
												<select name="intPageSize" id="intPageSize" onChange="OnPageSize();return false;">
												<option value="10"<% IF INT(intPageSize) = 10 THEN %> SELECTED<% END IF %>>10 개씩출력</option>
												<option value="20"<% IF INT(intPageSize) = 20 THEN %> SELECTED<% END IF %>>20 개씩출력</option>
												<option value="30"<% IF INT(intPageSize) = 30 THEN %> SELECTED<% END IF %>>30 개씩출력</option>
												<option value="50"<% IF INT(intPageSize) = 50 THEN %> SELECTED<% END IF %>>50 개씩출력</option>
												<option value="100"<% IF INT(intPageSize) = 100 THEN %> SELECTED<% END IF %>>100 개씩출력</option>
												</select>	
											</td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr align="center" bgcolor="EB766F">
											<td colspan="10" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td height="30" class="table_Txt1" nowrap>선택</td>
											<td height="30" class="table_Txt1" nowrap>번호</td>
											<td height="30" class="table_Txt1" nowrap>그룹명</td>
											<td height="30" class="table_Txt1" nowrap>게시글</td>
											<td class="table_Txt1" nowrap>글제목</td>
											<td class="table_Txt1" nowrap>출력순서</td>
											<td class="table_Txt1" nowrap>사용유무</td>
											<td nowrap class="table_Txt1">보기</td>
											<td width="45" height="30" nowrap class="table_Txt1">수정</td>
											<td width="45" align="center" class="table_Txt1" nowrap>삭제</td>
										</tr>
										<tr bgcolor="EB766F">
											<td colspan="10" class="table_Round1"></td>
										</tr>
<%
	IF RS.EOF THEN
%>
										<tr align="center" bgcolor="#FFFFFF">
											<td colspan="10" class="table_ListSubText1">등록된 메인추천 게시글이 없습니다.</td>
										</tr>
										<tr>
											<td colspan="10" class="table_ListSubLine1"></td>
										</tr>
<%
	ELSE
		DIM iCount, intNumber
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1"><input name="intNum" type="checkbox" id="intNum" value="<%=RS("intNum")%>" class="no_Line"><input type="hidden" name="intNumH" value="<%=RS("intNum")%>"></td>
											<td class="table_ListSubText1"><%=intNumber%></td>
											<td class="table_ListSubText1"><%=GetMainBoardGroup(strGroupCode, strGroupName, RS("strCode"), "strCode", "", "")%></td>
											<td class="table_ListSubText1"><%=RS("intSeq")%></td>
											<td class="table_ListSubText1" align="left"><%=GetCutSubject(RS("strSubject"),30)%></td>
											<td class="table_ListSubText1"><input name="intStep" type="text" id="intStep" value="<%=RS("intStep")%>" size="2" maxlength="4" OnKeydown="onlyNumber();"></td>
											<td class="table_ListSubText1">
											<select name="bitUsage" id="bitUsage">
											<option value="1"<% IF RS("bitUsage") = True THEN %> SELECTED<% END IF %>>사용함</option>
											<option value="0"<% IF RS("bitUsage") = False THEN %> SELECTED<% END IF %>>사용안함</option>
											</select>											</td>
											<td class="table_ListSubText1"><a href="../../Mboard.asp?Action=view&strBoardID=<%=RS("strBoardID")%>&intSeq=<%=RS("intSeq")%>" target="_blank"><img src="../images/btn_view_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:popupLayer('BoardBestEdit.asp?intNum=<%=RS("intNum")%>&intPage=<%=intPage%>&intPageSize=<%=intPageSize%>&strSelectGroup=<%=RS("strCode")%>',700,530);"><img src="../images/btn_edit_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:;" onClick="OnRemove('<%=RS("intNum")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0"></a></td>
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
											<a href="javascript:;" onClick="OnBoardSelect();return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0"></a>
											<a href="javascript:popupLayer('BoardBestGroupList.asp',810,470);"><img src="../images/btn_board_group_w.gif" width="105" height="19" border="0"></a>											</td>
											<td align="right">
											<a href="javascript:popupLayer('BoardBestSelect.asp',900,670);"><img src="../images/btn_new_board_w.gif" width="110" height="19" border="0"></a>
											<a href="javascript:;" onClick="OnSelectRemove();return false;"><img src="../images/btn_select_board_delete_w.gif" width="109" height="19" border="0"></a>
											<a href="javascript:;" onClick="OnAllEdit();return false;"><img src="../images/btn_select_edit_w.gif" width="116" height="19" border="0"></a>
											<a href="javascript:;" onClick="popupLayer('BoardBestSample.asp',900,670);"><img src="../images/btn_sample2_w.gif" width="92" height="19" border="0"></a></td>
										</tr>
									</table>
								</td>
              </tr>
							<tr>
								<td height="40" align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
							</tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>메인추천 게시글이란 특정 게시글들을 그룹에 등록해서 메인에 추천글을 출력하는 기능입니다.</LI>
											<LI>그룹을 먼저 생성하신 후 게시글들을 등록할 수 있으며, 각 게시글에 대해 이미지 등록이 가능합니다.</LI>
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
	var SET_NOW_PAGE = "<%=intPage%>";
	var SET_intTotalCount = "<%=intTotalCount%>";

	function OnBoardSelect(){
		obj = document.all['intNum'];
		if(!obj) return false;
		if (SET_intTotalCount == "1"){
			if (document.all['intNum'].checked == true){
				document.all['intNum'].checked = false;
			}else{
				document.all['intNum'].checked = true
			}
		}else{
			var cntBox = obj.length - 1;
			for(var i = 0; i <= cntBox; i++){
				if (obj[i].checked == false){
					obj[i].checked=true;
				}else{
					obj[i].checked=false;
				}
			}
		}
	}

	function OnSelectRemove(){
		obj = document.all['intNum'];
		var k = 0;
		if(!obj) return false;
		if (SET_intTotalCount == "1"){
			if (document.all['intNum'].checked == true){
				k++;
			}
		}else{
			var cntBox = obj.length - 1;
			for(var i = 0; i <= cntBox; i++){
				if (obj[i].checked == true){
					k++;
				}
			}
		}
		if (k == 0){
			alert("삭제할 메인추천글 정보를 선택해 주시기 바랍니다.");return false;
		}
		if (confirm("선택된 메인추천글 정보를 삭제하시겠습니까?")){
			document.theForm.action = "BoardBestList_ok.asp?Action=selectremove&intPage=" + SET_NOW_PAGE;
			document.theForm.submit();
		}
	}

	function OnAllEdit(){
		if (confirm("현재 페이지의 메인 추천글 정보를 일괄적으로 수정하시겠습니까?")){
			document.theForm.action = "BoardBestList_ok.asp?Action=edit&intPage=" + SET_NOW_PAGE;
			document.theForm.submit();
		}
	}

	function OnRemove(str){
		if (confirm("선택된 메인추천글 정보를 삭제하시겠습니까?")){
			document.theForm.action = "BoardBestList_ok.asp?Action=remove&intNum=" + str + "&intPage=" + SET_NOW_PAGE;
			document.theForm.submit();
		}
	}

	function OnGroupSelect(str){
		document.theForm.action = "BoardBestList.asp";
		document.theForm.submit();
	}

	function OnPageSize(){
		document.theForm.action = "BoardBestList.asp";
		document.theForm.submit();
	}

	function OnPageMove(str){
		document.theForm.action = "BoardBestList.asp?intPage=" + str;
		document.theForm.submit();
	}

	function OnEdit(str){
		document.theForm.action = "BoardNoticeAdd.asp?intNum=" + str + "&intPage=" + SET_NOW_PAGE;
		document.theForm.submit();
	}

</script>
<!-- #include file = "Foot.asp" -->