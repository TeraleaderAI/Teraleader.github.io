<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = False
	strAdminPrevUrl = "Default/DefaultConfig.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	WITH REQUEST

		strConnectDbName  = GetReplaceInput(.FORM("strConnectDbName"),"")
		strConnectDbId    = GetReplaceInput(.FORM("strConnectDbId"),"")
		strConnectDbPass  = GetReplaceInput(.FORM("strConnectDbPass"),"")
		strConnectDbIp    = GetReplaceInput(.FORM("strConnectDbIp"),"")
		setUploadComponet = GetReplaceInput(.FORM("setUploadComponet"),"")
		sitePath          = GetReplaceInput(.FORM("sitePath"),"")
		httpPath          = GetReplaceInput(.FORM("httpPath"),"")
		rootPath          = GetReplaceInput(.FORM("rootPath"),"")

	END WITH

	DIM conFile, FSO

	conFile = rootPath & "\Dbconnect\Dbconnect.asp"
	SET FSO = SERVER.CREATEOBJECT("Scripting.FileSystemObject")
	
	IF FSO.fileExists(conFile) THEN
		FSO.DeleteFile(conFile)
		SET FILE = FSO.createTextFile(conFile, ForWriting)

		FILE.WRITELINE("<%")
		FILE.WRITELINE("	DIM rootPath, httpPath, DbCon, DbConnect, setUploadComponet, strConnectDbName, strConnectDbId, strConnectDbPass, strConnectDbIp ")
		FILE.WRITELINE("")
		FILE.WRITELINE("	rootPath         = """ & rootPath & """")
		FILE.WRITELINE("	httpPath         = """ & httpPath & """")
		FILE.WRITELINE("	sitePath         = """ & sitePath & """")
		FILE.WRITELINE("	strConnectDbName = """ & strConnectDbName & """")
		FILE.WRITELINE("	strConnectDbId   = """ & strConnectDbId & """")
		FILE.WRITELINE("	strConnectDbPass = """ & strConnectDbPass & """")
		FILE.WRITELINE("	strConnectDbIp   = """ & strConnectDbIp & """")
		FILE.WRITELINE("")
		FILE.WRITELINE("	DbConnect = ""Provider=SQLOLEDB.1; Data Source="" & strConnectDbIp & ""; Initial Catalog="" & strConnectDbName & ""; User Id="" & strConnectDbId & ""; Password="" & strConnectDbPass & "";""")
		FILE.WRITELINE("")
		FILE.WRITELINE("	SET DbCon = Server.CreateObject(""ADODB.Connection"")")
		FILE.WRITELINE("	DbCon.Open DbConnect")
		FILE.WRITELINE("")
		FILE.WRITELINE("	setUploadComponet = """ & setUploadComponet & """")
		FILE.WRITELINE(CHR(37 ) & ">")
		FILE.CLOSE

		RESPONSE.WRITE ExecFormSubmit("정상적으로 적용되었습니다.", "DefaultConfig.asp", "")
		RESPONSE.End()

	ELSE

		RESPONSE.WRITE ExecJavaAlert("환경설정 파일이 존재하지 않습니다.", 0)
		RESPONSE.End()

	END IF

	SET FSO = NOTHING

	SET RS = NOTHING : DBCON.CLOSE
%>