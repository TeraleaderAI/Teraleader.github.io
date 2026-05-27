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
	intBoardConfigMenu = 4

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_WRITE] '" & strBoardID & "' ")

	DIM strWriteDefault, bitUseLink1, bitUseLink2, bitUseReple, strReplePreview, bitUseSecret, bitUseSecretReple, bitUseRepleMail
	DIM bitUseWriteAdminMail, strWriteMailList, bitUseEditor, strEditorWidth, strEditorHeight, bitEditorSource, bitEditorPrev
	DIM strEditorBgColor, bitEditorZoom, intEditorZoomSize, bitEditorHostName, strWriteOkLink, strWriteCustLink, bitWriteAdmin
	DIM bitWriteAdminMsg, bitUseCaptcha, strBadContent, strBadContentReplace, strBadContentMsg, strBadContentList, bitAdminContent
	DIM strAdminContentMsg, strAdminContentList, bitUseUpload, intUploadCount, bitUseUploadLarge, bitUploadAdmin, intUploadSize
	DIM strUploadNotFile, bitUploadReplaceFile, strUploadReplaceFile, bitThrum, intThrumWidth, intThrumHeight, bitThrumScale
	DIM strThrumProg, bitUseWaterMark, strWaterMarkType, strWaterMarkCont, bitUseExif

	strWriteDefault      = RS("strWriteDefault")
	bitUseLink1          = RS("bitUseLink1")
	bitUseLink2          = RS("bitUseLink2")
	bitUseReple          = RS("bitUseReple")
	strReplePreview      = RS("strReplePreview")
	bitUseSecret         = RS("bitUseSecret")
	bitUseSecretReple    = RS("bitUseSecretReple")
	bitUseRepleMail      = RS("bitUseRepleMail")
	bitUseWriteAdminMail = RS("bitUseWriteAdminMail")
	strWriteMailList     = RS("strWriteMailList")
	bitUseEditor         = RS("bitUseEditor")
	strEditorWidth       = RS("strEditorWidth")
	strEditorHeight      = RS("strEditorHeight")
	bitEditorSource      = RS("bitEditorSource")
	bitEditorPrev        = RS("bitEditorPrev")
	strEditorBgColor     = RS("strEditorBgColor")
	bitEditorZoom        = RS("bitEditorZoom")
	intEditorZoomSize    = SPLIT(RS("intEditorZoomSize"), "|")
	bitEditorHostName    = RS("bitEditorHostName")
	strWriteOkLink       = RS("strWriteOkLink")
	strWriteCustLink     = RS("strWriteCustLink")
	bitWriteAdmin        = RS("bitWriteAdmin")
	bitWriteAdminMsg     = RS("bitWriteAdminMsg")
	bitUseCaptcha        = RS("bitUseCaptcha")
	strBadContent        = RS("strBadContent")
	strBadContentReplace = RS("strBadContentReplace")
	strBadContentMsg     = RS("strBadContentMsg")
	strBadContentList    = RS("strBadContentList")
	bitAdminContent      = RS("bitAdminContent")
	strAdminContentMsg   = RS("strAdminContentMsg")
	strAdminContentList  = RS("strAdminContentList")
	bitUseUpload         = RS("bitUseUpload")
	intUploadCount       = RS("intUploadCount")
	bitUseUploadLarge    = RS("bitUseUploadLarge")
	bitUploadAdmin       = RS("bitUploadAdmin")
	intUploadSize        = RS("intUploadSize")
	strUploadNotFile     = RS("strUploadNotFile")
	bitUploadReplaceFile = RS("bitUploadReplaceFile")
	strUploadReplaceFile = RS("strUploadReplaceFile")
	bitThrum             = RS("bitThrum")
	intThrumWidth        = RS("intThrumWidth")
	intThrumHeight       = RS("intThrumHeight")
	bitThrumScale        = RS("bitThrumScale")
	strThrumProg         = RS("strThrumProg")
	bitUseWaterMark      = RS("bitUseWaterMark")
	strWaterMarkType     = RS("strWaterMarkType")
	strWaterMarkCont     = RS("strWaterMarkCont")
	bitUseExif           = RS("bitUseExif")

	IF strWaterMarkCont = "" OR ISNULL(strWaterMarkCont) = True THEN strWaterMarkCont = strBoardID & "|||||"
	strWaterMarkCont = SPLIT(strWaterMarkCont, "|")
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" action="BoardWriteConfig_ok.asp" onSubmit="return OnSubmitAction();" enctype="multipart/form-data">
							<input type="hidden" name="strBoardID" value="<%=strBoardID%>">
              <input type="hidden" name="strPrevWaterMarkFile" value="<%=strWaterMarkCont(1)%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title24.gif" width="139" height="19"></td>
                      <td align="right">관리자 홈 &gt; 게시판관리 &gt; <b>게시판 글쓰기 설정</b></td>
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
              <tr>
                <td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>글쓰기 기본환경 설정</strong></span></td>
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
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strWriteDefault" class="no_Line">본문 기본내용 </td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td style="word-break:break-all;"><textarea name="strWriteDefault" rows="5" id="strWriteDefault" style="width:98%"><%=strWriteDefault%></textarea></td>
														<td width="15" valign="top">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td height="18"><a href="javascript:;" onclick="resize_textarea('strWriteDefault', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onclick="reset_textarea('strWriteDefault', 8);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onclick="resize_textarea('strWriteDefault', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td><span style="color: #E86A34">글쓰기 본문에 기본적으로 출력될 내용입니다.</span></td>
														<td valign="top">&nbsp;</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseLink1,bitUseLink2" class="no_Line">링크기능</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="50%" height="26">링크기능 #1&nbsp;&nbsp;<input type="radio" name="bitUseLink1" id="bitUseLink1_1" value="1"<% IF bitUseLink1 = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseLink1_1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseLink1" id="bitUseLink1_2" value="0"<% IF bitUseLink1 = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseLink1_2" style="cursor:hand">사용안함</LABEL></td>
														<td width="50%" height="26">링크기능 #2&nbsp;&nbsp;<input type="radio" name="bitUseLink2" id="bitUseLink2_1" value="1"<% IF bitUseLink2 = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseLink2_1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseLink2" id="bitUseLink2_2" value="0"<% IF bitUseLink2 = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseLink2_2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseReple,strReplePreview" class="no_Line">답변글 설정</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="26">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td height="26" colspan="2">답변글 쓰기&nbsp;&nbsp;<input type="radio" name="bitUseReple" id="bitUseReple1" value="1"<% IF bitUseReple = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseReple1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseReple" id="bitUseReple2" value="0"<% IF bitUseReple = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseReple2" style="cursor:hand">사용안함</LABEL></td>
																</tr>
																<tr>
																	<td width="50%" height="26">답변글 기본 내용</td>
																	<td width="50%" height="26" align="right" style="padding:0 50 0 0"><select name="strReplePreviewDim" id="strReplePreviewDim" onChange="OnRepleDimSet(this.value);">
																	<option>관련변수 선택</option>
																	<option value="{{strName}}">등록자</option>
																	<option value="{{strSubject}}">제목</option>
																	<option value="{{strContent}}">내용</option>
																	</select></td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strReplePreview" rows="5" id="strReplePreview" style="width:98%"><%=strReplePreview%></textarea></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strReplePreview', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strReplePreview', 8);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strReplePreview', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																		</table>											</td>
																</tr>
																<tr>
																	<td><span style="color: #E86A34">답변글 본문에 출력된 내용을 설정합니다. 변수를 지정할 수 있습니다.</span></td>
																	<td valign="top">&nbsp;</td>
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
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseRepleMail" class="no_Line">답변글 메일받기</td>
											<td class="table_Right1"><input type="radio" name="bitUseRepleMail" id="bitUseRepleMail1" value="1"<% IF bitUseRepleMail = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseRepleMail1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseRepleMail" id="bitUseRepleMail2" value="0"<% IF bitUseRepleMail = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseRepleMail2" style="cursor:hand">사용안함</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseWriteAdminMail,strWriteMailList" class="no_Line">게시글 메일받기</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="26">관리자에게 게시글 메일 자동발송&nbsp;&nbsp;<input type="radio" name="bitUseWriteAdminMail" id="bitUseWriteAdminMail1" value="1"<% IF bitUseWriteAdminMail = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseWriteAdminMail1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseWriteAdminMail" id="bitUseWriteAdminMail2" value="0"<% IF bitUseWriteAdminMail = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseWriteAdminMail2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
													<tr>
														<td height="26">게시글 수신자 메일 리스트</td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strWriteMailList" rows="5" id="strWriteMailList" style="width:98%"><%=strWriteMailList%></textarea><br><font color="#E86A34">메일주소는 엔터로 구분지어서 입력해 주세요.</font></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strWriteMailList', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strWriteMailList', 8);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strWriteMailList', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
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
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseSecret,bitUseSecretReple" class="no_Line">비밀게시물 설정</td>
											<td>
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="50%" height="26">비밀게시물 사용&nbsp;&nbsp;<input type="radio" name="bitUseSecret" id="bitUseSecret1" value="1"<% IF bitUseSecret = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseSecret1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseSecret" id="bitUseSecret2" value="0"<% IF bitUseSecret = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseSecret2" style="cursor:hand">사용안함</LABEL></td>
														<td width="50%" height="26">비밀게시글 답변&nbsp;&nbsp;<input type="radio" name="bitUseSecretReple" id="bitUseSecretReple1" value="1"<% IF bitUseSecretReple = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseSecretReple1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseSecretReple" id="bitUseSecretReple2" value="0"<% IF bitUseSecretReple = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseSecretReple2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseEditor,strEditorWidth,strEditorHeight,bitEditorSource,bitEditorPrev,strEditorBgColor,bitEditorZoom,intEditorZoomSize,bitEditorHostName" class="no_Line">웹 에디터 정보</td>
											<td class="table_Right1">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="24">에디터 사용유뮤</td>
														<td height="24"><input type="radio" name="bitUseEditor" id="bitUseEditor1" value="1"<% IF bitUseEditor = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseEditor1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseEditor" id="bitUseEditor2" value="0"<% IF bitUseEditor = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseEditor2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
													<tr>
														<td width="110" height="24">에디터 크기정보</td>
														<td height="24">너비&nbsp;<input name="strEditorWidth" type="text" id="strEditorWidth" value="<%=strEditorWidth%>" size="6" maxlength="6">&nbsp;(px 또는 %)&nbsp;&nbsp;&nbsp;높이&nbsp;<input name="strEditorHeight" type="text" id="strEditorHeight" value="<%=strEditorHeight%>" size="6" maxlength="6">&nbsp;(px 또는 %)</td>
													</tr>
													<tr>
														<td height="24">소스보기</td>
														<td height="24"><input type="radio" name="bitEditorSource" id="bitEditorSource1" value="1"<% IF bitEditorSource = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitEditorSource1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitEditorSource" id="bitEditorSource2" value="0"<% IF bitEditorSource = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitEditorSource2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
													<tr>
														<td height="24">미리보기</td>
														<td height="24"><input type="radio" name="bitEditorPrev" id="bitEditorPrev1" value="1"<% IF bitEditorPrev = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitEditorPrev1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitEditorPrev" id="bitEditorPrev2" value="0"<% IF bitEditorPrev = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitEditorPrev2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
													<tr>
														<td height="24">편집 배경색</td>
														<td height="24"><input name="strEditorBgColor" type="text" id="strEditorBgColor" onBlur="OnColorSet(document.all['strEditorBgColorPrev'], this);" value="<%=strEditorBgColor%>" size="8" maxlength="7">&nbsp;<INPUT style="BACKGROUND: <%=strEditorBgColor%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strEditorBgColor',410,430);" READONLY size=2 name="strEditorBgColorPrev"></td>
													</tr>
													<tr>
														<td height="24">이미지 ZOOM</td>
														<td height="24"><input type="radio" name="bitEditorZoom" id="bitEditorZoom1" value="1"<% IF bitEditorZoom = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitEditorZoom1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitEditorZoom" id="bitEditorZoom2" value="0"<% IF bitEditorZoom = False THEN %> CHECKED<% END IF %> class="no_Line">
