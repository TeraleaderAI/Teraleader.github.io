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
	intBoardConfigMenu = 6

	SET RS = DBCON.EXECUTE("SELECT COUNT([strGroupCode]) FROM [MPLUS_GROUP] ")
	intGroupCount = RS(0)

	REDIM strGroupListDim(intGroupCount)
	REDIM strGroupListValueDim(intGroupCount)

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_GROUP] ")
	iCount = -1
	WHILE NOT(RS.EOF)
		iCount = iCount + 1
		strGroupListDim(iCount)      = RS("strGroupName")
		strGroupListValueDim(iCount) = RS("intLevel")
	RS.MOVENEXT
	WEND

	SET RS = DBCON.EXECUTE("SELECT [strListLevel], [strListLevelUrl], [bitListLevelLogin], [strReadLevel], [strReadLevelUrl], [bitReadLevelLogin], [strWriteLevel], [strWriteLevelUrl], [bitWriteLevelLogin], [strRepleLevel], [strRepleLevelUrl], [bitRepleLevelLogin], [strWriteCommentLevel], [strReplyCommentLevel], [strReadCommentLevel], [strSubjectStyleLevel], [strUploadLevel], [strDownLevel] FROM [MPLUS_GROUP_BOARD] WHERE [strBoardID] = '" & strBoardID & "' ")

	DIM strListLevel, strListLevelUrl, bitListLevelLogin, strReadLevel, strReadLevelUrl, bitReadLevelLogin, strWriteLevel
	DIM strWriteLevelUrl, bitWriteLevelLogin, strRepleLevel, strRepleLevelUrl, bitRepleLevelLogin, strWriteCommentLevel
	DIM strReplyCommentLevel, strReadCommentLevel, strSubjectStyleLevel, strUploadLevel, strDownLevel

	strListLevel         = SPLIT(RS("strListLevel"), "|")
	strListLevelUrl      = RS("strListLevelUrl")
	bitListLevelLogin    = RS("bitListLevelLogin")
	strReadLevel         = SPLIT(RS("strReadLevel"), "|")
	strReadLevelUrl      = RS("strReadLevelUrl")
	bitReadLevelLogin    = RS("bitReadLevelLogin")
	strWriteLevel        = SPLIT(RS("strWriteLevel"), "|")
	strWriteLevelUrl     = RS("strWriteLevelUrl")
	bitWriteLevelLogin   = RS("bitWriteLevelLogin")
	strRepleLevel        = SPLIT(RS("strRepleLevel"), "|")
	strRepleLevelUrl     = RS("strRepleLevelUrl")
	bitRepleLevelLogin   = RS("bitRepleLevelLogin")
	strWriteCommentLevel = SPLIT(RS("strWriteCommentLevel"), "|")
	strReplyCommentLevel = SPLIT(RS("strReplyCommentLevel"), "|")
	strReadCommentLevel  = SPLIT(RS("strReadCommentLevel"), "|")
	strSubjectStyleLevel = SPLIT(RS("strSubjectStyleLevel"), "|")
	strUploadLevel       = SPLIT(RS("strUploadLevel"), "|")
	strDownLevel         = SPLIT(RS("strDownLevel"), "|")

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_POINT] '" & strBoardID & "' ")

	DIM bitUsePoint, intReadPoint, intDownPoint, intVotePoint, intWritePoint, intReplePoint, intUploadPoint, intCommentPoint

	bitUsePoint     = RS("bitUsePoint")
	intReadPoint    = RS("intReadPoint")
	intDownPoint    = RS("intDownPoint")
	intVotePoint    = RS("intVotePoint")
	intWritePoint   = RS("intWritePoint")
	intReplePoint   = RS("intReplePoint")
	intUploadPoint  = RS("intUploadPoint")
	intCommentPoint = RS("intCommentPoint")
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" action="BoardPointConfig_ok.asp" onSubmit="return OnSubmitAction();">
							<input type="hidden" name="strBoardID" value="<%=strBoardID%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title26.gif" width="172" height="19"></td>
                      <td align="right">관리자 홈 &gt; 게시판관리 &gt; <b>게시판 권한/포인트 설정</b></td>
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
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>게시판 권한설정</strong></span></td>
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
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strListLevel,strListLevelUrl" class="no_Line">게시글 목록보기</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="220" height="24"><select name="strListLevel1" id="strListLevel1"<% IF strListLevel(0) = 1 THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF strListLevel(0) = "0" THEN
			IF INT(strListLevel(1)) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value=" & strGroupListValueDim(I) & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
														</select>&nbsp;이상&nbsp;
														<input name="strListLevel2" type="checkbox" id="strListLevel2" value="1"<% IF strListLevel(0) = 1 THEN %> CHECKED<% END IF %> onClick="OnLevelDisabled('strListLevel1', this);" class="no_Line"><LABEL FOR="strListLevel2" style="cursor:hand">제한없음</LABEL></td>
														<td height="24">출력 메시지&nbsp;
														<input name="strListLevel3" type="text" id="strCategoryName" value="<%=strListLevel(2)%>" size="54"></td>
													</tr>
													<tr>
														<td height="24">&nbsp;</td>
														<td height="24">페이지 이동&nbsp;
														<input name="strListLevelUrl" type="text" id="strCategoryName" value="<%=strListLevelUrl%>" size="54"> </td>
													</tr>
													<tr>
														<td height="24">&nbsp;</td>
														<td height="24"><input name="bitListLevelLogin" type="checkbox" id="bitListLevelLogin" value="1" class="no_Line"<% IF bitListLevelLogin = True THEN %> CHECKED<% END IF %>><LABEL FOR="bitListLevelLogin" style="cursor:hand"><font color="#FD8402">로그인 페이지로 이동 (게시판스킨)</font></LABEL></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strReadLevel,strReadLevelUrl" class="no_Line">게시글 읽기</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="220" height="24"><select name="strReadLevel1" id="strReadLevel1"<% IF strReadLevel(0) = 1 THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF strReadLevel(0) = "0" THEN
			IF INT(strReadLevel(1)) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value=" & strGroupListValueDim(I) & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
														</select>&nbsp;이상&nbsp;
														<input name="strReadLevel2" type="checkbox" id="strReadLevel2" value="1"<% IF strReadLevel(0) = 1 THEN %> CHECKED<% END IF %> onClick="OnLevelDisabled('strReadLevel1', this);" class="no_Line"><LABEL FOR="strReadLevel2" style="cursor:hand">제한없음</LABEL></td>
														<td height="24">출력 메시지&nbsp;
														<input name="strReadLevel3" type="text" id="strCategoryName" value="<%=strReadLevel(2)%>" size="54"></td>
													</tr>
													<tr>
														<td height="24">&nbsp;</td>
														<td height="24">페이지 이동&nbsp;
														<input name="strReadLevelUrl" type="text" id="strCategoryName" value="<%=strReadLevelUrl%>" size="54"></td>
													</tr>
													<tr>
														<td height="24">&nbsp;</td>
														<td height="24"><input name="bitReadLevelLogin" type="checkbox" id="bitReadLevelLogin" value="1" class="no_Line"<% IF bitReadLevelLogin = True THEN %> CHECKED<% END IF %>><LABEL FOR="bitReadLevelLogin" style="cursor:hand"><font color="#FD8402">로그인 페이지로 이동 (게시판스킨)</font></LABEL></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strWriteLevel,strWriteLevelUrl" class="no_Line">게시글 쓰기</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="220" height="24"><select name="strWriteLevel1" id="strWriteLevel1"<% IF strWriteLevel(0) = 1 THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF strWriteLevel(0) = "0" THEN
			IF INT(strWriteLevel(1)) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value='" & strGroupListValueDim(I) & "'" & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
														</select>&nbsp;이상&nbsp;
														<input name="strWriteLevel2" type="checkbox" id="strWriteLevel2" value="1"<% IF strWriteLevel(0) = 1 THEN %> CHECKED<% END IF %> onClick="OnLevelDisabled('strWriteLevel1', this);" class="no_Line"><LABEL FOR="strWriteLevel2" style="cursor:hand">제한없음</LABEL></td>
														<td height="24">출력 메시지&nbsp;
														<input name="strWriteLevel3" type="text" id="strCategoryName" value="<%=strWriteLevel(2)%>" size="54"></td>
													</tr>
													<tr>
														<td height="24">&nbsp;</td>
														<td height="24">페이지 이동&nbsp;
														<input name="strWriteLevelUrl" type="text" id="strCategoryName" value="<%=strWriteLevelUrl%>" size="54"></td>
													</tr>
													<tr>
														<td height="24">&nbsp;</td>
														<td height="24"><input name="bitWriteLevelLogin" type="checkbox" id="bitWriteLevelLogin" value="1" class="no_Line"<% IF bitWriteLevelLogin = True THEN %> CHECKED<% END IF %>><LABEL FOR="bitWriteLevelLogin" style="cursor:hand"><font color="#FD8402">로그인 페이지로 이동 (게시판스킨)</font></LABEL></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strRepleLevel,strRepleLevelUrl" class="no_Line">답변글 쓰기</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="220" height="24"><select name="strRepleLevel1" id="strRepleLevel1"<% IF strRepleLevel(0) = 1 THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF strRepleLevel(0) = "0" THEN
			IF INT(strRepleLevel(1)) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value=" & strGroupListValueDim(I) & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
														</select>&nbsp;이상&nbsp;
														<input name="strRepleLevel2" type="checkbox" id="strRepleLevel2" value="1"<% IF strRepleLevel(0) = 1 THEN %> CHECKED<% END IF %> onClick="OnLevelDisabled('strRepleLevel1', this);" class="no_Line"><LABEL FOR="strRepleLevel2" style="cursor:hand">제한없음</LABEL></td>
														<td height="24">출력 메시지&nbsp;
														<input name="strRepleLevel3" type="text" id="strCategoryName" value="<%=strRepleLevel(2)%>" size="54"></td>
													</tr>
													<tr>
														<td height="24">&nbsp;</td>
															<td height="24">페이지 이동&nbsp;
															<input name="strRepleLevelUrl" type="text" id="strCategoryName" value="<%=strRepleLevelUrl%>" size="54"></td>
													</tr>
													<tr>
														<td height="24">&nbsp;</td>
														<td height="24"><input name="bitRepleLevelLogin" type="checkbox" id="bitRepleLevelLogin" value="1" class="no_Line"<% IF bitRepleLevelLogin = True THEN %> CHECKED<% END IF %>><LABEL FOR="bitRepleLevelLogin" style="cursor:hand"><font color="#FD8402">로그인 페이지로 이동 (게시판스킨)</font></LABEL></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strWriteCommentLevel" class="no_Line">댓글 쓰기</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="220" height="24"><select name="strWriteCommentLevel1" id="strWriteCommentLevel1"<% IF strWriteCommentLevel(0) = 1 THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF strWriteCommentLevel(0) = "0" THEN
			IF INT(strWriteCommentLevel(1)) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value=" & strGroupListValueDim(I) & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
														</select>&nbsp;이상&nbsp;
														<input name="strWriteCommentLevel2" type="checkbox" id="strWriteCommentLevel2" value="1"<% IF strWriteCommentLevel(0) = 1 THEN %> CHECKED<% END IF %> onClick="OnLevelDisabled('strWriteCommentLevel1', this);" class="no_Line"><LABEL FOR="strWriteCommentLevel2" style="cursor:hand">제한없음</LABEL></td>
														<td height="24">출력 메시지&nbsp;
														<input name="strWriteCommentLevel3" type="text" id="strCategoryName" value="<%=strWriteCommentLevel(2)%>" size="54"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strReplyCommentLevel" class="no_Line">댓글 답변글 쓰기</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="220" height="24"><select name="strReplyCommentLevel1" id="strReplyCommentLevel1"<% IF strReplyCommentLevel(0) = 1 THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF strReplyCommentLevel(0) = "0" THEN
			IF INT(strReplyCommentLevel(1)) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value=" & strGroupListValueDim(I) & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
														</select>&nbsp;이상&nbsp;
														<input name="strReplyCommentLevel2" type="checkbox" id="strReplyCommentLevel2" value="1"<% IF strReplyCommentLevel(0) = 1 THEN %> CHECKED<% END IF %> onClick="OnLevelDisabled('strReplyCommentLevel1', this);" class="no_Line"><LABEL FOR="strReplyCommentLevel2" style="cursor:hand">제한없음</LABEL></td>
														<td height="24">출력 메시지&nbsp;
														<input name="strReplyCommentLevel3" type="text" id="strCategoryName" value="<%=strReplyCommentLevel(2)%>" size="54"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strReadCommentLevel" class="no_Line">댓글 읽기</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="220" height="24"><select name="strReadCommentLevel1" id="strReadCommentLevel1"<% IF strReadCommentLevel(0) = 1 THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF strReadCommentLevel(0) = "0" THEN
			IF INT(strReadCommentLevel(1)) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value=" & strGroupListValueDim(I) & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
														</select>&nbsp;이상&nbsp;
														<input name="strReadCommentLevel2" type="checkbox" id="strReadCommentLevel2" value="1"<% IF strReadCommentLevel(0) = 1 THEN %> CHECKED<% END IF %> onClick="OnLevelDisabled('strReadCommentLevel1', this);" class="no_Line"><LABEL FOR="strReadCommentLevel2" style="cursor:hand">제한없음</LABEL></td>
														<td height="24">&nbsp;</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strSubjectStyleLevel" class="no_Line">제목 스타일 설정</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="220" height="24"><select name="strSubjectStyleLevel1" id="strSubjectStyleLevel1"<% IF strSubjectStyleLevel(0) = 1 THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF strSubjectStyleLevel(0) = "0" THEN
			IF INT(strSubjectStyleLevel(1)) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value=" & strGroupListValueDim(I) & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
														</select>&nbsp;이상&nbsp;
														<input name="strSubjectStyleLevel2" type="checkbox" id="strSubjectStyleLevel2" value="1"<% IF strSubjectStyleLevel(0) = 1 THEN %> CHECKED<% END IF %> onClick="OnLevelDisabled('strSubjectStyleLevel1', this);" class="no_Line"><LABEL FOR="strSubjectStyleLevel2" style="cursor:hand">제한없음</LABEL></td>
														<td height="24">&nbsp;</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strUploadLevel" class="no_Line">파일 업로드</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="220" height="24"><select name="strUploadLevel1" id="strUploadLevel1"<% IF strUploadLevel(0) = 1 THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF strRepleLevel(0) = "0" THEN
			IF INT(strUploadLevel(1)) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value=" & strGroupListValueDim(I) & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
														</select>&nbsp;이상&nbsp;
														<input name="strUploadLevel2" type="checkbox" id="strUploadLevel2" value="1"<% IF strUploadLevel(0) = 1 THEN %> CHECKED<% END IF %> onClick="OnLevelDisabled('strUploadLevel1', this);" class="no_Line"><LABEL FOR="strUploadLevel2" style="cursor:hand">제한없음</LABEL></td>
														<td height="24">&nbsp;</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfig" type="checkbox" id="copyConfig" value="strDownLevel" class="no_Line">파일 다운로드</td>
											<td class="table_Right1">
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="220" height="24"><select name="strDownLevel1" id="strDownLevel1"<% IF strDownLevel(0) = 1 THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF strRepleLevel(0) = "0" THEN
			IF INT(strDownLevel(1)) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value=" & strGroupListValueDim(I) & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
														</select>&nbsp;이상&nbsp;
														<input name="strDownLevel2" type="checkbox" id="strDownLevel2" value="1"<% IF strDownLevel(0) = 1 THEN %> CHECKED<% END IF %> onClick="OnLevelDisabled('strDownLevel1', this);" class="no_Line"><LABEL FOR="strDownLevel2" style="cursor:hand">제한없음</LABEL></td>
														<td height="24">&nbsp;</td>
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
                <td height="30">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>게시판 포인트 설정</strong></span></td>
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
											<td class="table_Left1"><input name="copyConfigRe" type="checkbox" id="copyConfigRe" value="bitUsePoint" class="no_Line">포인트 사용</td>
											<td class="table_Right1"><input name="bitUsePoint" type="checkbox" id="bitUsePoint" value="1"<% IF bitUsePoint = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUsePoint" style="cursor:hand">포인트 기능을 사용합니다.</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfigRe" type="checkbox" id="copyConfigRe" value="intReadPoint" class="no_Line">게시글 읽기</td>
											<td class="table_Right1"><input name="intReadPoint" type="text" id="intReadPoint" onBlur="onlyInt(this);" value="<%=intReadPoint%>" size="4" maxlength="4"> 
											포인트를 지급 또는 차감 합니다.</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfigRe" type="checkbox" id="copyConfigRe" value="intDownPoint" class="no_Line">첨부파일 다운로드</td>
											<td class="table_Right1"><input name="intDownPoint" type="text" id="intDownPoint" onBlur="onlyInt(this);" value="<%=intDownPoint%>" size="4" maxlength="4">
											포인트를 지급 또는 차감 합니다.</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfigRe" type="checkbox" id="copyConfigRe" value="intVotePoint" class="no_Line">게시글 추천</td>
											<td class="table_Right1"><input name="intVotePoint" type="text" id="intVotePoint" onBlur="onlyInt(this);" value="<%=intVotePoint%>" size="4" maxlength="4">
											포인트를 지급 또는 차감 합니다.</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfigRe" type="checkbox" id="copyConfigRe" value="intWritePoint" class="no_Line">게시글 쓰기</td>
											<td class="table_Right1"><input name="intWritePoint" type="text" id="intWritePoint" onBlur="onlyInt(this);" value="<%=intWritePoint%>" size="4" maxlength="4">
											포인트를 지급 또는 차감 합니다.</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfigRe" type="checkbox" id="copyConfigRe" value="intReplePoint" class="no_Line">답변글 쓰기</td>
											<td class="table_Right1"><input name="intReplePoint" type="text" id="intReplePoint" onBlur="onlyInt(this);" value="<%=intReplePoint%>" size="4" maxlength="4">
											포인트를 지급 또는 차감 합니다.</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfigRe,bitUploadCount" type="checkbox" id="copyConfigRe" value="intUploadPoint" class="no_Line">첨부파일 업로드</td>
											<td class="table_Right1"><input name="intUploadPoint" type="text" id="intUploadPoint" onBlur="onlyInt(this);" value="<%=intUploadPoint%>" size="4" maxlength="4">
											포인트를 지급 또는 차감 합니다.</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1"><input name="copyConfigRe" type="checkbox" id="copyConfigRe" value="intCommentPoint" class="no_Line">댓글 쓰기</td>
											<td class="table_Right1"><input name="intCommentPoint" type="text" id="intCommentPoint" onBlur="onlyInt(this);" value="<%=intCommentPoint%>" size="4" maxlength="4">
											포인트를 지급 또는 차감 합니다. </td>
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
											<td style="padding-left:15;"><a href="javascript:;" onClick="OnConfigSelectRe();return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0" align="absmiddle"></a>&nbsp;&nbsp;<a href="javascript:;" onclick="OnBoardConfigCopy('5','<%=strBoardID%>');return false;"><img src="../images/btn_config_copy_w.gif" width="121" height="19" border="0" align="absmiddle"></a></td>
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
											<LI>게시판별 포인트 및 액션에 따른 권한설정을 설정하실 수 있습니다.</LI>
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
<script language="javascript">
	function OnLevelDisabled(obj1, obj2){
		if (obj2.checked == true){
			document.all[obj1].disabled = true;
		}else{
			document.all[obj1].disabled = false;
		}
	}

	function OnSubmitAction(){
		document.all['strListLevel1'].disabled = false;
		document.all['strReadLevel1'].disabled = false;
		document.all['strWriteLevel1'].disabled = false;
		document.all['strRepleLevel1'].disabled = false;
		document.all['strWriteCommentLevel1'].disabled = false;
		document.all['strReplyCommentLevel1'].disabled = false;
		document.all['strReadCommentLevel1'].disabled = false;
		document.all['strUploadLevel1'].disabled = false;
		document.all['strSubjectStyleLevel1'].disabled = false;
		document.all['strDownLevel1'].disabled = false;
		document.theForm.submit();
	}
</script>
<!-- #include file = "Foot.asp" -->