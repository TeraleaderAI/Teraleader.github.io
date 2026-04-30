<!--METADATA TYPE="typelib" NAME="ADODB Type Library" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"-->
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM Action
	Action = UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S"))

	IF SESSION("strLoginID") = "" THEN
		IF Action = "WRITE" THEN
			RESPONSE.WRITE ExecJavaAlert("로그인 후 이용하실 수 있습니다.", 1)
			RESPONSE.End()
		ELSE
			RESPONSE.WRITE ExecJavaAlert("로그인 후 이용하실 수 있습니다.", 0)
			RESPONSE.End()
		END IF
	END IF

	DIM strWidth, strAlign, strSkin, strSkinGroup, skinPath, bitUsage, bitSound, strSoundFile, intMemoTime, intMemoSaveCount
	DIM intPageCount, bitMemoUse, intMemoUseLevel, bitMemoSend, intMemoSendLevel, bitMemoRead, intMemoReadLevel, strErrorUrl
	DIM strErrorUrlTarget, strErrorMsg, intUserLevel

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMO_CONFIG] '" & SESSION("strLoginID") & "' ")

	strWidth          = RS("strWidth")
	strAlign          = GetAlignSet(RS("strAlign"))
	strSkin           = RS("strSkin")
	strSkinGroup      = RS("strSkinGroup")
	bitUsage          = RS("bitUsage")
	bitSound          = RS("bitSound")
	strSoundFile      = RS("strSoundFile")
	intMemoTime       = RS("intMemoTime")
	intMemoSaveCount  = RS("intMemoSaveCount")
	intPageCount      = RS("intPageCount")
	skinPath          = GetSkinPath(strSkin, 1, strSkinGroup, 1) & "/"

	bitMemoUse        = RS("bitMemoUse")
	intMemoUseLevel   = RS("intMemoUseLevel")
	bitMemoSend       = RS("bitMemoSend")
	intMemoSendLevel  = RS("intMemoSendLevel")
	bitMemoRead       = RS("bitMemoRead")
	intMemoReadLevel  = RS("intMemoReadLevel")
	strErrorUrl       = RS("strErrorUrl")
	strErrorUrlTarget = RS("strErrorUrlTarget")
	strErrorMsg       = RS("strErrorMsg")
	intUserLevel      = RS("intUserLevel")
	IF intUserLevel = "" OR ISNULL(intUserLevel) = True THEN intUserLevel = 0

	IF bitUsage = False THEN
		IF Action = "WRITE" THEN
			RESPONSE.WRITE ExecJavaAlert("메모를 사용하실 수 없습니다.", 1)
			RESPONSE.End()
		ELSE
			IF strErrorUrl <> "" AND ISNULL(strErrorUrl) = False THEN
				RESPONSE.WRITE ExecFormSubmit(strErrorMsg, strErrorUrl, strErrorUrlTarget)
				RESPONSE.End()
			ELSE
				RESPONSE.WRITE ExecJavaAlert("메모를 사용하실 수 없습니다.", 0)
				RESPONSE.End()
			END IF
		END IF
	END IF

	IF bitMemoUse = True THEN
		IF SESSION("strAdmin") = "2" THEN
		ELSE
			IF INT(intMemoUseLevel) < INT(intUserLevel) OR INT(intMemoUseLevel) = INT(intUserLevel) THEN
			ELSE
				IF Action = "WRITE" THEN
					RESPONSE.WRITE ExecJavaAlert(strErrorMsg, 1)
					RESPONSE.End()
				ELSE
					IF strErrorUrl <> "" AND ISNULL(strErrorUrl) = False THEN
						RESPONSE.WRITE ExecFormSubmit(strErrorMsg, strErrorUrl, strErrorUrlTarget)
						RESPONSE.End()
					ELSE
						RESPONSE.WRITE ExecJavaAlert(strErrorMsg, 0)
						RESPONSE.End()
					END IF
				END IF
			END IF
		END IF
	END IF

	SELECT CASE UCASE(Action)
	CASE "WRITE"
		IF bitMemoSend = False THEN
			IF SESSION("strAdmin") = "2" THEN
			ELSE
				IF INT(intMemoSendLevel) < INT(intUserLevel) OR INT(intMemoSendLevel) = INT(intUserLevel) THEN
				ELSE
					IF Action = "WRITE" THEN
						RESPONSE.WRITE ExecJavaAlert(strErrorMsg, 1)
						RESPONSE.End()
					ELSE
						IF strErrorUrl <> "" AND ISNULL(strErrorUrl) = False THEN
							RESPONSE.WRITE ExecFormSubmit(strErrorMsg, strErrorUrl, strErrorUrlTarget)
							RESPONSE.End()
						ELSE
							RESPONSE.WRITE ExecJavaAlert(strErrorMsg, 0)
							RESPONSE.End()
						END IF
					END IF
				END IF
			END IF
		END IF
	CASE "READ", "LIST"
		IF bitMemoRead = False THEN
			IF SESSION("strAdmin") = "2" THEN
			ELSE
				IF INT(intMemoReadLevel) < INT(intUserLevel) OR INT(intMemoReadLevel) = INT(intUserLevel) THEN
				ELSE
					IF Action = "WRITE" THEN
						RESPONSE.WRITE ExecJavaAlert(strErrorMsg, 1)
						RESPONSE.End()
					ELSE
						IF strErrorUrl <> "" AND ISNULL(strErrorUrl) = False THEN
							RESPONSE.WRITE ExecFormSubmit(strErrorMsg, strErrorUrl, strErrorUrlTarget)
							RESPONSE.End()
						ELSE
							RESPONSE.WRITE ExecJavaAlert(strErrorMsg, 0)
							RESPONSE.End()
						END IF
					END IF
				END IF
			END IF
		END IF
	END SELECT
%>