<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu  = 3
	intLeftMenu = 5
	isAdminMenu = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_LOGIN] ")

	DIM strSkin, strHeadFile, strTailFile, strHeadText, strTailText, strWidth, strAlign, intLogOutTime, intLoginPoint
	DIM strLoginType, strLoginLinkTarget, strLoginMsg, strLoginScript, strLoginUrl, strLoginUrlTarget, strLoginErrorMsg1
	DIM strLoginErrorMsg2, strLoginErrorScript, strLoginErrorUrl, strLoginErrorUrlTarget, strLogOutMsg, strLogOutScript
	DIM strLogOutUrl, strLogOutUrlTarget, bitUseSsnFindID, bitUseSsnFindPW, bitFindEmail

	strSkin                = RS("strSkin")
	strHeadFile            = RS("strHeadFile")
	strTailFile            = RS("strTailFile")
	strHeadText            = GetReplaceTag2UserHtml(RS("strHeadText"))
	strTailText            = GetReplaceTag2UserHtml(RS("strTailText"))
	strWidth               = RS("strWidth")
	strAlign               = RS("strAlign")
	intLogOutTime          = RS("intLogOutTime")
	intLoginPoint          = RS("intLoginPoint")
	strLoginType           = RS("strLoginType")
	strLoginLinkTarget     = RS("strLoginLinkTarget")
	strLoginMsg            = RS("strLoginMsg")
	strLoginScript         = RS("strLoginScript")
	strLoginUrl            = RS("strLoginUrl")
	strLoginUrlTarget      = RS("strLoginUrlTarget")
	strLoginErrorMsg1      = RS("strLoginErrorMsg1")
	strLoginErrorMsg2      = RS("strLoginErrorMsg2")
	strLoginErrorScript    = RS("strLoginErrorScript")
	strLoginErrorUrl       = RS("strLoginErrorUrl")
	strLoginErrorUrlTarget = RS("strLoginErrorUrlTarget")
	strLogOutMsg           = RS("strLogOutMsg")
	strLogOutScript        = RS("strLogOutScript")
	strLogOutUrl           = RS("strLogOutUrl")
	strLogOutUrlTarget     = RS("strLogOutUrlTarget")
	bitUseSsnFindID        = RS("bitUseSsnFindID")
	bitUseSsnFindPW        = RS("bitUseSsnFindPW")
	bitFindEmail           = RS("bitFindEmail")

	DIM strTempSkin, strNowSkinIMG
	strTempSkin = GetFolderList(rootPath & "Skin\Member\Login\", strSkin, "file")
	IF strTempSkin = "" THEN
		strNowSkinIMG = "<img id=skinPrev src=../images/skin_not_image.gif width=160 height=120 align=absmiddle border=0>"
	ELSE
		IF GetFileExists(rootPath & "Skin\Member\Login\" & strSkin & "\", "preview.jpg") = True THEN strNowSkinIMG = "<img id=skinPrev src=../../Skin/Member/Login/" & strSKin & "/preview.jpg width=160 height=120 align=absmiddle border=0>" ELSE strNowSkinIMG = "<img id=skinPrev src=../images/skin_not_image.gif width=160 height=120 align=absmiddle border=0>"
		strTempSkin = SPLIT(strTempSkin, "|")
%>
<script language="javascript">

	var arrSkinPrev = new Array(<%=UBOUND(strTempSkin)%>);
	var arrSkinPrevZoom = new Array(<%=UBOUND(strTempSkin)%>);

<%
	FOR I = 0 TO UBOUND(strTempSkin)
		IF strTempSkin(I) <> "" THEN
			IF GetFileExists(rootPath & "Skin\Member\Login\" & strTempSkin(I) & "\", "preview.jpg") = True THEN
				RESPONSE.WRITE "	arrSkinPrev[" & I & "] = ""../../Skin/Member/Login/" & strTempSkin(I) & "/preview.jpg"";" & vbcrlf
				RESPONSE.WRITE "	arrSkinPrevZoom[" & I & "] = """ & httpPath & "Skin/Member/Login/" & strTempSkin(I) & "/preview.jpg"";" & vbcrlf
			ELSE
				RESPONSE.WRITE "	arrSkinPrev[" & I & "] = ""../images/skin_not_image.gif"";" & vbcrlf
				RESPONSE.WRITE "	arrSkinPrevZoom[" & I & "] = """";" & vbcrlf
			END IF
		END IF
	NEXT
%>
</script>
<% END IF %>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" action="MemberLoginConfig_ok.asp" onSubmit="return OnSubmitAction();">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title9.gif" width="170" height="19"></td>
                      <td align="right">관리자 홈 &gt; 회원관리 &gt; <b>로그인 및 계정 관련설정</b></td>
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
											<td class="table_Left1">스킨선택</td>
											<td class="table_Right1"><select name="strSkin" size="8" id="strSkin" style="width:200" onChange="OnPrevSkin();"><%=GetFolderList(rootPath & "Skin\Member\Login\", strSkin, "skin")%></select>&nbsp;&nbsp;<a href="javascript:;" onClick="OnPopSkinView();"><%=strNowSkinIMG%></a></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">폭(너비) 설정</td>
											<td class="table_Right1">폭(너비) <input name="strWidth" type="text" id="strWidth" value="<%=strWidth%>" size="5" maxlength="4">&nbsp;<span style="color: #FD8402"> (pt 또는 px)</span>
											정렬방식
											<select name="strAlign" id="strAlign">
											<option value="0" <% IF strAlign = "0" THEN %>SELECTED<% END IF %>>좌측 정렬</option>
											<option value="1" <% IF strAlign = "1" THEN %>SELECTED<% END IF %>>가운데 정렬</option>
											<option value="2" <% IF strAlign = "2" THEN %>SELECTED<% END IF %>>우측 정렬</option>
											</select></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">상단 (Head) File</td>
											<td class="table_Right1"><input name="strHeadFile" type="text" id="strHeadFile" style="width:100%" value="<%=strHeadFile%>" maxlength="128"><br><font color="#FD8402">시작경로는 기본으로 설정된 경로부터 시작됩니다.</font></td>
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
											<td class="table_Right1"><input name="strTailFile" type="text" id="strTailFile" style="width:100%" value="<%=strTailFile%>" maxlength="128"><br><font color="#FD8402">시작경로는 기본으로 설정된 경로부터 시작됩니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">하단 (Foot) HTML</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
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
                <td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>로그인 시간 및 포인트 설정</strong></span></td>
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
											<td class="table_Left1">로그아웃 시간</td>
											<td class="table_Right1"><input name="intLogOutTime" type="text" id="intLogOutTime" value="<%=intLogOutTime%>" size="4" maxlength="3">&nbsp;분&nbsp;<font color="#FD8402">세션유지 시간을 설정합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">로그인 타입</td>
											<td class="table_Right1"><select name="strLoginType" id="strLoginType">
											<option value="0"<% IF strLoginType = "0" THEN %> SELECTED<% END IF %>>사용안함</option>
											<option value="1"<% IF strLoginType = "1" THEN %> SELECTED<% END IF %>>아이디 기억</option>
											<option value="2"<% IF strLoginType = "2" THEN %> SELECTED<% END IF %>>아이디/패스워드 기억</option>
											</select></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">로그인 포인트</td>
											<td class="table_Right1"><input name="intLoginPoint" type="text" id="intLoginPoint" onBlur="onlynum(this, '1');" value="<%=intLoginPoint%>" size="5" maxlength="4"> &nbsp;Point&nbsp;<font color="#FD8402">로그인시 지급되는 포인트를 설정합니다. (1일 1회 포인트 지급)</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">로그인 관련버튼 타겟</td>
											<td class="table_Right1">
											<select name="strLoginLinkTarget" id="strLoginLinkTarget">
											<option value=""></option>
											<option value="_self" <% IF strLoginLinkTarget = "_self" THEN %>SELECTED<% END IF %>>self</option>
											<option value="_parent" <% IF strLoginLinkTarget = "_parent" THEN %>SELECTED<% END IF %>>parent</option>
											<option value="_top" <% IF strLoginLinkTarget = "_top" THEN %>SELECTED<% END IF %>>top</option>
											</select>&nbsp;<font color="#FD8402">회원가입, 정보수정 등의 로그인 관련 버튼에 대한 링크</font></td>
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
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>로그인 완료 관련설정</strong></span></td>
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
											<td class="table_Left1">로그인 완료시 메시지</td>
											<td class="table_Right1"><input name="strLoginMsg" type="text" id="strLoginMsg" style="width:100%" value="<%=strLoginMsg%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">스크립트 실행</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>&lt;SCRIPT&gt;</td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strLoginScript" rows="4" id="strLoginScript" style="width:98%"><%=strLoginScript%></textarea></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strLoginScript', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strLoginScript', 4);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strLoginScript', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																		</table>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>&lt;/SCRIPT&gt;</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">로그인 후 이동할 URL</td>
											<td class="table_Right1"><input name="strLoginUrl" type="text" id="strLoginUrl" value="<%=strLoginUrl%>" size="100" maxlength="128">&nbsp;<select name="strLoginUrlTarget" id="strLoginUrlTarget">
											<option value=""></option>
											<option value="_self" <% IF strLoginUrlTarget = "_self" THEN %>SELECTED<% END IF %>>self</option>
											<option value="_parent" <% IF strLoginUrlTarget = "_parent" THEN %>SELECTED<% END IF %>>parent</option>
											<option value="_top" <% IF strLoginUrlTarget = "_top" THEN %>SELECTED<% END IF %>>top</option>
											</select><br><font color="#FD8402">시작경로는 기본으로 설정된 경로부터 시작됩니다.</font></td>
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
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>로그인 실패 관련설정</strong></span></td>
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
											<td class="table_Left1">ID 오류시 메시지</td>
											<td class="table_Right1"><input name="strLoginErrorMsg1" type="text" id="strLoginErrorMsg1" style="width:100%" value="<%=strLoginErrorMsg1%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">PWD 오류시 메시지</td>
											<td class="table_Right1"><input name="strLoginErrorMsg2" type="text" id="strLoginErrorMsg2" style="width:100%" value="<%=strLoginErrorMsg2%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">스크립트 실행</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>&lt;SCRIPT&gt;</td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strLoginErrorScript" rows="4" id="strLoginErrorScript" style="width:98%"><%=strLoginErrorScript%></textarea></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strLoginErrorScript', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strLoginErrorScript', 4);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strLoginErrorScript', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																		</table>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>&lt;/SCRIPT&gt;</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">로그인 오류시 이동 URL</td>
											<td class="table_Right1"><input name="strLoginErrorUrl" type="text" id="strLoginErrorUrl" value="<%=strLoginErrorUrl%>" size="100" maxlength="128">&nbsp;<select name="strLoginErrorUrlTarget" id="strLoginErrorUrlTarget">
											<option value=""></option>
											<option value="_self" <% IF strLoginErrorUrlTarget = "_self" THEN %>SELECTED<% END IF %>>self</option>
											<option value="_parent" <% IF strLoginErrorUrlTarget = "_parent" THEN %>SELECTED<% END IF %>>parent</option>
											<option value="_top" <% IF strLoginErrorUrlTarget = "_top" THEN %>SELECTED<% END IF %>>top</option>
											</select><br><font color="#FD8402">시작경로는 기본으로 설정된 경로부터 시작됩니다.</font></td>
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
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>로그아웃 관련설정</strong></span></td>
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
											<td class="table_Left1">로그아웃 완료 메시지</td>
											<td class="table_Right1"><input name="strLogOutMsg" type="text" id="strLogOutMsg" style="width:100%" value="<%=strLogOutMsg%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">스크립트 실행</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>&lt;SCRIPT&gt;</td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strLogOutScript" rows="4" id="strLogOutScript" style="width:98%"><%=strLogOutScript%></textarea></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strLogOutScript', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strLogOutScript', 4);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strLogOutScript', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																		</table>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>&lt;/SCRIPT&gt;</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">로그아웃 후 이동할 URL</td>
											<td class="table_Right1"><input name="strLogOutUrl" type="text" id="strLogOutUrl" value="<%=strLogOutUrl%>" size="100" maxlength="128">&nbsp;<select name="strLogOutUrlTarget" id="strLogOutUrlTarget">
											<option value=""></option>
											<option value="_self" <% IF strLogOutUrlTarget = "_self" THEN %>SELECTED<% END IF %>>self</option>
											<option value="_parent" <% IF strLogOutUrlTarget = "_parent" THEN %>SELECTED<% END IF %>>parent</option>
											<option value="_top" <% IF strLogOutUrlTarget = "_top" THEN %>SELECTED<% END IF %>>top</option>
											</select><br><font color="#FD8402">시작경로는 기본으로 설정된 경로부터 시작됩니다.</font></td>
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
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>계정정보 찾기 관련설정</strong></span></td>
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
											<td class="table_Left1">아이디 찾기</td>
											<td class="table_Right1"><input name="bitUseSsnFindID" type="checkbox" id="bitUseSsnFindID" value="1"<% IF bitUseSsnFindID = True THEN %> CHECKED<% END IF %> class="no_Line">&nbsp;<LABEL FOR=bitUseSsnFindID style="cursor:hand">주민등록번호를 입력받습니다.</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">비밀번호 찾기</td>
											<td class="table_Right1"><input name="bitUseSsnFindPW" type="checkbox" id="bitUseSsnFindPW" value="1"<% IF bitUseSsnFindPW = True THEN %> CHECKED<% END IF %> class="no_Line">&nbsp;<LABEL FOR=bitUseSsnFindPW style="cursor:hand">주민등록번호를 입력받습니다.</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">출력 형식</td>
											<td class="table_Right1"><input type="radio" name="bitFindEmail" id="bitFindEmail0" value="0"<% IF bitFindEmail = "0" THEN %> CHECKED<% END IF %> class="no_Line">&nbsp;<LABEL FOR=bitFindEmail0 style="cursor:hand">직접출력</LABEL>&nbsp;<input type="radio" name="bitFindEmail" id="bitFindEmail1" value="1"<% IF bitFindEmail = "1" THEN %> CHECKED<% END IF %> class="no_Line">&nbsp;<LABEL FOR=bitFindEmail1 style="cursor:hand">이메일</LABEL>&nbsp;<input type="radio" name="bitFindEmail" id="bitFindEmail2" value="2"<% IF bitFindEmail = "2" THEN %> CHECKED<% END IF %> class="no_Line">&nbsp;<LABEL FOR=bitFindEmail2 style="cursor:hand">직접출력 + 이메일</LABEL></td>
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
											<LI><b>기본 스타일 정보</b> : 사용할 스킨 및 기본적인 페이지 스타일 정보를 설정합니다. </LI>
											<LI><b>로그인 시간 및 포인트 설정</b> : 로그인 유지시간, 계정저장, 포인트를 설정하며, 계정저장은 스킨에 따라 다르게 실행됩니다.</LI>
											<LI><b>로그인 완료 관련설정</b> : 로그인이 완료되었을 경우 실행되는 정보를 설정합니다.</LI>
											<LI><b>로그인 실패 관련설정</b> : 로그인 실패시 실행되는 정보를 설정합니다.</LI>
											<LI><b>로그아웃 관련설정</b> : 로그아웃이 완료되었을 경우 실행되는 정보를 설정합니다.</LI>
											<LI><b>계정정보 찾기 관련설정</b> : 아이디 및 비밀번호 찾기에 관련된 정보를 설정합니다.</LI>
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

	function OnPrevSkin(){
		for (i=0;i<document.all['strSkin'].length;i++){if (document.all['strSkin'][i].selected){nowItem = i;break;}}
		document.all['skinPrev'].src = arrSkinPrev[nowItem];
	}

	function OnSubmitAction(){
		str = document.all['strWidth'];
		if (str.value == ""){alert("너비(폭)을 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['strLoginErrorMsg1'];
		if (str.value == ""){alert("아이디 오류시 출력할 메시지를 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['strLoginErrorMsg2'];
		if (str.value == ""){alert("비밀번호 오류시 출력할 메시지를 입력해 주시기 바랍니다.");str.focus();return false;}
	}

	function OnPopSkinView(){
		for (i=0;i<document.all['strSkin'].length;i++){if (document.all['strSkin'][i].selected){nowItem = i;break;}}
		if (arrSkinPrevZoom[nowItem]!=""){
			parent.popupLayer('../SkinView.asp?strFileName=' + arrSkinPrevZoom[nowItem],800,632);
		}
	}

</script>
<!-- #include file = "Foot.asp" -->