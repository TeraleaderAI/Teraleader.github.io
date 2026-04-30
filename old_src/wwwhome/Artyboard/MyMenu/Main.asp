<!-- #include file = "Head.asp" -->
			<table width="100%" border="0" cellpadding="10" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
          <td valign="top" height="100%">
          	<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
              <tr>
                <td>
                	<table width="100%" border="1" cellpadding="10" cellspacing="0" bordercolor="#e7e7e7" style="border-collapse:collapse; line-height:16px;">
                    <tr>
                      <td bgcolor="#f7f7f7"><font color="#808080">멤버룸에서는 <%=SESSION("strLoginName")%>님의 <a href="MyMenu.asp?Action=BoardList&strUserID=<%=strUserID%>"><u>포스트</u></a> 및 <a href="MyMenu.asp?Action=CmtList&strUserID=<%=strUserID%>"><u>댓글</u></a>을 조회하실 수 있습니다.<br>
                        아티보드님에게 <a href="MyMenu.asp?Action=email&strUserID=<%=strUserID%>"><u>이메일</u></a> 및 <a href="MyMenu.asp?Action=memo&strUserID=<%=strUserID%>"><u>쪽지</u></a>를 전송하실 수 있습니다.<br>
                        아티보드님에게 남기고 싶은 말씀이 있으시면 <a href="MyMenu.asp?Action=Guest&strUserID=<%=strUserID%>"><u>흔적남기기</u></a>를 이용해 주세요.</font></td>
                    </tr>
                	</table>
                </td>
              </tr>
              <tr>
                <td height="20">&nbsp;</td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="30">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><img src="images/ico_dot.gif" width="9" height="9"><b>포스트</b></td>
                            <td align="right"><a href="MyMenu.asp?Action=BoardList&strUserID=<%=strUserID%>"><span style="font-size:11px;">더보기</span></a></td>
                          </tr>
                       </table>
                     </td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="30" align="center" class="board1_title">제목</td>
                            <td width="50" align="center" class="board1_title">조회</td>
                            <td width="120" align="center" class="board1_title">등록일</td>
                          </tr>
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MYMENU_BOARD] '" & SESSION("strLoginID") & "', 'M', '5' ")

	WHILE NOT(RS.EOF)
%>
                          <tr>
                            <td height="25" class="board1_txt"><a href="Mboard.asp?action=view&strBoardID=<%=RS("strBoardID")%>&intSeq=<%=RS("intSeq")%>" target="_blank"><%=GetCutSubject(RS("strSubject"),60)%></a><% IF RS("intComment") > 0 THEN %>&nbsp;<font color="#E76322">(<%=RS("intComment")%>)</font><% END IF %><% IF GetNewBoardTime(48, RS("dateRegDate")) = True THEN %>&nbsp;<img src="MyMenu/images/ico_new.gif" width="10" height="9" align="absmiddle"><% END IF %></td>
                            <td height="25" align="center" class="board1_txt" style="font-size:11px;"><%=RS("intRead")%></td>
                            <td height="25" align="center" class="board1_txt" style="font-size:11px;"><%=GetDateType(0, RS("dateRegDate"))%></td>
                          </tr>
<%
	RS.MOVENEXT
	WEND
%>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td height="20">&nbsp;</td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="30">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><img src="images/ico_dot.gif" width="9" height="9"><b>댓글</b></td>
                            <td align="right"><a href="MyMenu.asp?Action=CmtList&strUserID=<%=strUserID%>"><span style="font-size:11px;">더보기</span></a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="30" align="center" class="board1_title">댓글의견</td>
                            <td width="120" align="center" class="board1_title">등록일</td>
                          </tr>
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MYMENU_COMMENT] '" & SESSION("strLoginID") & "', 'M', '5' ")

	WHILE NOT(RS.EOF)
%>
                          <tr>
                            <td height="25" class="board1_txt"><a href="Mboard.asp?action=view&strBoardID=<%=RS("strBoardID")%>&intSeq=<%=RS("intBoardSeq")%>" target="_blank"><%=GetCutSubject(GetReplaceTag2Text(StripTags(RS("strContent"))),60)%></a><% IF GetNewBoardTime(48, RS("dateRegDate")) = True THEN %>&nbsp;<img src="MyMenu/images/ico_new.gif" width="10" height="9" align="absmiddle"><% END IF %></td>
                            <td height="25" align="center" class="board1_txt" style="font-size:11px;"><%=GetDateType(0, RS("dateRegDate"))%></td>
                          </tr>
<%
	RS.MOVENEXT
	WEND
%>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
          	</table>
          </td>
        </tr>
				<tr>
					<td height="20"></td>
				</tr>
      </table>
<!-- #include file = "Foot.asp" -->