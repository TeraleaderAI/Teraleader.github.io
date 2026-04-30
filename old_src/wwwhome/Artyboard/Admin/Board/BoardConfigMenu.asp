									<table width="100%" border="0" cellpadding="10" cellspacing="0" class="table_Select1">
										<tr>
											<td class="table_SelecttdIn1">
												<table width="100%" border="0" cellpadding="2" cellspacing="0">
													<tr>
														<td align="right" style="font:bold">
														<a href="boardDefaultConfig.asp?strBoardID=<%=strBoardID%>">기본설정</a> | <a href="boardListConfig.asp?strBoardID=<%=strBoardID%>">리스트설정</a> | <a href="boardReadConfig.asp?strBoardID=<%=strBoardID%>">글읽기설정</a> | <a href="boardWriteConfig.asp?strBoardID=<%=strBoardID%>">글쓰기설정</a> | <a href="BoardCategoryConfig.asp?strBoardID=<%=strBoardID%>">카테고리설정</a> | <a href="BoardPointConfig.asp?strBoardID=<%=strBoardID%>">권한/포인트 설정</a> |
														<select name="strSetBoardID" id="strSetBoardID" style="font-size:12px" onchange="OnAdminBoardPageMove(this.value, '<%=intBoardConfigMenu%>');">
                            <option value="">게시판 선택</option>
<%
	DIM SELECTED
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '', '' ")
	WHILE NOT(RS.EOF)
		IF RS("strBoardID") = strBoardID THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		RESPONSE.WRITE "<option value='" & RS("strBoardID") & "'" & SELECTED & ">" & RS("strBoardID") & "</oprion>" & vbcrlf
	RS.MOVENEXT
	WEND
%>
														</select>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>