<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Member/MemberPointLevel.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM Action, intSeq, bitPointLevel, strGroupCode, intStartPoint, intEndPoint
	Action = UCASE(REQUEST.QueryString("Action"))

	SELECT CASE Action
	CASE "UPDATE"

		bitPointLevel = REQUEST.FORM("bitPointLevel")

		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_CONFIG_LOGIN] SET [bitPointLevel] = '" & bitPointLevel & "' ")

		RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "MemberPointLevel.asp", "")
		RESPONSE.End()

	CASE "ADD", "EDIT"

		intSeq        = REQUEST.QueryString("intSeq")
		strGroupCode  = REQUEST.FORM("strGroupCode")
		intStartPoint = REQUEST.FORM("intStartPoint")
		intEndPoint   = REQUEST.FORM("intEndPoint")

		IF UCASE(Action) = "ADD" THEN

			SET RS = DBCON.EXECUTE("SELECT [intSeq] FROM [MPLUS_MEMBER_POINT_LEVEL] WHERE ([intStartPoint] BETWEEN " & INT(intStartPoint - 1) & " AND " & intEndPoint & ") OR ([intEndPoint] BETWEEN " & INT(intStartPoint) & " AND " & intEndPoint & ") ")
	
			IF NOT(RS.EOF) THEN
				RESPONSE.WRITE ExecJavaAlert("설정하신 포인트가 중복됩니다.", 0)
				RESPONSE.End()
			END IF
	
			DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_POINT_LEVEL] ([strGroupCode], [intStartPoint], [intEndPoint]) VALUES ('" & strGroupCode & "', " & intStartPoint & ", " & intEndPoint & ") ")
	
			RESPONSE.WRITE ExecJavaAlertLayer("등급 신규 등록이 완료되었습니다.", "MemberPointLevel.asp")
			RESPONSE.End()

		ELSE

			SET RS = DBCON.EXECUTE("SELECT [intSeq] FROM [MPLUS_MEMBER_POINT_LEVEL] WHERE [intSeq] != '" & intSeq & "' AND (([intStartPoint] BETWEEN " & INT(intStartPoint - 1) & " AND " & intEndPoint & ") OR ([intEndPoint] BETWEEN " & INT(intStartPoint) & " AND " & intEndPoint & ")) ")

			IF NOT(RS.EOF) THEN
				RESPONSE.WRITE ExecJavaAlert("설정하신 포인트가 중복됩니다.", 0)
				RESPONSE.End()
			END IF

			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_POINT_LEVEL] SET [strGroupCode] = '" & strGroupCode & "', [intStartPoint] = " & intStartPoint & ", [intEndPoint] = " & intEndPoint & " WHERE [intSeq] = '" & intSeq & "' ")

			RESPONSE.WRITE ExecJavaAlertLayer("등급 수정이 완료되었습니다.", "MemberPointLevel.asp")
			RESPONSE.End()

		END IF

	CASE "SORT"

		SET RS = DBCON.EXECUTE("SELECT [strGroupCode], [intStartPoint], [intEndPoint] FROM [MPLUS_MEMBER_POINT_LEVEL] ")

		WHILE NOT(RS.EOF)

			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strGroup] = '" & RS("strGroupCode") & "' WHERE [intPoint] >=" & RS("intStartPoint") & " AND [intPoint] <=" & RS("intEndPoint"))

		RS.MOVENEXT
		WEND

		RESPONSE.WRITE "<script language=javascript>" & vbcrlf
		RESPONSE.WRITE "alert('일괄적용 처리되었습니다.');" & vbcrlf
		RESPONSE.WRITE "self.close();" & vbcrlf
		RESPONSE.WRITE "</script>" & vbcrlf

	CASE "REMOVE"

		DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_POINT_LEVEL] WHERE [intSeq] = '" & REQUEST.QueryString("intSeq") & "' ")

		RESPONSE.WRITE ExecFormSubmit("포인트 등급정보가 삭제되었습니다.", "MemberPointLevel.asp", "")
		RESPONSE.End()

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>