<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu  = 2
	isAdminPopup = True
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM strPollCode, strSubject
	strPollCode = REQUEST.QueryString("strPollCode")

	SET RS = DBCON.EXECUTE("SELECT [strSubject] FROM [MPLUS_POLL] WHERE [strPollCode] = '" & strPollCode & "' ")

	strSubject = RS("strSubject")

	DIM intPage, intPageSize, intTotalCount, intPageCount
	intPage     = REQUEST.QueryString("intPage") : IF intPage     = "" THEN intPage     = 1
	intPageSize = REQUEST.FORM("intPageSize")    : IF intPageSize = "" THEN intPageSize = 10

	SET RS = DBCON.EXECUTE("SELECT COUNT([intSeq]) FROM [MPLUS_POLL_ITEM] WHERE [strPollCode] = '" & strPollCode & "' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [intSeq], [strSubject], [bitObjective], [intItemCount], [intStep] FROM [MPLUS_POLL_ITEM] WHERE [strPollCode] = '" & strPollCode & "' AND [intSeq] NOT IN (SELECT TOP " & (intPage - 1) * intPageSize & " [intSeq] FROM [MPLUS_POLL_ITEM] WHERE [strPollCode] = '" & strPollCode & "' ORDER BY [intSeq] DESC) ORDER BY [intSeq] DESC ")
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post">
	<tr>
		<td background="../images/pop_title_bg.gif"><img src="../images/pop_title_poll_item.gif" width="155" height="44"></td>
	</tr>
	<tr>
		<td height="8"></td>
	</tr>
	<tr>
		<td class="table_Select2" style="padding-top:10; padding-bottom:10; padding-left:10; padding-right:10;"><%=strSubject%></td>
	</tr>
	<tr>
		<td height="8"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="30">전체 : <font color="#C6325B"><b><%=intTotalCount%></b></font>&nbsp;&nbsp;<%=intPage%>/<%=intPageCount%> 페이지</td>
				</tr>
				<tr>
				  <td>
						<table width="100%"  border="0" cellpadding="0" cellspacing="0">
							<tr align="center" bgcolor="EB766F">
								<td colspan="7" class="table_Round1"></td>
							</tr>
							<tr align="center" bgcolor="EB766F">
								<td width="60" height="30" nowrap class="table_Txt1">번호</td>
								<td height="30" class="table_Txt1" nowrap>설문제목</td>
								<td width="60" height="30" nowrap class="table_Txt1">설문타입</td>
								<td width="60" height="30" nowrap class="table_Txt1">항목수</td>
								<td width="55" nowrap class="table_Txt1">출력순서</td>
								<td width="55" height="30" nowrap class="table_Txt1">수정</td>
							  <td width="55" nowrap class="table_Txt1">삭제</td>
							</tr>
							<tr bgcolor="EB766F">
								<td colspan="7" class="table_Round1"></td>
							</tr>
<%
	IF RS.EOF THEN
%>
							<tr align="center" bgcolor="#FFFFFF">
								<td colspan="7" class="table_ListSubText1">등록된 설문항목이 없습니다.</td>
							</tr>
							<tr>
								<td colspan="7" class="table_ListSubLine1"></td>
							</tr>
