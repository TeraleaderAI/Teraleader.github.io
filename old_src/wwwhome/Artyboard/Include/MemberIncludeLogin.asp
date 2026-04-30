<!-- #include file = "MemberInclude.asp" -->
<%
	DIM intLogOutTime, intLoginPoint, strLoginType, strLoginLinkTarget, strLoginMsg, strLoginScript, strLoginUrl
	DIM strLoginUrlTarget, strLoginErrorMsg1, strLoginErrorMsg2, strLoginErrorScript, strLoginErrorUrl, strLoginErrorUrlTarget
	DIM strLogOutMsg, strLogOutScript, strLogOutUrl, strLogOutUrlTarget, strWidth, strAlign, strSkin, strSkinGroup, skinPath

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_LOGIN] ")

	strSkin         = RS("strSkin")
	strSkinGroup    = RS("strSkinGroup")
	skinPath        = GetSkinPath(strSkin, 1, strSkinGroup, 1) & "/"
	strWidth        = RS("strWidth")
	strAlign        = RS("strAlign")

	SELECT CASE strAlign
	CASE "0" : strAlign = "LEFT"
	CASE "1" : strAlign = "CENTER"
	CASE "2" : strAlign = "RIGHT"
	END SELECT

	intLogOutTime          = RS("intLogOutTime")
	intLoginPoint          = RS("intLoginPoint")
	strLoginType           = RS("strLoginType")
	strLoginLinkTarget     = RS("strLoginLinkTarget")
	strLoginMsg            = RS("strLoginMsg")
	strLoginScript         = RS("strLoginScript")
	strLoginUrl            = RS("strLoginUrl")
	strLoginUrlTarget      = RS("strLoginUrlTarget")
	strLoginErrorMsg1      = RS("strLoginErrorMsg1")
	strLoginErrorMsg2      = RS("strLoginErrorMsg2")
	strLoginErrorScript    = RS("strLoginErrorScript")
	strLoginErrorUrl       = RS("strLoginErrorUrl")
	strLoginErrorUrlTarget = RS("strLoginErrorUrlTarget")
	strLogOutMsg           = RS("strLogOutMsg")
	strLogOutScript        = RS("strLogOutScript")
	strLogOutUrl           = RS("strLogOutUrl")
	strLogOutUrlTarget     = RS("strLogOutUrlTarget")

