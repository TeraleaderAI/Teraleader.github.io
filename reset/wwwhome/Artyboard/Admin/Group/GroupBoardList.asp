<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 3
	intLeftMenu  = 2
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
                      <td height="35"><img src="../images/main_title4.gif" width="151" height="19"></td>
                      <td align="right">관리자 홈 &gt; 그룹관리 &gt; <b>게시판 접근 그룹관리</b></td>
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
											<td colspan="9" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td height="30" class="table_Txt1" nowrap>그룹코드</td>
											<td height="30" class="table_Txt1" nowrap>그룹명</td>
											<td height="30" class="table_Txt1" nowrap>그룹설명</td>
											<td height="30" class="table_Txt1" nowrap>등록게시판</td>
											<td height="30" class="table_Txt1" nowrap>등록회원</td>
											<td height="30" class="table_Txt1" nowrap>게시판설정</td>
											<td class="table_Txt1" nowrap>회원설정</td>
											<td height="30" nowrap class="table_Txt1">수정</td>
											<td width="60" align="center" class="table_Txt1" nowrap>삭제</td>
										</tr>
										<tr bgcolor="EB766F">
											<td colspan="9" class="table_Round1"></td>
										</tr>
<%
	SET RS = DBCON.EXECUTE("SELECT [strGroupCode], [strGroupName], [strGroupMemo], [intBoardCount] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_GROUP_BOARD] WHERE [strGroupCode] = [MPLUS_BOARD_GROUP].[strGroupCode]), [intMemberCount] = (SELECT COUNT([intNum]) FROM [MPLUS_BOARD_GROUP_MEMBER] WHERE [strGroupCode] = [MPLUS_BOARD_GROUP].[strGroupCode]) FROM [MPLUS_BOARD_GROUP] ")
	DIM iCount
	iCount = 0

	IF RS.EOF THEN
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td colspan="9" class="table_ListSubText1">등록된 그룹이 없습니다. </td>
											</tr>
										<tr>
											<td colspan="9" class="table_ListSubLine1"></td>
										</tr>
<%
	ELSE
		WHILE NOT(RS.EOF)
		iCount = iCount + 1
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1"><%=RS("strGroupCode")%></td>
											<td class="table_ListSubText1"><%=RS("strGroupName")%></td>
											<td class="table_ListSubText1"><%=RS("strGroupMemo")%></td>
											<td class="table_ListSubText1"><%=RS("intBoardCount")%></td>
											<td class="table_ListSubText1"><%=RS("intMemberCount")%></td>
											<td class="table_ListSubText1"><a href="javascript:popupLayer('GroupBoard.asp?strGroupCode=<%=RS("strGroupCode")%>',720,405)"><img src="../images/btn_setup_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:popupLayer('GroupMember.asp?strGroupCode=<%=RS("strGroupCode")%>',940,591)"><img src="../images/btn_setup_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:popupLayer('GroupBoardAdd.asp?Action=edit&strGroupCode=<%=RS("strGroupCode")%>',540,290)"><img src="../images/btn_edit_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:;" onClick="OnGroupRemove('<%=RS("strGroupCode")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0"></a></td>
										</tr>
										<tr>
											<td colspan="9" class="table_ListSubLine1"></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
										<tr>
											<td colspan="9" height="1"></td>
										</tr>
										<tr>
											<td colspan="9" class="table_ListSubBLine1"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><a href="javascript:popupLayer('GroupBoardAdd.asp?Action=add',540,290)"><img src="../images/btn_group_add_m.gif" width="86" height="25" border="0"></a></td>
              </tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>특정 게시판에 특정 회원만 접근할 수 있게 끔 그룹을 지정하실 수 있습니다.</LI>
											<LI>그룹의 개수는 제한이 없으며, 해당 그룹별로 회원이나 게시판을 등록하시면 편리하게 이용하실 수 있습니다.</LI>
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
		if (confirm("선택한 그룹을 삭제하시겠습니까?")){
			document.theForm.action = "GroupBoard_ok.asp?Action=REMOVE&strGroupCode=" + str;
			document.theForm.submit();
		}
	}

</script>
<!-- #include file = "Foot.asp" -->