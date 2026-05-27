<!-- #include file = "../../../../Include/BoardIncludeCommentAdd.asp" -->
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="30" colspan="2" align="center"><% IF UCASE(Action) = "CMTREPLY" THEN %>댓글답변<% ELSE %>댓글수정<% END IF %></td>
	</tr>
	<tr>
		<td height="2" colspan="2" class="cmtLine4"></td>
	</tr>
	<tr>
		<td>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<% IF UCASE(Action) = "CMTREPLY" THEN %>
				<tr>
					<td class="write_table_left">댓글정보</td>
					<td class="write_table_right">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
											<% IF CMT_strMarkName <> False THEN %><%=CMT_strMarkName%><% END IF %>
											<a href="javascript:;" onClick="showSideView(this, '<%=CONF_strNameClick%>','<%=CMT_strLoginID%>','<%=CMT_strName%>','','');return false;"><% IF CMT_strNameImage = False THEN %><%=CMT_strReplyName%><% ELSE %><%=CMT_strNameImage%><% END IF %></a>
											</td>
											<td align="right"><span class="smallFont"><%=CMT_dateRegDate%><% IF CONF_bitCommentIp = True THEN %>&nbsp;(<%=CMT_strIpAddr%>)<% END IF %></span></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style="word-break:break-all;"><%=CMT_strContent%></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="2" class="cmtLine1"></td>
				</tr>
<% END IF %>
				<tr>
					<td class="write_table_left">등록자</td>
					<td class="write_table_right"><% IF UCASE(Action) = "CMTEDIT" THEN %><input name="cmtName" type="hidden" value="<%=CMT_strName%>"><%=CMT_strName%><% ELSE %><input name="cmtName" type="text" class="input" id="cmtName" maxlength="20" value="<%=CMT_strName%>"><% END IF %></td>
				</tr>
				<tr>
					<td height="1" colspan="2" class="cmtLine1"></td>
				</tr>
<% IF SESSION("strLoginID") = "" THEN %>
				<tr>
					<td class="write_table_left">비밀번호</td>
					<td class="write_table_right"><input name="cmtPwd" type="password" id="cmtPwd" maxlength="20"></td>
				</tr>
				<tr>
					<td height="1" colspan="2" class="cmtLine1"></td>
				</tr>
<% END IF %>
				<tr>
					<td class="write_table_left">내용</td>
					<td class="write_table_right"><textarea name="cmtContent" cols="70" rows="16" id="cmtContent" style="display:<% IF CONF_bitUseEditor = False THEN %>block<% ELSE %>none<% END IF %>; width:100%"><%=EDIT_strContent%></textarea>
					<% IF CONF_bitUseEditor = True THEN %><script type="text/javascript" language="javascript">myeditor.run();</script><% END IF %></td>
				</tr>
			</table>
		</td>
	</tr>
  <tr>
    <td height="2" class="cmtLine1"></td>
  </tr>
  <tr>
    <td height="1" class="cmtLine5"></td>
  </tr>
  <tr align="center">
    <td height="40"><a href="<%=LINK_COMMENT_OK%>"><img src="<%=skinPath%>images/btn_save.gif" border="0" align="absmiddle"></a>&nbsp;<a href="javascript:history.go(-1);"><img src="<%=skinPath%>images/btn_return.gif" border="0" align="absmiddle"></a></td>
  </tr>
</table>