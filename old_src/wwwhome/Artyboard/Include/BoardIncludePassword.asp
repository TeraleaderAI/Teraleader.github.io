<!-- #include file = "BoardInclude.asp" -->
<%
	DIM strPassMode, strFormLink
	strPassMode = REQUEST.QueryString("strPassMode")   : IF strPassMode = "" THEN strPassMode = "secBoard"

	SELECT CASE UCASE(strPassMode)
	CASE "SECBOARD"
		strFormLink = "mboard.asp?strBoardID=" & strBoardID
	CASE "EDIT"
		strFormLink = "mboard.asp?Action=edit&strBoardID=" & strBoardID & "&intCategory=" & intCategory & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intPage=" & intPage & "&intSeq=" & GetReplaceInput(REQUEST.QueryString("intSeq"), "S")
	CASE "SECRET"
		strFormLink = "mboard.asp?Action=view&strBoardID=" & strBoardID & "&intPage=" & intPage & "&intCategory=" & intCategory & "&strSearchCategory=" & strSearchCategory & "&strSearchWord=" & strSearchWord & "&intSeq=" & GetReplaceInput(REQUEST.QueryString("intSeq"), "S")
	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>