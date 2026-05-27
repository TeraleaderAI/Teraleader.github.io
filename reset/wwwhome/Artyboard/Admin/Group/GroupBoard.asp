<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Group/GroupBoardList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM strGroupCode
	strGroupCode = REQUEST.QueryString("strGroupCode")
%>
<table width="700" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post">
	<tr>
	  <td background="../images/pop_title_bg.gif"><img src="../images/GroupBoard_title.gif" width="155" height="44"></td>
	  </tr>
	<tr>
		<td height="8"></td>
	</tr>
	<tr>
		<td>
			<table width="700" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="320" align="center" valign="top">
						<table width="310" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>미등록 게시판 리스트</strong></span></td>
              </tr>
							<tr>
								<td><select name="strBoardList" size="18" multiple id="strBoardList" style="width:100%">
<%
	SET RS = DBCON.EXECUTE("SELECT [strBoardID], [strName] FROM [MPLUS_BOARD_CONFIG_DEFAULT] WHERE [strBoardID] NOT IN (SELECT [strBoardID] FROM [MPLUS_BOARD_GROUP_BOARD] WHERE [strGroupCode] = '" & strGroupCode & "') ")
	WHILE NOT(RS.EOF)
		RESPONSE.WRITE "<option value=" & RS("strBoardID") & ">[" & RS("strBoardID") & "] " & RS("strName") & "</option>" & vbcrlf
	RS.MOVENEXT
	WEND
%>
								</select></td>
							</tr>
						</table>					</td>
					<td width="50" align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="40" align="center"><a href="javascript:;" onClick="OnBoardAdd();return false;">&gt;&gt;</a></td>
            </tr>
            <tr>
              <td height="40" align="center"><a href="javascript:;" onClick="OnBoardRemove();return false;">&lt;&lt;</a></td>
            </tr>
          </table>					</td>
					<td width="320" align="center" valign="top">
						<table width="310" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>등록된 게시판 리스트</strong></span></td>
              </tr>
							<tr>
								<td><select name="strBoardGroupList" size="18" multiple id="strBoardGroupList" style="width:100%">
<%
	SET RS = DBCON.EXECUTE("SELECT [strBoardID], [strName] = (SELECT [strName] FROM [MPLUS_BOARD_CONFIG_DEFAULT] WHERE [strBoardID] = [MPLUS_BOARD_GROUP_BOARD].[strBoardID]) FROM [MPLUS_BOARD_GROUP_BOARD] WHERE [strGroupCode] = '" & strGroupCode & "' ")
	WHILE NOT(RS.EOF)
		RESPONSE.WRITE "<option value=" & RS("strBoardID") & ">[" & RS("strBoardID") & "] " & RS("strName") & "</option>" & vbcrlf
	RS.MOVENEXT
	WEND
%>
								</select></td>
							</tr>
						</table>					</td>
				</tr>
			</table>		</td>
	</tr>
	<tr>
		<td height="30" align="right" style="padding-right:20"><font color="#FD8402">다중 선택은 Ctrl을 누른 후 선택해 주세요.</font></td>
	</tr>
</form>
</table>
<script language="javascript">
	var SET_strGroupCode = "<%=strGroupCode%>";

	function OnBoardAdd(){
		var k = 0;
		for(i = 0; i < document.theForm.strBoardList.options.length; i++){
			if (document.theForm.strBoardList.options[i].selected == true){
				k++;
			}
		}

		if (k == 0){
			alert("등록할 게시판을 선택해 주시기 바랍니다.");
			return false;
		}

		document.theForm.action = "GroupBoard_ok.asp?Action=move&strGroupCode=" + SET_strGroupCode;
		document.theForm.submit();

	}

	function OnBoardRemove(){
		var k = 0;
		for(i = 0; i < document.theForm.strBoardGroupList.options.length; i++){
			if (document.theForm.strBoardGroupList.options[i].selected == true){
				k++;
			}
		}

		if (k == 0){
			alert("삭제할 게시판을 선택해 주시기 바랍니다.");
			return false;
		}

		document.theForm.action = "GroupBoard_ok.asp?Action=nouse&strGroupCode=" + SET_strGroupCode;
		document.theForm.submit();

	}
</script>
<!-- #include file = "../Foot.asp" -->