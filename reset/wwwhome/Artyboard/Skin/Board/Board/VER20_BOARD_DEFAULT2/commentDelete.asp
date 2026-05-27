<!-- #include file = "../../../../Include/BoardIncludeCommentErase.asp" -->
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="<%=CMT_DeleteLink%>" onSubmit="return OnEraseCommentSubmit()">
  <tr>
    <td align="center">
			<table width="260"  border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="2" class="commLine1"></td>
				</tr>
				<tr>
					<td class="commTitle" align="center">댓글 삭제</td>
				</tr>
				<tr>
				  <td height="5"></td>
				</tr>
				<tr>
					<td height="56" align="center">
<% SELECT CASE strCmtDeleteMode %>
<% CASE "0" %>
								삭제 권한이 없습니다.
<% CASE "1" %>
								비밀번호 입력 
								<input name="strPassword" type="password" size="20" maxlength="20">
<% CASE "2" %>
								댓글을 삭제하시겠습니까?
<% END SELECT %>
					</td>
				</tr>
				<tr>
					<td height="35" bgcolor="#FFFFFF" align="center">
					<% IF strCmtDeleteMode <> "0" THEN %><input type="image" name="imageField" src="<%=skinPath%>images/btn_ok.gif" border="0" class="no_Line" align="absmiddle"><% END IF %>
					<a href="<%=CMT_BackLink%>"><img src="<%=skinPath%>images/btn_return.gif" border="0" align="absmiddle"></a>
					</td>
				</tr>
				<tr>
				  <td height="1" class="commLine2"></td>
				</tr>
			</table>
		</td>
  </tr>
</form>
</table>