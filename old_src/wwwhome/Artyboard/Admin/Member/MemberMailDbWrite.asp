<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu  = 2
	isAdminPopup = True
	strAdminPrevUrl = "Member/MemberMailingList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM Action, intPage
	DIM intNum, strName, strCompany, strPosition, strClass, strTel, strFax, strMobile, strEmail, strPost, strAddr1, strAddr2
	DIM bitEmail, dateRegDate

	intNum  = REQUEST.QueryString("intNum")
	Action  = UCASE(REQUEST.QueryString("Action"))
	intPage = REQUEST.QueryString("intPage")
	IF Action = "ADD" THEN
		strTel    = "--"
		strFax    = "--"
		strMobile = "--"
		strPost   = "-"
		bitEmail  = True
	ELSE

		SET RS = DBCON.EXECUTE("SELECT [strName], [strCompany], [strPosition], [strClass], [strTel], [strFax], [strMobile], [strEmail], [strPost], [strAddr1], [strAddr2], [bitEmail] FROM [MPLUS_MAIL_MEMBER] WHERE [intNum] = '" & intNum & "' ")
		
		strName     = RS("strName")
		strCompany  = RS("strCompany")
		strPosition = RS("strPosition")
		strClass    = RS("strClass")
		strTel      = RS("strTel")       : IF strTel    = "" OR ISNULL(strTel)    = True THEN strTel    = "--"
		strFax      = RS("strFax")       : IF strFax    = "" OR ISNULL(strFax)    = True THEN strFax    = "--"
		strMobile   = RS("strMobile")    : IF strMobile = "" OR ISNULL(strMobile) = True THEN strMobile = "--"
		strEmail    = RS("strEmail")
		strPost     = RS("strPost")      : IF strPost   = "" OR ISNULL(strPost)   = True THEN strPost   = "-"
		strAddr1    = RS("strAddr1")
		strAddr2    = RS("strAddr2")
		bitEmail    = RS("bitEmail")

	END IF

	strTel    = SPLIT(strTel, "-")
	strFax    = SPLIT(strFax, "-")
	strMobile = SPLIT(strMobile, "-")
	strPost   = SPLIT(strPost, "-")
