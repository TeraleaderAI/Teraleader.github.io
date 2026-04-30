<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Member/MemberList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM strSearchCategory, strSearchWord, strSearchID, Query, sType

	WITH REQUEST

		strSearchID       = .QueryString("strSearchID")
		strSearchCategory = .FORM("strSearchCategory")
		strSearchWord     = GetReplaceInput(.FORM("strSearchWord"), "")
		sType             = .QueryString("sType")

	END WITH

	IF strSearchID <> "" THEN
		strSearchCategory = "strLoginID"
		strSearchWord     = strSearchID
	END IF

	Query = " WHERE [bitSecession] = '0' AND [strAdmin] != '2' "

	IF strSearchWord <> "" THEN Query = Query & " AND [" & strSearchCategory & "] LIKE '%" & strSearchWord & "%' "

	DIM intPage, intPageSize, intTotalCount, intPageCount
	intPage     = REQUEST.QueryString("intPage") : IF intPage     = "" THEN intPage     = 1
	intPageSize = REQUEST.FORM("intPageSize")    : IF intPageSize = "" THEN intPageSize = 15

	SET RS = DBCON.EXECUTE("SELECT COUNT([strLoginID]) FROM [MPLUS_MEMBER_LIST]" & Query)

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

	SET RS = DBCON.EXECUTE("SELECT TOP " & intPageSize & " [strLoginID], [strLoginName], [intLevel] = (SELECT [intLevel] FROM [MPLUS_GROUP] WHERE [strGroupCode] = [MPLUS_MEMBER_LIST].[strGroup]), [dateSignDate], [dateRegDate] FROM [MPLUS_MEMBER_LIST] " & Query & " AND [intNum] NOT IN (SELECT TOP " & (intPage - 1) * intPageSize & " [intNum] FROM [MPLUS_MEMBER_LIST] " & Query & " ORDER BY [dateRegDate] DESC) ORDER BY [dateRegDate] DESC ")
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post" action="MemberSearchList.asp?sType=<%=sType%>" onSubmit="return OnMemberSearch();">
	<tr>
		<td background="../images/pop_title_bg.gif"><img src="../images/pop_title_member_list.gif" width="155" height="44"></td>
	</tr>
	<tr>
		<td height="8"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="30">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>전체 : <font color="#C6325B"><b><%=intTotalCount%></b></font>&nbsp;&nbsp;<%=intPage%>/<%=intPageCount%> 페이지</td>
								<td align="right">
								<select name="strSearchCategory" id="searchCategory">
								<option value="strLoginName"<% IF strSearchCategory = "strLoginName" THEN %> SELECTED<% END IF %>>회원이름</option>
								<option value="strLoginID"<% IF strSearchCategory = "strLoginID" THEN %> SELECTED<% END IF %>>회원아이디</option>
								<option value="strNick"<% IF strSearchCategory = "strNick" THEN %> SELECTED<% END IF %>>닉네임</option>
								<option value="strEmail"<% IF strSearchCategory = "strEmail" THEN %> SELECTED<% END IF %>>이메일 주소</option>
								</select>
								<input name="strSearchWord" type="text" id="strSearchWord" class="input" value="<%=strSearchWord%>">
								<a href="javascript:;" onClick="OnMemberSearch();return false;"><img src="../images/btn_member_search_w.gif" width="68" height="19" align="absmiddle" border="0"></a></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				  <td>
						<table width="100%"  border="0" cellpadding="0" cellspacing="0">
							<tr align="center" bgcolor="EB766F">
								<td colspan="7" class="table_Round1"></td>
							</tr>
							<tr align="center" bgcolor="EB766F">
								<td height="30" class="table_Txt1" nowrap>선택</td>
								<td class="table_Txt1" nowrap>번호</td>
								<td height="30" class="table_Txt1" nowrap>아이디</td>
								<td height="30" class="table_Txt1" nowrap>이름</td>
								<td height="30" class="table_Txt1" nowrap>레벨</td>
								<td class="table_Txt1" nowrap>최근접속</td>
								<td height="30" nowrap class="table_Txt1">가입일자</td>
							</tr>
							<tr bgcolor="EB766F">
								<td colspan="7" class="table_Round1"></td>
							</tr>
<%
	IF RS.EOF THEN
%>
							<tr align="center" bgcolor="#FFFFFF">
								<td colspan="7" class="table_ListSubText1">검색된 회원이 없습니다.</td>
							</tr>
							<tr>
								<td colspan="7" class="table_ListSubLine1"></td>
							</tr>
<%
	ELSE
		DIM iCount, intMemberNum
		WHILE NOT(RS.EOF)
			iCount = iCount + 1
			intMemberNum = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
							<tr bgcolor="#FFFFFF" align="center">
								<td class="table_ListSubText1"><input name="strLoginID" type="checkbox" id="strLoginID" value="<%=RS("strLoginID")%>" class="no_Line"></td>
								<td class="table_ListSubText1"><%=intMemberNum%></td>
								<td class="table_ListSubText1"><%=RS("strLoginID")%></td>
								<td class="table_ListSubText1"><%=RS("strLoginName")%></td>
								<td class="table_ListSubText1"><%=RS("intLevel")%></td>
								<td class="table_ListSubText1"><% IF RS("dateSignDate") = "" OR ISNULL(RS("dateSignDate")) = True THEN %>-<% ELSE %><%=REPLACE(FORMATDATETIME(RS("dateSignDate"),2),"-","/")%><% END IF %></td>
								<td class="table_ListSubText1"><%=REPLACE(FORMATDATETIME(RS("dateRegDate"),2),"-","/")%></td>
							</tr>
							<tr>
								<td colspan="7" class="table_ListSubLine1"></td>
							</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
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
					<td height="40">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="230">
								<a href="javascript:;" onClick="OnMemberSelectAll();return false;"><img src="../images/btn_select_all_w.gif" width="102" height="19" border="0"></a>
								<a href="javascript:;" onClick="OnMemberSelect();return false;"><img src="../images/btn_select_member_add_w.gif" width="116" height="19" border="0"></a> </td>
								<td align="center"><% CALL GotoPageHTML(intPage, intPageCount) %></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
