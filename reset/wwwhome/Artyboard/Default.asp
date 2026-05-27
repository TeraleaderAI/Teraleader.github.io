<!-- #include file = "Head.asp" -->
<!-- #include file = "Library/popup.asp" -->
<%
	DIM strBoardID(5)

	strBoardID(1) = ""
	strBoardID(2) = ""
	strBoardID(3) = ""
	strBoardID(4) = ""
	strBoardID(5) = ""

	' // 게시판 아이디를 환경설정 정보에서 읽어와서 배열 변수에 저장합니다.
	' // 최근글을 뽑을 게시판 아이디를 배열변수에 직접 기재 하시려면 아래 소스를 삭제하시기 바랍니다.
	' // 갤러리 게시판은 strBoardID(5) 변수에 값을 넣습니다.

	SET RS = DBCON.EXECUTE("SELECT TOP 5 [strBoardID] FROM [MPLUS_BOARD_CONFIG_DEFAULT] ORDER BY [intNum] ASC ")

	iCount = 0
	WHILE NOT(RS.EOF)
		iCount = iCount + 1
		strBoardID(iCount) = RS("strBoardID")
	RS.MOVENEXT
	WEND

	' // 게시판 아이디를 직접 입력하는 경우
	'strBoardID(1) = "board1"
	'strBoardID(2) = "board2"
	'strBoardID(3) = "board3"
	'strBoardID(4) = "board4"
	'strBoardID(5) = "board5"
%>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="images/top_img.gif" width="770" height="126"></td>
              </tr>
              <tr>
                <td height="15"></td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="50%" style="padding-right:25px;" valign="top">
<!-- 최근글 뽑기 1번 시작 -->
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="5"><img src="images/board_tit_left.gif" width="5" height="30"></td>
                                  <td background="images/board_tit_bg.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td><img src="images/board_tit.gif" width="62" height="15"></td>
                                      <td width="45"><% IF strBoardID(1) <> "" THEN %><a href="Mboard.asp?strBoardID=<%=strBoardID(1)%>"><img src="images/more.gif" width="33" height="6" border="0"></a><% END IF %></td>
                                    </tr>
                                  </table></td>
                                  <td width="5"><img src="images/board_tit_right.gif" width="5" height="30"></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td height="7"></td>
                          </tr>
                          <tr>
                            <td style="padding-left:10px">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_NOTICE] '" & strBoardID(1) & "', '', '5' ")

	WHILE NOT(RS.EOF)
%>
                                <tr>
                                  <td width="7"><img src="images/txt_icon2.gif" width="2" height="2"></td>
                                  <td height="18"><a href="Mboard.asp?Action=view&strBoardID=<%=strBoardID(1)%>&intSeq=<%=RS("intSeq")%>"><%=GetCutSubject(RS("strSubject"), 40)%></a></td>
                                </tr>
<%
	RS.MOVENEXT
	WEND
%>
                              </table>
                            </td>
                          </tr>
                        </table>
<!-- 최근글 뽑기 1번 종료 -->
                      </td>
                      <td valign="top">
<!-- 최근글 뽑기 2번 시작 -->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="5"><img src="images/board_tit_left.gif" width="5" height="30"></td>
                                  <td background="images/board_tit_bg.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td><img src="images/board_tit.gif" width="62" height="15"></td>
                                      <td width="45"><% IF strBoardID(2) <> "" THEN %><a href="Mboard.asp?strBoardID=<%=strBoardID(2)%>"><img src="images/more.gif" width="33" height="6" border="0"></a><% END IF %></td>
                                    </tr>
                                  </table></td>
                                  <td width="5"><img src="images/board_tit_right.gif" width="5" height="30"></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td height="7"></td>
                          </tr>
                          <tr>
                            <td style="padding-left:10px">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_NOTICE] '" & strBoardID(2) & "', '', '5' ")

	WHILE NOT(RS.EOF)
%>
                                <tr>
                                  <td width="7"><img src="images/txt_icon2.gif" width="2" height="2"></td>
                                  <td height="18"><a href="Mboard.asp?Action=view&strBoardID=<%=strBoardID(2)%>&intSeq=<%=RS("intSeq")%>"><%=GetCutSubject(RS("strSubject"), 40)%></a></td>
                                </tr>
<%
	RS.MOVENEXT
	WEND
%>
                              </table>
                            </td>
                          </tr>
                        </table>
<!-- 최근글 뽑기 2번 종료 -->
                      </td>
                    </tr>
                    <tr>
                      <td height="25">&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td style="padding-right:25px;" valign="top">
