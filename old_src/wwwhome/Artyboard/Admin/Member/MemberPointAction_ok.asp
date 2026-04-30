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
	DIM sMember, strCode, moneyPoint, strMemo, I

	WITH REQUEST
	
		sMember    = .FORM("sMember")
		strCode    = .FORM("strCode")
		moneyPoint = .FORM("moneyPoint")
		strMemo    = GetReplaceInput(.FORM("strMemo"), "")

	END WITH

	DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [intPoint] = [intPoint] + " & moneyPoint & " WHERE [strLoginID] IN (" & getSplitQuery(sMember) & ") ")

	sMember = SPLIT(REQUEST.FORM("sMember"), ",")

	FOR I = 0 TO UBOUND(sMember)

		IF sMember(I) <> "" THEN
			DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_POINT] ([strPointType], [strLoginID], [strCode], [moneyPoint], [strMemo]) VALUES ('3', '" & sMember(I) & "', '" & strCode & "', " & moneyPoint & ", '" & strMemo & "') ")
			DBCON.EXECUTE("EXEC [MPLUS_MEMBER_POINT_SORT] '" & sMember(I) & "' ")
		END IF

	NEXT

	RESPONSE.WRITE "<script language=javascript>" & vbcrlf
	RESPONSE.WRITE "alert('포인트 일괄지급/삭제 처리가 완료되었습니다.');" & vbcrlf
	RESPONSE.WRITE "parent.closeLayer();" & vbcrlf
	RESPONSE.WRITE "</script>" & vbcrlf
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>