<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Group/GroupList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	RESPONSE.EXPIRES     = 0
	SERVER.SCRIPTTIMEOUT = 2000

	DIM Action, strGroupCode, strGroupName, strGroupMemo, intLevel, intDefaultPoint, strAvata
	Action = UCASE(REQUEST.QueryString("Action"))

	WITH REQUEST

		strGroupCode    = GetReplaceInput(.FORM("strGroupCode"), "")
		strGroupName    = GetReplaceInput(.FORM("strGroupName"), "")
		strGroupMemo    = GetReplaceInput(.FORM("strGroupMemo"), "")
		intDefaultPoint = .FORM("intDefaultPoint")
		IF intDefaultPoint = "" THEN intDefaultPoint = 0
		strAvata        = GetReplaceInput(.FORM("strAvata"),"")
		intLevel        = .FORM("intLevel") + 1
	
	END WITH

	SELECT CASE Action
	CASE "ADD"

		DBCON.EXECUTE("INSERT INTO [MPLUS_GROUP] ([strGroupCode], [strGroupName], [strGroupMemo], [intLevel], [intDefaultPoint], [strAvata]) VALUES ('" & strGroupCode & "', '" & strGroupName & "', '" & strGroupMemo & "', '" & intLevel & "', " & intDefaultPoint & ", '" & strAvata & "') ")

		DBCON.EXECUTE("UPDATE [MPLUS_GROUP] SET [intLevel] = [intLevel] + 1 WHERE [intLevel] >= " & intLevel & " AND [strGroupCode] != '" & strGroupCode & "' ")

		RESPONSE.WRITE ExecFormSubmit("신규그룹 등록이 완료되었습니다.", "GroupList.asp", "")
		RESPONSE.End()
		
	CASE "EDIT"

		DBCON.EXECUTE("UPDATE [MPLUS_GROUP] SET [strGroupName] = '" & strGroupName & "', [strGroupMemo] = '" & strGroupMemo & "', [intDefaultPoint] = " & intDefaultPoint & ", [strAvata] = '" & strAvata & "' WHERE [strGroupCode] = '" & strGroupCode & "' ")

		RESPONSE.WRITE ExecFormSubmit("그룹 수정이 완료되었습니다.", "GroupList.asp", "")
		RESPONSE.End()

	CASE "REMOVE"

		DBCON.EXECUTE("UPDATE [MPLUS_GROUP] SET [intLevel] = [intLevel] - 1 WHERE [intLevel] > (SELECT [intLevel] FROM [MPLUS_GROUP] WHERE [strGroupCode] = '" & REQUEST.QueryString("strGroupCode") & "') ")
		DBCON.EXECUTE("DELETE FROM [MPLUS_GROUP] WHERE [strGroupCode] = '" & REQUEST.QueryString("strGroupCode") & "' ")
		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strGroup] = 'G000' WHERE [strGroup] = '" & REQUEST.QueryString("strGroupCode") & "' ")

		RESPONSE.WRITE ExecFormSubmit("그룹 삭제가 완료되었습니다.", "GroupList.asp", "")
		RESPONSE.End()

	CASE "STEP"

		DIM newGroupCode
	
		strGroupCode = REQUEST.QueryString("strGroupCode")

		SELECT CASE REQUEST.QueryString("strStep")
		CASE "d"

			SET RS = DBCON.EXECUTE("SELECT TOP 1 [strGroupCode] FROM [MPLUS_GROUP] WHERE [intLevel] > (SELECT [intLevel] FROM [MPLUS_GROUP] WHERE [strGroupCode] = '" & strGroupCode & "') ORDER BY [intLevel] ASC ")
			newGroupCode = RS("strGroupCode")
			
			DBCON.EXECUTE("UPDATE [MPLUS_GROUP] SET [intLevel] = [intLevel] - 1 WHERE [strGroupCode] = '" & newGroupCode & "' ")
			DBCON.EXECUTE("UPDATE [MPLUS_GROUP] SET [intLevel] = [intLevel] + 1 WHERE [strGroupCode] = '" & strGroupCode & "' ")

		CASE "u"

			SET RS = DBCON.EXECUTE("SELECT TOP 1 [strGroupCode] FROM [MPLUS_GROUP] WHERE [intLevel] < (SELECT [intLevel] FROM [MPLUS_GROUP] WHERE [strGroupCode] = '" & strGroupCode & "') ORDER BY [intLevel] DESC ")
			newGroupCode = RS("strGroupCode")
			
			DBCON.EXECUTE("UPDATE [MPLUS_GROUP] SET [intLevel] = [intLevel] + 1 WHERE [strGroupCode] = '" & newGroupCode & "' ")
			DBCON.EXECUTE("UPDATE [MPLUS_GROUP] SET [intLevel] = [intLevel] - 1 WHERE [strGroupCode] = '" & strGroupCode & "' ")

		END SELECT

		RESPONSE.WRITE ExecFormSubmit("", "GroupList.asp", "")
		RESPONSE.End()

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>