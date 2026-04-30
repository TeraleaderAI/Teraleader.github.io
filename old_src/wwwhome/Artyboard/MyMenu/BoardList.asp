<!-- #include file = "Head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount
	intPage     = REQUEST.QueryString("intPage")     : IF intPage     = "" THEN intPage     = 1
	intPageSize = REQUEST.QueryString("intPageSize") : IF intPageSize = "" THEN intPageSize = 15

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MYMENU_BOARD] '" & strUserID & "', 'C', '" & intPageSize & "' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
<table width="100%" border="0" cellpadding="10" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td valign="top" height="100%">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><img src="MyMenu/images/ico_dot.gif" width="9" height="9">포스트&nbsp;<b><%=intTotalCount%>개</b></td>
											<td align="right" style="font-size:11px;">&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="30" height="30" align="center" class="board1_title">번호</td>
											<td height="30" align="center" class="board1_title">제목</td>
											<td width="50" align="center" class="board1_title">조회</td>
											<td width="120" align="center" class="board1_title">등록일</td>
										</tr>
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MYMENU_BOARD] '" & strUserID & "', 'L', '" & intPageSize & "', '" & intPage & "' ")

	IF RS.EOF THEN
%>
										<tr>
											<td height="30" colspan="4" align="center" class="board1_txt">등록된 게시글이 없습니다.</td>
										</tr>
<%
	ELSE
		DIM iCount, intNumber
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
										<tr>
											<td height="30" align="center" class="board1_txt"><%=intNumber%></td>
											<td height="25" class="board1_txt"><a href="Mboard.asp?action=view&strBoardID=<%=RS("strBoardID")%>&intSeq=<%=RS("intSeq")%>" target="_blank"><%=GetCutSubject(RS("strSubject"),60)%></a><% IF RS("intComment") > 0 THEN %>&nbsp;<font color="#E76322">(<%=RS("intComment")%>)</font><% END IF %><% IF GetNewBoardTime(48, RS("dateRegDate")) = True THEN %>&nbsp;<img src="MyMenu/images/ico_new.gif" width="10" height="9" align="absmiddle"><% END IF %></td>
											<td height="25" align="center" class="board1_txt" style="font-size:11px;"><%=RS("intRead")%></td>
											<td height="25" align="center" class="board1_txt" style="font-size:11px;"><%=GetDateType(0, RS("dateRegDate"))%></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="10">&nbsp;</td>
				</tr>
				<tr>
					<td height="5" align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<script language="javascript">

	function OnPageMove(intPage, strUserID){
		location.href = "MyMenu.asp?Action=BoardList&strUserID=" + strUserID + "&intPage=" + intPage;
	}

</script>
<%
	SUB GotoPageHTML(intPage, intPageCount)

		RESPONSE.WRITE "<table border='0' cellpadding='0' cellspacing='0'>" & vbcrlf
		RESPONSE.WRITE "	<tr>" & vbcrlf

		DIM intBlockPage, I
		intBlockPage = INT((intPage - 1) / 10) * 10 + 1

		IF intBlockPage = 1 THEN
		ELSE
    	RESPONSE.WRITE "<td id='mytd'><img src='MyMenu/images/page_allow1.gif' vspace='2'>&nbsp;<a href=""javascript:;"" OnClick=""OnPageMove('" & intBlockPage - 10 & "','" & strUserID & "');return false;"" class='brn01'>이전</a></td>"
		END IF

		RESPONSE.WRITE "		<td  width='1' nowrap bgcolor='#cccccc'></td>" & vbcrlf

		i = 1
		
		DO UNTIL i > 10 OR intBlockPage > intPageCount

			RESPONSE.WRITE "		<td id='mytd' onMouseOver=""this.style.background='#f7f7f7'"" onMouseOut=""this.style.background=''"" align=center onClick=""OnPageMove('" & intBlockPage & "','" & strUserID & "');return false;"">"
		
			IF INT(intBlockPage) = INT(intPage) THEN RESPONSE.WRITE "<font color='#ff7635'><b>" & intBlockPage & "</b></font>" ELSE RESPONSE.WRITE "<b>" & intBlockPage & "</b>"

			RESPONSE.WRITE "</td>" & vbcrlf
			RESPONSE.WRITE "<td  width=1 nowrap bgcolor='#cccccc'></td>" & vbcrlf

			intBlockPage = intBlockPage + 1
			I = I + 1
		
		LOOP

    IF intBlockPage > intPageCount THEN
		ELSE
			RESPONSE.WRITE "<td id='mytd'>&nbsp;<a href=""javascript:;"" OnClick=""OnPageMove('" & intBlockPage & "','" & strUserID & "');return false;"" class='brn01'>다음</a>&nbsp;<img src='MyMenu/images/page_allow2.gif' vspace='2'></td>"
		END IF

		RESPONSE.WRITE "	</tr>" & vbcrlf
		RESPONSE.WRITE "</table>" & vbcrlf

	END SUB
%>
<!-- #include file = "Foot.asp" -->