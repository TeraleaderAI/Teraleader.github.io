<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 5
	intLeftMenu  = 2
	isAdminMenu  = 1
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM strBoardID, intBoardConfigMenu
	strBoardID         = REQUEST.QueryString("strBoardID")
	intBoardConfigMenu = 2

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_LIST] '" & strBoardID & "' ")

	DIM intRowCount, intLineCount, intLineHeight, intListImgWidth, intListImgHeight, bitMouseOver, strMouseOverColor
	DIM bitPreview, intPreviewCut, intPreviewWidth, intCutSubject, intCutContent, intCutName, strNameClick, strViewType
	DIM intPopViewWidth, intPopViewHeight, strDateType, strColorNoticeBg, strColorNoticeFont, strColorRepleBg
	DIM strColorRepleFont, strColorListOddBg, strColorListEvenBg, bitColorListBgGrd, strColorListOddFont, strColorListEvenFont
	DIM bitColorListFontGrd, strColorListReadBg, strColorListReadFont, strIconFolder, strIconNotice, strIconNew, strIconReple
	DIM strIconLine, strIconSecret, strIconRead, strIconNewCmt, bitUseSelectView, intNewIconTime, strBadSubject, strLinkHomepage
	DIM strLinkHomepageTarget, intPageCount, strPagePrevGroup, strPageNextGroup, strPageFirstPage, strPageEndPage, strPageNow
	DIM strPageDefault, bitUseSearch, intSearchCount, strSeaechTag

	intRowCount           = RS("intRowCount")
	intLineCount          = RS("intLineCount")
	intLineHeight         = RS("intLineHeight")
	intListImgWidth       = RS("intListImgWidth")
	intListImgHeight      = RS("intListImgHeight")
	bitMouseOver          = RS("bitMouseOver")
	strMouseOverColor     = RS("strMouseOverColor")
	bitPreview            = RS("bitPreview")
	intPreviewCut         = RS("intPreviewCut")
	intPreviewWidth       = RS("intPreviewWidth")
	intCutSubject         = RS("intCutSubject")
	intCutContent         = RS("intCutContent")
	intCutName            = RS("intCutName")
	strNameClick          = RS("strNameClick")
	strViewType           = RS("strViewType")
	intPopViewWidth       = RS("intPopViewWidth")
	intPopViewHeight      = RS("intPopViewHeight")
	strDateType           = RS("strDateType")
	strColorNoticeBg      = RS("strColorNoticeBg")
	strColorNoticeFont    = RS("strColorNoticeFont")
	strColorRepleBg       = RS("strColorRepleBg")
	strColorRepleFont     = RS("strColorRepleFont")
	strColorListOddBg     = RS("strColorListOddBg")
	strColorListEvenBg    = RS("strColorListEvenBg")
	bitColorListBgGrd     = RS("bitColorListBgGrd")
	strColorListOddFont   = RS("strColorListOddFont")
	strColorListEvenFont  = RS("strColorListEvenFont")
	bitColorListFontGrd   = RS("bitColorListFontGrd")
	strColorListReadBg    = RS("strColorListReadBg")
	strColorListReadFont  = RS("strColorListReadFont")
	strIconFolder         = RS("strIconFolder")
	strIconNotice         = RS("strIconNotice")
	strIconNew            = RS("strIconNew")
	strIconReple          = RS("strIconReple")
	strIconLine           = RS("strIconLine")
	strIconSecret         = RS("strIconSecret")
	strIconRead           = RS("strIconRead")
	strIconNewCmt         = RS("strIconNewCmt")
	intNewIconTime        = RS("intNewIconTime")
	bitUseSelectView      = RS("bitUseSelectView")
	strBadSubject         = RS("strBadSubject")
	strLinkHomepage       = RS("strLinkHomepage")
	strLinkHomepageTarget = RS("strLinkHomepageTarget")
	intPageCount          = RS("intPageCount")
	strPagePrevGroup      = RS("strPagePrevGroup")
	strPageNextGroup      = RS("strPageNextGroup")
	strPageFirstPage      = RS("strPageFirstPage")
	strPageEndPage        = RS("strPageEndPage")
	strPageNow            = RS("strPageNow")
	strPageDefault        = RS("strPageDefault")
	bitUseSearch          = RS("bitUseSearch")
	intSearchCount        = RS("intSearchCount")
	strSeaechTag          = RS("strSeaechTag")
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
						<form name="theForm" method="post" action="BoardListConfig_ok.asp" onSubmit="return OnSubmitAction();">
						<input type="hidden" name="strBoardID" value="<%=strBoardID%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title22.gif" width="139" height="19"></td>
                      <td align="right">관리자 홈 &gt; 게시판관리 &gt; <b>게시판 리스트 설정</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><!-- #include file = "BoardConfigMenu.asp" --></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>리스트 출력관련 정보</strong></span></td>
                      <td align="right"><a href="../../mboard.asp?strBoardID=<%=strBoardID%>" target="_blank"><img src="../images/btn_board_view_g.gif" width="80" height="19" align="absmiddle" border="0"></a>
											<input name="imageField2" type="image" id="imageField" src="../images/btn_board_submit_g.gif" align="absmiddle" class="no_Line"></td>
                    </tr>
                  </table>
                </td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="intRowCount,intLineCount" class="no_Line">게시물 출력 갯수</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="50%">가로출력&nbsp;<input name="intRowCount" type="text" id="intRowCount"onBlur="onlynum(this, '1');" value="<%=intRowCount%>" size="4" maxlength="10">&nbsp;개</td>
														<td width="50%">세로출력&nbsp;<input name="intLineCount" type="text" id="intLineCount"onBlur="onlynum(this, '1');" value="<%=intLineCount%>" size="4" maxlength="10">&nbsp;개</span></td>
												</tr>
											</table></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="intListImgWidth, intListImgHeight" class="no_Line">이미지 출력 크기</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="50%">가로크기&nbsp;<input name="intListImgWidth" type="text" id="intListImgWidth"onBlur="onlynum(this, '1');" value="<%=intListImgWidth%>" size="4" maxlength="10">&nbsp;픽셀</td>
														<td width="50%">세로크기&nbsp;<input name="intListImgHeight" type="text" id="intListImgHeight"onBlur="onlynum(this, '1');" value="<%=intListImgHeight%>" size="4" maxlength="10">&nbsp;픽셀</span></td>
												</tr>
											</table></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="intLineHeight" class="no_Line">게시물 높이</td>
											<td class="table_Right1"><input name="intLineHeight" type="text" id="intLineHeight"onBlur="onlynum(this, '1');" value="<%=intLineHeight%>" size="4" maxlength="10">&nbsp;픽셀&nbsp;<span style="color: #E86A34">게시글 라인 높이를 설정합니다.</span></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="intCutSubject,intCutContent,intCutName" class="no_Line">글자수 제한</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="33%">제목 자르기&nbsp;<input name="intCutSubject" type="text" id="intCutSubject"onBlur="onlynum(this, '1');" value="<%=intCutSubject%>" size="4" maxlength="10">&nbsp;자</td>
														<td width="33%">내용 자르기&nbsp;<input name="intCutContent" type="text" id="intCutContent"onBlur="onlynum(this, '1');" value="<%=intCutContent%>" size="4" maxlength="10">&nbsp;자</td>
														<td width="33%">이름 자르기&nbsp;<input name="intCutName" type="text" id="intCutName"onBlur="onlynum(this, '1');" value="<%=intCutName%>" size="4" maxlength="10">&nbsp;자</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strColorNoticeBg,strColorNoticeFont,strColorRepleBg,strColorRepleFont,strColorListOddBg,strColorListEvenBg,bitColorListBgGrd,strColorListOddFont,strColorListEvenFont,bitColorListFontGrd,strColorListReadBg,strColorListReadFont" class="no_Line">색상설정</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="50%">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="100" height="26">공지 배경색</td>
																	<td height="26"><input name="strColorNoticeBg" type="text" id="strColorNoticeBg" onBlur="OnColorSet(document.all['strColorNoticeBgPrev'], this);" value="<%=strColorNoticeBg%>" size="8" maxlength="7">&nbsp;<INPUT class="text" style="BACKGROUND: <%=strColorNoticeBg%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorNoticeBg',410,430);" READONLY size=2 name="strColorNoticeBgPrev"></td>
																</tr>
																<tr>
																	<td width="100" height="26">답변 배경색</td>
																	<td height="26"><input name="strColorRepleBg" type="text" id="strColorRepleBg" onBlur="OnColorSet(document.all['strColorRepleBgPrev'], this);" value="<%=strColorRepleBg%>" size="8" maxlength="7">&nbsp;<INPUT class="text" style="BACKGROUND: <%=strColorRepleBg%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorRepleBg',410,430);" READONLY size=2 name="strColorRepleBgPrev"></td>
																</tr>
																<tr>
																	<td width="100" height="26">목록 배경색</td>
																	<td height="26"><input name="strColorListOddBg" type="text" id="strColorListOddBg" onBlur="OnColorSet(document.all['strColorListOddBgPrev'], this);" value="<%=strColorListOddBg%>" size="8" maxlength="7">&nbsp;<INPUT class="text" style="BACKGROUND: <%=strColorListOddBg%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorListOddBg',410,430);" READONLY size=2 name="strColorListOddBgPrev"> (홀수)</td>
																</tr>
																<tr>
																	<td width="100" height="26">&nbsp;</td>
																	<td height="26"><input name="strColorListEvenBg" type="text" id="strColorListEvenBg" onBlur="OnColorSet(document.all['strColorListEvenBgPrev'], this);" value="<%=strColorListEvenBg%>" size="8" maxlength="7">&nbsp;<INPUT class="text" style="BACKGROUND: <%=strColorListEvenBg%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorListEvenBg',410,430);" READONLY size=2 name="strColorListEvenBgPrev"> (짝수)</td>
																</tr>
																<tr>
																	<td width="100" height="26">&nbsp;</td>
																	<td height="26"><input name="bitColorListBgGrd" type="checkbox" id="bitColorListBgGrd" value="1"<% IF bitColorListBgGrd = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitColorListBgGrd" style="cursor:hand">배경 그라데이션 사용</LABEL></td>
																</tr>
																<tr>
																	<td width="100" height="26">현재글 배경색</td>
																	<td height="26"><input name="strColorListReadBg" type="text" id="strColorListReadBg" onBlur="OnColorSet(document.all['strColorListReadBgPrev'], this);" value="<%=strColorListReadBg%>" size="8" maxlength="7">&nbsp;<INPUT name="strColorListReadBgPrev" class="text" id="strColorListReadBgPrev" style="BACKGROUND: <%=strColorListReadBg%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorListReadBg',410,430);" size=2 READONLY></td>
																</tr>
															</table>
														</td>
														<td width="50%">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="100" height="26">공지 글자색</td>
																	<td height="26"><input name="strColorNoticeFont" type="text" id="strColorNoticeFont" onBlur="OnColorSet(document.all['strColorNoticeFontPrev'], this);" value="<%=strColorNoticeFont%>" size="8" maxlength="7">&nbsp;<INPUT class="text" style="BACKGROUND: <%=strColorNoticeFont%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorNoticeFont',410,430);" READONLY size=2 name="strColorNoticeFontPrev"></td>
																</tr>
																<tr>
																	<td width="100" height="26">답변 글자색</td>
																	<td height="26"><input name="strColorRepleFont" type="text" id="strColorRepleFont" onBlur="OnColorSet(document.all['strColorRepleFontPrev'], this);" value="<%=strColorRepleFont%>" size="8" maxlength="7">&nbsp;<INPUT class="text" style="BACKGROUND: <%=strColorRepleFont%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorRepleFont',410,430);" READONLY size=2 name="strColorRepleFontPrev"></td>
																</tr>
																<tr>
																	<td width="100" height="26">목록 글자색</td>
																	<td height="26"><input name="strColorListOddFont" type="text" id="strColorListOddFont" onBlur="OnColorSet(document.all['strColorListOddFontPrev'], this);" value="<%=strColorListOddFont%>" size="8" maxlength="7">&nbsp;<INPUT class="text" style="BACKGROUND: <%=strColorListOddFont%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorListOddFont',410,430);" READONLY size=2 name="strColorListOddFontPrev"> (홀수)</td>
																</tr>
																<tr>
																	<td width="100" height="26">&nbsp;</td>
																	<td height="26"><input name="strColorListEvenFont" type="text" id="strColorListEvenFont" onBlur="OnColorSet(document.all['strColorListEvenFontPrev'], this);" value="<%=strColorListEvenFont%>" size="8" maxlength="7">&nbsp;<INPUT class="text" style="BACKGROUND: <%=strColorListEvenFont%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorListEvenFont',410,430);" READONLY size=2 name="strColorListEvenFontPrev"> (짝수)</td>
																</tr>
																<tr>
																	<td width="100" height="26">&nbsp;</td>
																	<td height="26"><input name="bitColorListFontGrd" type="checkbox" id="bitColorListFontGrd" value="1"<% IF bitColorListFontGrd = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitColorListFontGrd" style="cursor:hand">글자 그라데이션 사용</LABEL></td>
																</tr>
																<tr>
																	<td width="100" height="26">현재글 글자색</td>
																	<td height="26"><input name="strColorListReadFont" type="text" id="strColorListReadFont" onBlur="OnColorSet(document.all['strColorListReadFontPrev'], this);" value="<%=strColorListReadFont%>" size="8" maxlength="7">&nbsp;<INPUT name="strColorListReadFontPrev" class="text" id="strColorListReadFontPrev" style="BACKGROUND: <%=strColorListReadFont%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorListReadFont',410,430);" size=2 READONLY></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitMouseOver,strMouseOverColor" class="no_Line">마우스 오버 설정</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="50%">마우스 오버 기능 &nbsp;<input type="radio" name="bitMouseOver" id="bitMouseOver1" value="1"<% IF bitMouseOver = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitMouseOver1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitMouseOver" id="bitMouseOver2" value="0"<% IF bitMouseOver = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitMouseOver2" style="cursor:hand">사용안함</LABEL></td><td width="50%">마우스 오버시 색상&nbsp;<input name="strMouseOverColor" type="text" id="strMouseOverColor" value="<%=strMouseOverColor%>" size="8" maxlength="7">&nbsp;<INPUT class="text" style="BACKGROUND: <%=strMouseOverColor%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strMouseOverColor',410,430);" READONLY size=2 name="strMouseOverColorPrev"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strIconFolder,strIconNotice,strIconNew,strIconReple,strIconLine,strIconSecret,strIconRead" class="no_Line">아이콘/라인 이미지</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="50%">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="100" height="26">제목 아이콘</td>
																	<td><img name="strIconFolder1" src="../../Pds/Board/Icon/folder/<%=strIconFolder%>" border="0"></td>
																	<td width="100" height="26"><input name="strIconFolder" type="hidden" id="strIconFolder" value="<%=strIconFolder%>"><a href="javascript:;" onclick="popupLayer('BoardListIcon.asp?strFolder=folder&strSetIcon=strIconFolder',420,325);return false;"><img src="../images/btn_select_icon_w.gif" width="79" height="19" border="0" align="absmiddle"></a></td>
																</tr>
																<tr>
																	<td width="100" height="26">NEW 아이콘</td>
																	<td><img name="strIconNew1" src="../../Pds/Board/Icon/New/<%=strIconNew%>" border="0"></td>
																	<td height="26" colspan="2"><input name="strIconNew" type="hidden" id="strIconNew" value="<%=strIconNew%>"><a href="javascript:;" onclick="popupLayer('BoardListIcon.asp?strFolder=new&strSetIcon=strIconNew',420,325);return false;"><img src="../images/btn_select_icon_w.gif" width="79" height="19" align="absmiddle" border="0"></a></td>
																</tr>
																<tr>
																	<td width="100" height="26">Line 이미지</td>
																	<td><img name="strIconLine1" src="../../Pds/Board/Icon/Line/<%=strIconLine%>" border="0"></td>
																	<td height="26" colspan="2"><input name="strIconLine" type="hidden" id="strIconLine" value="<%=strIconLine%>"><a href="javascript:;" onclick="popupLayer('BoardListIcon.asp?strFolder=line&strSetIcon=strIconLine',420,325);return false;"><img src="../images/btn_select_icon_w.gif" width="79" height="19" align="absmiddle" border="0"></a></td>
																</tr>
																<tr>
																	<td width="100" height="26">현재글 아이콘</td>
																	<td><img name="strIconRead1" src="../../Pds/Board/Icon/Read/<%=strIconRead%>" border="0"></td>
																	<td height="26" colspan="2"><input name="strIconRead" type="hidden" id="strIconRead" value="<%=strIconRead%>"><a href="javascript:;" onclick="popupLayer('BoardListIcon.asp?strFolder=read&strSetIcon=strIconRead',420,325);return false;"><img src="../images/btn_select_icon_w.gif" width="79" height="19" align="absmiddle" border="0"></a></td>
																</tr>
															</table>
														</td>
														<td width="50%" valign="top">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="100" height="26">공지 아이콘</td>
																	<td><img name="strIconNotice1" src="../../Pds/Board/Icon/Notice/<%=strIconNotice%>" border="0"></td>
																	<td width="100" height="26"><input name="strIconNotice" type="hidden" id="strIconNotice" value="<%=strIconNotice%>"><a href="javascript:;" onclick="popupLayer('BoardListIcon.asp?strFolder=notice&strSetIcon=strIconNotice',420,325);return false;"><img src="../images/btn_select_icon_w.gif" width="79" height="19" align="absmiddle" border="0"></a></td>
																</tr>
																<tr>
																	<td width="100" height="26">답변 아이콘</td>
																	<td><img name="strIconReple1" src="../../Pds/Board/Icon/Reple/<%=strIconReple%>" border="0"></td>
																	<td height="26" colspan="2"><input name="strIconReple" type="hidden" id="strIconReple" value="<%=strIconReple%>"><a href="javascript:;" onclick="popupLayer('BoardListIcon.asp?strFolder=reple&strSetIcon=strIconReple',420,325);return false;"><img src="../images/btn_select_icon_w.gif" width="79" height="19" align="absmiddle" border="0"></a></td>
																</tr>
																<tr>
																	<td width="100" height="26">비밀 게시물</td>
																	<td><img name="strIconSecret1" src="../../Pds/Board/Icon/Secret/<%=strIconSecret%>" border="0"></td>
																	<td height="26" colspan="2"><input name="strIconSecret" type="hidden" id="strIconSecret" value="<%=strIconSecret%>"><a href="javascript:;" onclick="popupLayer('BoardListIcon.asp?strFolder=secret&strSetIcon=strIconSecret',420,325);return false;"><img src="../images/btn_select_icon_w.gif" width="79" height="19" align="absmiddle" border="0"></a></td>
																</tr>
																<tr>
																	<td height="26">신규 댓글</td>
																	<td><img name="strIconNewCmt1" src="../../Pds/Board/Icon/NewCmt/<%=strIconNewCmt%>" border="0"></td>
																	<td height="26" colspan="2"><input name="strIconNewCmt" type="hidden" id="strIconNewCmt" value="<%=strIconNewCmt%>"><a href="javascript:;" onclick="popupLayer('BoardListIcon.asp?strFolder=newcmt&strSetIcon=strIconNewCmt',420,325);return false;"><img src="../images/btn_select_icon_w.gif" width="79" height="19" align="absmiddle" border="0"></a></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>리스트 기능설정 정보</strong></span></td>
                      <td align="right"><a href="../../mboard.asp?strBoardID=<%=strBoardID%>" target="_blank"><img src="../images/btn_board_view_g.gif" width="80" height="19" align="absmiddle" border="0"></a>
											<input name="imageField2" type="image" id="imageField" src="../images/btn_board_submit_g.gif" align="absmiddle" class="no_Line"></td>
                    </tr>
                  </table>
                </td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseSelectView" class="no_Line">여러글 선택보기</td>
											<td class="table_Right1"><input type="radio" name="bitUseSelectView" id="bitUseSelectView1" value="1"<% IF bitUseSelectView = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseSelectView1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseSelectView" id="bitUseSelectView2" value="0"<% IF bitUseSelectView = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseSelectView2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">게시글을 선택해서 일괄적으로 열람합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="intNewIconTime" class="no_Line">NEW 아이콘 출력</td>
											<td class="table_Right1"><input name="intNewIconTime" type="text" id="intNewIconTime"onBlur="onlynum(this, '1');" value="<%=intNewIconTime%>" size="4" maxlength="10">
						시간 이내의 등록된 게시글에 아이콘 출력</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strDateType" class="no_Line">날짜 출력형식</td>
											<td class="table_Right1"><select name="strDateType" id="strDateType">
												<option value="0"<% IF strDateType = "0" THEN %> SELECTED<% END IF %>>년/월/일 시:분</option>
												<option value="1"<% IF strDateType = "1" THEN %> SELECTED<% END IF %>>년/월/일</option>
												<option value="2"<% IF strDateType = "2" THEN %> SELECTED<% END IF %>>월/일</option>
												<option value="3"<% IF strDateType = "3" THEN %> SELECTED<% END IF %>>월/일 시:분</option>
												<option value="4"<% IF strDateType = "4" THEN %> SELECTED<% END IF %>>일 시:분</option>
												<option value="5"<% IF strDateType = "5" THEN %> SELECTED<% END IF %>>년/월/일 시:분:초</option>
												</select>&nbsp;<font color="#E86A34">게시글 등록일자의 출력형식을 설정합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitPreview,intPreviewCut,intPreviewWidth" class="no_Line">미리보기 설정</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="50%" height="26">미리보기 기능&nbsp;&nbsp;<input type="radio" name="bitPreview" id="bitPreview1" value="1"<% IF bitPreview = True THEN %> CHECKED<% END IF %> class="no_Line"><label for="bitPreview1" style="cursor:hand">사용함</label><input type="radio" name="bitPreview" id="bitPreview2" value="0"<% IF bitPreview = False THEN %> CHECKED<% END IF %> class="no_Line"><label for="bitPreview2" style="cursor:hand">사용안함</label></td>
														<td width="50%" height="26">&nbsp;</td>
													</tr>
													<tr>
														<td width="50%" height="26">미리보기 내용 자르기&nbsp;&nbsp;&nbsp;<input name="intPreviewCut" type="text" id="intPreviewCut"onBlur="onlynum(this, '1');" value="<%=intPreviewCut%>" size="4" maxlength="10">&nbsp;자</td>
														<td width="50%" height="26">미리보기 출력 너비 &nbsp;&nbsp;&nbsp;<input name="intPreviewWidth" type="text" id="intPreviewWidth"onBlur="onlynum(this, '1');" value="<%=intPreviewWidth%>" size="4" maxlength="10">&nbsp;픽셀</td>
													</tr>
												</table>											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strNameClick" class="no_Line">등록자 클릭 설정</td>
											<td class="table_Right1"><input type="radio" name="strNameClick" id="strNameClick1" value="0"<% IF strNameClick = 0 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strNameClick1" style="cursor:hand">메뉴창 실행(회원전용)</LABEL>&nbsp;<input type="radio" name="strNameClick" id="strNameClick2" value="1"<% IF strNameClick = 1 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strNameClick2" style="cursor:hand">아이디/이름으로 검색/이메일/홈페이지</LABEL>&nbsp;<input type="radio" name="strNameClick" id="strNameClick3" value="2"<% IF strNameClick = 2 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strNameClick3" style="cursor:hand">이메일</LABEL>&nbsp;<input type="radio" name="strNameClick" id="strNameClick4" value="3"<% IF strNameClick = 3 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strNameClick4" style="cursor:hand">없음</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strViewType,intPopViewWidth,intPopViewHeight" class="no_Line">게시글 클릭 설정 </td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="26" colspan="2"><input type="radio" name="strViewType" id="strViewType1" value="0"<% IF strViewType = 0 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strViewType1" style="cursor:hand">글읽기 화면이동</LABEL>&nbsp;<input type="radio" name="strViewType" id="strViewType2" value="1"<% IF strViewType = 1 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strViewType2" style="cursor:hand">팝업창 실행(팝업창 스킨)</LABEL>&nbsp;<input type="radio" name="strViewType" id="strViewType3" value="2"<% IF strViewType = 2 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strViewType3" style="cursor:hand">새창으로 실행(글읽기 스킨)</LABEL></td>
													</tr>
													<tr>
														<td width="50%" height="26">팝업창 너비&nbsp;&nbsp;<input name="intPopViewWidth" type="text" id="intPopViewWidth"onBlur="onlynum(this, '1');" value="<%=intPopViewWidth%>" size="4" maxlength="10">&nbsp;픽셀</td>
														<td width="50%" height="26">팝업창 높이 &nbsp;&nbsp;<input name="intPopViewHeight" type="text" id="intPopViewHeight"onBlur="onlynum(this, '1');" value="<%=intPopViewHeight%>" size="4" maxlength="10">&nbsp;픽셀</td>
													</tr>
												</table>											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strBadSubject" class="no_Line">불량게시글 제목변경</td>
											<td class="table_Right1"><input name="strBadSubject" type="text" id="strBadSubject" value="<%=strBadSubject%>" maxlength="128" style="width:100%"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strLinkHomepage,strLinkHomepageTarget" class="no_Line">홈페이지 링크</td>
											<td class="table_Right1"><input name="strLinkHomepage" type="text" id="strLinkHomepage" value="<%=strLinkHomepage%>" size="90" maxlength="128">
											&nbsp;<select name="strLinkHomepageTarget" id="strLinkHomepageTarget">
											<option value=""></option>
											<option value="_self"<% IF strLinkHomepageTarget = "_self" THEN %> SELECTED<% END IF %>>self</option>
											<option value="_parent"<% IF strLinkHomepageTarget = "_parent" THEN %> SELECTED<% END IF %>>parent</option>
											<option value="_top"<% IF strLinkHomepageTarget = "_top" THEN %> SELECTED<% END IF %>>top</option>
											</select><br><font color="#E86A34">http:// 를 포함한 경로를 입력하세요.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>페이징 관련정보</strong></span></td>
                      <td align="right"><a href="../../mboard.asp?strBoardID=<%=strBoardID%>" target="_blank"><img src="../images/btn_board_view_g.gif" width="80" height="19" align="absmiddle" border="0"></a>
											<input name="imageField2" type="image" id="imageField" src="../images/btn_board_submit_g.gif" align="absmiddle" class="no_Line"></td>
                    </tr>
                  </table>
                </td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="intPageCount" class="no_Line">페이지 표시 출력수</td>
											<td class="table_Right1"><input name="intPageCount" type="text" id="intPageCount" onBlur="onlynum(this, '1');" value="<%=intPageCount%>" size="4" maxlength="10">&nbsp;개&nbsp;<font color="#E86A34">페이지 표시 출력수를 설정합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strPagePrevGroup,strPageNextGroup,strPageFirstPage,strPageEndPage,strPageNow,strPageDefault" class="no_Line">페이지 링크 설정</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="171" height="26">이전 페이지 그룹</td>
														<td width="656" height="26"><input name="strPagePrevGroup" type="text" id="strPagePrevGroup" value="<%=strPagePrevGroup%>" maxlength="128" style="width:100%"></td>
													</tr>
													<tr>
														<td width="171" height="26">다음 페이지 그룹</td>
														<td height="26"><input name="strPageNextGroup" type="text" id="strPageNextGroup" value="<%=strPageNextGroup%>" maxlength="128" style="width:100%"></td>
													</tr>
													<tr>
														<td width="171" height="26">이전 페이지</td>
														<td height="26"><input name="strPageFirstPage" type="text" id="strPageFirstPage" value="<%=strPageFirstPage%>" maxlength="128" style="width:100%"></td>
													</tr>
													<tr>
														<td width="171" height="26">다음 페이지</td>
														<td height="26"><input name="strPageEndPage" type="text" id="strPageEndPage" value="<%=strPageEndPage%>" maxlength="128" style="width:100%"></td>
													</tr>
													<tr>
														<td width="171" height="26">일반 페이지</td>
														<td height="26"><input name="strPageDefault" type="text" id="strPageDefault" value="<%=strPageDefault%>" maxlength="128" style="width:100%"></td>
													</tr>
													<tr>
														<td width="171" height="26">현재 페이지</td>
														<td height="26"><input name="strPageNow" type="text" id="strPageNow" value="<%=strPageNow%>" maxlength="128" style="width:100%"></td>
													</tr>
													<tr>
														<td colspan="2"><font color="#E86A34">{LINK} : 페이지 링크, {PAGE] : 페이징 변수, {SKINPATH} : 스킨 경로 변수</font></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseSearch,intSearchCount,strSeaechTag" class="no_Line">검색 기능</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="26">검색 기능&nbsp;&nbsp;<input type="radio" name="bitUseSearch" id="bitUseSearch1" value="1"<% IF bitUseSearch = True THEN %> CHECKED<% END IF %> class="no_Line"><label for="bitUseSearch1" style="cursor:hand">사용함</label><input type="radio" name="bitUseSearch" id="bitUseSearch2" value="0"<% IF bitUseSearch = False THEN %> CHECKED<% END IF %> class="no_Line"><label for="bitUseSearch2" style="cursor:hand">사용안함</label></td>
													</tr>
													<tr>
														<td height="26">검색 단어 치환 태그 <input name="strSeaechTag" type="text" id="strSeaechTag" value="<%=strSeaechTag%>" size="50" maxlength="128">&nbsp;<font color="#E86A34">{KEY} : 검색한 단어의 치환변수</font></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td style="padding-left:15;"><a href="javascript:;" onClick="OnConfigSelect();return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0" align="absmiddle"></a>&nbsp;&nbsp;<a href="javascript:;" onclick="OnBoardConfigCopy('2','<%=strBoardID%>');return false;"><img src="../images/btn_config_copy_w.gif" width="121" height="19" border="0" align="absmiddle"></a></td>
											<td align="right" style="padding-right:20;"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>게시판의 게시글 목록에 관련된 환경설정을 설정하실 수 있습니다.</LI>
											</td>
										</tr>
									</table>
									</fieldset>
								</td>
							</tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							</form>
            </table>
