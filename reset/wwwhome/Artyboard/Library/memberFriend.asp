<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM strUserID, Action
	strUserID  = GetReplaceInput(REQUEST.QueryString("strUserID"), "S")
	Action     = UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))

	RESPONSE.WRITE "<script language=javascript>" & vbcrlf

	IF SESSION("strLoginID") = "" THEN
		RESPONSE.WRITE "alert('로그인 후 이용해 주시기 바랍니다.');" & vbcrlf
		RESPONSE.WRITE "window.returnValue=0;" & vbcrlf
	ELSE
		SELECT CASE Action
		CASE "ADD"
			SET RS = DBCON.EXECUTE("SELECT [strLoginID] FROM [MPLUS_MEMBER_FRIEND] WHERE [strLoginID] = '" & SESSION("strLoginID") & "' AND [strFriendID] = '" & strUserID & "' ")
			IF RS.EOF THEN
				DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_FRIEND] ([strLoginID], [strFriendID]) VALUES ('" & SESSION("strLoginID") & "', '" & strUserID & "') ")
				RESPONSE.WRITE "alert('친구등록이 완료되었습니다.');" & vbcrlf
				RESPONSE.WRITE "window.returnValue=1;" & vbcrlf
			ELSE
				RESPONSE.WRITE "alert('이미 등록된 아이디 입니다.');" & vbcrlf
				RESPONSE.WRITE "window.returnValue=0;" & vbcrlf
			END IF
		CASE "ERASE"
			DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_FRIEND] WHERE [strLoginID] = '" & SESSION("strLoginID") & "' AND [strFriendID] = '" & strUserID & "' ")
			RESPONSE.WRITE "alert('친구삭제가 완료되었습니다.');" & vbcrlf
			RESPONSE.WRITE "window.returnValue=1;" & vbcrlf
		END SELECT
	END IF

	RESPONSE.WRITE "self.close();" & vbcrlf
	RESPONSE.WRITE "</script>" & vbcrlf

	SET RS = NOTHING : DBCON.CLOSE
%>