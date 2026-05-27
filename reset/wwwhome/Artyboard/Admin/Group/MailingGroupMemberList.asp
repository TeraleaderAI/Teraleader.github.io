<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Group/MailingGroupList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM strCode, intPage, intPageSize, intTotalCount, intPageCount, Query1, Query2, I
	intPage     = REQUEST("intPage")     : IF intPage = "" THEN intPage = 1
	intPageSize = REQUEST("intPageSize") : IF intPageSize = "" THEN intPageSize = 10
	strCode     = REQUEST.QueryString("strCode")

	SET RS = DBCON.EXECUTE("SELECT COUNT([intSeq]) AS [RecCount] FROM [MPLUS_MEMBER_MAILING_MEMBER] WHERE [strGroup] = '" & strCode & "' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
<style type="text/css">
	body {margin : 0 0 0 0}
</style>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post">
	<tr>
		<td height="20">전체 : <b><%=intTotalCount%></b>&nbsp;&nbsp;페이지 : <b><%=intPage%> / <%=intPageSize%></b></td>
	</tr>
	<tr>
		<td>
			<table width="100%"  border="0" cellpadding="0" cellspacing="0">
				<tr align="center" bgcolor="EB766F">
					<td colspan="6" class="table_Round1"></td>
				</tr>
				<tr align="center" bgcolor="EB766F">
					<td height="30" class="table_Txt1" nowrap>선택</td>
					<td height="30" class="table_Txt1" nowrap>아이디</td>
					<td height="30" class="table_Txt1" nowrap>이름</td>
					<td height="30" class="table_Txt1" nowrap>레벨</td>
					<td height="30" nowrap class="table_Txt1">등록일자</td>
					<td width="60" align="center" class="table_Txt1" nowrap>삭제</td>
				</tr>
				<tr bgcolor="EB766F">
					<td colspan="6" class="table_Round1"></td>
				</tr>
<%
	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [b].[strLoginID], [b].[strLoginName], [intLevel] = (SELECT [intLevel] FROM [MPLUS_GROUP] WHERE [strGroupCode] = [b].[strGroup]), [b].[dateRegDate] FROM [MPLUS_MEMBER_MAILING_MEMBER][a] INNER JOIN [MPLUS_MEMBER_LIST][b] ON [a].[strLoginID] = [b].[strLoginID] WHERE [a].[intSeq] NOT IN (SELECT TOP " & (intPage - 1) * intPageSize & " [intSeq] FROM [MPLUS_MEMBER_MAILING_MEMBER] WHERE [strGroup] = '" & strCode & "' ORDER BY [intSeq] DESC) AND [a].[strGroup] = '" & strCode & "' ORDER BY [a].[intSeq] DESC ")

	IF RS.EOF THEN
%>
				<tr align="center" bgcolor="#FFFFFF">
					<td colspan="6" class="table_ListSubText1">등록된 회원이 없습니다.</td>
				</tr>
				<tr>
					<td colspan="6" class="table_ListSubLine1"></td>
				</tr>
<%
	ELSE
		DIM iCount
		iCount = 0
		WHILE NOT(RS.EOF)
		iCount = iCount + 1
%>
				<tr bgcolor="#FFFFFF" align="center">
					<td class="table_ListSubText1"><input name="strLoginID" type="checkbox" id="strLoginID" value="<%=RS("strLoginID")%>" class="no_Line"></td>
					<td class="table_ListSubText1"><%=RS("strLoginID")%></td>
					<td class="table_ListSubText1"><%=RS("strLoginName")%></td>
					<td class="table_ListSubText1">Lv.<%=RS("intLevel")%></td>
					<td class="table_ListSubText1"><%=REPLACE(FORMATDATETIME(RS("dateRegDate"), 2), "-", "/")%></td>
					<td class="table_ListSubText1"><a href="javascript:;" onClick="OnMemberRemove('<%=RS("strLoginID")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0"></a></td>
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
			</table>
		</td>
	</tr>
	<tr>
		<td height="30">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><a href="javascript:;" onClick="select_all();return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0"></a></td>
					<td align="right"><a href="javascript:;" onClick="OnMemberSelectRemove();return false;"><img src="../images/btn_select_member_cancel_w.gif" width="117" height="19" border="0"></a></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="40" align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
	</tr>
</form>
</table>
<script language="javascript">
	var SET_intMemberCount = "<%=intTotalCount%>";
	var SET_strGroupCode   = "<%=strCode%>";

	function select_all(){
		obj = document.all['strLoginID'];
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

	function OnMemberRemove(str){
		if(confirm("선택한 회원을 삭제하시겠습니까?")){
			document.theForm.action = "MailingGroupMember_ok.asp?Action=remove&strCode=" + SET_strGroupCode + "&strLoginID=" + str;
			document.theForm.submit();
		}
	}

	function OnMemberSelectRemove(){
		if (SET_intMemberCount == "0"){
			alert("삭제할 회원이 없습니다.");
			return false;
		}
		var k = 0;
		obj = document.all['strLoginID'];
		if(!obj) return false;
		var cntBox = obj.length - 1;
		for(var i = 0; i <= cntBox; i++){
			if (obj[i].checked == true){
				k++;
			}
		}
		if (k == 0){
			alert("삭제할 회원을 선택해 주시기 바랍니다.");
			return false;
		}

		if(confirm("선택된 회원을 삭제하시겠습니까?")){
			document.theForm.action = "MailingGroupMember_ok.asp?Action=sRemove&strCode=" + SET_strGroupCode;
			document.theForm.submit();
		}

	}

	function OnPageMove(intPage){

		document.theForm.action = "MailingGroupMemberList.asp?strCode=" + SET_strGroupCode + "&intPage=" + intPage;
		document.theForm.submit();

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