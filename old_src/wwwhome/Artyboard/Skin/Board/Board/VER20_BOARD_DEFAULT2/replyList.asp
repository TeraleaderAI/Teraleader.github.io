<!-- #include file = "../../../../Include/BoardIncludeListReply.asp" -->
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<%
	IF REPLY_COUNT <> 0 THEN
		FOR REPLY_LIST = 0 TO REPLY_COUNT
%>
  <tr<% IF CONF_bitMouseOver = True THEN %> onMouseOver="Onrollover(this, '<%=CONF_strMouseOverColor%>');" onMouseOut="Onrollover(this, '');"<% END IF %> height="<%=CONF_intLineHeight%>">
    <td width="60" class="pdl10"><% IF REPLY_LIST = 0 THEN %>¿øº»±Û<% END IF %></td>
    <td width="40" align="center"><% IF INT(intSeq) = INT(REPLY_intSeq(REPLY_LIST)) THEN %><img src="<%=skinPath%>images/selected_article.gif" align="absmiddle"><% END IF %></td>
    <td>
		<% IF REPLY_iConFolder <> False THEN %><img src="<%=REPLY_iConFolder%>" align="absmiddle"><% END IF %>
		<% IF REPLY_LIST > 0 THEN %><%=REPLY_iConReply(REPLY_LIST)%>&nbsp;<% END IF %>
		<a href="<%=REPLY_strReadLink(REPLY_LIST)%>"><%=REPLY_strSubject(REPLY_LIST)%></a>
		<% IF REPLY_intComment(REPLY_LIST) > 0 THEN %><span class="smallFont" style="color:#E76322">(<%=REPLY_intComment(REPLY_LIST)%>)</span><% END IF %>
		<% IF REPLY_iConNew(REPLY_LIST) <> False THEN %>&nbsp;<img src="<%=REPLY_iConNew(REPLY_LIST)%>" border="0" align="absmiddle"><% END IF %>
		<% IF REPLY_iConSecret(REPLY_LIST) <> False THEN %>&nbsp;<img src="<%=REPLY_iConSecret(REPLY_LIST)%>" border="0" align="absmiddle"><% END IF %></td>
    <td width="80" align="center"><%=REPLY_strName(REPLY_LIST)%></td>
    <td width="80" align="center" class="smallFont"><%=REPLY_dateRegDate(REPLY_LIST)%></td>
    <td width="50" align="center" class="smallFont"><%=REPLY_intRead(REPLY_LIST)%></td>
  </tr>
  <tr>
    <td height="1" colspan="6" background="<%=REPLY_iConLine%>"></td>
  </tr>
<%
		NEXT
	END IF
%>
</table>