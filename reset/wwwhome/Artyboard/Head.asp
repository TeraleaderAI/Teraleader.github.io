<% 
	DIM Path_sLine, strUrl
	IF INSTR(StrReverse(REQUEST.ServerVariables("URL")),"/") > 0 THEN Path_sLine = instr(StrReverse(REQUEST.ServerVariables("URL")),"/") ELSE Path_sLine = 0
	strUrl = UCASE(StrReverse(LEFT(StrReverse(REQUEST.ServerVariables("URL")), Path_sLine - 1)))

	SELECT CASE strUrl
	CASE "MBOARD.ASP", "MEMBER.ASP", "MEMO.ASP", "POLL.ASP", "SCRAP.ASP"
	CASE ELSE
%>
<html lang="ko" xml:lang="ko" xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>▒ 아티보드 Ver 1.5 샘플메인 ▒</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body topmargin="25" leftmargin="18">
<!-- #include file = "DBConnect/DBConnect.asp" -->
<!-- #include file = "Library/Function.asp" -->
<% END SELECT %>
<table width="960" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td></td>
  </tr>
  <tr>
    <td><!-- #include file = "TopMenu.asp" --></td>
  </tr>
  <tr>
    <td height="9"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="192" valign="top"><!-- #include file = "LeftMenu.asp" --></td>
          <td valign="top" style="padding-left:10;">