<%
	ELSE
		DIM iCount, intNumber
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
							<tr bgcolor="#FFFFFF" align="center">
								<td class="table_ListSubText1"><%=intNumber%><input type="hidden" name="intSeq" value="<%=RS("intSeq")%>"></td>
								<td align="left" class="table_ListSubText1"><%=GetCutsubject(RS("strSubject"),60)%></td>
								<td class="table_ListSubText1"><% IF RS("bitObjective") = True THEN %>객관식<% ELSE %>주관식<% END IF %></td>
								<td class="table_ListSubText1"><% IF RS("bitObjective") = True THEN %><%=RS("intItemCount")%>개<% ELSE %>-<% END IF %></td>
								<td class="table_ListSubText1"><input name="intStep" type="text" id="intStep" value="<%=RS("intStep")%>" size="4" maxlength="3" onBlur="onlynum(this, 1);"></td>
								<td class="table_ListSubText1"><a href="PollItemAdd.asp?strPollCode=<%=strPollCode%>&Action=edit&intSeq=<%=RS("intSeq")%>"><img src="../images/btn_edit_s.gif" width="38" height="16" border="0"></a></td>
							  <td class="table_ListSubText1"><a href="javascript:;" onClick="OnRemove('<%=RS("intSeq")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0"></a></td>
							</tr>
							<tr>
								<td colspan="7" class="table_ListSubLine1"></td>
							</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
							<tr>
								<td colspan="7" height="1"></td>
							</tr>
							<tr>
								<td colspan="7" class="table_ListSubBLine1"></td>
							</tr>
						</table>
					</td>
			  </tr>
				<tr>
					<td height="40">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="95">
								<a href="PollItemAdd.asp?strPollCode=<%=strPollCode%>&Action=add"><img src="../images/btn_add_item_w.gif" width="95" height="19" border="0"></a></td>
								<td align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
							  <td width="116" align="center"><a href="javascript:;" onClick="OnEditAll();return false;"><img src="../images/btn_step_w.gif" width="116" height="19" border="0"></a></td>
							</tr>
						</table>
					</td>
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

	var SET_intTotalCount = "<%=intTotalCount%>";
	var SET_strPollCode   = "<%=strPollCode%>";
	var SET_intPage       = "<%=intPage%>";

	function OnPageMove(intPage){
		document.theForm.action = "PollItemList.asp?strPollCode=" + SET_strPollCode + "&intPage=" + intPage;
		document.theForm.submit();
	}

	function OnMemberSelectAll(){
		if (SET_intTotalCount != "0"){

			obj = document.all['strLoginID'];

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

	function OnMemberSelectCheck(){
		var sMember = "";
		if (SET_intTotalCount == "0"){
			return false;
		}else{
			obj = document.all['strLoginID'];
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

	function OnMemberSelect(){

		var sMember = "";
		sMember = OnMemberSelectCheck();
		if (!sMember || sMember == ""){
			alert("회원을 선택해 주시기 바랍니다.");
			return false;
		}

		if (SET_sType == ""){
			parent.document.all['strMemberList'].value = parent.document.all['strMemberList'].value + sMember;
			parent.closeLayer();
		}else{
			parent.BoardAdmin.document.all['strAdminInput'].value = parent.BoardAdmin.document.all['strAdminInput'].value + sMember;
			parent.closeLayer();
		}

	}

	function OnMemberSearch(){
		str = document.all['strSearchWord'];
		if (str.value == ""){alert("검색 단어를 입력해 주시기 바랍니다.");str.focus();return false;}
		document.theForm.submit();
	}

	function OnEditAll(){
		if (SET_intTotalCount == "0"){
			alert("일괄수정할 항목이 없습니다.");return false;
		}else{
			if (SET_intTotalCount == "1"){
				if (document.all['intStep'].value == ""){
					document.all['intStep'].value = "1";
				}
			}else{
				for(var i = 0; i < document.all['intStep'].length; i++){
					if (document.all['intStep'][i].value == ""){
						alert("순서정보를 입력해 주시기 바랍니다.");document.all['intStep'][i].focus();return false;
					}
				}
			}
		}

		if (confirm("일괄적으로 순서정보를 적용하시겠습니까?")){
			document.theForm.action = "pollItem_ok.asp?strPollCode=" + SET_strPollCode + "&intPage=" + SET_intPage + "&Action=editall";
			document.theForm.submit();
		}
	}

	function OnRemove(intSeq){
		if (confirm("선택한 설문항목을 삭제하시겠습니까?")){
			document.theForm.action = "pollItem_ok.asp?strPollCode=" + SET_strPollCode + "&Action=remove&intSeq=" + intSeq;
			document.theForm.submit();
		}
	}

</script>
<!-- #include file = "../Foot.asp" -->