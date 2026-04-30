<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardBestList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM intNum, intPage, intPageSize, strSelectGroup

	intNum         = REQUEST.QueryString("intNum")
	intPage        = REQUEST.QueryString("intPage")
	intPageSize    = REQUEST.QueryString("intPageSize")
	strSelectGroup = REQUEST.QueryString("strSelectGroup")

	DIM strGroupCode, strGroupName

	SET RS = DBCON.EXECUTE("SELECT [strCode], [strName] FROM [MPLUS_BOARD_NOTICE] ")
	IF NOT(RS.EOF) THEN
		WHILE NOT(RS.EOF)
			IF strGroupCode <> "" THEN strGroupCode = strGroupCode & ","
			IF strGroupName <> "" THEN strGroupName = strGroupName & ","
			strGroupCode = strGroupCode & RS("strCode")
			strGroupName = strGroupName & RS("strName")
		RS.MOVENEXT
		WEND
	END IF

	DIM strCode, strBoardID, intSeq, strFileName, intStep, bitUsage, bitMemoInfo, strFontColor, bitBold

	SET RS = DBCON.EXECUTE("SELECT [strCode], [strBoardID], [intSeq], [strFileName], [intStep], [bitUsage], [bitMemoInfo], [strFontColor], [bitBold] FROM [MPLUS_BOARD_NOTICE_LIST] WHERE [intNum] = '" & intNum & "' ")

	strCode      = RS("strCode")
	strBoardID   = RS("strBoardID")
	intSeq       = RS("intSeq")
	strFileName  = RS("strFileName")
	intStep      = RS("intStep")
	bitUsage     = RS("bitUsage")
	bitMemoInfo  = RS("bitMemoInfo")
	strFontColor = RS("strFontColor")
	bitBold      = RS("bitBold")

	DIM strSmallSubject, strSmallContent

	SET RS = DBCON.EXECUTE("SELECT [strSmallSubject], [strSmallContent] FROM [MPLUS_BOARD] WHERE [intSeq] = '" & intSeq & "' ")

	strSmallSubject = RS("strSmallSubject")
	strSmallContent = RS("strSmallContent")
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<form name="theForm" method="post" action="BoardBestEdit_ok.asp?intNum=<%=intNum%>&intPage=<%=intPage%>&intPageSize=<%=intPageSize%>&strSelectGroup=<%=strSelectGroup%>&intSeq=<%=intSeq%>" onSubmit="return OnSubmitAction();" enctype="multipart/form-data">
	<tr>
		<td height="44" background="../images/pop_title_bg.gif"><img src="../images/pop_title_board_group.gif" width="155" height="44"></td>
	</tr>
	<tr>
		<td height="8"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="33" class="table_Left1">그룹코드</td>
					<td class="table_Right1"><%=GetMainBoardGroup(strGroupCode, strGroupName, strCode, "strCode", "", "")%></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td height="33" class="table_Left1">게시판 아이디</td>
					<td class="table_Right1"><%=strBoardID%></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td height="33" class="table_Left1">게시글 번호</td>
					<td class="table_Right1"><%=intSeq%></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">이미지 파일</td>
					<td class="table_Right1"><input name="strFileName" type="file" id="strFileName" size="30" maxlength="32" class="input"> 
<% IF strFileName <> "" AND ISNULL(strFileName) = False THEN %>
					<a href="javascript:;" onClick="OnPrevIMG();return false;"><img src="../images/btn_image_view_w.gif" width="81" height="19" border="0" align="absmiddle"></a>
					<a href="javascript:;" onClick="OnRemoveIMG('<%=intNum%>', '<%=intPage%>', '<%=intPageSize%>', '<%=strSelectGroup%>');return false;"><img src="../images/btn_image_delete_w.gif" width="81" height="19" border="0" align="absmiddle"></a></td>
