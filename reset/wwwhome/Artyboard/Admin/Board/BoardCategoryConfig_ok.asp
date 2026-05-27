<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM Action, strBoardID, intCategory, nowStep, strCategory, RecCount
	Action      = REQUEST.QueryString("Action")
	intCategory = REQUEST.QueryString("intCategory")
	nowStep     = REQUEST.QueryString("nowStep") - 1

	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 1
	SELECT CASE UCASE(Action)
	CASE "ADD", "EDIT", "MOVE"
		isAdminPopup = True
	CASE ELSE
		isAdminPopup = False
	END SELECT
	strAdminPrevUrl = "Board/BoardList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	IF UCASE(Action) = "ADD" OR UCASE(Action) = "EDIT" THEN
%>
<!-- #include file = "../../Include/UploadInclude.asp" -->
<%
		strBoardID  = UPLOAD("strBoardID")
		strCategory = GetReplaceInput(UPLOAD("strCategory"), "")

		DIM theField1, theField2, strPath
		SET theField1 = UPLOAD("strFileName1")(1)
		SET theField2 = UPLOAD("strFileName2")(1)

		CALL ExecFolderMake(rootPath & "Pds\Board\" & strBoardID & "\Category")

		strPath = rootPath & "Pds\Board\" & strBoardID & "\Category\"

		DIM strFileName1, strFileName2
	
		IF checkImageFileField(setUploadComponet, theField1) = True THEN
			strFileName1 = ExecFIleUpload(setUploadComponet, theField1, 1048576, strPath, "", False, "", False, 0, 0, False, "0", False, "0", "")
			IF UCASE(Action) = "EDIT" AND strFileName1 <> False THEN
				SET RS = DBCON.EXECUTE("SELECT [strFileName1] FROM [MPLUS_BOARD_CATEGORY] WHERE [strBoardiD] = '" & strBoardID & "' AND [intCategory] = '" & intCategory & "' ")
				IF RS("strFileName1") <> "" AND ISNULL(RS("strFileName1")) = False THEN CALL ExecFileDelete(strPath, RS("strFileName1"))
				DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [strFileName1] = '" & strFileName1 & "' WHERE [strBoardID] = '" & strBoardID & "' AND [intCategory] = '" & intCategory & "' ")
			END IF
		END IF

		IF checkImageFileField(setUploadComponet, theField2) = True THEN
			strFileName2 = ExecFIleUpload(setUploadComponet, theField2, 1048576, strPath, "", False, "", False, 0, 0, False, "0", False, "0", "")
			IF UCASE(Action) = "EDIT" AND strFileName2 <> False THEN
				SET RS = DBCON.EXECUTE("SELECT [strFileName2] FROM [MPLUS_BOARD_CATEGORY] WHERE [strBoardiD] = '" & strBoardID & "' AND [intCategory] = '" & intCategory & "' ")
				IF RS("strFileName2") <> "" AND ISNULL(RS("strFileName2")) = False THEN CALL ExecFileDelete(strPath, RS("strFileName2"))
				DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [strFileName2] = '" & strFileName2 & "' WHERE [strBoardID] = '" & strBoardID & "' AND [intCategory] = '" & intCategory & "' ")
			END IF
		END IF

		IF strFileName1 = False THEN strFileName1 = ""
		IF strFileName2 = False THEN strFileName2 = ""

		SELECT CASE UCASE(Action)
		CASE "ADD"

			SET RS = DBCON.EXECUTE("SELECT MAX([intCategory]) AS [maxIntCategory], MAX([intStep]) AS [maxIntStep] FROM [MPLUS_BOARD_CATEGORY] WHERE [strBoardID] = '" & strBoardID & "' ")
	
			DIM maxIntCategory, maxIntStep
			maxIntCategory = RS("maxIntCategory") + 1
			maxIntStep     = RS("maxIntStep")     + 1
	
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_CATEGORY] ([strBoardID], [intCategory], [strCategory], [intCategoryCount], [intStep], [strFileName1], [strFileName2]) VALUES ('" & strBoardID & "', '" & maxIntCategory & "', '" & strCategory & "', '0', '" & maxIntStep & "', '" & strFileName1 & "', '" & strFileName2 & "') ")
	
			RESPONSE.WRITE ExecJavaAlertLayer("정상적으로 적용되었습니다.", "BoardCategoryConfig.asp?strBoardID=" & strBoardID)
			RESPONSE.End()

		CASE "EDIT"

			DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [strCategory] = '" & strCategory & "' WHERE [strBoardiD] = '" & strBoardID & "' AND [intCategory] = '" & intCategory & "' ")
	
			RESPONSE.WRITE ExecJavaAlertLayer("정상적으로 적용되었습니다.", "BoardCategoryConfig.asp?strBoardID=" & strBoardID)
			RESPONSE.End()

		END SELECT

	ELSE

		strBoardID  = REQUEST.FORM("strBoardID")
		strCategory = GetReplaceInput(REQUEST.FORM("strCategory"), "")

		SELECT CASE UCASE(Action)
		CASE "MOVEUP"
	
			DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [intStep] = [intStep] + 1 WHERE [strBoardID] = '" & strBoardID & "' AND [intStep] = '" & nowStep - 1 & "' ")
			DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [intStep] = [intStep] - 1 WHERE [strBoardID] = '" & strBoardID & "' AND [intCategory] = '" & intCategory & "' ")
	
		CASE "MOVEDOWN"
	
			DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [intStep] = [intStep] - 1 WHERE [strBoardID] = '" & strBoardID & "' AND [intStep] = '" & nowStep + 1 & "' ")
			DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [intStep] = [intStep] + 1 WHERE [strBoardID] = '" & strBoardID & "' AND [intCategory] = '" & intCategory & "' ")
	
		CASE "MOVE"
		
			DIM exIntCategory
			exIntCategory = REQUEST.FORM("exIntCategory")
			
			DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [intCategory] = '" & exIntCategory & "' WHERE [strBoardID] = '" & strBoardID & "' AND [intCategory] = '" & intCategory & "' AND [bitDelete] = '0' ")
	
			DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [intCategoryCount] = (SELECT COUNT([intCategory]) FROM [MPLUS_BOARD] WHERE [bitDelete] = '0' AND [strBoardID] = [MPLUS_BOARD_CATEGORY].[strBoardID] AND [intCategory] = [MPLUS_BOARD_CATEGORY].[intCategory]) WHERE [strBoardID] = '" & strBoardID & "' ")
	
			RESPONSE.WRITE ExecJavaAlertLayer("카테고리 이동이 완료되었습니다.", "BoardCategoryConfig.asp?strBoardID=" & strBoardID)
			RESPONSE.End()
	
		CASE "REMOVE"
	
			DBCON.EXECUTE("DELETE FROM [MPLUS_BOARD_CATEGORY] WHERE [strBoardID] = '" & strBoardID & "' AND [intCategory] = '" & intCategory & "' ")
	
			DBCON.EXECUTE("UPDATE [MPLUS_BOARD] SET [intCategory] = '0' WHERE [strBoardID] = '" & strBoardID & "' AND [intCategory] = '" & intCategory & "' ")
	
			DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [intStep] = [intStep] - 1 WHERE [strBoardID] = '" & strBoardID & "' AND [intStep] > " & REQUEST.QueryString("intStep"))
	
			DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [intCategoryCount] = (SELECT COUNT([intCategory]) FROM [MPLUS_BOARD] WHERE [bitDelete] = '0' AND [strBoardID] = [MPLUS_BOARD_CATEGORY].[strBoardID] AND [intCategory] = [MPLUS_BOARD_CATEGORY].[intCategory]) WHERE [strBoardID] = '" & strBoardID & "' ")
	
		CASE "USECATEGORY"
		
			DIM bitUseCategory
			bitUseCategory = REQUEST.FORM("bitUseCategory")
			IF bitUseCategory = "" THEN bitUseCategory = "0"
			
			DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CONFIG_DEFAULT] SET [bitUseCategory] = '" & bitUseCategory & "' WHERE [strBoardID] = '" & strBoardID& "' ")
	
		CASE "IMGREMOVE"

			SET RS = DBCON.EXECUTE("SELECT [strFIleName1], [strFileName2] FROM [MPLUS_BOARD_CATEGORY] WHERE [strBoardID] = '" & REQUEST.QueryString("strBoardID") & "' AND [intCategory] = '" & REQUEST.QueryString("intCategory") & "' ")

			SELECT CASE REQUEST.QueryString("intFile")
			CASE "1"
				CALL ExecFileDelete(rootPath & "Pds\Board\" & REQUEST.QueryString("strBoardID") & "\Category\", RS("strFileName1"))
				DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [strFileName1] = '' WHERE [strBoardID] = '" & REQUEST.QueryString("strBoardID") & "' AND [intCategory] = '" & REQUEST.QueryString("intCategory") & "' ")
			CASE "2"
				CALL ExecFileDelete(rootPath & "Pds\Board\" & REQUEST.QueryString("strBoardID") & "\Category\", RS("strFileName2"))
				DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CATEGORY] SET [strFileName2] = '' WHERE [strBoardID] = '" & REQUEST.QueryString("strBoardID") & "' AND [intCategory] = '" & REQUEST.QueryString("intCategory") & "' ")
			END SELECT

			RESPONSE.WRITE ExecFormSubmit("이미지 삭제가 완료되었습니다.", "BoardCategoryAdd.asp?Action=edit&intCategory=" & REQUEST.QueryString("intCategory") & "&strBoardID=" & REQUEST.QueryString("strBoardID"), "")
			RESPONSE.End()

		END SELECT

		RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "BoardCategoryConfig.asp?strBoardID=" & strBoardID, "")
		RESPONSE.End()

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>