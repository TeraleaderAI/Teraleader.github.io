<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 1
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	RESPONSE.EXPIRES     = 0
	SERVER.SCRIPTTIMEOUT = 2000
%>
<!-- #include file = "../../Include/UploadInclude.asp" -->
<%
	DIM Action, strPath, strFolder
	Action     = UCASE(REQUEST.QueryString("Action"))
	strFolder  = REQUEST.QueryString("strFolder")
	strSetIcon = REQUEST.QueryString("strSetIcon")
	strPath    = rootPath & "Pds\Board\Icon\" & strFolder & "\"

	SELECT CASE Action
	CASE "ADD"

		DIM theField
		SET theField = UPLOAD("uploadFile")(1)

		IF checkImageFileField(setUploadComponet, theField) = True THEN
			CALL ExecFIleUpload(setUploadComponet, theField, 1048576, strPath, "", False, "", False, 0, 0, False, "0", False, "0", "")
		ELSE
			RESPONSE.WRITE ExecJavaAlert("이미지 파일만 업로드가 가능합니다.", 0)
			RESPONSE.End()
		END IF

		RESPONSE.WRITE ExecFormSubmit("등록되었습니다.", "BoardListIcon.asp?strFolder=" & strFolder & "&strSetIcon=" & strSetIcon, "")
		RESPONSE.End()

	CASE "REMOVE"

		DIM I
		FOR I = 0 TO UPLOAD("strFileName").COUNT
			CALL ExecFileDelete(strPath, UPLOAD("strFileName")(I))
		NEXT

		RESPONSE.WRITE ExecFormSubmit("삭제되었습니다.", "BoardListIcon.asp?strFolder=" & strFolder & "&strSetIcon=" & strSetIcon, "")
		RESPONSE.End()

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>