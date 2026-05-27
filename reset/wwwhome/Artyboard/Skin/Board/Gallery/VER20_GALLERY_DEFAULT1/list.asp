<!-- #include file = "../../../../Include/BoardIncludeList.asp" -->
<%
	CONF_intColSpan = CONF_intColSpan + 2
	IF CONF_bitUseSelectView = True THEN CONF_intColSpan = CONF_intColSpan + 1
	IF CONF_bitUseVote       = True THEN CONF_intColSpan = CONF_intColSpan + 1
%>
<!-- #include file = "../../../../Include/BoardIncludeCategory.asp" -->
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post">
  <tr>
    <td>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="25"><img src="<%=skinPath%>images/icon_article.gif" width="12" height="14" align="absmiddle">&nbsp;글수 <span class="skinTotal"><%=LIST_intTotalCount%></span>,&nbsp;<span class="skinPage">Page <%=LIST_intPage%> / <%=LIST_intTotalPage%></span></td>
					<td align="right">
					<% IF CONF_bitUseRss = True THEN %><a href="<%=CONF_strRssLink%>" target="_blank"><img src="<%=skinPath%>images/btn_rss.gif" width="13" height="13" align="absmiddle" class="topBtnMarg"></a><% END IF %>
					<% IF CONF_strLinkHomepage <> False THEN %><a href="<%=CONF_strLinkHomepage%>" target="<%=CONF_strLinkHomepageTarget%>" class="skinList">홈페이지</a><img src="<%=skinPath%>images/table_bar_line.gif" class="topBtnMarg"><% END IF %><% IF SESSION("strLoginID") = "" THEN %><a href="<%=CONF_strMemberJoinLink%>" class="skinList">회원가입</a><img src="<%=skinPath%>images/table_bar_line.gif" class="topBtnMarg"><a href="<%=CONF_strLoginLink%>" class="skinList">로그인</a><img src="<%=skinPath%>images/table_bar_line.gif" class="topBtnMarg"><% ELSE %><a href="<%=CONF_strMemberEditLink%>" class="skinList">정보수정</a><img src="<%=skinPath%>images/table_bar_line.gif" class="topBtnMarg"><a href="<%=CONF_strLogoutLink%>" class="skinList">로그아웃</a><img src="<%=skinPath%>images/table_bar_line.gif" class="topBtnMarg"><% END IF %><% IF CONF_bitUseMemo = True THEN %><a href="memo.asp?Action=list" class="skinList">쪽지</a><img src="<%=skinPath%>images/table_bar_line.gif" class="topBtnMarg"><% END IF %><% IF CONF_bitUseScrap = True THEN %><a href="scrap.asp?Action=list" target="_blank" class="skinList">스크랩</a><img src="<%=skinPath%>images/table_bar_line.gif" class="topBtnMarg"><% END IF %><% IF CONF_bitBoardAdmin = True THEN %><a href="Admin/Default.asp" target="_blank" class="skinList">관리자</a><% END IF %></td>
				</tr>
			</table>
		</td>
  </tr>
<% IF CONF_bitUseCategory = True THEN %>
	<tr>
		<td height="30"><%=strCategorySelect%></td>
	</tr>
<% END IF %>
	<tr>
		<td height="1" bgcolor="#E0E1DB"></td>
	</tr>
	<tr>
		<td class="h5"></td>
	</tr>
  <tr>
    <td>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
			<col width="5"><col width="40"><% IF CONF_bitUseSelectView = True THEN %><col width="20"><% END IF %><col><col width="100"><col width="75"><col width="40"><% IF CONF_bitUseVote = True THEN %><col width="40"><% END IF %><col width="5">
<% IF intPage = 1 THEN %>
<!-- #include file = "../../../../Include/BoardIncludeNoticeLoop.asp" -->
				<tr style="color:<%=CONF_strColorNoticeFont%>" align="center" bgcolor="<%=CONF_strColorNoticeBg%>" height="<%=CONF_intLineHeight%>" <% IF CONF_bitMouseOver = True THEN %>onMouseOver="Onrollover(this, '<%=CONF_strMouseOverColor%>');" onMouseOut="Onrollover(this, '');"<% END IF %>>
					<td></td>
					<td bgcolor="<%=CONF_strColorNoticeBg%>"><% IF LIST_iConNotice <> False THEN %><img src="<%=LIST_iConNotice%>"><% END IF %></td>
