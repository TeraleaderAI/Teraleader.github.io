<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu  = 2
	isAdminPopup = True
	strAdminPrevUrl = "Member/MemberMailingList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount, Query1, Query2, strCategory, strSearch
	intPage     = REQUEST.QueryString("intPage")     : IF intPage = "" THEN intPage = 1
	intPageSize = 15
	strCategory = REQUEST.FORM("strCategory")
	strSearch   = REQUEST.FORM("strSearch")

	IF strSearch <> "" THEN
		Query1 = " WHERE [" & strCategory & "] LIKE '%" & GetReplaceInput(strSearch, "") & "%' "
		Query2 = " AND [" & strCategory & "] LIKE '%" & strSearch & "%' "
	END IF

	SET RS = DBCON.EXECUTE("SELECT COUNT([intNum]) AS [RecCount] FROM [MPLUS_MAIL_MEMBER] " & Query1)

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [intNum], [strCompany], [strName], [strEmail], [bitEmail] FROM [MPLUS_MAIL_MEMBER] WHERE [intNum] NOT IN (SELECT TOP " & (intPage - 1) * intPageSize & " [intNum] FROM [MPLUS_MAIL_MEMBER] " & Query1 & " ORDER BY [intNum] DESC) " & Query2 & " ORDER BY [intNum] DESC ")
%>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td height="44" background="../images/pop_title_bg.gif"><img src="../images/MailDbList_title.gif" width="155" height="44"></td>
	</tr>
  <tr>
    <td height="10"></td>
  </tr>
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<form name="theForm" method="post">
				<tr>
					<td height="24">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>전체 <%=intTotalCount%>, 페이지 <%=intPage%>/<%=intPageCount%></td>
								<td align="right"><select name="strCategory" id="strCategory">
								<option value="strCompany"<% IF strCategory = "strCompany" THEN %> SELECTED<% END IF %>>소속</option>
								<option value="strName"<% IF strCategory = "strName" THEN %> SELECTED<% END IF %>>이름</option>
								<option value="strEmail"<% IF strCategory = "strEmail" THEN %> SELECTED<% END IF %>>메일주소</option>
								</select>
								<input name="strSearch" type="text" class="input" id="strSearch" value="<%=strSearch%>">
								<a href="javascript:;" onClick="OnSearch();return false;"><img src="../images/btn_search_w.gif" width="68" height="19" border="0" align="absmiddle"></a>
								<a href="MemberMailDbList.asp"><img src="../images/btn_search_cancel_w.gif" width="68" height="19" border="0" align="absmiddle"></a></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="100%"  border="0" cellpadding="0" cellspacing="0">
							<tr align="center" bgcolor="EB766F">
								<td colspan="8" class="table_Round1"></td>
							</tr>
							<tr align="center" bgcolor="EB766F">
								<td height="30" class="table_Txt1" nowrap>선택</td>
								<td height="30" class="table_Txt1" nowrap>번호</td>
								<td height="30" class="table_Txt1" nowrap>소속</td>
								<td height="30" class="table_Txt1" nowrap>이름</td>
								<td class="table_Txt1" nowrap>메일주소</td>
								<td nowrap class="table_Txt1">메일수신</td>
								<td width="45" height="30" nowrap class="table_Txt1">수정</td>
								<td width="45" align="center" class="table_Txt1" nowrap>삭제</td>
							</tr>
							<tr bgcolor="EB766F">
								<td colspan="8" class="table_Round1"></td>
							</tr>
<%
	IF RS.EOF THEN
%>
							<tr align="center" bgcolor="#FFFFFF">
								<td colspan="8" class="table_ListSubText1">등록된 회원이 없습니다.</td>
							</tr>
							<tr>
								<td colspan="8" class="table_ListSubLine1"></td>
							</tr>
<%
	ELSE
		DIM iCount, intMemberNum
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intMemberNum = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
							<tr bgcolor="#FFFFFF" align="center">
								<td class="table_ListSubText1"><input name="intNum" type="checkbox" id="intNum" value="<%=RS("intNum")%>" class="no_Line"></td>
								<td class="table_ListSubText1"><%=intMemberNum%></td>
								<td class="table_ListSubText1"><%=RS("strCompany")%></td>
								<td class="table_ListSubText1"><%=RS("strName")%></td>
								<td class="table_ListSubText1"><%=RS("strEmail")%></td>
								<td class="table_ListSubText1"><% IF RS("bitEmail") = True THEN %>O<% ELSE %>X<% END IF %></td>
								<td class="table_ListSubText1"><a href="MemberMailDbWrite.asp?Action=edit&intNum=<%=RS("intNum")%>&intPage=<%=intPage%>"><img src="../images/btn_edit_s.gif" width="38" height="16" border="0"></a></td>
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
					<td height="30">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="180"><a href="javascript:;" onClick="select_all();return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0"></a>&nbsp;<a href="javascript:;" onClick="OnSelectRemove();return false;"><img src="../images/btn_select_delete_w.gif" width="68" height="19" border="0"></a></td>
								<td align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
								<td width="95" align="right"><a href="MemberMailDbWrite.asp?Action=add"><img src="../images/btn_add_new_w.gif" width="91" height="19" border="0"></a></td>
							</tr>
						</table>					</td>
				</tr>
			</form>
			</table>
		</td>
	</tr>
</table>
<script language="javascript">
	var SET_intMemberCount = "<%=intTotalCount%>";

	function select_all(){
		obj = document.all['intNum'];
		if(!obj) return false;
		var cntBox = obj.length - 1;
		for(var i = 0; i <= cntBox; i++){
			if (obj[i].checked == false){
				obj[i].checked=true;
			}else{
				obj[i].checked=false;
			}
		}
	}

	function OnSearch(){
		str = document.all['strSearch'];
		if (str.value == ""){alert("검색할 단어를 입력해 주시기 바랍니다.");str.focus();return false;}

		document.theForm.action = "MemberMailDbList.asp";
		document.theForm.submit();
	}

	function OnPageMove(str){
		document.theForm.action = "MemberMailDbList.asp?intPage=" + str;
		document.theForm.submit();
	}

	function OnRemove(str){
		if (confirm("선택된 정보를 삭제하시겠습니까?")){
			document.theForm.action = "MemberMailDb_ok.asp?Action=remove&intNum=" + str;
			document.theForm.submit();
		}
	}

	function OnSelectRemove(){
		if (SET_intMemberCount == "0"){
			alert("삭제할 정보가 없습니다.");
			return false;
		}
		var k = 0;
		obj = document.all['intNum'];
		if(!obj) return false;
		var cntBox = obj.length - 1;
		for(var i = 0; i <= cntBox; i++){
			if (obj[i].checked == true){
				k++;
			}
		}
		if (k == 0){
			alert("삭제할 정보를 선택해 주시기 바랍니다.");
			return false;
		}

		if(confirm("선택된 정보를 삭제하시겠습니까?")){
			document.theForm.action = "MemberMailDb_ok.asp?Action=sremove";
			document.theForm.submit();
		}
	}
</script>
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
<!-- #include file = "../Foot.asp" -->