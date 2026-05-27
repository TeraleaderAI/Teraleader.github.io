<!-- #include file = "DBConnect/DBconnect.asp" -->
<%
	DIM strQueryString
	DIM errorURL
	DIM errorNum
	DIM url_comm_domain
	DIM strServerURL
	DIM strServerPort
	DIM strClubID
	DIM strClubName

	strQueryString  = Request.ServerVariables("QUERY_STRING")
	strServerURL    = "http://"&Request.ServerVariables("SERVER_NAME")&"/"
	strServerPort   = Request.ServerVariables("SERVER_PORT")

	errorNum = (Split(strQueryString,";"))(0)
	errorURL = (Split(strQueryString,";"))(1)
	errorURL = REPLACE(errorURL, ":80", "")

	' 404에러이면서 뒤의 url이 "/"로 끝나지 않을경우 아래 구문 실행
	IF errorNum = "404" THEN

		url_comm_domain = REPLACE(errorURL,strServerURL,"")

		IF RIGHT(url_comm_domain, 1) = "/" THEN url_comm_domain = MID(url_comm_domain, 1, LEN(url_comm_domain) - 1)

		SET RS = DBCON.EXECUTE("EXEC [MCLUB_GET_BASIC_INFO] '" & url_comm_domain & "' ")

		IF NOT(RS.EOF) THEN
			strClubID   = RS("strClubID")
			strClubName = RS("strClubName")
			IF SESSION("strLoginID") <> "" THEN
				SET RS = DBCON.EXECUTE("SELECT [intSeq] FROM [MCLUB_CAFE_VISIT] WHERE [strClubID] = '" & strClubID & "' AND [strLoginID] = '" & SESSION("strLoginID") & "' AND DATEPART(day, [dateVisitDate]) = DATEPART(wk, getdate()) ")
				IF RS.EOF THEN DBCON.EXECUTE("INSERT INTO [MCLUB_CAFE_VISIT] ([strClubID], [strLoginID]) VALUES ('" & strClubID & "', '" & SESSION("strLoginID") & "') ")
			END IF
			CALL CommunityFramePage(strClubID, strClubName)
		ELSE
			RESPONSE.WRITE "경로 오류입니다.^^"
			RESPONSE.End()
		END IF

	END IF
    
	SUB CommunityFramePage(strClubID, strClubTitle)

		DIM outStr
		outStr = outStr & "<html>" & vbCrLf
		outStr = outStr & "<head>" & vbCrLf
		outStr = outStr & "<title>[커뮤니티] " & strClubTitle & "</title>" & vbCrLf
		outStr = outStr & "</head>" & vbCrLf
		outStr = outStr & "<frameset rows=""0,*"" border=0>" & vbCrLf
		outStr = outStr & "    <frame src=""about:blank"" name=blank marginwidth=0 marginheight=0 leftmargin=0 topmargin=0 noresize>" & vbCrLf
		outStr = outStr & "    <frame src=""/" & REPLACE(httpPath, sitePath, "") & "club/Cafe.asp?strClubID=" & strClubID & """ name=body  scrolling=auto marginwidth=0 marginheight=0 leftmargin=0 topmargin=0>" & vbCrLf
		outStr = outStr & "</frameset>" & vbCrLf
		outStr = outStr & "</html>" & vbCrLf

		RESPONSE.WRITE outStr
		RESPONSE.End()

	END SUB
    
	SET RS = NOTHING : DBCON.CLOSE
%>