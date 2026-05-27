<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 1
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardList.asp"
%>
<!-- #include file = "../head.asp" -->
<%
	DIM strBoardID, intCategory

	strBoardID  = REQUEST.QueryString("strBoardID")
	intCategory = REQUEST.QueryString("intCategory")
%>
<table width="520"  border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="BoardCategoryConfig_ok.asp?Action=MOVE&intCategory=<%=intCategory%>">
<input type="hidden" name="strBoardID" value="<%=strBoardID%>">
	<tr>
		<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>카테고리 게시글 이동</strong></span></td>
	</tr>
	<tr>
		<td height="3" bgcolor="#CCCCCC"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="table_Left1">카테고리명</td>
					<td class="table_Right1">
					<select name="exIntCategory" id="exIntCategory" style="width:300">
<%
	SET RS = DBCON.EXECUTE("SELECT [intCategory], [strCategory] FROM [MPLUS_BOARD_CATEGORY] WHERE [strBoardID] = '" & strBoardID & "' AND [intCategory] != '" & intCategory & "' ")

	WHILE NOT(RS.EOF)
		RESPONSE.WRITE "<option value='" & RS("intCategory") & "'>" & RS("strCategory") & "</option>" & vbcrlf
	RS.MOVENEXT
	WEND
%>
					</select>
					</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="40" align="right" style="padding-right:30;"><input type="image" name="imageField" src="../images/btn_board_move_m.gif" class="no_Line"></td>
	</tr>
	</form>
</table>
<!-- #include file = "../foot.asp" -->