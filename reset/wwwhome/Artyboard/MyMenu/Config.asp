<!-- #include file = "Head.asp" -->
<%
	IF SESSION("strLoginID") <> strUserID THEN
		RESPONSE.WRITE ExecJavaAlert("본인의 정보만 수정이 가능합니다.", 0)
		RESPONSE.End()
	END IF

	DIM strOpenMemo, strOpenName, strOpenGroup, strOpenEmail, strOpenSex, strOpenAge, strOpenBirthday, strOpenTel
	DIM strOpenMobile, strOpenAddr, strOpenHomp, strOpenJob, strOpenHobby, strOpenMarry

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & SESSION("strLoginID") & "' ")

	strOpenMemo     = RS("strOpenMemo")
	strOpenName     = RS("strOpenName")
	strOpenGroup    = RS("strOpenGroup")
	strOpenEmail    = RS("strOpenEmail")
	strOpenSex      = RS("strOpenSex")
	strOpenAge      = RS("strOpenAge")
	strOpenBirthday = RS("strOpenBirthday")
	strOpenTel      = RS("strOpenTel")
	strOpenMobile   = RS("strOpenMobile")
	strOpenAddr     = RS("strOpenAddr")
	strOpenHomp     = RS("strOpenHomp")
	strOpenJob      = RS("strOpenJob")
	strOpenHobby    = RS("strOpenHobby")
	strOpenMarry    = RS("strOpenMarry")
