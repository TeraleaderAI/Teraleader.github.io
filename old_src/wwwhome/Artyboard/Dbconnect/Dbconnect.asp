<%
	' 이 파일은 아티보드의 1.5 버전의 환경 설정 파일입니다.
	' 이 파일은 임의대로 수정이 가능하나 DB의 연결이 잘못될 수 있습니다. 

	DIM rootPath, httpPath, sitePath, DbCon, DbConnect, setUploadComponet, strConnectDbName, strConnectDbId
	DIM strConnectDbPass, strConnectDbIp 

	rootPath         = "d:\iweb\teraleader\wwwhome\Artyboard\"
	httpPath         = "http://www.teralead.com/artyboard/"
	sitePath         = "http://www.teralead.com/"
	strConnectDbName = "<DB_NAME>"
	strConnectDbId   = "<DB_USER>"
	strConnectDbPass = "<DB_PASSWORD>"
	strConnectDbIp   = "<DB_HOST>"

	DbConnect = "Provider=SQLOLEDB;Data Source = " & strConnectDbIp & "; Initial Catalog=" & strConnectDbName & "; User ID=" & strConnectDbId & "; Password=" & strConnectDbPass & ";"

	SET DbCon = Server.CreateObject("ADODB.Connection")
	DbCon.Open DbConnect

	setUploadComponet = "2"
%>
