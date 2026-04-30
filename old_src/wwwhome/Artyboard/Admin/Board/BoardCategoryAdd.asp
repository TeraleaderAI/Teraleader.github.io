<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 1
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardList.asp"
%>
<!-- #include file = "../head.asp" -->
<%
	DIM Action, strBoardID, intCategory, strFileName1, strFileName2
	Action = UCASE(REQUEST.QueryString("Action"))
	IF Action = "" THEN Action = "ADD"

	strBoardID  = REQUEST.QueryString("strBoardID")
	intCategory = REQUEST.QueryString("intCategory")

	IF Action = "EDIT" THEN

		SET RS = DBCON.EXECUTE("SELECT [intCategory], [strCategory], [strFileName1], [strFileName2] FROM [MPLUS_BOARD_CATEGORY] WHERE [strBoardID] = '" & strBoardID & "' AND [intCategory] = '" & intCategory & "' ")

		strCategory  = RS("strCategory")
		strFileName1 = RS("strFileName1")
		strFileName2 = RS("strFileName2")

	END IF
%>
<table width="520"  border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="BoardCategoryConfig_ok.asp?Action=<%=Action%>&intCategory=<%=intCategory%>" onSubmit="return OnSubmitAction();" enctype="multipart/form-data">
<input type="hidden" name="strBoardID" value="<%=strBoardID%>">
	<tr>
		<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong><% IF Action = "ADD" THEN %>신규 카테고리 등록<% ELSE %>카테고리 정보수정<% END IF %></strong></span></td>
	</tr>
	<tr>
		<td height="3" bgcolor="#CCCCCC"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="table_Left1">카테고리명</td>
					<td class="table_Right1"><input name="strCategory" type="text" id="strCategory" value="<%=strCategory%>" maxlength="64" style="width:98%">
					</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
<% IF UCASE(Action) = "EDIT" AND strFileName1 <> "" AND ISNULL(strFileName1) = False THEN %>
				<tr>
					<td class="table_Left1">등록된 기본 이미지</td>
					<td class="table_Right1"><b><%=strFileName1%></b> 파일이 등록되어 있습니다.&nbsp;<a href="javascript:;" onClick="OnImgRemove('<%=intCategory%>', '<%=strBoardID%>', '1');return false;"><img src="../images/btn_image_delete_w.gif" width="81" height="19" align="absmiddle" border="0"></a></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
<% END IF %>
				<tr>
					<td class="table_Left1">기본 이미지</td>
					<td class="table_Right1"><input name="strFileName1" type="file" id="strFileName1" maxlength="64" style="width:98%">
					</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
<% IF UCASE(Action) = "EDIT" AND strFileName2 <> "" AND ISNULL(strFileName2) = False THEN %>
				<tr>
					<td class="table_Left1">등록된 선택 이미지</td>
					<td class="table_Right1"><b><%=strFileName2%></b> 파일이 등록되어 있습니다.&nbsp;<a href="javascript:;" onClick="OnImgRemove('<%=intCategory%>', '<%=strBoardID%>', '2');return false;"><img src="../images/btn_image_delete_w.gif" width="81" height="19" align="absmiddle" border="0"></a></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
<% END IF %>
				<tr>
					<td class="table_Left1">선택 이미지</td>
					<td class="table_Right1"><input name="strFileName2" type="file" id="strFileName2" maxlength="64" style="width:98%">
					</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="40" align="right" style="padding-right:30;"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
	</tr>
	</form>
</table>
<script language="javascript">

	function OnSubmitAction(){
		str = document.all['strCategory'];
		if (str.value == ""){alert("카테고리명을 입력해 주시기 바랍니다.");str.focus();return false;}
	}

	function OnImgRemove(str1, str2, str3){
		if (confirm("등록된 이미지를 삭제하시겠습니까?")){
			document.theForm.action = "BoardCategoryConfig_ok.asp?Action=imgremove&intCategory=" + str1 + "&strBoardID=" + str2 + "&intFile=" + str3;
			document.theForm.submit();
		}
	}

</script>
<!-- #include file = "../foot.asp" -->