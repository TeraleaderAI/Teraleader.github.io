<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 4
	intLeftMenu  = 13
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	SET RS = DBCON.EXECUTE("SELECT [bitPointLevel] FROM [MPLUS_MEMBER_CONFIG_LOGIN] ")

	DIM bitPointLevel
	bitPointLevel = RS("bitPointLevel")
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" action="MemberPointLevel_ok.asp?Action=update">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title57.gif" width="165" height="19"></td>
                      <td align="right">관리자 홈 &gt; 회원관리 &gt; <b>포인트별 자동 그룹변경</b></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>포인트별 자동 그룹변경 사용유무</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">자동변환 기능사용</td>
											<td class="table_Right1"><input name="bitPointLevel" type="checkbox" id="bitPointLevel" value="1"<% IF bitPointLevel = True THEN %> CHECKED<% END IF %> class="no_Line">
											<LABEL FOR="bitPointLevel" style="cursor:hand">포인트등급 자동변환 기능을 사용합니다.</LABEL></td>
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
								<td height="26" align="right" style="padding-right:20;"><a href="javascript:;" onclick="OnSubmitAction();return false;"><img src="../images/btn_submit_m.gif" width="77" height="25" border="0"></a></td>
							</tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>등급 포인트 목록</strong></span></td>
              </tr>
              <tr>
                <td>
									<table width="100%"  border="0" cellpadding="0" cellspacing="0">
										<tr align="center" bgcolor="EB766F">
											<td colspan="6" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td height="30" class="table_Txt1" nowrap>선택</td>
											<td height="30" class="table_Txt1" nowrap>그룹코드</td>
											<td height="30" class="table_Txt1" nowrap>그룹명</td>
											<td height="30" nowrap class="table_Txt1">포인트 설정 </td>
											<td width="60" align="center" class="table_Txt1" nowrap>수정</td>
											<td width="60" align="center" class="table_Txt1" nowrap>삭제</td>
										</tr>
										<tr bgcolor="EB766F">
											<td colspan="6" class="table_Round1"></td>
										</tr>
<%
	SET RS = DBCON.EXECUTE("SELECT [intSeq], [strGroupCode], [strGroupName] = (SELECT [strGroupName] FROM [MPLUS_GROUP] WHERE [strGroupCode] = [MPLUS_MEMBER_POINT_LEVEL].[strGroupCode]), [intStartPoint], [intEndPoint] FROM [MPLUS_MEMBER_POINT_LEVEL] ")

	DIM iCount
	WHILE NOT(RS.EOF)
		iCount = iCount + 1
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1"><%=iCount%></td>
											<td class="table_ListSubText1"><%=RS("strGroupCode")%></td>
											<td class="table_ListSubText1"><%=RS("strGroupName")%></td>
											<td class="table_ListSubText1"><%=RS("intStartPoint")%> Point ~ <%=RS("intEndPoint")%> Point</td>
											<td class="table_ListSubText1"><a href="javascript:popupLayer('MemberPointLevelAdd.asp?Action=edit&intSeq=<%=RS("intSeq")%>',540,210)"><img src="../images/btn_edit_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><a href="javascript:;" onClick="OnPointRemove('<%=RS("intSeq")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0"></a></td>
										</tr>
										<tr>
											<td colspan="6" class="table_ListSubLine1"></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
%>
										<tr>
											<td colspan="6" height="1"></td>
										</tr>
										<tr>
											<td colspan="6" class="table_ListSubBLine1"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><a href="javascript:popupLayer('MemberPointLevelAdd.asp?Action=add',540,210)"><img src="../images/btn_point_group_add_w.gif" width="136" height="19" border="0"></a></td>
											<td align="right"><a href="javascript:;" onClick="OnPointSort();return false;"><img src="../images/btn_point_group_sort_w.gif" width="180" height="19" border="0"></a></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>등급 포인트 항목을 추가하려면 먼저 그룹을 생성해야 하며, 회원로그인시 포인트를 체크해서 그룹을 변경합니다.</LI>
											<LI>설정 포인트 회원등급 일괄적용 버튼을 클릭하면 생성하시는 등급별로 회원의 그룹을 일괄적으로 변경합니다.</LI>
											<LI>등급 포인트 항목을 삭제시 회원의 그룹은 변경이 되지 않으니, 주의하시기 바랍니다.</LI>
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

	function OnPointSort(){

		if (confirm("회원등급을 일괄적용 처리 하시겠습니까?")){
			var arr = showModalDialog('MemberPointLevel_ok.asp?Action=sort', 'pointSort', 'dialogWidth:0px; dialogHeight: 0px; resizable: no; help: no; status: no; scroll: no;');
		}
	}

	function OnPointRemove(intSeq){
		if (confirm("선택된 등급정보를 삭제하시겠습니까?")){
			document.theForm.action = "MemberPointLevel_ok.asp?Action=remove&intSeq=" + intSeq;
			document.theForm.submit();
		}
	}

	function OnSubmitAction(){

		document.theForm.submit();

	}

</script>
<!-- #include file = "Foot.asp" -->