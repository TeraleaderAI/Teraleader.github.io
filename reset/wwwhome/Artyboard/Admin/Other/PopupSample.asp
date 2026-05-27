<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu  = 2
	isAdminPopup = True
%>
<!-- #include file = "../Head.asp" -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post">
	<tr>
		<td background="../images/pop_title_bg.gif"><img src="../images/pop_title_popup.gif" width="155" height="44"></td>
	</tr>
	<tr>
		<td height="8"></td>
	</tr>
	<tr>
		<td bgcolor="#333333" style="color:#FFFFFF;padding:10;">
			&lt;html&gt;<br>
			&lt;head&gt;<br>
			&lt;meta http-equiv="Content-Type" content="text/html; charset=euc-kr"&gt;<br>
			&lt;title&gt;&lt;/title&gt;<br>
			&lt;/head&gt;<br>
			&lt;body&gt;<br>
			&lt;!-- #include file = "<%=REPLACE(httpPath, "http://" & Request.ServerVariables("SERVER_NAME") & "/", "")%>DBConnect/DBConnect.asp" --&gt;<br>
			&lt;!-- #include file = "<%=REPLACE(httpPath, "http://" & Request.ServerVariables("SERVER_NAME") & "/", "")%>Library/Function.asp" --&gt;<br>
			&lt;!-- #include file = "<%=REPLACE(httpPath, "http://" & Request.ServerVariables("SERVER_NAME") & "/", "")%>Library/popup.asp" --&gt;<br>
			&lt;% SET RS = NOTHING : DBCON.CLOSE %&gt;<br>
			&lt;/body&gt;<br>
			&lt;/html&gt;<br>
		</td>
	</tr>
</form>
</table>
<!-- #include file = "../Foot.asp" -->