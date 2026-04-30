<script language="javascript" src="<%=httpPath%>Js/popup.js"></script>
<%
	DIM strDate
	strDate = YEAR(NOW)
	IF LEN(MONTH(NOW)) = 1 THEN strDate = strDate & "0" & MONTH(NOW) ELSE strDate = strDate & MONTH(NOW)
	IF LEN(DAY(NOW)) = 1 THEN strDate = strDate & "0" & DAY(NOW) ELSE strDate = strDate & DAY(NOW)

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_POPUP] '3', '', '', '" & strDate & "', '' ")

	IF NOT(RS.EOF) THEN

		RESPONSE.WRITE "<script language=""javascript"">" & vbcrlf

		WHILE NOT(RS.EOF)

			RESPONSE.WRITE "mgStartPopup('" & RS("intNum") & "', " & RS("intWidth") & ", " & INT(RS("intHeight") + 30) & ", " & GetTrueFalse(RS("bitScroll")) & ", " & RS("strPopupBox") & ", " & RS("intPosX") & ", " & RS("intPosY") & ", " & GetTrueFalse(RS("bitPosC")) & ", " & RS("strPosition") & ", '" & httpPath & "');" & vbcrlf


		RS.MOVENEXT
		WEND

		RESPONSE.WRITE "</script>"

	END IF

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_POPUP] '3', '', '', '" & strDate & "', '', '1' ")

	IF NOT(RS.EOF) THEN

		RESPONSE.WRITE "<script language=""javascript"">" & vbcrlf

		WHILE NOT(RS.EOF)

			RESPONSE.WRITE "mgStartLayerPopup('" & RS("intNum") & "', " & RS("intWidth") & ", " & INT(RS("intHeight") + 30) & ", " & GetTrueFalse(RS("bitScroll")) & ", " & RS("strPopupBox") & ", " & RS("intPosX") & ", " & RS("intPosY") & ", " & GetTrueFalse(RS("bitPosC")) & ", " & RS("strPosition") & ", " & GetTrueFalse(RS("bitLayerLine")) & ",'" & RS("strLayerLineColor") & "','" & RS("strLayerAni") & "', '" & httpPath & "');" & vbcrlf

		RS.MOVENEXT
		WEND

		RESPONSE.WRITE "</script>"

	END IF
%>