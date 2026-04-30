<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<%
	RESPONSE.EXPIRES = -1

	DIM strLoginID, Action
	strLoginID = GetReplaceInput(REQUEST.QueryString("strLoginID"), "S")
	Action     = UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & strLoginID & "', '' ")

	IF RS.EOF THEN
		RESPONSE.WRITE "<script language=javascript>" & vbcrlf
		IF Action = "0" THEN
			RESPONSE.WRITE "alert('사용가능한 회원아이디 입니다.');" & vbcrlf
			RESPONSE.WRITE "window.returnValue=1;" & vbcrlf
		ELSE
			RESPONSE.WRITE "alert('등록되어 있지 않은 회원아이디 입니다.');" & vbcrlf
			RESPONSE.WRITE "window.returnValue=0;" & vbcrlf
		END IF
		RESPONSE.WRITE "self.close();" & vbcrlf
		RESPONSE.WRITE "</script>" & vbcrlf
	ELSE
		RESPONSE.WRITE "<script language=javascript>" & vbcrlf
		IF Action = "0" THEN
			RESPONSE.WRITE "alert('이미 사용되고 있는 회원아이디 입니다.\n\n다른 아이디를 입력해 주시기 바랍니다.');" & vbcrlf
			RESPONSE.WRITE "window.returnValue=0;" & vbcrlf
		ELSE
			RESPONSE.WRITE "alert('정상적으로 등록되어 있는 회원아이디 입니다.');" & vbcrlf
			RESPONSE.WRITE "window.returnValue=1;" & vbcrlf
		END IF
		RESPONSE.WRITE "self.close();" & vbcrlf
		RESPONSE.WRITE "</script>" & vbcrlf
	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>