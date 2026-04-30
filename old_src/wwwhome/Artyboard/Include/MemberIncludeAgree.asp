<!-- #include file = "MemberInclude.asp" -->
<%
	DIM strSkin, strSkinGroup, skinPath, strWidth, strAlign

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_JOIN] ")

	strSkin              = RS("strSkin")
	strSkinGroup         = RS("strSkinGroup")
	skinPath             = GetSkinPath(strSkin, 1, strSkinGroup, 1) & "/"
	strWidth             = RS("strWidth")
	strAlign             = RS("strAlign")

	SELECT CASE strAlign
	CASE "0" : strAlign = "LEFT"
	CASE "1" : strAlign = "CENTER"
	CASE "2" : strAlign = "RIGHT"
	END SELECT
%>