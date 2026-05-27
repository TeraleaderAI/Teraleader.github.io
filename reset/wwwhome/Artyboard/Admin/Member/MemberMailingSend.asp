<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu  = 4
	intLeftMenu = 11
	isAdminMenu = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM intNum, strName, strMail, strSubject, strContent, strContentBg
	
	intNum = REQUEST.QueryString("intNum")

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_MAIL] '', '" & intNum & "' ")
	
	strName      = RS("strName")
	strMail      = RS("strMail")
	strSubject   = RS("strSubject")
	strContent   = RS("strContent")
	strContentBg = GetReplaceTag2Editor(RS("strContentBg"))
%>
<script language="javascript">
	var SET_Editor_FilePath = "Pds/Member/Editor/";
</script>
<script type="text/javascript" language="javascript" src="../../Editor/cheditor.js"></script>
<script language="javascript">

	var myeditor = new cheditor("myeditor");

	myeditor.config.editorHeight = '400px';
	myeditor.config.editorWidth = '100%';
	myeditor.config.includeHostname = false;
	myeditor.config.editorBgcolor = "";
	myeditor.inputForm = 'strContent';

</script>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
						<form name="theForm" method="post" action="MemberMailingSend_ok.asp?intNum=<%=intNum%>" onSubmit="return OnSubmitAction();">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="35"><img src="../images/main_title15.gif" width="126" height="19"></td>
											<td align="right">관리자 홈 &gt; 회원관리 &gt; <b>전체 메일링 발송</b></td>
										</tr>
									</table>								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>메일링 발송정보</strong></span></td>
							</tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">보내는 사람</td>
											<td class="table_Right1"><input name="strName" type="text" id="strName" value="<%=strName%>" size="30" maxlength="30"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">보내는 사람 메일주소</td>
											<td class="table_Right1"><input name="strMail" type="text" id="strMail" value="<%=strMail%>" size="40" maxlength="64"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">받는 사람<br>기본그룹 / 메일링그룹</td>
											<td>
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="50%">
														<select name="strGroupList" size="10" multiple id="strGroupList" style="width:100%">
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_GROUP] ")
	WHILE NOT(RS.EOF)
		RESPONSE.WRITE "<option value=" & RS("strGroupCode") & ">" & RS("strGroupName") & " [회원수:" & RS("intMemberCount") & "]</option>" & vbcrlf
	RS.MOVENEXT
	WEND
%>
														</select>														</td>
														<td width="50%">
														<select name="strMailGroupList" size="10" multiple="multiple" id="strMailGroupList" style="width:100%">
<%
	SET RS = DBCON.EXECUTE("SELECT [strCode], [strName], [intCount] = (SELECT COUNT([intSeq]) FROM [MPLUS_MEMBER_MAILING_MEMBER] WHERE [strGroup] = [MPLUS_MEMBER_MAILING_GROUP].[strCode]) FROM [MPLUS_MEMBER_MAILING_GROUP] ")
	WHILE NOT(RS.EOF)
		RESPONSE.WRITE "<option value=" & RS("strCode") & ">" & RS("strName") & " [회원수:" & RS("intCount") & "]</option>" & vbcrlf
	RS.MOVENEXT
	WEND
