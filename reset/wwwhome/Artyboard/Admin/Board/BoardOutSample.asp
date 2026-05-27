<%
	DIM intTopMenu, intLeftMenu, isAdminMenu
	intTopMenu  = 5
	intLeftMenu = 8
	isAdminMenu = 2
%>
<!-- #include file = "Head.asp" -->
<%
	DIM strBoardType, strSetBoardID, intCount, strLink, intSubjectLength

	WITH REQUEST

		strBoardType     = .FORM("strBoardType")
		strSetBoardID    = .FORM("strSetBoardID")
		intCount         = .FORM("intCount")
		strLink          = .FORM("strLink")
		intSubjectLength = .FORM("intSubjectLength")

	END WITH

	IF intCount         = "" THEN intCount         = 5
	IF intSubjectLength = "" THEN intSubjectLength = 40
%>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" action="BoardOutSample.asp" onSubmit="return OnSubmitAction();">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title43.gif" width="125" height="19"></td>
                      <td align="right">관리자 홈 &gt; 게시판관리 &gt; <b>최근 게시글 출력</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>출력정보 선택</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">출력 타입</td>
											<td class="table_Right1">
											<select name="strBoardType" id="strBoardType">
											<option value="board"<% IF strBoardType = "board" THEN %> SELECTED<% END IF %>>일반 게시판 타입</option>
											<option value="gallery1"<% IF strBoardType = "gallery1" THEN %> SELECTED<% END IF %>>갤러리 타입 (썸네일 사용)</option>
											<option value="gallery2"<% IF strBoardType = "gallery2" THEN %> SELECTED<% END IF %>>갤러리 타입 (썸네일 미사용)</option>
											</select>											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">게시판 선택</td>
											<td class="table_Right1">
											<select name="strSetBoardID" id="strSetBoardID" style="font-size:12px" onchange="OnAdminBoardPageMove(this.value, '<%=intBoardConfigMenu%>');">
<%
	DIM SELECTED
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '', '' ")
	RESPONSE.WRITE "<option value=''>게시판 선택</option>" & vbcrlf
	WHILE NOT(RS.EOF)
		IF RS("strBoardID") = strSetBoardID THEN SELECTED = " SELECTED " ELSE SELECTED = ""
		RESPONSE.WRITE "<option value='" & RS("strBoardID") & "'" & SELECTED & ">[" & RS("strBoardID") & "] " & RS("strName") & "</oprion>" & vbcrlf
	RS.MOVENEXT
	WEND
%>
											</select>											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">출력 정보</td>
											<td class="table_Right1">출력개수 
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
									</table>								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							<tr>
								<td align="right" style="padding-right:20;"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td><textarea name='code' rows=30 cols=80 style='width:100%;height:500;padding:5pt;border:1 solid dfdfdf;overflow:auto;background:black;color:white;'>
<% IF strSetBoardID <> "" THEN %>
								<!-- #include file = "BoardOutSample1.asp" -->
<% END IF %>
								</textarea>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>게시판 최근글을 출력하는 소스를 확인 할 수 있으며, 필요에 따라 경로등을 수정해서 사용하시기 바랍니다.</LI>
											</td>
										</tr>
									</table>
									</fieldset>								</td>
							</tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							</form>
            </table>
<script language="javascript">

	function OnSubmitAction(){

		str = document.all['strSetBoardID'];
		if (str.value == ""){
			alert("게시판을 선택해 주시기 바랍니다.");str.focus();return false;
		}

	}

</script>
<!-- #include file = "Foot.asp" -->