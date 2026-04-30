<!-- #include file = "../../../../Include/BoardIncludeLogin.asp" -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="<%=LOGIN_strFormUrl%>" onSubmit="return OnBoardLoginCheck();">
	<tr>
		<td align="center">
			<table width="300" border="0" cellspacing="1" cellpadding="0" bgcolor="#DFDFDF">
				<tr>
					<td bgcolor="#FFFFFF" style="padding:10px 10px 10px 10px">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="30" style="font-size:16px"><b>로그인</b></td>
							</tr>
							<tr>
								<td height="1" bgcolor="#CCCCCC"></td>
							</tr>
							<tr>
								<td height="2" bgcolor="#F3F3F3"></td>
							</tr>
							<tr>
								<td height="60" align="center">
									<table border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="30" align="right" style="padding-right:10px;">아이디</td>
											<td><input name="strLoginID" type="text" id="strLoginID" size="20"></td>
										</tr>
										<tr>
											<td height="30" align="right" style="padding-right:10px;">비밀번호</td>
											<td height="30"><input name="strLoginPwd" type="password" id="strLoginPwd" size="20"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="1" bgcolor="#DFDFDF"></td>
							</tr>
							<tr>
								<td height="40" align="right" valign="bottom">
								<input type="image" name="imageField" src="<%=skinPath%>images/btn_login.gif"  border="0" class="no_Line">
								<a href="javascript:;" onClick="history.go(-1);"><img src="<%=skinPath%>images/btn_back.gif" border="0" /></a></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>