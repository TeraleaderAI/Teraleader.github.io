<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Member/MemberList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount, strLoginID
	intPage     = REQUEST.QueryString("intPage") : IF intPage     = "" THEN intPage     = 1
	intPageSize = 10
	strLoginID  = REQUEST.QueryString("strLoginID")
	
	SET RS = DBCON.EXECUTE("SELECT COUNT([intNum]) AS [RecCount] FROM [MPLUS_MEMBER_POINT] WHERE [strLoginID] = '" & strLoginID & "' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [intNum], [strPointType], [strPointCode] = (SELECT [strName] FROM [MPLUS_BOARD_POINT_CODE] WHERE [strCode] = [MPLUS_MEMBER_POINT].[strCode]), [moneyPoint], [strMemo], [dateRegDate] FROM [MPLUS_MEMBER_POINT] WHERE [intNum] NOT IN (SELECT TOP " & (intPage - 1) * intPageSize & " [intNum] FROM [MPLUS_MEMBER_POINT] WHERE [strLoginID] = '" & strLoginID & "' ORDER BY [intNum] DESC) AND [strLoginID] = '" & strLoginID & "' ORDER BY [intNum] DESC ")
%>
<table width="784" height="100%"  border="0" cellpadding="0" cellspacing="0">
<form name="theForm" method="post" action="MemberPoint_ok.asp">
<input type="hidden" name="eIntNum">
<input type="hidden" name="eMoneyPoint">
<input type="hidden" name="eStrMemo">
	<tr>
		<td height="44" background="../images/pop_title_bg.gif"><img src="../images/pop_title_member_point.gif" width="155" height="44"></td>
	</tr>
	<tr>
	  <td height="30" style="padding-left:5;">전체 : <font color="#C6325B"><b><%=intTotalCount%></b></font>&nbsp;&nbsp;<%=intPage%>/<%=intPageCount%> 페이지 </td>
	  </tr>
	<tr>
		<td height="100%" align="center" valign="top">
			<table width="771" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr align="center" bgcolor="EB766F">
								<td colspan="9" class="table_Round1"></td>
							</tr>
							<tr align="center" bgcolor="EB766F">
								<td height="30" class="table_Txt1" nowrap>선택</td>
								<td height="30" class="table_Txt1" nowrap>번호</td>
								<td height="30" class="table_Txt1" nowrap>구분</td>
								<td height="30" class="table_Txt1" nowrap>코드</td>
								<td class="table_Txt1" nowrap>포인트</td>
								<td class="table_Txt1" nowrap>메모</td>
								<td nowrap class="table_Txt1">등록일자</td>
								<td width="45" height="30" nowrap class="table_Txt1">수정</td>
								<td width="45" align="center" class="table_Txt1" nowrap>삭제</td>
							</tr>
							<tr bgcolor="EB766F">
								<td colspan="9" class="table_Round1"></td>
							</tr>
<%
	IF RS.EOF THEN
%>
							<tr align="center" bgcolor="#FFFFFF">
								<td colspan="9" class="table_ListSubText1">등록된 포인트 내역이 없습니다.</td>
							</tr>
							<tr>
								<td colspan="9" class="table_ListSubLine1"></td>
							</tr>
<%
	ELSE
		DIM strPointType, intNumber
		WHILE NOT(RS.EOF)
		iCount = iCount + 1
		intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
		SELECT CASE RS("strPointType")
		CASE "0" : strPointType = "회원관련"
		CASE "1" : strPointType = "게시판관련"
		CASE "2" : strPointType = "그룹관련"
		CASE "3" : strPointType = "기타"
		END SELECT
%>
							<tr bgcolor="#FFFFFF" align="center">
								<td class="table_ListSubText1"><input name="intNum" type="checkbox" id="intNum" value="<%=RS("intNum")%>" class="no_Line"></td>
								<td class="table_ListSubText1"><%=intNumber%></td>
								<td class="table_ListSubText1"><%=strPointType%></td>
								<td class="table_ListSubText1"><%=RS("strPointCode")%></td>
								<td class="table_ListSubText1"><input name="moneyPoint" type="text" id="moneyPoint" value="<%=RS("moneyPoint")%>" size="6" maxlength="12" onBlur="onlyInt(this);" class="input"></td>
								<td class="table_ListSubText1"><input name="strMemo" type="text" class="input" id="strMemo" value="<%=RS("strMemo")%>" size="40" maxlength="128"></td>
								<td class="table_ListSubText1"><%=RS("dateRegDate")%></td>
								<td class="table_ListSubText1"><a href="javascript:;" onClick="OnPointEdit('<%=strLoginID%>','<%=iCount-1%>','<%=RS("intNum")%>');return false;"><img src="../images/btn_edit_s.gif" width="38" height="16" border="0" /></a></td>
								<td class="table_ListSubText1"><a href="javascript:;" onClick="OnPointRemove('<%=RS("intNum")%>', '<%=strLoginID%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0" /></a></td>
							</tr>
							<tr>
								<td colspan="9" class="table_ListSubLine1"></td>
							</tr>