<script language="javascript">
	function OnIconSelect(str1, str2){
		openWindows('BoardListIcon.asp?strFolder=' + str1 + "&strSetIcon=" + str2, 'IconSelect', '500', '500', '3');
	}

	function OnSubmitAction(){
		str = document.all['intLineCount'];
		if (str.value == "" || str.value.length == 0){alert("게시글 출력개수가 입력되지 않았거나 잘못 입력하셨습니다.");str.focus();return false;}

		if (document.all['bitPreview'][0].checked == true){
			str = document.all['intPreviewWidth'];
			if (str.value == "" || str.value.length == 0){alert("미리보기 출력너비를 올바르게 입력해 주시기 바랍니다.");str.focus();return false;}
		}		

		if (document.all['strViewType'][1].checked == true || document.all['strViewType'][2].checked == true){
			str = document.all['intPopViewWidth'];
			if (str.value == "" || str.value.length == 0){alert("팝업창 너비를 올바르게 입력해 주시기 바랍니다.");str.focus();return false;}
			str = document.all['intPopViewHeight'];
			if (str.value == "" || str.value.length == 0){alert("팝업창 높이를 올바르게 입력해 주시기 바랍니다.");str.focus();return false;}
		}

	}
</script>
<!-- #include file = "Foot.asp" -->