<% IF CONF_bitUseSelectView = True THEN %>
					<td><input name="checkIntSeq" type="checkbox" id="checkIntSeq" value="<%=LIST_intSeq%>" class="no_Line"><input type="hidden" name="checkIntSeqSecret" value="<%=LIST_bitSecret%>"></td>
<% END IF %>
					<td align="left">
					<% IF LIST_iConFolder <> False THEN %><img src="<%=LIST_iConFolder%>" align="absmiddle" style="margin-right:5px;"><% END IF %>
					<% IF CONF_bitUseCategory = True AND LIST_intCategory <> 0 THEN %><b><%=LIST_strCategory%></b><img src="<%=skinPath%>images/table_bar_line.gif" class="topBtnMarg" align="absmiddle"><% END IF %>
					<% IF LIST_iConReply <> False THEN %><%=LIST_iConReply%><% END IF %>
					<% IF CONF_bitReadLevel = True THEN %>
					<a href="<%=LIST_strReadLink%>"<% IF CONF_bitPreview = True THEN %> onMouseMove="OnListMovePreview();" onMouseOut="OnListHidePreview();" onMouseOver="OnListPreview('<%=LIST_strContentPrev%>');"<% END IF %>><% IF CONF_bitColorListFontGrd = True THEN %><font color="<%=CONF_strColorNoticeFont%>"><% END IF %><%=LIST_strSubject%><% IF CONF_bitColorListFontGrd = True THEN %></font><% END IF %></a>
					<% ELSE %>
					<% IF CONF_bitColorListFontGrd = True THEN %><font color="<%=CONF_strColorNoticeFont%>"><% END IF %><%=LIST_strSubject%><% IF CONF_bitColorListFontGrd = True THEN %></font><% END IF %>
					<% END IF %>
					<% IF LIST_iConNew <> False THEN %>&nbsp;<img src="<%=LIST_iConNew%>" border="0" align="absmiddle"><% END IF %>
					<% IF LIST_iConSecret <> False THEN %>&nbsp;<img src="<%=LIST_iConSecret%>" border="0" align="absmiddle"><% END IF %>
					<% IF LIST_intComment > 0 THEN %>&nbsp;<span class="boardNum" style="color:#E76322">(<%=LIST_intComment%>)</span><% END IF %>					
					<% IF LIST_iConNewCmt <> False THEN %>&nbsp;<img src="<%=LIST_iConNewCmt%>" border="0" align="absmiddle"><% END IF %></td>
					<td class="skinList"><% IF LIST_strMarkImage <> False THEN %><%=LIST_strMarkImage%><% END IF %>
					<a href="javascript:;" onClick="showSideView(this, '<%=CONF_strNameClick%>','<%=LIST_strLoginID%>','<%=AdRs_strName%>','<%=GetUserEmailBit(LIST_strEmail)%>','<%=LIST_strHomepage%>','<%=LIST_intSeq%>');">
					<% IF CONF_bitColorListFontGrd = True THEN %><font color="<%=CONF_strColorNoticeFont%>"><% END IF %>
					<% IF LIST_strNameImage = False THEN %><%=LIST_strName%><% ELSE %><%=LIST_strNameImage%><% END IF %>
					<% IF CONF_bitColorListFontGrd = True THEN %></font><% END IF %>
					</a></td>
					<td class="boardNum"><%=LIST_dateRegDate%></td>
					<td class="boardNum"><%=LIST_intRead%></td>
<% IF CONF_bitUseVote = True THEN %>
					<td class="boardNum"><%=LIST_intVote%></td>
<% END IF %>
					<td></td>
				</tr>
				<tr>
					<td height="1" colspan="<%=CONF_intColSpan%>" bgcolor="#E6E6E6"></td>
				</tr>
<%
			NEXT
		END IF
	END IF
%>
	    </table>
	  </td>
  </tr>
<% IF LIST_intTotalCount = 0 THEN %>
	<tr>
		<td align="center" class="pdl10 pdr10">게시글이 없습니다.</td>
	</tr>
<% ELSE %>
	<tr>
		<td class="pdl10 pdr10">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
<%
	iCount = 0
