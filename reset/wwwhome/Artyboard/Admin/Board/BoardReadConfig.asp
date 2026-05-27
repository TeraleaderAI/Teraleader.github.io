<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu  = 5
	intLeftMenu = 2
	isAdminMenu = 1
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM strBoardID, intBoardConfigMenu
	strBoardID         = REQUEST.QueryString("strBoardID")
	intBoardConfigMenu = 3

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_READ] '" & strBoardID & "' ")

	DIM strNameClick, bitImgView, intImgWidth, intImgHeight, intImgScare, bitImgLightbox, bitImgViewAll, bitFileExe, intExeWidth
	DIM intExeHeight, bitAutoLink, bitWordBreak, bitReadInsert, bitVoteInsert, strBadErrMsg, bitContentIp, strDateTypeView
	DIM bitCommentIp, strDateTypeComment, bitPrevNext, bitListReple, bitListBoard, bitCommentEdit, bitCommentReply, bitUseEditor
	DIM strEditorWidth, strEditorHeight, strEditorWidthReply, strEditorHeightReply, bitEditorSource, bitEditorPrev
	DIM strEditorBgColor, bitEditorZoom, intEditorZoomSize, bitViewSign

	strNameClick         = RS("strNameClick")
	bitImgView           = RS("bitImgView")
	intImgWidth          = RS("intImgWidth")
	intImgHeight         = RS("intImgHeight")
	intImgScare          = RS("intImgScare")
	bitImgLightbox       = RS("bitImgLightbox")
	bitImgViewAll        = RS("bitImgViewAll")
	bitFileExe           = RS("bitFileExe")
	intExeWidth          = RS("intExeWidth")
	intExeHeight         = RS("intExeHeight")
	bitAutoLink          = RS("bitAutoLink")
	bitWordBreak         = RS("bitWordBreak")
	bitReadInsert        = RS("bitReadInsert")
	bitVoteInsert        = RS("bitVoteInsert")
	strBadErrMsg         = RS("strBadErrMsg")
	bitContentIp         = RS("bitContentIp")
	bitCommentIp         = RS("bitCommentIp")
	strDateTypeView      = RS("strDateTypeView")
	strDateTypeComment   = RS("strDateTypeComment")
	bitPrevNext          = RS("bitPrevNext")
	bitListReple         = RS("bitListReple")
	bitListBoard         = RS("bitListBoard")
	bitCommentEdit       = RS("bitCommentEdit")
	bitCommentReply      = RS("bitCommentReply")
	bitUseEditor         = RS("bitUseEditor")
	strEditorWidth       = RS("strEditorWidth")
	strEditorHeight      = RS("strEditorHeight")
	strEditorWidthReply  = RS("strEditorWidthReply")
	strEditorHeightReply = RS("strEditorHeightReply")
	bitEditorSource      = RS("bitEditorSource")
	bitEditorPrev        = RS("bitEditorPrev")
	strEditorBgColor     = RS("strEditorBgColor")
	bitEditorZoom        = RS("bitEditorZoom")
	intEditorZoomSize    = SPLIT(RS("intEditorZoomSize"), "|")
	bitViewSign          = RS("bitViewSign")
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
						<form name="theForm" method="post" action="BoardReadConfig_ok.asp">
						<input type="hidden" name="strBoardID" value="<%=strBoardID%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title23.gif" width="139" height="19"></td>
                      <td align="right">관리자 홈 &gt; 게시판관리 &gt; <b>게시판 글읽기 설정</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><!-- #include file = "BoardConfigMenu.asp" --></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>게시글 출력관련 정보</strong></span></td>
                      <td align="right"><a href="../../mboard.asp?strBoardID=<%=strBoardID%>" target="_blank"><img src="../images/btn_board_view_g.gif" width="80" height="19" align="absmiddle" border="0"></a>
											<input name="imageField2" type="image" id="imageField" src="../images/btn_board_submit_g.gif" align="absmiddle" class="no_Line"></td>
                    </tr>
                  </table>
                </td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitImgView,intImgWidth,intImgHeight,intImgScare,bitImgLightbox,bitImgViewAll" class="no_Line">이미지파일 본문출력</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="26" colspan="2"><input name="bitImgView" type="checkbox" id="bitImgView" value="1"<% IF bitImgView = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitImgView" style="cursor:hand">본문에 첨부 이미지 출력</LABEL>&nbsp;<span style="color: #E86A34;">첨부된 이미지를 본문에 출력합니다.</span></td>
													</tr>
													<tr>
														<td width="50%" height="26">가로 출력 사이즈 &nbsp;<input name="intImgWidth" type="text" id="intImgWidth"onBlur="onlynum(this, '1');" value="<%=intImgWidth%>" size="4" maxlength="10">&nbsp;Pixel</td>
														<td width="50%" height="26">세로 출력 사이즈 &nbsp;<input name="intImgHeight" type="text" id="intImgHeight"onBlur="onlynum(this, '1');" value="<%=intImgHeight%>" size="4" maxlength="10">&nbsp;Pixel</td>
													</tr>
													<tr>
														<td height="26" colspan="2"><input name="intImgScare" type="checkbox" id="intImgScare" value="1"<% IF intImgScare = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="intImgScare" style="cursor:hand">원본 이미지 비율 유지</LABEL>&nbsp;<span style="color: #E86A34;">출력사이즈를 0으로 설정하면 원본대로 출력됩니다.</span></td>
													</tr>
													<tr>
														<td height="26" colspan="2">
                            <input type="radio" name="bitImgLightbox" id="bitImgLightbox1" value="1"<% IF bitImgLightbox = True THEN %> CHECKED<% END IF %> class="no_Line" /><LABEL FOR="bitImgLightbox1" style="cursor:hand">라이트박스 확대 이미지 사용</LABEL>
														<input type="radio" name="bitImgLightbox" id="bitImgLightbox2" value="0"<% IF bitImgLightbox = False THEN %> CHECKED<% END IF %> class="no_Line" /><LABEL FOR="bitImgLightbox2" style="cursor:hand">일반 확대 이미지 사용</LABEL><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #E86A34;">라이트박스 확대 이미지 사용시 이미지는 전체 본문에 출력됩니다.</span>
														</td>
													</tr>
													<tr>
														<td height="26" colspan="2">
                            <input type="radio" name="bitImgViewAll" id="bitImgViewAll1" value="1"<% IF bitImgViewAll = True THEN %> CHECKED<% END IF %> class="no_Line" /><LABEL FOR="bitImgViewAll1" style="cursor:hand">전체 이미지 본문출력</LABEL>
														<input type="radio" name="bitImgViewAll" id="bitImgViewAll2" value="0"<% IF bitImgViewAll = False THEN %> CHECKED<% END IF %> class="no_Line" /><LABEL FOR="bitImgViewAll2" style="cursor:hand">링크 이미지 본문출력</LABEL>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitFileExe,intExeWidth,intExeHeight" class="no_Line">첨부파일 실행</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="26" colspan="2">첨부파일 실행&nbsp;&nbsp;<input type="radio" name="bitFileExe" id="bitFileExe1" value="1"<% IF bitFileExe = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitFileExe1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitFileExe" id="bitFileExe2" value="0"<% IF bitFileExe = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitFileExe2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">웹 페이지에서 실행이 가능한 첨부파일을 실행합니다.</font></td>
													</tr>
													<tr>
														<td width="50%" height="26">가로 출력 사이즈 &nbsp;<input name="intExeWidth" type="text" id="intExeWidth"onBlur="onlynum(this, '1');" value="<%=intExeWidth%>" size="4" maxlength="10">&nbsp;Pixel</td>
														<td width="50%">세로 출력 사이즈 &nbsp;<input name="intExeHeight" type="text" id="intExeHeight"onBlur="onlynum(this, '1');" value="<%=intExeHeight%>" size="4" maxlength="10">&nbsp;Pixel</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitAutoLink" class="no_Line">본문 자동링크</td>
											<td class="table_Right1"><input type="radio" name="bitAutoLink" id="bitAutoLink1" value="1"<% IF bitAutoLink = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitAutoLink1" style="cursor:hand">사용함(URL, 이메일에 대한 자동링크)</LABEL><input type="radio" name="bitAutoLink" id="bitAutoLink2" value="0"<% IF bitAutoLink = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitAutoLink2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">본문 게시글의 링크를 자동으로 연결합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitWordBreak" class="no_Line">자동 줄바꿈</td>
											<td class="table_Right1"><input type="radio" name="bitWordBreak" id="bitWordBreak1" value="1"<% IF bitWordBreak = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitWordBreak1" style="cursor:hand">사용함(본문 테이블 너비에 맞게 자동 줄바꿈)</LABEL><input type="radio" name="bitWordBreak" id="bitWordBreak2" value="0"<% IF bitWordBreak = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitWordBreak2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">페이지 너비에 맞게 줄바꿈을 합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitContentIp" class="no_Line">본문 IP 출력</td>
											<td class="table_Right1"><input type="radio" name="bitContentIp" id="bitContentIp1" value="1"<% IF bitContentIp = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitContentIp1" style="cursor:hand">사용함(게시글 등록자 IP 출력)</LABEL><input type="radio" name="bitContentIp" id="bitContentIp2" value="0"<% IF bitContentIp = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitContentIp2" style="cursor:hand">사용안함</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strDateTypeView" class="no_Line">본문 날짜 출력형식</td>
											<td class="table_Right1"><select name="strDateTypeView" id="strDateTypeView">
												<option value="0"<% IF strDateTypeView = "0" THEN %> SELECTED<% END IF %>>년/월/일 시:분</option>
												<option value="1"<% IF strDateTypeView = "1" THEN %> SELECTED<% END IF %>>년/월/일</option>
												<option value="2"<% IF strDateTypeView = "2" THEN %> SELECTED<% END IF %>>월/일</option>
												<option value="3"<% IF strDateTypeView = "3" THEN %> SELECTED<% END IF %>>월/일 시:분</option>
												<option value="4"<% IF strDateTypeView = "4" THEN %> SELECTED<% END IF %>>일 시:분</option>
												<option value="5"<% IF strDateTypeView = "5" THEN %> SELECTED<% END IF %>>년/월/일 시:분:초</option>
												</select>&nbsp;<font color="#E86A34">게시글 등록일자의 출력형식을 설정합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>게시글 본문 기능정보</strong></span></td>
                      <td align="right"><a href="../../mboard.asp?strBoardID=<%=strBoardID%>" target="_blank"><img src="../images/btn_board_view_g.gif" width="80" height="19" align="absmiddle" border="0"></a>
											<input name="imageField2" type="image" id="imageField" src="../images/btn_board_submit_g.gif" align="absmiddle" class="no_Line"></td>
                    </tr>
                  </table>
                </td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strNameClick" class="no_Line">등록자 클릭 설정</td>
											<td class="table_Right1"><input type="radio" name="strNameClick" id="strNameClick1" value="0"<% IF strNameClick = 0 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strNameClick1" style="cursor:hand">메뉴창 실행(회원전용)</LABEL>&nbsp;<input type="radio" name="strNameClick" id="strNameClick2" value="1"<% IF strNameClick = 1 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strNameClick2" style="cursor:hand">아이디/이름으로 검색/이메일/홈페이지</LABEL>&nbsp;<input type="radio" name="strNameClick" id="strNameClick3" value="2"<% IF strNameClick = 2 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strNameClick3" style="cursor:hand">이메일</LABEL>&nbsp;<input type="radio" name="strNameClick" id="strNameClick4" value="3"<% IF strNameClick = 3 THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strNameClick4" style="cursor:hand">없음</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitReadInsert" class="no_Line">조회수 증가</td>
											<td class="table_Right1"><input type="radio" name="bitReadInsert" id="bitReadInsert1" value="1"<% IF bitReadInsert = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitReadInsert1" style="cursor:hand">사용함(한번만 증가함)</LABEL><input type="radio" name="bitReadInsert" id="bitReadInsert2" value="0"<% IF bitReadInsert = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitReadInsert2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">게시판의 조회수의 증가를 설정합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitVoteInsert" class="no_Line">게시글 추천</td>
											<td class="table_Right1"><input type="radio" name="bitVoteInsert" id="bitVoteInsert1" value="1"<% IF bitVoteInsert = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitVoteInsert1" style="cursor:hand">1회추천(한번만 증가함)</LABEL><input type="radio" name="bitVoteInsert" id="bitVoteInsert2" value="0"<% IF bitVoteInsert = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitVoteInsert2" style="cursor:hand">다중추천(여러번 추천)</LABEL>&nbsp;<font color="#E86A34">게시판의 조회수의 증가를 설정합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strBadErrMsg" class="no_Line">불량 게시글 열람<br>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;메시지 </td>
											<td class="table_Right1"><input name="strBadErrMsg" type="text" id="strBadErrMsg" value="<%=strBadErrMsg%>" maxlength="128" style="width:95%"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitViewSign" class="no_Line">개인서명 본문출력</td>
											<td class="table_Right1"><input type="radio" name="bitViewSign" id="bitViewSign1" value="1"<% IF bitViewSign = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitViewSign1" style="cursor:hand">출력함</LABEL><input type="radio" name="bitViewSign" id="bitViewSign2" value="0"<% IF bitViewSign = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitViewSign2" style="cursor:hand">출력안함</LABEL>&nbsp;<font color="#E86A34">등록된 회원의 서명을 본문에 출력합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitPrevNext" class="no_Line">이전글 다음글 출력</td>
											<td class="table_Right1"><input type="radio" name="bitPrevNext" id="bitPrevNext1" value="1"<% IF bitPrevNext = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitPrevNext1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitPrevNext" id="bitPrevNext2" value="0"<% IF bitPrevNext = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitPrevNext2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">열람한 게시글의 이전글과 다음글을 출력합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitListReple" class="no_Line">답변글 리스트 출력</td>
											<td class="table_Right1"><input type="radio" name="bitListReple" id="bitListReple1" value="1"<% IF bitListReple = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitListReple1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitListReple" id="bitListReple2" value="0"<% IF bitListReple = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitListReple2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">열람한 게시글의 답변이 있으면 답변글을 출력합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitListBoard" class="no_Line">게시글 리스트 출력</td>
											<td class="table_Right1"><input type="radio" name="bitListBoard" id="bitListBoard1" value="1"<% IF bitListBoard = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitListBoard1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitListBoard" id="bitListBoard2" value="0"<% IF bitListBoard = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitListBoard2" style="cursor:hand">사용안함</LABEL>&nbsp;<font color="#E86A34">본문페이지 아래에 게시판 리스트를 출력합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>댓글 관련 정보</strong></span></td>
                      <td align="right"><a href="../../mboard.asp?strBoardID=<%=strBoardID%>" target="_blank"><img src="../images/btn_board_view_g.gif" width="80" height="19" align="absmiddle" border="0"></a>
											<input name="imageField2" type="image" id="imageField" src="../images/btn_board_submit_g.gif" align="absmiddle" class="no_Line"></td>
                    </tr>
                  </table>
                </td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitCommentIp" class="no_Line">댓글 IP 출력</td>
											<td class="table_Right1"><input type="radio" name="bitCommentIp" id="bitCommentIp1" value="1"<% IF bitCommentIp = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitCommentIp1" style="cursor:hand">사용함(댓글 등록자 IP 출력)</LABEL><input type="radio" name="bitCommentIp" id="bitCommentIp2" value="0"<% IF bitCommentIp = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitCommentIp2" style="cursor:hand">사용안함</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strDateTypeComment" class="no_Line">댓글 날짜 출력형식</td>
											<td class="table_Right1"><select name="strDateTypeComment" id="strDateTypeComment">
												<option value="0"<% IF strDateTypeComment = "0" THEN %> SELECTED<% END IF %>>년/월/일 시:분</option>
												<option value="1"<% IF strDateTypeComment = "1" THEN %> SELECTED<% END IF %>>년/월/일</option>
												<option value="2"<% IF strDateTypeComment = "2" THEN %> SELECTED<% END IF %>>월/일</option>
												<option value="3"<% IF strDateTypeComment = "3" THEN %> SELECTED<% END IF %>>월/일 시:분</option>
												<option value="4"<% IF strDateTypeComment = "4" THEN %> SELECTED<% END IF %>>일 시:분</option>
												<option value="5"<% IF strDateTypeComment = "5" THEN %> SELECTED<% END IF %>>년/월/일 시:분:초</option>
												</select>&nbsp;<font color="#E86A34">댓글 등록일자의 출력형식을 설정합니다.</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitCommentEdit" class="no_Line">댓글내용 수정</td>
											<td class="table_Right1"><input type="radio" name="bitCommentEdit" id="bitCommentEdit1" value="1"<% IF bitCommentEdit = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitCommentEdit1" style="cursor:hand">사용함 (댓글수정 가능)</LABEL><input type="radio" name="bitCommentEdit" id="bitCommentEdit2" value="0"<% IF bitCommentEdit = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitCommentEdit2" style="cursor:hand">사용안함 (댓글수정 불가)</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitCommentReply" class="no_Line">댓글답변 기능</td>
											<td class="table_Right1"><input type="radio" name="bitCommentReply" id="bitCommentReply1" value="1"<% IF bitCommentReply = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitCommentReply1" style="cursor:hand">사용함 (댓글답변 등록가능)</LABEL><input type="radio" name="bitCommentReply" id="bitCommentReply2" value="0"<% IF bitCommentReply = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitCommentReply2" style="cursor:hand">사용안함 (댓글답변 등록불가)</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="bitUseEditor,strEditorWidth,strEditorHeight,bitEditorSource,bitEditorPrev,strEditorBgColor,bitEditorZoom,intEditorZoomSize" class="no_Line">웹 에디터 정보</td>
											<td class="table_Right1">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="130" height="24">에디터 사용유뮤</td>
														<td height="24"><input type="radio" name="bitUseEditor" id="bitUseEditor1" value="1"<% IF bitUseEditor = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseEditor1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitUseEditor" id="bitUseEditor2" value="0"<% IF bitUseEditor = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseEditor2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
													<tr>
														<td height="24">에디터 크기 (일반등록)</td>
														<td height="24">너비&nbsp;<input name="strEditorWidth" type="text" id="strEditorWidth" value="<%=strEditorWidth%>" size="6" maxlength="6">&nbsp;(px 또는 %)&nbsp;&nbsp;&nbsp;높이&nbsp;<input name="strEditorHeight" type="text" id="strEditorHeight" value="<%=strEditorHeight%>" size="6" maxlength="6">&nbsp;(px 또는 %)</td>
													</tr>
													<tr>
														<td height="24">에디터 크기 (수정/답변)</td>
														<td height="24">너비&nbsp;<input name="strEditorWidthReply" type="text" id="strEditorWidthReply" value="<%=strEditorWidthReply%>" size="6" maxlength="6">&nbsp;(px 또는 %)&nbsp;&nbsp;&nbsp;높이&nbsp;<input name="strEditorHeightReply" type="text" id="strEditorHeightReply" value="<%=strEditorHeightReply%>" size="6" maxlength="6">&nbsp;(px 또는 %)</td>
													</tr>
													<tr>
														<td height="24">소스보기</td>
														<td height="24"><input type="radio" name="bitEditorSource" id="bitEditorSource1" value="1"<% IF bitEditorSource = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitEditorSource1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitEditorSource" id="bitEditorSource2" value="0"<% IF bitEditorSource = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitEditorSource2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
													<tr>
														<td height="24">미리보기</td>
														<td height="24"><input type="radio" name="bitEditorPrev" id="bitEditorPrev1" value="1"<% IF bitEditorPrev = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitEditorPrev1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitEditorPrev" id="bitEditorPrev2" value="0"<% IF bitEditorPrev = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitEditorPrev2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
													<tr>
														<td height="24">편집 배경색</td>
														<td height="24"><input name="strEditorBgColor" type="text" id="strEditorBgColor" onBlur="OnColorSet(document.all['strEditorBgColorPrev'], this);" value="<%=strEditorBgColor%>" size="8" maxlength="7">&nbsp;<INPUT style="BACKGROUND: <%=strEditorBgColor%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strEditorBgColor',410,430);" READONLY size=2 name="strEditorBgColorPrev"></td>
													</tr>
													<tr>
														<td height="24">이미지 ZOOM</td>
														<td height="24"><input type="radio" name="bitEditorZoom" id="bitEditorZoom1" value="1"<% IF bitEditorZoom = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitEditorZoom1" style="cursor:hand">사용함</LABEL><input type="radio" name="bitEditorZoom" id="bitEditorZoom2" value="0"<% IF bitEditorZoom = False THEN %> CHECKED<% END IF %> class="no_Line">
