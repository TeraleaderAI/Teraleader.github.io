<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu  = 3
	intLeftMenu = 2
	isAdminMenu = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM strType, strCssLink, strCssContent, strContent

	strType = REQUEST.FORM("strType")
	IF strType = "" THEN strType = "A"
	
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_AGREE] '" & strType & "' ")

	strCssLink    = RS("strCssLink")
	strCssContent = RS("strCssContent")
	strContent    = GetReplaceTag2Editor(RS("strContent"))
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
							<form name="theForm" method="post" action="MemberAgree_ok.asp" onSubmit="return OnSubmitAction();">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title<% IF strType = "A" THEN %>6<% ELSE %>55<% END IF %>.gif"></td>
                      <td align="right">관리자 홈 &gt; 회원관리 &gt; <b><% IF strType = "A" THEN %>회원가입 약관설정<% ELSE %>개인정보보호정책 설정<% END IF %></b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>회원가입약관 / 개인정보보호정책 선택</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">항목선택</td>
											<td class="table_Right1">
											<input type="radio" name="strType" id="strType1" value="A"<% IF strType = "A" THEN %> CHECKED<% END IF %> class="no_Line" onClick="OnEditType();"><LABEL FOR="strType1" style="cursor:hand">회원가입 약관
											<input type="radio" name="strType" id="strType2" value="P"<% IF strType = "P" THEN %> CHECKED<% END IF %> class="no_Line" onClick="OnEditType();"><LABEL FOR="strType2" style="cursor:hand">개인정보보호정책</LABEL>
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
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>기본 스타일 정보</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">CSS 파일링크</td>
											<td class="table_Right1"><input name="strCssLink" type="text" id="strCssLink" value="<%=strCssLink%>" maxlength="64" style="width:100%"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">사용자 스타일</td>
											<td>
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><b>&lt;STYLE&gt;</b></td>
													</tr>
													<tr>
														<td class="table_Right1">
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td style="word-break:break-all;"><textarea name="strCssContent" rows="8" id="strCssContent" style="width:98%"><%=strCssContent%></textarea></td>
																	<td width="15" valign="top">
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strCssContent', -5);return false;"><img src="../Images/bt_size_minus.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="reset_textarea('strCssContent', 8);return false;"><img src="../Images/bt_size_ori2.gif" width="15" height="15" border="0"></a></td>
																			</tr>
																			<tr>
																				<td height="18"><a href="javascript:;" onClick="resize_textarea('strCssContent', 5);return false;"><img src="../Images/bt_size_plus.gif" width="15" height="15" border="0"></a></td>
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
									</table>								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>회원가입 약관정보</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">약관내용</td>
											<td class="table_Right1" style="padding-top:5px; padding-bottom:5px;">
											<textarea id="strContent" name="strContent" style="display:none"><%=strContent%></textarea>
											<script type="text/javascript" language="javascript">myeditor.run();</script>
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
											<LI><b>기본 스타일 정보</b> : 회원가입시 출력되는 약관 페이지의 스타일 정보를 설정합니다.</LI>
											<LI><b>회원가입 약관정보</b> : 회원가입시 출력되는 약관 페이지를 등록/수정 하실 수 있습니다.</LI>
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

		document.getElementById("strContent").value = myeditor.outputBodyHTML();

		if (document.getElementById("strContent").value == ""){
			alert("내용을 입력하여 주세요.");myeditor.editArea.focus();return false;
		}


	}

	function OnEditType(){
		document.theForm.action = "MemberAgree.asp";
		document.theForm.submit();
	}

</script>
<!-- #include file = "Foot.asp" -->