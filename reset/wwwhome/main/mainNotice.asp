<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>공지사항메인최신글보기</title>
<link rel="stylesheet" type="text/css" href="/css/main.css" />

<style type="text/css">
<!--
/*기본link*/
a:link { color:#666; text-decoration:none; }
a:visited { color:#666; text-decoration:none; }
a:hover { color:#0b7c9d; text-decoration:underline; }
a:active { color:#666; text-decoration:none; }
a:focus { color:#666; text-decoration:none; }

a.B:link { color:#666; font-weight:bold; text-decoration:none; }
a.B:visited { color:#666; font-weight:bold; text-decoration:none; }
a.B:hover { color:#0b7c9d; font-weight:bold; text-decoration:underline; }
a.B:active { color:#666; font-weight:bold; text-decoration:none; }
a.B:focus { color:#666; font-weight:bold; text-decoration:none; }

a.U:link { color:#666; font-weight:bold; text-decoration:underline; }
a.U:visited { color:#666; font-weight:bold; text-decoration:underline; }
a.U:hover { color:#0b7c9d; font-weight:bold; text-decoration:underline; }
a.U:active { color:#666; font-weight:bold; text-decoration:underline; }
a.U:focus { color:#666; font-weight:bold; text-decoration:underline; }
-->
</style></head>
<body  leftmargin="0" topmargin="0">
<!-- #include file = "../artyboard/Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../artyboard/Library/Function.asp" -->
<%
	DIM intNoticeType, strBoardID, iCount, strCCode, strFCode

	intNoticeType = REQUEST.QueryString("intNoticeType")
	strFcode = "board"
	IF intNoticeType = "" THEN intNoticeType = 0

	SELECT CASE intNoticeType
	CASE "0" : 
		strBoardID = "notice"
		strCCode = "notice"		
	END SELECT
%>
<table width="350" border="0" cellspacing="0" cellpadding="0">

	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="FONT-SIZE: 9pt; LINE-HEIGHT: 140%">
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_NOTICE] '" & strBoardID & "', '0', '4' ")

	WHILE NOT(RS.EOF)
	iCount = iCount + 1
%>
				<tr>
					<td width="10"><img src="/main/images/c_board_icon.gif" width="3" height="3"></td>
					<td height="20"><a href="/pages/board/board01.asp?mmode=view&intSeq=<%=RS("intSeq")%>&strBoardID=<%=strBoardID%>" target="_top"><% IF iCount = 1 THEN %><font color="FF5122"><% END IF %><%=GetCutSubject(RS("strSubject"),46)%><% IF iCount = 1 THEN %></font><% END IF %></a><% IF GetNewBoardTime(20, RS("dateRegDate")) = True THEN %>&nbsp;<img src="/main/images/c_board_new.gif" width="25" height="11" align="absmiddle"><% END IF %></td>
				</tr>
<%
	RS.MOVENEXT
	WEND
%>
			</table>		</td>
	</tr>
</table>
<p>
  <% SET RS = NOTHING : DBCON.CLOSE %> 
</p>
</body>
</html>