<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM setType
	DIM strColorVisited, strColorLink, strUserCss, strHeadFile, strTailFile, strHeadText, strTailText

	setType = REQUEST.QueryString("setType")

	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu = 2
	IF setType = "0" THEN isAdminPopup = False ELSE isAdminPopup = True
	strAdminPrevUrl = "Member/MemberJoinItemConfig.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%

	SELECT CASE setType
	CASE "0"
		DIM vPidList, I
		vPidList = SPLIT(REQUEST.Form("vPidList"), "|")
		FOR I = 0 TO UBOUND(vPidList)
			IF vPidList(I) <> "" THEN DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_CONFIG_JOIN_ITEM] SET [intStep] = '" & I + 1 & "' WHERE [strItem] = '" & vPidList(I) & "' ")
		NEXT

		RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "MemberJoinItemConfig.asp", "")
		RESPONSE.End()

	CASE "1"

		DIM strItem, strItemName, strItemMemo, bitUse, bitRequire, strFormType, txtDefaultItem, intMaxLength, intLength
		
		WITH REQUEST

			strItem        = GetReplaceInput(.FORM("strItem"), "")
			strItemName    = GetReplaceInput(.FORM("strItemName"), "")
			strItemMemo    = GetReplaceInput(.FORM("strItemMemo"), "")
			bitUse         = .FORM("bitUse")
			bitRequire     = .FORM("bitRequire")
			strFormType    = GetReplaceInput(.FORM("strFormType"), "")
			txtDefaultItem = GetReplaceInput(.FORM("txtDefaultItem"), "")
			intMaxLength   = .FORM("intMaxLength")
			intLength      = .FORM("intLength")

		END WITH

		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_CONFIG_JOIN_ITEM] SET [strItemName] = '" & strItemName & "', [strItemMemo] = '" & strItemMemo & "', [bitUse] = '" & bitUse & "', [bitRequire] = '" & bitRequire & "', [strFormType] = '" & strFormType & "', [txtDefaultItem] = '" & txtDefaultItem & "', [intMaxLength] = '" & intMaxLength & "', [intLength] = '" & intLength & "' WHERE [strItem] = '" & strItem & "' ")

		RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "MemberJoinItemList.asp?setStrItem=" & strItem, "")
		RESPONSE.End()

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>