'	IF strLoginMsg       = "" OR ISNULL(strLoginMsg)       = True THEN strLoginMsg       = "로그인 되었습니다.\n방문을 환영합니다."
'	IF strLogOutMsg      = "" OR ISNULL(strLogOutMsg)      = True THEN strLogOutMsg      = "로그아웃 되었습니다."
	IF strLoginErrorMsg1 = "" OR ISNULL(strLoginErrorMsg1) = True THEN strLoginErrorMsg1 = "등록되어 있지 않은 회원아이디 입니다."
	IF strLoginErrorMsg2 = "" OR ISNULL(strLoginErrorMsg2) = True THEN strLoginErrorMsg2 = "비밀번호를 올바르게 입력해 주시기 바랍니다."

	DIM LOGIN_LINK_TARGET
	LOGIN_LINK_TARGET  = strLoginLinkTarget

	SELECT CASE Action

		CASE "LOGIN"

			IF SESSION("strLoginID") = "" THEN

				DIM LOGIN_SAVE_ID, LOGIN_SAVE_PWD, LOGIN_SAVE_CHECK

				SELECT CASE strLoginType
				CASE "0"
					LOGIN_SAVE_ID    = ""
					LOGIN_SAVE_PWD   = ""
					LOGIN_SAVE_CHECK = False
				CASE "1"
					LOGIN_SAVE_ID    = Base64decode(REQUEST.COOKIES("MPLUS_LOGIN_ID"))
					LOGIN_SAVE_PWD   = ""
					LOGIN_SAVE_CHECK = True
				CASE "2"
					LOGIN_SAVE_ID    = Base64decode(REQUEST.COOKIES("MPLUS_LOGIN_ID"))
					LOGIN_SAVE_PWD   = Base64decode(REQUEST.COOKIES("MPLUS_LOGIN_PWD"))
					LOGIN_SAVE_CHECK = True
				END SELECT

				DIM LOGIN_JOIN_LINK, LOGIN_FIND_ID_LINK, LOGIN_FIND_PW_LINK, LOGIN_PREV_URL
				LOGIN_JOIN_LINK    = "member.asp?Action=join"
				LOGIN_FIND_ID_LINK = "javascript:OnLoginFindID();"
				LOGIN_FIND_PW_LINK = "javascript:OnLoginFindPW();"
				LOGIN_PREV_URL     = Request.ServerVariables("url") & "?" & Replace(Request.ServerVariables("QUERY_STRING"), "&", "--**--" )

			ELSE

				DIM LOGIN_LOGOUT_LINK, LOGIN_MEMBER_EDIT_LINK, LOGIN_ADMIN_LINK
				LOGIN_LOGOUT_LINK      = "javascript:OnLoginLogout();"
				LOGIN_MEMBER_EDIT_LINK = "member.asp?Action=edit"
				LOGIN_ADMIN_LINK       = "Admin/default.asp"

				SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_LOGIN] '" & SESSION("strLoginID") & "', '" & SESSION("strAdmin") & "' ")

				DIM LOGIN_VISIT, LOGIN_POINT, LOGIN_LEVEL, LOGIN_SIGNDATE, LOGIN_PHOTO, LOGIN_COMMENT, LOGIN_BOARD, LOGIN_ADMIN, LOGIN_ID
				DIM LOGIN_NAME, LOGIN_NICK

				LOGIN_ID       = SESSION("strLoginID")
				LOGIN_NAME     = SESSION("strLoginName")
				LOGIN_NICK     = RS("strNick")
				LOGIN_VISIT    = GetMoneyComma(RS("intVisit"))
				LOGIN_POINT    = GetMoneyComma(RS("intPoint"))
				LOGIN_LEVEL    = "Lv. " & RS("intLevel")
				LOGIN_SIGNDATE = RS("dateSignDate")
				LOGIN_PHOTO    = RS("strPhotoFile")
				LOGIN_COMMENT  = GetMoneyComma(RS("intCommentCount"))
				LOGIN_BOARD    = GetMoneyComma(RS("intBoardCount"))
				LOGIN_MEMO     = GetMoneyComma(RS("intMemoCount"))
				LOGIN_NAME_IMG = RS("strNameFile")
				LOGIN_MARK_IMG = RS("strMarkFile")

				IF RS("strAdmin") = "0" THEN LOGIN_ADMIN = False ELSE LOGIN_ADMIN = True

				DIM LOGIN_USE_MEMO, LOGIN_MEMO_SOUND, LOGIN_MEMO_LINK, strFileExt

				LOGIN_MEMO_LINK = "Memo.asp?Action=list"

				SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMO_CONFIG] '" & SESSION("strLoginID") & "' ")

				IF LOGIN_MEMO = 0 THEN
					LOGIN_MEMO_SOUND = False
				ELSE
					IF RS("bitSound") = True THEN
						IF RS("strSoundFile") <> "" AND ISNULL(RS("strSoundFile")) = False THEN
							strFileExt = MID(RS("strSoundFile"), InStrRev(RS("strSoundFile"), "."))
							SELECT CASE UCASE(strFileExt)
							CASE ".SWF"
								LOGIN_MEMO_SOUND = "<script language='javascript'>playflash('Pds/Memo/" & RS("strSoundFile") & "', 0, 0, '#FFFFFF', 'high', 'memoSount');</script>"
							CASE ELSE
								LOGIN_MEMO_SOUND = "<bgsound id='presound' src='Pds/Memo/" & RS("strSoundFile") & "'>"
							END SELECT
						ELSE
							LOGIN_MEMO_SOUND = False
						END IF
					ELSE
						LOGIN_MEMO_SOUND = False
					END IF
				END IF

				IF RS("bitMemoUse") = True THEN
					LOGIN_USE_MEMO = True
				ELSE
					IF INT(RS("intMemoUseLevel")) > INT(RS("intUserLevel")) THEN LOGIN_USE_MEMO = False ELSE LOGIN_USE_MEMO = True
				END IF

				IF LOGIN_USE_MEMO = True THEN
					IF RS("bitMemoRead") = False THEN
						IF INT(RS("intMemoReadLevel")) > INT(RS("intUserLevel")) THEN LOGIN_USE_MEMO = False ELSE LOGIN_USE_MEMO = True
					END IF
				END IF

			END IF

		CASE "LOGIN_OK"

			DIM strLoginID, strLoginPwd, SET_LOGIN_SAVE
			strLoginID     = GetReplaceInput(REQUEST.Form("strLoginID"), "S")
			strLoginPwd    = GetReplaceInput(REQUEST.Form("strLoginPwd"), "S")
			SET_LOGIN_SAVE = GetReplaceInput(REQUEST.Form("SET_LOGIN_SAVE"), "")

			IF SET_LOGIN_SAVE = "" THEN SET_LOGIN_SAVE = "0"

			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_LOGIN_EXEC] '" & strLoginID & "', '', '', '0' ")

			IF RS.EOF THEN

				IF strLoginErrorScript <> "" AND ISNULL(strLoginErrorScript) = False THEN
					RESPONSE.WRITE ExecJavaScript(strLoginErrorScript)
				END IF

				IF strLoginErrorUrl <> "" AND ISNULL(strLoginErrorUrl) = False THEN
					RESPONSE.WRITE ExecFormSubmit(strLoginErrorMsg1, strLoginErrorUrl, strLoginErrorUrlTarget)
					RESPONSE.End()
				ELSE
					RESPONSE.WRITE ExecJavaAlert(strLoginErrorMsg1, 0)
					RESPONSE.End()
				END IF

			ELSE

				IF strLoginPwd = RS("strLoginPwd") THEN

					IF RS("bitAuth") = False THEN
						RESPONSE.WRITE ExecJavaAlert("승인되지 않은 회원아이디 입니다.", 0)
						RESPONSE.End()
					END IF
	
					IF RS("bitSecession") = True THEN
						RESPONSE.WRITE ExecJavaAlert("탈퇴처리된 회원 아이디 입니다.", 0)
						RESPONSE.End()
					END IF

					SESSION("strLoginID")   = LCASE(strLoginID)
					SESSION("strLoginName") = RS("strLoginName")
					SESSION("strAdmin")     = RS("strAdmin")

					IF intLoginPoint <> 0 THEN
						SET RS = DBCON.EXECUTE("SELECT [strLoginID] FROM [MPLUS_MEMBER_LIST] WHERE [strLoginID] = '" & strLoginID & "' AND DATEDIFF(second, [dateSignDate], getdate()) >= 86400 ")

						IF NOT(RS.EOF) THEN DBCON.EXECUTE("EXEC [MPLUS_PUT_MEMBER_POINT] '0', '', '', '', '" & strLoginID & "', '', '', 'M003', " & intLoginPoint & ", '로그인시 지급한 포인트' ")
					END IF

					DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [intVisit] = [intVisit] + 1, [dateSignDate] = getdate(), [strSignIP] = '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "' WHERE [strLoginID] = '" & strLoginID & "' ")

					SET RS = DBCON.EXECUTE("SELECT [bitPointLevel] FROM [MPLUS_MEMBER_CONFIG_LOGIN] ")

					IF RS("bitPointLevel") = True THEN

						SET RS = DBCON.EXECUTE("SELECT [strGroupCode], [intStartPoint], [intEndPoint] FROM [MPLUS_MEMBER_POINT_LEVEL] ")
				
						WHILE NOT(RS.EOF)
				
							DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strGroup] = '" & RS("strGroupCode") & "' WHERE [intPoint] >=" & RS("intStartPoint") & " AND [intPoint] <=" & RS("intEndPoint") & " AND [strLoginID] = '" & SESSION("strLoginID") & "' ")
				
						RS.MOVENEXT
						WEND

					END IF

					SELECT CASE SET_LOGIN_SAVE
					CASE "0"
						RESPONSE.COOKIES("MPLUS_LOGIN_ID") = ""
						RESPONSE.COOKIES("MPLUS_LOGIN_ID").EXPIRES = DATE + 30
						RESPONSE.COOKIES("MPLUS_LOGIN_PWD") = ""
						RESPONSE.COOKIES("MPLUS_LOGIN_PWD").EXPIRES = DATE + 30
					CASE "1"
						RESPONSE.COOKIES("MPLUS_LOGIN_ID") = Base64encode(strLoginID)
						RESPONSE.COOKIES("MPLUS_LOGIN_ID").EXPIRES = DATE + 30
						RESPONSE.COOKIES("MPLUS_LOGIN_PWD") = ""
						RESPONSE.COOKIES("MPLUS_LOGIN_PWD").EXPIRES = DATE + 30
					CASE "2"
						RESPONSE.COOKIES("MPLUS_LOGIN_ID") = Base64encode(strLoginID)
						RESPONSE.COOKIES("MPLUS_LOGIN_ID").EXPIRES = DATE + 30
						RESPONSE.COOKIES("MPLUS_LOGIN_PWD") = Base64encode(strLoginPwd)
						RESPONSE.COOKIES("MPLUS_LOGIN_PWD").EXPIRES = DATE + 30

					END SELECT

					IF strLoginScript <> "" AND ISNULL(strLoginScript) = False THEN
						RESPONSE.WRITE ExecJavaScript(strLoginScript)
						RESPONSE.End()
					END IF

					IF REQUEST.FORM("strPrevUrl") = "" THEN
						IF strLoginUrl = "" OR ISNULL(strLoginUrl) = True THEN strLoginUrl = "Member.asp?Action=login"
					ELSE
						strLoginUrl = REPLACE(REPLACE(REQUEST.FORM("strPrevUrl"), "'", ""), "--**--", "&")
					END IF

					RESPONSE.WRITE ExecFormSubmit(strLoginMsg, strLoginUrl, strLoginUrlTarget)
					RESPONSE.End()

				ELSE
					IF strLoginErrorScript <> "" AND ISNULL(strLoginErrorScript) = False THEN
						RESPONSE.WRITE ExecJavaScript(strLoginErrorScript)
					END IF
					IF strLoginErrorUrl <> "" AND ISNULL(strLoginErrorUrl) = False THEN
						RESPONSE.WRITE ExecFormSubmit(strLoginErrorMsg2, strLoginErrorUrl, strLoginErrorUrlTarget)
						RESPONSE.End()
					ELSE
						RESPONSE.WRITE ExecJavaAlert(strLoginErrorMsg2, 0)
						RESPONSE.End()
					END IF
				END IF
			END IF

		CASE "LOGOUT"

			SESSION("strLoginID")     = ""
			SESSION("strLoginName")   = ""
			SESSION("strAdmin")       = ""
			SESSION("strSecretBoard") = ""

			IF strLogOutScript <> "" AND ISNULL(strLogOutScript) = False THEN
				RESPONSE.WRITE ExecJavaScript(strLogOutScript)
			END IF
	
			IF strLogOutUrl <> "" AND ISNULL(strLogOutUrl) = False THEN
				RESPONSE.WRITE ExecFormSubmit(strLogOutMsg, strLogOutUrl, strLogOutUrlTarget)
				RESPONSE.End()
			ELSE
				RESPONSE.WRITE ExecFormSubmit(strLogOutMsg, "member.asp?Action=login", "")
				RESPONSE.End()
			END IF

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
	SESSION.Timeout = intLogOutTime
%>