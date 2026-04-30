<!-- #include file = "../../../../Include/BoardIncludePassword.asp" -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="<%=strFormLink%>" onSubmit="return OnPasswordCheck();">
	<tr>
		<td align="center">
			<table width="300" border="0" cellspacing="1" cellpadding="0" bgcolor="#DFDFDF">
				<tr>
					<td bgcolor="#FFFFFF" style="padding:10px 10px 10px 10px">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="30" style="font-size:16px"><b>비밀번호 확인</b></td>
							</tr>
							<tr>
								<td height="1" bgcolor="#CCCCCC"></td>
							</tr>
							<tr>
								<td height="2" bgcolor="#F3F3F3"></td>
							</tr>
							<tr>
								<td height="60">
								비밀번호 입력 
								<input name="strPassword" type="password" id="strPassword" size="20" maxlength="20">
								</td>
							</tr>
							<tr>
								<td height="1" bgcolor="#DFDFDF"></td>
							</tr>
							<tr>
								<td height="40" align="right" valign="bottom">
								<input type="image" name="imageField" id="imageField" src="<%=skinPath%>images/btn_submit.gif" class="no_Line">
								<a href="javascript:;" onClick="history.go(-1);return false;"><img src="<%=skinPath%>images/btn_back.gif" width="82" height="23" border="0"></a></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>