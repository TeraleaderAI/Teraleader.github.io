<!-- #include file = "Head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount
	intPage     = REQUEST.QueryString("intPage")     : IF intPage     = "" THEN intPage     = 1
	intPageSize = REQUEST.QueryString("intPageSize") : IF intPageSize = "" THEN intPageSize = 15

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MYMENU_GUEST] '" & strUserID & "', 'C', '20' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
<table width="100%" border="0" cellpadding="10" cellspacing="0" bgcolor="#FFFFFF">
<form name="theForm" method="post">
<input type="hidden" name="strUserID" value="<%=strUserID%>">
<input type="hidden" name="strLoginID" value="<%=SESSION("strLoginID")%>">
	<tr>
		<td valign="top" height="100%">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
				<tr>
					<td height="30">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><img src="MyMenu/images/ico_dot.gif" width="9" height="9"><b>방명록</b> <font color="#999999" style="font-size:11px;">(<%=intTotalCount%>개의 흔적이 있습니다)</font></td>
								<td align="right">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="10">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td background="MyMenu/images/line_dot.gif" height="9"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="5">&nbsp;</td>
				</tr>
				<tr>
					<td height="2">
						<table width="100%" border="1" cellpadding="10" cellspacing="0" bordercolor="#e7e7e7" style="border-collapse:collapse; line-height:16px;">
							<tr>
								<td bgcolor="#f7f7f7"><font color="#808080"><b><%=strUserName%></b>님에게 <b><%=SESSION("strLoginName")%></b>님의 흔적을 남겨주세요.</font></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1">&nbsp;</td>
				</tr>
				<tr>
					<td height="100%">
						<table width="100%" height="100%" border="1" cellpadding="10" cellspacing="0" bordercolor="#e7e7e7" style="border-collapse:collapse; line-height:16px;">
							<tr>
								<td valign="top">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MYMENU_GUEST] '" & strUserID & "', 'L', '20', '" & intPage & "' ")

	IF RS.EOF THEN
%>
										<tr>
											<td align="center">등록된 방문글이 없습니다.</td>
										</tr>
<%
	ELSE
		DIM bitGuestErase
		WHILE NOT(RS.EOF)
			IF strUserID = SESSION("strLoginID") THEN
				bitGuestErase = True
			ELSE
				IF SESSION("strLoginID") = RS("strLoginID") THEN bitGuestErase = True ELSE bitGuestErase = False
			END IF
%>
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="6">
													<tr>
														<td bgcolor="#f7f7f7"><%=RS("strLoginName")%>(<%=RS("strLoginName")%>)</td>
														<td align="right" bgcolor="#f7f7f7" class="txt1"><%=GetDateType(0, RS("dateRegDate"))%><% IF bitGuestErase = True THEN %>&nbsp;|&nbsp;<a href="javascript:;" onClick="OnCommentErase('<%=RS("intSeq")%>');return false;" class="txt1">삭제</a>
														<% END IF %></td>
													</tr>
													<tr>
														<td colspan="2"><font color="#666666"><%=RS("strContent")%></font></td>
													</tr>
													<tr>
														<td colspan="2" height="20"></td>
													</tr>
												</table>
											</td>               	
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
					<td height="3"></td>
				</tr>
				<tr>
					<td height="40" align="center">
						<% CALL GotoPageHTML(intPage, intPageCount) %></td>
				</tr>
				<tr>
					<td>
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#FFFFFF">
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
											<b>
											<textarea name="strContent" cols="80" rows="4" id="strContent" style="font-size:12px; width:98%"></textarea>
											</b></td>
											<td align="right" width="74"><a href="javascript:;" onClick="OnCommentAdd();return false;"><img src="MyMenu/images/btn_comment_add.gif" border="0" align="absmiddle"></a></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="center" valign="bottom">&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
<%
	SUB GotoPageHTML(intPage, intPageCount)

		RESPONSE.WRITE "<table border='0' cellpadding='0' cellspacing='0'>" & vbcrlf
		RESPONSE.WRITE "	<tr>" & vbcrlf

		DIM intBlockPage, I
		intBlockPage = INT((intPage - 1) / 10) * 10 + 1

		IF intBlockPage = 1 THEN
		ELSE
    	RESPONSE.WRITE "<td id='mytd'><img src='MyPage/images/page_allow1.gif' vspace='2'>&nbsp;<a href=""javascript:;"" OnClick=""OnPageMove('" & intBlockPage - 10 & "','" & strUserID & "');return false;"" class='brn01'>이전</a></td>"
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
			RESPONSE.WRITE "<td id='mytd'>&nbsp;<a href=""javascript:;"" OnClick=""OnPageMove('" & intBlockPage & "','" & strUserID & "');return false;"" class='brn01'>다음</a>&nbsp;<img src='MyPage/images/page_allow2.gif' vspace='2'></td>"
		END IF

		RESPONSE.WRITE "	</tr>" & vbcrlf
		RESPONSE.WRITE "</table>" & vbcrlf

	END SUB
%>
<script language="javascript">

	function OnCommentAdd(){
		str = document.theForm.strContent;
		if (str.value == ""){alert("내용을 입력해 주시기 바랍니다.");str.focus();return false;}

		document.theForm.action = "MyMenu/Guest_ok.asp?action=add";
		document.theForm.submit();

	}

	function OnPageMove(intPage, strUserID){
		location.href = "MyMenu.asp?Action=Guest&strUserID=" + strUserID + "&intPage=" + intPage;
	}

	function OnCommentErase(intSeq){
		if (confirm("삭제하시겠습니까?")){
			document.theForm.action = "MyMenu/Guest_ok.asp?action=erase&intSeq=" + intSeq;
			document.theForm.submit();
		}
	}

</script>
<!-- #include file = "Foot.asp" -->