%>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<form name="theForm" method="post" action="MemberMailDb_ok.asp?Action=<%=Action%>&intPage=<%=intPage%>" onSubmit="return OnSubmitAction();">
<input type="hidden" name="intNum" value="<%=intNum%>">
	<tr>
		<td height="44" background="../images/pop_title_bg.gif"><img src="../images/MailDbList_title.gif" width="155" height="44"></td>
	</tr>
	<tr>
		<td height="10"></td>
	</tr>
	<tr>
		<td valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td class="table_Left1">이름</td>
								<td class="table_Right1"><input name="strName" type="text" class="input" id="strName" value="<%=strName%>" size="20" maxlength="20"></td>
								<td class="table_Left1">소속</td>
								<td class="table_Right1"><input name="strCompany" type="text" class="input" id="strCompany" value="<%=strCompany%>" size="32" maxlength="32"></td>
							</tr>
							<tr>
								<td colspan="4" height="1" bgcolor="#EFEFEF"></td>
							</tr>
							<tr>
								<td class="table_Left1">부서</td>
								<td class="table_Right1"><input name="strPosition" type="text" class="input" id="strPosition" value="<%=strPosition%>" size="32" maxlength="32"></td>
								<td class="table_Left1">직급</td>
								<td class="table_Right1"><input name="strClass" type="text" class="input" id="strClass" value="<%=strClass%>" size="32" maxlength="32"></td>
							</tr>
							<tr>
								<td colspan="4" height="1" bgcolor="#EFEFEF"></td>
							</tr>
							<tr>
								<td class="table_Left1">전화번호</td>
								<td class="table_Right1"><select name="strTel" id="strTel"><%=GetPhoneMobileSelect("tel", strTel(0))%></select> 
								- 
								<input name="strTel" type="text" class="input" id="strTel" onBlur="onlynum(this, '1');" value="<%=strTel(1)%>" size="6" maxlength="4"> 
								- 
								<input name="strTel" type="text" class="input" id="strTel" onBlur="onlynum(this, '1');" value="<%=strTel(2)%>" size="6" maxlength="4"></td>
								<td class="table_Left1">FAX 번호 </td>
								<td class="table_Right1"><select name="strFax" id="strFax">
								<%=GetPhoneMobileSelect("tel", strFax(0))%>
								</select>
								-
								<input name="strFax" type="text" class="input" id="strFax" onBlur="onlynum(this, '1');" value="<%=strFax(1)%>" size="6" maxlength="4">
								-
								<input name="strFax" type="text" class="input" id="strFax" onBlur="onlynum(this, '1');" value="<%=strFax(2)%>" size="6" maxlength="4"></td>
							</tr>
							<tr>
								<td colspan="4" height="1" bgcolor="#EFEFEF"></td>
							</tr>
							<tr>
								<td class="table_Left1">휴대폰</td>
								<td class="table_Right1"><select name="strMobile" id="strMobile">
								<%=GetPhoneMobileSelect("mobile", strMobile(0))%>
								</select>
								-
								<input name="strMobile" type="text" class="input" id="strMobile" onBlur="onlynum(this, '1');" value="<%=strMobile(1)%>" size="6" maxlength="4">
								-
								<input name="strMobile" type="text" class="input" id="strMobile" onBlur="onlynum(this, '1');" value="<%=strMobile(2)%>" size="6" maxlength="4"></td>
								<td class="table_Left1">E-MAIL</td>
								<td class="table_Right1"><input name="strEmail" type="text" class="input" id="strEmail" value="<%=strEmail%>" size="40" maxlength="64"></td>
							</tr>
							<tr>
								<td colspan="4" height="1" bgcolor="#EFEFEF"></td>
							</tr>
							<tr>
								<td class="table_Left1">우편번호</td>
								<td colspan="3" class="table_Right1"><input name="strPost" type="text" class="input" id="strHomeAddr" value="<%=strPost(0)%>" size="5" maxlength="3" readonly> 
								-				    
								<input name="strPost" type="text" class="input" id="strHomeAddr" value="<%=strPost(1)%>" size="5" maxlength="3" readonly>					    <a href="javascript:;" onClick="OnFindPost('strHomeAddr');return false;"><img src="../images/btn_find_post_w.gif" width="90" height="19" border="0" align="absmiddle"></a></td>
							</tr>
							<tr>
								<td colspan="4" height="1" bgcolor="#EFEFEF"></td>
							</tr>
							<tr>
								<td class="table_Left1">주소지</td>
								<td colspan="3">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="26"><input name="strAddr1" type="text" class="input" id="strHomeAddr" value="<%=strAddr1%>" size="50" maxlength="64" readonly></td>
										</tr>
										<tr>
											<td height="26"><input name="strAddr2" type="text" class="input" id="strHomeAddr" value="<%=strAddr2%>" size="50" maxlength="64"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="4" height="1" bgcolor="#EFEFEF"></td>
							</tr>
							<tr>
								<td class="table_Left1">메일수신</td>
								<td colspan="3" class="table_Right1"><input type="radio" name="bitEmail" id="bitEmail1" value="1"<% IF bitEmail = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitEmail1" style="cursor:hand">메일수신</LABEL><input type="radio" name="bitEmail" id="bitEmail2" value="0"<% IF bitEmail = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitEmail2" style="cursor:hand">수신거부</LABEL></td>
							</tr>
							<tr>
								<td colspan="4" height="1" bgcolor="#EFEFEF"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="40" align="center"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
<script language="javascript">
	function OnFindPost(str){
		openWindows("../../Library/findPost.asp?strForm=" + str, 'findPost', 500, 500, 0);
	}

	function OnSubmitAction(){
		str = document.all['strName'];
		if (str.value == ""){alert("이름을 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['strEmail'];
		if (!isEmailCheck(str.value)){
			alert("올바른 이메일 주소를 입력해 주시기 바랍니다.");str.focus();return false;
		}
	}
</script>
<!-- #include file = "../Foot.asp" -->