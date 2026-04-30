<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu  = 2
	isAdminPopup = True
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM strPollCode, Action
	strPollCode = REQUEST.QueryString("strPollCode")
	Action      = UCASE(REQUEST.QueryString("Action"))

	DIM I, strSubject, bitObjective, bitCrowd, intItemCount, strItem, strValue, strTextValue, intStep

	SELECT CASE Action
	CASE "ADD"

		bitObjective = True
		bitCrowd     = False
		intItemCount = 4

	CASE "EDIT"

		SET RS = DBCON.EXECUTE("SELECT [strSubject], [bitObjective], [bitCrowd], [intItemCount], [strItem], [intStep] FROM [MPLUS_POLL_ITEM] WHERE [intSeq] = '" & REQUEST.QueryString("intSeq") & "' ")

		strSubject = RS("strSubject")
		bitObjective = RS("bitObjective")
		bitCrowd     = RS("bitCrowd")
		intItemCount = RS("intItemCount")
		IF RS("strItem") <> "" AND ISNULL(RS("strItem")) = False THEN strItem = SPLIT(RS("strItem"), "|")
		intStep      = RS("intStep")

	END SELECT
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="PollItem_ok.asp?strPollCode=<%=strPollCode%>&Action=<%=Action%>&intSeq=<%=REQUEST.QueryString("intSeq")%>" onSubmit="return OnSubmitAction();">
	<tr>
		<td background="../images/pop_title_bg.gif"><img src="../images/pop_title_poll_content.gif" width="155" height="44"></td>
	</tr>
	<tr>
		<td height="8"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="33" class="table_Left1">설문조사 제목</td>
					<td class="table_Right1"><input name="strSubject" type="text" id="strSubject" style="width:100%" value="<%=strSubject%>" maxlength="128"></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td height="33" class="table_Left1">설문타입</td>
					<td class="table_Right1">
<% IF Action = "ADD" THEN %>
          <input type="radio" name="bitObjective" id="bitObjective1" value="1" class="no_Line"<% IF bitObjective = True THEN %> CHECKED<% END IF %> onClick="OnPollType();"><LABEL FOR="bitObjective1" style="cursor:hand">객관식</LABEL>
					<input type="radio" name="bitObjective" id="bitObjective2" value="0" class="no_Line"<% IF bitObjective = False THEN %> CHECKED<% END IF %> onClick="OnPollType();"><LABEL FOR="bitObjective2" style="cursor:hand">주관식</LABEL>
<% ELSE %>
					<% IF bitObjective = True THEN %>객관식<% ELSE %>주관식<% END IF %><input type="hidden" name="bitObjective" value="<%=GetTrueFalse(bitObjective)%>">
<% END IF %>
          </td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr id="tr_content" style="display:<% IF bitObjective = True THEN %>block<% ELSE %>none<% END IF %>">
					<td height="33" class="table_Left1">항목선택</td>
					<td class="table_Right1">
<% IF Action = "ADD" THEN %>
          <input type="radio" name="bitCrowd" id="bitCrowd1" value="0" class="no_Line"<% IF bitCrowd = False THEN %> CHECKED<% END IF %> onClick="OnCrowd();"><LABEL FOR="bitCrowd1" style="cursor:hand">단일선택</LABEL>
					<input type="radio" name="bitCrowd" id="bitCrowd2" value="1" class="no_Line"<% IF bitCrowd = True THEN %> CHECKED<% END IF %> onClick="OnCrowd();"><LABEL FOR="bitCrowd2" style="cursor:hand">다중선택</LABEL>
<% ELSE %>
					<% IF bitCrowd = False THEN %>단일선택<% ELSE %>다중선택<% END IF %><input type="hidden" name="bitCrowd" value="<%=GetTrueFalse(bitCrowd)%>">
<% END IF %>
          </td>
				</tr>
				<tr id="tr_content" style="display:<% IF bitObjective = True THEN %>block<% ELSE %>none<% END IF %>">
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr id="tr_crowd" style="display:<% IF bitCrowd = True THEN %>block<% ELSE %>none<% END IF %>">
					<td height="33" class="table_Left1">다중선택 필수 개수</td>
					<td class="table_Right1">
<% IF Action = "ADD" THEN %>
          <select name="intCrowd" id="intCrowd">
          <option value="0">제한없음</option>
<% FOR I = 2 TO 20 %>
					<option value="<%=I%>"<% IF INT(I) = INT(intCrowd) THEN %> SELECTED<% END IF %>><%=I%> 개</option>
<% NEXT %>
					</select>
<% ELSE %>
					<%=intCrowd%>&nbsp;개<input type="hidden" name="intCrowd" value="<%=intCrowd%>">
<% END IF %>
          </td>
				</tr>
				<tr id="tr_crowd" style="display:<% IF bitCrowd = True THEN %>block<% ELSE %>none<% END IF %>">
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr id="tr_content" style="display:<% IF bitObjective = True THEN %>block<% ELSE %>none<% END IF %>">
					<td height="33" class="table_Left1">설문항목 개수</td>
					<td class="table_Right1">
