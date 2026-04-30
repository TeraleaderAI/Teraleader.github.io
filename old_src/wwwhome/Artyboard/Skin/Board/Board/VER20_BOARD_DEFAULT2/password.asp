<!-- #include file = "../../../../Include/BoardIncludePassword.asp" -->
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="<%=strFormLink%>" onSubmit="return OnPasswordCheck();">
  <tr>
    <td align="center">
			<table width="260"  border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="2" class="commLine1"></td>
				</tr>
				<tr>
					<td class="commTitle" align="center">비밀번호 확인</td>
				</tr>
				<tr>
				  <td height="5"></td>
				</tr>
				<tr>
					<td height="56" align="center">
					비밀번호 입력
					<input name="strPassword" type="password" size="20" maxlength="20"></td>
					</tr>
				<tr>
					<td height="35" align="center"><input type="image" name="imageField" src="<%=skinPath%>images/btn_ok.gif"  border="0" class="no_Line">&nbsp; <a href="javascript:;" onClick="history.go(-1);"><img src="<%=skinPath%>images/btn_return.gif" border="0" /></a></td>
				</tr>
				<tr>
				  <td height="1" class="commLine2"></td>
				</tr>
			</table>
		</td>
  </tr>
</form>
</table>