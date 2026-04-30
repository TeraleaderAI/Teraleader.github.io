<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 4
	intLeftMenu  = 10
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM intNum, strMailType, bitSend, strName, strMail, strSubject, strContent, strContentBg, dateRegDate
	
	strMailType = REQUEST.QueryString("strMailType")
	IF strMailType = "" THEN strMailType = "0"

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_MAIL] '" & strMailType & "' ")

	intNum     = RS("intNum")
	bitSend    = RS("bitSend")
	strName    = RS("strName")
	strMail    = RS("strMail")
	strSubject = RS("strSubject")
	strContent = GetReplaceTag2Editor(RS("strContent"))
	strContentBg = RS("strContentBg")
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
							<form name="theForm" method="post" action="MemberSendMail_ok.asp?strMailType=<%=strMailType%>" onSubmit="return OnSubmitAction();">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title14.gif" width="134" height="19"></td>
                      <td align="right">관리자 홈 &gt; 회원관리 &gt; <b>자동발송 메일설정</b></td>
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
											<td class="table_Left1">메일 구분</td>
											<td class="table_Right1">
											<select name="strMailType" id="strMailType" onChange="OnMemberSendMail(this.value);">
											<option value="0"<% IF strMailType = "0" THEN %> SELECTED<% END IF %>>회원가입 발송메일</option>
											<option value="1"<% IF strMailType = "1" THEN %> SELECTED<% END IF %>>아이디 분실 발송메일</option>
											</select>											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">메일 발송 </td>
											<td><input type="radio" name="bitSend" id="bitSend1" value="1"<% IF bitSend = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitSend1" style="cursor:hand">메일발송</LABEL>&nbsp;<input type="radio" name="bitSend" id="bitSend2" value="0"<% IF bitSend = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitSend2" style="cursor:hand">메일발송 안함</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">보내는 사람</td>
											<td class="table_Right1"><input name="strName" type="text" id="strName" value="<%=strName%>" size="30" maxlength="30"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">보내는 사람 이메일 </td>
											<td class="table_Right1"><input name="strMail" type="text" id="strMail" value="<%=strMail%>" size="40" maxlength="64"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">메일 제목 </td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><input name="strSubject" type="text" id="strSubject" value="<%=strSubject%>" size="60" maxlength="64">														</td>
														<td align="right">
														<select name="setMemberDim" onChange="OnSetMemberInfo(this.value);">
														<option>출력변수 선택</option>
														<option value="{{strLoginID}}">회원아이디</option>
														<option value="{{strLoginName}}">회원이름</option>
														<option value="{{strLoginPwd}}">비밀번호</option>
														</select>														</td>
													</tr>
												</table>											</td>
										</tr>
										<tr>
											<td class="table_Left1">메일 내용</td>
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
								<td align="right" style="padding-right:20;"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
							</tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>회원가입 및 아이디 및 비밀번호 분실시 발송되는 메일을 편집하셔서 사용하실 수 있습니다.</LI>
											<LI>메일 본문에 사용할 수 있는 변수는 {{strLoginID}}, {{strLoginName}}, {{strLoginPwd}}입니다.
											<LI>변수는 회원아이디, 회원이름, 회원비밀번호의 값을 출력합니다.
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

	function OnSetMemberInfo(str){
		myeditor.appendContents(str);
	}

	function OnMemberSendMail(str){
		document.location.href = "MemberSendMail.asp?strMailType=" + str;
	}

	function OnSubmitAction(){

		document.getElementById("strContent").value = myeditor.outputBodyHTML();

		if (document.getElementById("strContent").value == ""){
			alert("내용을 입력하여 주세요.");myeditor.editArea.focus();return false;
		}

	}
</script>
<!-- #include file = "Foot.asp" -->