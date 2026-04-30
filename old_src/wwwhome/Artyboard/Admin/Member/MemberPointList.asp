<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Member/MemberList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM intPageSize, iCount
	intPageSize = REQUEST.FORM("intPageSize")
	IF intPageSize = "" THEN intPageSize = 20
	iCount = 0
	
	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSIze & " [strLoginID], [strLoginName], [intPoint] = (SELECT SUM([moneyPoint]) FROM [MPLUS_MEMBER_POINT] WHERE [strLoginID] = [MPLUS_MEMBER_LIST].[strLoginID]), [intBoardCount], [intCommentCount], [intVote], [intVisit], [dateRegDate] FROM [MPLUS_MEMBER_LIST] WHERE [strAdmin] != '2' ORDER BY [intPoint] DESC ")
%>
<table width="584" height="100%"  border="0" cellpadding="0" cellspacing="0">
<form name="theForm" method="post" action="MemberPointList.asp">
	<tr>
	  <td height="44" background="../images/pop_title_bg.gif"><img src="../images/pop_title_point_ranking.gif" width="155" height="44"></td>
	  </tr>
	<tr>
	  <td height="5" align="center"></td>
	  </tr>
	<tr>
		<td height="30" align="right"><select name="intPageSize" id="intPageSize" onChange="document.theForm.submit();">
		  <option value="20"<% IF intPageSize = 20 THEN %> SELECTED<% END IF %>>1위 ~ 20위</option>
		  <option value="50"<% IF intPageSize = 50 THEN %> SELECTED<% END IF %>>1위 ~ 50위</option>
		  <option value="100"<% IF intPageSize = 100 THEN %> SELECTED<% END IF %>>1위 ~ 100위</option>
		  </select>
		  &nbsp; </td>
	</tr>
	<tr>
		<td valign="top">
			<table width="100%"  border="0" cellpadding="0" cellspacing="0">
				<tr align="center" bgcolor="EB766F">
					<td colspan="9" class="table_Round1"></td>
				</tr>
				<tr align="center" bgcolor="EB766F">
					<td height="30" class="table_Txt1" nowrap>순위</td>
					<td height="30" class="table_Txt1" nowrap>아이디</td>
					<td height="30" class="table_Txt1" nowrap>이름</td>
					<td height="30" class="table_Txt1" nowrap>포인트</td>
					<td class="table_Txt1" nowrap>게시글</td>
					<td class="table_Txt1" nowrap>댓글</td>
					<td class="table_Txt1" nowrap>추천</td>
					<td class="table_Txt1" nowrap>방문</td>
					<td height="30" nowrap class="table_Txt1">가입일</td>
				</tr>
				<tr bgcolor="EB766F">
					<td colspan="9" class="table_Round1"></td>
				</tr>
<%
	IF RS.EOF THEN
%>
				<tr align="center" bgcolor="#FFFFFF">
					<td colspan="9" class="table_ListSubText1">검색된 회원이 없습니다.</td>
				</tr>
				<tr>
					<td colspan="9" class="table_ListSubLine1"></td>
				</tr>
<%
		ELSE
			WHILE NOT(RS.EOF)
			iCount = iCount + 1
%>
				<tr bgcolor="#FFFFFF" align="center">
					<td class="table_ListSubText1"><%=iCount%></td>
					<td class="table_ListSubText1"><%=RS("strLoginID")%></td>
					<td class="table_ListSubText1"><%=RS("strLoginName")%></td>
					<td class="table_ListSubText1"><%=GetMoneyComma(RS("intPoint"))%></td>
					<td class="table_ListSubText1"><%=RS("intBoardCount")%></td>
					<td class="table_ListSubText1"><%=RS("intCommentCount")%></td>
					<td class="table_ListSubText1"><%=RS("intVote")%></td>
					<td class="table_ListSubText1"><%=RS("intVisit")%></td>
					<td class="table_ListSubText1"><%=REPLACE(FORMATDATETIME(RS("dateRegDate"), 2), "-", "/")%></td>
				</tr>
				<tr>
					<td colspan="9" class="table_ListSubLine1"></td>
				</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
				<tr>
					<td colspan="9" height="1"></td>
				</tr>
				<tr>
					<td colspan="9" class="table_ListSubBLine1"></td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
<!-- #include file = "../Foot.asp" -->