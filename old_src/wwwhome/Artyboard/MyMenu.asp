<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "Library/topSide.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>Artyboard MemberMenu</title>
<link rel="stylesheet" type="text/css" href="MyMenu/style.css">
</head>
<style type="text/css">
    
    BODY, TD    {FONT-FAMILY:돋움; FONT-SIZE:12px; TEXT-DECORATION:none;}
    IMG         {border:0px;}

    a           {FONT-FAMILY:돋움; FONT-SIZE:9pt; LINE-HEIGHT:normal;}
    a:link      {COLOR:#555555; TEXT-DECORATION:none;}
    a:visited   {COLOR:#555555; TEXT-DECORATION:none;}
    a:active    {COLOR:#555555; TEXT-DECORATION:none;}
    a:hover     {COLOR:#03366C; TEXT-DECORATION:underline;}

    .barcolor   {background:#ABA79E}
    .border     {border:1px solid #ABA79E}
    .bordertb   {border-top:1px solid #ABA79E; border-bottom:1px solid #ABA79E}

</style>
<body topmargin="0" leftmargin="0">
<!-- #include file = "Library/Function.asp" -->
<%
	IF SESSION("strLoginID") = "" THEN
		RESPONSE.WRITE ExecJavaAlert("로그인 후 이용해 주시기 바랍니다.", 1)
		RESPONSE.End()
	END IF

	DIM Action, execFile
	Action = UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))
	
	IF Action = "" THEN Action = "main"

	SELECT CASE UCASE(Action)
	CASE "MAIN"      : execFile = "Main.asp"
	CASE "BOARDLIST" : execFile = "BoardList.asp"
	CASE "CMTLIST"   : execFile = "CmtList.asp"
	CASE "MEMO"      : execFile = "Memo.asp"
	CASE "EMAIL"     : execFile = "Email.asp"
	CASE "CONFIG"    : execFile = "Config.asp"
	CASE "INFO"      : execFile = "Info.asp"
	CASE "GUEST"     : execFile = "Guest.asp"
	END SELECT

	SERVER.EXECUTE("MyMenu\" & execFile)
%>
</body>
</html>
<!-- #include file = "Library/downSide.asp" -->