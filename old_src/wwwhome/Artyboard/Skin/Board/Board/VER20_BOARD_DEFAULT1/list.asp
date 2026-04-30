<!-- #include file = "../../../../Include/BoardIncludeList.asp" -->
<%
	IF CONF_bitUseSelectView = True THEN CONF_intColSpan = CONF_intColSpan + 1
	IF CONF_bitUseVote       = True THEN CONF_intColSpan = CONF_intColSpan + 1
	IF CONF_bitUseUpload     = True THEN CONF_intColSpan = CONF_intColSpan + 1
	IF CONF_bitUseCategory   = True THEN CONF_intColSpan = CONF_intColSpan + 1
%>
<!-- #include file = "../../../../Include/BoardIncludeCategory.asp" -->
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post">
  <tr>
    <td>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="23">전체게시물: <b><%=LIST_intTotalCount%></b>, &nbsp;현재페이지<b><%=LIST_intPage%></b><b>/<%=LIST_intTotalPage%></b></td>
					<td align="right"><% IF CONF_bitUseRss = True THEN %><a href="<%=CONF_strRssLink%>" target="_blank"><img src="<%=skinPath%>images/btn_rss.gif" width="13" height="13" align="absmiddle" style="margin-right:5px;"></a><% END IF %><% IF CONF_strLinkHomepage <> False THEN %><a href="<%=CONF_strLinkHomepage%>" target="<%=CONF_strLinkHomepageTarget%>"><img src="<%=skinPAth%>images/shome.gif" width="34" height="8" border="0" style="margin-right:5px;"></a><% END IF %><% IF SESSION("strLoginID") = "" THEN %><a href="<%=CONF_strMemberJoinLink%>"><img src="<%=skinPath%>images/sjoin.gif" width="29" height="8" border="0" style="margin-right:5px;"></a><a href="<%=CONF_strLoginLink%>"><img src="<%=skinPath%>images/slogin.gif" width="34" height="8" border="0" style="margin-right:5px;"></a><% ELSE %><a href="<%=CONF_strMemberEditLink%>"><img src="<%=skinPath%>images/smyinfo.gif" width="41" height="8" border="0" style="margin-right:5px;"></a><a href="<%=CONF_strLogoutLink%>"><img src="<%=skinPath%>images/slogout.gif" width="41" height="8" border="0" style="margin-right:5px;"></a><% END IF %><% IF CONF_bitUseMemo = True THEN %><a href="memo.asp?Action=list"><img src="<%=skinPath%>images/smemo.gif" width="34" height="8" border="0" style="margin-right:5px;"></a><% END IF %><% IF CONF_bitUseScrap = True THEN %><a href="scrap.asp?Action=list" target="_blank"><img src="<%=skinPath%>images/sscrap.gif" width="38" height="8" border="0" style="margin-right:5px;"></a><% END IF %><% IF CONF_bitBoardAdmin = True THEN %><a href="Admin/Default.asp" target="_blank"><img src="<%=skinPath%>images/sadmin.gif" width="36" height="8" border="0"></a><% END IF %></td>
				</tr>
			</table>
		</td>
  </tr>
  <tr>
    <td>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
			<col width="40"></col></col><% IF CONF_bitUseCategory = True THEN %><col width="100"></col><% END IF %><% IF CONF_bitUseSelectView = True THEN %><col width="20"></col><% END IF %><col></col><col width="100"></col><col width="75"></col><col width="45"></col><% IF CONF_bitUseVote = True THEN %><col width="40"></col><% END IF %><% IF CONF_bitUseUpload = True THEN %><col width="50"></col><% END IF %>
				<tr>
				  <td height="2" colspan="<%=CONF_intColSpan%>" class="listLine1"></td>
				</tr>
				<tr align="center">
					<td class="listTop">번호</td>
<% IF CONF_bitUseCategory = True THEN %>
					<td class="listTop"><%=strCategorySelect%></td>
<% END IF %>
<% IF CONF_bitUseSelectView = True THEN %>
					<td class="listTop"><a href="javascript:OnBoardSelectAll();"><img src="<%=skinPath%>images/list_select.gif" width="13" height="13" border="0" /></a></td>
