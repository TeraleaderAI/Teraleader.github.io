<!-- #include file = "../../../../Include/BoardIncludeWrite.asp" -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="<%=LINK_BOARD_ADD%>" onSubmit="return verify_data();">
<input type="hidden" name="strLoginID" value="<%=WRITE_strLoginID%>">
<input type="hidden" name="strBoardBg" value="<%=WRITE_strBoardBg%>">
<input type="hidden" name="bitHtmlBr" value="0">
<input type="hidden" name="strSessionID" value="<%=SESSION.SESSIONID%>">
	<tr>
		<td height="25" align="right">
		<% IF CONF_bitUseRss = True THEN %><a href="<%=CONF_strRssLink%>" target="_blank"><img src="<%=skinPath%>images/btn_rss.gif" width="13" height="13" align="absmiddle" class="topBtnMarg"></a><% END IF %>
		<% IF CONF_strLinkHomepage <> False THEN %><a href="<%=CONF_strLinkHomepage%>" target="<%=CONF_strLinkHomepageTarget%>" class="skinList">홈페이지</a><img src="<%=skinPath%>images/table_bar_line.gif" class="topBtnMarg"><% END IF %><% IF SESSION("strLoginID") = "" THEN %><a href="<%=CONF_strMemberJoinLink%>" class="skinList">회원가입</a><img src="<%=skinPath%>images/table_bar_line.gif" class="topBtnMarg"><a href="<%=CONF_strLoginLink%>" class="skinList">로그인</a><img src="<%=skinPath%>images/table_bar_line.gif" class="topBtnMarg"><% ELSE %><a href="<%=CONF_strMemberEditLink%>" class="skinList">정보수정</a><img src="<%=skinPath%>images/table_bar_line.gif" class="topBtnMarg"><a href="<%=CONF_strLogoutLink%>" class="skinList">로그아웃</a><img src="<%=skinPath%>images/table_bar_line.gif" class="topBtnMarg"><% END IF %><% IF CONF_bitUseMemo = True THEN %><a href="memo.asp?Action=list" class="skinList">쪽지</a><img src="<%=skinPath%>images/table_bar_line.gif" class="topBtnMarg"><% END IF %><% IF CONF_bitUseScrap = True THEN %><a href="scrap.asp?Action=list" target="_blank" class="skinList">스크랩</a><img src="<%=skinPath%>images/table_bar_line.gif" class="topBtnMarg"><% END IF %><% IF CONF_bitBoardAdmin = True THEN %><a href="Admin/Default.asp" target="_blank" class="skinList">관리자</a><% END IF %>
		</td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="10" cellspacing="1" bgcolor="#E0E1DB">
				<tr>
					<td bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td class="w80 h33">글쓴이</td>
											<td><input name="strName" type="text" class="input" id="strName" value="<%=WRITE_strName%>" size="20" maxlength="20"></td>
										</tr>
<% IF SESSION("strLoginID") = "" THEN %>
										<tr>
											<td class="w80 h33">비밀번호</td>
											<td><input name="strPassword" type="password" id="strPassword" value="<%=WRITE_strPassword%>" size="20" maxlength="20" class="input"></td>
										</tr>
<% END IF %>
										<tr>
											<td class="w80 h33">이메일 주소</td>
											<td><input name="strEmail" type="text" id="strEmail" value="<%=WRITE_strEmail%>" size="40" maxlength="64" class="input"></td>
										</tr>
										<tr>
											<td class="w80 h33">홈페이지</td>
											<td><input name="strHomepage" type="text" id="strHomepage" value="<%=WRITE_strHomepage%>" size="40" maxlength="64" class="input"></td>
										</tr>
										<tr>
											<td class="w80 h33">글제목</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
<% IF CONF_bitUseCategory = True THEN %>
																	<td class="h33 pdr5"><%=strCategoryForm%></td>
<% END IF %>
																	<td width="100%" class="h33"><input name="strSubject" type="text" id="strSubject" value="<%=WRITE_strSubject%>" style="width:90%" maxlength="64" class="input"></td>
																</tr>
															</table>
														</td>
													</tr>
