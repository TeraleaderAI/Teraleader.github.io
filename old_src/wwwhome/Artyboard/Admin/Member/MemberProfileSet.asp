<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 4
	intLeftMenu  = 9
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM strSkin, strSkinGroup, bitUseGroup, bitUseVisit, bitUsePoint, bitUseSignDate, bitUseRegDate
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_PROFILE] ")

	strSkin        = RS("strSkin")
	strSkinGroup   = RS("strSkinGroup")
	bitUseGroup    = RS("bitUseGroup")
	bitUseVisit    = RS("bitUseVisit")
	bitUsePoint    = RS("bitUsePoint")
	bitUseSignDate = RS("bitUseSignDate")
	bitUseRegDate  = RS("bitUseRegDate")

	DIM strTempSkin, strNowSkinIMG
	strTempSkin = GetFolderList(rootPath & "Skin\Member\Profile\", strSkin, "file")
	IF strTempSkin = "" THEN
		strNowSkinIMG = "<img id=skinPrev src=../images/skin_not_image.gif width=160 height=120 align=absmiddle border=0>"
	ELSE
		IF GetFileExists(rootPath & "Skin\Member\Profile\" & strSkin & "\", "preview.jpg") = True THEN strNowSkinIMG = "<img id=skinPrev src=../../Skin/Member/Profile/" & strSKin & "/preview.jpg width=160 height=120 align=absmiddle border=0>" ELSE strNowSkinIMG = "<img id=skinPrev src=../images/skin_not_image.gif width=160 height=120 align=absmiddle border=0>"
		strTempSkin = SPLIT(strTempSkin, "|")
%>
<script language="javascript">

	var arrSkinPrev = new Array(<%=UBOUND(strTempSkin)%>);
	var arrSkinPrevZoom = new Array(<%=UBOUND(strTempSkin)%>);

<%
	FOR I = 0 TO UBOUND(strTempSkin)
		IF strTempSkin(I) <> "" THEN
			IF GetFileExists(rootPath & "Skin\Member\Profile\" & strTempSkin(I) & "\", "preview.jpg") = True THEN
				RESPONSE.WRITE "	arrSkinPrev[" & I & "] = ""../../Skin/Member/Profile/" & strTempSkin(I) & "/preview.jpg"";" & vbcrlf
				RESPONSE.WRITE "	arrSkinPrevZoom[" & I & "] = """ & httpPath & "Skin/Member/Profile/" & strTempSkin(I) & "/preview.jpg"";" & vbcrlf
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
							<form name="theForm" method="post" action="MemberProfileSet_ok.asp">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title13.gif" width="152" height="19"></td>
                      <td align="right">관리자 홈 &gt; 회원관리 &gt; <b>회원 프로필 열람설정</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>프로필 열람 스킨정보</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">스킨선택</td>
											<td class="table_Right1"><select name="strSkin" size="8" id="strSkin" style="width:170" onChange="OnPrevSkin();"><%=GetFolderList(rootPath & "Skin\Member\Profile\", strSkin, "skin")%></select>&nbsp;&nbsp;<a href="javascript:;" onClick="OnPopSkinView();"><%=strNowSkinIMG%></a></td>
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
											<td style="padding-right:5;" width="50%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>기본 프로필 출력항목</strong></span></td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellpadding="0" cellspacing="0">
																<tr align="center" bgcolor="EB766F">
																	<td colspan="3" class="table_Round1"></td>
																</tr>
																<tr align="center" bgcolor="EB766F">
																	<td height="30" class="table_Txt1" nowrap>번호</td>
																	<td height="30" class="table_Txt1" nowrap>출력유무</td>
																	<td height="30" nowrap bgcolor="EB766F" class="table_Txt1">항목이름</td>
																</tr>
																<tr bgcolor="EB766F">
																	<td colspan="3" class="table_Round1"></td>
																</tr>
						<%
							SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_JOIN_ITEM] ")
							iCount = 0
						
							WHILE NOT(RS.EOF)
							iCount = iCount + 1
						%>
																<tr bgcolor="#FFFFFF" align="center">
																	<td class="table_ListSubText1"><%=iCount%></td>
																	<td class="table_ListSubText1"><input name="<%=RS("strItem")%>" type="checkbox" id="<%=RS("strItem")%>" value="1"<% IF RS("bitUseProfile") = True THEN %> CHECKED<% END IF %> class="no_Line"></td>
																	<td bgcolor="#FFFFFF" class="table_ListSubText1"><%=RS("strItemName")%></td>
																</tr>
																<tr>
																	<td colspan="3" class="table_ListSubLine1"></td>
																</tr>
						<%
							RS.MOVENEXT
							WEND
						%>
																<tr>
																	<td colspan="3" height="1"></td>
																</tr>
																<tr>
																	<td colspan="3" class="table_ListSubBLine1"></td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td width="50%" valign="top" style="padding-left:5;">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>회원 기타정보</strong></span></td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellpadding="0" cellspacing="0">
																<tr align="center" bgcolor="EB766F">
																	<td colspan="3" class="table_Round1"></td>
																</tr>
																<tr align="center" bgcolor="EB766F">
																	<td height="30" class="table_Txt1" nowrap>번호</td>
																	<td height="30" class="table_Txt1" nowrap>출력유무</td>
																	<td height="30" nowrap bgcolor="EB766F" class="table_Txt1">항목이름</td>
																</tr>
																<tr bgcolor="EB766F">
																	<td colspan="3" class="table_Round1"></td>
																</tr>
																<tr bgcolor="#FFFFFF" align="center">
																	<td class="table_ListSubText1">1</td>
																	<td class="table_ListSubText1"><input type="checkbox" name="bitUseGroup" value="1"<% IF bitUseGroup = True THEN %> CHECKED<% END IF %> class="no_Line"></td>
																	<td bgcolor="#FFFFFF" class="table_ListSubText1">그룹정보</td>
																</tr>
																<tr>
																	<td colspan="3" class="table_ListSubLine1"></td>
																</tr>
																<tr bgcolor="#FFFFFF" align="center">
																	<td class="table_ListSubText1">2</td>
																	<td class="table_ListSubText1"><input type="checkbox" name="bitUseVisit" value="1"<% IF bitUseVisit = True THEN %> CHECKED<% END IF %> class="no_Line"></td>
																	<td bgcolor="#FFFFFF" class="table_ListSubText1">방문회수</td>
																</tr>
																<tr>
																	<td colspan="3" class="table_ListSubLine1"></td>
																</tr>
																<tr bgcolor="#FFFFFF" align="center">
																	<td class="table_ListSubText1">3</td>
																	<td class="table_ListSubText1"><input type="checkbox" name="bitUsePoint" value="1"<% IF bitUsePoint = True THEN %> CHECKED<% END IF %> class="no_Line"></td>
																	<td bgcolor="#FFFFFF" class="table_ListSubText1">포인트</td>
																</tr>
																<tr>
																	<td colspan="3" class="table_ListSubLine1"></td>
																</tr>
																<tr bgcolor="#FFFFFF" align="center">
																	<td class="table_ListSubText1">4</td>
																	<td class="table_ListSubText1"><input type="checkbox" name="bitUseSignDate" value="1"<% IF bitUseSignDate = True THEN %> CHECKED<% END IF %> class="no_Line"></td>
																	<td bgcolor="#FFFFFF" class="table_ListSubText1">최근방문일</td>
																</tr>
																<tr>
																	<td colspan="3" class="table_ListSubLine1"></td>
																</tr>
																<tr bgcolor="#FFFFFF" align="center">
																	<td class="table_ListSubText1">5</td>
																	<td class="table_ListSubText1"><input type="checkbox" name="bitUseRegDate" value="1"<% IF bitUseRegDate = True THEN %> CHECKED<% END IF %> class="no_Line"></td>
																	<td bgcolor="#FFFFFF" class="table_ListSubText1">가입일자</td>
																</tr>
																<tr>
																	<td colspan="3" class="table_ListSubLine1"></td>
																</tr>
																<tr>
																	<td colspan="3" height="1"></td>
																</tr>
																<tr>
																	<td colspan="3" class="table_ListSubBLine1"></td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
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
											<LI>회원을 클릭시 출력되는 회원의 프로필에서 설정한 항목만 출력됩니다.</LI>
											<LI>게시판에 등록된 회원의 이름을 클릭시 회원프로필 열람이 가능하며, 프로필 열람권한은 회원그룹 권한설정에서 설정합니다.</LI>
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

	function OnPopSkinView(){
		for (i=0;i<document.all['strSkin'].length;i++){if (document.all['strSkin'][i].selected){nowItem = i;break;}}
		if (arrSkinPrevZoom[nowItem]!=""){
			parent.popupLayer('../SkinView.asp?strFileName=' + arrSkinPrevZoom[nowItem],800,632);
		}
	}

</script>
<!-- #include file = "Foot.asp" -->