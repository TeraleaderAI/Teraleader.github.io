<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 1
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM Action, strBoardID, strField
	Action     = REQUEST.QueryString("Action")
	strBoardID = REQUEST.QueryString("strBoardID")
	strField   = REQUEST.QueryString("strField")
%>
<table width="480" height="100%"  border="0" cellpadding="0" cellspacing="0">
<form name="theForm" method="post" action="BoardCopy_ok.asp" onSubmit="return OnSubmitAction();">
<input type="hidden" name="Action" value="<%=Action%>">
<input type="hidden" name="strBoardID" value="<%=strBoardID%>">
<input type="hidden" name="selectBoardID">
<input type="hidden" name="strField" value="<%=strField%>">
	<tr>
	  <td height="42" background="../images/pop_title_bg.gif"><img src="../images/pop_title_board_config.gif" width="157" height="44"></td>
	  </tr>
	<tr>
		<td height="10" align="center">&nbsp;</td>
	</tr>
	<tr>
		<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>설정할 게시판 선택</strong></span></td>
	</tr>
	<tr>
		<td height="3" bgcolor="#CCCCCC"></td>
	</tr>
	<tr>
		<td align="center" valign="top" style="padding-top:5; padding-bottom:5;">
<%
	DIM Query
	Query = ""
	IF SESSION("strAdmin") = "1" THEN
		SET RS = DBCON.EXECUTE("SELECT [strBoardID], [strAdmin] FROM [MPLUS_BOARD_CONFIG_DEFAULT] WHERE [strBoardID] != '" & strBoardID & "' ")
		IF NOT(RS.EOF) THEN
			WHILE NOT(RS.EOF)
				IF RS("strAdmin") <> "" AND ISNULL(RS("strAdmin")) = False THEN
					SplitStrAdmin = SPLIT(RS("strAdmin"), "|")
					FOR I = 0 TO UBOUND(SplitStrAdmin)
						IF SplitStrAdmin(I) <> SESSION("strLoginID") THEN
							Query = Query & RS("strBoardID") & ","
						END IF
					NEXT
				END IF
			RS.MOVENEXT
			WEND
			IF Query <> "" THEN Query = " WHERE [strBoardID] IN (" & getSplitQuery(Query) & ") "
		END IF
	ELSE
		Query = ""
	END IF
%>
		<select name="strCopyBoardID" size="20" multiple id="strCopyBoardID" style="width:95%">
<%
	SET RS = DBCON.EXECUTE("SELECT [strBoardiD], [strName] FROM [MPLUS_BOARD_CONFIG_DEFAULT] " & Query)
	WHILE NOT(RS.EOF)
		RESPONSE.WRITE "<option value='" & RS("strBoardID") & "'>[" & RS("strBoardID") & "] " & RS("strName") & "</option>" & vbcrlf
	RS.MOVENEXT
	WEND
%>
		</select>
		</td>
	</tr>
	<tr>
		<td height="20" align="right" style="padding-right:10"><font color="#e86a34">설정을 동일하게 적용할 <b>게시판</b>을 모두 선택해주세요</font></td>
	</tr>
	<tr>
		<td height="40" align="center"><input type="image" name="imageField" src="../images/btn_config_copy_m.gif" class="no_Line"></td>
	</tr>
</form>
</table>
<script language="javascript">
	function OnSubmitAction(){

		var selectBoardID = "";
		var obj = document.all['strCopyBoardID'].options;

		for(var i = 0; i < obj.length; i++) {
			if(obj[i].selected) {
				selectBoardID = selectBoardID + obj[i].value + ",";
			}
		}

		if(selectBoardID == "") {
			alert("설정할 게시판을 선택해주세요");
			return false;
		}

		if (confirm("선택된 게시판에 적용하시겠습니까?")){
			document.all['selectBoardID'].value = selectBoardID ;
			document.theForm.submit();
		}else{
			return false;
		}
	}
</script>
<!-- #include file = "../Foot.asp" -->