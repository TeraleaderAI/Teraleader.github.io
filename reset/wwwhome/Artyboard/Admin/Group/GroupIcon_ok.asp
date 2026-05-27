<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Group/GroupList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	RESPONSE.EXPIRES     = 0
	SERVER.SCRIPTTIMEOUT = 2000
%>
<!-- #include file = "../../Include/UploadInclude.asp" -->
<%
	DIM Action, strPath
	Action  = UCASE(REQUEST.QueryString("Action"))
	strPath = rootPath & "Pds\Member\GroupIcon\"

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

		RESPONSE.WRITE ExecFormSubmit("등록되었습니다.", "GroupIcon.asp", "")
		RESPONSE.End()

	CASE "REMOVE"

		DIM I
		FOR I = 0 TO UPLOAD("strFileName").COUNT
			CALL ExecFileDelete(strPath, UPLOAD("strFileName")(I))
		NEXT

		RESPONSE.WRITE ExecFormSubmit("삭제되었습니다.", "GroupIcon.asp", "")
		RESPONSE.End()

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>