<% END IF %>
					<td class="listTop">제목</td>
					<td class="listTop">이름</td>
					<td class="listTop">날짜</td>
					<td class="listTop">조회</td>
          <% IF CONF_bitUseVote = True THEN %>
					<td class="listTop">추천</td>
          <% END IF %>
<% IF CONF_bitUseUpload = True THEN %>
					<td class="listTop">다운</td>
          <% END IF %>
				</tr>
				<tr>
				  <td height="1" colspan="<%=CONF_intColSpan%>" class="listLine2"></td>
				</tr>
<% IF intPage = 1 THEN %>
				<!-- #include file = "../../../../Include/BoardIncludeNoticeLoop.asp" -->
				<tr style="color:<%=CONF_strColorNoticeFont%>" align="center" bgcolor="<%=CONF_strColorNoticeBg%>" height="<%=CONF_intLineHeight%>" <% IF CONF_bitMouseOver = True THEN %>onMouseOver="Onrollover(this, '<%=CONF_strMouseOverColor%>');" onMouseOut="Onrollover(this, '');"<% END IF %>>
					<td bgcolor="<%=CONF_strColorNoticeBg%>"><% IF LIST_iConNotice <> False THEN %><img src="<%=LIST_iConNotice%>"><% END IF %></td>
<% IF CONF_bitUseCategory = True THEN %>
					<td><%=LIST_strCategory%></td>
<% END IF %>
<% IF CONF_bitUseSelectView = True THEN %>
					<td><input name="checkIntSeq" type="checkbox" id="checkIntSeq" value="<%=LIST_intSeq%>" class="no_Line"><input type="hidden" name="checkIntSeqSecret" value="<%=LIST_bitSecret%>"></td>
<% END IF %>
					<td align="left">
					<% IF LIST_iConFolder <> False THEN %><img src="<%=LIST_iConFolder%>" align="absmiddle"><% END IF %>
					<% IF LIST_iConReply <> False THEN %><%=LIST_iConReply%><% END IF %>
					<% IF CONF_bitReadLevel = True THEN %>
					<a href="<%=LIST_strReadLink%>"<% IF CONF_bitPreview = True THEN %> onMouseMove="OnListMovePreview();" onMouseOut="OnListHidePreview();" onMouseOver="OnListPreview('<%=LIST_strContentPrev%>');"<% END IF %>><% IF CONF_bitColorListFontGrd = True THEN %><font color="<%=CONF_strColorNoticeFont%>"><% END IF %><%=LIST_strSubject%><% IF CONF_bitColorListFontGrd = True THEN %></font><% END IF %></a>
					<% ELSE %>
					<% IF CONF_bitColorListFontGrd = True THEN %><font color="<%=CONF_strColorNoticeFont%>"><% END IF %><%=LIST_strSubject%><% IF CONF_bitColorListFontGrd = True THEN %></font><% END IF %>
					<% END IF %>
					<% IF LIST_iConNew <> False THEN %>&nbsp;<img src="<%=LIST_iConNew%>" border="0" align="absmiddle"><% END IF %>
					<% IF LIST_iConSecret <> False THEN %>&nbsp;<img src="<%=LIST_iConSecret%>" border="0" align="absmiddle"><% END IF %>
					<% IF LIST_intComment > 0 THEN %>&nbsp;<span class="smallFont" style="color:#E76322">(<%=LIST_intComment%>)</span><% END IF %>					
					<% IF LIST_iConNewCmt <> False THEN %>&nbsp;<img src="<%=LIST_iConNewCmt%>" border="0" align="absmiddle"><% END IF %></td>
					<td><% IF LIST_strMarkImage <> False THEN %><%=LIST_strMarkImage%><% END IF %>
					<a href="javascript:;" onClick="showSideView(this, '<%=CONF_strNameClick%>','<%=LIST_strLoginID%>','<%=AdRs_strName%>','<%=GetUserEmailBit(LIST_strEmail)%>','<%=LIST_strHomepage%>','<%=LIST_intSeq%>');">
					<% IF CONF_bitColorListFontGrd = True THEN %><font color="<%=CONF_strColorNoticeFont%>"><% END IF %>
					<% IF LIST_strNameImage = False THEN %><b><%=LIST_strName%></b><% ELSE %><%=LIST_strNameImage%><% END IF %>
					<% IF CONF_bitColorListFontGrd = True THEN %></font><% END IF %>
					</a></td>
					<td class="smallFont"><%=LIST_dateRegDate%></td>
					<td class="smallFont"><%=LIST_intRead%></td>
