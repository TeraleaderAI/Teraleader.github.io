<%
	Dim DB
	Dim strConnection
	Set DB = Server.CreateObject("ADODB.Connection")

	strConnection = "Provider=SQLOLEDB;Data Source =<DB_HOST>;Initial Catalog =<DB_NAME>;User id=<DB_USER>; Password=<DB_PASSWORD>;"
	DB.Open strConnection
%>