<% IF CONF_bitSubjectStyleLevel = True THEN %>
													<tr>
														<td class="h33">
														<%=GetSubjectStyleForm("1", WRITE_strSubjectStyle(0))%>
														<%=GetSubjectStyleForm("2", WRITE_strSubjectStyle(1))%>
														<%=GetSubjectStyleForm("3", WRITE_strSubjectStyle(2))%>
														<%=GetSubjectStyleForm("4", WRITE_strSubjectStyle(3))%>
														</td>
													</tr>
<% END IF %>
												</table>
											</td>
										</tr>
										<tr>
											<td class="w80 h33">옵션</td>
											<td>
											<% IF CONF_bitUseEditor = False THEN%><input name="bitHtml" type="checkbox" class="no_Line" id="bitHtml" value="1"<% IF WRITE_bitHtml = True THEN %> CHECKED<% END IF %> onClick="OnHtmlBr();"><LABEL STYLE='cursor:hand;' FOR=bitHtml>HTML</LABEL>&nbsp;<input name="bitText" type="checkbox" class="no_Line" id="bitText" value="1"<% IF WRITE_bitText = True THEN %> CHECKED<% END IF %>><LABEL STYLE='cursor:hand;' FOR=bitText>TEXT</LABEL><% END IF %>
											<% IF CONF_bitBoardAdmin = True THEN %><input name="bitNotice" type="checkbox" class="no_Line" id="bitNotice" value="1"<% IF WRITE_bitNotice = True THEN %> CHECKED<% END IF %>><LABEL STYLE='cursor:hand;' FOR=bitNotice>공지사항</LABEL><% END IF %>
											<% IF CONF_bitUseRepleMail = True THEN %><input name="bitReMail" type="checkbox" class="no_Line" id="bitReMail" value="1"<% IF WRITE_bitReMail = True THEN %> CHECKED<% END IF %>><LABEL STYLE='cursor:hand;' FOR=bitReMail>답변글 메일</LABEL><% END IF %>
											<% IF CONF_bitUseSecret = True THEN %><input name="bitSecret" type="checkbox" class="no_Line" id="bitSecret" value="1"<% IF WRITE_bitSecret = True THEN %> CHECKED<% END IF %>><LABEL STYLE='cursor:hand;' FOR=bitSecret>비밀글</LABEL><% END IF %>
											<input name="bitCook" type="checkbox" class="no_Line" id="bitCook" value="1" checked><LABEL STYLE='cursor:hand;' FOR=bitCook>등록자 정보기억</LABEL>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td><textarea name="strContent" cols="70" rows="16" id="strContent" style="display:<% IF CONF_bitUseEditor = False THEN %>block<% ELSE %>none<% END IF %>; width:98%"><%=WRITE_strContent%></textarea><% IF CONF_bitUseEditor = True THEN %><script type="text/javascript" language="javascript">myeditor.run();</script><% END IF %></td>
							</tr>
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
<% IF CONF_bitUseLink1 = True THEN %>
										<tr>
											<td class="w80 h33">링크주소</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="100%" style="padding-right:5px"><input name="strLink1" type="text" id="strLink1" value="<%=WRITE_strLink1%>" style="width:100%" maxlength="512" class="input"></td>
														<td>
														<select name="strLink1Target" id="strLink1Target">
														<option value="_blank"<% IF WRITE_strLink1Target = "_blank" THEN %> SELECTED<% END IF %>>_blank</option>
														<option value="_parent"<% IF WRITE_strLink1Target = "_parent" THEN %> SELECTED<% END IF %>>_parent</option>
														<option value="_self"<% IF WRITE_strLink1Target = "_self" THEN %> SELECTED<% END IF %>>_self</option>
														<option value="_top"<% IF WRITE_strLink1Target = "_top" THEN %> SELECTED<% END IF %>>_top</option>
														</select>
														</td>
													</tr>
												</table>
											</td>
										</tr>