<% IF CONF_bitUseVote = True THEN %>
					<td class="smallFont"><%=LIST_intVote%></td>
<% END IF %>
<% IF CONF_bitUseUpload = True THEN %>
					<td class="smallFont"><% IF LIST_strFileName <> False THEN %><a href="<%=LIST_strFileLink%>"><%=GetFileIcon(LIST_strFileName, True)%></a><% END IF %></td>
<% END IF %>
				</tr>
				<tr>
					<td height="1" colspan="<%=CONF_intColSpan%>" background="<%=skinPath%>images/list_line.gif"></td>
				</tr>
<%
	NEXT
	END IF
%>
<% END IF %>
<!-- #include file = "../../../../Include/BoardIncludeBoardLoop.asp" -->
				<tr style="color:<%=CONF_strColorListFont%>" align="center" bgcolor="<%=CONF_strColorListBg%>" height="<%=CONF_intLineHeight%>" <% IF CONF_bitMouseOver = True THEN %>onMouseOver="Onrollover(this, '<%=CONF_strMouseOverColor%>');" onMouseOut="Onrollover(this, '');"<% END IF %>>
					<td class="smallFont"><% IF LIST_iConRead = False THEN %><%=LIST_intViewNum%><% ELSE %><img src="<%=LIST_iConRead%>"><% END IF %></td>
<% IF CONF_bitUseCategory = True THEN %>
					<td><%=LIST_strCategory%></td>
<% END IF %>
<% IF CONF_bitUseSelectView = True THEN %>
					<td><input name="checkIntSeq" type="checkbox" id="checkIntSeq" value="<%=LIST_intSeq%>" class="no_Line"><input type="hidden" name="checkIntSeqSecret" value="<%=LIST_bitSecret%>"></td>
<% END IF %>
					<td align="left">
					<% IF LIST_iConFolder <> False THEN %><img src="<%=LIST_iConFolder%>" align="absmiddle"><% END IF %>
					<% IF LIST_iConReply <> False THEN %><%=LIST_iConReply%><% END IF %>
					<% IF CONF_bitReadLevel = True THEN %>
					<a href="<%=LIST_strReadLink%>"<% IF CONF_bitPreview = True THEN %> onMouseMove="OnListMovePreview();" onMouseOut="OnListHidePreview();" onMouseOver="OnListPreview('<%=LIST_strContentPrev%>');"<% END IF %>><% IF CONF_bitColorListFontGrd = True THEN %><font color="<%=CONF_strColorListFont%>"><% END IF %><%=LIST_strSubject%><% IF CONF_bitColorListFontGrd = True THEN %></font><% END IF %></a>
					<% ELSE %>
					<% IF CONF_bitColorListFontGrd = True THEN %><font color="<%=CONF_strColorListFont%>"><% END IF %><%=LIST_strSubject%><% IF CONF_bitColorListFontGrd = True THEN %></font><% END IF %>
					<% END IF %>
					<% IF LIST_iConNew <> False THEN %>&nbsp;<img src="<%=LIST_iConNew%>" border="0" align="absmiddle"><% END IF %>
					<% IF LIST_iConSecret <> False THEN %>&nbsp;<img src="<%=LIST_iConSecret%>" border="0" align="absmiddle"><% END IF %>
					<% IF LIST_intComment > 0 THEN %>&nbsp;<span class="smallFont" style="color:#E76322">(<%=LIST_intComment%>)</span><% END IF %>
					<% IF LIST_iConNewCmt <> False THEN %>&nbsp;<img src="<%=LIST_iConNewCmt%>" border="0" align="absmiddle"><% END IF %></td>
					<td><% IF LIST_strMarkImage <> False THEN %><%=LIST_strMarkImage%><% END IF %>
					<a href="javascript:;" onClick="showSideView(this, '<%=CONF_strNameClick%>','<%=LIST_strLoginID%>','<%=AdRs_strName%>','<%=GetUserEmailBit(LIST_strEmail)%>','<%=LIST_strHomepage%>','<%=LIST_intSeq%>');">
					<% IF CONF_bitColorListFontGrd = True THEN %><font color="<%=CONF_strColorListFont%>"><% END IF %>
					<% IF LIST_strNameImage = False THEN %><b><%=LIST_strName%></b><% ELSE %><%=LIST_strNameImage%><% END IF %>
					<% IF CONF_bitColorListFontGrd = True THEN %></font><% END IF %>
					</a></td>
					<td class="smallFont"><%=LIST_dateRegDate%></td>
					<td class="smallFont"><%=LIST_intRead%></td>
