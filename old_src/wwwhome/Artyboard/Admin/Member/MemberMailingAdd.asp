<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu  = 4
	intLeftMenu = 11
	isAdminMenu = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM Action, intNum, strName, strMail, strSubject, strContent, strContentBg
	
	Action = UCASE(REQUEST.QueryString("Action"))

	IF Action = "EDIT" THEN

		intNum = REQUEST.QueryString("intNum")
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_MAIL] '', '" & intNum & "' ")
	
		strName      = RS("strName")
		strMail      = RS("strMail")
		strSubject   = RS("strSubject")
		strContent   = GetReplaceTag2Editor(RS("strContent"))
		strContentBg = RS("strContentBg")

	ELSE

		SET RS = DBCON.EXECUTE("SELECT [strLoginName], [strEmail] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & SESSION("strLoginID") & "' AND [strAdmin] = '2' ")

		strName      = RS("strLoginName")
		strMail      = RS("strEmail")

	END IF
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
							<form name="theForm" method="post" action="MemberMailing_ok.asp?Action=<%=Action%>&intNum=<%=intNum%>" onSubmit="return OnSubmitAction();">
							<textarea id="strContent" name="strContent" style="display:none"><%=strContent%></textarea>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title15.gif" width="126" height="19"></td>
                      <td align="right">관리자 홈 &gt; 회원관리 &gt; <b><% IF Action = "ADD" THEN %>신규 메일링 등록<% ELSE %>메일링 정보수정<% END IF %></b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong><% IF Action = "ADD" THEN %>신규 메일링 등록<% ELSE %>메일링 정보수정<% END IF %></strong></span></td>
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
											<td class="table_Left1">메일링 제목</td>
											<td class="table_Right1"><input name="strSubject" type="text" id="strSubject" value="<%=strSubject%>" maxlength="64" style="width:98%"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">메일내용</td>
											<td style="padding-top:5px; padding-bottom:5px;"><script type="text/javascript" language="javascript">myeditor.run();</script></td>
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
											<LI><b>기본 스타일 정보</b> : 회원가입시 출력되는 약관 페이지의 스타일 정보를 설정합니다.</LI>
											<LI><b>회원가입 약관정보</b> : 회원가입시 출력되는 약관 페이지를 등록/수정 하실 수 있습니다.</LI>											</td>
										</tr>
									</table>
									</fieldset>								</td>
							</tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							</form>
            </table>
<script language="javascript">
	function OnSubmitAction(){
		str = document.all['strName'];
		if (str.value == ""){alert("보내는 사람의 이름을 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['strMail'];

		if (str.value == ""){alert("보내는 사람의 메일주소를 입력해 주시기 바랍니다.");str.focus();return false;}

		if (!isEmailCheck(str.value)){
			alert("보내는 사람의 메일주소를 올바르게 입력해 주시기 바랍니다.");str.focus();return false;
		}

		str = document.all['strSubject'];
		if (str.value == ""){alert("메일제목을 입력해 주시기 바랍니다.");str.focus();return false;}

		document.getElementById("strContent").value = myeditor.outputBodyHTML();

		if (document.getElementById("strContent").value == ""){
			alert("내용을 입력하여 주세요.");myeditor.editArea.focus();return false;
		}

	}
</script>
<!-- #include file = "Foot.asp" -->