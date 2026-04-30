<%
	DIM intTopMenu, intLeftMenu, isAdminMenu
	intTopMenu  = 1
	intLeftMenu = 2
	isAdminMenu = 2
%>
<!-- #include file = "Head.asp" -->
<%
	DIM strLoginName, strLoginPwd, strEmail, strNick, strUserSign, strPhotoFile, strNameFile, strHomepage
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & SESSION("strLoginID") & "', '2' ")

	strLoginName = RS("strLoginName")
	strLoginPwd  = RS("strLoginPwd")
	strEmail     = RS("strEmail")
	strNick      = RS("strNick")
	strUserSign  = RS("strUserSign")
	strPhotoFile = RS("strPhotoFile")
	strNameFile  = RS("strNameFile")
	strHomepage  = RS("strHomepage")
%>
<script language="javascript">
	var SET_Editor_FilePath = "Pds/Member/Sign/";
</script>
<script type="text/javascript" language="javascript" src="../../Editor/cheditor.js"></script>
<script language="javascript">

	var myeditor = new cheditor("myeditor");

	myeditor.config.editorWidth = '100%';
	myeditor.config.editorHeight = '100px';
	myeditor.config.includeHostname = false;
	myeditor.config.editorBgcolor = "";
	myeditor.inputForm = 'strUserSign';

</script>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" action="AdminEdit_ok.asp?Action=edit" onSubmit="return OnSubmitAction();" enctype="multipart/form-data">
							<input type="hidden" name="strLoginID" value="<%=SESSION("strLoginID")%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title2.gif" width="121" height="19"></td>
                      <td align="right">관리자 홈 &gt; 기본환경설정 &gt; <b>관리자 정보수정</b></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>전체 관리자 기본정보</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1" height="33">아이디</td>
											<td class="table_Right1"><span style="font-weight: bold"><%=SESSION("strLoginID")%></span>&nbsp;<span style="color: #2267a2; font-weight: bold">관리자 아이디는 변경이 불가능 합니다.</span></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">이름</td>
											<td class="table_Right1"><input name="strLoginName" type="text" class="input" id="strLoginName" value="<%=strLoginName%>" maxlength="20">&nbsp;<font color="#E86A34">전체 관리자 이름</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">비밀번호</td>
											<td class="table_Right1"><input name="strLoginPwd" type="password" class="input" id="strLoginPwd" value="<%=strLoginPwd%>" maxlength="20">&nbsp;<font color="#E86A34">관리자 비밀번호</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">비밀번호 확인 </td>
											<td class="table_Right1"><input name="strLoginPwdRe" type="password" class="input" id="strLoginPwdRe" value="<%=strLoginPwd%>" maxlength="20"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">이메일</td>
											<td class="table_Right1"><input name="strEmail" type="text" class="input" id="strEmail" value="<%=strEmail%>" size="40" maxlength="64">&nbsp;<font color="#E86A34">관리자 이메일 주소</font></td>
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
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>전체 관리자 기타정보</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">홈페이지</td>
											<td class="table_Right1"><input name="strHomepage" type="text" class="input" id="strHomepage" value="<%=strHomepage%>" size="40" maxlength="64">&nbsp;<font color="#E86A34">관리자 홈페이지 주소</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">닉네임 (별명)</td>
											<td class="table_Right1"><input name="strNick" type="text" class="input" id="strNick" value="<%=strNick%>" size="20" maxlength="20">
												&nbsp;<font color="#E86A34">관리자 닉네임</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">관리자 서명</td>
											<td class="table_Right1" style="padding-top:5px; padding-bottom:5px;"><textarea name="strUserSign" cols="70" style="display:none"><%=strUserSign%></textarea><script type="text/javascript" language="javascript">myeditor.run();</script></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">사진 이미지 </td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellpadding="0" cellspacing="0">
													<tr>
														<td height="24"><input name="strPhotoFile" type="file" class="input" id="strPhotoFile" size="40">
														<% IF strPhotoFile <> "" AND ISNULL(strPhotoFile) = False THEN %><a href="javascript:;" onClick="OnDisplayView('trPhotoFile');return false;"><img src="../images/btn_image_view_w.gif" width="81" height="19" border="0" align="absmiddle"></a>&nbsp;<a href="javascript:;" onClick="OnRemoveFile('1');return false;"><img src="../images/btn_image_delete_w.gif" width="81" height="19" border="0" align="absmiddle"></a><% END IF %></td>
													</tr>
													<tr id="trPhotoFile" style="display:none">
														<td style="padding: 5 0 5 0"><img src="../../Pds/Member/Photo/<%=strPhotoFile%>"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">이름 이미지 </td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="24"><input name="strNameFile" type="file" class="input" id="strNameFile" size="40">
														<% IF strNameFile <> "" AND ISNULL(strNameFile) = False THEN %><a href="javascript:;" onClick="OnDisplayView('trNameFile');return false;"><img src="../images/btn_image_view_w.gif" width="81" height="19" border="0" align="absmiddle"></a>&nbsp;<a href="javascript:;" onClick="OnRemoveFile('2');return false;"><img src="../images/btn_image_delete_w.gif" width="81" height="19" align="absmiddle" border="0"></a><% END IF %></td>
													</tr>
													<tr id="trNameFile" style="display:none">
														<td style="padding: 5 0 5 0"><img src="../../Pds/Member/Name/<%=strNameFile%>"></td>
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
											<LI>전체 관리자 정보를 변경하실 수 있으며, <font color="#FD8402"><b>전체 관리자의 아이디는 변경이 불가능합니다.</b></font></LI>
											<LI>이름 이미지의 권장 <font color="#FD8402"><b>사이즈는 가로 70px, 세로 20px</b></font> 입니다.</LI>
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

			str = document.all['strLoginName'];
			if (str.value == ""){alert("관리자 이름을 입력해 주시기 바랍니다.");str.focus();return false;}

			str = document.all['strLoginPwd'];
			if (str.value == ""){alert("비밀번호를 입력해 주시기 바랍니다.");str.focus();return false;}
			if (str.value != document.all['strLoginPwdRe'].value){alert("비밀번호가 일치하지 않습니다.");document.all['strLoginPwdRe'].focus();return false;}

			str = document.all['strEmail'];
			if (!isEmailCheck(str.value)){alert("이메일 주소를 올바르게 입력해 주시기 바랍니다.");str.focus();return false;}

			document.getElementById("strUserSign").value = myeditor.outputBodyHTML();

	}

	function OnRemoveFile(str){
		if (confirm("선택된 이미지를 삭제하시겠습니까?")){
			document.theForm.action = "AdminEdit_ok.asp?Action=remove&intFile=" + str;
			document.theForm.submit();
		}
	}

</script>
<!-- #include file = "Foot.asp" -->