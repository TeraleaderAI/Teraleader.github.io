<!-- #include file = "../../../../Include/BoardIncludeListReply.asp" -->
<% IF REPLY_COUNT <> 0 THEN %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:5px; padding-bottom:5px;">
			<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#E0E1DB">
				<tr>
					<td bgcolor="#FFFFFF" style="padding-top:5px; padding-bottom:5px;">
						<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<% FOR REPLY_LIST = 0 TO REPLY_COUNT %>
							<tr<% IF CONF_bitMouseOver = True THEN %> onMouseOver="Onrollover(this, '<%=CONF_strMouseOverColor%>');" onMouseOut="Onrollover(this, '');"<% END IF %> height="<%=CONF_intLineHeight%>">
								<td width="50" class="pdl10">
								<% IF REPLY_LIST = 0 THEN %>¿øº»±Û
								<% END IF %></td>
								<td width="50" align="center"><% IF INT(intSeq) = INT(REPLY_intSeq(REPLY_LIST)) THEN %><img src="<%=skinPath%>images/selected_article.gif" align="absmiddle"><% ELSE %><% IF REPLY_iConFolder <> False THEN %><img src="<%=REPLY_iConFolder%>" align="absmiddle"><% END IF %><% END IF %></td>
								<td>
								<% IF REPLY_LIST > 0 THEN %><%=REPLY_iConReply(REPLY_LIST)%>&nbsp;<% END IF %><a href="<%=REPLY_strReadLink(REPLY_LIST)%>"><%=REPLY_strSubject(REPLY_LIST)%></a>
								<% IF REPLY_intComment(REPLY_LIST) > 0 THEN %><span style="font-size:9px;color:#E76322">(<%=REPLY_intComment(REPLY_LIST)%>)</span><% END IF %>
								<% IF REPLY_iConNew(REPLY_LIST) <> False THEN %>&nbsp;<img src="<%=REPLY_iConNew(REPLY_LIST)%>" border="0" align="absmiddle"><% END IF %>
							<% IF REPLY_iConSecret(REPLY_LIST) <> False THEN %>&nbsp;<img src="<%=REPLY_iConSecret(REPLY_LIST)%>" border="0" align="absmiddle"><% END IF %></td>
								<td width="80" align="center"><%=REPLY_strName(REPLY_LIST)%></td>
								<td width="80" align="center" class="boardNum"><%=REPLY_dateRegDate(REPLY_LIST)%></td>
							</tr>
							<tr>
								<td height="1" colspan="6" background="<%=REPLY_iConLine%>"></td>
							</tr>
<% NEXT %>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<% END IF %>