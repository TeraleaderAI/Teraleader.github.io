<!-- #include file = "../../../../Include/BoardIncludeDelete.asp" -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="<%=strFormLink%>" onSubmit="return OnDeleteCheck();">
	<tr>
		<td align="center">
			<table width="300" border="0" cellspacing="1" cellpadding="0" bgcolor="#DFDFDF">
				<tr>
					<td bgcolor="#FFFFFF" style="padding:10px 10px 10px 10px">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="30" style="font-size:16px"><b>게시글 삭제</b></td>
							</tr>
							<tr>
								<td height="1" bgcolor="#CCCCCC"></td>
							</tr>
							<tr>
								<td height="2" bgcolor="#F3F3F3"></td>
							</tr>
							<tr>
								<td height="60">
<% SELECT CASE strBoardDeleteMode %>
<% CASE "0" %>
								삭제 권한이 없습니다.
<% CASE "1" %>
								비밀번호 입력 
								<input name="strPassword" type="password" id="strPassword" size="20" maxlength="20">
<% CASE "2" %>
								게시글을 삭제하시겠습니까?
<% END SELECT %>
								</td>
							</tr>
							<tr>
								<td height="1" bgcolor="#DFDFDF"></td>
							</tr>
							<tr>
								<td height="40" align="right" valign="bottom">
								<% IF strBoardDeleteMode <> "0" THEN %><input type="image" name="imageField" id="imageField" src="<%=skinPath%>images/btn_delete2.gif" class="no_Line"><% END IF %>
								<a href="javascript:;" onClick="history.back(-1);return false;"><img src="<%=skinPath%>images/btn_back.gif" width="82" height="23" border="0"></a></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>