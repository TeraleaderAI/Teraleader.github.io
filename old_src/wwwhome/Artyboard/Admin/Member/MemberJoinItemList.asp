<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Member/MemberJoinItemConfig.asp"
%>
<!-- #include file = "../Head.asp" -->
<style type="text/css">
	body {margin : 0 0 10 10}
</style>
<%
	DIM SET_strItem, SET_intDefault, SET_strItemName, SET_strItemMemo, SET_bitUse, SET_bitRequire, SET_intStep, SET_strFormType
	DIM SET_txtDefaultItem, SET_intMaxLength, SET_intReadOnly, SET_strDBFiledName, SET_intLength, SET_TypeSelect, SET_DisabledSelect

	DIM setStrItem
	setStrItem = REQUEST.QueryString("setStrItem")

	IF setStrItem <> "" THEN
		SET RS = DBCON.EXECUTE("SELECT [strItem], [intDefault], [strItemName], [strItemMemo], [bitUse], [bitRequire], [intStep], [strFormType], [txtDefaultItem], [intMaxLength], [intReadOnly], [strDBFiledName], [intLength] FROM [MPLUS_MEMBER_CONFIG_JOIN_ITEM] WHERE [strItem] = '" & setStrItem & "' ")
		SET_strItem        = RS("strItem")
		SET_intDefault     = RS("intDefault")
		SET_strItemName    = RS("strItemName")
		SET_strItemMemo    = RS("strItemMemo")
		SET_bitUse         = RS("bitUse")
		SET_bitRequire     = RS("bitRequire")
		SET_intStep        = RS("intStep")
		SET_strFormType    = RS("strFormType")
		SET_txtDefaultItem = RS("txtDefaultItem")
		SET_intMaxLength   = RS("intMaxLength")
		SET_intReadOnly    = RS("intReadOnly")
		SET_strDBFiledName = RS("strDBFiledName")
		SET_intLength      = RS("intLength")

		IF SET_intDefault = 0 THEN
			SET_DisabledSelect = False
			SET_TypeSelect     = 0
		ELSE
			IF SET_intDefault = 1 THEN
				SELECT CASE SET_strItem
				CASE "strJob", "strJobLevel", "strHobby", "strJoinMemo", "strMemberAdd1", "strMemberAdd2", "strMemberAdd3", "strMemberAdd4", "strMemberAdd5", "strMemberAdd6", "strMemberAdd7", "strMemberAdd8", "strMemberAdd9", "strMemberAdd10"
					SET_DisabledSelect = True
					SET_TypeSelect     = 1
				CASE "strUserSign"
					SET_DisabledSelect = False
					SET_TypeSelect     = 2
				CASE ELSE
					SET_DisabledSelect = False
					SET_TypeSelect     = 2
				END SELECT
			ELSE
				SET_TypeSelect     = 1
				SET_DisabledSelect = True
			END IF
		END IF
	END IF
%>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="MemberJoinItemConfig_ok.asp?setType=1" onSubmit="return OnSubmitAction();">
<input type="hidden" name="strItem" value="<%=SET_strItem%>">
	<tr>
		<td height="40" align="center">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="table_Left1">항목 필드</td>
					<td class="table_Right1"><input name="strItemName" type="text" id="strItemName" style="width:98%" value="<%=SET_strItemName%>" maxlength="20"></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">간단한 설명</td>
					<td class="table_Right1"><input name="strItemMemo" type="text" id="strItemMemo" style="width:98%" value="<%=SET_strItemMemo%>" maxlength="64"></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">사용유무</td>
					<td class="table_Right1"><input type="radio" name="bitUse" id="bitUse0" value="1" <% IF SET_bitUse = True THEN %>CHECKED<% END IF %><% IF SET_intDefault = 0 THEN %> DISABLED<% END IF %> class="no_Line"><LABEL FOR=bitUse0 style='cursor:hand;'>사용함</LABEL><input type="radio" name="bitUse" id="bitUse1" value="0" <% IF SET_bitUse = False THEN %>CHECKED<% END IF %><% IF SET_intDefault = 0 THEN %> DISABLED<% END IF %> class="no_Line">