%>
<!-- #include file = "../../../../Include/BoardIncludeBoardLoop.asp" -->
<%
	IF LIST_strFileImage = False THEN
		LIST_strFileImage = ""
	ELSE
		IF CONF_bitThrum = True THEN
			LIST_strFileImage = "<img src=Pds/Board/" & strBoardID & "/Thrum/" & LIST_strFileImage & " WIDTH=100 HEIGHT=100 BORDER=0>"
		ELSE
			LIST_strFileImage = "<img src=Pds/Board/" & strBoardID & "/" & LIST_strFileImage & " WIDTH=" & CONF_intListImgWidth & " HEIGHT=" & CONF_intListImgHeight & " BORDER=0>"
		END IF
	END IF

	iCount = iCount + 1
	IF iCount = 1 THEN
%>
				<tr>
<%
	END IF
%>
					<td width="<%=100/CONF_intRowCount%>%" align="center" valign="top">
						<table width="130" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="100" align="center" class="pdt10 pdb10">
									<table width="100" height="100" border="0" cellspacing="1" cellpadding="4" bgcolor="#E0E1DB">
										<tr>
											<td align="center" bgcolor="#FFFFFF">
											<% IF CONF_bitReadLevel = True THEN %>
											<a href="<%=LIST_strReadLink%>"><%=LIST_strFileImage%></a>
											<% ELSE %>
											<%=LIST_strFileImage%>
											<% END IF %>
											</td>
										</tr>
									</table>
								</td>
							</tr>
<% IF CONF_bitUseCategory = True AND LIST_intCategory <> 0 THEN %>
							<tr>
								<td align="center"><b><%=LIST_strCategory%></b></td>
							</tr>
<% END IF %>
							<tr>
								<td align="center">
								<% IF LIST_iConReply <> False THEN %><%=LIST_iConReply%><% END IF %>
								<% IF CONF_bitReadLevel = True THEN %>
								<a href="<%=LIST_strReadLink%>"<% IF CONF_bitPreview = True THEN %> onMouseMove="OnListMovePreview();" onMouseOut="OnListHidePreview();" onMouseOver="OnListPreview('<%=LIST_strContentPrev%>');"<% END IF %>><% IF CONF_bitColorListFontGrd = True THEN %><font color="<%=CONF_strColorNoticeFont%>"><% END IF %><%=LIST_strSubject%><% IF CONF_bitColorListFontGrd = True THEN %></font><% END IF %></a>
								<% ELSE %>
								<% IF CONF_bitColorListFontGrd = True THEN %><font color="<%=CONF_strColorNoticeFont%>"><% END IF %><%=LIST_strSubject%><% IF CONF_bitColorListFontGrd = True THEN %></font><% END IF %>
								<% END IF %>
								<% IF LIST_iConNew <> False THEN %>&nbsp;<img src="<%=LIST_iConNew%>" border="0" align="absmiddle"><% END IF %>
								<% IF LIST_iConSecret <> False THEN %>&nbsp;<img src="<%=LIST_iConSecret%>" border="0" align="absmiddle"><% END IF %>
								<% IF LIST_intComment > 0 THEN %>&nbsp;<span class="boardNum" style="color:#E76322">(<%=LIST_intComment%>)</span><% END IF %>					
								<% IF LIST_iConNewCmt <> False THEN %>&nbsp;<img src="<%=LIST_iConNewCmt%>" border="0" align="absmiddle"><% END IF %>
								</td>
							</tr>
							<tr>
								<td align="center" height="20">
								<% IF LIST_strMarkImage <> False THEN %><%=LIST_strMarkImage%><% END IF %>
								<a href="javascript:;" onClick="showSideView(this, '<%=CONF_strNameClick%>','<%=LIST_strLoginID%>','<%=AdRs_strName%>','<%=GetUserEmailBit(LIST_strEmail)%>','<%=LIST_strHomepage%>','<%=LIST_intSeq%>');">
								<% IF CONF_bitColorListFontGrd = True THEN %><font color="<%=CONF_strColorNoticeFont%>"><% END IF %>
								<% IF LIST_strNameImage = False THEN %><%=LIST_strName%><% ELSE %><%=LIST_strNameImage%><% END IF %>
								<% IF CONF_bitColorListFontGrd = True THEN %></font><% END IF %>
								</a>
								</td>
							</tr>
							<tr>
								<td height="20" align="center" class="boardNum"><%=LIST_dateRegDate%></td>
							</tr>
							<tr>
								<td height="20" align="center" class="boardNum">Read <%=LIST_intRead%></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
