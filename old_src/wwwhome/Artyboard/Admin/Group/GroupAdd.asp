<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 3
	intLeftMenu  = 1
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM Action
	Action = UCASE(REQUEST.QueryString("Action"))
	IF Action = "" THEN Action = "ADD"

	DIM strGroupCode, strGroupName, strGroupMemo, intLevel, intDefaultPoint, strAvata, bitDefault, I

	SELECT CASE Action
	CASE "ADD"

		SET RS = DBCON.EXECUTE("SELECT TOP 1 [strGroupCode] FROM [MPLUS_GROUP] ORDER BY [strGroupCode] DESC ")

		strGroupCode = INT(RIGHT(RS("strGroupCode"), 3)) + 1

		FOR I = LEN(strGroupCode) TO 2
			strGroupCode = "0" & strGroupCode
		NEXT
		strGroupCode = "G" & strGroupCode

	CASE "EDIT"

		strGroupCode = REQUEST.QueryString("strGroupCode")

		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_GROUP] '" & strGroupCode & "' ")

		strGroupName    = RS("strGroupName")
		strGroupMemo    = RS("strGroupMemo")
		intLevel        = RS("intLevel")
		intDefaultPoint = RS("intDefaultPoint")
		strAvata        = RS("strAvata")
		bitDefault      = RS("bitDefault")

	END SELECT
%>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<form name="theForm" method="post" action="Group_ok.asp?Action=<%=Action%>" onSubmit="return OnSubmitAction();">
						<input type="hidden" name="strGroupCode" value="<%=strGroupCode%>">
						<input type="hidden" name="strAvata" value="<%=strAvata%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title3.gif" width="107" height="19"></td>
                      <td align="right">관리자 홈 &gt; 그룹관리 &gt; <b><% IF Action = "ADD" THEN %>신규 그룹등록<% ELSE %>그룹 정보수정<% END IF %></b></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							<tr>
								<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong><% IF Action = "ADD" THEN %>신규 그룹등록<% ELSE %>그룹 정보수정<% END IF %></strong></span></td>
							</tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%"  border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
												<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
													<tr>
														<td height="33" class="table_Left1">그룹코드</td>
														<td class="table_Right1"><B><%=strGroupCode%></B></td>
													</tr>
													<tr>
														<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
													</tr>
													<tr>
														<td class="table_Left1">그룹명</td>
														<td class="table_Right1"><input name="strGroupName" type="text" id="strGroupName" value="<%=strGroupName%>" size="32" maxlength="32"></td>
													</tr>
													<tr>
														<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
													</tr>
<% IF Action = "EDIT" THEN %>
													<tr>
														<td class="table_Left1">그룹 Level</td>
														<td class="table_Right1">Lv. <%=intLevel%></td>
													</tr>
													<tr>
														<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
													</tr>
<% END IF %>
													<tr>
														<td class="table_Left1">그룹 포인트</td>
														<td class="table_Right1"><input name="intDefaultPoint" type="text" id="intDefaultPoint" value="<%=intDefaultPoint%>" size="10" maxlength="10">&nbsp;<font color="#E86A34">현재 그룹으로 회원등급이 변경될때 지급될 포인트 입니다.</font></td>
													</tr>
													<tr>
														<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
													</tr>
<% IF Action = "ADD" THEN %>
													<tr>
														<td class="table_Left1">그룹 위치 </td>
														<td class="table_Right1">
														<select name="intLevel" id="intLevel">
														<option value="0">맨위에 등록</option>
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_GROUP] ")
	WHILE NOT(RS.EOF)
		IF RS("intLevel") <> "0" THEN RESPONSE.WRITE "<option value=" & RS("intLevel") & ">" & RS("strGroupName") & " 아래에 등록</option>" & vbcrlf
	RS.MOVENEXT
	WEND
%>
														</select></td>
													</tr>
													<tr>
														<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
													</tr>
<% END IF %>
													<tr>
														<td class="table_Left1">마크 이미지</td>
														<td class="table_Right1"><img name="setIcon" src="<% IF strAvata = "" OR ISNULL(strAvata) = True THEN %>../Images/blank_icon.gif<% ELSE %>../../Pds/Member/GroupIcon/<%=strAvata%><% END IF %>" border="1" align="absmiddle" style="border-color:#000000">&nbsp;&nbsp;<a href="javascript:popupLayer('GroupIcon.asp',441,300)" name=navi><img src="../images/btn_mark_select.gif" width="101" height="16" border="0" align="absmiddle"></a>&nbsp;<a href="javascript:;" onClick="OnAvataUseNot();return false;"><img src="../images/btn_nouse.gif" width="47" height="16" border="0" align="absmiddle" /></a><font color="#E86A34">&nbsp;게시판의 회원이름 앞에 붙는 그룹 마크이미지 입니다.</font></td>
													</tr>
													<tr>
														<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
													</tr>
													<tr>
														<td class="table_Left1">그룹 설명 </td>
														<td class="table_Right1"><input name="strGroupMemo" type="text" id="strGroupMemo" value="<%=strGroupMemo%>" size="40" maxlength="128"></td>
													</tr>
													<tr>
														<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="10"></td>
											</tr>
										<tr>
											<td height="40" align="right" style="padding-right:30;"><input name="imageField" type="image" src="../images/btn_submit_m.gif" border="0" class="no_Line">
											</td>
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
											<LI>그룹 포인트는 <font color="#FD8402"><b>회원의 그룹이 변경될 경우 지급할 포인트이며, 그룹의 변경시 과거에 지급된 포인트는 삭제</b></font> 됩니다.</LI>
											<LI>그룹별로 마크 이미지를 설정하실 수 있으며, 신규로 마크 이미지를 등록하거나 삭제가 가능합니다.</LI>
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
		str = document.all['strGroupName'];
		if (str.value == ""){alert("그룹명을 입력해 주시기 바랍니다.");str.focus();return false;}
	}

	function OnAvataUseNot(){
		document.all['setIcon'].src = "../Images/blank_icon.gif";
		document.all['strAvata'].value = "";
	}

</script>
<!-- #include file = "Foot.asp" -->