<LABEL FOR=bitUse1 style='cursor:hand;'>사용안함</LABEL></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">필수입력</td>
					<td class="table_Right1"><input type="radio" name="bitRequire" id="bitRequire0" value="1" <% IF SET_bitRequire = True THEN %>CHECKED<% END IF %><% IF SET_intDefault = 0 THEN %> DISABLED<% END IF %> class="no_Line"><LABEL FOR=bitRequire0 style='cursor:hand;'>필수입력</LABEL>
<input type="radio" name="bitRequire" id="bitRequire1" value="0" <% IF SET_bitRequire = False THEN %>CHECKED<% END IF %><% IF SET_intDefault = 0 THEN %> DISABLED<% END IF %> class="no_Line"><LABEL FOR=bitRequire1 style='cursor:hand;'>선택입력</LABEL></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">필드형식</td>
					<td class="table_Right1"><select name="strFormType" id="strFormType" <% IF SET_DisabledSelect = False THEN %>DISABLED<% END IF %>>
<% IF SET_DisabledSelect = False THEN %>
					<option value="USERID"<% IF SET_strFormType = "USERID" THEN %> SELECTED<% END IF %>>아이디 입력형</option>
					<option value="RECID"<% IF SET_strFormType = "RECID" THEN %> SELECTED<% END IF %>>추천인 입력형</option>
					<option value="TEXT"<% IF SET_strFormType = "TEXT" THEN %> SELECTED<% END IF %>>한줄 입력형</option>
					<option value="PASSWORD"<% IF SET_strFormType = "PASSWORD" THEN %> SELECTED<% END IF %>>비밀번호형</option>
					<option value="SSN"<% IF SET_strFormType = "SSN" THEN %> SELECTED<% END IF %>>주민등록번호형</option>
					<option value="TEXTAREA"<% IF SET_strFormType = "TEXTAREA" THEN %> SELECTED<% END IF %>>여러줄 입력형</option>
					<option value="BIT"<% IF SET_strFormType = "BIT" THEN %> SELECTED<% END IF %>>BIT 타입형</option>
					<option value="RADIO"<% IF SET_strFormType = "RADIO" THEN %> SELECTED<% END IF %>>단일 선택형</option>
					<option value="CHECKBOX"<% IF SET_strFormType = "CHECKBOX" THEN %> SELECTED<% END IF %>>다중 선택형</option>
					<option value="SELECT"<% IF SET_strFormType = "SELECT" THEN %> SELECTED<% END IF %>>목록 선택형</option>
					<option value="BIRTHDAY"<% IF SET_strFormType = "BIRTHDAY" THEN %> SELECTED<% END IF %>>생년월일 입력형</option>
					<option value="MARRY"<% IF SET_strFormType = "MARRY" THEN %> SELECTED<% END IF %>>결혼기념일 입력형</option>
					<option value="DATE"<% IF SET_strFormType = "DATE" THEN %> SELECTED<% END IF %>>날짜 입력형</option>
					<option value="TEL"<% IF SET_strFormType = "TEL" THEN %> SELECTED<% END IF %>>전화번호 입력형</option>
					<option value="MOBILE"<% IF SET_strFormType = "MOBILE" THEN %> SELECTED<% END IF %>>핸드폰 입력형</option>
					<option value="ADDR"<% IF SET_strFormType = "ADDR" THEN %> SELECTED<% END IF %>>주소 입력형</option>
					<option value="EMAIL"<% IF SET_strFormType = "EMAIL" THEN %> SELECTED<% END IF %>>E-MAIL 입력형</option>
					<option value="FILE"<% IF SET_strFormType = "FILE" THEN %> SELECTED<% END IF %>>FILE 입력형</option>
					<option value="AVATA"<% IF SET_strFormType = "AVATA" THEN %> SELECTED<% END IF %>>FILE 입력형</option>
					<option value="SIGN"<% IF SET_strFormType = "SIGN" THEN %> SELECTED<% END IF %>>개인서명 입력형</option>
					<option value="NICK"<% IF SET_strFormType = "NICK" THEN %> SELECTED<% END IF %>>닉네임 입력형</option>
<%
	ELSE
		IF SET_TypeSelect = 1 THEN
