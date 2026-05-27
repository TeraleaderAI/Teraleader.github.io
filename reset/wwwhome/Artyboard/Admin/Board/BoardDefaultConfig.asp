<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu  = 5
	intLeftMenu = 2
	isAdminMenu = 1
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM strBoardID, intBoardConfigMenu
	strBoardID         = REQUEST.QueryString("strBoardID")
	intBoardConfigMenu = 1

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '" & strBoardID & "' ")

	DIM strName, strTitle, strMemo, strSkin, strSkinGroup, strAdmin, strCharset, strKeyword, strDescription, strLanguage
	DIM strBrowser, strFont, strFontSize, strWidth, strBodyTag, intTopMargin, intLeftMargin, intRightMargin, strAlign
	DIM strColorBg, strColorActive, strColorHover, strColorVisited, strColorLink, strUserCss, strHeadFile, strTailFile
	DIM strHeadText, strTailText, bitSecret, strSecretPassword, bitNotLink, strNotLinkMsg, strNotLinkList, bitNotIp
	DIM strNotIpMsg, strNotIpList, bitUseCategory, bitUseVote, bitUseComment, bitUseScrap, bitUseBad, bitUseNickName
	DIM bitUseStat, bitStatCheck, bitAdminCheck, bitUseRss

	strName           = RS("strName")
	strTitle          = RS("strTitle")
	strMemo           = RS("strMemo")
	strSkin           = RS("strSkin")
	strSkinGroup      = RS("strSkinGroup")
	strAdmin          = RS("strAdmin")
	strBrowser        = RS("strBrowser")
	strCharset        = RS("strCharset")
	strKeyword        = RS("strKeyword")
	strDescription    = RS("strDescription")
	strLanguage       = RS("strLanguage")
	strFont           = RS("strFont")
	strFontSize       = RS("strFontSize")
	strWidth          = RS("strWidth")
	strBodyTag        = RS("strBodyTag")
	intTopMargin      = RS("intTopMargin")
	intLeftMargin     = RS("intLeftMargin")
	intRightMargin    = RS("intRightMargin")
	strAlign          = RS("strAlign")
	strColorBg        = RS("strColorBg")
	strColorActive    = RS("strColorActive")
	strColorHover     = RS("strColorHover")
	strColorVisited   = RS("strColorVisited")
	strColorLink      = RS("strColorLink")
	strUserCss        = RS("strUserCss")
	strHeadFile       = RS("strHeadFile")
	strTailFile       = RS("strTailFile")
	strHeadText       = RS("strHeadText")
	strTailText       = RS("strTailText")
	bitSecret         = RS("bitSecret")
	strSecretPassword = RS("strSecretPassword")
	bitNotLink        = RS("bitNotLink")
	strNotLinkMsg     = RS("strNotLinkMsg")
	strNotLinkList    = RS("strNotLinkList")
	bitNotIp          = RS("bitNotIp")
	strNotIpMsg       = RS("strNotIpMsg")
	strNotIpList      = RS("strNotIpList")
	bitUseCategory    = RS("bitUseCategory")
	bitUseVote        = RS("bitUseVote")
	bitUseComment     = RS("bitUseComment")
	bitUseScrap       = RS("bitUseScrap")
	bitUseBad         = RS("bitUseBad")
	bitUseNickName    = RS("bitUseNickName")
	bitUseStat        = RS("bitUseStat")
	bitStatCheck      = RS("bitStatCheck")
	bitAdminCheck     = RS("bitAdminCheck")
	bitUseRss         = RS("bitUseRss")
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
						<form name="theForm" method="post" action="BoardDefaultConfig_ok.asp" onSubmit="return OnSubmitAction();">
						<input type="hidden" name="strBoardID" value="<%=strBoardID%>">
						<input type="hidden" name="strSkinGroup">
						<input type="hidden" name="strSkin">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title21.gif" width="152" height="19"></td>
                      <td align="right">관리자 홈 &gt; 게시판관리 &gt; <b>게시판 기본환경 설정</b></td>
                    </tr>
                  </table>
                </td>
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
<% IF SESSION("strAdmin") = "2" THEN %>
              <tr>
                <td height="30">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>게시판 관리자 정보</strong></span></td>
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
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strAdmin" class="no_Line">
											게시판 관리자</td>
											<td class="table_Right1"><iframe name="BoardAdmin" src="BoardAdmin.asp?strBoardID=<%=strBoardID%>" frameborder="0" width="100%" height="52"></iframe></td>
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
<% END IF %>
              <tr>
                <td height="30">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>기본정보 및 스킨정보</strong></span></td>
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
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strName" class="no_Line">
											게시판 이름</td>
											<td class="table_Right1"><input name="strName" type="text" id="strName" style="width:100%" value="<%=strName%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strTitle" class="no_Line">
											게시판 타이틀</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td style="word-break:break-all;"><textarea name="strTitle" rows="5" id="strTitle" style="width:98%"><%=strTitle%></textarea></td>
														<td width="15" valign="top">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strTitle', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="reset_textarea('strTitle', 5);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strTitle', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																</tr>
															</table>														</td>
													</tr>
												</table>											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strMemo" class="no_Line">
											게시판 메모</td>
											<td class="table_Right1"><input name="strMemo" type="text" id="strMemo" style="width:100%" value="<%=strMemo%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strSkin,strSkinGroup" class="no_Line">
											게시판 스킨</td>
											<td class="table_Right1"><iframe name="BoardSkin" src="BoardSkin.asp?strSkinGroup=<%=strSkinGroup%>&strSkin=<%=strSkin%>" frameborder="0" width="100%" height="134"></iframe></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strCharset" class="no_Line">
											문자셋 선택</td>
											<td class="table_Right1">
											<select name="strCharset" id="strCharset">
											<option value="euc-kr"<% IF strCharset = "euc-kr" THEN %> SELECTED<% END IF %>>euc-kr (한국 : 기본)</option>
											<option value="iso2022-kr"<% IF strCharset = "iso2022-kr" THEN %> SELECTED<% END IF %>>ISO (한국)</option>
											<option value="UTF-8"<% IF strCharset = "UTF-8" THEN %> SELECTED<% END IF %>>UTF-8 (영어)</option>
											</select>											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strKeyword" class="no_Line">
											키워드 등록</td>
											<td class="table_Right1"><input name="strKeyword" type="text" id="strKeyword" style="width:100%" value="<%=strKeyword%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strDescription" class="no_Line">
											설명 등록</td>
											<td class="table_Right1"><input name="strDescription" type="text" id="strDescription" style="width:100%" value="<%=strDescription%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strLanguage" class="no_Line">
											언어선택</td>
											<td class="table_Right1">
											<select name="strLanguage" id="strLanguage">
											<option value="1"<% IF strLanguage = "1" THEN %> SELECTED<% END IF %>>한국어</option>
											<option value="2"<% IF strLanguage = "2" THEN %> SELECTED<% END IF %>>영어</option>
											</select>
											<span style="color: #E86A34">메시지 출력시 언어를 선택합니다.</span></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strBrowser" class="no_Line">
											상단 브라우저</td>
											<td class="table_Right1"><input name="strBrowser" type="text" id="strBrowser" style="width:100%" value="<%=strBrowser%>" maxlength="128"></td>
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
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>기본 스타일 정보</strong></span></td>
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

								</td>
              </tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strFont,strFontSize" class="no_Line">
											기본글꼴 / 사이즈</td>
											<td class="table_Right1"><select name="strFont" class="select" id="strFont">
											<option value="">기본글꼴선택</option>
											<option value="굴림" <% IF strFont = "굴림" THEN %>SELECTED<% END IF %>>굴림</option>
											<option value="굴림체" <% IF strFont = "굴림체" THEN %>SELECTED<% END IF %>>굴림체</option>
											<option value="돋움" <% IF strFont = "돋움" THEN %>SELECTED<% END IF %>>돋움</option>
											<option value="돋움체" <% IF strFont = "돋움체" THEN %>SELECTED<% END IF %>>돋움체</option>
											<option value="바탕" <% IF strFont = "바탕" THEN %>SELECTED<% END IF %>>바탕</option>
											<option value="바탕체" <% IF strFont = "바탕체" THEN %>SELECTED<% END IF %>>바탕체</option>
											<option value="궁서" <% IF strFont = "궁서" THEN %>SELECTED<% END IF %>>궁서</option>
											<option value="궁서체" <% IF strFont = "궁서체" THEN %>SELECTED<% END IF %>>궁서체</option></select>&nbsp;<input name="strFontSize" type="text" id="strFontSize" value="<%=strFontSize%>" size="5" maxlength="4">&nbsp;<span style="color: #E86A34">단위 : 포인트는 pt, 픽셀은 px로 등록합니다.</span></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strWidth" class="no_Line">
											폭 ( 너비) 설정</td>
											<td class="table_Right1"><input name="strWidth" type="text" id="strWidth" value="<%=strWidth%>" size="5" maxlength="4">&nbsp;<span style="color: #E86A34">단위 : 포인트는 pt, 픽셀은 px로 등록합니다.</span></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strAlign,intTopMargin,intLeftMargin,intRightMargin" class="no_Line">
											정렬 및 여백</td>
											<td class="table_Right1">
											<select name="strAlign" id="strAlign">
											<option value="0" <% IF strAlign = "0" THEN %>SELECTED<% END IF %>>좌측 정렬</option>
											<option value="1" <% IF strAlign = "1" THEN %>SELECTED<% END IF %>>가운데 정렬</option>
											<option value="2" <% IF strAlign = "2" THEN %>SELECTED<% END IF %>>우측 정렬</option>
											</select>
											상단&nbsp;<input name="intTopMargin" type="text" id="intTopMargin"onBlur="onlynum(this, '1');" value="<%=intTopMargin%>" size="5">&nbsp;px&nbsp;&nbsp;좌측&nbsp;<input name="intLeftMargin" type="text" id="intLeftMargin"onBlur="onlynum(this, '1');" value="<%=intLeftMargin%>" size="5" maxlength="4">&nbsp;px&nbsp;&nbsp;우측&nbsp;<input name="intRightMargin" type="text" id="intRightMargin"onBlur="onlynum(this, '1');" value="<%=intRightMargin%>" size="5" maxlength="4">											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strColorBg" class="no_Line">
											배경색</td>
											<td class="table_Right1">
											<input name="strColorBg" type="text" id="strColorBg" onBlur="OnColorSet(document.all['strColorBgPrev'], this);" value="<%=strColorBg%>" size="8" maxlength="7">&nbsp;<INPUT style="BACKGROUND: <%=strColorBg%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorBg',410,430);" READONLY size=2 name="strColorBgPrev"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strColorActive,strColorHover,strColorVisited,strColorLink" class="no_Line">
											링크 관련색</td>
											<td class="table_Right1">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="25%">Active <input name="strColorActive" type="text" id="strColorActive" onBlur="OnColorSet(document.all['strColorActivePrev'], this);" value="<%=strColorActive%>" size="8" maxlength="7">&nbsp;<INPUT style="BACKGROUND: <%=strColorActive%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorActive',410,430);" READONLY size=2 name="strColorActivePrev"></td>
														<td width="25%">Hover <input name="strColorHover" type="text" id="strColorHover" onBlur="OnColorSet(document.all['strColorHoverPrev'], this);" value="<%=strColorHover%>" size="8" maxlength="7">&nbsp;<INPUT style="BACKGROUND: <%=strColorHover%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorHover',410,430);" READONLY size=2 name="strColorHoverPrev"></td>
														<td width="25%">Visited <input name="strColorVisited" type="text" id="strColorVisited" onBlur="OnColorSet(document.all['strColorVisitedPrev'], this);" value="<%=strColorVisited%>" size="8" maxlength="7">&nbsp;<INPUT style="BACKGROUND: <%=strColorVisited%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorVisited',410,430);" READONLY size=2 name="strColorVisitedPrev"></td>
														<td width="25%">Link <input name="strColorLink" type="text" id="strColorLink" onBlur="OnColorSet(document.all['strColorLinkPrev'], this);" value="<%=strColorLink%>" size="8" maxlength="7">&nbsp;<INPUT style="BACKGROUND: <%=strColorLink%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorLink',410,430);" READONLY size=2 name="strColorLinkPrev"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strBodyTag" class="no_Line">
											추가 BODY 태그</td>
											<td class="table_Right1"><input name="strBodyTag" type="text" id="strBodyTag" style="width:100%" value="<%=strBodyTag%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strUserCss" class="no_Line">
											사용자 스타일</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>&lt;STYLE&gt;</td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strUserCss" rows="8" id="strUserCss" style="width:98%"><%=strUserCss%></textarea></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strUserCss', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strUserCss', 8);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strUserCss', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																		</table>																	</td>
																</tr>
															</table>														</td>
													</tr>
													<tr>
														<td>&lt;/STYLE&gt;</td>
													</tr>
												</table>											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td height="30">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>상단 및 하단 파일 또는 HTML 정보</strong></span></td>
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
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strHeadFile" class="no_Line">
											상단 (Head) File</td>
											<td class="table_Right1"><input name="strHeadFile" type="text" id="strHeadFile" style="width:100%" value="<%=strHeadFile%>" maxlength="128"><br><font color="#E86A34">시작경로는 기본으로 설정된 경로부터 시작됩니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strHeadText" class="no_Line">
											상단 (Head) HTML</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="751" style="word-break:break-all;"><textarea name="strHeadText" rows="8" id="strHeadText" style="width:98%"><%=strHeadText%></textarea></td>
														<td width="17" valign="top">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strHeadText', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="reset_textarea('strHeadText', 8);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strHeadText', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
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
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strTailFile" class="no_Line">
											하단 (Foot) File</td>
											<td class="table_Right1"><input name="strTailFile" type="text" id="strTailFile" style="width:100%" value="<%=strTailFile%>" maxlength="128"><br><font color="#E86A34">시작경로는 기본으로 설정된 경로부터 시작됩니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strTailText" class="no_Line">
											하단 (Foot) HTML</td>
											<td class="table_Right1">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td style="word-break:break-all;"><textarea name="strTailText" rows="8" id="strTailText" style="width:98%"><%=strTailText%></textarea></td>
														<td width="15" valign="top">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strTailText', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="reset_textarea('strTailText', 8);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strTailText', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																</tr>
															</table>														</td>
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
                <td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>게시판 기본기능 정보</strong></span></td>
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
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitSecret,strSecretPassword" class="no_Line">
											비밀게시판</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="50%" height="26">비밀게시판&nbsp;&nbsp;<input type="radio" name="bitSecret" id="bitSecret1" value="1"<% IF bitSecret = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitSecret1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitSecret" id="bitSecret2" value="0"<% IF bitSecret = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitSecret2" style="cursor:hand">사용안함</LABEL></td>
														<td width="50%" height="26">접근 비밀번호&nbsp;&nbsp;<input name="strSecretPassword" type="password" id="strSecretPassword" value="<%=strSecretPassword%>" maxlength="20"></td>
													</tr>
													<tr>
														<td colspan="2"><font color="#E86A34">비밀게시판은 비밀번호 입력 후 접근이 가능합니다.</font></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitNotLink,strNotLinkMsg,strNotLinkList" class="no_Line">
											무단링크 방지</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="90" height="26">무단링크</td>
														<td height="26"><input type="radio" name="bitNotLink" id="bitNotLink1" value="1"<% IF bitNotLink = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitNotLink1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitNotLink" id="bitNotLink2" value="0"<% IF bitNotLink = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitNotLink2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
													<tr>
														<td width="90" height="26">경고 메시지</td>
														<td height="26"><input name="strNotLinkMsg" type="text" id="strNotLinkMsg" value="<%=strNotLinkMsg%>" maxlength="128" style="width:100%"></td>
													</tr>
													<tr>
														<td height="26" colspan="2">링크 허용 URL 리스트</td>
													</tr>
													<tr>
														<td height="26" colspan="2">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strNotLinkList" rows="4" id="strNotLinkList" style="width:98%"><%=strNotLinkList%></textarea></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strNotLinkList', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strNotLinkList', 8);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strNotLinkList', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																		</table>
																	</td>
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
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitNotIp,strNotIpMsg,strNotIpList" class="no_Line">
											IP 접근 제한</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="90" height="26">IP 접근제한</td>
														<td height="26"><input type="radio" name="bitNotIp" id="bitNotIp1" value="1"<% IF bitNotIp = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitNotIp1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitNotIp" id="bitNotIp2" value="0"<% IF bitNotIp = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitNotIp2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
													<tr>
														<td width="90" height="26">경고 메시지</td>
														<td height="26"><input name="strNotIpMsg" type="text" id="strNotIpMsg" style="width:100%" value="<%=strNotIpMsg%>" maxlength="128"></td>
													</tr>
													<tr>
														<td height="26" colspan="2">접근 허용 IP 리스트</td>
													</tr>
													<tr>
														<td height="26" colspan="2">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strNotIpList" rows="4" id="strNotIpList" style="width:98%"><%=strNotIpList%></textarea></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strNotIpList', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strNotIpList', 8);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strNotIpList', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																		</table>
																	</td>
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
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseCategory" class="no_Line">
											카테고리 사용 </td>
											<td class="table_Right1"><input type="radio" name="bitUseCategory" id="bitUseCategory1" value="1"<% IF bitUseCategory = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseCategory1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseCategory" id="bitUseCategory2" value="0"<% IF bitUseCategory = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseCategory2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">카테고리기능의 사용유무를 설정합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseVote" class="no_Line">
											추천기능 사용 </td>
											<td class="table_Right1"><input type="radio" name="bitUseVote" id="bitUseVote1" value="1"<% IF bitUseVote = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseVote1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseVote" id="bitUseVote2" value="0"<% IF bitUseVote = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseVote2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">추천기능의 사용유무를 설정합니다.(추천은 회원만 가능합니다.)</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseComment" class="no_Line">
											댓글기능 사용</td>
											<td class="table_Right1"><input type="radio" name="bitUseComment" id="bitUseComment1" value="1"<% IF bitUseComment = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseComment1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseComment" id="bitUseComment2" value="0"<% IF bitUseComment = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseComment2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">댓글(짧은답변)기능의 사용유무를 설정합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseScrap" class="no_Line">
											스크랩 사용</td>
											<td class="table_Right1"><input type="radio" name="bitUseScrap" id="bitUseScrap1" value="1"<% IF bitUseScrap = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseScrap1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseScrap" id="bitUseScrap2" value="0"<% IF bitUseScrap = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseScrap2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">게시글 스크랩 기능의 사용유무를 설정합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseNickName" class="no_Line">
											게시판 닉네임 사용</td>
											<td class="table_Right1"><input type="radio" name="bitUseNickName" id="bitUseNickName1" value="1"<% IF bitUseNickName = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseNickName1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseNickName" id="bitUseNickName2" value="0"<% IF bitUseNickName = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseNickName2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">게시판에 출력될 이름대신 닉네임을 사용합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseBad" class="no_Line">
											게시글 신고</td>
											<td class="table_Right1"><input type="radio" name="bitUseBad" id="bitUseBad1" value="1"<% IF bitUseBad = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseBad1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseBad" id="bitUseBad2" value="0"<% IF bitUseBad = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseBad2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">광고,홍보등의 불량게시글 신고기능의 사용유무를 설정합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseStat" class="no_Line">
											게시판 접속통계</td>
											<td class="table_Right1"><input type="radio" name="bitUseStat" id="bitUseStat1" value="1"<% IF bitUseStat = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseStat1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseStat" id="bitUseStat2" value="0"<% IF bitUseStat = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseStat2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">접속통계를 사용시 게시판의 속도가 약간 저하됩니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitStatCheck" class="no_Line">
											중복 접속통계</td>
											<td class="table_Right1"><input type="radio" name="bitStatCheck" id="bitStatCheck1" value="1"<% IF bitStatCheck = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitStatCheck1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitStatCheck" id="bitStatCheck2" value="0"<% IF bitStatCheck = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitStatCheck2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">중복 접속통계를 24시간 기준으로 중복 체크를 합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitAdminCheck" class="no_Line">
											게시글 관리자 승인</td>
											<td class="table_Right1"><input type="radio" name="bitAdminCheck" id="bitAdminCheck1" value="1"<% IF bitAdminCheck = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitAdminCheck1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitAdminCheck" id="bitAdminCheck2" value="0"<% IF bitAdminCheck = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitAdminCheck2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">관리자 승인 후 게시글을 게시합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseRss" class="no_Line">
											RSS 기능 사용</td>
											<td class="table_Right1"><input type="radio" name="bitUseRss" id="bitUseRss1" value="1"<% IF bitUseRss = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseRss1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseRss" id="bitUseRss2" value="0"<% IF bitUseRss = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseRss2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">RSS 기능의 사용유무를 설정합니다.</font></td>
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
											<td style="padding-left:15;"><a href="javascript:;" onClick="OnConfigSelect();return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0" align="absmiddle"></a>&nbsp;&nbsp;<a href="javascript:;" onclick="OnBoardConfigCopy('1','<%=strBoardID%>');return false;"><img src="../images/btn_config_copy_w.gif" width="121" height="19" border="0" align="absmiddle"></a></td>
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
											<LI>게시판의 기본적인 환경설정을 설정하실 수 있습니다.</LI>
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
	function OnSubmitAction(){
		str = document.all['strFontSize'];
		if (str.value == ""){alert("기본 폰트 사이즈를 입력해 주시기 바랍니다.");str.focus();return false;}

		if (document.all['bitSecret'][0].checked == true){
			str = document.all['strSecretPassword'];
			if (str.value.length < 4){alert("비밀게시판 비밀번호를 4자리 이상 입력해 주시기 바랍니다.");str.focus();return false;}
		}

		if (document.all['bitNotLink'][0].checked == true){
			str = document.all['strNotLinkMsg'];
			if (str.value == ""){alert("무단링크 메시지를 입력해 주시기 바랍니다.");str.focus();return false;}
		}

		if (document.all['bitNotIp'][0].checked == true){
			str = document.all['strNotIpMsg'];
			if (str.value == ""){alert("IP 접근제한 메시지를 입력해 주시기 바랍니다.");str.focus();return false;}
		}

		document.all['strSkinGroup'].value = parent.BoardSkin.document.all['strSkinGroupSet'].value;
		document.all['strSkin'].value = parent.BoardSkin.document.all['strSkinSet'].value;
	}
</script>
<!-- #include file = "Foot.asp" -->