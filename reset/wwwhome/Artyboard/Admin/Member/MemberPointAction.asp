<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Member/MemberList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM sMember, sMemberList, I
	sMember = REQUEST.QueryString("sMember")
	sMember = SPLIT(sMember, ",")
%>
<table width="584" border="0" cellpadding="0" cellspacing="0">
<form name="theForm" method="post" action="MemberPointAction_ok.asp" onSubmit="return OnSubmitAction();">
<input type="hidden" name="sMember" value="<%=REQUEST.QueryString("sMember")%>">
	<tr>
	  <td height="42" align="center" valign="bottom"><img src="../images/point_pop_tit.gif" width="571" height="38"></td>
	</tr>
	<tr>
	  <td valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td height="100%" align="center" valign="top">
			<table width="571" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td class="table_Left1">회원아이디</td>
								<td class="table_Right1"><%=UBOUND(sMember)%> 명의 회원이 선택되었습니다.</td>
							</tr>
							<tr>
								<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
							</tr>
							<tr>
								<td class="table_Left1">포인트 타입 </td>
								<td class="table_Right1">
								<select name="strCode" id="strCode">
				<%
					SET RS = DBCON.EXECUTE("SELECT [strCode], [strName] FROM [MPLUS_BOARD_POINT_CODE] WHERE SUBSTRING([strCode], 1, 1) = 'M' OR SUBSTRING([strCode], 1, 1) = 'E' ")
				
					WHILE NOT(RS.EOF)
						RESPONSE.WRITE "<option value='" & RS("strCode") & "'>" & RS("strName") & "</option>" & vbcrlf
					RS.MOVENEXT
					WEND
				%>
								</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
							</tr>
							<tr>
								<td class="table_Left1">지급/삭감 포인트 </td>
								<td class="table_Right1"><input name="moneyPoint" type="text" class="input" id="moneyPoint" onBlur="onlyInt(this);" size="6" maxlength="12"> 
								<span class="style1">Point</span> </td>
							</tr>
							<tr>
								<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
							</tr>
						  <tr>
								<td class="table_Left1">포인트 메모 </td>
								<td class="table_Right1"><input name="strMemo" type="text" class="input" id="strMemo" size="60" maxlength="128"></td>
							</tr>
							<tr>
								<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
							</tr>
						</table>
					</td>
        </tr>
				<tr>
					<td height="40" align="center"><input type="image" name="imageField" src="../images/btn_point_m.gif" class="no_Line"></td>
				</tr>
      </table>
			</td>
	</tr>
</form>
</table>
<script language="javascript">
	function OnSubmitAction(){
		str = document.all['moneyPoint'];
		if (str.value == ""){alert("지급 또는 삭감할 포인트를 입력해 주시기 바랍니다.");str.focus();return false;}
	}
</script>
<!-- #include file = "../Foot.asp" -->