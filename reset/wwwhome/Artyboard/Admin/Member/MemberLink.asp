<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu  = 4
	intLeftMenu = 12
	isAdminMenu = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title16.gif" width="135" height="19"></td>
                      <td align="right">관리자 홈 &gt; 회원관리 &gt; <b>회원관련 링크정보</b></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>회원등록 관련링크</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td height="33" class="table_Left1">회원가입 링크</td>
											<td class="table_Right1"><a href="<%=httpPath%>Member.asp?Action=join" target="_blank"><%=httpPath%>Member.asp?Action=join</a></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td height="33" class="table_Left1">아이디 찾기 링크</td>
											<td><a href="<%=httpPath%>Library/findMemberID.asp?Action=ID" target="_blank"><%=httpPath%>Library/findMemberID.asp?Action=ID</a></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td height="33" class="table_Left1">비밀번호 찾기 링크</td>
											<td><a href="<%=httpPath%>Library/findMemberID.asp?Action=PW" target="_blank"><%=httpPath%>Library/findMemberID.asp?Action=PW</a></td>
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
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>로그인 관련링크</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td height="33" class="table_Left1">로그인 링크</td>
											<td class="table_Right1"><a href="<%=httpPath%>member.asp?Action=login" target="_blank"><%=httpPath%>member.asp?Action=login</a></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td height="33" class="table_Left1">로그아웃 링크</td>
											<td><a href="<%=httpPath%>member.asp?Action=logout" target="_blank"><%=httpPath%>member.asp?Action=logout</a></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td height="33" class="table_Left1">개인정보 수정링크</td>
											<td><a href="<%=httpPath%>member.asp?Action=edit" target="_blank"><%=httpPath%>member.asp?Action=edit</a></td>
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
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>개인정보 관련링크</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td height="33" class="table_Left1">회원 프로필 보기</td>
											<td class="table_Right1"><a href="<%=httpPath%>member.asp?Action=profile&amp;strLoginID=회원아이디&amp;strBoardID=board1" target="_blank"><%=httpPath%>member.asp?Action=profile&strLoginID=회원아이디&strBoardID=게시판아이디</a></td>
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
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>개인메모 관련링크</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td height="33" class="table_Left1">메모리스트 링크</td>
											<td class="table_Right1"><a href="<%=httpPath%>memo.asp?Action=list"><%=httpPath%>memo.asp?Action=list</a></td>
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
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>회원관련 링크에 대한 정보입니다. 적절히 수정하셔서 사용하시기 바랍니다.</LI></td>
										</tr>
									</table>
									</fieldset>								</td>
							</tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							</form>
            </table>
<!-- #include file = "Foot.asp" -->