<!-- 최근글 뽑기 3번 시작 -->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="5"><img src="images/board_tit_left.gif" width="5" height="30"></td>
                                  <td background="images/board_tit_bg.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td><img src="images/board_tit.gif" width="62" height="15"></td>
                                      <td width="45"><% IF strBoardID(3) <> "" THEN %><a href="Mboard.asp?strBoardID=<%=strBoardID(3)%>"><img src="images/more.gif" width="33" height="6" border="0"></a><% END IF %></td>
                                    </tr>
                                  </table></td>
                                  <td width="5"><img src="images/board_tit_right.gif" width="5" height="30"></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td height="7"></td>
                          </tr>
                          <tr>
                            <td style="padding-left:10px">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_NOTICE] '" & strBoardID(3) & "', '', '5' ")

	WHILE NOT(RS.EOF)
%>
                                <tr>
                                  <td width="7"><img src="images/txt_icon2.gif" width="2" height="2"></td>
                                  <td height="18"><a href="Mboard.asp?Action=view&strBoardID=<%=strBoardID(3)%>&intSeq=<%=RS("intSeq")%>"><%=GetCutSubject(RS("strSubject"), 40)%></a></td>
                                </tr>
<%
	RS.MOVENEXT
	WEND
%>
                              </table>
                            </td>
                          </tr>
                        </table>
<!-- 최근글 뽑기 3번 종료 -->
                      </td>
                      <td valign="top">
<!-- 최근글 뽑기 4번 시작 -->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="5"><img src="images/board_tit_left.gif" width="5" height="30"></td>
                                  <td background="images/board_tit_bg.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td><img src="images/board_tit.gif" width="62" height="15"></td>
                                      <td width="45"><% IF strBoardID(4) <> "" THEN %><a href="Mboard.asp?strBoardID=<%=strBoardID(4)%>"><img src="images/more.gif" width="33" height="6" border="0"></a><% END IF %></td>
                                    </tr>
                                  </table></td>
                                  <td width="5"><img src="images/board_tit_right.gif" width="5" height="30"></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td height="7"></td>
                          </tr>
                          <tr>
                            <td style="padding-left:10px">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_NOTICE] '" & strBoardID(4) & "', '', '5' ")

	WHILE NOT(RS.EOF)
%>
                                <tr>
                                  <td width="7"><img src="images/txt_icon2.gif" width="2" height="2"></td>
                                  <td height="18"><a href="Mboard.asp?Action=view&strBoardID=<%=strBoardID(4)%>&intSeq=<%=RS("intSeq")%>"><%=GetCutSubject(RS("strSubject"), 40)%></a></td>
                                </tr>
<%
	RS.MOVENEXT
	WEND
%>
                              </table>
                            </td>
                          </tr>
                        </table>
<!-- 최근글 뽑기 4번 종료 -->
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td height="25">&nbsp;</td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="7"><img src="images/gallery_frame_left.gif" width="7" height="129"></td>
                      <td valign="top" background="images/gallery_frame_bg.gif" style="padding:0px 8px 0px 8px">
<!-- 최근글 뽑기 5번 (갤러리) 시작 -->
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_LIST_NOTICE] '" & strBoardID(5) & "', '', '6' ")
%>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="32">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td><img src="images/gallery_tit.gif" width="55" height="13"></td>
                                  <td align="right"><% IF strBoardID(5) <> "" THEN %><a href="Mboard.asp?strBoardID=<%=strBoardID(5)%>"><img src="images/more.gif" width="33" height="6" border="0"></a><% END IF %></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td height="97" align="center">
                              <table width="96%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
<%
	WHILE NOT(RS.EOF)

		IF RS("strFIleImage") = "" OR ISNULL(RS("strFIleImage")) = True THEN
			strFileImage = SPLIT("|||", "|")
		ELSE
			strFileImage = SPLIT(RS("strFIleImage"), "|")
		END IF

		' // 썸네일을 사용하지 않으면 /Thrum 삭제
		strImgPath = "Pds/Board/" & strBoardID(5) & "/Thrum/"
%>
                                  <td width="16%"><a href="Mboard.asp?Action=view&strBoardID=<%=strBoardID(5)%>&intSeq=<%=RS("intSeq")%>"><img src="<%=strImgPath%><%=strFileImage(0)%>" width="100" height="75" border="1" style="border-color:C5C5C5"></a></td>
<%
	RS.MOVENEXT
	WEND
%>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
<!-- 최근글 뽑기 5번 (갤러리) 종료 -->
                      </td>
                      <td width="7"><img src="images/gallery_frame_right.gif" width="7" height="129"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
<!-- #include file = "Foot.asp" -->