<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Member/MemberSecessionList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM Action, I, J, strMsg, intPage, strLoginID, tempAdmin, strAdmin, strBoardID
	Action     = REQUEST.QueryString("Action")
	intPage    = REQUEST.QueryString("intPage")
	strLoginID = REQUEST.QueryString("strLoginID")
	
	SELECT CASE UCASE(Action)
	CASE "SELECTSECESSION"

		FOR I = 1 TO REQUEST.FORM("strLoginID").COUNT
			DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [bitSecession] = '0', [strSecessionMemo] = NULL, [dateSecessionDate] = NULL WHERE [strLoginID] = '" & REQUEST.FORM("strLoginID")(I) & "' ")
		NEXT

		strMsg = "탈퇴취소가 완료되었습니다."

	CASE "SECESSION"

		DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [bitSecession] = '0', [strSecessionMemo] = NULL, [dateSecessionDate] = NULL WHERE [strLoginID] = '" & strLoginID & "' ")

		strMsg = "탈퇴취소가 완료되었습니다."

	CASE "SELECTREMOVE"

		FOR I = 1 TO REQUEST.FORM("strLoginID").COUNT

			SET RS = DBCON.EXECUTE("SELECT [strPhotoFile], [strNameFile] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & REQUEST.FORM("strLoginID")(I) & "' ")
	
			IF RS("strPhotoFile") <> "" AND ISNULL(RS("strPhotoFile")) = False THEN CALL ExecFileDelete(rootPath & "Pds\Member\Photo\", RS("strPhotoFile"))
	
			IF RS("strNameFile") <> "" AND ISNULL(RS("strNameFile")) = False THEN CALL ExecFileDelete(rootPath & "Pds\Member\Name\", RS("strNameFile"))
	
			DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & REQUEST.FORM("strLoginID")(I) & "' ")
			DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_POINT] WHERE ([strLoginID] = '" & REQUEST.FORM("strLoginID")(I) & "' OR [strRecID] = '" & REQUEST.FORM("strLoginID")(I) & "')" )

			SET RS = DBCON.EXECUTE("SELECT [strBoardID], [strAdmin] FROM [MPLUS_BOARD_CONFIG_DEFAULT] ")

			WHILE NOT(RS.EOF)

				strBoardID = RS("strBoardID")
				tempAdmin = ""
				IF RS("strAdmin") <> "" AND ISNULL(RS("strAdmin")) = False THEN
					strAdmin = SPLIT(RS("strAdmin"), "|")
					FOR J = 0 TO UBOUND(strAdmin)
						IF strAdmin(J) <> "" AND ISNULL(strAdmin(J)) = False THEN
							IF UCASE(REQUEST.FORM("strLoginID")(I)) <> UCASE(strAdmin(J)) THEN
								tempAdmin = tempAdmin & strAdmin(J) & "|"
							END IF
						END IF
					NEXT
				END IF

				DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CONFIG_DEFAULT] SET [strAdmin] = '" & tempAdmin & "' WHERE [strBoardID] = '" & strBoardID & "' ")

			RS.MOVENEXT
			WEND

		NEXT

		strMsg = "회원삭제가 완료되었습니다."

	CASE "REMOVE"

		SET RS = DBCON.EXECUTE("SELECT [strPhotoFile], [strNameFile] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & strLoginID & "' ")

		IF RS("strPhotoFile") <> "" AND ISNULL(RS("strPhotoFile")) = False THEN CALL ExecFileDelete(rootPath & "Pds\Member\Photo\", RS("strPhotoFile"))

		IF RS("strNameFile") <> "" AND ISNULL(RS("strNameFile")) = False THEN CALL ExecFileDelete(rootPath & "Pds\Member\Name\", RS("strNameFile"))

		DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & strLoginID & "' ")
		DBCON.EXECUTE("DELETE FROM [MPLUS_MEMBER_POINT] WHERE ([strLoginID] = '" & strLoginID & "' OR [strRecID] = '" & strLoginID & "')" )

		SET RS = DBCON.EXECUTE("SELECT [strBoardID], [strAdmin] FROM [MPLUS_BOARD_CONFIG_DEFAULT] ")

		WHILE NOT(RS.EOF)

			strBoardID = RS("strBoardID")
			tempAdmin = ""
			IF RS("strAdmin") <> "" AND ISNULL(RS("strAdmin")) = False THEN
				strAdmin = SPLIT(RS("strAdmin"), "|")
				FOR J = 0 TO UBOUND(strAdmin)
					IF strAdmin(J) <> "" AND ISNULL(strAdmin(J)) = False THEN
						IF UCASE(strLoginID) <> UCASE(strAdmin(J)) THEN
							tempAdmin = tempAdmin & strAdmin(J) & "|"
						END IF
					END IF
				NEXT
			END IF

			DBCON.EXECUTE("UPDATE [MPLUS_BOARD_CONFIG_DEFAULT] SET [strAdmin] = '" & tempAdmin & "' WHERE [strBoardID] = '" & strBoardID & "' ")

			RS.MOVENEXT
			WEND

		strMsg = "회원삭제가 완료되었습니다."

	END SELECT

	RESPONSE.WRITE ExecFormSubmit(strMsg, "MemberSecessionList.asp?intPage=" & intPage, "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>