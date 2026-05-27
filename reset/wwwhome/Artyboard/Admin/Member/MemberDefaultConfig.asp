<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu  = 3
	intLeftMenu = 1
	isAdminMenu = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_DEFAULT] ")
	DIM strBrowser, strFont, strFontSize, intTopMargin, intLeftMargin, intRightMargin, strColorBg, strColorActive, strColorHover
	DIM strColorVisited, strColorLink, strUserCss, bitUseMarkAvata, bitUseNameAvata, intNameAvataWidth, intNameAvataHeight
	DIM strHeadFile, strTailFile, strHeadText, strTailText

	strBrowser         = RS("strBrowser")
	strFont            = RS("strFont")
	strFontSize        = RS("strFontSize")
	intTopMargin       = RS("intTopMargin")
	intLeftMargin      = RS("intLeftMargin")
	intRightMargin     = RS("intRightMargin")
	strColorBg         = RS("strColorBg")
	strColorActive     = RS("strColorActive")
	strColorHover      = RS("strColorHover")
	strColorVisited    = RS("strColorVisited")
	strColorLink       = RS("strColorLink")
	strUserCss         = RS("strUserCss")
	bitUseMarkAvata    = RS("bitUseMarkAvata")
	bitUseNameAvata    = RS("bitUseNameAvata")
	intNameAvataWidth  = RS("intNameAvataWidth")
	intNameAvataHeight = RS("intNameAvataHeight")
	strHeadFile        = RS("strHeadFile")
	strTailFile        = RS("strTailFile")
	strHeadText        = GetReplaceTag2UserHtml(RS("strHeadText"))
	strTailText        = GetReplaceTag2UserHtml(RS("strTailText"))
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" action="MemberDefaultConfig_ok.asp" onSubmit="return OnSubmitAction();">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title5.gif" width="139" height="19"></td>
                      <td align="right">관리자 홈 &gt; 회원관리 &gt; <b>회원 기본환경 설정</b></td>
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
                      <td align="right"><input name="imageField2" type="image" id="imageField" src="../images/btn_board_submit_g.gif" align="absmiddle" class="no_Line"></td>
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
											<td class="table_Left1">브라우저 상단 메시지</td>
											<td class="table_Right1"><input name="strBrowser" type="text" id="strBrowser" style="width:100%" value="<%=strBrowser%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">기본글꼴 / 사이즈</td>
											<td class="table_Right1"><select name="strFont" id="strFont">
											<option value="">기본글꼴선택</option>
											<option value="굴림" <% IF strFont = "굴림" THEN %>SELECTED<% END IF %>>굴림</option>
											<option value="굴림체" <% IF strFont = "굴림체" THEN %>SELECTED<% END IF %>>굴림체</option>
											<option value="돋움" <% IF strFont = "돋움" THEN %>SELECTED<% END IF %>>돋움</option>
											<option value="돋움체" <% IF strFont = "돋움체" THEN %>SELECTED<% END IF %>>돋움체</option>
											<option value="바탕" <% IF strFont = "바탕" THEN %>SELECTED<% END IF %>>바탕</option>
											<option value="바탕체" <% IF strFont = "바탕체" THEN %>SELECTED<% END IF %>>바탕체</option>
											<option value="궁서" <% IF strFont = "궁서" THEN %>SELECTED<% END IF %>>궁서</option>
											<option value="궁서체" <% IF strFont = "궁서체" THEN %>SELECTED<% END IF %>>궁서체</option></select>&nbsp;<input name="strFontSize" type="text" id="strFontSize" value="<%=strFontSize%>" size="5" maxlength="5">&nbsp;<span style="color: #FD8402"><span style="font-weight: bold">단위</span> : 포인트는 pt, 픽셀은 px로 등록합니다.</span></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">여백</td>
											<td class="table_Right1">상단&nbsp;
												<input name="intTopMargin" type="text" id="intTopMargin" value="<%=intTopMargin%>" size="5">&nbsp;px&nbsp;&nbsp;좌측&nbsp;<input name="intLeftMargin" type="text" id="intLeftMargin" value="<%=intLeftMargin%>" size="5" maxlength="4">&nbsp;px&nbsp;&nbsp;우측&nbsp;<input name="intRightMargin" type="text" id="intRightMargin" value="<%=intRightMargin%>" size="5" maxlength="4">&nbsp;<span style="color: #FD8402">픽셀단위 기준</span></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">배경색</td>
											<td class="table_Right1">
											<input name="strColorBg" type="text" id="strColorBg" onBlur="OnColorSet(document.all['strColorBgPrev'], this);" value="<%=strColorBg%>" size="8" maxlength="7">&nbsp;<INPUT style="BACKGROUND: <%=strColorBg%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strColorBg',410,430);" READONLY size=2 name="strColorBgPrev"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">링크 관련색</td>
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
											<td class="table_Left1">사용자 스타일</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><b>&lt;STYLE&gt;</b></td>
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
														<td><b>&lt;/STYLE&gt;</b></td>
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
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>마크 및 이름 이미지 정보</strong></span></td>
                      <td align="right"><input name="imageField2" type="image" id="imageField" src="../images/btn_board_submit_g.gif" align="absmiddle" class="no_Line"></td>
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
											<td class="table_Left1">마크 이미지 사용</td>
											<td class="table_Right1"><input type="radio" name="bitUseMarkAvata" id="bitUseMarkAvata1" value="1"<% IF bitUseMarkAvata = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseMarkAvata1" style="cursor:hand">사용함</LABEL>&nbsp;<input type="radio" name="bitUseMarkAvata" id="bitUseMarkAvata2" value="0"<% IF bitUseMarkAvata = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseMarkAvata2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#FD8402">그룹에서 설정된 마크이미지 사용 유무를 설정합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">이름 이미지 사용</td>
											<td class="table_Right1"><input type="radio" name="bitUseNameAvata" id="bitUseNameAvata1" value="1"<% IF bitUseNameAvata = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseNameAvata1" style="cursor:hand">사용함</LABEL>&nbsp;<input type="radio" name="bitUseNameAvata" id="bitUseNameAvata2" value="0"<% IF bitUseNameAvata = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseNameAvata2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#FD8402">이름 대신에 출력할 이름이미지 사용 유무를 설정합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">이름 이미지 사이즈</td>
											<td class="table_Right1">가로&nbsp;
												<input name="intNameAvataWidth" type="text" id="intNameAvataWidth" value="<%=intNameAvataWidth%>" size="5" onblur="onlynum(this, 1);">&nbsp;px&nbsp;&nbsp;세로&nbsp;<input name="intNameAvataHeight" type="text" id="intNameAvataHeight" value="<%=intNameAvataHeight%>" size="5" maxlength="4" onblur="onlynum(this, 1);">&nbsp;px&nbsp;<font color="#FD8402">이름 이미지의 출력사이즈를 설정합니다.</font></td>
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
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>상단 및 하단 파일 또는 HTML 정보</strong></span></td>
                      <td align="right"><input name="imageField2" type="image" id="imageField" src="../images/btn_board_submit_g.gif" align="absmiddle" class="no_Line"></td>
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
											<td class="table_Left1">상단 (Head) File</td>
											<td class="table_Right1"><input name="strHeadFile" type="text" id="strHeadFile" style="width:100%" value="<%=strHeadFile%>" maxlength="128"><br><span style="color: #FD8402">시작경로는 기본으로 설정된 경로부터 시작됩니다.</span></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">상단 (Head) HTML</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td style="word-break:break-all;"><textarea name="strHeadText" rows="8" id="strHeadText" style="width:98%"><%=strHeadText%></textarea></td>
														<td width="15" valign="top">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strHeadText', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="reset_textarea('strHeadText', 6);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
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
											<td class="table_Left1">하단 (Foot) File</td>
											<td class="table_Right1"><input name="strTailFile" type="text" id="strTailFile" style="width:100%" value="<%=strTailFile%>" maxlength="128"><br>
												<span style="color: #FD8402">시작경로는 기본으로 설정된 경로부터 시작됩니다.</span></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">하단 (Foot) HTML</td>
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
																	<td height="18"><a href="javascript:;" onClick="reset_textarea('strTailText', 6);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strTailText', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
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
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							<tr>
								<td align="right" style="padding-right:20;"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
							</tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI><b>기본 스타일 정보</b> : 기본적인 페이지 스타일 정보를 설정합니다.</LI>
											<LI><b>마크 및 이름 이미지 정보</b> : 게시판 또는 기타 페이지에서 마크 이미지를 출력하거나 이름대신 회원이 등록한 이미지를 출력.</LI>
											<LI><b>상단 및 하단 파일 또는 HTML 정보</b> : 회원관련 페이지의 상단 및 하단에 파일을 출력하거나 HTML 태그를 출력합니다.</LI>
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
	}

</script>
<!-- #include file = "Foot.asp" -->