<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardBestList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount, I
	intPage     = REQUEST("intPage")     : IF intPage = "" THEN intPage = 1
	intPageSize = REQUEST("intPageSize") : IF intPageSize = "" THEN intPageSize = 10

	SET RS = DBCON.EXECUTE("SELECT COUNT([intNum]) AS [RecCount] FROM [MPLUS_BOARD_NOTICE] ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [intNum], [strCode], [strName], [strMemo], [intBoardCount] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_NOTICE_LIST] WHERE [strCode] = [MPLUS_BOARD_NOTICE].[strCode]), [dateRegDate] FROM [MPLUS_BOARD_NOTICE] WHERE [intNum] NOT IN (SELECT TOP " & (intPage - 1) * intPageSize & " [intNum] FROM [MPLUS_BOARD_NOTICE] ORDER BY [intNum] DESC) ORDER BY [intNum] DESC ")
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<form name="theForm" method="post">
	<tr>
		<td height="44" background="../images/pop_title_bg.gif"><img src="../images/pop_title_board_group.gif" width="155" height="44"></td>
	</tr>
	<tr>
		<td height="8"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr align="center" bgcolor="EB766F">
					<td colspan="8" class="table_Round1"></td>
				</tr>
				<tr align="center" bgcolor="EB766F">
					<td height="30" class="table_Txt1" nowrap>번호</td>
					<td height="30" class="table_Txt1" nowrap>그룹코드</td>
					<td height="30" class="table_Txt1" nowrap>그룹명</td>
					<td height="30" nowrap class="table_Txt1">그룹설명</td>
					<td nowrap class="table_Txt1">게시글수</td>
					<td nowrap class="table_Txt1">등록일자</td>
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
					<td colspan="8" class="table_ListSubText1">등록된 게시글 그룹이 없습니다.</td>
				</tr>
				<tr>
					<td colspan="8" class="table_ListSubLine1"></td>
				</tr>
<%
	ELSE
		DIM iCount, intNumber
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
				<tr bgcolor="#FFFFFF" align="center">
					<td class="table_ListSubText1"><%=intNumber%></td>
					<td class="table_ListSubText1"><%=RS("strCode")%></td>
					<td class="table_ListSubText1"><%=RS("strName")%></td>
					<td class="table_ListSubText1" align="left"><%=RS("strMemo")%></td>
					<td class="table_ListSubText1"><%=RS("intBoardCount")%></td>
					<td class="table_ListSubText1"><%=REPLACE(FORMATDATETIME(RS("dateRegDate"),2),"-","/")%></td>
					<td class="table_ListSubText1"><a href="BoardBestGroupAdd.asp?Action=edit&intNum=<%=RS("intNum")%>"><img src="../images/btn_edit_s.gif" width="38" height="16" border="0" /></a></td>
					<td class="table_ListSubText1"><a href="javascript:;" onClick="OnRemove('<%=RS("intNum")%>','<%=RS("strCode")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0" /></a></td>
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
					<td width="95"><a href="BoardBestGroupAdd.asp?Action=add"><img src="../images/btn_group_add_w.gif" width="95" height="19" border="0"></a></td>
					<td align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
				</tr>
			</table>
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

	function OnRemove(str1, str2){
		if(confirm("삭제할 그룹의 게시글까지 삭제됩니다.\n\n메인추천글 그룹을 삭제하시겠습니까?")){
			document.theForm.action = "BoardBestGroup_ok.asp?Action=remove&intNum=" + str1 + "&strCode=" + str2;
			document.theForm.submit();
		}
	}

</script>
<!-- #include file = "../Foot.asp" -->