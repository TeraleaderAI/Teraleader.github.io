<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Member/MemberMemoList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM Action, strLoginID, strGroup, strMailingGroup, strMemberList, strContent, SQL, tempMemoID

	Action = UCASE(REQUEST.QueryString("Action"))

	SELECT CASE Action
	CASE "SEND"

		WITH REQUEST
	
			strLoginID      = .FORM("strLoginID")
			strGroup        = .FORM("strGroup")
			strMailingGroup = .FORM("strMailingGroup")
			strMemberList   = GetReplaceInput(.FORM("strMemberList"), "")
			strContent      = GetReplaceInput(.FORM("strContent"), "")
	
		END WITH

		SQL = "INSERT INTO [MPLUS_MEMO_ADMIN_SEND] ([strGroup], [strMailingGroup], [strMemberID], [strContent], [intMember] VALUES () "
	
		IF strGroup <> "" THEN
	
			FOR I = 1 TO REQUEST.FORM("strGroup").COUNT
	
				SET RS = DBCON.EXECUTE("SELECT [strLoginID] FROM [MPLUS_MEMBER_LIST] WHERE [strGroup] = '" & REQUEST.FORM("strGroup")(I) & "' AND [bitAuth] = '1' AND [bitSecession] = '0' ")
	
				WHILE NOT(RS.EOF)
	
					IF tempMemoID <> "" THEN tempMemoID = tempMemoID & ","
					tempMemoID = tempMemoID & RS("strLoginID")
	
				RS.MOVENEXT
				WEND
	
			NEXT
	
		END IF
	
		IF strMailingGroup <> "" THEN
	
			FOR I = 1 TO REQUEST.FORM("strMailingGroup").COUNT
	
				SET RS = DBCON.EXECUTE("SELECT [strLoginID] FROM [MPLUS_MEMBER_LIST] WHERE [bitAuth] = '1' AND [bitSecession] = '0' AND [strLoginID] IN (SELECT [strLoginID] FROM [MPLUS_MEMBER_MAILING_MEMBER] WHERE [strGroup] = '" & REQUEST.FORM("strMailingGroup")(I) & "') ")
	
				WHILE NOT(RS.EOF)
	
					IF tempMemoID <> "" THEN tempMemoID = tempMemoID & ","
					tempMemoID = tempMemoID & RS("strLoginID")
	
				RS.MOVENEXT
				WEND
	
			NEXT
	
		END IF
	
		IF strMemberList <> "" THEN
	
			strMemberList = SPLIT(strMemberList, ",")
				
			DIM Query
			Query = " AND [strLoginID] IN ("
	
			FOR I = 0 TO UBOUND(strMemberList)
				IF strMemberList(I) <> "" THEN Query = Query & "'" & TRIM(strMemberList(I)) & "',"
			NEXT
	
			Query = LEFT(Query, LEN(Query) - 1)
			Query = Query & ") "
	
			SET RS = DBCON.EXECUTE("SELECT [strLogiNID] FROM [MPLUS_MEMBER_LIST] WHERE [bitAuth] = '1' AND [bitSecession] = '0' " & Query)
	
			WHILE NOT(RS.EOF)
	
				IF tempMemoID <> "" THEN tempMemoID = tempMemoID & ","
				tempMemoID = tempMemoID & RS("strLoginID")
	
			RS.MOVENEXT
			WEND
	
		END IF

		tempMemoID = SPLIT(tempMemoID, ",")
	
		IF UBOUND(tempMemoID) = 0 THEN
			RESPONSE.WRITE ExecJavaAlert("쪽지를 발송할 회원이 없습니다.", 0)
			RESPONSE.End()
		END IF
	
		DBCON.EXECUTE("INSERT INTO [MPLUS_MEMO_ADMIN_SEND] ([strGroup], [strMailingGroup], [strMemberID], [strContent], [intMember]) VALUES ('" & strGroup & "', '" & strMailingGroup & "', '" & strMemberList & "', '" & strContent & "', '" & UBOUND(tempMemoID) & "') ")
	
		SET RS = DBCON.EXECUTE("SELECT TOP 1 [intNum] FROM [MPLUS_MEMO_ADMIN_SEND] ORDER BY [intNum] DESC ")
	
		DIM intNumAdminSend
		intNumAdminSend = RS("intNum")
	
		FOR I = 0 TO UBOUND(tempMemoID)
	
			DBCON.EXECUTE("INSERT INTO [MPLUS_MEMO] ([strSendID], [strRecvID], [strContent], [intNumAdminSend]) VALUES ('" & strLoginID & "', '" & tempMemoID(I) & "', '" & strContent & "','" & intNumAdminSend & "') ")
	
		NEXT
	
		RESPONSE.WRITE ExecFormSubmit("일괄쪽지 발송이 완료되었습니다.", "MemberMemoList.asp", "")
		RESPONSE.End()

	CASE "REMOVE"

		DBCON.EXECUTE("DELETE FROM [MPLUS_MEMO_ADMIN_SEND] WHERE [intNum] = '" & REQUEST.QueryString("intNum") & "' ")

		RESPONSE.WRITE ExecFormSubmit("일괄쪽지 발송내역이 삭제되었습니다.", "MemberMemoList.asp", "")
		RESPONSE.End()

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>