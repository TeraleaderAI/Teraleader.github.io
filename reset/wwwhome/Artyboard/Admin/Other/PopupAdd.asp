<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu   = 8
	intLeftMenu  = 1
	isAdminMenu  = 2
	isAdminPopup = False
%>
<!-- #include file = "Head.asp" -->
<%
	DIM Action
	Action = UCASE(REQUEST.QueryString("Action"))
	IF Action = "" THEN Action = "ADD"

	DIM intNum, strStartDate, strEndDate, intPosX, intPosY, bitPosC, strPosition, intWidth, intHeight, strPopupBox, bitScroll
	DIM bitLayerLine, strLayerLineColor, strLayerAni, strSubject, strContent, bitUsage, intVisit, dateRegDate

	IF Action = "ADD" THEN

		strStartDate = YEAR(NOW)
		strEndDate   = YEAR(DATEADD("m", 1, NOW))

		IF LEN(MONTH(NOW)) = 1 THEN strStartDate = strStartDate & "0" & MONTH(NOW) ELSE strStartDate = strStartDate & MONTH(NOW)
		IF LEN(DAY(NOW)) = 1 THEN strStartDate = strStartDate & "0" & DAY(NOW) ELSE strStartDate = strStartDate & DAY(NOW)
		IF LEN(MONTH(DATEADD("m", 1, NOW))) = 1 THEN strEndDate   = strEndDate   & "0" & MONTH(DATEADD("m", 1, NOW)) ELSE strEndDate   = strEndDate   & MONTH(DATEADD("m", 1, NOW))
		IF LEN(DAY(DATEADD("m", 1, NOW))) = 1 THEN strEndDate   = strEndDate   & "0" & DAY(DATEADD("m", 1, NOW)) ELSE strEndDate   = strEndDate   & DAY(DATEADD("m", 1, NOW))

		strPopupBox = "0"
		bitScroll   = True
		bitUsage    = True

	ELSE

		intNum = REQUEST.QueryString("intNum")
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_POPUP] '4', '', '', '', '" & intNum & "' ")

		strStartDate      = RS("strStartDate")
		strEndDate        = RS("strEndDate")
		intPosX           = RS("intPosX")
		intPosY           = RS("intPosY")
		bitPosC           = RS("bitPosC")
		strPosition       = RS("strPosition")
		intWidth          = RS("intWidth")
		intHeight         = RS("intHeight")
		strPopupBox       = RS("strPopupBox")
		bitScroll         = RS("bitScroll")
		bitLayerLine      = RS("bitLayerLine")
		strLayerLineColor = RS("strLayerLineColor")
		strLayerAni       = RS("strLayerAni")
		strSubject        = RS("strSubject")
		strContent        = GetReplaceTag2Editor(RS("strContent"))
		bitUsage          = RS("bitUsage")

	END IF
%>
<script language="javascript">
	var SET_Editor_FilePath = "Pds/Member/Editor/";
</script>
<script type="text/javascript" language="javascript" src="../../Editor/cheditor.js"></script>
<script language="javascript">

	var myeditor = new cheditor("myeditor");

	myeditor.config.editorHeight = '400px';
	myeditor.config.editorWidth = '100%';
	myeditor.config.includeHostname = false;
	myeditor.config.editorBgcolor = "";
	myeditor.inputForm = 'strContent';

</script>
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" action="Popup_ok.asp?Action=<%=Action%>&intNum=<%=intNum%>" onSubmit="return OnSubmitAction();">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title44.gif" width="93" height="19"></td>
                      <td align="right">관리자 홈 &gt; 기타관리 &gt; <b>팝업창 관리</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong><% IF Action = "ADD" THEN %>신규 팝업창 등록<% ELSE %>팝업창 정보수정<% END IF %></strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">출력기간</td>
											<td class="table_Right1">
											<select name="strStartDate" id="strStartDate">