<% IF Action = "ADD" THEN %>
          <select name="intItemCount" id="intItemCount" onChange="setPollList();">
<% FOR I = 2 TO 20 %>
					<option value="<%=I%>"<% IF INT(I) = INT(intItemCount) THEN %> SELECTED<% END IF %>><%=I%> 개</option>
<% NEXT %>
					</select>
<% ELSE %>
					<%=intItemCount%>&nbsp;개<input type="hidden" name="intItemCount" value="<%=intItemCount%>">
<% END IF %>
					</td>
				</tr>
				<tr id="tr_content" style="display:<% IF bitObjective = True THEN %>block<% ELSE %>none<% END IF %>">
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr id="tr_content" style="display:<% IF bitObjective = True THEN %>block<% ELSE %>none<% END IF %>">
					<td height="33" class="table_Left1">설문항목 설정</td>
					<td class="table_Right1">
					<DIV ID="list" align="left"> 
					<table width="100%" border="0" cellspacing="1" cellpadding="3">
<%
	FOR I = 1 TO intItemCount
%>
						<tr> 
							<td>&nbsp;<% IF LEN(I) = 1 THEN %>0<% END IF %><%=I%>. &nbsp;<input name='strItemSubject' type='text' id="strItemSubject" style="width:95%" size="43"<% IF Action = "EDIT" THEN %> value="<%=strItem(I-1)%>"<% END IF %>></td>
						</tr>
<%
	NEXT
%>
						</table>
						</DIV>
          </td>
				</tr>
				<tr id="tr_content" style="display:<% IF bitObjective = True THEN %>block<% ELSE %>none<% END IF %>">
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="40" align="right"><input type="image" name="imageField" id="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
  </tr>
</form>
</table>
<script language="javascript">

	var SET_Action = "<%=Action%>";

	function setPollList(){
		var obj = document.all['strItemSubject'];
		var len = obj.length;
		var temp = new Array(len);

		for(i=0;i<len;i++){
			temp[i] = obj[i].value;
		}

		var str = document.theForm.intItemCount[document.theForm.intItemCount.selectedIndex].value;
		var len2 = parseInt(str);
		var write_str = "<table width='100%' border='0' cellspacing='1' cellpadding='3'>";

		for(i=0;i<len2;i++){
		write_str = write_str + "<tr><td>";
		if (eval(i+1) < 10){
			write_str = write_str + "0";
		}
		write_str = write_str + (i+1)+". <input type='text' name='strItemSubject' size='43' class='input' style='width:90%'></td></tr>";
		}

		write_str = write_str + "</table>";

		document.all['list'].innerHTML = write_str;

		if (len>len2){
			len = len2;
		}

		for(i=0;i<len;i++){
			obj[i].value = temp[i];
		}
	}

	function OnPollType(){

		if (document.all['bitObjective'][0].checked == true){
			for(i=0;i<6;i++){
				document.all['tr_content'][i].style.display = "block";
			}

			if (document.all['bitCrowd'][0].checked == true){
				document.all['tr_crowd'][0].style.display = "none";
				document.all['tr_crowd'][1].style.display = "none";
			}else{
				document.all['tr_crowd'][0].style.display = "block";
				document.all['tr_crowd'][1].style.display = "block";
			}

		}else{
			for(i=0;i<6;i++){
				document.all['tr_content'][i].style.display = "none";
			}
			document.all['tr_crowd'][0].style.display = "none";
			document.all['tr_crowd'][1].style.display = "none";
		}

	}

	function OnSubmitAction(){

		str = document.all['strSubject'];
		if (str.value == ""){alert("제목을 입력해 주시기 바랍니다.");str.focus();return false;}

		if (SET_Action == "ADD"){
			if (document.all['bitObjective'][0].checked == true){
				if (document.all['bitCrowd'][1].checked == true){
					if (document.all['intCrowd'].value != "0"){
						if (document.all['intItemCount'].value < document.all['intCrowd'].value){
							alert("설문항목 개수보다 필수다중 선택 개수가 큽니다.");
							document.all['intCrowd'].focus();
							return false;
						}
					}
				}
				var len = parseInt(document.theForm.intItemCount[document.theForm.intItemCount.selectedIndex].value);
				for(i=0;i<len;i++){
					if (document.all['strItemSubject'][i].value == ""){
						alert("설문항목을 입력해 주시기 바랍니다.");document.all['strItemSubject'][i].focus();return false;
					}
				}
			}
		}else{
			if (document.all['bitObjective'].value == "1"){
				for(i=0;i<(document.all['intItemCount'].value-1);i++){
					if (document.all['strItemSubject'][i].value == ""){
						alert("설문항목을 입력해 주시기 바랍니다.");document.all['strItemSubject'][i].focus();return false;
					}
				}
			}
		}
	}

	function OnCrowd(){
		if (document.all['bitCrowd'][0].checked == true){
			document.all['tr_crowd'][0].style.display = "none";
			document.all['tr_crowd'][1].style.display = "none";
		}else{
			document.all['tr_crowd'][0].style.display = "block";
			document.all['tr_crowd'][1].style.display = "block";
		}
	}

</script>
<!-- #include file = "../Foot.asp" -->