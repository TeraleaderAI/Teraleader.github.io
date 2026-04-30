<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu  = 3
	intLeftMenu = 3
	isAdminMenu = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_JOIN] ")

	DIM strSkin, strSkinGroup, strDefaultGroupCode, strJoinType, bitJoinEmailActivate, strActivateSubject, strActivateContent
	DIM strHeadFile, strTailFile, strHeadText, strTailText, strWidth, strAlign, intJoinPoint, intRecPoint, bitJoinEmail
	DIM strJoinNotMsg, bitJoinResult, strJoinMsg, strJoinScript, strJoinUrl, strJoinUrlTarget, strEditMsg, strEditScript
	DIM strEditUrl, strEditUrlTarget, bitOutType, strOutMsg, strOutScript, strOutUrl, strOutUrlTarget
	DIM strJoinNotEmail, SELECTED, I

	strSkin              = RS("strSkin")
	strSkinGroup         = RS("strSkinGroup")
	strDefaultGroupCode  = RS("strDefaultGroupCode")
	strJoinType          = RS("strJoinType")
	bitJoinEmailActivate = RS("bitJoinEmailActivate")
	strActivateSubject   = RS("strActivateSubject")
	strActivateContent   = RS("strActivateContent")
	strHeadFile          = RS("strHeadFile")
	strTailFile          = RS("strTailFile")
	strHeadText          = GetReplaceTag2UserHtml(RS("strHeadText"))
	strTailText          = GetReplaceTag2UserHtml(RS("strTailText"))
	strWidth             = RS("strWidth")
	strAlign             = RS("strAlign")
	intJoinPoint         = RS("intJoinPoint")
	intRecPoint          = RS("intRecPoint")
	bitJoinEmail         = RS("bitJoinEmail")
	strJoinNotMsg        = RS("strJoinNotMsg")
	bitJoinResult        = RS("bitJoinResult")
	strJoinMsg           = RS("strJoinMsg")
	strJoinScript        = RS("strJoinScript")
	strJoinUrl           = RS("strJoinUrl")
	strJoinUrlTarget     = RS("strJoinUrlTarget")
	strEditMsg           = RS("strEditMsg")
	strEditScript        = RS("strEditScript")
	strEditUrl           = RS("strEditUrl")
	strEditUrlTarget     = RS("strEditUrlTarget")
	bitOutType           = RS("bitOutType")
	strOutMsg            = RS("strOutMsg")
	strOutScript         = RS("strOutScript")
	strOutUrl            = RS("strOutUrl")
	strOutUrlTarget      = RS("strOutUrlTarget")
	strJoinNotEmail      = RS("strJoinNotEmail")

	DIM strTempSkin, strNowSkinIMG
	strTempSkin = GetFolderList(rootPath & "Skin\Member\Join\", strSkin, "file")
	IF strTempSkin = "" THEN
		strNowSkinIMG = "<img id=skinPrev src=../images/skin_not_image.gif width=160 height=120 align=absmiddle border=0>"
	ELSE
		IF GetFileExists(rootPath & "Skin\Member\Join\" & strSkin & "\", "preview.gif") = True THEN strNowSkinIMG = "<img id=skinPrev src=../../Skin/Member/Join/" & strSKin & "/preview.gif width=160 height=120 align=absmiddle border=0>" ELSE strNowSkinIMG = "<img id=skinPrev src=../images/skin_not_image.gif width=160 height=120 align=absmiddle border=0>"
		strTempSkin = SPLIT(strTempSkin, "|")
%>
<script language="javascript">

	var arrSkinPrev = new Array(<%=UBOUND(strTempSkin)%>);
	var arrSkinPrevZoom = new Array(<%=UBOUND(strTempSkin)%>);

<%
	FOR I = 0 TO UBOUND(strTempSkin)
		IF strTempSkin(I) <> "" THEN
			IF GetFileExists(rootPath & "Skin\Member\Join\" & strTempSkin(I) & "\", "preview.gif") = True THEN
				RESPONSE.WRITE "	arrSkinPrev[" & I & "] = ""../../Skin/Member/Join/" & strTempSkin(I) & "/preview.jpg"";" & vbcrlf
				RESPONSE.WRITE "	arrSkinPrevZoom[" & I & "] = """ & httpPath & "Skin/Member/Join/" & strTempSkin(I) & "/preview.jpg"";" & vbcrlf
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
							<form name="theForm" method="post" action="MemberJoinConfig_ok.asp" onSubmit="return OnSubmitAction();">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title7.gif" width="134" height="19"></td>
                      <td align="right">관리자 홈 &gt; 회원관리 &gt; <b>회원가입 관련설정</b></td>
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
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>스킨정보 및 기본 스타일 정보</strong></span></td>
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
											<td class="table_Right1"><select name="strSkin" size="8" id="strSkin" style="width:170" onChange="OnPrevSkin();"><%=GetFolderList(rootPath & "Skin\Member\Join\", strSkin, "skin")%></select>&nbsp;&nbsp;<a href="javascript:;" onClick="OnPopSkinView();"><%=strNowSkinIMG%></a></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">폭(너비) 및 정렬방식</td>
											<td class="table_Right1">폭(너비) <input name="strWidth" type="text" id="strWidth" value="<%=strWidth%>" size="5" maxlength="4">&nbsp;<span style="color: #FD8402"> (pt 또는 px)</span>
											정렬방식
											<select name="strAlign" id="strAlign">
											<option value="0" <% IF strAlign = "0" THEN %>SELECTED<% END IF %>>좌측 정렬</option>
											<option value="1" <% IF strAlign = "1" THEN %>SELECTED<% END IF %>>가운데 정렬</option>
											<option value="2" <% IF strAlign = "2" THEN %>SELECTED<% END IF %>>우측 정렬</option>
											</select>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
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
											<td class="table_Right1"><input name="strTailFile" type="text" id="strTailFile" style="width:100%" value="<%=strTailFile%>" maxlength="128"><br><span style="color: #FD8402">시작경로는 기본으로 설정된 경로부터 시작됩니다.</span></td>
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
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>회원가입 기본설정</strong></span></td>
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
											<td class="table_Left1">가입 완료시 이용권한</td>
											<td class="table_Right1"><select name="strJoinType" id="strJoinType" onChange="OnMemberJoinType(this.value);">
											<option value="0" <% IF strJoinType = "0" THEN %>SELECTED<% END IF %>>신청시 가입완료</option>
											<option value="1" <% IF strJoinType = "1" THEN %>SELECTED<% END IF %>>관리자 인증후 완료</option>
											<option value="2" <% IF strJoinType = "2" THEN %>SELECTED<% END IF %>>가입불가</option>
											</select>&nbsp;<span style="color: #FD8402">회원가입완료 후 권한을 설정합니다.</span></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr id="trJoinNotMsg" style="display:<% IF strJoinType = "2" THEN %>block<% ELSE %>none<% END IF %>">
											<td class="table_Left1">가입 불가시 메시지</td>
											<td class="table_Right1"><input name="strJoinNotMsg" type="text" id="strJoinNotMsg" style="width:100%" value="<%=strJoinNotMsg%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">가입 E-MAIL 인증 </td>
											<td class="table_Right1"><input type="checkbox" name="bitJoinEmailActivate" id="bitJoinEmailActivate" value="1"<% IF bitJoinEmailActivate = True THEN %> CHECKED<% END IF %> class="no_Line" onclick="OnEmailActivate();"><LABEL FOR="bitJoinEmailActivate" style="cursor:hand">E-MAIL 인증 시스템을 사용합니다.</LABEL><br><font color="#FD8402">회원가입시 등록한 회원은 E-MAIL로 발송되는 인증링크를 클릭해야 회원 가입이 완료됩니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr id="tr_EmailActivate" style="display:<% IF bitJoinEmailActivate = True THEN %>block<% ELSE %>none<% END IF %>">
											<td class="table_Left1">인증메일 발송 제목</td>
											<td class="table_Right1"><input name="strActivateSubject" type="text" id="strActivateSubject" style="width:100%" value="<%=strActivateSubject%>" maxlength="128"></td>
										</tr>
										<tr id="tr_EmailActivate" style="display:<% IF bitJoinEmailActivate = True THEN %>block<% ELSE %>none<% END IF %>">
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr id="tr_EmailActivate" style="display:<% IF bitJoinEmailActivate = True THEN %>block<% ELSE %>none<% END IF %>">
											<td class="table_Left1">인증메일 발송 내용</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td style="word-break:break-all;"><textarea name="strActivateContent" rows="8" id="strActivateContent" style="width:98%"><%=strActivateContent%></textarea></td>
														<td width="15" valign="top">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strActivateContent', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="reset_textarea('strActivateContent', 8);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strActivateContent', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr id="tr_EmailActivate" style="display:<% IF bitJoinEmailActivate = True THEN %>block<% ELSE %>none<% END IF %>">
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">가입 후 기본그룹</td>
											<td class="table_Right1"><select name="strDefaultGroupCode" id="strDefaultGroupCode">
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_GROUP] ")
	WHILE NOT(RS.EOF)
		IF RS("strGroupCode") = strDefaultGroupCode THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		RESPONSE.WRITE "<option value=" & RS("strGroupCode") & SELECTED & ">" & RS("strGroupName") & "</option>" & vbcrlf
	RS.MOVENEXT
	WEND
%>
											</select>&nbsp;<font color="#FD8402">회원가입 완료시 기본그룹을 지정합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">회원가입 포인트</td>
											<td class="table_Right1">회원가입시 <input name="intJoinPoint" type="text" id="intJoinPoint" onBlur="onlynum(this, '1');" value="<%=intJoinPoint%>" size="5" maxlength="4">&nbsp;<b>Point</b>&nbsp;추천인 지급 <input name="intRecPoint" type="text" id="intRecPoint" onBlur="onlynum(this, '1');" value="<%=intRecPoint%>" size="5" maxlength="4">&nbsp;<b>Point</b><font color="#FD8402">&nbsp;포인트를 지급하지 않으려면 0을 입력하세요.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">회원가입 완료 메일발송</td>
											<td class="table_Right1"><input type="radio" name="bitJoinEmail" id="bitJoinEmail2" value="1"<% IF bitJoinEmail = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL for="bitJoinEmail2" style="cursor:hand"><b>가입메일 발송함</b></LABEL>&nbsp;<input type="radio" name="bitJoinEmail" id="bitJoinEmail1" value="0"<% IF bitJoinEmail = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL for="bitJoinEmail1" style="cursor:hand"><b>가입메일 발송안함</b></LABEL>&nbsp;<font color="#FD8402">회원 가입시 발송되는 메일설정</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">회원가입시 등록불가<br>이메일 리스트</td>
											<td class="table_Right1">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strJoinNotEmail" rows="6" class="textarea" id="strJoinNotEmail" style="width:98%" onFocus="this.className='textareafs'" onBlur="this.className='textarea'"><%=strJoinNotEmail%></textarea></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strJoinNotEmail', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strJoinNotEmail', 6);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strJoinNotEmail', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																		</table>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td><font color="#FD8402">엔터로 구분지어 도메인만 입력 예) hanmail.net</font></td>
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
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>회원가입 완료 설정</strong></span></td>
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
											<td class="table_Left1">회원가입 결과페이지</td>
											<td class="table_Right1"><input type="radio" name="bitJoinResult" id="bitJoinResult1" value="1"<% IF bitJoinResult = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitJoinResult1" style="cursor:hand"><b>사용함</b></LABEL>&nbsp;<input type="radio" name="bitJoinResult" id="bitJoinResult2" value="0"<% IF bitJoinResult = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitJoinResult2" style="cursor:hand"><b>사용안함</b></LABEL>&nbsp;<font color="#FD8402">회원가입 후 가입정보 표시 출력 유무를 설정합니다.</font><br><span style="color: #FD8402"><b>이 기능을 사용하면 회원가입 후 완료메시지 출력 및 실행할 자바스크립트는 실행이 되지 않습니다.</b></span></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">완료 메시지</td>
											<td class="table_Right1"><input name="strJoinMsg" type="text" id="strJoinMsg" style="width:100%" value="<%=strJoinMsg%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">실행할 자바 스크립트</td>
											<td class="table_Right1">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>&lt;SCRIPT&gt;</td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strJoinScript" rows="4" id="strJoinScript" style="width:98%"><%=strJoinScript%></textarea></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strJoinScript', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strJoinScript', 4);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strJoinScript', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
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
											<td class="table_Left1">가입 후 이동할 URL</td>
											<td class="table_Right1"><input name="strJoinUrl" type="text" id="strJoinUrl" value="<%=strJoinUrl%>" size="100" maxlength="128">&nbsp;<select name="strJoinUrlTarget" id="strJoinUrlTarget">
											<option value=""></option>
											<option value="_self" <% IF strJoinUrlTarget = "_self" THEN %>SELECTED<% END IF %>>self</option>
											<option value="_parent" <% IF strJoinUrlTarget = "_parent" THEN %>SELECTED<% END IF %>>parent</option>
											<option value="_top" <% IF strJoinUrlTarget = "_top" THEN %>SELECTED<% END IF %>>top</option>
											</select><br><font color="#FD8402">시작경로는 기본으로 설정된 경로부터 시작됩니다.</font>
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
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>회원정보 수정완료 설정</strong></span></td>
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
											<td class="table_Left1">완료 메시지</td>
											<td class="table_Right1"><input name="strEditMsg" type="text" id="strEditMsg" value="<%=strEditMsg%>" style="width:100%"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">실행할 자바 스크립트</td>
											<td class="table_Right1">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>&lt;SCRIPT&gt;</td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strEditScript" rows="4" id="strEditScript" style="width:98%"><%=strEditScript%></textarea></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strEditScript', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strEditScript', 4);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strEditScript', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
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
											<td class="table_Left1">정보수정 후 이동 URL</td>
											<td class="table_Right1"><input name="strEditUrl" type="text" id="strEditUrl" value="<%=strEditUrl%>" size="100" maxlength="128">&nbsp;<select name="strEditUrlTarget" id="strEditUrlTarget">
											<option value=""></option>
											<option value="_self" <% IF strEditUrlTarget = "_self" THEN %>SELECTED<% END IF %>>self</option>
											<option value="_parent" <% IF strEditUrlTarget = "_parent" THEN %>SELECTED<% END IF %>>parent</option>
											<option value="_top" <% IF strEditUrlTarget = "_top" THEN %>SELECTED<% END IF %>>top</option>
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
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>회원탈퇴 관련설정</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">회원 탈퇴 방법</td>
											<td class="table_Right1"><input type="radio" name="bitOutType" id="bitOutType0" value="0" <% IF bitOutType = False THEN %>CHECKED<% END IF %> class="no_Line"><LABEL FOR=bitOutType0 style='cursor:hand;'>관리자 확인 후 정보삭제</LABEL>&nbsp;<input type="radio" name="bitOutType" id="bitOutType1" value="1" <% IF bitOutType = True THEN %>CHECKED<% END IF %> class="no_Line"><LABEL FOR=bitOutType1 style='cursor:hand;'>탈퇴 즉시 정보삭제</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">완료 메시지</td>
											<td class="table_Right1"><input name="strOutMsg" type="text" id="strOutMsg" style="width:100%" value="<%=strOutMsg%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">실행할 자바 스크립트</td>
											<td class="table_Right1">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>&lt;SCRIPT&gt;</td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strOutScript" rows="4" id="strOutScript" style="width:98%"><%=strOutScript%></textarea></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strOutScript', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strOutScript', 4);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strOutScript', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
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
											<td class="table_Left1">탈퇴완료 후 이동 URL</td>
											<td class="table_Right1"><input name="strOutUrl" type="text" id="strOutUrl" value="<%=strOutUrl%>" size="100" maxlength="128">&nbsp;<select name="strOutUrlTarget" id="strOutUrlTarget">
											<option value=""></option>
											<option value="_self" <% IF strOutUrlTarget = "_self" THEN %>SELECTED<% END IF %>>self</option>
											<option value="_parent" <% IF strOutUrlTarget = "_parent" THEN %>SELECTED<% END IF %>>parent</option>
											<option value="_top" <% IF strOutUrlTarget = "_top" THEN %>SELECTED<% END IF %>>top</option></select><br><font color="#FD8402">시작경로는 기본으로 설정된 경로부터 시작됩니다.</font></td>
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
											<LI><b>스킨정보 및 기본 스타일 정보</b> : 사용할 스킨 및 기본적인 페이지 스타일 정보를 설정합니다.</LI>
											<LI><b>회원가입 기본설정</b> : 회원가입에 필요한 설정을 합니다.</LI>
											<LI><b>회원가입 완료 설정</b> : 회원가입이 완료시 실행될 환경정보를 설정합니다.</LI>
											<LI><b>회원정보 수정완료 설정</b> : 회원정보수정 완료시 실행될 환경정보를 설정합니다.</LI>
											<LI><b>회원탈퇴 관련설정</b> : 회원탈퇴시 실행될 환경정보를 설정합니다.</LI>
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

	function OnEmailActivate(){
		if (document.all['bitJoinEmailActivate'].checked == true){
			document.all['tr_EmailActivate'][0].style.display = "block";
			document.all['tr_EmailActivate'][1].style.display = "block";
			document.all['tr_EmailActivate'][2].style.display = "block";
			document.all['tr_EmailActivate'][3].style.display = "block";
		}else{
			document.all['tr_EmailActivate'][0].style.display = "none";
			document.all['tr_EmailActivate'][1].style.display = "none";
			document.all['tr_EmailActivate'][2].style.display = "none";
			document.all['tr_EmailActivate'][3].style.display = "none";
		}
	}

	function OnPrevSkin(){
		for (i=0;i<document.all['strSkin'].length;i++){if (document.all['strSkin'][i].selected){nowItem = i;break;}}
		document.all['skinPrev'].src = arrSkinPrev[nowItem];
	}

	function OnMemberJoinType(str){
		if (str == "2"){
			document.all['trJoinNotMsg'].style.display = "block";
		}else{
			document.all['trJoinNotMsg'].style.display = "none";
		}
	}

	function OnSubmitAction(){
		str = document.all['strWidth'];
		if (str.value == ""){alert("너비(폭)을 입력해 주시기 바랍니다.");str.focus();return false;}

		if (document.all['bitJoinEmailActivate'].checked == true){
			str = document.all['strActivateSubject'];
			if (str.value == ""){alert("인증메일 발송 제목을 입력해 주시기 바랍니다.");str.focus();return false;}

			str = document.all['strActivateContent'];
			if (str.value == ""){alert("인증메일 발송 내용을 입력해 주시기 바랍니다.");str.focus();return false;}
		}

		if (document.all['strJoinType'].value == "2"){
			str = document.all['strJoinNotMsg'];
			if (str.value == ""){alert("가입불가시 출력될 메시지를 입력해 주시기 바랍니다.");str.focus();return false;}
		}

		str = document.all['strJoinUrl'];
		if (str.value == ""){alert("회원가입 후 이동할 경로를 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['strEditUrl'];
		if (str.value == ""){alert("회원정보수정 후 이동할 경로를 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['strOutUrl'];
		if (str.value == ""){alert("회원탈퇴 후 이동할 경로를 입력해 주시기 바랍니다.");str.focus();return false;}
	}

	function OnPopSkinView(){
		for (i=0;i<document.all['strSkin'].length;i++){if (document.all['strSkin'][i].selected){nowItem = i;break;}}
		if (arrSkinPrevZoom[nowItem]!=""){
			parent.popupLayer('../SkinView.asp?strFileName=' + arrSkinPrevZoom[nowItem],800,632);
		}
	}

</script>
<!-- #include file = "Foot.asp" -->