<LABEL FOR="bitEditorZoom2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
													<tr>
														<td height="24">ZOOM 이미지 사이즈</td>
														<td height="24">
														가로&nbsp;<input name="intEditorZoomSize1" type="text" id="intEditorZoomSize1" size="6" maxlength="4" value="<%=intEditorZoomSize(0)%>" onBlur="onlynum(this, 1);">
														&nbsp;px
														세로&nbsp;<input name="intEditorZoomSize2" type="text" id="intEditorZoomSize2" size="6" maxlength="4" value="<%=intEditorZoomSize(1)%>" onBlur="onlynum(this, 1);">
														&nbsp;px
														<font color="#E86A34">이미지 ZOOM 사용시만 적용</font></td>
													</tr>
													<tr>
														<td height="24">에디터 이미지 경로</td>
														<td height="24"><input type="radio" name="bitEditorHostName" id="bitEditorHostName1" value="1"<% IF bitEditorHostName = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitEditorHostName1" style="cursor:hand">사이트 전체주소</LABEL><input type="radio" name="bitEditorHostName" id="bitEditorHostName2" value="0"<% IF bitEditorHostName = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitEditorHostName2" style="cursor:hand">도메인 제외</LABEL></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strWriteOkLink,strWriteCustLink" class="no_Line">게시글 등록후 이동할
											<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;URL</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="26"><input type="radio" name="strWriteOkLink" id="strWriteOkLink1" value="0"<% IF strWriteOkLink = 0 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strWriteOkLink1" style="cursor:hand">등록글 읽기화면</LABEL>
															<input type="radio" name="strWriteOkLink" id="strWriteOkLink2" value="1"<% IF strWriteOkLink = 1 THEN %> CHECKED<% END IF %> class="no_Line">
															<LABEL FOR="strWriteOkLink2" style="cursor:hand">게시글 리스트</LABEL><input type="radio" name="strWriteOkLink" id="strWriteOkLink3" value="2"<% IF strWriteOkLink = 2 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strWriteOkLink3" style="cursor:hand">게시글 등록화면</LABEL><input type="radio" name="strWriteOkLink" id="strWriteOkLink4" value="3"<% IF strWriteOkLink = 3 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strWriteOkLink4" style="cursor:hand">특정페이지</LABEL></td>
													</tr>
													<tr>
														<td height="26"><input name="strWriteCustLink" type="text" id="strWriteCustLink" value="<%=strWriteCustLink%>" style="width:100%"><br><font color="#E86A34">시작경로는 기본으로 설정된 경로부터 시작됩니다.</font></td>
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
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>글쓰기 권한 및 단어차단</strong></span></td>
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
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitWriteAdmin,bitWriteAdminMsg" class="no_Line">기본 글쓰기 권한</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="110" height="26">글쓰기 권한</td>
														<td height="26"><input type="radio" name="bitWriteAdmin" id="bitWriteAdmin1" value="0"<% IF bitWriteAdmin = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitWriteAdmin1" style="cursor:hand">모든사용자</LABEL><input type="radio" name="bitWriteAdmin" id="bitWriteAdmin2" value="1"<% IF bitWriteAdmin = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitWriteAdmin2" style="cursor:hand">관리자 전용</LABEL></td>
													</tr>
													<tr>
														<td width="110" height="26">권한오류 메시지</td>
														<td height="26"><input name="bitWriteAdminMsg" type="text" id="bitWriteAdminMsg" value="<%=bitWriteAdminMsg%>" style="width:100%"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseCaptcha" class="no_Line">자동등록 방지</td>
											<td class="table_Right1">
											<input type="radio" name="bitUseCaptcha" id="bitUseCaptcha1" value="1"<% IF bitUseCaptcha = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseCaptcha1" style="cursor:hand">사용함</LABEL>
											<input type="radio" name="bitUseCaptcha" id="bitUseCaptcha2" value="0"<% IF bitUseCaptcha = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseCaptcha2" style="cursor:hand">사용안함</LABEL>
											<font color="#E86A34">비회원으로 접근시 출력되며, 좌측의 이미지 문자를 입력해야 글이 등록됩니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strBadContent,strBadContentReplace,strBadContentMsg,strBadContentList" class="no_Line">불량단어 차단</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="120" height="26">불량단어 차단</td>
														<td height="26"><input type="radio" name="strBadContent" id="strBadContent1" value="0"<% IF strBadContent = 0 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strBadContent1" style="cursor:hand">사용안함</LABEL><input type="radio" name="strBadContent" id="strBadContent2" value="1"<% IF strBadContent = 1 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strBadContent2" style="cursor:hand">단어치환</LABEL><input type="radio" name="strBadContent" id="strBadContent3" value="2"<% IF strBadContent = 2 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strBadContent3" style="cursor:hand">경고창 출력</LABEL></td>
													</tr>
													<tr>
														<td width="120" height="26">불량단어 치환단어</td>
														<td height="26"><input name="strBadContentReplace" type="text" id="strBadContentReplace" value="<%=strBadContentReplace%>" size="20" maxlength="32"></td>
													</tr>
													<tr>
														<td width="120" height="26">경고메시지</td>
														<td height="26"><input name="strBadContentMsg" type="text" id="strBadContentMsg" value="<%=strBadContentMsg%>" style="width:100%" maxlength="128"></td>
													</tr>
													<tr>
														<td height="26" colspan="2">불량 단어리스트</td>
													</tr>
													<tr>
														<td height="26" colspan="2">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strBadContentList" rows="5" id="strBadContentList" style="width:98%"><%=strBadContentList%></textarea><br><font color="#E86A34">불량단어는 컴마(,)로 구분지어서 입력하세요.</font></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strBadContentList', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strBadContentList', 8);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strBadContentList', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
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
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitAdminContent,strAdminContentMsg,strAdminContentList" class="no_Line">관리자 사칭 차단</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="105" height="26">관리자 사칭차단</td>
														<td height="26"><input type="radio" name="bitAdminContent" id="bitAdminContent1" value="1"<% IF bitAdminContent = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitAdminContent1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitAdminContent" id="bitAdminContent2" value="0"<% IF bitAdminContent = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitAdminContent2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
													<tr>
														<td width="105" height="26">경고 메시지</td>
														<td height="26"><input name="strAdminContentMsg" type="text" id="strAdminContentMsg" value="<%=strAdminContentMsg%>" style="width:100%" maxlength="128"></td>
													</tr>
													<tr>
														<td height="26" colspan="2">차단할 관리자 명칭 리스트 </td>
													</tr>
													<tr>
														<td height="26" colspan="2">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="739" style="word-break:break-all;"><textarea name="strAdminContentList" rows="5" id="strAdminContentList" style="width:98%"><%=strAdminContentList%></textarea><br><font color="#E86A34">관리자 사칭 단어는 컴마(,)로 구분지어서 입력하세요.</font></td>
																	<td width="17" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strAdminContentList', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strAdminContentList', 8);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strAdminContentList', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
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
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>글쓰기 파일업로드 설정</strong></span></td>
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
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseUpload,intUploadCount,bitUseUploadLarge,bitUploadAdmin,intUploadSize,strUploadNotFile,bitUploadReplaceFile,strUploadReplaceFile" class="no_Line">파일 업로드 설정</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="110" height="26">파일 업로드</td>
																	<td width="195"><input type="radio" name="bitUseUpload" id="bitUseUpload1" value="1"<% IF bitUseUpload = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseUpload1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseUpload" id="bitUseUpload2" value="0"<% IF bitUseUpload = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseUpload2" style="cursor:hand">사용안함</LABEL></td>
																	<td width="110">파일 업로드 개수</td>
																	<td width="195"><input name="intUploadCount" type="text" id="intUploadCount"onBlur="onlynum(this, '1');" value="<%=intUploadCount%>" size="4" maxlength="10">&nbsp;개</td>
																</tr>
																<tr>
																	<td height="26">대용량 업로드</td>
																	<td colspan="3"><input type="radio" name="bitUseUploadLarge" id="bitUseUploadLarge1" value="1"<% IF bitUseUploadLarge = True THEN %> CHECKED<% END IF %> class="no_Line" onClick="OnDextCheck();"><LABEL FOR="bitUseUploadLarge1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseUploadLarge" id="bitUseUploadLarge2" value="0"<% IF bitUseUploadLarge = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseUploadLarge2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">Dext Upload Pro 컴포넌트에서만 사용하실 수 있습니다.</font></td>
																	</tr>
																<tr>
																	<td height="26">파일 업로드 권한</td>
																	<td colspan="3"><input type="radio" name="bitUploadAdmin" id="bitUploadAdmin1" value="0"<% IF bitUploadAdmin = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUploadAdmin1" style="cursor:hand">모든사용자</LABEL><input type="radio" name="bitUploadAdmin" id="bitUploadAdmin2" value="1"<% IF bitUploadAdmin = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUploadAdmin2" style="cursor:hand">관리자 전용</LABEL></td>
																	</tr>
																<tr>
																	<td height="26">제한 용량 사이즈</td>
																	<td colspan="3"><input name="intUploadSize" type="text" id="intUploadSize"onBlur="onlynum(this, '1');" value="<%=intUploadSize%>" size="10" maxlength="10">
																		&nbsp;MB&nbsp;<font color="#E86A34">대용량 업로드를 사용시 전체용량, 일반 업로드 사용시 각 파일별 체크</font></td>
																	</tr>
															</table>
														</td>
														</tr>
													<tr>
														<td height="26">업로드 금지 파일 확장자 리스트</td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strUploadNotFile" rows="5" id="strUploadNotFile" style="width:98%"><%=strUploadNotFile%></textarea></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strUploadNotFile', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strUploadNotFile', 8);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strUploadNotFile', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																		</table>											</td>
																</tr>
																<tr>
																	<td><font color="#E86A34">업로드 금지 확장자는 컴마(,)로 구분지어서 입력하세요.</font></td>
																	<td valign="top">&nbsp;</td>
																</tr>
															</table>														</td>
													</tr>
													<tr>
														<td height="14">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="110" height="26">파일 확장자 변환</td>
																	<td height="26"><input type="radio" name="bitUploadReplaceFile" id="bitUploadReplaceFile1" value="1"<% IF bitUploadReplaceFile = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUploadReplaceFile1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUploadReplaceFile" id="bitUploadReplaceFile2" value="0"<% IF bitUploadReplaceFile = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUploadReplaceFile2" style="cursor:hand">사용안함</LABEL></td>
																</tr>
															</table>
														</td>
														</tr>
													<tr>
														<td height="26">파일 확장자 변환 리스트</td>
													</tr>
													<tr>
														<td height="26">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strUploadReplaceFile" rows="5" id="strUploadReplaceFile" style="width:98%"><%=strUploadReplaceFile%></textarea></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strUploadReplaceFile', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strUploadReplaceFile', 8);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strUploadReplaceFile', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																		</table>											</td>
																</tr>
																<tr>
																	<td><font color="#E86A34">파일 확장자를 변환할 확장자 입력은 컴마(,)로 구분지어서 입력하세요.</font></td>
																	<td valign="top">&nbsp;</td>
																</tr>
															</table>														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitThrum,intThrumWidth,intThrumHeight,bitThrumScale,strThrumProg,bitUseWaterMark,strWaterMarkType,strWaterMarkCont,bitUseExif" class="no_Line">이미지 업로드</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="130" height="26">썸네일 사용유무</td>
														<td height="26"><input type="radio" name="bitThrum" id="bitThrum1" value="1"<% IF bitThrum = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitThrum1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitThrum" id="bitThrum2" value="0"<% IF bitThrum = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitThrum2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
													<tr>
														<td height="26">썸네일 컴포넌트</td>
														<td height="26">
                            <input type="radio" name="strThrumProg" id="strThrumProg1" value="1" class="no_Line"<% IF strThrumProg = "1" THEN %> CHECKED<% END IF %> /><LABEL FOR="strThrumProg1" style="cursor:hand">나누미</LABEL>
														<input type="radio" name="strThrumProg" id="strThrumProg2" value="2" class="no_Line"<% IF strThrumProg = "2" THEN %> CHECKED<% END IF %> /><LABEL FOR="strThrumProg2" style="cursor:hand">Dext Pro</LABEL>
                            <font color="#E86A34">썸네일은 나누미 또는 Dext Pro 컴포넌트만 지원합니다.</font></td>
													</tr>
													<tr>
														<td height="26">썸네일 이미지 설정&nbsp;&nbsp;</LABEL></td>
														<td height="26">
                            가로크기&nbsp;<input name="intThrumWidth" type="text" id="intThrumWidth"onBlur="onlynum(this, '1');" value="<%=intThrumWidth%>" size="4" maxlength="10">
                            &nbsp;&nbsp;
                            세로크기&nbsp;<input name="intThrumHeight" type="text" id="intThrumHeight"onBlur="onlynum(this, '1');" value="<%=intThrumHeight%>" size="4" maxlength="10">&nbsp;&nbsp;&nbsp;&nbsp;<input name="bitThrumScale" type="checkbox" id="bitThrumScale" value="1"<% IF bitThrumScale = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitThrumScale" style="cursor:hand">원본 비율 유지</LABEL>
                            </td>
													</tr>
													<tr>
														<td height="26">이미지 워터마크</td>
														<td height="26">
                            <input type="radio" name="bitUseWaterMark" id="bitUseWaterMark1" value="1"<% IF bitUseWaterMark = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseWaterMark1" style="cursor:hand">사용함</LABEL>
                            <input type="radio" name="bitUseWaterMark" id="bitUseWaterMark2" value="0"<% IF bitUseWaterMark = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseWaterMark2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
													<tr>
														<td height="26">워터마크 옵션</td>
														<td height="26">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td height="30">
                                  <input type="radio" name="strWaterMarkType" id="strWaterMarkType1" value="1"<% IF strWaterMarkType = "1" THEN %> CHECKED<% END IF %> class="no_Line" /><LABEL FOR="strWaterMarkType1" style="cursor:hane">이미지 타입</LABEL>
																	<input type="radio" name="strWaterMarkType" id="strWaterMarkType2" value="2"<% IF strWaterMarkType = "2" THEN %> CHECKED<% END IF %> class="no_Line" /><LABEL FOR="strWaterMarkType2" style="cursor:hane">텍스트 타입</LABEL></td>
                                </tr>
                                <tr>
                                  <td height="30">이미지 파일명 : <input name="strFileName" type="file" id="strFileName" size="40" /></td>
                                </tr>
