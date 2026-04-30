<!-- #include file = "Head.asp" -->
<%
	DIM AdRs_strUserFamily

	IF SESSION("strLoginID") = strUserID THEN
		AdRs_strUserFamily = "본인"
	ELSE
		IF CONF_bitUserFriend = True THEN AdRs_strUserFamily = "내가 등록한 관심회원" ELSE AdRs_strUserFamily = "관심회원 아님"
	END IF

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & strUserID & "' ")

	IF RS.EOF THEN
		RESPONSE.WRITE ExecJavaAlert("회원정보를 찾을 수 없습니다.", 0)
		RESPONSE.End()
	END IF
%>
<!-- #include file = "../Include/MemberIncludeRead.asp" -->
<%
	DIM AdRs_strSex, AdRs_intAge, AdRs_strHomeAddr

	IF AdRs_strSSN <> "" AND ISNULL(AdRs_strSSN) = False THEN
		SELECT CASE MID(AdRs_strSSN, 7, 1)
		CASE "1", "3" : AdRs_strSex = "남"
		CASE "2", "4" : AdRs_strSex = "여"
		END SELECT

		SELECT CASE MID(AdRs_strSSN, 7, 1)
		CASE "1", "2"
			AdRs_intAge = YEAR(NOW) - (1900 + INT(LEFT(AdRs_strSSN, 2))) & "세"
		CASE "3", "4"
			AdRs_intAge = YEAR(NOW) - (2000 + INT(LEFT(AdRs_strSSN, 2))) & "세"
		END SELECT
	ELSE
		AdRs_strSex = "-"
		AdRs_intAge = "-"
	END IF

	IF AdRs_strBirthday = "" OR ISNULL(AdRs_strBirthday) = True THEN
		AdRs_strBirthday = "-"
	ELSE
		AdRs_strBirthday = LEFT(AdRs_strBirthday, 4) & "년 " & MID(AdRs_strBirthday, 3, 2) & "월 " & MID(AdRs_strBirthday, 5,2) & "일 ("
		IF RIGHT(AdRs_strBirthday, 1) = "0" THEN AdRs_strBirthday = AdRs_strBirthday & "음력" ELSE AdRs_strBirthday = AdRs_strBirthday & "양력"
		AdRs_strBirthday = AdRs_strBirthday & ")"
	END IF

	IF AdRs_strHomeAddr1 = "" AND AdRs_strHomeAddr2 = "" THEN
		AdRs_strHomeAddr = "-"
	ELSE
		AdRs_strHomeAddr = AdRs_strHomeAddr1 & " " & AdRs_strHomeAddr2
	END IF

	IF AdRs_strHomepage = "" THEN AdRs_strHomepage = "-"
	IF AdRs_strJob = "" THEN AdRs_strJob = "-"
	IF AdRs_strHobby = "" THEN AdRs_strHobby = "-"
	IF AdRs_strMarry = "" OR AdRs_strMarry = "000000000" THEN
		AdRs_strMarry = "-"
	ELSE
		IF RIGHT(AdRs_strMarry, 1) = "0" THEN
			AdRs_strMarry = "미혼"
		ELSE
			AdRs_strMarry = "기혼 (" & LEFT(AdRs_strMarry,4) & "년 " & MID(AdRs_strMarry, 5, 2) & "월 " & MID(AdRs_strMarry, 7, 2) & "일)"
		END IF
	END IF

	IF SESSION("strAdmin") = "2" THEN

	ELSE

		SELECT CASE AdRs_strOpenName
		CASE "0" : AdRs_strLoginName = "비공개"
		CASE "1" : IF CONF_bitUserFriend = False THEN AdRs_strLoginName = "비공개"
		END SELECT

		SELECT CASE AdRs_strOpenGroup
		CASE "0" : AdRs_strGroupName = "비공개"
		CASE "1" : IF CONF_bitUserFriend = False THEN AdRs_strGroupName = "비공개"
		END SELECT

		SELECT CASE AdRs_strOpenEmail
		CASE "0" : AdRs_strEmail = "비공개"
		CASE "1" : IF CONF_bitUserFriend = False THEN AdRs_strEmail = "비공개"
		END SELECT
		
		SELECT CASE AdRs_strOpenTel
		CASE "0" : AdRs_strHomeTel = "비공개"
		CASE "1" : IF CONF_bitUserFriend = False THEN AdRs_strHomeTel = "비공개"
		END SELECT

		SELECT CASE AdRs_strOpenMobile
		CASE "0" : AdRs_strMobile = "비공개"
		CASE "1" : IF CONF_bitUserFriend = False THEN AdRs_strMobile = "비공개"
		END SELECT

		SELECT CASE AdRs_strOpenSex
		CASE "0" : AdRs_strSex = "비공개"
		CASE "1" : IF CONF_bitUserFriend = False THEN AdRs_strSex = "비공개"
		END SELECT

		SELECT CASE AdRs_strOpenAge
		CASE "0" : AdRs_intAge = "비공개"
		CASE "1" : IF CONF_bitUserFriend = False THEN AdRs_intAge = "비공개"
		END SELECT

		SELECT CASE AdRs_strOpenBirthday
		CASE "0" : AdRs_strBirthday = "비공개"
		CASE "1" : IF CONF_bitUserFriend = False THEN AdRs_strBirthday = "비공개"
		END SELECT

		SELECT CASE AdRs_strOpenAddr
		CASE "0" : AdRs_strHomeAddr = "비공개"
		CASE "1" : IF CONF_bitUserFriend = False THEN AdRs_strHomeAddr = "비공개"
		END SELECT

		SELECT CASE AdRs_strOpenHomp
		CASE "0" : AdRs_strHomepage = "비공개"
		CASE "1" : IF CONF_bitUserFriend = False THEN AdRs_strHomepage = "비공개"
		END SELECT


		SELECT CASE AdRs_strOpenJob
		CASE "0" : AdRs_strJob = "비공개"
		CASE "1" : IF CONF_bitUserFriend = False THEN AdRs_strJob = "비공개"
		END SELECT

		SELECT CASE AdRs_strOpenHobby
		CASE "0" : AdRs_strHobby = "비공개"
		CASE "1" : IF CONF_bitUserFriend = False THEN AdRs_strHobby = "비공개"
		END SELECT

		SELECT CASE AdRs_strOpenMarry
		CASE "0" : AdRs_strMarry = "비공개"
		CASE "1" : IF CONF_bitUserFriend = False THEN AdRs_strMarry = "비공개"
		END SELECT

	END IF
