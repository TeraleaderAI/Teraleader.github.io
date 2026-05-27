<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 1
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM strBoardID
	strBoardID = GetReplaceInput(REQUEST.QueryString("strBoardID"), "S")

	SET RS = DBCON.EXECUTE("SELECT [strName], [strSkin], [strSKinGroup], [dateRegDate] FROM [MPLUS_BOARD_CONFIG_DEFAULT] WHERE [strBoardID] = '" & strBoardID & "' ")
%>
<table width="700" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>게시판 정보</strong></span></td>
	</tr>
	<tr>
		<td height="3" bgcolor="#CCCCCC"></td>
	</tr>
	<tr>
	  <td>
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td height="33" class="table_Left1">게시판 접속 URL</td>
					<td class="table_Right1"><a href="<%=httpPath%>Mboard.asp?Action=list&strBoardID=<%=strBoardID%>" target="_blank"><%=httpPath%>Mboard.asp?Action=list&amp;strBoardID=<%=strBoardID%></a></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td height="33" class="table_Left1">게시판 이름</td>
					<td class="table_Right1"><%=RS("strName")%></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td height="33" class="table_Left1">스킨명 (타입)</td>
					<td class="table_Right1"><%=RS("strSkin")%> (<%=GetSKinGroupCode(RS("strSKinGroup"))%>)</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td height="33" class="table_Left1">게시판 생성일</td>
					<td class="table_Right1"><%=RS("dateRegDate")%></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
			</table>
		</td>
  </tr>
</table>
<!-- #include file = "../Foot.asp" -->