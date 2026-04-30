<%
	DIM intTopMenu, intLeftMenu, isAdminMenu
	intTopMenu  = 5
	intLeftMenu = 2
	isAdminMenu = 1
%>
<!-- #include file = "Head.asp" -->
<%
	DIM strBoardID, intBoardConfigMenu
	strBoardID         = REQUEST.QueryString("strBoardID")
	intBoardConfigMenu = 5

	SET RS = DBCON.EXECUTE("SELECT [bitUseCategory] FROM [MPLUS_BOARD_CONFIG_DEFAULT] WHERE [strBoardID] = '" & strBoardID & "' ")
	DIM bitUseCategory
	bitUseCategory = RS("bitUseCategory")
%>

						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post">
							<input type="hidden" name="strBoardID" value="<%=strBoardID%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title25.gif" width="152" height="19"></td>
                      <td align="right">관리자 홈 &gt; 게시판관리 &gt; <b>게시판 카테고리 설정</b></td>
                    </tr>
                  </table>
                </td>
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
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>카테고리 사용정보</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">카테고리 기능사용</td>
											<td class="table_Right1"><input name="bitUseCategory" type="checkbox" id="bitUseCategory" value="1"<% IF bitUseCategory = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitUseCategory" style="cursor:hand">게시판 카테고리를 기능을 사용합니다.</LABEL></td>
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
								<td align="right" style="padding-right:20;"><a href="javascript:;" onclick="OnCategoryUse();return false;"><img src="../images/btn_submit_m.gif" width="77" height="25" border="0"></a></td>
							</tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>게시판 카테고리 목록</strong></span></td>
              </tr>
              <tr>
                <td>
									<table width="100%"  border="0" cellpadding="0" cellspacing="0">
										<tr align="center" bgcolor="EB766F">
											<td colspan="7" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td height="30" class="table_Txt1" nowrap>선택</td>
											<td height="30" class="table_Txt1" nowrap>번호</td>
											<td height="30" class="table_Txt1" nowrap>카테고리명</td>
											<td height="30" class="table_Txt1" nowrap>게시글</td>
											<td height="30" class="table_Txt1" nowrap>순서</td>
											<td width="60" height="30" nowrap bgcolor="EB766F" class="table_Txt1">수정</td>
											<td width="60" align="center" class="table_Txt1" nowrap>삭제</td>
										</tr>
										<tr bgcolor="EB766F">
											<td colspan="7" class="table_Round1"></td>
										</tr>
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CATEGORY] '" & strBoardID & "' ")
	DIM iCount, intCategory, strCategory, intCategoryCount
	iCount = 0
	WHILE NOT(RS.EOF)
	iCount = iCount + 1
	intCategory = RS("intCategory")
	strCategory = RS("strCategory")
	intCategoryCount = RS("intCategoryCount")
%>
										<tr bgcolor="#FFFFFF" align="center">
											<td class="table_ListSubText1"><input name="intCategory" type="radio" value="<%=intCategory%>"<% IF iCount = 1 THEN %> checked<% END IF %> class="no_Line"></td>
											<td class="table_ListSubText1"><%=iCount%></td>
											<td class="table_ListSubText1"><%=strCategory%></td>
											<td class="table_ListSubText1"><%=intCategoryCount%></td>
											<td class="table_ListSubText1">
											<% IF iCount <> 1 THEN %><a href="javascript:;" onClick="OnCategoryStep('d', <%=iCount%>, '<%=intCategory%>');return false;"><img src="../images/btn_down.gif" width="16" height="10" border="0" align="absmiddle"></a>&nbsp;<a href="javascript:;" onClick="OnCategoryStep('u', <%=iCount%>, '<%=intCategory%>');return false;"><img src="../images/btn_up.gif" width="16" height="10" border="0" align="absmiddle"></a>
									    <% END IF %>
											</td>
											<td bgcolor="#FFFFFF" class="table_ListSubText1"><a href="javascript:popupLayer('BoardCategoryAdd.asp?Action=edit&intCategory=<%=RS("intCategory")%>&strBoardID=<%=strBoardID%>',540,260)"><img src="../images/btn_edit_s.gif" width="38" height="16" border="0"></a></td>
											<td class="table_ListSubText1"><% IF iCount <> 1 THEN %><a href="javascript:;" onClick="OnCategoryRemove('<%=RS("intCategory")%>', '<%=RS("intStep")%>');return false;"><img src="../images/btn_delete_s.gif" width="38" height="16" border="0"></a><% END IF %></td>
										</tr>
										<tr>
											<td colspan="7" class="table_ListSubLine1"></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
%>
										<tr>
											<td colspan="7" height="1"></td>
										</tr>
										<tr>
											<td colspan="7" class="table_ListSubBLine1"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							<tr>
								<td>
								<a href="javascript:popupLayer('BoardCategoryAdd.asp?Action=add&strBoardID=<%=strBoardID%>',540,210)"><img src="../images/btn_category_add_w.gif" width="121" height="19" border="0"></a>
								<a href="javascript:;" onClick="OnBoardMoveExec('<%=strBoardID%>');return false;"><img src="../images/btn_category_move_w.gif" width="132" height="19" border="0"></a></td>
							</tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>카테고리 기능은 게시판에 있는 게시글을 특정 분류로 나누어 사용할 수 있는 기능입니다.</LI>
											<LI>신규 카테고리를 등록하거나 삭제가 가능하며, 등록된 게시글을 특정 카테고리로 이동하실 수 있습니다.</LI>
											<LI>카테고리를 삭제할 경우 삭제할 카테고리에 속한 게시글은 미등록 카테고리로 이동하게 됩니다.</LI>
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
	var SET_iStart = 2;
	var SET_iEnd   = <%=iCount%>;

	function OnCategoryStep(moveType, nowStep, intCategory){
		switch (moveType){
			case "d" :
				if (nowStep == SET_iEnd){
					alert("더이상 아래로 이동이 불가능합니다.");
					return false;
				}
				document.theForm.action = "BoardCategoryConfig_ok.asp?Action=moveDown&nowStep=" + nowStep + "&intCategory=" + intCategory;
				document.theForm.submit();
				break;
			case "u" :
				if (nowStep == SET_iStart){
					alert("더이상 위로 이동이 불가능합니다.");
					return false;
				}
				document.theForm.action = "BoardCategoryConfig_ok.asp?Action=moveUp&nowStep=" + nowStep + "&intCategory=" + intCategory;
				document.theForm.submit();
				break;
		}
	}

	function OnBoardMoveExec(str){

		if (SET_iEnd == "1"){
			alert("카테고리를 먼저 생성해 주시기 바랍니다.");
			return false;
		}

		var obj = document.all['intCategory'];

		var cntBox = obj.length - 1;
		for(var i = 0; i <= cntBox; i++){
			if (obj[i].checked == true){
				var ss = obj[i].value;
			}
		}
		
		popupLayer('BoardCategoryMove.asp?intCategory=' + ss + '&strBoardID=' + str,540,140);

	}

	function OnCategoryRemove(str1, str2){
		if (confirm("선택한 카테고리를 삭제하시겠습니까?\n\n삭제된 카테고리에 속한 게시글은 미등록 카테고리글로 변경됩니다.")){
			document.theForm.action = "BoardCategoryConfig_ok.asp?Action=remove&intCategory=" + str1 + "&intStep=" + str2;
			document.theForm.submit();
		}
	}

	function OnCategoryUse(){
		document.theForm.action = "BoardCategoryConfig_ok.asp?Action=usecategory";
		document.theForm.submit();
	}
</script>
<!-- #include file = "Foot.asp" -->