%>
<table width="100%" border="0" cellpadding="10" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td valign="top" height="100%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
				<tr>
					<td height="30"><img src="MyMenu/images/ico_dot.gif" width="9" height="9"><b><%=strUserName%></b>님의 기본정보입니다.</td>
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
								<td height="29" class="table1_left">이름(실명)</td>
								<td class="table1_right"><%=AdRs_strLoginName%></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">닉네임</td>
								<td class="table1_right"><%=AdRs_strNick%></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">아이디</td>
								<td class="table1_right"><%=AdRs_strLoginID%></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">회원그룹</td>
								<td class="table1_right"><%=AdRs_strGroupName%></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">이메일</td>
								<td class="table1_right"><%=AdRs_strEmail%></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">전화번호</td>
								<td class="table1_right"><%=AdRs_strHomeTel%></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">휴대폰</td>
								<td class="table1_right"><%=AdRs_strMobile%></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">성별/나이</td>
								<td class="table1_right"><%=AdRs_strSex%>/<%=AdRs_intAge%></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">생일</td>
								<td class="table1_right"><%=AdRs_strBirthday%></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">주소</td>
								<td class="table1_right"><%=AdRs_strHomeAddr%></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">가입일/접속일</td>
								<td class="table1_right"><%=AdRs_dateRegDate%>/<%=AdRs_dateSignDate%></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">홈페이지</td>
								<td class="table1_right"><%=AdRs_strHomepage%></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">직업</td>
								<td class="table1_right"><%=AdRs_strJob%></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">취미</td>
								<td class="table1_right"><%=AdRs_strHobby%></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">결혼정보</td>
								<td class="table1_right"><%=AdRs_strMarry%></td>
							</tr>
							<tr>
								<td height="29" class="table1_left">나와의 관계</td>
								<td class="table1_right">
								<%=AdRs_strUserFamily%>
								<% IF AdRs_strUserFamily <> "본인" THEN %>
								<% IF CONF_bitUserFriend = False THEN %>
								<a href="javascript:;" onClick="OnFriendExec('<%=strUserID%>','add');return false;"><img src="MyMenu/images/btn_interest_add.gif" border="0" align="absmiddle" border="0"></a></td>
								<% ELSE %>
								<a href="javascript:;" onClick="OnFriendExec('<%=strUserID%>','erase');return false;"><img src="MyMenu/images/btn_interest_del.gif" border="0" align="absmiddle" border="0"></a></td>
								<% END IF %>
								<% END IF %>
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
			</table>
		</td>
	</tr>
</table>
<script language="javascript">

	function OnFriendExec(strUserID, strAction){
		var arr = showModalDialog('Library/memberFriend.asp?strUserID=' + strUserID + '&Action=' + strAction, 'memberFriend', 'dialogWidth:300px; dialogHeight: 300px; resizable: no; help: no; status: no; scroll: no;');
		if (arr == "1"){
			location.href = "MyMenu.asp?Action=info&strUserID=" + strUserID
		}
	}
</script>
<!-- #include file = "Foot.asp" -->