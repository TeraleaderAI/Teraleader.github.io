<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu  = 7
	intLeftMenu = 1
	isAdminMenu = 2
	isAdminPopup= False
%>
<!-- #include file = "Head.asp" -->
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title51.gif" width="135" height="19"></td>
                      <td align="right">관리자 홈 &gt; DB 관리 &gt; <b>데이타베이스 정보</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>회원 DB 등록</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
<% SET RS = DBCON.EXECUTE("SELECT @@VERSION") %>
										<tr>
											<td class="table_Left1">SQL 서버 정보</td>
											<td class="table_Right1"><%=RS(0)%></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
<% SET RS = DBCON.EXECUTE("EXEC sp_spaceused ") %>
										<tr>
											<td class="table_Left1">DB 사이즈</td>
											<td>DB 이름 : <%=RS(0)%>, DB 사이즈 : <%=RS(1)%>, 할당 사이즈 : <%=RS(2)%></td>
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
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>회원 DB필드 정보</strong></span></td>
              </tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr align="center" bgcolor="EB766F">
											<td colspan="9" class="table_Round1"></td>
										</tr>
										<tr align="center" bgcolor="EB766F">
											<td height="30" class="table_Txt1" nowrap>번호</td>
											<td height="30" class="table_Txt1" nowrap>테이블명</td>
											<td height="30" class="table_Txt1" nowrap>레코드수</td>
											<td height="30" class="table_Txt1" nowrap>DATA</td>
											<td class="table_Txt1" nowrap>INDEX</td>
											<td class="table_Txt1" nowrap>UNSED</td>
											<td class="table_Txt1" nowrap>크기</td>
											<td class="table_Txt1" nowrap>생성일</td>
											<td height="30" nowrap class="table_Txt1">EXCEL</td>
											</tr>
										<tr bgcolor="EB766F">
											<td colspan="9" class="table_Round1"></td>
										</tr>
<%
	SET RS = DBCON.EXECUTE("SELECT name, crdate FROM sysobjects WHERE xtype='U' ")

	DIM iCount
	WHILE NOT(RS.EOF)

		SET nRS = DBCON.EXECUTE("EXEC sp_spaceused " & RS("name"))
		IF NOT(nRS.EOF) AND RS("name") <> "dtproperties" THEN
		iCount = iCount + 1
%>
										<tr align="center" bgcolor="#FFFFFF">
											<td class="table_ListSubText1"><%=iCount%></td>
											<td class="table_ListSubText1" align="left">[<%=RS("name")%>]</td>
											<td class="table_ListSubText1"><%=nRS(1)%></td>
											<td class="table_ListSubText1"><%=nRS(3)%></td>
											<td class="table_ListSubText1"><%=nRS(4)%></td>
											<td class="table_ListSubText1"><%=nRS(5)%></td>
											<td class="table_ListSubText1"><%=nRS(2)%></td>
											<td class="table_ListSubText1"><%=GetDateType(0, RS("crdate"))%></td>
											<td class="table_ListSubText1"><a href="javascript:;" onClick="OnDbExcel('<%=nRS(1)%>','<%=RS("name")%>');return false;"><img src="../images/btn_down_s.gif" width="58" height="16" border="0" /></a></td>
											</tr>
										<tr>
											<td colspan="9" class="table_ListSubLine1"></td>
										</tr>
<%
		END IF
	RS.MOVENEXT
	WEND
%>
										<tr>
											<td colspan="9" height="1"></td>
										</tr>
										<tr>
											<td colspan="9" class="table_ListSubBLine1"></td>
										</tr>
									</table>
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
											<LI>레코드의 개수가 많은 경우 엑셀 파일로 다운받지 못하는 경우가 발생됩니다.</LI>
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

	function OnDbExcel(str1, str2){
		if (str1 == 0){
			alert("데이타가 없습니다.");
			return false;
		}

		document.theForm.action = "DbTableList_Excel.asp?strTableName=" + str2;
		document.theForm.submit();

	}

</script>
<!-- #include file = "Foot.asp" -->