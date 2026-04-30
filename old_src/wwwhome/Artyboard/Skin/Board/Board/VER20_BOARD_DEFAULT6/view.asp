<!-- #include file = "../../../../Include/BoardInclude.asp" -->
<!-- #include file = "../../../../Include/BoardIncludeRead.asp" -->
<!-- #include file = "../../../../Include/BoardIncludeCategory.asp" -->
<!-- #include file = "../../../../Include/BoardIncludeListFile.asp" -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right">
		<% IF CONF_bitUseRss = True THEN %><a href="<%=CONF_strRssLink%>" target="_blank"><img src="<%=skinPath%>images/btn_rss.gif" width="13" height="13" align="absmiddle" class="topBtnMarg"></a><% END IF %>
		<% IF CONF_strLinkHomepage <> False THEN %><a href="<%=CONF_strLinkHomepage%>" target="<%=CONF_strLinkHomepageTarget%>" class="skinList">홈페이지</a>
		<% END IF %><% IF SESSION("strLoginID") = "" THEN %>		<a href="<%=CONF_strLoginLink%>" class="skinList">로그인</a>
		<% ELSE %>		<a href="<%=CONF_strLogoutLink%>" class="skinList">로그아웃</a>
		<% END IF %><% IF CONF_bitUseMemo = True THEN %>
		<% END IF %><% IF CONF_bitUseScrap = True THEN %><a href="scrap.asp?Action=list" target="_blank" class="skinList">스크랩</a>
		<% END IF %><% IF CONF_bitBoardAdmin = True THEN %><a href="Admin/Default.asp" target="_blank" class="skinList">관리자</a><% END IF %>
		</td>
	</tr>
	<tr>
		<td class="h30">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="font16"><%=READ_strSubject%></td>
					<td align="right">
					<% IF READ_strMarkImage <> False THEN %><%=READ_strMarkImage%><% END IF %>
					<a href="javascript:;" onClick="showSideView(this, '<%=CONF_strNameClick%>','<%=READ_strLoginID%>','<%=READ_strName%>','<%=READ_strEmail%>','<%=READ_strHomepage%>','<%=READ_intSeq%>');return false;">
					<% IF READ_strNameImage = False THEN %><b><%=READ_strName%></b><% ELSE %><%=READ_strNameImage%><% END IF %>
					</a></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td bgcolor="#E0E1DB" height="1"></td>
	</tr>
	<tr>
		<td align="right" class="h30 font11">조회 : <%=READ_intRead%>, <% IF CONF_bitUseVote <> False THEN %>추천 : <%=READ_intVote%>,<% END IF %> 등록일 : <%=READ_dateRegDate%><% IF CONF_bitContentIp = True THEN %>&nbsp;(<%=READ_strIpAddr%>)<% END IF %></td>
	</tr>
<% IF READ_strLink1 <> False THEN %>
	<tr>
		<td align="right" class="h20"><a href="<%=READ_strLink1%>" target="<%=READ_strLinkTarget1%>"><%=READ_strLink1%></a></td>
	</tr>
<% END IF %>
<% IF READ_strLink2 <> False THEN %>
	<tr>
		<td class="h20" align="right"><a href="<%=READ_strLink2%>" target="<%=READ_strLinkTarget2%>"><%=READ_strLink2%></a></td>
	</tr>
<% END IF %>
<% IF CONF_bitUseUpload = True AND CONF_bitImgView = True AND READ_intImgCount > 0 THEN %>
  <tr>
    <td>
    	<!-- #include file = "imgList.asp" -->
    </td>
  </tr>
<% END IF %>
<% IF CONF_bitUseUpload = True AND CONF_bitFileExe = True THEN %>
<% FOR I = 1 TO READ_intFileCount %>
<% IF FILE_REDIM_FileExe(I) <> False THEN %>
  <tr>
    <td class="pdt5" align="center"><%=FILE_REDIM_FileExe(I)%></td>
  </tr>
<% END IF %>
<% NEXT %>
<% END IF %>
	<tr>
		<td class="pda5"<% IF READ_strBoardBg <> False THEN %><%=READ_strBoardBg%><% END IF %> style="line-height:20px;<% IF CONF_bitWordBreak = True THEN %> word-break:break-all;<% END IF %>"><%=READ_strContent%></td>
	</tr>
	<tr>
		<td class="h40" align="right">
		<a href="<%=READ_strPrintLink%>"><img src="<%=skinPath%>images/btn_print.gif" border="0" /></a>
		<% IF CONF_bitUseBad = True THEN %><a href="<%=READ_strBadLink%>"><img src="<%=skinPath%>images/btn_bad.gif" border="0" /></a><% END IF %>
		</td>
	</tr>
<% IF CONF_bitUseSign = True THEN %>
	<tr>
		<td class="pdt5 pdb5">
			<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#DFDFDF">
<% IF READ_strUserSign <> "" AND ISNULL(READ_strUserSign) = False THEN %>
				<tr>
					<td bgcolor="#FFFFFF" style="padding:20px 10px 20px 10px"><%=READ_strUserSign%></td>
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
<% IF CONF_bitUseUpload = True AND READ_intFileCount > 0 THEN %>
	<tr>
		<td class="pdt5 pdb5">
			<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#EFEFEF">
				<tr>
					<td bgcolor="#F4F4F4" class="pda5"><!-- #include file = "fileList.asp" --></td>
				</tr>
			</table>
		</td>
	</tr>