<%
	FOR I = 2005 TO YEAR(NOW) + 1
		RESPONSE.WRITE "<option value='" & I & "'"
		IF INT(I) = INT(LEFT(strStartDate, 4)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">" & I & "</option>" & vbcrlf
	NEXT
%>
											</select> 년
											<select name="strStartDate" id="strStartDate">
<%
	FOR I = 1 TO 12
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I & "'" ELSE RESPONSE.WRITE I & "'"
		IF INT(I) = INT(MID(strStartDate, 5, 2)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">" & I & "</option>" & vbcrlf
	NEXT
%>
											</select> 월
											<select name="strStartDate" id="strStartDate">
<%
	FOR I = 1 TO 31
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I & "'" ELSE RESPONSE.WRITE I & "'"
		IF INT(I) = INT(RIGHT(strStartDate, 2)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">" & I & "</option>" & vbcrlf
	NEXT
%>
											</select> 일 ~
											<select name="strEndDate" id="strEndDate">
<%
	FOR I = 2005 TO YEAR(NOW) + 1
		RESPONSE.WRITE "<option value='" & I & "'"
		IF INT(I) = INT(LEFT(strEndDate, 4)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">" & I & "</option>" & vbcrlf
	NEXT
%>
											</select> 년
											<select name="strEndDate" id="strEndDate">
<%
	FOR I = 1 TO 12
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I & "'" ELSE RESPONSE.WRITE I & "'"
		IF INT(I) = INT(MID(strEndDate, 5, 2)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">" & I & "</option>" & vbcrlf
	NEXT
%>
											</select> 월
											<select name="strEndDate" id="strEndDate">
<%
	FOR I = 1 TO 31
		RESPONSE.WRITE "<option value='"
		IF LEN(I) = 1 THEN RESPONSE.WRITE "0" & I & "'" ELSE RESPONSE.WRITE I & "'"
		IF INT(I) = INT(RIGHT(strEndDate, 2)) THEN RESPONSE.WRITE " SELECTED "
		RESPONSE.WRITE ">" & I & "</option>" & vbcrlf
	NEXT
%>
											</select> 일</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">팝업창 위치 설정방식</td>
											<td class="table_Right1">
											<input type="radio" name="bitPosC" id="bitPosC1" value="0"<% IF bitPosC = False THEN %> CHECKED<% END IF %> class="no_Line" onClick="OnPosition('0');"><LABEL FOR="bitPosC1" style="cursor:hand">고정위치</LABEL>
											<input type="radio" name="bitPosC" id="bitPosC2" value="1"<% IF bitPosC = True THEN %> CHECKED<% END IF %> class="no_Line" onClick="OnPosition('1');"><LABEL FOR="bitPosC2" style="cursor:hand">상대위치</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr id="tr_Position" style="display:<% IF bitPosC = False THEN %>none<% ELSE %>block<% END IF %>">
											<td class="table_Left1">팝업창 상대위치 설정</td>
											<td class="table_Right1">
											<input type="radio" name="strPosition" id="strPosition1" value="0"<% IF strPosition = "0" THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strPosition1" style="cursor:hand">상단 좌측</LABEL>
											<input type="radio" name="strPosition" id="strPosition2" value="1"<% IF strPosition = "1" THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strPosition2" style="cursor:hand">상단 중앙</LABEL>
											<input type="radio" name="strPosition" id="strPosition3" value="2"<% IF strPosition = "2" THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strPosition3" style="cursor:hand">상단 우측</LABEL>
											<input type="radio" name="strPosition" id="strPosition4" value="3"<% IF strPosition = "3" THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="strPosition4" style="cursor:hand">중앙</LABEL>
											</td>
										</tr>
										<tr id="tr_Position" style="display:<% IF bitPosC = False THEN %>none<% ELSE %>block<% END IF %>">
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">팝업창 위치</td>
											<td class="table_Right1">X 
											<input name="intPosX" type="text" id="intPosX"onBlur="onlynum(this,'1');" value="<%=intPosX%>" size="6" maxlength="4">&nbsp;&nbsp;&nbsp;Y
											<input name="intPosY" type="text" id="intPosY"onBlur="onlynum(this,'1');" value="<%=intPosY%>" size="6" maxlength="4"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">팝업창 크기 </td>
											<td class="table_Right1">가로
											<input name="intWidth" type="text" id="intWidth"onBlur="onlynum(this,'1');" value="<%=intWidth%>" size="6" maxlength="4">
											px
											&nbsp;&nbsp;&nbsp;세로
											<input name="intHeight" type="text" id="intHeight"onBlur="onlynum(this,'1');" value="<%=intHeight%>" size="6" maxlength="4">
											px</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">팝업창 종류</td>
											<td class="table_Right1"><input type="radio" name="strPopupBox" id="strPopupBox1" value="0"<% IF strPopupBox = "0" THEN %> CHECKED<% END IF %> class="no_Line" onClick="OnPopType('0');"><LABEL FOR="strPopupBox1" style="cursor:hand">일반적인 팝업창</LABEL>
											<input type="radio" name="strPopupBox" id="strPopupBox2" value="1"<% IF strPopupBox = "1" THEN %> CHECKED<% END IF %> class="no_Line" onClick="OnPopType('1');"><LABEL FOR="strPopupBox2" style="cursor:hand">대화상자형 팝업창</LABEL>
											<input type="radio" name="strPopupBox" id="strPopupBox3" value="2"<% IF strPopupBox = "2" THEN %> CHECKED<% END IF %> class="no_Line" onClick="OnPopType('2');"><LABEL FOR="strPopupBox3" style="cursor:hand">레이어 팝업창</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr id="tr_Line" style="display:<% IF strPopupBox = "2" THEN %>block<% ELSE %>none<% END IF %>">
											<td class="table_Left1">팝업창 테두리</td>
											<td class="table_Right1"><input name="bitLayerLine" type="checkbox" id="bitLayerLine" value="1"<% IF bitLayerLine = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitLayerLine" style="cursor:hand">테두리 사용</LABEL>&nbsp;&nbsp;&nbsp;테두리 라인색상&nbsp;<input name="strLayerLineColor" type="text" id="strLayerLineColor" onBlur="OnColorSet(document.all['strColorHoverPrev'], this);" value="<%=strLayerLineColor%>" size="8" maxlength="7">&nbsp;<INPUT style="BACKGROUND: <%=strLayerLineColor%>; CURSOR: hand" onclick="popupLayer('../../Library/setColor.asp?target=strLayerLineColor',410,430);" READONLY size=2 name="strLayerLineColorPrev"></td>
										</tr>
										<tr id="tr_Line" style="display:<% IF strPopupBox = "2" THEN %>block<% ELSE %>none<% END IF %>">
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr id="tr_Ani" style="display:<% IF strPopupBox = "2" THEN %>block<% ELSE %>none<% END IF %>">
											<td class="table_Left1">팝업창 테두리</td>
											<td class="table_Right1">
											<input type="radio" name="strLayerAni" id="strLayerAni1" value="down" class="no_Line"<% IF strLayerAni = "down" THEN %> CHECKED<% END IF %>><LABEL FOR="strLayerAni1" style="cursor:hand">위에서 아래로</LABEL>
											<input type="radio" name="strLayerAni" id="strLayerAni2" value="up" class="no_Line"<% IF strLayerAni = "up" THEN %> CHECKED<% END IF %>><LABEL FOR="strLayerAni2" style="cursor:hand">아래에서 위로</LABEL>
											<input type="radio" name="strLayerAni" id="strLayerAni3" value="right" class="no_Line"<% IF strLayerAni = "right" THEN %> CHECKED<% END IF %>><LABEL FOR="strLayerAni3" style="cursor:hand">좌측에서 우측으로</LABEL>
											<input type="radio" name="strLayerAni" id="strLayerAni4" value="left" class="no_Line"<% IF strLayerAni = "left" THEN %> CHECKED<% END IF %>><LABEL FOR="strLayerAni4" style="cursor:hand">우측에서 좌측으로</LABEL>
											</td>
										</tr>
										<tr id="tr_Ani" style="display:<% IF strPopupBox = "2" THEN %>block<% ELSE %>none<% END IF %>">
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">팝업창 스크롤</td>
											<td class="table_Right1"><input type="radio" name="bitScroll" id="bitScroll1" value="1"<% IF bitScroll = True THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitScroll1" style="cursor:hand">스크롤 허용함</LABEL>
											<input type="radio" name="bitScroll" id="bitScroll2" value="0"<% IF bitScroll = False THEN %> CHECKED<% END IF %> class="no_Line"><LABEL FOR="bitScroll2" style="cursor:hand">스크롤 허용안함</LABEL></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">제목</td>
											<td class="table_Right1"><input name="strSubject" type="text" id="strSubject" value="<%=strSubject%>" maxlength="128" style="width:100%"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">내용</td>
											<td class="table_Right1">
											<textarea id="strContent" name="strContent" style="display:none"><%=strContent%></textarea>
											<script type="text/javascript" language="javascript">myeditor.run();</script>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">현재상태</td>
											<td class="table_Right1"><select name="bitUsage" id="bitUsage">
											<option value="0"<% IF bitUsage = False THEN %> SELECTED<% END IF %>>사용중지</option>
											<option value="1"<% IF bitUsage = True THEN %> SELECTED<% END IF %>>사용중</option>
											</select>&nbsp;<font color="#FD8402">현재상태가 사용중이라도 공지종료일자가 지나면 팝업창 출력안됨</font></td>
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
											<LI>드림위버, 나모웹에디터 등으로 작성후 붙여넣기로 할때는 이미지 경로에 주의하세요.</LI>
											<LI>이미지는 기본적으로 제공되는 에디터에서 신규로 등록이 가능합니다.</LI>
											<LI>제목에는 가급적 HTML코드를 사용하지 마시기 바랍니다. 팝업창 타이틀로 사용이 됩니다.</LI>
											<LI>레이어 팝업을 사용할때, &lt;A HREF="이동URL" TARGET="_parent"&gt;바로가기&lt;/A&gt;로 하시면, 메인창에서 링크가 이동합니다.</LI>
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

	function OnSubmitAction(){
		str = document.all['strSubject'];
		if (str.value == ""){alert("제목을 입력해 주시기 바랍니다.");str.focus();return false;}

		str = document.all['strSubject'];
		if (str.value == ""){alert("메일제목을 입력해 주시기 바랍니다.");str.focus();return false;}

		document.getElementById("strContent").value = myeditor.outputBodyHTML();

		if (document.getElementById("strContent").value == ""){
			alert("내용을 입력해 주시기 바랍니다.");myeditor.editArea.focus();return false;
		}

	}

	function OnPosition(str){
		if (str == "0"){
			document.all['tr_Position'][0].style.display = "none";
			document.all['tr_Position'][1].style.display = "none";
		}else{
			document.all['tr_Position'][0].style.display = "block";
			document.all['tr_Position'][1].style.display = "block";
		}
	}

	function OnPopType(str){
		if (str == "2"){
			document.all['tr_Line'][0].style.display = "block";
			document.all['tr_Line'][1].style.display = "block";
			document.all['tr_Ani'][0].style.display = "block";
			document.all['tr_Ani'][1].style.display = "block";
		}else{
			document.all['tr_Line'][0].style.display = "none";
			document.all['tr_Line'][1].style.display = "none";
			document.all['tr_Ani'][0].style.display = "none";
			document.all['tr_Ani'][1].style.display = "none";
		}
	}

</script>
<!-- #include file = "Foot.asp" -->