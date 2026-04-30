<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 3
	intLeftMenu  = 3
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
                      <td height="35"><img src="../images/main_title18.gif" width="151" height="19"></td>
                      <td align="right">관리자 홈 &gt; 그룹관리 &gt; <b>메일링 회원그룹 관리</b></td>
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
											<td colspan="7" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td height="30" class="table_Txt1" nowrap>그룹코드</td>
											<td height="30" class="table_Txt1" nowrap>그룹명</td>
											<td height="30" class="table_Txt1" nowrap>그룹설명</td>
											<td height="30" class="table_Txt1" nowrap>등록회원</td>
											<td class="table_Txt1" nowrap>회원설정</td>
											<td height="30" nowrap class="table_Txt1">수정</td>
											<td width="60" align="center" class="table_Txt1" nowrap>삭제</td>
										</tr>
										<tr bgcolor="EB766F">
											<td colspan="7" class="table_Round1"></td>
										</tr>
<%
	SET RS = DBCON.EXECUTE("SELECT [strCode], [strName], [strMemo], [intMemberCount] = (SELECT COUNT([intSeq]) FROM [MPLUS_MEMBER_MAILING_MEMBER] WHERE [strGroup] = [MPLUS_MEMBER_MAILING_GROUP].[strCode]) FROM [MPLUS_MEMBER_MAILING_GROUP] ")
	DIM iCount
	iCount = 0

	IF RS.EOF THEN
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td colspan="7" class="table_ListSubText1">등록된 그룹이 없습니다. </td>
											</tr>
										<tr>
											<td colspan="7" class="table_ListSubLine1"></td>
										</tr>
<%
	ELSE
		WHILE NOT(RS.EOF)
		iCount = iCount + 1
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1"><%=RS("strCode")%></td>
											<td class="table_ListSubText1"><%=RS("strName")%></td>
											<td class="table_ListSubText1"><%=RS("strMemo")%></td>
											<td class="table_ListSubText1"><%=RS("intMemberCount")%></td>
											<td class="table_ListSubText1"><a href="javascript:popupLayer('MailingGroupMember.asp?strCode=<%=RS("strCode")%>',940,591)"><img src="../images/btn_setup_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:popupLayer('MailingGroupAdd.asp?Action=edit&strCode=<%=RS("strCode")%>',540,220)"><img src="../images/btn_edit_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:;" onClick="OnRemove('<%=RS("strCode")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0"></a></td>
										</tr>
										<tr>
											<td colspan="7" class="table_ListSubLine1"></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
										<tr>
											<td colspan="7" height="1"></td>
										</tr>
										<tr>
											<td colspan="7" class="table_ListSubBLine1"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><a href="javascript:popupLayer('MailingGroupAdd.asp?Action=add',540,220)"><img src="../images/btn_group_add_m.gif" width="86" height="25" border="0"></a></td>
              </tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>메일링 발송시 회원별로 그룹을 생성하셔서 해당 그룹에 회원을 등록해서 사용하실 수 있습니다.</LI>
											<LI>그룹의 생성개수는 제한이 없으며, 각 그룹별 회원은 중복 등록이 가능합니다.</LI>
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

	function OnRemove(str){
		if (confirm("선택한 그룹을 삭제하시겠습니까?")){
			document.theForm.action = "MailingGroup_ok.asp?Action=REMOVE&strCode=" + str;
			document.theForm.submit();
		}
	}

</script>
<!-- #include file = "Foot.asp" -->