<!-- #include file = "../../../../Include/BoardIncludeCommentAdd.asp" -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<% IF UCASE(Action) = "CMTREPLY" THEN %>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#DFDFDF">
				<tr>
					<td bgcolor="#FFFFFF" style="padding:10px 10px 10px 10px">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
											<% IF CMT_strMarkName <> False THEN %><%=CMT_strMarkName%><% END IF %>
											<a href="javascript:;" onClick="showSideView(this, '<%=CONF_strNameClick%>','<%=CMT_strLoginID%>','<%=CMT_strName%>','','');return false;"><% IF CMT_strNameImage = False THEN %><%=CMT_strReplyName%><% ELSE %><%=CMT_strNameImage%><% END IF %></a>
											</td>
											<td align="right"><%=CMT_dateRegDate%><% IF CONF_bitCommentIp = True THEN %>&nbsp;(<%=CMT_strIpAddr%>)<% END IF %></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style="word-break:break-all; line-height:18px"><%=CMT_strContent%></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="10"></td>
	</tr>
<% END IF %>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#DFDFDF">
				<tr>
					<td bgcolor="#FFFFFF" style="padding:10px 10px 10px 10px">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="30">
								등록자
								<% IF SESSION("strLoginID") = "" THEN %>
								<input name="cmtName" type="text" class="input" id="cmtName" value="<%=CMT_strName%>" size="10" maxlength="20">
								<% ELSE %>
								<%=SESSION("strLoginName")%>
								<input type="hidden" name="cmtName" maxlength="10" value="<%=SESSION("strLoginName")%>">
								<% END IF %>
								<% IF SESSION("strLoginID") = "" THEN %>
								비밀번호
								<input name="cmtPwd" type="password" id="cmtPwd" size="10" maxlength="20">
								<% END IF %>
								</td>
							</tr>
							<tr>
								<td>
								<textarea name="cmtContent" cols="70" rows="16" id="cmtContent" style="display:<% IF CONF_bitUseEditor = False THEN %>block<% ELSE %>none<% END IF %>"><%=EDIT_strContent%></textarea>
								<% IF CONF_bitUseEditor = True THEN %><script type="text/javascript" language="javascript">myeditor.run();</script><% END IF %></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="40" align="right">
		<a href="<%=LINK_COMMENT_OK%>"><img src="<%=skinPath%>images/btn_comment_add.gif" border="0" align="absmiddle"></a>
		<a href="<%=LINK_COMMENT_BACK%>"><img src="<%=skinPath%>images/btn_back.gif" width="82" height="23" align="absbottom" border="0"></a></td>
	</tr>
</table>