<% IF strWaterMarkCont(1) <> "" AND ISNULL(strWaterMarkCont(1)) = False THEN %>
                                <tr>
                                  <td style="padding-top:5px; padding-bottom:5px"><img src="../../Pds/Board/<%=strWaterMarkCont(0)%>/WaterMark/<%=strWaterMarkCont(1)%>"></td>
                                </tr>
<% END IF %>
                                <tr>
                                  <td height="30">텍스트 내용 : <input name="strMarkText" type="text" id="strMarkText" size="60" maxlength="32" value="<%=strWaterMarkCont(2)%>" /></td>
                                </tr>
                                <tr>
                                  <td height="30">X좌표 : 
                                    <input name="intMarkX" type="text" id="intMarkX" onBlur="onlynum(this,1);" value="<%=strWaterMarkCont(3)%>" size="4" maxlength="4" /> 
                                    Y좌표 : 
                                    <input name="intMarkY" type="text" id="intMarkY" onBlur="onlynum(this,1);" value="<%=strWaterMarkCont(4)%>" size="4" maxlength="4" /> 
                                    : 폰트크기 : 
                                    <input name="intMarkFont" type="text" id="intMarkFont" onBlur="onlynum(this,1);" value="<%=strWaterMarkCont(5)%>" size="2" maxlength="2" /> 
                                    pt
                                    <br><font color="#E86A34">PosX가 -10, PosY -10일 경우 이미지의 우하단에 위치합니다.</font></td>
                                </tr>
                              </table>
                            </td>
													</tr>
													<tr>
														<td height="26">이미지 파일정보 저장</td>
														<td height="26"><input type="radio" name="bitUseExif" id="bitUseExif1" value="1"<% IF bitUseExif = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseExif1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseExif" id="bitUseExif2" value="0"<% IF bitUseExif = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseExif2" style="cursor:hand">사용안함</LABEL><br><font color="#E86A34">이미지에 대한 노출 시간, 이미지 설명, 해상도등 다양한 메타 정보를 저장합니다.</font></td>
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
											<td style="padding-left:15;"><a href="javascript:;" onClick="OnConfigSelect();return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0" align="absmiddle"></a>&nbsp;&nbsp;<a href="javascript:;" onclick="OnBoardConfigCopy('4','<%=strBoardID%>');return false;"><img src="../images/btn_config_copy_w.gif" width="121" height="19" border="0" align="absmiddle"></a></td>
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
											<LI>게시글 쓰기에 관련된 환경설정을 설정하실 수 있습니다.</LI>
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

	var SET_setUploadComponet = "<%=setUploadComponet%>";

	function OnRepleDimSet(str){
		document.all['strReplePreview'].value = document.all['strReplePreview'].value + str;
	}

	function OnSubmitAction(){
		if (document.all['strWriteOkLink'][3].checked == true){
			str = document.all['strWriteCustLink'];
			if (str.value == ""){alert("글쓰기 완료 후 이동할 페이지를 입력해 주시기 바랍니다.");str.focus();return false;}
		}

		if (document.all['bitWriteAdmin'][1].checked == true){
			str = document.all['bitWriteAdminMsg'];
			if (str.value == ""){alert("권한 오류메시지를 입력해 주시기 바랍니다.");str.focus();return false;}
		}
		
		if (document.all['strBadContent'][1].checked == true){
			str = document.all['strBadContentReplace'];
			if (str.value == ""){alert("불량단어 치환문자를 입력해 주시기 바랍니다.");str.focus();return false;}
		}

		if (document.all['strBadContent'][2].checked == true){
			str = document.all['strBadContentReplace'];
			if (str.value == ""){alert("불량단어 오류 메시지를 입력해 주시기 바랍니다.");str.focus();return false;}
		}

		if (document.all['bitAdminContent'][0].checked == true){
			str = document.all['strAdminContentMsg'];
			if (str.value == ""){alert("관리자 사칭 오류 메시지를 입력해 주시기 바랍니다.");str.focus();return false;}
		}

	}

	function OnDextCheck(){
		if (SET_setUploadComponet != "2"){
			alert("대용량 업로드는 Dext Upload Pro 버전의 업로드 컴포넌트에서만\n사용이 가능합니다.\n업로드 컴포넌트를 DEXT UPLOAD 로 변경해 주시기 바랍니다.");
			document.all['bitUseUploadLarge'][1].checked = true;
		}
	}

</script>
<!-- #include file = "Foot.asp" -->