<!-- #include file = "../Library/Function.asp" -->
<%
	DIM strCaptchaText
	strCaptchaText = REQUEST.QueryString("strCaptchaText")

	RESPONSE.WRITE "<script language=javascript>" & vbcrlf

	IF CheckCAPTCHA(strCaptchaText) = False THEN
		RESPONSE.WRITE "window.returnValue=0;" & vbcrlf
	ELSE
		SESSION("CAPTCHA") = vbNullString
		RESPONSE.WRITE "window.returnValue=1;" & vbcrlf
	END IF

	RESPONSE.WRITE "self.close();" & vbcrlf
	RESPONSE.WRITE "</script>" & vbcrlf
%>