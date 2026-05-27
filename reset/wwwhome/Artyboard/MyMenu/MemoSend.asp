<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM MEMO_strRecvID, MEMO_strSendID, MEMO_strContent, bitSendClose

	WITH REQUEST

		MEMO_strRecvID  = GetReplaceInput(.FORM("strUserID"), "")
		MEMO_strSendID  = GetReplaceInput(.FORM("strLoginID"), "")
		MEMO_strContent = GetReplaceInput(.FORM("strContent"), "")
		bitSendClose    = .FORM("bitSendClose")

	END WITH

	IF bitSendClose = "" THEN bitSendClose = "0"

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & MEMO_strRecvID & "', '0' ")

	IF RS.EOF THEN

		RESPONSE.WRITE ExecJavaAlert("등록된 회원 아이디가 아닙니다.", 0)
		RESPONSE.End()

	ELSE

		IF RS("bitSecession") = True THEN

			RESPONSE.WRITE ExecJavaAlert("탈퇴 처리된 회원 아이디 입니다.", 0)
			RESPONSE.End()

		ELSE

			DBCON.EXECUTE("INSERT INTO [MPLUS_MEMO] ([strSendID], [strRecvID], [strContent]) VALUES ('" & MEMO_strSendID & "', '" & MEMO_strRecvID & "', '" & MEMO_strContent & "') ")

			IF bitSendClose = "1" THEN

				RESPONSE.WRITE ExecJavaAlert("메모발송이 완료되었습니다.", 1)
				RESPONSE.End()

			ELSE

				RESPONSE.WRITE ExecFormSubmit("", "../MyMenu.asp?Action=memo&strUserID=" & MEMO_strRecvID, "")
				RESPONSE.End()

			END IF

		END IF
	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>