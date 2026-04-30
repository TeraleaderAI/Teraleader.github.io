<!--#include virtual="/include/Function.asp"-->
<%
		b_file				= Request("b_file")
		b_file				= replace(b_file,"'","''")
		file_folder		=	request("file_folder")
		file_folder		= replace(file_folder,"'","''")
		DirectoryPath = Server.MapPath("/data/"+file_folder)
		realPath = DirectoryPath & "\" & b_file
		
		'response.write realPath
    
		Response.ContentType = "application/unknown"
    Response.AddHeader "Content-Disposition","attachment; filename=" & b_file
    Set objStream = Server.CreateObject("ADODB.Stream")
    objStream.Open
    objStream.Type = 1
    objStream.LoadFromFile realPath
    download = objStream.Read
    Response.BinaryWrite download
    Set objstream = nothing 
%> 