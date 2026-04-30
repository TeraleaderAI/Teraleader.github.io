<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Member/MemberProfileSet.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM strSkin, bitUseGroup, bitUseVisit, bitUsePoint, bitUseSignDate, bitUseRegDate

	WITH REQUEST
	
		strSkin        = .FORM("strSkin")
		bitUseGroup    = .FORM("bitUseGroup")
		bitUseVisit    = GetCheckBoxRequest(.FORM("bitUseVisit"))
		bitUsePoint    = GetCheckBoxRequest(.FORM("bitUsePoint"))
		bitUseSignDate = GetCheckBoxRequest(.FORM("bitUseSignDate"))
		bitUseRegDate  = GetCheckBoxRequest(.FORM("bitUseRegDate"))

	END WITH


	DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_PROFILE] SET [strSkin] = '" & strSkin & "', [bitUseGroup] = '" & bitUseGroup & "', [bitUseVisit] = '" & bitUseVisit & "', [bitUsePoint] = '" & bitUsePoint & "', [bitUseSignDate] = '" & bitUseSignDate & "', [bitUseRegDate] = '" & bitUseRegDate & "' ")

	DIM strSetItem(35), strSetItemValue(35), I

	strSetItem(0) = "strLoginID"
	strSetItem(1) = "strLoginPwd"
	strSetItem(2) = "strLoginName"
	strSetItem(3) = "strEmail"
	strSetItem(4) = "bitMailing"
	strSetItem(5) = "strSSN"
	strSetItem(6) = "strBirthday"
	strSetItem(7) = "strNick"
	strSetItem(8) = "strIcq"
	strSetItem(9) = "strMsn"
	strSetItem(10) = "strHomepage"
	strSetItem(11) = "strHomeAddr"
	strSetItem(12) = "strHomeTel"
	strSetItem(13) = "strMobile"
	strSetItem(14) = "strCompAddr"
	strSetItem(15) = "strCompTel"
	strSetItem(16) = "strJob"
	strSetItem(17) = "strJobLevel"
	strSetItem(18) = "strHobby"
	strSetItem(19) = "strMarry"
	strSetItem(20) = "strJoinMemo"
	strSetItem(21) = "strPhotoFile"
	strSetItem(22) = "strNameFile"
	strSetItem(23) = "strMemo"
	strSetItem(24) = "bitUserInfo"
	strSetItem(25) = "strRecLoginID"
	strSetItem(26) = "strMemberAdd1"
	strSetItem(27) = "strMemberAdd2"
	strSetItem(28) = "strMemberAdd3"
	strSetItem(29) = "strMemberAdd4"
	strSetItem(30) = "strMemberAdd5"
	strSetItem(31) = "strMemberAdd6"
	strSetItem(32) = "strMemberAdd7"
	strSetItem(33) = "strMemberAdd8"
	strSetItem(34) = "strMemberAdd9"
	strSetItem(35) = "strMemberAdd10"

	WITH REQUEST

		strSetItemValue(0) = .FORM("strLoginID")
		strSetItemValue(1) = .FORM("strLoginPwd")
		strSetItemValue(2) = .FORM("strLoginName")
		strSetItemValue(3) = .FORM("strEmail")
		strSetItemValue(4) = .FORM("bitMailing")
		strSetItemValue(5) = .FORM("strSSN")
		strSetItemValue(6) = .FORM("strBirthday")
		strSetItemValue(7) = .FORM("strNick")
		strSetItemValue(8) = .FORM("strIcq")
		strSetItemValue(9) = .FORM("strMsn")
		strSetItemValue(10) = .FORM("strHomepage")
		strSetItemValue(11) = .FORM("strHomeAddr")
		strSetItemValue(12) = .FORM("strHomeTel")
		strSetItemValue(13) = .FORM("strMobile")
		strSetItemValue(14) = .FORM("strCompAddr")
		strSetItemValue(15) = .FORM("strCompTel")
		strSetItemValue(16) = .FORM("strJob")
		strSetItemValue(17) = .FORM("strJobLevel")
		strSetItemValue(18) = .FORM("strHobby")
		strSetItemValue(19) = .FORM("strMarry")
		strSetItemValue(20) = .FORM("strJoinMemo")
		strSetItemValue(21) = .FORM("strPhotoFile")
		strSetItemValue(22) = .FORM("strNameFile")
		strSetItemValue(23) = .FORM("strMemo")
		strSetItemValue(24) = .FORM("bitUserInfo")
		strSetItemValue(25) = .FORM("strRecLoginID")
		strSetItemValue(26) = .FORM("strMemberAdd1")
		strSetItemValue(27) = .FORM("strMemberAdd2")
		strSetItemValue(28) = .FORM("strMemberAdd3")
		strSetItemValue(29) = .FORM("strMemberAdd4")
		strSetItemValue(30) = .FORM("strMemberAdd5")
		strSetItemValue(31) = .FORM("strMemberAdd6")
		strSetItemValue(32) = .FORM("strMemberAdd7")
		strSetItemValue(33) = .FORM("strMemberAdd8")
		strSetItemValue(34) = .FORM("strMemberAdd9")
		strSetItemValue(35) = .FORM("strMemberAdd10")

	END WITH

	FOR I = 0 TO 35
		IF strSetItemValue(I) = "" THEN strSetItemValue(I) = "0"
		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_CONFIG_JOIN_ITEM] SET [bitUseProfile] = '" & strSetItemValue(I) & "' WHERE [strItem] = '" & strSetItem(I) & "' ")
	NEXT

	RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "MemberProfileSet.asp", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>