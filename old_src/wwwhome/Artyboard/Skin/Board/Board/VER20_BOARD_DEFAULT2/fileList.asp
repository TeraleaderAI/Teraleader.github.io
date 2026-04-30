<% FOR I = 1 TO READ_intFileCount %>
<img src="<%=skinPath%>images/icon_file.gif" width="13" height="12">
<% IF CONF_bitDownLevel = True THEN %><a href="<%=FILE_REDIM_FileLink(I)%>"><%=FILE_REDIM_FileName(I)%> (<%=GetFilesize(FILE_REDIM_FileSize(I))%>)(<%=FILE_REDIM_FileDown(I)%>)</a><% ELSE %><%=FILE_REDIM_FileName(I)%> (<%=GetFilesize(FILE_REDIM_FileSize(I))%>)(<%=FILE_REDIM_FileDown(I)%>)<% END IF %>&nbsp;
<% NEXT %>