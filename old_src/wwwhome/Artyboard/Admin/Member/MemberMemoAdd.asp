<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 4
	intLeftMenu  = 14
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
						<table width="750" border="0" cellspacing="0" cellpadding="0">
						<form name="theForm" method="post" action="MemberMemo_ok.asp?Action=send" onSubmit="return OnSubmitAction();">
							<input type="hidden" name="strLoginID" value="<%=SESSION("strLoginID")%>">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="35"><img src="../images/main_title58.gif" width="113" height="19"></td>
											<td align="right">관리자 홈 &gt; 회원관리 &gt; <b>일괄 쪽지 발송</b></td>
										</tr>
									</table>								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>쪽지 발송정보</strong></span></td>
							</tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
							<tr>
								<td height="5"></td>
							</tr>
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">받는 사람<br>기본그룹 / 메일링그룹</td>
											<td>
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="50%">
														<select name="strGroup" size="10" multiple id="strGroup" style="width:100%">
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_GROUP] ")
	WHILE NOT(RS.EOF)
		RESPONSE.WRITE "<option value=" & RS("strGroupCode") & ">" & RS("strGroupName") & " [회원수:" & RS("intMemberCount") & "]</option>" & vbcrlf
	RS.MOVENEXT
	WEND
%>
														</select>														</td>
														<td width="50%">
														<select name="strMailingGroup" size="10" multiple="multiple" id="strMailingGroup" style="width:100%">
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
														<td width="50%" height="28" align="right" style="padding-right:10">(Ctrl + 선택) <a href="javascript:;" onClick="OnSelectAllGroup('strGroup');return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0" align="absmiddle"></a></td>
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
											<td class="table_Left1">쪽지 내용</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
													<td><textarea name="strContent" rows="15" id="strContent" style="width:98%"></textarea></td>
														<td width="15" valign="top">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strContent', -3);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="reset_textarea('strContent', 15);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																</tr>
																<tr>
																	<td height="18"><a href="javascript:;" onClick="resize_textarea('strContent', 3);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
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
								<td align="right" style="padding-right:20;"><input type="image" name="imageField" src="../images/btn_send_memo2_m.gif" class="no_Line"></td>
							</tr>
							<tr>
								<td style="padding:10 10 10 10">
								<fieldset CLASS="infobox">
								<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
												<LI>회원을 그룹별, 메일링 그룹별로 일괄적으로 쪽지를 발송 할 수 있습니다.</LI>
												<LI>회원검색 버튼을 이용해서 원하는 회원을 검색해서 특정 회원에게만 쪽지 발송이 가능합니다.</LI>
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

		var k = 0;
		for(i = 0; i < document.theForm.strGroup.options.length; i++){
			if (document.theForm.strGroup.options[i].selected == true){
				k++;
			}
		}

		if (k == 0){
			for(i = 0; i < document.theForm.strMailingGroup.options.length; i++){
				if (document.theForm.strMailingGroup.options[i].selected == true){
					k++;
				}
			}
		}

		if (k == 0){
			if (document.all['strMemberList'].value == ""){
				alert("쪽지를 발송할 회원이나 주소가 없습니다.");
				return false;
			}
		}

		str = document.theForm.strContent;
		if (str.value == ""){
			alert("쪽지내용을 입력해 주시기 바랍니다.");str.focus();return false;
		}

		if (confirm("일괄쪽지를 발송하시겠습니까?")){
			return true;
		}
		return false;
	}

	function OnSelectAllGroup(str){

		var obj = document.all[str];
		if (!obj==null){
			for(i = 0; i < obj.options.length; i++){
				obj.options[i].selected = true;
			}
		}
	}

</script>
<!-- #include file = "Foot.asp" -->