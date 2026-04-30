<!-- #include file = "../../../../Include/BoardInclude.asp" -->
<!-- #include file = "../../../../Include/BoardIncludeRead.asp" -->
<!-- #include file = "../../../../Include/BoardIncludeCategory.asp" -->
<!-- #include file = "../../../../Include/BoardIncludeListFile.asp" -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="28" align="right"><% IF CONF_strLinkHomepage <> False THEN %><a href="<%=CONF_strLinkHomepage%>" target="<%=CONF_strLinkHomepageTarget%>"><img src="<%=skinPAth%>images/shome.gif" width="34" height="8" border="0" style="margin-right:5px;"></a><% END IF %><% IF SESSION("strLoginID") = "" THEN %><a href="<%=CONF_strMemberJoinLink%>"><img src="<%=skinPath%>images/sjoin.gif" width="29" height="8" border="0" style="margin-right:5px;"></a><a href="<%=CONF_strLoginLink%>"><img src="<%=skinPath%>images/slogin.gif" width="34" height="8" border="0" style="margin-right:5px;"></a><% ELSE %><a href="<%=CONF_strMemberEditLink%>"><img src="<%=skinPath%>images/smyinfo.gif" width="41" height="8" border="0" style="margin-right:5px;"></a><a href="<%=CONF_strLogoutLink%>"><img src="<%=skinPath%>images/slogout.gif" width="41" height="8" border="0" style="margin-right:5px;"></a><% END IF %><% IF CONF_bitUseMemo = True THEN %><a href="memo.asp?Action=list"><img src="<%=skinPath%>images/smemo.gif" width="34" height="8" border="0" style="margin-right:5px;"></a><% END IF %><% IF CONF_bitUseScrap = True THEN %><a href="scrap.asp?Action=list" target="_blank"><img src="<%=skinPath%>images/sscrap.gif" width="38" height="8" border="0" style="margin-right:5px;"></a><% END IF %><% IF CONF_bitBoardAdmin = True THEN %><a href="Admin/Default.asp" target="_blank"><img src="<%=skinPath%>images/sadmin.gif" width="36" height="8" border="0"></a><% END IF %></td>
  </tr>
  <tr>
    <td>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<col width=65></col><col width=></col>
				<tr>
					<td height="2" colspan="2" class="viewLine1"></td>
				</tr>
				<tr>
					<td height="1" colspan="2" class="viewLine3"></td>
				</tr>
				<tr>
					<td class="view_table_left">제 목</td>
					<td class="pdl10" style="color:#2A2C29; font-weight:bold"><%=READ_strSubject%></td>
				</tr>
				<tr>
					<td height="1" colspan="2" class="viewLine2"></td>
				</tr>
				<tr>
					<td class="view_table_left">글쓴이</td>
					<td class="pdl10"><% IF READ_strMarkImage <> False THEN %><%=READ_strMarkImage%><% END IF %>
					<a href="javascript:;" onClick="showSideView(this, '<%=CONF_strNameClick%>','<%=READ_strLoginID%>','<%=READ_strName%>','<%=READ_strEmail%>','<%=READ_strHomepage%>','<%=READ_intSeq%>');return false;">
					<% IF READ_strNameImage = False THEN %><b><%=READ_strName%></b><% ELSE %><%=READ_strNameImage%><% END IF %>
					</a></td>
				</tr>
				<tr>
					<td height="1" colspan="2" class="viewLine2"></td>
				</tr>
				<tr>
					<td class="view_table_left">글정보</td>
					<td class="pdl10 smallFont">Hit : <%=READ_intRead%>, <% IF CONF_bitUseVote <> False THEN %>Vote : <%=READ_intVote%>,<% END IF %> Date : <%=READ_dateRegDate%><% IF CONF_bitContentIp = True THEN %>&nbsp;(ip : <%=READ_strIpAddr%>)<% END IF %></td>
				</tr>
				<tr>
					<td height="1" colspan="2" class="viewLine2"></td>
				</tr>
			</table>
		</td>
	</tr>
