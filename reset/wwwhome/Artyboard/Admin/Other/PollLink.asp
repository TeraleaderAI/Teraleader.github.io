<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu  = 2
	isAdminPopup = True
%>
<!-- #include file = "../Head.asp" -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post">
	<tr>
		<td background="../images/pop_title_bg.gif"><img src="../images/pop_title_poll.gif" width="155" height="44"></td>
	</tr>
	<tr>
		<td height="8"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="table_Left1">설문조사 리스트</td>
					<td class="table_Right1"><a href="<%=httpPath%>poll.asp?Action=list&strPollCode=<%=REQUEST.QueryString("strPollCode")%>" target="_blank"><%=httpPath%>poll.asp?Action=list&amp;strPollCode=<%=REQUEST.QueryString("strPollCode")%></a></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">설문조사 설문지 </td>
					<td class="table_Right1"><a href="<%=httpPath%>poll.asp?Action=read&strPollCode=<%=REQUEST.QueryString("strPollCode")%>" target="_blank"><%=httpPath%>poll.asp?Action=read&amp;strPollCode=<%=REQUEST.QueryString("strPollCode")%></a></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
<!-- #include file = "../Foot.asp" -->