<% END IF %>
<% IF CONF_bitUseLink2 = True THEN %>
										<tr>
											<td class="w80 h33">링크주소</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="100%"><input name="strLink2" type="text" id="strLink2" value="<%=WRITE_strLink2%>" style="width:100%" maxlength="512" class="input"></td>
														<td width="0" class="pdl5">
														<select name="strLink2Target" id="strLink2Target">
														<option value='_blank'<% IF WRITE_strLink2Target = "_blank" THEN %> SELECTED<% END IF %>>_blank</option>
														<option value='_parent'<% IF WRITE_strLink2Target = "_parent" THEN %> SELECTED<% END IF %>>_parent</option>
														<option value='_self'<% IF WRITE_strLink2Target = "_self" THEN %> SELECTED<% END IF %>>_self</option>
														<option value='_top'<% IF WRITE_strLink2Target = "_top" THEN %> SELECTED<% END IF %>>_top</option>
														</select>
														</td>
													</tr>
												</table>
											</td>
										</tr>
<% END IF %>
<% IF CONF_bitUseUpload = True THEN %>
										<tr>
											<td class="w80 h33">파일 첨부</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
<% IF UCASE(Action) = "EDIT" THEN %>
													<tr>
														<td>
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="120" height="120">
																		<table width="110" height="110" border="0" cellpadding="0" cellspacing="1" bgcolor="#E1E1DD">
																			<tr>
																				<td align="center" bgcolor="#FFFFFF"><span id="imtPrev"></span></td>
																			</tr>
																		</table>
																	</td>
																	<td>
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td>
																				<select name="strFileList" size="5" multiple="multiple" id="strFileList" style="width:100%" onChange="OnWritePrevIMG(this.value);">
<%
	FOR I = 1 TO WRITE_intFileCount
		RESPONSE.WRITE "<option value='" & WRITE_REDIM_intImageFileNum(I) & "," & WRITE_REDIM_strImageFileName(I) & "'>" & WRITE_REDIM_strImageFileName(I) & " - " & GetFilesize(WRITE_REDIM_intFileSize(I)) & "</option>" & vbcrlf
	NEXT
%>
																				</select>
																				</td>
																			</tr>
																			<tr>
																				<td>
																					<table width="100%" border="0" cellspacing="0" cellpadding="0">
																						<tr>
																							<td valign="bottom" height="28">
<% IF WRITE_strUploadDelete <> "0" THEN %>
<% IF WRITE_strUploadDelete = "1" THEN %>
																							<input name="strFilePass" type="hidden" id="strFilePass" value="<%=WRITE_strPassword%>" size="20" maxlength="20">
<% END IF %>
																							<a href="javascript:;" onClick="OnUploadFileDelete('<%=WRITE_strUploadDelete%>');return false;"><img src="<%=skinPath%>images/btn_select_delete.gif" width="107" height="23" align="absmiddle" /></a>
<% END IF %>
																							</td>
																							<td align="right" style="color:#AAAAAA">현재 업로드 사이즈 : <%=CONF_intNowUploadSize%></td>
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
<% END IF %>
													<tr>
														<td class="pdt10"><iframe name="chxUpload" src="<%=CONF_strUploadLink%>" width="100%" frameborder="0" scrolling="auto" onload="this.style.height=this.contentWindow.document.body.scrollHeight"></iframe></td>
													</tr>
												</table>
											</td>
										</tr>
<% END IF %>
<% IF CONF_bitUseCaptcha = True THEN %>
										<tr>
											<td class="w80 h33">무단입력 방지</td>
											<td>
											<img src="Library/captcha.asp" alt="왼쪽의 글자를 순서대로 입력하세요." align="absbottom">
											<input name="strCaptchaText" type="text" id="strCaptchaText" size="14" maxlength="6" class="input">
											왼쪽의 글자를 순서대로 입력하세요.
											</td>
										</tr>
<% END IF %>
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
		<td height="40" align="right">
		<div id="writeButton" style="display:block">
		<a href="javascript:verify_data();"><img src="<%=skinPath%>images/btn_save.gif" border="0" align="absmiddle"></a>
		<a href="javascript:history.go(-1);"><img src="<%=skinPath%>images/btn_back.gif" border="0" align="absmiddle"></a>
		<a href="javascript:OnBoardList();"><img src="<%=skinPath%>images/btn_list.gif" border="0" align="absmiddle"></a>
		</div>
		</td>
	</tr>
	</form>
</table>