%>
<table width="100%" height="100%" border="0" cellpadding="10" cellspacing="0" bgcolor="#FFFFFF">
<form name="theForm" method="post" action="MyMenu/Config_ok.asp">
<input type="hidden" name="strLoginID" value="<%=SESSION("strLoginID")%>">
	<tr>
		<td valign="top" height="100%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
				<tr>
					<td height="30"><img src="MyMenu/images/ico_dot.gif" width="9" height="9"><b>아티보드</b>님의 공개정보를 설정니다.</td>
				</tr>
				<tr>
					<td height="10">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td background="MyMenu/images/line_dot.gif" height="9"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="5">&nbsp;</td>
				</tr>
				<tr>
					<td height="5">
						<table width="100%" border="1" cellpadding="10" cellspacing="0" bordercolor="#e7e7e7" style="border-collapse:collapse; line-height:16px;">
							<tr>
								<td bgcolor="#f7f7f7"><font color="#808080">쪽지수신을 원하시면 &quot;모두받음&quot;으로 설정해 주세요<br>
								&quot;관심회원에게만 받음&quot;으로 설정하시면 아티보드님의 친구에게만 받으실 수 있습니다.</font></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="10">&nbsp;</td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="3" bgcolor="#75bbd4"></td>
								<td height="3" bgcolor="#a5c9d9"></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">쪽지수신</td>
								<td class="table1_right">
								<select name="strOpenMemo" id="strOpenMemo" style="font-size:12px; width:200px;">
								<option value="0"<% IF strOpenMemo = "0" THEN %> SELECTED<% END IF %>>받지않음</option>
								<option value="2"<% IF strOpenMemo = "2" THEN %> SELECTED<% END IF %>>모두받음</option>
								<option value="1"<% IF strOpenMemo = "1" THEN %> SELECTED<% END IF %>>관심회원에게만 받음</option>
								</select>
								</td>
							</tr>
							<tr>
								<td height="29" class="table1_left">이름(실명)</td>
								<td class="table1_right">
								<input type="radio" name="strOpenName" value="0"<% IF strOpenName = "0" THEN %> CHECKED<% END IF %>>공개안함&nbsp;&nbsp;
								<input type="radio" name="strOpenName" value="1"<% IF strOpenName = "1" THEN %> CHECKED<% END IF %>>관심회원에게만 공개&nbsp;&nbsp; 
								<input type="radio" name="strOpenName" value="2"<% IF strOpenName = "2" THEN %> CHECKED<% END IF %>>모두공개
								</td>
							</tr>
							<tr>
								<td height="29" class="table1_left">회원그룹</td>
								<td class="table1_right">
								<input type="radio" name="strOpenGroup" value="0"<% IF strOpenGroup = "0" THEN %> CHECKED<% END IF %>>공개안함&nbsp;&nbsp;
								<input type="radio" name="strOpenGroup" value="1"<% IF strOpenGroup = "1" THEN %> CHECKED<% END IF %>>관심회원에게만 공개&nbsp;&nbsp; 
								<input type="radio" name="strOpenGroup" value="2"<% IF strOpenGroup = "2" THEN %> CHECKED<% END IF %>>모두공개
								</td>
							</tr>
							<tr>
								<td height="29" class="table1_left">이메일</td>
								<td class="table1_right">
								<input type="radio" name="strOpenEmail" value="0"<% IF strOpenEmail = "0" THEN %> CHECKED<% END IF %>>공개안함&nbsp;&nbsp;
								<input type="radio" name="strOpenEmail" value="1"<% IF strOpenEmail = "1" THEN %> CHECKED<% END IF %>>관심회원에게만 공개&nbsp;&nbsp; 
								<input type="radio" name="strOpenEmail" value="2"<% IF strOpenEmail = "2" THEN %> CHECKED<% END IF %>>모두공개
								</td>
							</tr>
							<tr>
								<td height="29" class="table1_left">전화번호</td>
								<td class="table1_right">
								<input type="radio" name="strOpenTel" value="0"<% IF strOpenTel = "0" THEN %> CHECKED<% END IF %>>공개안함&nbsp;&nbsp;
								<input type="radio" name="strOpenTel" value="1"<% IF strOpenTel = "1" THEN %> CHECKED<% END IF %>>관심회원에게만 공개&nbsp;&nbsp; 
								<input type="radio" name="strOpenTel" value="2"<% IF strOpenTel = "2" THEN %> CHECKED<% END IF %>>모두공개
								</td>
							</tr>
							<tr>
								<td height="29" class="table1_left">휴대폰</td>
								<td class="table1_right">
								<input type="radio" name="strOpenMobile" value="0"<% IF strOpenMobile = "0" THEN %> CHECKED<% END IF %>>공개안함&nbsp;&nbsp;
								<input type="radio" name="strOpenMobile" value="1"<% IF strOpenMobile = "1" THEN %> CHECKED<% END IF %>>관심회원에게만 공개&nbsp;&nbsp; 
								<input type="radio" name="strOpenMobile" value="2"<% IF strOpenMobile = "2" THEN %> CHECKED<% END IF %>>모두공개
								</td>
							</tr>
							<tr>
								<td height="29" class="table1_left">성별/나이</td>
								<td class="table1_right">
								<input type="radio" name="strOpenSex" value="0"<% IF strOpenSex = "0" THEN %> CHECKED<% END IF %>>공개안함&nbsp;&nbsp;
								<input type="radio" name="strOpenSex" value="1"<% IF strOpenSex = "1" THEN %> CHECKED<% END IF %>>관심회원에게만 공개&nbsp;&nbsp; 
								<input type="radio" name="strOpenSex" value="2"<% IF strOpenSex = "2" THEN %> CHECKED<% END IF %>>모두공개
								</td>
							</tr>
							<tr>
								<td height="29" class="table1_left">생일</td>
								<td class="table1_right">
								<input type="radio" name="strOpenBirthday" value="0"<% IF strOpenBirthday = "0" THEN %> CHECKED<% END IF %>>공개안함&nbsp;&nbsp;
								<input type="radio" name="strOpenBirthday" value="1"<% IF strOpenBirthday = "1" THEN %> CHECKED<% END IF %>>관심회원에게만 공개&nbsp;&nbsp; 
								<input type="radio" name="strOpenBirthday" value="2"<% IF strOpenBirthday = "2" THEN %> CHECKED<% END IF %>>모두공개
								</td>
							</tr>
							<tr>
								<td height="29" class="table1_left">주소</td>
								<td class="table1_right">
								<input type="radio" name="strOpenAddr" value="0"<% IF strOpenAddr = "0" THEN %> CHECKED<% END IF %>>공개안함&nbsp;&nbsp;
								<input type="radio" name="strOpenAddr" value="1"<% IF strOpenAddr = "1" THEN %> CHECKED<% END IF %>>관심회원에게만 공개&nbsp;&nbsp; 
								<input type="radio" name="strOpenAddr" value="2"<% IF strOpenAddr = "2" THEN %> CHECKED<% END IF %>>모두공개
								</td>
							</tr>
							<tr>
								<td height="29" class="table1_left">홈페이지</td>
								<td class="table1_right">
								<input type="radio" name="strOpenHomp" value="0"<% IF strOpenHomp = "0" THEN %> CHECKED<% END IF %>>공개안함&nbsp;&nbsp;
								<input type="radio" name="strOpenHomp" value="1"<% IF strOpenHomp = "1" THEN %> CHECKED<% END IF %>>관심회원에게만 공개&nbsp;&nbsp; 
								<input type="radio" name="strOpenHomp" value="2"<% IF strOpenHomp = "2" THEN %> CHECKED<% END IF %>>모두공개
								</td>
							</tr>
							<tr>
								<td height="29" class="table1_left">직업</td>
								<td class="table1_right">
								<input type="radio" name="strOpenJob" value="0"<% IF strOpenJob = "0" THEN %> CHECKED<% END IF %>>공개안함&nbsp;&nbsp;
								<input type="radio" name="strOpenJob" value="1"<% IF strOpenJob = "1" THEN %> CHECKED<% END IF %>>관심회원에게만 공개&nbsp;&nbsp; 
								<input type="radio" name="strOpenJob" value="2"<% IF strOpenJob = "2" THEN %> CHECKED<% END IF %>>모두공개
								</td>
							</tr>
							<tr>
								<td height="29" class="table1_left">취미</td>
								<td class="table1_right">
								<input type="radio" name="strOpenHobby" value="0"<% IF strOpenHobby = "0" THEN %> CHECKED<% END IF %>>공개안함&nbsp;&nbsp;
								<input type="radio" name="strOpenHobby" value="1"<% IF strOpenHobby = "1" THEN %> CHECKED<% END IF %>>관심회원에게만 공개&nbsp;&nbsp; 
								<input type="radio" name="strOpenHobby" value="2"<% IF strOpenHobby = "2" THEN %> CHECKED<% END IF %>>모두공개
								</td>
							</tr>
							<tr>
								<td height="29" class="table1_left">결혼정보</td>
								<td class="table1_right">
								<input type="radio" name="strOpenMarry" value="0"<% IF strOpenMarry = "0" THEN %> CHECKED<% END IF %>>공개안함&nbsp;&nbsp;
								<input type="radio" name="strOpenMarry" value="1"<% IF strOpenMarry = "1" THEN %> CHECKED<% END IF %>>관심회원에게만 공개&nbsp;&nbsp; 
								<input type="radio" name="strOpenMarry" value="2"<% IF strOpenMarry = "2" THEN %> CHECKED<% END IF %>>모두공개
								</td>
							</tr>
							<tr>
								<td height="3" bgcolor="#75bbd4"></td>
								<td height="3" bgcolor="#a5c9d9"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="center"><input type="image" name="imageField" id="imageField" src="MyMenu/images/btn_ok.gif" align="absmiddle">&nbsp;<a href="javascript:history.back(-1);"><img src="MyMenu/images/btn_cancle.gif" align="absmiddle"></a></td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
<!-- #include file = "Foot.asp" -->