<% IF READ_strLink1 <> False THEN %>
	<tr>
		<td height="20" class="smallFont" style="padding:2px">·&nbsp;Site Link1 : <a href="<%=READ_strLink1%>" target="<%=READ_strLinkTarget1%>"><%=READ_strLink1%></a></td>
	</tr>
<% END IF %>
<% IF READ_strLink2 <> False THEN %>
	<tr>
		<td height="20" class="smallFont" style="padding:2px">·&nbsp;Site Link2 : <a href="<%=READ_strLink2%>" target="<%=READ_strLinkTarget2%>"><%=READ_strLink2%></a></td>
	</tr>
<% END IF %>
<% IF CONF_bitUseUpload = True AND CONF_bitImgView = True AND READ_intImgCount > 0 THEN %>
  <tr>
    <td><!-- #include file = "imgList.asp" --></td>
  </tr>
<% END IF %>
<% IF CONF_bitUseUpload = True AND CONF_bitFileExe = True THEN %>
<% FOR I = 1 TO READ_intDefaultFileCount %>
<% IF FILE_REDIM_FileExe(I) <> False THEN %>
  <tr>
    <td class="pda5" align="center"><%=FILE_REDIM_FileExe(I)%></td>
  </tr>
<% END IF %>
<% NEXT %>
<% END IF %>
	<tr>
		<td align="right" class="pdt10 pdb10"><a href="<%=READ_strPrintLink%>"><img src="<%=skinPath%>images/btn_print.gif" border="0" style="margin-right:5px"></a><% IF CONF_bitUseBad = True THEN %><a href="<%=READ_strBadLink%>"><img src="<%=skinPath%>images/btn_badlist.gif" border="0" /></a><% END IF %></td>
  </tr>
	<tr>
		<td<% IF READ_strBoardBg <> False THEN %><%=READ_strBoardBg%><% END IF %> class="pda10" style="<% IF CONF_bitWordBreak = True THEN %> word-break:break-all;<% END IF %>"><%=READ_strContent%></td>
	</tr>
<% IF CONF_bitUseSign = True THEN %>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#DFDFDF">
<% IF READ_strUserSign <> "" AND ISNULL(READ_strUserSign) = False THEN %>
				<tr>
					<td bgcolor="#FFFFFF" style="padding:10px 10px 10px 10px"><%=READ_strUserSign%></td>
				</tr>
<% ELSE %>
				<tr>
					<td bgcolor="#FFFFFF" style="padding:10px 10px 10px 10px"><b><%=READ_strLoginName%><b>님(<%=READ_strLoginID%>)께서는 아직 인사말(서명)을 등록하지 않으셨습니다.</td>
				</tr>
<% END IF %>
			</table>
		</td>
	</tr>
<% END IF %>
<% IF CONF_bitUseComment = True AND CONF_bitCommentLevel = True THEN %>
	<tr>
		<td style="padding-top:15px"><!-- #include file = "comment.asp" --></td>
	</tr>
<% ELSE %>
	<tr>
		<td height="2" class="viewLine4"></td>
	</tr>
<% END IF %>
<% IF CONF_bitPrevNext = True AND READ_intPrevSeq <> 0 THEN %>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr<% IF CONF_bitMouseOver = True THEN %> onMouseOver="Onrollover(this, '<%=CONF_strMouseOverColor%>');" onMouseOut="Onrollover(this, '');"<% END IF %> height="<%=CONF_intLineHeight%>">
					<td class="pdl10" width="60"><img src="<%=skinPath%>images/btn_prevlist.gif"></td>
					<td width="40" align="center" class="smallFont"><%=READ_intPrevSeq%></td>
					<td><% IF READ_iConFolder <> False THEN %><img src="<%=READ_iConFolder%>" align="absmiddle">&nbsp;<% END IF %><a href="<%=READ_strPrevReadLink%>"><%=READ_strPrevSubject%></a>
					<% IF READ_iConNewPrev <> False THEN %><img src="<%=READ_iConNewPrev%>" align="absmiddle"><% END IF %>
					<% IF READ_iConSecretPrev <> False THEN %><img src="<%=READ_iConSecretPrev%>" align="absmiddle"><% END IF %>
					<% IF READ_intPrevComment > 0 THEN %><span class="smallFont" style="color:#E76322">(<%=READ_intPrevComment%>)</span><% END IF %>					</td>
					<td width="80"><%=READ_strPrevName%></td>
				</tr>
			</table>
		</td>
	</tr>
