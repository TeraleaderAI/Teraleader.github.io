<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu  = 2
	isAdminPopup = True
%>
<!-- #include file = "../Head.asp" -->
<%
	SET RS = DBCON.EXECUTE("SELECT [strSubject], [strTextValue] FROM [MPLUS_POLL_ITEM] WHERE [intSeq] = '" & REQUEST.QueryString("intSeq") & "' ")

	DIM strSubject, strTextValue

	strSubject   = RS("strSubject")
	strTextValue = SPLIT(RS("strTextValue"), "|")
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td background="../images/pop_title_bg.gif"><img src="../images/pop_title_poll_result.gif" width="155" height="44"></td>
	</tr>
	<tr>
		<td height="8"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="33" class="table_Left1">설문조사 제목</td>
					<td class="table_Right1"><%=strSubject%></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td height="33" class="table_Left1">설문조사 결과</td>
					<td class="table_Right1">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
<%
	DIM I
	FOR I = 0 TO UBOUND(strTextValue)
%>
							<tr>
								<td height="24" style="padding-left:10;"><%=I+1%>.&nbsp;<%=strTextValue(I)%></td>
							</tr>
<% NEXT %>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- #include file = "../Foot.asp" -->