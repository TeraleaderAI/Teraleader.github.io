<%
	DIM strSource

	strSource = ""
	strSource = strSource & "&lt;!-- #include file = """ & LCASE(REPLACE(LCASE(httpPath), LCASE(sitePath), "")) & "Dbconnect/Dbconnect.asp"" --&gt;" & vbcrlf
	strSource = strSource & "&lt;!-- #include file = """ & LCASE(REPLACE(LCASE(httpPath), LCASE(sitePath), "")) & "Library/Function.asp"" --&gt;" & vbcrlf
	strSource = strSource & "" & vbcrlf
	
	SELECT CASE strBoardType
	CASE "board"
	
	strSource = strSource & "&lt;table border=0 cellspacing=0 cellpadding=0&gt;" & vbcrlf
	strSource = strSource & "&lt;%" & vbcrlf
	strSource = strSource & "	SET RS = DBCON.EXECUTE(""EXEC [MPLUS_GET_BOARD_LIST_BEST] '" & strGroup & "', '" & intCount & "' "")" & vbcrlf
	strSource = strSource & "	WHILE NOT(RS.EOF)" & vbcrlf
	strSource = strSource & "" & vbcrlf
	strSource = strSource & "	'//제목 꾸미기" & vbcrlf
	strSource = strSource & "	strSubject = ""<font color="" & RS(""strFontColor"") & "">"" & GetCutSubject(RS(""strSubject"")," & intSubjectLength & ")" & " & ""</font>""" & vbcrlf
	strSource = strSource & "	IF RS(""bitBold"") = True THEN strSubject = strSubject & ""<b>"" & strSubject & ""</b>""" & vbcrlf
	strSource = strSource & "	'RS(""strCategory"")//카테고리명" & vbcrlf
	strSource = strSource & "	'RS(""intRead"")//조회수" & vbcrlf
	strSource = strSource & "	'RS(""intComment"")//댓글수" & vbcrlf
	strSource = strSource & "	'RS(""dateRegDate"")//등록일자" & vbcrlf
	strSource = strSource & "%&gt;" & vbcrlf
	strSource = strSource & "  &lt;tr&gt;" & vbcrlf
	strSource = strSource & "    &lt;td&gt;" & vbcrlf
	strSource = strSource & "      &lt;table width=100% border=0 cellspacing=0 cellpadding=0&gt;" & vbcrlf
	strSource = strSource & "        &lt;tr&gt;" & vbcrlf
	strSource = strSource & "          &lt;td&gt;&lt;a href=""" & LCASE(REPLACE(LCASE(httpPath), LCASE(sitePath), "")) & "Mboard.asp?Action=view&strBoardID=&lt;%=RS(""strBoardID"")%&gt;&intSeq=&lt;%=RS(""intSeq"")%&gt;"""
	IF strLink = "2" THEN strSource = strSource & " target=""_blank"""
	strSource = strSource & "&gt;&lt;%=strSubject%&gt;&lt;/a&gt;&lt;/td&gt;" & vbcrlf
	strSource = strSource & "          &lt;td align=right&gt;[&lt;%=FORMATDATETIME(RS(""dateRegDate""),2)%&gt;]&lt;/td&gt;" & vbcrlf
	strSource = strSource & "        &lt;/tr&gt;" & vbcrlf
	strSource = strSource & "        &lt;tr&gt;" & vbcrlf
	strSource = strSource & "          &lt;td colspan=2&gt;&lt;a href=""" & LCASE(REPLACE(LCASE(httpPath), LCASE(sitePath), "")) & "Mboard.asp?Action=view&strBoardID=&lt;%=RS(""strBoardID"")%&gt;&intSeq=&lt;%=RS(""intSeq"")%&gt;"""
	IF strLink = "2" THEN strSource = strSource & " target=""_blank"""
	strSource = strSource & "&gt;&lt;%=GetReplaceTag2Text(StripTags(RS(""strContent"")))%&gt;&lt;/a&gt;&lt;/td&gt;" & vbcrlf
	strSource = strSource & "        &lt;/tr&gt;" & vbcrlf
	strSource = strSource & "      &lt;/table&gt;" & vbcrlf
	strSource = strSource & "    &lt;/td&gt;" & vbcrlf
	strSource = strSource & "  &lt;/tr&gt;" & vbcrlf
	strSource = strSource & "&lt;%" & vbcrlf
	strSource = strSource & "	RS.MOVENEXT" & vbcrlf
	strSource = strSource & "	WEND" & vbcrlf
	strSource = strSource & "%&gt;" & vbcrlf
	strSource = strSource & "&lt;/table&gt;" & vbcrlf

	CASE "gallery1", "gallery2"

	strSource = strSource & "&lt;%" & vbcrlf
	strSource = strSource & "	DIM intImgWidth, intImgHeight, strFileName" & vbcrlf
	strSource = strSource & "	intImgWidth   = 80  '// 이미지 너비" & vbcrlf
	strSource = strSource & "	intImgHeight  = 80  '// 이미지 높이" & vbcrlf
	strSource = strSource & "%&gt;" & vbcrlf
	strSource = strSource & "&lt;table width=100% border=0 cellspacing=0 cellpadding=0&gt;" & vbcrlf
	strSource = strSource & "&lt;%" & vbcrlf
	strSource = strSource & "	SET RS = DBCON.EXECUTE(""EXEC [MPLUS_GET_BOARD_LIST_BEST] '" & strGroup & "', '" & intCount & "' "")" & vbcrlf
	strSource = strSource & "	WHILE NOT(RS.EOF)" & vbcrlf
	strSource = strSource & "" & vbcrlf
	strSource = strSource & "	'//제목 꾸미기" & vbcrlf
	strSource = strSource & "	strSubject = ""<font color="" & RS(""strFontColor"") & "">"" & GetCutSubject(RS(""strSubject"")," & intSubjectLength & ")" & " & ""</font>""" & vbcrlf
	strSource = strSource & "	IF RS(""bitBold"") = True THEN strSubject = strSubject & ""<b>"" & strSubject & ""</b>""" & vbcrlf
	strSource = strSource & "" & vbcrlf
	strSource = strSource & "	'RS(""strCategory"")//카테고리명" & vbcrlf
	strSource = strSource & "	'RS(""intRead"")//조회수" & vbcrlf
	strSource = strSource & "	'RS(""intComment"")//댓글수" & vbcrlf
	strSource = strSource & "	'RS(""dateRegDate"")//등록일자" & vbcrlf
	strSource = strSource & "	IF RS(""strFileName"") = """" OR ISNULL(RS(""strFileName"")) = True THEN" & vbcrlf
	strSource = strSource & "	strFileName = ""No Image""" & vbcrlf
	strSource = strSource & "	ELSE" & vbcrlf
	strSource = strSource & "	strFileName = ""<img src=" & LCASE(REPLACE(LCASE(httpPath), LCASE(sitePath), "")) & "Pds/Board/"" & RS(""strBoardID"") & ""/"
	IF strBoardType = "gallery1" THEN strSource = strSource & "Thrum/"
	
	strSource = strSource & """ & RS(""strFileName"") & "" border=""""0""""&gt;""" & vbcrlf
	strSource = strSource & "	END IF" & vbcrlf
	strSource = strSource & "%&gt;" & vbcrlf

	strSource = strSource & "  &lt;tr&gt;" & vbcrlf
	strSource = strSource & "    &lt;td width=90 height=90 align=center&gt;&lt;a href=""" & LCASE(REPLACE(LCASE(httpPath), LCASE(sitePath), "")) & "Mboard.asp?Action=view&strBoardID=&lt;%=RS(""strBoardID"")%&gt;&intSeq=&lt;%=RS(""intSeq"")%&gt;"""
	IF strLink = "2" THEN strSource = strSource & " target=""_blank"""
	strSource = strSource & "&gt;&lt;%=strFileName%&gt;&lt;/a&gt;&lt;/td&gt;" & vbcrlf
	strSource = strSource & "    &lt;td valign=top&gt;" & vbcrlf
	strSource = strSource & "      &lt;table width=100% border=0 cellspacing=0 cellpadding=0&gt;" & vbcrlf
	strSource = strSource & "        &lt;tr&gt;" & vbcrlf
	strSource = strSource & "          &lt;td&gt;&lt;a href=""" & LCASE(REPLACE(LCASE(httpPath), LCASE(sitePath), "")) & "Mboard.asp?Action=view&strBoardID=&lt;%=RS(""strBoardID"")%&gt;&intSeq=&lt;%=RS(""intSeq"")%&gt;"""
	IF strLink = "2" THEN strSource = strSource & " target=""_blank"""
	strSource = strSource & "&gt;&lt;%=strSubject%&gt;&lt;/a&gt;&lt;/td&gt;" & vbcrlf
	strSource = strSource & "        &lt;/tr&gt;" & vbcrlf
	strSource = strSource & "        &lt;tr&gt;" & vbcrlf
	strSource = strSource & "        &lt;td colspan=2&gt;&lt;a href=""" & LCASE(REPLACE(LCASE(httpPath), LCASE(sitePath), "")) & "Mboard.asp?Action=view&strBoardID=&lt;%=RS(""strBoardID"")%&gt;&intSeq=&lt;%=RS(""intSeq"")%&gt;"""
	IF strLink = "2" THEN strSource = strSource & " target=""_blank"""
	strSource = strSource & "&gt;&lt;%=GetReplaceTag2Text(StripTags(RS(""strContent"")))%&gt;&lt;/a&gt;&lt;/td&gt;" & vbcrlf
	strSource = strSource & "        &lt;/tr&gt;" & vbcrlf
	strSource = strSource & "      &lt;/table&gt;" & vbcrlf
	strSource = strSource & "    &lt;/td&gt;" & vbcrlf
	strSource = strSource & "  &lt;/tr&gt;" & vbcrlf
	strSource = strSource & "&lt;%" & vbcrlf
	strSource = strSource & "	RS.MOVENEXT" & vbcrlf
	strSource = strSource & "	WEND" & vbcrlf
	strSource = strSource & "%&gt;" & vbcrlf
	strSource = strSource & "&lt;/table&gt;" & vbcrlf

	END SELECT

	RESPONSE.WRITE strSource
%>