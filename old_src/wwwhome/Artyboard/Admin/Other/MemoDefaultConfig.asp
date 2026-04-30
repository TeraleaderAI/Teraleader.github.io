<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 8
	intLeftMenu  = 2
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMO_CONFIG] ")

	DIM strBrowser, strFont, strFontSize, intTopMargin, intLeftMargin, intRightMargin, strColorBg, strColorActive, strColorHover
	DIM strColorVisited, strColorLink, strUserCss, strHeadFile, strTailFile, strHeadText, strTailText, strWidth, strAlign, strSkin
	DIM strSkinGroup, bitUsage, bitSound, strSoundFile, intMemoTime, intMemoSaveCount, intPageCount

	strBrowser       = RS("strBrowser")
	strFont          = RS("strFont")
	strFontSize      = RS("strFontSize")
	intTopMargin     = RS("intTopMargin")
	intLeftMargin    = RS("intLeftMargin")
	intRightMargin   = RS("intRightMargin")
	strColorBg       = RS("strColorBg")
	strColorActive   = RS("strColorActive")
	strColorHover    = RS("strColorHover")
	strColorVisited  = RS("strColorVisited")
	strColorLink     = RS("strColorLink")
	strUserCss       = RS("strUserCss")
	strHeadFile      = RS("strHeadFile")
	strTailFile      = RS("strTailFile")
	strHeadText      = RS("strHeadText")
	strTailText      = RS("strTailText")
	strWidth         = RS("strWidth")
	strAlign         = RS("strAlign")
	strSkin          = RS("strSkin")
	strSkinGroup     = RS("strSkinGroup")
	bitUsage         = RS("bitUsage")
	bitSound         = RS("bitSound")
	strSoundFile     = RS("strSoundFile")
	intMemoTime      = RS("intMemoTime")
	intMemoSaveCount = RS("intMemoSaveCount")
	intPageCount     = RS("intPageCount")

	DIM strTempSkin, strNowSkinIMG
	strTempSkin = GetFolderList(rootPath & "Skin\Member\Memo\", strSkin, "file")
	IF strTempSkin = "" THEN
		strNowSkinIMG = "<img id=skinPrev src=../images/skin_not_image.gif width=160 height=120 align=absmiddle border=0>"
	ELSE
		IF GetFileExists(rootPath & "Skin\Member\Memo\" & strSkin & "\", "preview.jpg") = True THEN strNowSkinIMG = "<img id=skinPrev src=../../Skin/Member/Memo/" & strSKin & "/preview.jpg width=160 height=120 align=absmiddle border=0>" ELSE strNowSkinIMG = "<img id=skinPrev src=../images/skin_not_image.gif width=160 height=120 align=absmiddle border=0>"
		strTempSkin = SPLIT(strTempSkin, "|")
%>
<script language="javascript">

	var arrSkinPrev = new Array(<%=UBOUND(strTempSkin)%>);
	var arrSkinPrevZoom = new Array(<%=UBOUND(strTempSkin)%>);

<%
	FOR I = 0 TO UBOUND(strTempSkin)
		IF strTempSkin(I) <> "" THEN
			IF GetFileExists(rootPath & "Skin\Member\Memo\" & strTempSkin(I) & "\", "preview.jpg") = True THEN
				RESPONSE.WRITE "	arrSkinPrev[" & I & "] = ""../../Skin/Member/Memo/" & strTempSkin(I) & "/preview.jpg"";" & vbcrlf
				RESPONSE.WRITE "	arrSkinPrevZoom[" & I & "] = """ & httpPath & "Skin/Member/Memo/" & strTempSkin(I) & "/preview.jpg"";" & vbcrlf
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
							<form name="theForm" method="post" action="MemoDefaultConfig_ok.asp?Action=EDIT" onSubmit="return OnSubmitAction();" enctype="multipart/form-data">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title45.gif" width="107" height="19"></td>
                      <td align="right">관리자 홈 &gt; 기타관리 &gt; <b>메모 환경설정</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>기본 스타일 정보</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">스킨선택</td>
											<td class="table_Right1">
											<select name="strSkin" size="8" id="strSkin" style="width:170" onChange="OnPrevSkin();">
											<%=GetFolderList(rootPath & "Skin\Member\Memo\", strSkin, "skin")%>
											</select>&nbsp;&nbsp;<a href="javascript:;" onClick="OnPopSkinView();"><%=strNowSkinIMG%></a></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">브라우저 상단 메시지</td>
											<td class="table_Right1"><input name="strBrowser" type="text" id="strBrowser" style="width:100%" value="<%=strBrowser%>" maxlength="128"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">기본글꼴 / 사이즈</td>
											<td class="table_Right1"><select name="strFont" class="select" id="strFont">
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
											<td class="table_Right1">상단&nbsp;<input name="intTopMargin" type="text" id="intTopMargin"onBlur="onlynum(this, '1');" value="<%=intTopMargin%>" size="5">&nbsp;px&nbsp;&nbsp;좌측&nbsp;<input name="intLeftMargin" type="text" id="intLeftMargin"onBlur="onlynum(this, '1');" value="<%=intLeftMargin%>" size="5" maxlength="4">&nbsp;px&nbsp;&nbsp;우측&nbsp;<input name="intRightMargin" type="text" id="intRightMargin"onBlur="onlynum(this, '1');" value="<%=intRightMargin%>" size="5" maxlength="4">&nbsp;px&nbsp;<span style="color: #FD8402">픽셀단위 기준</span></td>
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
																		</table>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>&lt;/STYLE&gt;</td>
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
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>상단 및 하단 파일 또는 HTML 정보</strong></span></td>
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
											<td class="table_Right1"><input name="strTailFile" type="text" id="strTailFile" style="width:98%" value="<%=strTailFile%>" maxlength="128"><br><span style="color: #FD8402">시작경로는 기본으로 설정된 경로부터 시작됩니다.</span></td>
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
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>메모 기능설정</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
							<tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">메모사용</td>
											<td class="table_Right1"><input type="radio" name="bitUsage" id="bitUsage1" value="1"<% IF bitUsage = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUsage1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUsage" id="bitUsage2" value="0"<% IF bitUsage = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUsage2" style="cursor:hand">사용안함</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">사운드 출력</td>
											<td class="table_Right1"><input type="radio" name="bitSound" id="bitSound1" value="1"<% IF bitSound = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitSound1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitSound" id="bitSound2" value="0"<% IF bitSound = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitSound2" style="cursor:hand">사용안함</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">사운드 파일</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<%
	IF strSoundFile <> "" AND ISNULL(strSoundFile) = False THEN
%>
													<tr>
														<td height="24"><bgsound id="presound" src=""><a href="javascript:;" onClick="OnMemoPlaySound('../../Pds/Memo/<%=strSoundFile%>','<%=UCASE(REPLACE(MID(strSoundFile, INSTRREV(strSoundFile, ".") + 1), ".", ""))%>');return false;"><img src="../images/btn_sound_w.gif" width="83" height="19" border="0" align="absmiddle" /></a>&nbsp;<a href="javascript:;" onClick="OnMemoRemoveSound();return false;"><img src="../images/btn_sound_delete_w.gif" width="83" height="19" border="0" align="absmiddle" /></a></td>
													</tr>
<%
	END IF
%>
													<tr>
														<td height="24"><input name="strFileName" type="file" size="30">&nbsp;<span style="color: #FD8402">파일형식 MP3,WAV,MID,WMA,ASF,ASX,SWF</span></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">메모확인 새로고침</td>
											<td class="table_Right1"><input name="intMemoTime" type="text" id="intMemoTime" value="<%=intMemoTime%>" size="4" maxlength="4"onBlur="onlynum(this, '1');">&nbsp;분</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">메모저장 제한개수</td>
											<td class="table_Right1"><input name="intMemoSaveCount" type="text" id="intMemoSaveCount" value="<%=intMemoSaveCount%>" size="4" maxlength="4"onBlur="onlynum(this, '1');">&nbsp;개</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">페이지 출력 메모수</td>
											<td class="table_Right1"><input name="intPageCount" type="text" id="intPageCount" value="<%=intPageCount%>" size="4" maxlength="4"onBlur="onlynum(this, '1');">&nbsp;개</td>
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
											<LI>스킨에 따라 메모 도착 알림 사운드가 출력되지 않을 수 있습니다.</LI>
											<LI>확장자가 SWF (플래시파일) 은 미리 듣기가 불가능하오니, 이점 확인해 주시기 바랍니다.</LI>
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
		str = document.all['strFontSize'];
		if (str.value == ""){alert("기본 폰트 사이즈를 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['strWidth'];
		if (str.value == ""){alert("너비(폭)을 입력해 주시기 바랍니다.");str.focus();return false;}
	}

	function OnMemoPlaySound(str1, str2){
		if (str2 == "SWF"){
			alert("플래시 파일은 미리듣기가 불가능합니다.");
			return false;
		}else{
			document.all['presound'].src = str1;
		}
	}

	function OnMemoRemoveSound(){
		if (confirm("사운드 파일을 삭제하시겠습니까?")){
			document.theForm.action = "MemoDefaultConfig_ok.asp?Action=REMOVE";
			document.theForm.submit();
		}
	}

	function OnPopSkinView(){
		for (i=0;i<document.all['strSkin'].length;i++){if (document.all['strSkin'][i].selected){nowItem = i;break;}}
		if (arrSkinPrevZoom[nowItem]!=""){
			parent.popupLayer('../SkinView.asp?strFileName=' + arrSkinPrevZoom[nowItem],800,632);
		}
	}

</script>
<!-- #include file = "Foot.asp" -->