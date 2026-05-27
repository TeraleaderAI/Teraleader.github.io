<!-- #include file = "../../../../Include/BoardIncludeLogin.asp" -->
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="<%=LOGIN_strFormUrl%>" onSubmit="return OnBoardLoginCheck();">
  <tr>
    <td>
			<table width="260"  border="0" cellpadding="0" cellspacing="0" align="center">
				<tr>
					<td height="2" colspan="2" class="commLine1"></td>
				</tr>
				<tr>
					<td colspan="2" class="commTitle" align="center">회원 로그인</td>
				</tr>
				<tr>
				  <td height="5" colspan="2"></td>
				</tr>
				<tr>
					<td height="28" class="pdl10">회원 아이디 </td>
					<td class="pdl10"><input name="strLoginID" type="text" id="strLoginID" size="20"></td>
				</tr>
				<tr>
					<td height="28" class="pdl10">비밀번호</td>
					<td class="pdl10"><input name="strLoginPwd" type="password" id="strLoginPwd" size="20"></td>
				</tr>
				<tr>
					<td height="35" colspan="2" align="center"><input type="image" name="imageField" src="<%=skinPath%>images/btn_ok.gif"  border="0" class="no_Line">&nbsp; <a href="javascript:;" onClick="history.go(-1);"><img src="<%=skinPath%>images/btn_return.gif" border="0" /></a>					</td>
				</tr>
				<tr>
				  <td height="1" colspan="2" class="commLine2"></td>
				  </tr>
			</table>
		</td>
  </tr>
</form>
</table>