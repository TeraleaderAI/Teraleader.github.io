<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Member/MemberList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM Action, strMsg, Query
	Action = REQUEST.QueryString("Action")

	DIM intPage, intPageSize, strSearchGroup, strSearchCategory, strSearchWord, strMemberList, I, iCount

	intPage           = REQUEST.QueryString("intPage")
	intPageSize       = REQUEST.FORM("intPageSize")
	strSearchGroup    = REQUEST.FORM("strSearchGroup")
	strSearchCategory = REQUEST.FORM("strSearchCategory")
	strSearchWord     = GetReplaceInput(REQUEST.FORM("strSearchWord"), "")

	DIM strLoginID

	SELECT CASE UCASE(Action)
	CASE "AUTH"

		DIM bitAuth
		bitAuth    = REQUEST.QueryString("bitAuth")
		strLoginID = REQUEST.QueryString("strLoginID")
		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [bitAuth] = '" & bitAuth & "' WHERE [strLoginID] = '" & strLoginID & "' ")
		SELECT CASE bitAuth
		CASE "0" : strMsg = "회원승인 취소가 완료되었습니다."
		CASE "1" : strMsg = "회원승인이 완료되었습니다."
		END SELECT

	CASE "GROUP"

		DIM strGroup
		strGroup = REQUEST.FORM("strGroup")
		strMemberList = getSplitQuery(REQUEST.QueryString("strMemberList"))
		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strGroup] = '" & strGroup & "' WHERE [strLoginID] IN (" & strMemberList & ") ")
		strMsg = "회원레벨 변경이 완료되었습니다."

	CASE "REMOVE"

		strLoginID = REQUEST.QueryString("strLoginID")

		SET RS = DBCON.EXECUTE("SELECT [strPhotoFile], [strNameFile] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & strLoginID & "' ")

		IF RS("strPhotoFile") <> "" AND ISNULL(RS("strPhotoFile")) = False THEN CALL ExecFileDelete(rootPath & "Pds\Member\Photo\", RS("strPhotoFile"))

		IF RS("strNameFile") <> "" AND ISNULL(RS("strNameFile")) = False THEN CALL ExecFileDelete(rootPath & "Pds\Member\Name\", RS("strNameFile"))

		DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & strLoginID & "' ")
		DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_POINT] WHERE ([strLoginID] = '" & strLoginID & "' OR [strRecID] = '" & strLoginID & "')" )

		strMsg = "회원삭제가 완료되었습니다."

	CASE "SELECTREMOVE"

		FOR I = 1 TO REQUEST.FORM("strLoginID").COUNT

			SET RS = DBCON.EXECUTE("SELECT [strPhotoFile], [strNameFile] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & REQUEST.FORM("strLoginID")(I) & "' ")
	
			IF RS("strPhotoFile") <> "" AND ISNULL(RS("strPhotoFile")) = False THEN CALL ExecFileDelete(rootPath & "Pds\Member\Photo\", RS("strPhotoFile"))
	
			IF RS("strNameFile") <> "" AND ISNULL(RS("strNameFile")) = False THEN CALL ExecFileDelete(rootPath & "Pds\Member\Name\", RS("strNameFile"))
	
			DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & REQUEST.FORM("strLoginID")(I) & "' ")
			DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_POINT] WHERE ([strLoginID] = '" & REQUEST.FORM("strLoginID")(I) & "' OR [strRecID] = '" & REQUEST.FORM("strLoginID")(I) & "')" )

		NEXT

		strMsg = "회원삭제가 완료되었습니다."

	CASE "SECESSION"

		strMemberList = getSplitQuery(REQUEST.QueryString("strMemberList"))
		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [bitSecession] = '1', [strSecessionMemo] = '관리자에 의한 탈퇴처리', [dateSecessionDate] = getdate() WHERE [strLoginID] IN (" & strMemberList & ") ")
		strMsg = "회원탈퇴 처리가 완료되었습니다."

	CASE "EXCEL"

		SET RS = DBCON.EXECUTE("SELECT [strItemName] FROM [MPLUS_MEMBER_CONFIG_JOIN_ITEM] ORDER BY [strItem] ASC ")

		DIM strItemName(10)
		I = 0

		WHILE NOT(RS.EOF)
			IF LEFT(RS("strItemName"), 12) = "strMemberAdd" THEN
				I = I + 1
				strItemName(I) = RS("strItemName")
			END IF
		RS.MOVENEXT
		WEND

		IF REQUEST.QueryString("sType") = "a" THEN
			Query = ""
		ELSE
			strMemberList = getSplitQuery(REQUEST.QueryString("strMemberList"))
			Query = " WHERE [strLoginID] IN (" & strMemberList & ") "
		END IF


		SET RS = DBCON.EXECUTE("SELECT [strLoginID], [strGroup], [strLoginPwd], [strLoginName], [strEmail], [bitMailing], [strSSN], [strBirthday], [strNick], [strIcq], [strMsn], [strHomepage], [strHomePost], [strHomeAddr1], [strHomeAddr2], [strHomeTel], [strMobile], [strCompPost], [strCompAddr1], [strCompAddr2], [strCompTel], [strJob], [strJobLevel], [strHobby], [strMarry], [strJoinMemo], [strPhotoFile], [strNameFile], [strMemo], [bitUserInfo], [strRecLoginID], [strMemberAdd1], [strMemberAdd2], [strMemberAdd3], [strMemberAdd4], [strMemberAdd5], [strMemberAdd6], [strMemberAdd7], [strMemberAdd8], [strMemberAdd9], [strMemberAdd10], [bitAuth], [intVisit], [intPoint], [intBoardCount], [intCommentCount], [intVote], [strAdmin], [dateSignDate], [bitSecession], [dateSecessionDate], [strSecessionMemo], [dateRegDate] FROM [MPLUS_MEMBER_LIST] " & Query & " ORDER BY [intNum] DESC ")

		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition","attachment;filename=MemberList" & YEAR(NOW) & MONTH(NOW) & DAY(NOW) & ".xls"

		RESPONSE.WRITE "<html>" & vbcrlf
		RESPONSE.WRITE "<head>" & vbcrlf
		RESPONSE.WRITE "<meta http-equiv='content-type' content='text/html; charset=euc-kr'>" & vbcrlf
		RESPONSE.WRITE "<title>회원정보</title>" & vbcrlf
		RESPONSE.WRITE "</head>" & vbcrlf
		RESPONSE.WRITE "<body>" & vbcrlf

		RESPONSE.WRITE "<table width=100% border=1 cellspacing=0 cellpadding=0>" & vbcrlf
		RESPONSE.WRITE "  <tr>" & vbcrlf
		RESPONSE.WRITE "    <td>번호</td>" & vbcrlf
		RESPONSE.WRITE "    <td>아이디</td>" & vbcrlf
		RESPONSE.WRITE "    <td>그룹</td>" & vbcrlf
		RESPONSE.WRITE "    <td>비밀번호</td>" & vbcrlf
		RESPONSE.WRITE "    <td>이름</td>" & vbcrlf
		RESPONSE.WRITE "    <td>메일</td>" & vbcrlf
		RESPONSE.WRITE "    <td>메일링</td>" & vbcrlf
		RESPONSE.WRITE "    <td>주민등록번호</td>" & vbcrlf
		RESPONSE.WRITE "    <td>생년월일</td>" & vbcrlf
		RESPONSE.WRITE "    <td>별칭</td>" & vbcrlf
		RESPONSE.WRITE "    <td>ICQ</td>" & vbcrlf
		RESPONSE.WRITE "    <td>MSN</td>" & vbcrlf
		RESPONSE.WRITE "    <td>홈페이지</td>" & vbcrlf
		RESPONSE.WRITE "    <td>자택우편번호</td>" & vbcrlf
		RESPONSE.WRITE "    <td>자택기본주소</td>" & vbcrlf
		RESPONSE.WRITE "    <td>자택세부주소</td>" & vbcrlf
		RESPONSE.WRITE "    <td>자택전화</td>" & vbcrlf
		RESPONSE.WRITE "    <td>휴대폰</td>" & vbcrlf
		RESPONSE.WRITE "    <td>회사우편번호</td>" & vbcrlf
		RESPONSE.WRITE "    <td>회사기본주소</td>" & vbcrlf
		RESPONSE.WRITE "    <td>회사세부주소</td>" & vbcrlf
		RESPONSE.WRITE "    <td>회사전화</td>" & vbcrlf
		RESPONSE.WRITE "    <td>직업</td>" & vbcrlf
		RESPONSE.WRITE "    <td>직급</td>" & vbcrlf
		RESPONSE.WRITE "    <td>취미</td>" & vbcrlf
		RESPONSE.WRITE "    <td>결혼</td>" & vbcrlf
		RESPONSE.WRITE "    <td>가입동기</td>" & vbcrlf
		RESPONSE.WRITE "    <td>사진파일</td>" & vbcrlf
		RESPONSE.WRITE "    <td>이름이미지</td>" & vbcrlf
		RESPONSE.WRITE "    <td>자기소개</td>" & vbcrlf
		RESPONSE.WRITE "    <td>정보공개</td>" & vbcrlf
		RESPONSE.WRITE "    <td>추천아이디</td>" & vbcrlf
		RESPONSE.WRITE "    <td>추가항목1</td>" & vbcrlf
		RESPONSE.WRITE "    <td>추가항목2</td>" & vbcrlf
		RESPONSE.WRITE "    <td>추가항목3</td>" & vbcrlf
		RESPONSE.WRITE "    <td>추가항목4</td>" & vbcrlf
		RESPONSE.WRITE "    <td>추가항목5</td>" & vbcrlf
		RESPONSE.WRITE "    <td>추가항목6</td>" & vbcrlf
		RESPONSE.WRITE "    <td>추가항목7</td>" & vbcrlf
		RESPONSE.WRITE "    <td>추가항목8</td>" & vbcrlf
		RESPONSE.WRITE "    <td>추가항목9</td>" & vbcrlf
		RESPONSE.WRITE "    <td>추가항목10</td>" & vbcrlf
		RESPONSE.WRITE "    <td>승인</td>" & vbcrlf
		RESPONSE.WRITE "    <td>방문</td>" & vbcrlf
		RESPONSE.WRITE "    <td>포인트</td>" & vbcrlf
		RESPONSE.WRITE "    <td>게시글</td>" & vbcrlf
		RESPONSE.WRITE "    <td>댓글</td>" & vbcrlf
		RESPONSE.WRITE "    <td>추천</td>" & vbcrlf
		RESPONSE.WRITE "    <td>관리자</td>" & vbcrlf
		RESPONSE.WRITE "    <td>최근방문이</td>" & vbcrlf
		RESPONSE.WRITE "    <td>탈퇴</td>" & vbcrlf
		RESPONSE.WRITE "    <td>탈퇴사유</td>" & vbcrlf
		RESPONSE.WRITE "    <td>탈퇴일자</td>" & vbcrlf
		RESPONSE.WRITE "    <td>가입일자</td>" & vbcrlf
		RESPONSE.WRITE "  </tr>" & vbcrlf

		WHILE NOT(RS.EOF)
		iCount = iCount + 1

		RESPONSE.WRITE "  <tr>" & vbcrlf
		RESPONSE.WRITE "    <td>" & iCount & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strLoginID") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strGroup") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strLoginPwd") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strLoginName") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strEmail") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("bitMailing") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>"
		IF RS("strSSN") <> "" AND ISNULL(RS("strSSN")) = False THEN RESPONSE.WRITE LEFT(RS("strSSN"), 6) & "-" & RIGHT(RS("strSSN"), 7)
		RESPONSE.WRITE "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>"
		IF RS("strBirthday") <> "" AND ISNULL(RS("strBirthday")) = False THEN
			RESPONSE.WRITE LEFT(RS("strBirthday"), 4) & "/" & MID(RS("strBirthday"), 5, 2) & "/" & MID(RS("strBirthday"), 7, 2) & " "
			IF RIGHT(RS("strBirthday"), 1) = "0" THEN RESPONSE.WRITE "양" ELSE RESPONSE.WRITE "음"
		END IF
		RESPONSE.WRITE "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strNick") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strIcq") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strMsn") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strHomepage") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>"
		IF RS("strHomePost") <> "" AND ISNULL(RS("strHomePost")) = False THEN RESPONSE.WRITE LEFT(RS("strHomePost"), 3) & "-" & RIGHT(RS("strHomePost"), 3)
		RESPONSE.WRITE "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strHomeAddr1") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strHomeAddr2") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strHomeTel") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strMobile") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>"
		IF RS("strCompPost") <> "" AND ISNULL(RS("strCompPost")) = False THEN RESPONSE.WRITE LEFT(RS("strCompPost"), 3) & "-" & RIGHT(RS("strCompPost"), 3)
		RESPONSE.WRITE "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strCompAddr1") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strCompAddr2") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strCompTel") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strJob") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strJobLevel") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strHobby") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>"
		IF RS("strMarry") <> "" AND ISNULL(RS("strMarry")) = False THEN
			RESPONSE.WRITE LEFT(RS("strMarry"), 4) & "/" & MID(RS("strMarry"), 5, 2) & "/" & MID(RS("strMarry"), 7, 2) & " "
			IF RIGHT(RS("strBirthday"), 1) = "0" THEN RESPONSE.WRITE "미혼" ELSE RESPONSE.WRITE "기혼"
		END IF
		RESPONSE.WRITE "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strJoinMemo") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strPhotoFile") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strNameFile") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strMemo") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("bitUserInfo") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strRecLoginID") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strMemberAdd1") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strMemberAdd2") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strMemberAdd3") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strMemberAdd4") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strMemberAdd5") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strMemberAdd6") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strMemberAdd7") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strMemberAdd8") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strMemberAdd9") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strMemberAdd10") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("bitAuth") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("intVisit") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("intPoint") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("intBoardCount") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("intCommentCount") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("intVote") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strAdmin") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("dateSignDate") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("bitSecession") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("strSecessionMemo") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("dateSecessionDate") & "</td>" & vbcrlf
		RESPONSE.WRITE "    <td>" & RS("dateRegDate") & "</td>" & vbcrlf
		RESPONSE.WRITE "  </tr>" & vbcrlf

		RS.MOVENEXT
		WEND

		RESPONSE.WRITE "</table>" & vbcrlf

		RESPONSE.WRITE "</body>" & vbcrlf
		RESPONSE.WRITE "</html>" & vbcrlf

	END SELECT

	IF UCASE(Action) <> "EXCEL" THEN

	RESPONSE.WRITE "<form name=theForm method=post action=MemberList.asp?intPage=" & intPage & ">" & vbcrlf
	RESPONSE.WRITE "<input type=hidden name=intPageSize value=" & intPageSize & ">" & vbcrlf
	RESPONSE.WRITE "<input type=hidden name=strSearchGroup value=" & strSearchGroup & ">" & vbcrlf
	RESPONSE.WRITE "<input type=hidden name=strSearchCategory value=" & strSearchCategory & ">" & vbcrlf
	RESPONSE.WRITE "<input type=hidden name=strSearchWord value=" & strSearchWord & ">" & vbcrlf
	RESPONSE.WRITE "</form>" & vbcrlf

	RESPONSE.WRITE "<script language=javascript>" & vbcrlf
	RESPONSE.WRITE "alert('" & strMsg & "');" & vbcrlf
	RESPONSE.WRITE "document.theForm.submit();" & vbcrlf
	RESPONSE.WRITE "</script>" & vbcrlf

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>