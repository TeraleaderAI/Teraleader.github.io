<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu  = 3
	intLeftMenu = 6
	isAdminMenu = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM intGroupCount, iCount, I, SELECTED

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

	DIM bitMemberInfo, intMemberInfoLevel, bitMemberAvata, intMemberAvataLevel, bitMemoUse, intMemoUseLevel, bitMemoSend, intMemoSendLevel
	DIM bitMemoRead, intMemoReadLevel, bitBoardScrap, intBoardScrapLevel, strErrorUrl, strErrorUrlTarget, strErrorMsg
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_GROUP_MEMBER] ")

	bitMemberInfo       = RS("bitMemberInfo")
	intMemberInfoLevel  = RS("intMemberInfoLevel")
	bitMemberAvata      = RS("bitMemberAvata")
	intMemberAvataLevel = RS("intMemberAvataLevel")
	bitMemoUse          = RS("bitMemoUse")
	intMemoUseLevel     = RS("intMemoUseLevel")
	bitMemoSend         = RS("bitMemoSend")
	intMemoSendLevel    = RS("intMemoSendLevel")
	bitBoardScrap       = RS("bitBoardScrap")
	intBoardScrapLevel  = RS("intBoardScrapLevel")
	strErrorUrl         = RS("strErrorUrl")
	strErrorUrlTarget   = RS("strErrorUrlTarget")
	strErrorMsg         = RS("strErrorMsg")
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" action="MemberGroupSet_ok.asp">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title10.gif" width="134" height="19"></td>
                      <td align="right">관리자 홈 &gt; 회원관리 &gt; <b>회원그룹 권한설정</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>그룹별 권한정보</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">타회원 프로필 열람</td>
											<td class="table_Right1">
											<select name="intMemberInfoLevel" id="intMemberInfoLevel"<% IF bitMemberInfo = True THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF bitMemberInfo = False THEN
			IF INT(intMemberInfoLevel) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value=" & strGroupListValueDim(I) & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
											</select>&nbsp;이상&nbsp;&nbsp;&nbsp;<input name="bitMemberInfo" type="checkbox" id="bitMemberInfo" value="1"<% IF bitMemberInfo = True THEN %> CHECKED<% END IF %> onClick="OnGroupSet('intMemberInfoLevel', this);" class="no_Line"><LABEL for="bitMemberInfo" style="cursor:hand">제한없음</LABEL>&nbsp;<font color="#FD8402">타회원 <span style="font-weight: bold">프로필을
			열람</span>할 수 있는 권한을 설정</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">이름 이미지 사용</td>
											<td class="table_Right1">
											<select name="intMemberAvataLevel" id="intMemberAvataLevel"<% IF bitMemberAvata = True THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF bitMemberAvata = False THEN
			IF INT(intMemberAvataLevel) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value=" & strGroupListValueDim(I) & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
											</select>&nbsp;이상&nbsp;&nbsp;&nbsp;<input name="bitMemberAvata" type="checkbox" id="bitMemberAvata" value="1"<% IF bitMemberAvata = True THEN %> CHECKED<% END IF %> onClick="OnGroupSet('intMemberAvataLevel', this);" class="no_Line"><LABEL for="bitMemberAvata" style="cursor:hand">제한없음</LABEL>&nbsp;<font color="#FD8402"><b>이름
			이미지</b>를 사용할 수 있는 권한을 설정</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">메모 사용</td>
											<td class="table_Right1">
											<select name="intMemoUseLevel" id="intMemoUseLevel"<% IF bitMemoUse = True THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF bitMemoUse = False THEN
			IF INT(intMemoUseLevel) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value=" & strGroupListValueDim(I) & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
											</select>&nbsp;이상&nbsp;&nbsp;&nbsp;<input name="bitMemoUse" type="checkbox" id="bitMemoUse" value="1"<% IF bitMemoUse = True THEN %> CHECKED<% END IF %> onClick="OnGroupSet('intMemoUseLevel', this);" class="no_Line"><LABEL for="bitMemoUse" style="cursor:hand">제한없음</LABEL>&nbsp;<font color="#FD8402"><b>메모기능</b>을 사용할 수 있는 권한을 설정</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">메모 보내기</td>
											<td class="table_Right1">
											<select name="intMemoSendLevel" id="intMemoSendLevel"<% IF bitMemoSend = True THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF bitMemoSend = False THEN
			IF INT(intMemoSendLevel) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value=" & strGroupListValueDim(I) & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
											</select>&nbsp;이상&nbsp;&nbsp;&nbsp;<input name="bitMemoSend" type="checkbox" id="bitMemoSend" value="1"<% IF bitMemoSend = True THEN %> CHECKED<% END IF %> onClick="OnGroupSet('intMemoSendLevel', this);" class="no_Line"><LABEL for="bitMemoSend" style="cursor:hand">제한없음</LABEL>&nbsp;<font color="#FD8402"><b>메모	 보내기</b>를 사용할 수 있는 권한을 설정</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">메모 읽기</td>
											<td class="table_Right1">
											<select name="intMemoReadLevel" id="intMemoReadLevel"<% IF bitMemoRead = True THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF bitMemoRead = False THEN
			IF INT(intMemoReadLevel) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value=" & strGroupListValueDim(I) & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
											</select>&nbsp;이상&nbsp;&nbsp;&nbsp;<input name="bitMemoRead" type="checkbox" id="bitMemoRead" value="1"<% IF bitMemoRead = True THEN %> CHECKED<% END IF %> onClick="OnGroupSet('intMemoReadLevel', this);" class="no_Line"><LABEL for="bitMemoRead" style="cursor:hand">제한없음</LABEL>&nbsp;<font color="#FD8402"><b>메모	읽기</b>를 사용할 수 있는 권한을 설정</font></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">게시글 스크랩</td>
											<td class="table_Right1">
											<select name="intBoardScrapLevel" id="intBoardScrapLevel"<% IF bitBoardScrap = True THEN %> DISABLED<% END IF %>>