<%
	IF INT(iCount) = INT(CONF_intRowCount) THEN
		iCount = 0
%>
				</tr>
<%
	END IF
	NEXT
	IF iCount <> 0 THEN
		FOR I = iCount TO CONF_intRowCount - 1
			RESPONSE.WRITE "					<td width=""" & 100/CONF_intRowCount & "%"">" & vbcrlf
		NEXT
			RESPONSE.WRITE "				</tr>" & vbcrlf
	END IF
	END IF
%>
			</table>
		</td>
	</tr>
<% END IF %>
	<tr>
		<td height="1" bgcolor="#E0E1DB"></td>
	</tr>
  <tr>
    <td height="35">
      <table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table border="0" cellspacing="0" cellpadding="0"><tr>
				<% IF CONF_bitWriteLevel = True THEN %>
				<td style="padding-right:3px"><a href="javascript:OnBoardWrite('write');"><img src="<%=skinPath%>images/btn_write.gif" border="0" align="absmiddle"></a></td>
				<% END IF %>
				<% IF CONF_bitReadLevel = True AND CONF_bitUseSelectView = True THEN %><td style="padding-right:3px"><a href="javascript:OnBoardRead();"><img src="<%=skinPath%>images/btn_read.gif" align="absmiddle" border="0"></a></td><% END IF %>
				<% IF CONF_bitBoardAdmin = True AND CONF_bitUseSelectView = True THEN %><td style="padding-right:3px"><a href="javascript:OnBoardAdmin();"><img src="<%=skinPath%>images/btn_admin.gif" border="0" align="absmiddle"></a></td>
				<% END IF %>
				</tr>
				</table>
				</td>
        <td align="right">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td style="padding-right:5px;"><input name="jump_page" type="text" id="jump_page" size="4" maxlength="3" style="height:12px"><a href="javascript:go_jump();"><img src="<%=skinPath%>images/btn_enter.gif" border="0" align="absmiddle"></a></td>
							<td><a href="<%=LIST_strPagePrevLink%>"><img src="<%=skinPath%>images/btn_prev.gif" border="0" align="absmiddle"></a>&nbsp;<a href="<%=LIST_strPageNextLink%>"><img src="<%=skinPath%>images/btn_next.gif" border="0" align="absmiddle"></a></td>
						</tr>
					</table>
				</td>
      </tr>
    </table>
	</td>
  </tr>
  <tr>
    <td height="30" align="center">
<%
		RESPONSE.WRITE "<table border=""0"" cellpadding=""0"" cellspacing=""0"">" & vbcrlf
		RESPONSE.WRITE "	<tr>" & vbcrlf

		intPageTemp = INT((intPage - 1) / CONF_intPageCount) * CONF_intPageCount + 1

		IF intPageTemp <> 1 THEN
    	RESPONSE.WRITE "<td id=""mytd""><img src=""" & skinPath & "images/page_allow1.gif"" vspace=""2"">&nbsp;<a href=""javascript:;"" OnClick=""OnPageMove(" & intPageTemp - CONF_intPageCount & ");return false;"">이전 " & CONF_intPageCount & "개</a></td>"
		END IF

		RESPONSE.WRITE "		<td width=""1"" nowrap bgcolor=""#cccccc""></td>" & vbcrlf

		FOR I = LIST_intStartPage TO LIST_intEndPage

			RESPONSE.WRITE "		<td id=""mytd"" onMouseOver=""this.style.background='#f7f7f7'"" onMouseOut=""this.style.background=''"" align=center onClick=""OnPageMove(" & I & ");return false;"">"

			IF INT(I) = INT(intPage) THEN RESPONSE.WRITE "<font color=""#ff7635""><b>" & I & "</b></font>" ELSE RESPONSE.WRITE "<b>" & I & "</b>"

			RESPONSE.WRITE "</td>" & vbcrlf
			RESPONSE.WRITE "<td width=""1"" nowrap bgcolor=""#cccccc""></td>" & vbcrlf

			intPageTemp = intPageTemp + 1

		NEXT

		IF intPageTemp < LIST_intTotalPage THEN
			RESPONSE.WRITE "<td id=""mytd"">&nbsp;<a href=""javascript:;"" OnClick=""OnPageMove(" & intPageTemp & ");return false;"">다음 " & CONF_intPageCount & "개</a>&nbsp;<img src=""" & skinPath & "images/page_allow2.gif"" vspace=""2""></td>"
		END IF

		RESPONSE.WRITE "	</tr>" & vbcrlf
		RESPONSE.WRITE "</table>" & vbcrlf
