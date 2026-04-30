<!-- #include file = "../../../../Include/BoardIncludeComment.asp" -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#E0E1DB">
				<tr>
					<td bgcolor="#FFFFFF" style="padding:10px 10px 10px 10px">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
<% IF CONF_bitCommentLevel = True THEN %>
<% IF CMT_intCount <> "" THEN %>
<% FOR CMT_LIST = 0 TO CMT_intCount %>
							<tr>
								<td<% IF CMT_REDIM_intDepth(CMT_LIST) > 0 THEN %> bgcolor="#F4F4F4" style="padding-left:<%=CMT_REDIM_intDepth(CMT_LIST)*15%>px"<% END IF %>>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
<% IF CMT_REDIM_intDepth(CMT_LIST) > 0 THEN %>
														<td width="15"><img src="<%=skinPath%>images/comment_reply.gif" width="9" height="8" /></td>
<% END IF %>
														<td style="padding-top:10px; padding-bottom:10px;">
														<% IF CMT_REDIM_strMarkName(CMT_LIST) <> False THEN %><%=CMT_REDIM_strMarkName(CMT_LIST)%><% END IF %>
														<a href="javascript:;" onClick="showSideView(this, '<%=CONF_strNameClick%>','<%=CMT_REDIM_strLoginID(CMT_LIST)%>','<%=CMT_REDIM_strName(CMT_LIST)%>','False','','');return false;">
														<% IF CMT_REDIM_NameImage(CMT_LIST) = False THEN %><b><%=CMT_REDIM_strName(CMT_LIST)%></b><% ELSE %><%=CMT_REDIM_NameImage(CMT_LIST)%><% END IF %></a>
														</td>
														<td align="right" style="padding-right:10px;">
														<span style="font:9px Tahoma; margin:.3em 0 .5em 0;"><%=CMT_REDIM_dateRegDate(CMT_LIST)%><% IF CONF_bitCommentIp = True THEN %>&nbsp;(<%=CMT_REDIM_strIpAddr(CMT_LIST)%>)<% END IF %></span><% IF CMT_REDIM_Remove(CMT_LIST) <> 0 THEN %>&nbsp;<a href="javascript:;" onClick="OnEraseComment('<%=CMT_REDIM_intSeq(CMT_LIST)%>');return false;"><img src="<%=skinPath%>images/btn_comment_del.gif" align="absmiddle" border="0"></a><% END IF %><% IF CMT_REDIM_Edit(CMT_LIST) = True THEN %>&nbsp;<a href="javascript:;" onClick="OnCommentEdit('<%=CMT_REDIM_intSeq(CMT_LIST)%>', '<%=intSeq%>');return false;"><img src="<%=skinPath%>images/btn_comment_edit.gif" align="absmiddle" border="0"></a><% END IF %><% IF CONF_bitCommentReplyLevel = True THEN %>&nbsp;<a href="javascript:;" onClick="OnCommentReply('<%=CMT_REDIM_intSeq(CMT_LIST)%>');return false;"><img src="<%=skinPath%>images/btn_comment_reply.gif" align="absbottom" border="0"></a><% END IF %>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
<% IF CMT_REDIM_intDepth(CMT_LIST) > 0 THEN %>
														<td width="15"></td>
<% END IF %>
														<td style="word-break:break-all; line-height:18px; padding-top:10px; padding-bottom:10px;"><%=CMT_REDIM_strContent(CMT_LIST)%></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="1" bgcolor="#EEEEEE"></td>
										</tr>
									</table>
								</td>
							</tr>
<% NEXT %>
<% END IF %>
<% END IF %>
<% IF CONF_bitCommentWriteLevel = True THEN %>
							<tr>
								<td style="padding-top:5px;">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="30">
											글쓴이</font>
											<% IF SESSION("strLoginID") = "" THEN %>
											<input type="text" size="10" name="cmtName" maxlength="20" tabindex="2">
											비밀번호
											<input type="password" size="10" name="cmtPwd" maxlength="20" tabindex="3">
											<% ELSE %>
											<%=SESSION("strLoginName")%>
											<input type="hidden" name="cmtName" maxlength="10" value="<%=SESSION("strLoginName")%>">
											<% END IF %></td>
										</tr>
										<tr>
											<td>
											<textarea name="cmtContent" id="cmtContent" style="width:100%;<% IF CONF_bitUseEditor = True THEN %> display:none<% ELSE %>block<% END IF %>" rows="5" tabindex=1 class="textarea"></textarea><% IF CONF_bitUseEditor = True THEN %><script type="text/javascript" language="javascript">myeditor.run();</script><% END IF %>
											</td>
										</tr>
									</table>
								</td>
							</tr>
<% END IF %>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
<% IF CONF_bitCommentWriteLevel = True THEN %>
	<tr>
		<td height="40" align="right"><a href="javascript:OnAddComment('<%=intSeq%>', '<%=SESSION("strLoginID")%>', '<%=AdRs_intThread%>');"><img src="<%=skinPath%>images/btn_comment_add.gif" width="79" height="23" border="0"></a></td>
	</tr>
<% END IF %>
</table>