<% END IF %>
<% IF (CONF_bitPrevNext = True AND READ_intPrevSeq <> 0) OR (CONF_bitPrevNext = True AND READ_intNextSeq <> 0) THEN %>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#E0E1DB">
				<tr>
					<td bgcolor="#FFFFFF" class="pdt5 pdb5">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
<% IF CONF_bitPrevNext = True AND READ_intPrevSeq <> 0 THEN %>
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr<% IF CONF_bitMouseOver = True THEN %> onMouseOver="Onrollover(this, '<%=CONF_strMouseOverColor%>');" onMouseOut="Onrollover(this, '');"<% END IF %> height="<%=CONF_intLineHeight%>">
											<td class="pdl10" width="40"><img src="<%=skinPath%>images/btn_prevlist.gif"></td>
											<td width="50" align="center"><%=READ_intPrevSeq%></td>
											<td><% IF READ_iConFolder <> False THEN %><img src="<%=READ_iConFolder%>" align="absmiddle">&nbsp;<% END IF %><a href="<%=READ_strPrevReadLink%>"><%=READ_strPrevSubject%></a>
											<% IF READ_iConNewPrev <> False THEN %><img src="<%=READ_iConNewPrev%>" align="absmiddle"><% END IF %>
											<% IF READ_iConSecretPrev <> False THEN %><img src="<%=READ_iConSecretPrev%>" align="absmiddle"><% END IF %>
											<% IF READ_intPrevComment > 0 THEN %><span style="font-size:9px;color:#E76322">(<%=READ_intPrevComment%>)</span><% END IF %>					</td>
											<td width="80" align="center"><%=READ_strPrevName%></td>
											<td width="80" align="center" class="boardNum"><%=GetDateType(1, READ_datePrevRegDate)%></td>
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
											<td class="pdl10" width="40"><img src="<%=skinPath%>images/btn_nextlist.gif" /></td>
											<td width="50" align="center"><%=READ_intNextSeq%></td>
											<td><% IF READ_iConFolder <> False THEN %><img src="<%=READ_iConFolder%>" align="absmiddle">&nbsp;<% END IF %><a href="<%=READ_strNextReadLink%>"><%=READ_strNextSubject%></a>
											<% IF READ_iConNewNext <> False THEN %><img src="<%=READ_iConNewNext%>" align="absmiddle"><% END IF %>
											<% IF READ_iConSecretNext <> False THEN %><img src="<%=READ_iConSecretNext%>" align="absmiddle"><% END IF %>
											<% IF READ_intNextComment > 0 THEN %><span style="font-size:9px;color:#E76322">(<%=READ_intNextComment%>)</span><% END IF %>					</td>
											<td width="80" align="center"><%=READ_strNextName%></td>
											<td width="80" align="center" class="boardNum"><%=GetDateType(1, READ_dateNextRegDate)%></td>
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
<% END IF %>
<% IF CONF_bitListReple = True THEN %>
	<tr>
		<td>
		<!-- #include file = "replyList.asp" -->
		</td>
	</tr>
<% END IF %>
	<tr>
		<td>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="35">
					<% IF CONF_bitWriteLevel = True THEN %><a href="javascript:OnBoardWrite('write');"><img src="<%=skinPath%>images/btn_write.gif" border="0" style="margin-right:5px"></a><% END IF %><% IF CONF_bitRepleLevel = True THEN %><a href="javascript:OnBoardWrite('reply','<%=intSeq%>');"><img src="<%=skinPath%>images/btn_reply.gif" border="0" style="margin-right:5px"></a><% END IF %><% IF CONF_bitEditLevel = True THEN %><a href="javascript:OnBoardWrite('edit','<%=intSeq%>');"><img src="<%=skinPath%>images/btn_edit.gif" border="0" style="margin-right:5px"></a><% END IF %><% IF CONF_bitRemoveLevel = True THEN %><a href="javascript:OnBoardRemove('<%=intSeq%>');"><img src="<%=skinPath%>images/btn_delete.gif" border="0" style="margin-right:5px"></a><% END IF %>
					<% IF CONF_bitUseVote = True THEN %><a href="javascript:OnVote('<%=intSeq%>');"><img src="<%=skinPath%>images/btn_vote.gif"  border="0" style="margin-right:5px"></a><% END IF %>
					<% IF CONF_bitUseScrap = True THEN %><a href="javascript:OnScrap('<%=intSeq%>');"><img src="<%=skinPath%>images/btn_scrap.gif" border="0"></a><% END IF %>					</td>
					<td height="35" align="right"><a href="javascript:OnBoardList();"><img src="<%=skinPath%>images/btn_list.gif" border="0" style="margin-right:2"></a></td>
				</tr>
			</table>
		</td>
	</tr>
<% IF CONF_bitUseComment = True AND CONF_bitCommentLevel = True THEN %>
	<tr>
		<td style="padding-top:5px; padding-bottom:5px;">
		<!-- #include file = "comment.asp" -->
		</td>
	</tr>
<% END IF %>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<% NEXT %>