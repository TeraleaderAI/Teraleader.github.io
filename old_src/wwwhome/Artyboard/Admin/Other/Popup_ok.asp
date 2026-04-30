<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Other/PopupList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM Action, strMsg
	DIM strStartDate, strEndDate, intPosX, intPosY, bitPosC, strPosition, intWidth, intHeight, strPopupBox, bitLayerLine
	DIM strLayerLineColor, strLayerAni, bitScroll, strSubject, strContent, bitUsage, intVisit, dateRegDate

	Action = UCASE(REQUEST.QueryString("Action"))

	SELECT CASE Action
	CASE "ADD", "EDIT"

		WITH REQUEST

			strStartDate      = GetReplaceInput(.FORM("strStartDate")(1),"") & GetReplaceInput(.FORM("strStartDate")(2),"") & GetReplaceInput(.FORM("strStartDate")(3),"")
			strEndDate        = GetReplaceInput(.FORM("strEndDate")(1),"") & GetReplaceInput(.FORM("strEndDate")(2),"") & GetReplaceInput(.FORM("strEndDate")(3),"")
			intPosX           = .FORM("intPosX")
			intPosY           = .FORM("intPosY")
			bitPosC           = .FORM("bitPosC")       : IF bitPosC      = "" THEN bitPosC      = "0"
			strPosition       = GetReplaceInput(.FORM("strPosition"),"")   : IF strPosition  = "" THEN strPosition  = "0"
			intWidth          = .FORM("intWidth")
			intHeight         = .FORM("intHeight")
			strPopupBox       = GetReplaceInput(.FORM("strPopupBox"),"")
			bitLayerLine      = .FORM("bitLayerLine")  : IF bitLayerLine = "" THEN bitLayerLine = "0"
			strLayerLineColor = GetReplaceInput(.FORM("strLayerLineColor"),"")
			strLayerAni       = GetReplaceInput(.FORM("strLayerAni"),"")   : IF strLayerAni  = "" THEN strLayerAni  = "right"
			bitScroll         = .FORM("bitScroll")
			strSubject        = GetReplaceInput(.FORM("strSubject"), "")
			strContent        = GetReplaceInput(.FORM("strContent"), "")
			bitUsage          = .FORM("bitUsage")

		END WITH

	END SELECT

	SELECT CASE Action
	CASE "ADD"

		DBCON.EXECUTE("INSERT INTO [MPLUS_POPUP] ([strStartDate], [strEndDate], [intPosX], [intPosY], [bitPosC], [strPosition], [intWidth], [intHeight], [strPopupBox], [bitLayerLine], [strLayerLineColor], [strLayerAni], [bitScroll], [strSubject], [strContent], [bitUsage]) VALUES ('" & strStartDate & "', '" & strEndDate & "', '" & intPosX & "', '" & intPosY & "', '" & bitPosC & "', '" & strPosition & "', '" & intWidth & "', '" & intHeight & "', '" & strPopupBox & "', '" & bitLayerLine & "', '" & strLayerLineColor & "', '" & strLayerAni & "', '" & bitScroll & "', '" & strSubject & "', '" & strContent & "', '" & bitUsage & "') ")

		strMsg = "팝업창 등록이 완료되었습니다."

	CASE "EDIT"

		DBCON.EXECUTE("UPDATE [MPLUS_POPUP] SET [strStartDate] = '" & strStartDate & "', [strEndDate] = '" & strEndDate & "', [intPosX] = '" & intPosX & "', [intPosY] = '" & intPosY & "', [bitPosC] = '" & bitPosC & "', [strPosition] = '" & strPosition & "', [intWidth] = '" & intWidth & "', [intHeight] = '" & intHeight & "', [strPopupBox] = '" & strPopupBox & "', [bitLayerLine] = '" & bitLayerLine & "', [strLayerLineColor] = '" & strLayerLineColor & "', [strLayerAni] = '" & strLayerAni & "', [bitScroll] = '" & bitScroll & "', [strSubject] = '" & strSubject & "', [strContent] = '" & strContent & "', [bitUsage] = '" & bitUsage & "' WHERE [intNum] = '" & REQUEST.QueryString("intNum") & "' ")

		strMsg = "팝업창 수정이 완료되었습니다."

	CASE "REMOVE"

		DBCON.EXECUTE("DELETE FROM [MPLUS_POPUP] WHERE [intNum] = '" & REQUEST.QueryString("intNum") & "' ")

		strMsg = "팝업창 삭제가 완료되었습니다."

	END SELECT

	RESPONSE.WRITE ExecFormSubmit(strMsg, "PopupList.asp", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>