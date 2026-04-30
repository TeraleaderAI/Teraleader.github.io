<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardBestList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM strBoardType, strGroup, intCount, strLink, intSubjectLength

	WITH REQUEST

		strBoardType     = .FORM("strBoardType")
		strGroup         = .FORM("strGroup")
		intCount         = .FORM("intCount")
		strLink          = .FORM("strLink")
		intSubjectLength = .FORM("intSubjectLength")

	END WITH

	IF intCount         = "" THEN intCount         = 5
	IF intSubjectLength = "" THEN intSubjectLength = 40
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<form name="theForm" method="post" action="BoardBestSample.asp" onSubmit="return OnSubmitAction();">
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
					<td height="33" class="table_Left1">출력타입</td>
					<td class="table_Right1">
					<select name="strBoardType" id="strBoardType">
					<option value="board"<% IF strBoardType = "board" THEN %> SELECTED<% END IF %>>일반 게시판 타입</option>
					<option value="gallery1"<% IF strBoardType = "gallery1" THEN %> SELECTED<% END IF %>>갤러리 타입 (썸네일 사용)</option>
					<option value="gallery2"<% IF strBoardType = "gallery2" THEN %> SELECTED<% END IF %>>갤러리 타입 (썸네일 미사용)</option>
					</select>
					</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td height="33" class="table_Left1">그룹선택</td>
					<td class="table_Right1">
					<select name="strGroup" id="strGroup">
					<option value="">그룹선택</option>
<%
	SET RS = DBCON.EXECUTE("SELECT [strCode], [strName] FROM [MPLUS_BOARD_NOTICE] ")
	WHILE NOT(RS.EOF)

		RESPONSE.WRITE "					<option value=""" & RS("strCode") & """"
		IF strGroup = RS("strCode") THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & RS("strName") & "</option>" & vbcrlf

	RS.MOVENEXT
	WEND
%>
					</select>
					</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td height="33" class="table_Left1">출력정보</td>
					<td class="table_Right1">
					출력개수 
					<select name="intCount" id="intCount">
<%
	FOR I = 1 TO 20
		RESPONSE.WRITE "											<option value='" & I & "'"
		IF INT(I) = INT(intCount) THEN RESPONSE.WRITE " SELECTED"
		RESPONSE.WRITE ">" & I & "개</option>" & vbcrlf
	NEXT
%>
					</select>
					링크방식  
					<select name="strLink" id="strLink">
					<option value="1"<% IF strLink = "1" THEN %> SELECTED<% END IF %>>일반링크</option>
					<option value="2"<% IF strLink = "2" THEN %> SELECTED<% END IF %>>새창열기</option>
					</select> 
					게시글 길이
					<input name="intSubjectLength" type="text" id="intSubjectLength" value="<%=intSubjectLength%>" size="4" maxlength="2">
					자
					</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="40" align="right"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
	</tr>
	<tr>
		<td>
		<textarea name='code' rows=30 cols=80 style='width:100%;height:430;padding:5pt;border:1 solid dfdfdf;overflow:auto;background:black;color:white;'><% IF strGroup <> "" THEN %><!-- #include file = "BoardOutSample2.asp" --><% END IF %></textarea>
		</td>
	</tr>
</form>
</table>
<script language="javascript">

	function OnSubmitAction(){
		str = document.all['strGroup'];
		if (str.value == ""){
			alert("그룹을을 선택해 주시기 바랍니다.");str.focus();return false;
		}
	}

</script>
<!-- #include file = "../Foot.asp" -->