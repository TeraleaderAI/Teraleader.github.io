<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM strLoginID, strOpenMemo, strOpenName, strOpenGroup, strOpenEmail, strOpenSex, strOpenAge, strOpenBirthday, strOpenTel
	DIM strOpenMobile, strOpenAddr, strOpenHomp, strOpenJob, strOpenHobby, strOpenMarry

	WITH REQUEST

		strLoginID      = .FORM("strLoginID")
		strOpenMemo     = .FORM("strOpenMemo")
		strOpenName     = .FORM("strOpenName")
		strOpenGroup    = .FORM("strOpenGroup")
		strOpenEmail    = .FORM("strOpenEmail")
		strOpenSex      = .FORM("strOpenSex")
		strOpenAge      = .FORM("strOpenAge")
		strOpenBirthday = .FORM("strOpenBirthday")
		strOpenTel      = .FORM("strOpenTel")
		strOpenMobile   = .FORM("strOpenMobile")
		strOpenAddr     = .FORM("strOpenAddr")
		strOpenHomp     = .FORM("strOpenHomp")
		strOpenJob      = .FORM("strOpenJob")
		strOpenHobby    = .FORM("strOpenHobby")
		strOpenMarry    = .FORM("strOpenMarry")

	END WITH

	DBCON.EXECUTE("UPDATE [MPLUS_MEMBER_LIST] SET [strOpenMemo] = '" & strOpenMemo & "', [strOpenName] = '" & strOpenName & "', [strOpenGroup] = '" & strOpenGroup & "', [strOpenEmail] = '" & strOpenEmail & "', [strOpenSex] = '" & strOpenSex & "', [strOpenAge] = '" & strOpenAge & "', [strOpenBirthday] = '" & strOpenBirthday & "', [strOpenTel] = '" & strOpenTel & "', [strOpenMobile] = '" & strOpenMobile & "', [strOpenAddr] = '" & strOpenAddr & "', [strOpenHomp] = '" & strOpenHomp & "', [strOpenJob] = '" & strOpenJob & "', [strOpenHobby] = '" & strOpenHobby & "', [strOpenMarry] = '" & strOpenMarry & "' WHERE [strLoginID] = '" & strLoginID & "' ")

	RESPONSE.WRITE ExecFormSubmit("", "../MyMenu.asp?Action=config&strUserID=" & strLoginID, "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>