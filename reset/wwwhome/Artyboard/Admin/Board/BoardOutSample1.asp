<%
	DIM strSource

	strSource = ""
	strSource = strSource & "&lt;!-- #include file = """ & LCASE(REPLACE(LCASE(httpPath), LCASE(sitePath), "")) & "Dbconnect/Dbconnect.asp"" --&gt;" & vbcrlf
	strSource = strSource & "&lt;!-- #include file = """ & LCASE(REPLACE(LCASE(httpPath), LCASE(sitePath), "")) & "Library/Function.asp"" --&gt;" & vbcrlf
	strSource = strSource & "" & vbcrlf
	
	SELECT CASE strBoardType
	CASE "board"
	
	strSource = strSource & "&lt;%" & vbcrlf
	strSource = strSource & "DIM intFileNum, strFileName, intFileSize, intFileDown, tempFileName" & vbcrlf
	strSource = strSource & "%&gt;" & vbcrlf
	strSource = strSource & "&lt;table border=0 cellspacing=0 cellpadding=0&gt;" & vbcrlf
	strSource = strSource & "&lt;!-- 타이틀이 필요없을 경우 이 부분을 삭제합니다. --&gt;" & vbcrlf
	strSource = strSource & " &lt;tr align=center bgcolor='#eaf0f4'&gt;" & vbcrlf
	strSource = strSource & "  &lt;td&gt;제목&lt;/td&gt;" & vbcrlf
	strSource = strSource & "  &lt;td&gt;이름&lt;/td&gt;" & vbcrlf
	strSource = strSource & "  &lt;td&gt;조회&lt;/td&gt;" & vbcrlf
	strSource = strSource & "  &lt;td&gt;추천&lt;/td&gt;" & vbcrlf
	strSource = strSource & "  &lt;td&gt;다운&lt;/td&gt;" & vbcrlf
	strSource = strSource & "  &lt;td&gt;날짜&lt;/td&gt;" & vbcrlf
	strSource = strSource & " &lt;/tr&gt;" & vbcrlf
	strSource = strSource & "&lt;!-- 타이틀이 필요없을 경우 이 부분을 삭제합니다. --&gt;" & vbcrlf
	strSource = strSource & "&lt;%" & vbcrlf
	strSource = strSource & "	SET RS = DBCON.EXECUTE(""EXEC [MPLUS_GET_BOARD_LIST_NOTICE] '" & strSetBoardID & "', '0', '" & intCount & "' "")" & vbcrlf
	strSource = strSource & "	WHILE NOT(RS.EOF)" & vbcrlf
	strSource = strSource & "" & vbcrlf
	strSource = strSource & "'// 첨부파일 정보가 필요없는 경우 삭제" & vbcrlf
	strSource = strSource & "	IF RS(""strFileName"") = """" OR ISNULL(RS(""strFileName"")) = True THEN" & vbcrlf
	strSource = strSource & "	intFileNum = """"" & vbcrlf
	strSource = strSource & "	strFileName = """"" & vbcrlf
	strSource = strSource & "	intFileSize = 0" & vbcrlf
	strSource = strSource & "	intFileDown = 0" & vbcrlf
	strSource = strSource & "	ELSE" & vbcrlf
	strSource = strSource & "	tempFileName = SPLIT(RS(""strFileName""),""|"")" & vbcrlf
	strSource = strSource & "	intFileNum = tempFileName(0)" & vbcrlf
	strSource = strSource & "	strFileName = tempFileName(1)" & vbcrlf
	strSource = strSource & "	intFileSize = tempFileName(2)" & vbcrlf
	strSource = strSource & "	intFileDown = tempFileName(3)" & vbcrlf
	strSource = strSource & "	END IF" & vbcrlf
	strSource = strSource & "'// 첨부파일 정보가 필요없는 경우 삭제" & vbcrlf
	strSource = strSource & "%&gt;" & vbcrlf
	strSource = strSource & " &lt;tr align=center&gt;" & vbcrlf
	strSource = strSource & "  &lt;!-- 제목출력 --&gt;" & vbcrlf
	strSource = strSource & "  &lt;td align=left&gt;&lt;a href=""" & LCASE(REPLACE(LCASE(httpPath), LCASE(sitePath), "")) & "" & LCASE(REPLACE(LCASE(httpPath), LCASE(sitePath), "")) & "Mboard.asp?Action=view&strBoardID=" & strSetBoardID & "&intSeq=&lt;%=RS(""intSeq"")%&gt;"""
	IF strLink = "2" THEN strSource = strSource & " target=""_blank"""
	strSource = strSource & ">&lt;%=GetCutSubject(RS(""strSubject"")," & intSubjectLength & ")%&gt;&lt;/a&gt;&lt;/td&gt;" & vbcrlf
	strSource = strSource & "  &lt;!-- 제목출력 --&gt;" & vbcrlf
	strSource = strSource & "  &lt;!-- 이름출력 --&gt;" & vbcrlf
	strSource = strSource & "  &lt;td align=left&gt;&lt;%=RS(""strName"")%&gt;&lt;/td&gt;" & vbcrlf
	strSource = strSource & "  &lt;!-- 이름출력 --&gt;" & vbcrlf
	strSource = strSource & "  &lt;!-- 조회수출력 --&gt;" & vbcrlf
	strSource = strSource & "  &lt;td&gt;&lt;%=RS(""intRead"")%&gt;&lt;/td&gt;" & vbcrlf
	strSource = strSource & "  &lt;!-- 조회수출력 --&gt;" & vbcrlf
	strSource = strSource & "  &lt;!-- 추천수출력 --&gt;" & vbcrlf
	strSource = strSource & "  &lt;td&gt;&lt;%=RS(""intVote"")%&gt;&lt;/td&gt;" & vbcrlf
	strSource = strSource & "  &lt;!-- 추천수출력 --&gt;" & vbcrlf
	strSource = strSource & "  &lt;!-- 다운수출력 --&gt;" & vbcrlf
	strSource = strSource & "  &lt;td&gt;&lt;%=intFileDown%&gt;&lt;/td&gt;" & vbcrlf
	strSource = strSource & "  &lt;!-- 다운수출력 --&gt;" & vbcrlf
	strSource = strSource & "  &lt;!-- 날짜출력 --&gt;" & vbcrlf
	strSource = strSource & "  &lt;td&gt;&lt;%=FORMATDATETIME(RS(""dateRegDate""),2)%&gt;&lt;/td&gt;" & vbcrlf
	strSource = strSource & "  &lt;!-- 날짜출력 --&gt;" & vbcrlf
	strSource = strSource & " &lt;/tr&gt;" & vbcrlf
	strSource = strSource & "&lt;%" & vbcrlf
	strSource = strSource & "	RS.MOVENEXT" & vbcrlf
	strSource = strSource & "	WEND" & vbcrlf
	strSource = strSource & "%&gt;" & vbcrlf
	strSource = strSource & "&lt;/table&gt;" & vbcrlf

	CASE "gallery1", "gallery2"

	strSource = strSource & "&lt;%" & vbcrlf
	strSource = strSource & "	DIM iCount, intWidthCount, intImgWidth, intImgHeight, tempFileName, strFileName" & vbcrlf
	strSource = strSource & "	intWidthCount = 4   '// 가로출력 개수" & vbcrlf
	strSource = strSource & "	iCount        = 0" & vbcrlf
	strSource = strSource & "	intImgWidth   = 80  '// 이미지 너비" & vbcrlf
	strSource = strSource & "	intImgHeight  = 80  '// 이미지 높이" & vbcrlf
	strSource = strSource & "%&gt;" & vbcrlf
	strSource = strSource & "&lt;script language=""javascript"" src=""Js/valId.js""&gt;&lt;/script&gt;" & vbcrlf
	strSource = strSource & "&lt;table border='0' cellspacing='0' cellpadding='0'&gt;" & vbcrlf
	strSource = strSource & "&lt;%" & vbcrlf
	strSource = strSource & "	SET RS = DBCON.EXECUTE(""EXEC [MPLUS_GET_BOARD_LIST_NOTICE] '" & strSetBoardID & "', '0', '" & intCount & "' "")" & vbcrlf
	strSource = strSource & "	WHILE NOT(RS.EOF)" & vbcrlf
	strSource = strSource & "	iCount = iCount + 1" & vbcrlf
	strSource = strSource & "" & vbcrlf
	strSource = strSource & "	IF RS(""strFileImage"") = """" OR ISNULL(RS(""strFileImage"")) = True THEN" & vbcrlf
	strSource = strSource & "	tempFileName = """"" & vbcrlf
	strSource = strSource & "	strFileName = """"" & vbcrlf
	strSource = strSource & "	ELSE" & vbcrlf
	strSource = strSource & "	tempFileName = SPLIT(RS(""strFileImage""), ""|"")" & vbcrlf
	strSource = strSource & "	strFileName = tempFileName(0)" & vbcrlf
	strSource = strSource & "	END IF" & vbcrlf
	strSource = strSource & "" & vbcrlf
	strSource = strSource & "	IF iCount = 1 THEN" & vbcrlf
	strSource = strSource & "%&gt;" & vbcrlf
	strSource = strSource & "  &lt;tr&gt;" & vbcrlf
	strSource = strSource & "&lt;%" & vbcrlf
	strSource = strSource & "	END IF" & vbcrlf
	strSource = strSource & "%&gt;" & vbcrlf
	strSource = strSource & "    &lt;td&gt;" & vbcrlf
	strSource = strSource & "      &lt;table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0""&gt;" & vbcrlf
	strSource = strSource & "        &lt;tr&gt;" & vbcrlf
	strSource = strSource & "          &lt;td&gt;&lt;% IF strFileName = """" THEN %&gt;No Image &lt;% ELSE %&gt;&lt;a href=""javascript:;"" onClick=""OnZoomGallery('&lt;%=strFileName%&gt;', '" & strSetBoardID & "');return false;""&gt;&lt;img src=""Pds/Board/" & strSetBoardID & "/"
	IF strBoardType = "gallery1" THEN strSource = strSource & "Thrum/"
	strSource = strSource & "&lt;%=strFileName%&gt;"""
	IF strBoardType = "gallery2" THEN strSource = strSource & " width=""&lt;%=intImgWidth%&gt;"" height=""&lt;%=intImgHeight%&gt;"""
	strSource = strSource & "border=""0""&gt;&lt;/a&gt;&lt;% END IF %&gt;&lt;/td&gt;" & vbcrlf
	strSource = strSource & "        &lt;/tr&gt;" & vbcrlf
	strSource = strSource & "        &lt;tr&gt;" & vbcrlf
	strSource = strSource & "          &lt;td&gt;&lt;a href=""" & LCASE(REPLACE(LCASE(httpPath), LCASE(sitePath), "")) & "" & LCASE(REPLACE(LCASE(httpPath), LCASE(sitePath), "")) & "Mboard.asp?Action=view&strBoardID=" & strSetBoardID & "&intSeq=&lt;%=RS(""intSeq"")%&gt;"""
	IF strLink = "2" THEN strSource = strSource & " target=""_blank"""
	strSource = strSource & ">&lt;%=GetCutSubject(RS(""strSubject"")," & intSubjectLength & ")%&gt;&lt;/a&gt;&lt;/td&gt;" & vbcrlf
	strSource = strSource & "        &lt;/tr&gt;" & vbcrlf
	strSource = strSource & "        &lt;tr&gt;" & vbcrlf
	strSource = strSource & "          &lt;td&gt;&lt;%=FORMATDATETIME(RS(""dateRegDate""),2)%&gt;&lt;/td&gt;" & vbcrlf
	strSource = strSource & "        &lt;/tr&gt;" & vbcrlf
	strSource = strSource & "      &lt;/table&gt;" & vbcrlf
	strSource = strSource & "    &lt;/td&gt;" & vbcrlf
	strSource = strSource & "&lt;%" & vbcrlf
	strSource = strSource & "	IF iCount = intWidthCount THEN" & vbcrlf
	strSource = strSource & "		iCount = 0" & vbcrlf
	strSource = strSource & "%&gt;" & vbcrlf
	strSource = strSource & "  &lt;/tr&gt;" & vbcrlf
	strSource = strSource & "&lt;%" & vbcrlf
	strSource = strSource & "	END IF" & vbcrlf
	strSource = strSource & "%&gt;" & vbcrlf
	strSource = strSource & "&lt;%" & vbcrlf
	strSource = strSource & "	RS.MOVENEXT" & vbcrlf
	strSource = strSource & "	WEND" & vbcrlf
	strSource = strSource & "%&gt;" & vbcrlf
	strSource = strSource & "&lt;/table&gt;" & vbcrlf

	END SELECT

	RESPONSE.WRITE strSource
%>