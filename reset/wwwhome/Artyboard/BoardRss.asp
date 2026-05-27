<?xml version="1.0" encoding="EUC-KR" ?>
<rss version="2.0" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/">
<!-- #include file = "Dbconnect/Dbconnect.asp" -->
<!-- #include file = "Library/Function.asp" -->
<%
	DIM strBoardID, bitUseRss, strBoardName, intTotalCount, Query
	strBoardID = REQUEST.QueryString("strBoardID")

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '" & strBoardID & "' ")

	bitUseRss = RS("bitUseRss")
	strBoardName = RS("strName")

	IF SESSION("strAdmin") <> "2" THEN Query = " AND [bitSecret] = '0' "

	SET RS = DBCON.EXECUTE("SELECT COUNT([intSeq]) FROM [MPLUS_BOARD] WHERE [strBoardID] = '" & strBoardID & "' AND [bitCheck] = '1' AND [bitDelete] = '0' " & Query)

	intTotalCount = RS(0)
%>
<channel>
	<title><![CDATA[<%=strBoardName%>]]></title>
	<link><![CDATA[<%=httpPath%>Mboard.asp?strBoardID=<%=strBoardID%>]]></link>
	<description><![CDATA[]]></description>
	<language>ko</language>
	<pubDate><%=NOW()%></pubDate>
	<totalCount><%=intTotalCount%></totalCount>
<%
	IF bitUseRss = True THEN
		SET RS = DBCON.EXECUTE("SELECT TOP 15 [intSeq], [strName], [strSubject], [strContent], [strCategory] = (SELECT [strCategory] FROM [MPLUS_BOARD_CATEGORY] WHERE [strBoardID] = [MPLUS_BOARD].[strBoardID] AND [intCategory] = [MPLUS_BOARD].[intCategory]), [dateRegDate] FROM [MPLUS_BOARD] WHERE [strBoardID] = '" & strBoardID & "' AND [bitCheck] = '1' AND [bitDelete] = '0' " & Query & " ORDER BY [intSeq] DESC ")
	
		WHILE NOT(RS.EOF)
%>
	<item>
	<title><![CDATA[<%=RS("strSubject")%>]]></title>
	<author><![CDATA[<%=RS("strName")%>]]></author>
	<link><![CDATA[<%=httpPath%>Mboard.asp?exec=Action&strBoardID=<%=strBoardID%>&intSeq=<%=RS("intSeq")%>]]></link>
	<description><![CDATA[<%=RS("strContent")%><br>]]></description>
	<pubDate><%=FORMATDATETIME(RS("dateRegDate"), 2) & " "%><%=FORMATDATETIME(RS("dateRegDate"), 4)%>:<%=SECOND(RS("dateRegDate"))%></pubDate>
	<category><![CDATA[<%=RS("strCategory")%>]]></category>
	</item>
<%
		RS.MOVENEXT
		WEND
	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>
</channel>
</rss>