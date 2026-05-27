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
	DIM Action, intPage, strLoginID, strMsg, I
	Action     = REQUEST.QueryString("Action")
	intPage    = REQUEST.QueryString("intPage")
	strLoginID = REQUEST.QueryString("strLoginID")

	DIM intNum, moneyPoint, strMemo

	SELECT CASE UCASE(Action)
	CASE "EDIT"
		intNum     = REQUEST.FORM("eIntNum")
		moneyPoint = REQUEST.FORM("eMoneyPoint")
		IF moneyPoint = "" THEN moneyPoint = 0
		strMemo    = GetReplaceInput(REQUEST.FORM("eStrMemo"), "")

		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_POINT] SET [moneyPoint] = " & moneyPoint & ", [strMemo] = '" & strMemo & "' WHERE [intNum] = '" & intNum & "' ")

		strMsg = "포인트 정보수정이 완료되었습니다."

	CASE "SELECTEDIT"

		FOR I = 1 TO REQUEST.FORM("intNum").COUNT

			intNum     = REQUEST.FORM("intNum")(I)
			moneyPoint = REQUEST.FORM("moneyPoint")(I)   : IF moneyPoint = "" THEN moneyPoint = 0
			strMemo    = GetReplaceInput(REQUEST.FORM("strMemo")(I), "")
			
			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_POINT] SET [moneyPoint] = " & moneyPoint & ", [strMemo] = '" & strMemo & "' WHERE [intNum] = '" & intNum & "' ")

		NEXT

		strMsg = "포인트 정보수정이 완료되었습니다."

	CASE "REMOVE"
	
		intNum = REQUEST.QueryString("intNum")
		DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_POINT] WHERE [intNum] = '" & intNum & "' ")

		strMsg = "포인트 정보삭제가 완료되었습니다."

	CASE "SELECTREMOVE"

		FOR I = 1 TO REQUEST.FORM("intNum").COUNT
		intNum = REQUEST.FORM("intNum")(I)
		DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_POINT] WHERE [intNum] = '" & intNum & "' ")
		NEXT

		strMsg = "포인트 정보삭제가 완료되었습니다."

	END SELECT

	DBCON.EXECUTE("EXEC [MPLUS_MEMBER_POINT_SORT] '" & strLoginID & "' ")

	RESPONSE.WRITE ExecFormSubmit(strMsg, "MemberPoint.asp?intPage=" & intPage & "&strLoginID=" & strLoginID, "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>