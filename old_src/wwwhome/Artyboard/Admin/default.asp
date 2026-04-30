<%
	DIM isAdmin
	isAdmin = 0
	IF SESSION("strLoginID") = "" THEN
		isAdmin = 0
	ELSE
		IF SESSION("strAdmin") = "" THEN
			isAdmin = 0
		ELSE
			isAdmin = SESSION("strAdmin")
		END IF
	END IF

	IF isAdmin = 0 THEN
		RESPONSE.REDIRECT "Login.asp"
		RESPONSE.End()
	ELSE
		SELECT CASE SESSION("strAdmin")
		CASE "1"
			RESPONSE.REDIRECT "Board/BoardList.asp"
			RESPONSE.END()
		CASE "2"
			RESPONSE.REDIRECT "Main/Main.asp"
			RESPONSE.END()
		END SELECT
	END IF
%>