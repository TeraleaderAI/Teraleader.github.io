<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Member/MemberMailingSend.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM intNum, strName, strMail, strSubject, strContent, strContentBg, strGroupList, strMailGroupList, strMemberList, strEtcEmail
	DIM Action, bitMemberDB

	intNum = REQUEST.QueryString("intNum")
	Action = REQUEST.QueryString("Action")

	WITH REQUEST
	
		strName          = GetReplaceInput(.FORM("strName"), "")
		strMail          = .FORM("strMail")
		strSubject       = GetReplaceInput(.FORM("strSubject"), "")
		strContent       = GetReplaceInput(.FORM("strContent"), "")
		strGroupList     = GetReplaceInput(.FORM("strGroupList"),"")
		strMailGroupList = GetReplaceInput(.FORM("strMailGroupList"),"")
		strMemberList    = GetReplaceInput(.FORM("strMemberList"),"")
		strEtcEmail      = GetReplaceInput(.FORM("strEtcEmail"),"")
		strContentBg     = GetReplaceInput(.FORM("strContentBg"),"")
		bitMemberDB      = GetReplaceInput(.FORM("bitMemberDB"),"")

	END WITH

	DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_MAIL] SET [strName] = '" & strName & "', [strMail] = '" & strMail & "', [strSubject] = '" & strSubject & "', [strContent] = '" & strContent & "', [strContentBg] = '" & strContentBg & "', [bitSendOk] = '1', [dateSendDate] = getdate() WHERE [intNum] = '" & intNum & "' ")

	IF strGroupList <> "" THEN

		FOR I = 1 TO REQUEST.FORM("strGroupList").COUNT

			DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_MAILING] ([strName], [strEmail]) SELECT [strLoginName], [strEmail] FROM [MPLUS_MEMBER_LIST] WHERE [strGroup] = '" & REQUEST.FORM("strGroupList")(I) & "' AND [bitMailing] = '1' ")

		NEXT

	END IF

	IF strMailGroupList <> "" THEN

		FOR I = 1 TO REQUEST.FORM("strMailGroupList").COUNT

			DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_MAILING] ([strName], [strEmail]) SELECT [strLoginName], [strEmail] FROM [MPLUS_MEMBER_LIST] WHERE [bitMailing] = '1' AND [strLoginID] IN (SELECT [strLoginID] FROM [MPLUS_MEMBER_MAILING_MEMBER] WHERE [strGroup] = '" & REQUEST.FORM("strMailGroupList")(I) & "') ")

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

		DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_MAILING] ([strName], [strEmail]) SELECT [strLoginName], [strEmail] FROM [MPLUS_MEMBER_LIST] WHERE [bitMailing] = '1' " & Query)

	END IF

	IF strEtcEmail <> "" THEN

		strEtcEmail = SPLIT(strEtcEmail, ",")

		FOR I = 0 TO UBOUND(strMemberList)
			IF strEtcEmail(I) <> "" THEN DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_MAILING] ([strName], [strEmail]) VALUES ('이름없음','" & TRIM(strEtcEmail(I)) & "') ")
		NEXT

	END IF

	IF bitMemberDB = "1" THEN DBCON.EXECUTE("INSERT INTO [MPLUS_MEMBER_MAILING] ([strName], [strEmail]) SELECT [strName], [strEmail] FROM [MPLUS_MAIL_MEMBER] WHERE [bitEmail] = '1' ")

	SET RS = DBCON.EXECUTE("SELECT [strName], [strEmail] FROM [MPLUS_MEMBER_MAILING] ")

	WHILE NOT(RS.EOF)

		CALL sendEmail(strName, strMail, RS("strName"), RS("strEmail"), GetReplaceTag2Html(strSubject), GetReplaceTag2Html(strContent), "", "", "", "")
	
	RS.MOVENEXT
	WEND

	DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_MAILING] ")

	RESPONSE.WRITE ExecFormSubmit("메일링 발송이 완료되었습니다.", "MemberMailingList.asp", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>