%>
														</select>														</td>
													</tr>
													<tr>
														<td width="50%" height="28" align="right" style="padding-right:10">(Ctrl + 선택) <a href="javascript:;" onClick="OnSelectAllGroup('strGroupList');return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0" align="absmiddle"></a></td>
														<td width="50%" height="28" align="right" style="padding-right:10">(Ctrl + 선택) <a href="javascript:;" onClick="OnSelectAllGroup('strMailGroupList');return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0" align="absmiddle"></a></td>
													</tr>
												</table>											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">회원아이디</td>
											<td class="table_Right1" style="word-break:break-all;">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
													<td><textarea name="strMemberList" rows="3" id="strMemberList" style="width:98%"></textarea></td>
														<td width="15" valign="top">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strMemberList', -3);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="reset_textarea('strMemberList', 3);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strMemberList', 3);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																</tr>
															</table>														</td>
													</tr>
													<tr>
														<td height="30">
														<a href="javascript:popupLayer('MemberSearchList.asp',810,650);"><img src="../images/btn_member_search_w.gif" width="68" height="19" border="0" align="absmiddle"></a>
														<font color="#FD8402">회원 아이디는 , (콤마)를 구분지어 입력해 주시기 바랍니다.</font></td>
														<td valign="top">&nbsp;</td>
													</tr>
												</table>											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">기타 메일주소</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><textarea name="strEtcEmail" rows="3" id="strEtcEmail" style="width:98%"></textarea></td>
														<td width="15" valign="top">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strEtcEmail', -3);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="reset_textarea('strEtcEmail', 3);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strEtcEmail', 3);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
																</tr>
															</table>														</td>
													</tr>
													<tr>
														<td height="30"><font color="#FD8402">메일주소는 , (콤마)를 구분지어 입력해 주시기 바랍니다.</font></td>
														<td valign="top">&nbsp;</td>
													</tr>
												</table>											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">기타 메일주소 DB</td>
											<td class="table_Right1"><input name="bitMemberDB" type="checkbox" id="bitMemberDB" value="1" class="no_Line"><LABEL FOR="bitMemberDB" style="cursor:hand">등록된 메일 DB 수신자에게 메일 발송</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">메일링 제목</td>
											<td class="table_Right1"><input name="strSubject" type="text" id="strSubject" value="<%=strSubject%>" style="width:98%" maxlength="64"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">메일링 내용</td>
											<td class="table_Right1">
											<textarea id="strContent" name="strContent" style="display:none"><%=strContent%></textarea>
											<script type="text/javascript" language="javascript">myeditor.run();</script>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
									</table>								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td align="right" style="padding-right:20;"><input type="image" name="imageField" src="../images/btn_send_mailing_m.gif" class="no_Line"></td>
							</tr>
							<tr>
								<td style="padding:10 10 10 10">
								<fieldset CLASS="infobox">
								<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
												<LI>회원 그룹별, 메일링 그룹별로 일괄적으로 메일을 발송 할 수 있습니다.</LI>
												<LI>회원검색 버튼을 이용해서 원하는 회원을 검색해서 특정 회원에게만 메일 발송이 가능합니다.</LI>
												<LI>등록되지 않은 메일주소를 임의대로 등록하시면 등록된 메일주소로 발송이 가능합니다.</LI>
												<LI>회원이 아닌 메일 DB 수신자에게 메일발송이 가능하며, 메일 DB는 메일링 목록에서 등록 및 수정이 가능합니다.</LI>
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
		str = document.all['strName'];
		if (str.value == ""){alert("이름을 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['strMail'];
		if (!isEmailCheck(str.value)){
			alert("메일주소를 올바르게 입력해 주시기 바랍니다.");str.focus();return false;
		}

		str = document.all['strSubject'];
		if (str.value == ""){alert("메일제목을 입력해 주시기 바랍니다.");str.focus();return false;}

		document.getElementById("strContent").value = myeditor.outputBodyHTML();

		if (document.getElementById("strContent").value == ""){
			alert("내용을 입력하여 주세요.");myeditor.editArea.focus();return false;
		}

		var k = 0;
		for(i = 0; i < document.theForm.strGroupList.options.length; i++){
			if (document.theForm.strGroupList.options[i].selected == true){
				k++;
			}
		}

		if (k == 0){
			for(i = 0; i < document.theForm.strMailGroupList.options.length; i++){
				if (document.theForm.strMailGroupList.options[i].selected == true){
					k++;
				}
			}
		}

		if (k == 0){
			if (document.all['strMemberList'].value == "" && document.all['strEtcEmail'].value == "" && document.all['bitMemberDB'].checked == false){
				alert("메일링을 발송할 회원이나 주소가 없습니다.");
				return false;
			}
		}

		if (confirm("메일링을 발송하시겠습니까?")){
			return true;
		}
		return false;

	}

	function OnSelectAllGroup(str){

		var obj = document.all[str];

		for(i = 0; i < obj.options.length; i++){
			obj.options[i].selected = true;
		}
	}

</script>
<!-- #include file = "Foot.asp" -->