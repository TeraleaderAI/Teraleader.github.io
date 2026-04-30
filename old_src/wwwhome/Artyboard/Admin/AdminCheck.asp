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
		IF strAdminPrevUrl = "" THEN
			IF isAdminPopup = False THEN
				RESPONSE.REDIRECT "../Login.asp?strPrevUrl=" & Request.ServerVariables("url") & "?" & Replace(Request.ServerVariables("QUERY_STRING"), "&", "--**--" )
				RESPONSE.End()
			ELSE
				RESPONSE.WRITE ExecJavaAlertLayer("", "../Login.asp?strPrevUrl=" & Request.ServerVariables("url") & "?" & Replace(Request.ServerVariables("QUERY_STRING"), "&", "--**--" ))
				RESPONSE.End()
			END IF
		ELSE
			IF isAdminPopup = False THEN
				RESPONSE.REDIRECT "../Login.asp?strPrevUrl=" & strAdminPrevUrl
				RESPONSE.End()
			ELSE
				RESPONSE.WRITE ExecJavaAlertLayer("", "../Login.asp?strPrevUrl=" & strAdminPrevUrl)
				RESPONSE.End()
			END IF
		END IF
	ELSE
		IF INT(isAdminMenu) > INT(SESSION("strAdmin")) THEN
			RESPONSE.WRITE ExecJavaAlert("전체 관리자만 접근이 가능한 페이지 입니다.", 0)
			RESPONSE.End()
		END IF
	END IF
%>