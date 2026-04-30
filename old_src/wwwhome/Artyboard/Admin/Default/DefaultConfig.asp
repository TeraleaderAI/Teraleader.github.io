<%
	DIM intTopMenu, intLeftMenu, isAdminMenu
	intTopMenu  = 1
	intLeftMenu = 1
	isAdminMenu = 2
%>
<!-- #include file = "Head.asp" -->
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" action="DefaultConfig_ok.asp" onSubmit="return OnSubmitAction();">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title1.gif" width="104" height="19"></td>
                      <td align="right">관리자 홈 &gt; 기본환경설정 &gt; <b>기본환경설정</b></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>DB 연결 정보</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td bgcolor="#FFFFFF">
												<table width="100%" border="0" cellpadding="0" cellspacing="0">
													<tr>
														<td class="table_Left1"><b>DB 이름</b></td>
														<td class="table_Right1">
														  <input name="strConnectDbName" type="text" value="<%=strConnectDbName%>">
														&nbsp;<font color="#E86A34">MS SQL DB 이름</font></td>
													</tr>
													<tr>
														<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
													</tr>
													<tr>
														<td class="table_Left1"><b>DB 접속 아이디</b></td>
														<td class="table_Right1">
														  <input name="strConnectDbId" type="text" value="<%=strConnectDbId%>">
														&nbsp;<font color="#E86A34">DB 접속 아이디</font></td>
													</tr>
													<tr>
														<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
													</tr>
													<tr>
														<td class="table_Left1"><b>DB 접속 비밀번호</b></td>
														<td class="table_Right1">
														  <input name="strConnectDbPass" type="password" value="<%=strConnectDbPass%>">
														&nbsp;<font color="#E86A34">DB 접속 비밀번호</font></td>
													</tr>
													<tr>
														<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
													</tr>
													<tr>
														<td class="table_Left1"><b>DB 서버 아이피</b></td>
														<td class="table_Right1">
														  <input name="strConnectDbIp" type="text" value="<%=strConnectDbIp%>">
															&nbsp;<font color="#E86A34">DB 서버 접속 아이피 (웹서버와 같은경우 127.0.0.1
														또는 localhost)</font></td>
													</tr>
													<tr>
														<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>서버경로 및 컴포넌트 설정</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border='0' align="center" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">업로드 컴포넌트 </td>
											<td class="table_Right1">
											<select name="setUploadComponet" id="setUploadComponet">
											<option value="1"<% IF setUploadComponet = "1" THEN %> SELECTED<% END IF %>>Abc Upload (http://websupergoo.com)</option>
											<option value="2"<% IF setUploadComponet = "2" THEN %> SELECTED<% END IF %>>Dext Upload Pro (http://devpia.com)</option>
											<option value="3"<% IF setUploadComponet = "3" THEN %> SELECTED<% END IF %>>TABS Upload (http://tabslab.com)</option>
											</select>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">웹사이트 경로정보</td>
											<td class="table_Right1">
										  <input name="sitePath" type="text" id="sitePath" value="<%=sitePath%>" size="60"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">아티보드 웹경로</td>
											<td class="table_Right1">
										  <input name="httpPath" type="text" id="httpPath" value="<%=httpPath%>" size="60"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">아티보드 서버경로</td>
											<td class="table_Right1"><input name="rootPath" type="text" id="rootPath" value="<%=rootPath%>" size="60"></td>
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
								<td align="right" style="padding-right:20;"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
							</tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI><font color="#FD8402"><b>아티보드를 사용하기 위한 기본환경 설정이며, 정확한 정보를 입력하셔야 합니다.</b></font></LI>
											<LI>오류 발생시 아티보드경로/DBConnect/DBConnect.asp 파일을 직접 수정하셔도 됩니다.</LI>
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

		str = document.all['strConnectDbName'];
		if (str.value == ""){alert("DB 이름을 입력해 주시기 바랍니다.");str.focus();return false;}
	
		str = document.all['strConnectDbId'];
		if (str.value == ""){alert("DB 접속 아이디를 입력해 주시기 바랍니다.");str.focus();return false;}
	
		str = document.all['strConnectDbPass'];
		if (str.value == ""){alert("DB 접속 비밀번호를 입력해 주시기 바랍니다.");str.focus();return false;}
	
		str = document.all['strConnectDbIp'];
		if (str.value == ""){alert("DB 접속 아이피를 입력해 주시기 바랍니다.");str.focus();return false;}
	
		str = document.all['rootPath'];
		if (str.value == ""){alert("실제 서버 경로를 입력해 주시기 바랍니다.");str.focus();return false;}

	}
</script>
<!-- #include file = "Foot.asp" -->