%>
		</td>
  </tr>
  <tr>
    <td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<% IF CONF_bitUseSearch = True THEN %>
				<tr>
					<td height="35" align="right"><a href="javascript:set_search('id');"><img src="<%=skinPath%>images/search_id.gif" name="s_id_chk" border="0" align="absmiddle"></a>&nbsp;&nbsp;<a href="javascript:set_search('name');"><img src="<%=skinPath%>images/search_name.gif" name="s_name_chk"border="0" align="absmiddle"></a>&nbsp;&nbsp;<a href="javascript:set_search('subject');"><img src="<%=skinPath%>images/search_subject.gif" name="s_subject_chk" border="0" align="absmiddle"></a>&nbsp;&nbsp;<a href="javascript:set_search('content');"><img src="<%=skinPath%>images/search_content.gif" name="s_content_chk"  border="0" align="absmiddle"></a>&nbsp;&nbsp;
						<input name="searchWord" type="text" id="searchWord" value="<%=strSearchWord%>" onkeypress="check_enter('search');" class="input">&nbsp;<a href="javascript:OnSearch();"><img src="<%=skinPath%>images/btn_search.gif" border="0" align="absmiddle"></a>&nbsp;<a href="javascript:OnSearchCancel();"><img src="<%=skinPath%>images/btn_search_cancel.gif" border="0" align="absmiddle"></a></td>
				</tr>
				<% END IF %>
      </table>
		</td>
	</tr>
	</form>
</table>
<script language="javascript">

	if (SET_BOARD_SEARCH == "True"){
		if(SET_SEARCH_CATEGORY_DIM[0]!= "")
			document.all["s_id_chk"].src = PATH_SKIN + "images/search_id-1.gif";
		if(SET_SEARCH_CATEGORY_DIM[1]!= "")
			document.all["s_name_chk"].src = PATH_SKIN + "images/search_name-1.gif";
		if(SET_SEARCH_CATEGORY_DIM[2]!= "")
			document.all["s_subject_chk"].src = PATH_SKIN + "images/search_subject-1.gif";
		if(SET_SEARCH_CATEGORY_DIM[3]!= "")
			document.all["s_content_chk"].src = PATH_SKIN + "images/search_content-1.gif";
	}

function set_search(str){
	switch (str){
		case "id":
			if (SET_SEARCH_CATEGORY_DIM[0]!= ""){
				SET_SEARCH_CATEGORY_DIM[0] = "";
				document.all['s_id_chk'].src = PATH_SKIN + "images/search_id.gif";
			}else{
				SET_SEARCH_CATEGORY_DIM[0] = "s_id";
				document.all['s_id_chk'].src = PATH_SKIN + "images/search_id-1.gif";
			}
			break;
		case "name":
			if (SET_SEARCH_CATEGORY_DIM[1]!= ""){
				SET_SEARCH_CATEGORY_DIM[1] = "";
				document.all['s_name_chk'].src = PATH_SKIN + "images/search_name.gif";
			}else{
				SET_SEARCH_CATEGORY_DIM[1] = "s_name";
				document.all['s_name_chk'].src = PATH_SKIN + "images/search_name-1.gif";
			}
			break;
		case "subject":
			if (SET_SEARCH_CATEGORY_DIM[2]!= ""){
				SET_SEARCH_CATEGORY_DIM[2] = "";
				document.all['s_subject_chk'].src = PATH_SKIN + "images/search_subject.gif";
			}else{
				SET_SEARCH_CATEGORY_DIM[2] = "s_subject";
				document.all['s_subject_chk'].src = PATH_SKIN + "images/search_subject-1.gif";
			}
			break;
		case "content":
			if (SET_SEARCH_CATEGORY_DIM[3]!= ""){
				SET_SEARCH_CATEGORY_DIM[3] = "";
				document.all['s_content_chk'].src = PATH_SKIN + "images/search_content.gif";
			}else{
				SET_SEARCH_CATEGORY_DIM[3] = "s_content";
				document.all['s_content_chk'].src = PATH_SKIN + "images/search_content-1.gif";
			}
			break;
	}
}
</script>