<% IF CONF_bitUseVote = True THEN %>
					<td class="smallFont"><%=LIST_intVote%></td>
<% END IF %>
<% IF CONF_bitUseUpload = True THEN %>
					<td  class="smallFont"><% IF LIST_strFileName <> False THEN %><a href="<%=LIST_strFileLink%>"><%=GetFileIcon(LIST_strFileName, True)%></a><% END IF %></td>
<% END IF %>
				</tr>
				<tr>
					<td height="1" colspan="<%=CONF_intColSpan%>" background="<%=skinPath%>images/list_line.gif"></td>
				</tr>
<%
	NEXT
	END IF
%>
				<tr>
					<td height="2" colspan="<%=CONF_intColSpan%>" class="listLine2"></td>
				</tr>
    </table>
	  </td>
  </tr>
  <tr>
    <td height="35">
      <table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><% IF CONF_bitWriteLevel = True THEN %><a href="javascript:OnBoardWrite('write');"><img src="<%=skinPath%>images/btn_write.gif" border="0" align="absmiddle" style="margin-right:3px"></a><% END IF %><% IF CONF_bitReadLevel = True AND CONF_bitUseSelectView = True THEN %><a href="javascript:OnBoardRead();"><img src="<%=skinPath%>images/btn_read.gif" align="absmiddle" border="0" style="margin-right:3px"></a><% END IF %><% IF CONF_bitBoardAdmin = True AND CONF_bitUseSelectView = True THEN %><a href="javascript:OnBoardAdmin();"><img src="<%=skinPath%>images/btn_admin.gif" border="0" align="absmiddle"></a><% END IF %>
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
    <td class="pdr5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<% IF CONF_bitUseSearch = True THEN %>
				<tr>
					<td height="35" align="right" class="pdr5"><a href="javascript:set_search('id');"><img src="<%=skinPath%>images/search_id.gif" name="s_id_chk" border="0" align="absmiddle"></a>&nbsp;&nbsp;<a href="javascript:set_search('name');"><img src="<%=skinPath%>images/search_name.gif" name="s_name_chk"border="0" align="absmiddle"></a>&nbsp;&nbsp;<a href="javascript:set_search('subject');"><img src="<%=skinPath%>images/search_subject.gif" name="s_subject_chk" border="0" align="absmiddle"></a>&nbsp;&nbsp;<a href="javascript:set_search('content');"><img src="<%=skinPath%>images/search_content.gif" name="s_content_chk"  border="0" align="absmiddle"></a>&nbsp;&nbsp;
						<input name="searchWord" type="text" id="searchWord" value="<%=strSearchWord%>" onkeypress="check_enter('search');" style="border-color:B4B4B4;">&nbsp;<a href="javascript:OnSearch();"><img src="<%=skinPath%>images/btn_search.gif" border="0" align="absmiddle"></a>&nbsp;<a href="javascript:OnSearchCancel();"><img src="<%=skinPath%>images/btn_search_cancel.gif" border="0" align="absmiddle"></a></td>
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