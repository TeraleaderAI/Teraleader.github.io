<!--METADATA TYPE="typelib" NAME="ADODB Type Library" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"-->
<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "DbManage/DbTableList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	RESPONSE.EXPIRES     = 0
	SERVER.SCRIPTTIMEOUT = 2000
	RESPONSE.Buffer      = TRUE
%>
<%
	DIM strTableName, intColumn
	strTableName = REQUEST.QueryString("strTableName")

	SET RS = DBCON.EXECUTE("SELECT COUNT([COLUMN_NAME]) FROM [information_schema].[columns] WHERE [TABLE_NAME] = '" & strTableName & "' ")

	intColumn = RS(0)

	SET RS = DBCON.EXECUTE("SELECT [COLUMN_NAME] FROM [information_schema].[columns] WHERE [TABLE_NAME] = '" & strTableName & "' ")

	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","attachment;filename=" & strTableName & "-" & YEAR(NOW) & MONTH(NOW) & DAY(NOW) & ".xls"

	RESPONSE.WRITE "<table width=100% border=1 cellspacing=0 cellpadding=0>" & vbcrlf
	RESPONSE.WRITE "  <tr>" & vbcrlf

	WHILE NOT(RS.EOF)

		RESPONSE.WRITE "    <td>" & RS("COLUMN_NAME") & "</td>" & vbcrlf

	RS.MOVENEXT
	WEND

	RESPONSE.WRITE "  </tr>" & vbcrlf

	DIM tmpFor, tmpFor2

	SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.Command")
	SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RecordSet")
	
	AdRs_GetRows_Count = ""
	WITH AdCmd

		.ActiveConnection = DbConnect
		.CommandText      = "MPLUS_GET_DB_TABLE"
		.CommandTimeOut   = 10
		.CommandType      = adCmdStoredProc
		.Parameters.Append	.CreateParameter("strTable", adVarChar,	adParamInput,	32,	strTableName)

		AdRs.Open .Execute
		IF (NOT (AdRs.EOF OR AdRs.BOF)) THEN
			AdRs_GetRows 		= AdRs.GetRows
			AdRs_GetRows_Count	= UBOUND(AdRs_GetRows, 2)
		END IF
		AdRs.Close
			
	END WITH
	SET	AdRS	= Nothing : SET	AdCmd	= Nothing

	FOR tmpFor = 0 TO AdRs_GetRows_Count

		RESPONSE.WRITE "  <tr>" & vbcrlf

		FOR tmpFor2 = 0 TO intColumn - 1

			RESPONSE.WRITE "    <td>" & AdRs_GetRows(tmpFor2, tmpFor) & "</td>" & vbcrlf

		NEXT

		RESPONSE.WRITE "  </tr>" & vbcrlf

	NEXT

	RESPONSE.WRITE "</table>" & vbcrlf

	SET RS = NOTHING : DBCON.CLOSE
%>