<%
	FOR I = 0 TO intGroupCount - 1
		IF bitBoardScrap = False THEN
			IF INT(intBoardScrapLevel) = INT(strGroupListValueDim(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		ELSE
			SELECTED = ""
		END IF
		RESPONSE.WRITE "<option value=" & strGroupListValueDim(I) & SELECTED & ">" & strGroupListDim(I) & "</option>" & vbcrlf
	NEXT
%>
											</select>&nbsp;이상&nbsp;&nbsp;&nbsp;<input name="bitBoardScrap" type="checkbox" id="bitBoardScrap" value="1"<% IF bitBoardScrap = True THEN %> CHECKED<% END IF %> onClick="OnGroupSet('intBoardScrapLevel', this);" class="no_Line"><LABEL for="bitBoardScrap" style="cursor:hand">제한없음</LABEL>&nbsp;<font color="#FD8402"><b>스크랩기능</b>을 사용할 수 있는 권한을 설정</font></td>
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
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>권한 부족시 페이지 이동 및 메시지 출력정보</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">페이지 이동</td>
											<td class="table_Right1"><input name="strErrorUrl" type="text" id="strErrorUrl" value="<%=strErrorUrl%>" size="100" maxlength="128">&nbsp;<select name="strErrorUrlTarget" id="strErrorUrlTarget">
											<option value=""></option>
											<option value="_self" <% IF strErrorUrlTarget = "_self" THEN %>SELECTED<% END IF %>>self</option>
											<option value="_parent" <% IF strErrorUrlTarget = "_parent" THEN %>SELECTED<% END IF %>>parent</option>
											<option value="_top" <% IF strErrorUrlTarget = "_top" THEN %>SELECTED<% END IF %>>top</option></select><br>
											<span style="color: #FD8402">시작경로는 <b>member.asp</b> 파일의 위치부터 시작됩니다.</span></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">출력 메시지</td>
											<td class="table_Right1"><input name="strErrorMsg" type="text" id="strErrorMsg" style="width:100%" value="<%=strErrorMsg%>" maxlength="128"></td>
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
								<td align="right" style="padding-right:20;"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
							</tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>회원관련 기능에서 제한을 둘 수 있으며, 제한은 그룹별 설정하실 수 있습니다.</LI>
											<LI>권한이 부족한 경우 메시지를 출력하거나 이동할 페이지의 정보를 설정할 수 있습니다.</LI>
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
	function OnGroupSet(str1, str2){
		if (str2.checked){
			document.all[str1].disabled = true;
		}else{
			document.all[str1].disabled = false;
		}
	}

	function OnSubmitAction(){
		str = document.all['strErrorMsg'];
		if (str.value == ""){alert("권한부족시 출력될 메시지를 입력해 주시기 바랍니다.");str.focus();return false;}

		document.all['intMemberInfoLevel'].disabled = false;
		document.all['intMemberAvataLevel'].disabled = false;
		document.all['intMemoUseLevel'].disabled = false;
		document.all['intMemoSendLevel'].disabled = false;
		document.all['intMemoReadLevel'].disabled = false;

		document.theForm.submit();
	}
</script>
<!-- #include file = "Foot.asp" -->