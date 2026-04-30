<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 3
	intLeftMenu  = 1
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title3.gif" width="107" height="19"></td>
                      <td align="right">관리자 홈 &gt; 그룹관리 &gt; <b>레벨 그룹관리</b></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>그룹 리스트</strong></span></td>
              </tr>
              <tr>
                <td>
									<table width="100%"  border="0" cellpadding="0" cellspacing="0">
										<tr align="center" bgcolor="EB766F">
											<td colspan="10" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td height="30" class="table_Txt1" nowrap>그룹코드</td>
											<td height="30" class="table_Txt1" nowrap>그룹명</td>
											<td height="30" class="table_Txt1" nowrap>그룹설명</td>
											<td height="30" class="table_Txt1" nowrap>레벨</td>
											<td height="30" class="table_Txt1" nowrap>그룹포인트</td>
											<td height="30" class="table_Txt1" nowrap>회원수</td>
											<td class="table_Txt1" nowrap>이미지</td>
											<td class="table_Txt1" nowrap>순서</td>
											<td width="60" height="30" align="center" class="table_Txt1" nowrap>수정</td>
											<td width="60" align="center" class="table_Txt1" nowrap>삭제</td>
										</tr>
										<tr bgcolor="EB766F">
											<td colspan="10" class="table_Round1"></td>
										</tr>
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_GROUP] ")
	DIM iCount
	iCount = 0

	WHILE NOT(RS.EOF)
		iCount = iCount + 1
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1"><%=RS("strGroupCode")%></td>
											<td class="table_ListSubText1"><%=RS("strGroupName")%></td>
											<td class="table_ListSubText1"><%=RS("strGroupMemo")%></td>
											<td class="table_ListSubText1">Lv. <%=RS("intLevel")%></td>
											<td class="table_ListSubText1"><%=GetMoneyComma(RS("intDefaultPoint"))%></td>
											<td class="table_ListSubText1"><%=RS("intMemberCount")%></td>
											<td class="table_ListSubText1"><% IF RS("strAvata") <> "" AND ISNULL(RS("strAvata")) = False THEN %><img src="../../Pds/Member/GroupIcon/<%=RS("strAvata")%>"><% ELSE %>-<% END IF %></td>
											<td class="table_ListSubText1"><a href="javascript:;" onClick="OnEditStep('d', '<%=RS("strGroupCode")%>', '<%=iCount%>');return false;"><img src="../images/btn_down.gif" width="16" height="10" border="0" align="absmiddle"></a>&nbsp;<a href="javascript:;" onClick="OnEditStep('u', '<%=RS("strGroupCode")%>', '<%=iCount%>');return false;"><img src="../images/btn_up.gif" width="16" height="10" border="0" align="absmiddle"></a></td>
											<td class="table_ListSubText1"><a href="GroupAdd.asp?Action=edit&strGroupCode=<%=RS("strGroupCode")%>"><img src="../images/btn_edit_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:;" onClick="OnGroupRemove('<%=RS("strGroupCode")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0"></a></td>
										</tr>
										<tr>
											<td colspan="10" class="table_ListSubLine1"></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
%>
										<tr>
											<td colspan="10" height="1"></td>
										</tr>
										<tr>
											<td colspan="10" class="table_ListSubBLine1"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><a href="GroupAdd.asp?Action=add"><img src="../images/btn_group_add_m.gif" width="86" height="25" border="0"></a></td>
              </tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>레벨별로 권한을 줄 수 있도록 그룹을 설정하실 수 있으며, <font color="#FD8402"><b>레벨이 높을 수록 높은 권한</b></font>을 가지게 됩니다.</LI>
											<LI>대기그룹은 최하위 그룹이며, 비회원, 미승인회원, 탈퇴회원과 동일한 권한의 그룹입니다.</LI>
											<LI>회원별로 권한을 설정하시려면 먼저 그룹을 하나 등록하셔서 회원가입시 기본 그룹으로 설정하시기 바랍니다.</LI>
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

	var SET_GROUP_COUNT = "<%=iCount%>";

	function OnGroupRemove(str){
		if (str == "G000"){
			alert("기본그룹은 삭제를 하실 수 없습니다.");
			return false;
		}else{
			if (confirm("그룹을 삭제하시면 복구가 불가능합니다.\n\n삭제할 그룹에 등록되어 있는 회원은 기본그룹으로 변경됩니다.\n\n선택한 그룹을 삭제하시겠습니까?")){
				document.theForm.action = "Group_ok.asp?Action=REMOVE&strGroupCode=" + str;
				document.theForm.submit();
			}
		}
	}

	function OnEditStep(str1, str2, str3){
		if (str2 == "G000"){
			alert("기본그룹은 이동이 불가능합니다.");
			return false;
		}else{
			switch (str1){
				case "d" :
						if (str3 == SET_GROUP_COUNT){
							alert("더이상 아래로 이동이 불가능합니다.");
							return false;
						}else{
							document.theForm.action = "Group_ok.asp?Action=STEP&strGroupCode=" + str2 + "&strStep=d";
							document.theForm.submit();
						}
					break;
				case "u" :
						if (str3 == 2){
							alert("더이상 위로 이동이 불가능합니다.");
							return false;
						}else{
							document.theForm.action = "Group_ok.asp?Action=STEP&strGroupCode=" + str2 + "&strStep=u";
							document.theForm.submit();
						}
					break;
			}
		}
	}
</script>
<!-- #include file = "Foot.asp" -->