<% END IF %>
<% IF CONF_bitPrevNext = True AND READ_intNextSeq <> 0 THEN %>
	<tr>
		<td>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr<% IF CONF_bitMouseOver = True THEN %> onMouseOver="Onrollover(this, '<%=CONF_strMouseOverColor%>');" onMouseOut="Onrollover(this, '');"<% END IF %> height="<%=CONF_intLineHeight%>">
					<td class="pdl10" width="60"><img src="<%=skinPath%>images/btn_nextlist.gif"></td>
					<td width="40" align="center" class="smallFont"><%=READ_intNextSeq%></td>
					<td><% IF READ_iConFolder <> False THEN %><img src="<%=READ_iConFolder%>" align="absmiddle">&nbsp;<% END IF %><a href="<%=READ_strNextReadLink%>"><%=READ_strNextSubject%></a>
					<% IF READ_iConNewNext <> False THEN %><img src="<%=READ_iConNewNext%>" align="absmiddle"><% END IF %>
					<% IF READ_iConSecretNext <> False THEN %><img src="<%=READ_iConSecretNext%>" align="absmiddle"><% END IF %>
					<% IF READ_intNextComment > 0 THEN %><span class="smallFont" style="color:#E76322">(<%=READ_intNextComment%>)</span><% END IF %>					</td>
					<td width="80"><%=READ_strNextName%></td>
				</tr>
			</table>
		</td>
  </tr>
	<tr>
		<td height="1" class="viewLine5"></td>
	</tr>
<% END IF %>
<% IF CONF_bitListReple = True THEN %>
	<tr>
		<td><!-- #include file = "replyList.asp" --></td>
	</tr>
<% END IF %>
	<tr>
		<td>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="35"><% IF CONF_bitWriteLevel = True THEN %><a href="javascript:OnBoardWrite('write');"><img src="<%=skinPath%>images/btn_write.gif" border="0" style="margin-right:3px"></a><% END IF %><% IF CONF_bitRepleLevel = True THEN %><a href="javascript:OnBoardWrite('reply','<%=intSeq%>');"><img src="<%=skinPath%>images/btn_reply.gif" border="0" style="margin-right:3px"></a><% END IF %><% IF CONF_bitEditLevel = True THEN %><a href="javascript:OnBoardWrite('edit','<%=intSeq%>');"><img src="<%=skinPath%>images/btn_modify.gif" border="0" style="margin-right:3px"></a><% END IF %><% IF CONF_bitRemoveLevel = True THEN %><a href="javascript:OnBoardRemove('<%=intSeq%>');"><img src="<%=skinPath%>images/btn_delete.gif" border="0" style="margin-right:3px"></a><% END IF %><% IF CONF_bitUseVote = True THEN %><a href="javascript:OnVote('<%=intSeq%>');"><img src="<%=skinPath%>images/btn_vote.gif"  border="0" style="margin-right:3px"></a><% END IF %><% IF CONF_bitUseScrap = True THEN %><a href="javascript:OnScrap('<%=intSeq%>');"><img src="<%=skinPath%>images/btn_scrap.gif" border="0"></a><% END IF %>					</td>
					<td height="35" align="right"><a href="javascript:OnBoardList();"><img src="<%=skinPath%>images/btn_list.gif" border="0" style="margin-right:2"></a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<% NEXT %>