<%
	if code="notice" then
		if session("m_level")<>"1" then
			response.write "<script>alert('관리자만 접근가능합니다.');top.location.href='/main.asp';</script>"
			response.end
		end if
	else
		if session("m_level")<>"1" and SESSION("strLoginID")="" then
			response.write "<script>alert('로그인후 이용해 주십시오.');top.location.href='/main.asp';</script>"
			response.end
		end if
	end if
%>