<% END IF %>
				</tr>
				<tr id="trPrevIMG" style="display:none">
					<td>&nbsp;</td>
					<td class="table_Right1"><img src="../../Pds/Main/<%=strFileName%>"/>				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">출력순서</td>
					<td class="table_Right1"><input name="intStep" type="text" class="input" id="intStep" OnKeydown="onlyNumber();" value="<%=intStep%>" size="4" maxlength="4"> 
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">사용유무</td>
					<td class="table_Right1"><input type="radio" name="bitUsage" id="bitUsage1" value="1" <% IF bitUsage = True THEN %> CHECKED<% END IF %> class="no_Line">
					<LABEL FOR="bitUsage1" style="cursor:hand">사용함</LABEL>
					<input type="radio" name="bitUsage" id="bitUsage2" value="0" <% IF bitUsage = False THEN %> CHECKED<% END IF %> class="no_Line">
					<LABEL FOR="bitUsage2" style="cursor:hand">사용안함</LABEL></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">출력게시글</td>
					<td class="table_Right1"><input type="radio" name="bitMemoInfo" id="bitMemoInfo1" value="1" <% IF bitMemoInfo = True THEN %> CHECKED<% END IF %> class="no_Line" onClick="OnContentsView('1');">
					<LABEL FOR="bitMemoInfo1" style="cursor:hand">간략정보출력</LABEL>
					<input type="radio" name="bitMemoInfo" id="bitMemoInfo2" value="0" <% IF bitMemoInfo = False THEN %> CHECKED<% END IF %> class="no_Line" onClick="OnContentsView('2');">
					<LABEL FOR="bitMemoInfo2" style="cursor:hand">기본정보출력</LABEL></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr id="smallContents" style="display:<% IF bitMemoInfo = True THEN %>block<% ELSE %>none<% END IF %>">
					<td class="table_Left1">간략한 제목</td>
					<td class="table_Right1">
						<LABEL FOR="bitBold" style="cursor:hand"<% IF bitBold = True THEN %> CHECKED<% END IF %>>
						<input name="strSmallSubject" type="text" id="strSmallSubject" style="width:100%" value="<%=strSmallSubject%>">
						</LABEL>
					</td>
				</tr>
				<tr id="smallContents" style="display:<% IF bitMemoInfo = True THEN %>block<% ELSE %>none<% END IF %>">
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr id="smallContents" style="display:<% IF bitMemoInfo = True THEN %>block<% ELSE %>none<% END IF %>">
					<td class="table_Left1">간략한 내용</td>
					<td class="table_Right1">
						<LABEL FOR="bitBold" style="cursor:hand"<% IF bitBold = True THEN %> CHECKED<% END IF %>>
						<textarea name="strSmallContent" id="strSmallContent" cols="45" rows="6" style="width:100%"><%=strSmallContent%></textarea>
						</LABEL>
					</td>
				</tr>
				<tr id="smallContents" style="display:<% IF bitMemoInfo = True THEN %>block<% ELSE %>none<% END IF %>">
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td class="table_Left1">제목글자</td>
					<td class="table_Right1"><input name="strFontColor" type="text" class="input" id="strFontColor" onBlur="OnColorSet(document.all['strFontColorPrev'], this);" value="<%=strFontColor%>" size="8" maxlength="7">
					<INPUT class="text" style="BACKGROUND: <%=strFontColor%>; CURSOR: hand" onClick="OnColorPicker('strFontColor');" size=2 name="strFontColorPrev">
					<input name="bitBold" type="checkbox" id="bitBold" value="1" class="no_Line">
					<LABEL FOR="bitBold" style="cursor:hand"<% IF bitBold = True THEN %> CHECKED<% END IF %>>굵은제목 사용</LABEL></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="40" align="center"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
	</tr>
</form>
</table>
<script language="javascript">

	function OnSubmitAction(){
		str = document.all['intStep'];
		if (str.value == ""){alert("출력순서를 입력해 주시기 바랍니다.");str.focus();return false;}
		if (document.all['bitMemoInfo'][0].checked == true){
			str = document.all['strSmallSubject'];
			if (str.value == ""){alert("간략한 제목을 입력해 주시기 바랍니다.");str.focus();return false;}
			str = document.all['strSmallContent'];
			if (str.value == ""){alert("간략한 내용을 입력해 주시기 바랍니다.");str.focus();return false;}
		}
	}

	function OnPrevIMG(){
		if (document.all['trPrevIMG'].style.display == "block"){
			document.all['trPrevIMG'].style.display = "none"
		}else{
			document.all['trPrevIMG'].style.display = "block"
		}
	}

	function OnRemoveIMG(str1, str2, str3, str4){
		if (confirm("이미지를 삭제하시겠습니까?")){
			document.theForm.action = "BoardBestEdit_ok.asp?Action=remove&intNum=" + str1 + "&intPage=" + str2 + "&intPageSize=" + str3 + "&strSelectGroup=" + str4;
			document.theForm.submit();
		}
	}

	function OnContentsView(str){
		switch (str){
			case "1" :
				document.all['smallContents'][0].style.display = "block";
				document.all['smallContents'][1].style.display = "block";
				document.all['smallContents'][2].style.display = "block";
				document.all['smallContents'][3].style.display = "block";
				break;
			case "2" :
				document.all['smallContents'][0].style.display = "none";
				document.all['smallContents'][1].style.display = "none";
				document.all['smallContents'][2].style.display = "none";
				document.all['smallContents'][3].style.display = "none";
				break;
		}
	}

</script>
<!-- #include file = "../Foot.asp" -->