%>
					<option value="TEXT"<% IF SET_strFormType = "TEXT" THEN %> SELECTED<% END IF %>>한줄 입력형</option>
					<option value="TEXTAREA"<% IF SET_strFormType = "TEXTAREA" THEN %> SELECTED<% END IF %>>여러줄 입력형</option>
					<option value="RADIO"<% IF SET_strFormType = "RADIO" THEN %> SELECTED<% END IF %>>단일 선택형</option>
					<option value="CHECKBOX"<% IF SET_strFormType = "CHECKBOX" THEN %> SELECTED<% END IF %>>다중 선택형</option>
					<option value="SELECT"<% IF SET_strFormType = "SELECT" THEN %> SELECTED<% END IF %>>목록 선택형</option>
<% ELSE %>
					<option value="TEXT"<% IF SET_strFormType = "TEXT" THEN %> SELECTED<% END IF %>>한줄 입력형</option>
					<option value="PASSWORD"<% IF SET_strFormType = "PASSWORD" THEN %> SELECTED<% END IF %>>비밀번호형</option>
					<option value="TEXTAREA"<% IF SET_strFormType = "TEXTAREA" THEN %> SELECTED<% END IF %>>여러줄 입력형</option>
					<option value="BIT"<% IF SET_strFormType = "BIT" THEN %> SELECTED<% END IF %>>BIT 타입형</option>
					<option value="RADIO"<% IF SET_strFormType = "RADIO" THEN %> SELECTED<% END IF %>>단일 선택형</option>
					<option value="CHECKBOX"<% IF SET_strFormType = "CHECKBOX" THEN %> SELECTED<% END IF %>>다중 선택형</option>
					<option value="SELECT"<% IF SET_strFormType = "SELECT" THEN %> SELECTED<% END IF %>>목록 선택형</option>
					<option value="BIRTHDAY"<% IF SET_strFormType = "BIRTHDAY" THEN %> SELECTED<% END IF %>>생년월일 입력형</option>
					<option value="DATE"<% IF SET_strFormType = "DATE" THEN %> SELECTED<% END IF %>>날짜 입력형</option>
					<option value="TEL"<% IF SET_strFormType = "TEL" THEN %> SELECTED<% END IF %>>전화번호 입력형</option>
					<option value="MOBILE"<% IF SET_strFormType = "MOBILE" THEN %> SELECTED<% END IF %>>핸드폰 입력형</option>
					<option value="EMAIL"<% IF SET_strFormType = "EMAIL" THEN %> SELECTED<% END IF %>>E-MAIL 입력형</option>
<%
		END IF
	END IF
%>
					</select></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">입력 길이</td>
					<td class="table_Right1">출력 길이&nbsp;
					  <input name="intLength" type="text" id="intLength" onBlur="onlynum(this, 1);" value="<%=SET_intLength%>" size="4" maxlength="3">&nbsp;/&nbsp;최대 입력&nbsp;<input name="intMaxLength" type="text" id="intMaxLength" onBlur="onlynum(this, 1);" value="<%=SET_intMaxLength%>" size="4" maxlength="3" <% IF SET_DisabledSelect = False THEN %>DISABLED<% END IF %>></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">항목필드</td>
					<td class="table_Right1"><textarea name="txtDefaultItem" rows="8" id="txtDefaultItem" style="width:98%"><%=SET_txtDefaultItem%></textarea><br><span><font color="#FD8402">한줄에 한개의 항목만 입력하세요.</font></span></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="40" align="right" style="padding-right:20;"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
	</tr>
</form>
</table>
<script language="javascript">
	function OnSubmitAction(){
		str = document.all['strItemName'];
		if (str.value == ""){alert("항목필드를 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['strFormType'];
		if (str.value == "RADIO" || str.value == "CHECKBOX" || str.value == "SELECT"){
			if (document.all['txtDefaultItem'].value == ""){
				alert("항목필드 입력값을 입력해 주시기 바랍니다.");
				document.all['txtDefaultItem'].focus();
				return false;
			}
		}

		document.all['bitUse'][0].disabled = false;
		document.all['bitUse'][1].disabled = false;
		document.all['bitRequire'][0].disabled = false;
		document.all['bitRequire'][1].disabled = false;
		document.all['strFormType'].disabled = false;
		document.all['intLength'].disabled = false;
		document.all['intMaxLength'].disabled = false;

	}
</script>
<!-- #include file = "../Foot.asp" -->