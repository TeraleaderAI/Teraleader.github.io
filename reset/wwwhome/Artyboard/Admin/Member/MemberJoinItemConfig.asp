<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu  = 3
	intLeftMenu = 4
	isAdminMenu = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" onsubmit="return OnSubmitAction();">
							<input type="hidden" name="vPidList">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title8.gif" width="134" height="19"></td>
                      <td align="right">관리자 홈 &gt; 회원관리 &gt; <b>회원가입 항목설정</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>회원가입 항목정보</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td style="padding-top:5;">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="250" valign="top">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td><select name="strMemberJoinItemList" size="24" id="strMemberJoinItemList" style="width:200" onChange="OnItemChange(this.value);">
<%
	DIM setStrItem, strItem, strItemName, intDefault
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_JOIN_ITEM] '0' ")

		WHILE NOT(RS.EOF)

			strItem     = RS("strItem")
			strItemName = RS("strItemName")
			intDefault  = RS("intDefault")

			SELECT CASE intDefault
			CASE 0 : strItemName = "[필수] " & strItemName
			CASE 1 : strItemName = "[선택] " & strItemName
			CASE 2 : strItemName = "[추가] " & strItemName
			END SELECT

			IF setStrItem = strItem THEN
				SELECTED = " SELECTED "
			ELSE
				IF setStrItem = "" THEN SELECTED = " SELECTED " ELSE SELECTED = ""
			END IF

			RESPONSE.WRITE "<option value=" & strItem & SELECTED & ">" & strItemName & "</option>" & vbcrlf

			IF setStrItem = "" THEN setStrItem = strItem

		RS.MOVENEXT
		WEND
%>
																	</select></td>
																	<td>
																		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td height="25" align="center"><img src="../Images/btn_top.gif" width="34" height="23" onClick="OnSwapFormList('t');" style="cursor:hand"></td>
																			</tr>
																			<tr>
																				<td height="25" align="center"><img src="../images/btn_plus.gif" width="34" height="23" onClick="OnSwapFormList('u');" style="cursor:hand"></td>
																			</tr>
																			<tr>
																				<td height="25" align="center"><img src="../images/btn_minus.gif" width="34" height="23" onClick="OnSwapFormList('d');" style="cursor:hand"></td>
																			</tr>
																			<tr>
																				<td height="25" align="center"><img src="../images/btn_buttom.gif" width="34" height="23" onClick="OnSwapFormList('b');" style="cursor:hand"></td>
																			</tr>
																		</table>																	</td>
																</tr>
															</table>														</td>
													</tr>
													<tr>
														<td height="40" align="right" style="padding-right:50"><input type="image" name="imageField2" src="../images/btn_step_m.gif" class="no_Line"></td>
													</tr>
												</table>											</td>
											<td valign="top"><iframe name="MemberJoinItemFrame" src="MemberJoinItemList.asp?setStrItem=<%=setStrItem%>" scrolling="no" frameborder="0" width="100%" height="388"></iframe></td>
										</tr>
									</table>								</td>
              </tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>회원가입시 입력받는 항목을 설정할 수 있으며, 각 항목은 필수입력과 선택입력으로 구분됩니다.</LI>
											<LI>추가항목은 최대 10개까지 사용이 가능하며, <font color="#FD8402"><b>아이디, 비밀번호, 이름, 메일주소</b></font>는 필수 항목입니다.</LI></td>
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
	function OnItemChange(str){
		parent.document.frames('MemberJoinItemFrame').location = "MemberJoinItemList.asp?setStrItem=" + str;
	}

	function OnSwapFormList(str){
		var objName = "strMemberJoinItemList";
		OnExeSwapList(objName, str);
	}

	function OnExeSwapList(id, dir){
		var theFrm  = document.all;
		eval('var vObj = theFrm.' + id + ';' );
		var nSel = vObj.selectedIndex;
		var nMax = vObj.options.length - 1;

		if (nSel < 0){alert('선택된 항목이 없습니다. 이동할 항목을 먼저 선택하세요.');return;}

		var nVal;
		var nText;

		switch(dir){
			case "d" :
				if (nSel + 1 > nMax) return;
					nVal  = vObj.options[nSel+1].value;
					nText = vObj.options[nSel+1].text;
					vObj.options[nSel+1].value = vObj.options[nSel].value;
					vObj.options[nSel+1].text  = vObj.options[nSel].text;
					vObj.options[nSel].value   = nVal;
					vObj.options[nSel].text    = nText;
					vObj.selectedIndex = nSel+1;
				break;
			case "u" :
				if (nSel == 0) return;
					nVal  = vObj.options[nSel-1].value;
					nText = vObj.options[nSel-1].text;
					vObj.options[nSel-1].value = vObj.options[nSel].value;
					vObj.options[nSel-1].text  = vObj.options[nSel].text;
					vObj.options[nSel].value   = nVal;
					vObj.options[nSel].text    = nText;
					vObj.selectedIndex = nSel-1;
				break;
			case "t" :
				if (nSel == 0) return;
					nVal = vObj.options[nSel].value;
					nText = vObj.options[nSel].text;
					for (i = nSel; i > 0; i--){
						vObj.options[i].value = vObj.options[i-1].value;
						vObj.options[i].text = vObj.options[i-1].text;
					}
					vObj.options[0].value = nVal;
					vObj.options[0].text = nText;
					vObj.selectedIndex = 0;
				break;
			case "b" :
				if (nSel + 1 > nMax) return;
					nVal = vObj.options[nSel].value;
					nText = vObj.options[nSel].text;
					for (i = nSel; i < nMax; i++){
						vObj.options[i].value = vObj.options[i+1].value;
						vObj.options[i].text = vObj.options[i+1].text;
					}
					vObj.options[nMax].value = nVal;
					vObj.options[nMax].text = nText;
					vObj.selectedIndex = nMax;
				break;
		}
	}

	function OnSubmitAction(){
		if(confirm("회원가입 항목 리스트 순서를 변경하시겠습니까?")){

			var str;
			str = "";

			for (var j = 0; j < document.all['strMemberJoinItemList'].length; j++){
				str += document.all['strMemberJoinItemList'].options[j].value;
				if ( j < document.all['strMemberJoinItemList'].length - 1 )
				str += "|";
			}

			document.all['vPidList'].value = str;

			document.theForm.action = "MemberJoinItemConfig_ok.asp?setType=0";
			document.theForm.submit();
		}
	}
</script>
<!-- #include file = "Foot.asp" -->