<%
	RS.MOVENEXT
	WEND
END IF
			
	SET RS = DBCON.EXECUTE("SELECT SUM([moneyPoint]) AS [totalPoint] FROM [MPLUS_MEMBER_POINT] WHERE [strLoginID] = '" & strLoginID & "' ")
	DIM totalPoint
	totalPoint = RS("totalPoint")
%>
							<tr>
								<td colspan="9" height="1"></td>
							</tr>
							<tr>
								<td colspan="9" class="table_ListSubBLine1"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="30">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><a href="javascript:;" onClick="OnSelectAll();return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0" align="absmiddle"></a> <a href="javascript:;" onClick="OnPointSelectEdit('<%=strLoginID%>');return false;"><img src="../images/btn_select_point_edit_w.gif" width="142" height="19" border="0" align="absmiddle"></a> <a href="javascript:;" onClick="OnPointSelectRemove('<%=strLoginID%>');return false;"><img src="../images/btn_select_point_delete_w.gif" width="142" height="19" border="0" align="absmiddle"></a></td>
								<td align="right"><b><%=strLoginID%></b> 님의 전체 포인트 : <span class="style1"><b><%=totalPoint%></b> Points</span></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="30" align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
				</tr>
			</table>
		</td>
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
	var SET_strLoginID = "<%=strLoginID%>";
	var SET_intTotalCount = "<%=intTotalCount%>";

	function OnPageMove(intPage){
		document.theForm.action = "MemberPoint.asp?strLoginID=" + SET_strLoginID + "&intPage=" + intPage;
		document.theForm.submit();
	}

	function OnSelectAll(){
		if (SET_intTotalCount != "0"){

			obj = document.all['intNum'];

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

	function OnPointSelect(){

		var sMember = "";
		if (SET_intTotalCount == "0"){
			return false;
		}else{
			obj = document.all['intNum'];
			if (SET_intTotalCount == "1"){
				if (obj.checked == true){
					sMember = sMember + obj.value + ",";
				}
			}else{
				var cntBox = obj.length - 1;
				for(var i = 0; i <= cntBox; i++){
					if (obj[i].checked == true){
						sMember = sMember + obj[i].value + ",";
					}
				}
			}
			return sMember;
		}

	}

	function OnPointSelectEdit(str){

		var sMember = "";
		sMember = OnPointSelect();
		if (!sMember || sMember == ""){
			alert("포인트 내역을 선택해 주시기 바랍니다.");
			return false;
		}

		if (confirm("선택된 회원포인트 정보를 수정하시겠습니까?")){
			document.theForm.action = "MemberPoint_ok.asp?Action=selectedit&intNum=" + sMember + "&strLoginID=" + str + "&intPage=" + SET_NOW_PAGE;
			document.theForm.submit();
		}

	}

	function OnPointEdit(str1, str2, str3){
		if(confirm("선택된 회원포인트 내역을 수정하시겠습니까?")){
			obj = document.all['intNum'];
			if(!obj) return false;
			if (obj.length == undefined){
				document.all['eIntNum'].value = str3;
				document.all['eMoneyPoint'].value = document.all['moneyPoint'].value;
				document.all['eStrMemo'].value = document.all['strMemo'].value;
			}else{
				document.all['eIntNum'].value = str3;
				document.all['eMoneyPoint'].value = document.all['moneyPoint'][str2].value;
				document.all['eStrMemo'].value = document.all['strMemo'][str2].value;
			}
			document.theForm.action = "MemberPoint_ok.asp?Action=edit&intPage=" + SET_NOW_PAGE + "&strLoginID=" + str1;
			document.theForm.submit();
		}
	}

	function OnPointSelectRemove(str){

		var sMember = "";
		sMember = OnPointSelect();
		if (!sMember || sMember == ""){
			alert("포인트 내역을 선택해 주시기 바랍니다.");
			return false;
		}

		if (confirm("선택된 회원포인트 정보를 삭제하시겠습니까?")){
			document.theForm.action = "MemberPoint_ok.asp?Action=selectremove&intNum=" + sMember + "&strLoginID=" + str + "&intPage=" + SET_NOW_PAGE;
			document.theForm.submit();
		}

	}

	function OnPointRemove(str1, str2){
		if(confirm("선택된 포인트 정보를 삭제하시겠습니까?")){
			document.theForm.action = "MemberPoint_ok.asp?Action=remove&intNum=" + str1 + "&strLoginID=" + str2 + "&intPage=" + SET_NOW_PAGE;
			document.theForm.submit();
		}
	}

</script>
<!-- #include file = "../Foot.asp" -->