<%
	SUB GotoPageHTML(intPage, intPageCount)

		RESPONSE.WRITE "<table border='0' cellpadding='0' cellspacing='0'>" & vbcrlf
		RESPONSE.WRITE "	<tr>" & vbcrlf

		DIM intBlockPage, I
		intBlockPage = INT((intPage - 1) / 10) * 10 + 1

		IF intBlockPage = 1 THEN
		ELSE
    	RESPONSE.WRITE "<td id='mytd'><img src='../images/page_allow1.gif' vspace='2'>&nbsp;<a href=""javascript:;"" OnClick=""OnPageMove('" & intBlockPage - 10 & "','" & topMenu & "','" & leftMenu & "');return false;"" class='brn01'>이전</a></td>"
		END IF

		RESPONSE.WRITE "		<td  width='1' nowrap bgcolor='#cccccc'></td>" & vbcrlf

		i = 1
		
		DO UNTIL i > 10 OR intBlockPage > intPageCount

			RESPONSE.WRITE "		<td id='mytd' onMouseOver=""this.style.background='#f7f7f7'"" onMouseOut=""this.style.background=''"" align=center onClick=""OnPageMove('" & intBlockPage & "','" & topMenu & "','" & leftMenu & "');return false;"">"
		
			IF INT(intBlockPage) = INT(intPage) THEN RESPONSE.WRITE "<font color='#ff7635'><b>" & intBlockPage & "</b></font>" ELSE RESPONSE.WRITE "<b>" & intBlockPage & "</b>"

			RESPONSE.WRITE "</td>" & vbcrlf
			RESPONSE.WRITE "<td  width=1 nowrap bgcolor='#cccccc'></td>" & vbcrlf

			intBlockPage = intBlockPage + 1
			I = I + 1
		
		LOOP

    IF intBlockPage > intPageCount THEN
		ELSE
			RESPONSE.WRITE "<td id='mytd'>&nbsp;<a href=""javascript:;"" OnClick=""OnPageMove('" & intBlockPage & "','" & topMenu & "','" & leftMenu & "');return false;"" class='brn01'>다음</a>&nbsp;<img src='../images/page_allow2.gif' vspace='2'></td>"
		END IF

		RESPONSE.WRITE "	</tr>" & vbcrlf
		RESPONSE.WRITE "</table>" & vbcrlf

	END SUB
%>
<script language="javascript">

	var SET_intTotalCount = "<%=intTotalCount%>";
	var SET_sType         = "<%=sType%>";

	function OnPageMove(intPage){
		document.theForm.action = "MemberSearchList.asp?sType=" + SET_sType + "&intPage=" + intPage;
		document.theForm.submit();
	}

	function OnMemberSelectAll(){
		if (SET_intTotalCount != "0"){

			obj = document.all['strLoginID'];

			if (SET_intTotalCount == "1"){
				if (obj.checked == true){obj.checked = false;}else{obj.checked = true}
			}else{
				var cntBox = obj.length - 1;
				for(var i = 0; i <= cntBox; i++){
					if (obj[i].checked == false){obj[i].checked=true;}else{obj[i].checked=false;}
				}
			}
		}
	}

	function OnMemberSelectCheck(){
		var sMember = "";
		if (SET_intTotalCount == "0"){
			return false;
		}else{
			obj = document.all['strLoginID'];
			if (SET_intTotalCount == "1"){
				if (obj.checked == true){
					sMember = sMember + obj.value + ",";
				}
			}else{
				var cntBox = obj.length - 1;
				for(var i = 0; i <= cntBox; i++){
					if (obj[i].checked == true){
						sMember = sMember + obj[i].value + ",";
					}
				}
			}
			return sMember;
		}
	}

	function OnMemberSelect(){

		var sMember = "";
		sMember = OnMemberSelectCheck();
		if (!sMember || sMember == ""){
			alert("회원을 선택해 주시기 바랍니다.");
			return false;
		}

		if (SET_sType == ""){
			parent.document.all['strMemberList'].value = parent.document.all['strMemberList'].value + sMember;
			parent.closeLayer();
		}else{
			parent.BoardAdmin.document.all['strAdminInput'].value = parent.BoardAdmin.document.all['strAdminInput'].value + sMember;
			parent.closeLayer();
		}

	}

	function OnMemberSearch(){
		str = document.all['strSearchWord'];
		if (str.value == ""){alert("검색 단어를 입력해 주시기 바랍니다.");str.focus();return false;}
		document.theForm.submit();
	}

</script>
<!-- #include file = "../Foot.asp" -->