<LABEL FOR="bitEditorZoom2" style="cursor:hand">사용안함</LABEL></td>
													</tr>
													<tr>
														<td height="24">ZOOM 이미지 사이즈</td>
														<td height="24">
														가로&nbsp;<input name="intEditorZoomSize1" type="text" id="intEditorZoomSize1" size="6" maxlength="4" value="<%=intEditorZoomSize(0)%>" onBlur="onlynum(this, 1);">
														&nbsp;px
														세로&nbsp;<input name="intEditorZoomSize2" type="text" id="intEditorZoomSize2" size="6" maxlength="4" value="<%=intEditorZoomSize(1)%>" onBlur="onlynum(this, 1);">
														&nbsp;px
														<font color="#E86A34">이미지 ZOOM 사용시만 적용</font></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td style="padding-left:15;"><a href="javascript:;" onClick="OnConfigSelect();return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0" align="absmiddle"></a>&nbsp;&nbsp;<a href="javascript:;" onclick="OnBoardConfigCopy('3','<%=strBoardID%>');return false;"><img src="../images/btn_config_copy_w.gif" width="121" height="19" border="0" align="absmiddle"></a></td>
											<td align="right" style="padding-right:20;"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>게시판 게시글 읽기에 관련된 환경설정을 설정하실 수 있습니다.</LI>
											</td>
										</tr>
									</table>
									</fieldset>
								</td>
							</tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							</form>
            </table>
<!-- #include file = "Foot.asp" -->