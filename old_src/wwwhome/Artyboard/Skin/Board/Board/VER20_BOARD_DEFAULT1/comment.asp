<!-- #include file = "../../../../Include/BoardIncludeComment.asp" -->
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><img src="<%=skinPath%>images/comment_img.gif" width="187" height="44" /></td>
	</tr>
	<tr>
		<td height="2" class="cmtLine1"></td>
	</tr>
<% IF CONF_bitCommentLevel = True THEN %>
<% IF CMT_intCount <> "" THEN %>
<% FOR CMT_LIST = 0 TO CMT_intCount %>
	<tr>
		<td class="pda5"<% IF CMT_REDIM_strBoardBg(CMT_LIST) = False THEN %><% IF CMT_REDIM_intDepth(CMT_LIST) > 0 THEN %> bgcolor="#FAFAFA"<% END IF %><% ELSE %><%=CMT_REDIM_strBoardBg(CMT_LIST)%><% END IF %>>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="<% IF CMT_REDIM_intDepth(CMT_LIST) = 0 THEN %>5<% ELSE %><%=CMT_REDIM_intDepth(CMT_LIST)*20%><% END IF %>" valign="top" class="pdt10 pdr10" align="right"><% IF CMT_REDIM_intDepth(CMT_LIST) > 0 THEN %><img src="<%=skinPath%>images/comment_reply.gif" width="9" height="8"><% END IF %></td>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
											<% IF CMT_REDIM_strMarkName(CMT_LIST) <> False THEN %><%=CMT_REDIM_strMarkName(CMT_LIST)%><% END IF %>
											<a href="javascript:;" onClick="showSideView(this, '<%=CONF_strNameClick%>','<%=CMT_REDIM_strLoginID(CMT_LIST)%>','<%=CMT_REDIM_strName(CMT_LIST)%>','False','','');return false;">
											<% IF CMT_REDIM_NameImage(CMT_LIST) = False THEN %><b><%=CMT_REDIM_strName(CMT_LIST)%></b><% ELSE %><%=CMT_REDIM_NameImage(CMT_LIST)%><% END IF %></a><% IF CONF_bitCommentIp = True THEN %>&nbsp;<span class="smallFont">- <%=CMT_REDIM_strIpAddr(CMT_LIST)%></span><% END IF %></td>
											<td align="right"><span class="smallFont"><%=CMT_REDIM_dateRegDate(CMT_LIST)%></span><% IF CMT_REDIM_Remove(CMT_LIST) <> 0 THEN %>&nbsp;<a href="javascript:;" onClick="OnEraseComment('<%=CMT_REDIM_intSeq(CMT_LIST)%>');return false;"><img src="<%=skinPath%>images/btn_comment_del.gif" align="absmiddle" border="0"></a><% END IF %><% IF CMT_REDIM_Edit(CMT_LIST) = True THEN %>&nbsp;<a href="javascript:;" onClick="OnCommentEdit('<%=CMT_REDIM_intSeq(CMT_LIST)%>', '<%=intSeq%>');return false;"><img src="<%=skinPath%>images/btn_comment_edit.gif" align="absmiddle" border="0"></a><% END IF %><% IF CONF_bitCommentReplyLevel = True THEN %>&nbsp;<a href="javascript:;" onClick="OnCommentReply('<%=CMT_REDIM_intSeq(CMT_LIST)%>');return false;"><img src="<%=skinPath%>images/btn_comment_reply.gif" align="absbottom" border="0"></a><% END IF %></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style="word-break:break-all; line-height:18px"><%=CMT_REDIM_strContent(CMT_LIST)%></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" class="cmtLine3"></td>
	</tr>
<% NEXT %>
<% END IF %>
<% END IF %>
<% IF CONF_bitCommentWriteLevel = True THEN %>
	<tr>
		<td align="center" class="cmtBG1 pdt5 pdb5">
		  <table width="96%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><textarea name="cmtContent" id="cmtContent" style="width:100%;<% IF CONF_bitUseEditor = True THEN %> display:none<% ELSE %>block<% END IF %>" rows="5" tabindex=1 class="textarea"></textarea><% IF CONF_bitUseEditor = True THEN %><script type="text/javascript" language="javascript">myeditor.run();</script><% END IF %></td>
								<td width="63" align="right"><a href="javascript:OnAddComment('<%=intSeq%>', '<%=SESSION("strLoginID")%>', '<%=AdRs_intThread%>');"><img src="<%=skinPath%>images/btn_comment.gif" border="0" align="absmiddle" tabindex="4" /></a></td>
							</tr>
							<tr>
								<td class="pdt5">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="right">등록자&nbsp;<% IF SESSION("strLoginID") = "" THEN %><input type="text" size="20" name="cmtName" maxlength="20" tabindex="2">&nbsp;&nbsp;비밀번호&nbsp;<input type="password" size="20" name="cmtPwd" maxlength="20" tabindex="3"><% ELSE %><b><%=SESSION("strLoginName")%></b><input type="hidden" name="cmtName" value="<%=SESSION("strLoginName")%>"><% END IF %></td>
										</tr>
									</table>
								</td>
								<td></td>
							</tr>
						</table>
					</td>
				</tr>
		  </table>
	  </td>
	</tr>
<% END IF %>
	<tr>
		<td height="1" class="cmtLine1"></td>
	</tr>
</table>