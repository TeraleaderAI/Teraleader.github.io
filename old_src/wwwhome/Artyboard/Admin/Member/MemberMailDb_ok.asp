<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu  = 2
	isAdminPopup = True
	strAdminPrevUrl = "Member/MemberMailingList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM Action, strMsg, intPage
	DIM intNum, strName, strCompany, strPosition, strClass, strTel, strFax, strMobile, strEmail, strPost, strAddr1, strAddr2
	DIM bitEmail, dateRegDate

	Action  = UCASE(REQUEST.QueryString("Action"))
	intPage = REQUEST.QueryString("intPage")

	IF Action = "ADD" OR Action = "EDIT" THEN

		WITH REQUEST
	
			intNum      = .FORM("intNum")
			strName     = GetReplaceInput(.FORM("strName"), "")
			strCompany  = GetReplaceInput(.FORM("strCompany"), "")
			strPosition = GetReplaceInput(.FORM("strPosition"), "")
			strClass    = GetReplaceInput(.FORM("strClass"), "")
			strTel      = .FORM("strTel")(1) & "-" & .FORM("strTel")(2) & "-" & .FORM("strTel")(3)
			strFax      = .FORM("strFax")(1) & "-" & .FORM("strFax")(2) & "-" & .FORM("strFax")(3)
			strMobile   = .FORM("strMobile")(1) & "-" & .FORM("strMobile")(2) & "-" & .FORM("strMobile")(3)
			strEmail    = GetReplaceInput(.FORM("strEmail"),"")
			strPost     = .FORM("strPost")(1) & "-" & .FORM("strPost")(2)
			strAddr1    = GetReplaceInput(.FORM("strAddr1"),"")
			strAddr2    = GetReplaceInput(.FORM("strAddr2"), "")
			bitEmail    = .FORM("bitEmail")
	
		END WITH

	END IF

	SELECT CASE Action
	CASE "ADD"

		DBCON.EXECUTE("INSERT INTO [MPLUS_MAIL_MEMBER] ([strName], [strCompany], [strPosition], [strClass], [strTel], [strFax], [strMobile], [strEmail], [strPost], [strAddr1], [strAddr2], [bitEmail]) VALUES ('" & strName & "', '" & strCompany & "', '" & strPosition & "', '" & strClass & "', '" & strTel & "', '" & strFax & "', '" & strMobile & "', '" & strEmail & "', '" & strPost & "', '" & strAddr1 & "', '" & strAddr2 & "', '" & bitEmail & "') ")

		strMsg = "정상적으로 등록되었습니다."

	CASE "EDIT"

		DBCON.EXECUTE("UPDATE [MPLUS_MAIL_MEMBER] SET [strName] = '" & strName & "', [strCompany] = '" & strCompany & "', [strPosition] = '" & strPosition & "', [strClass] = '" & strClass & "', [strTel] = '" & strTel & "', [strFax] = '" & strFax & "', [strMobile] = '" & strMobile & "', [strEmail] = '" & strEmail & "', [strPost] = '" & strPost & "', [strAddr1] = '" & strAddr1 & "', [strAddr2] = '" & strAddr2 & "', [bitEmail] = '" & bitEmail & "' WHERE [intNum] = '" & intNum & "' ")

		strMsg = "정상적으로 수정되었습니다."

	CASE "REMOVE"

		DBCON.EXECUTE("DELETE FROM [MPLUS_MAIL_MEMBER] WHERE [intNum] = '" & REQUEST.QueryString("intNum") & "' ")

		strMsg = "정상적으로 삭제되었습니다."

	CASE "SREMOVE"

		DIM I
		FOR I = 1 TO REQUEST.FORM("intNum").COUNT

			DBCON.EXECUTE("DELETE FROM [MPLUS_MAIL_MEMBER] WHERE [intNum] = '" & REQUEST.FORM("intNum")(I) & "' ")

		NEXT

		strMsg = "정상적으로 삭제되었습니다."

	END SELECT

	RESPONSE.WRITE ExecFormSubmit(strMsg, "MemberMailDbList.asp?intPage=" & intPage, "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>