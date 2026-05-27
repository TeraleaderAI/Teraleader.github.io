<HTML>
<HEAD>
<TITLE>▒▒▒ 우편번호 검색 ▒▒▒</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"></HEAD>
<BODY bgcolor="#FFFFFF" onLoad="init();">
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM strForm, searchStr
	strForm   = GetReplaceInput(REQUEST.QueryString("strForm"), "S")
	searchStr = GetReplaceInput(REQUEST.Form("searchStr"), "S")
%>
<style>
	#scrollbox {width:100%; height:140; overflow:auto; padding:0px; border:0px solid #A0D7D9;}
	BODY {MARGIN: 0px; SCROLLBAR-FACE-COLOR: #EAE6E6; SCROLLBAR-HIGHLIGHT-COLOR: #666666; SCROLLBAR-SHADOW-COLOR: #666666; SCROLLBAR-3DLIGHT-COLOR: #eeeeee; SCROLLBAR-ARROW-COLOR: #000000; SCROLLBAR-TRACK-COLOR: #eeeeee; SCROLLBAR-DARKSHADOW-COLOR: #ffffff}
	BODY {FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: 굴림}
	TH, TD {FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: Tahoma,Verdana,Arial;line-height:130%;}
	.INPUT_LINE {BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; FONT-SIZE: 9pt; BORDER-LEFT: #000000 1px solid; COLOR: #666666; BORDER-BOTTOM: #000000 1px solid; FONT-FAMILY: Tahoma,Verdana,Arial; HEIGHT: 21px; BACKGROUND-COLOR: #ffffff}

	A:link 		{FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: "굴림"; TEXT-DECORATION: none}
	A:visited {FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: "굴림"; TEXT-DECORATION: none}
	A:hover 	{FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: "굴림"; TEXT-DECORATION: none}
</style>
<table width="590" height="100%" border="0" cellpadding="0" cellspacing="0">
<form name="theForm" method="post" action="findPost.asp?strForm=<%=strForm%>">
	<tr>
		<td><img src="images/tit_zip.jpg" width="600" height="66"></td>
	</tr>
	<tr>
		<td height="100%" align="center" valign="top">
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="25"></td>
				</tr>
				<tr>
					<td height="290" align="center" valign="top">
						<table width="540" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="center" style="padding-bottom:12">찾고싶으신 주소의 동(읍/면) 이름을 입력하세요.<br>예) 청담1동, 한강로 3가, 수지읍</td>
							</tr>
							<tr>
							  <td align="center" style="padding-bottom:30"><input name="searchStr" type="text" id="searchStr" style="BORDER-RIGHT: #EAE6E6 1px solid; BORDER-TOP: #EAE6E6 1px solid; FONT-SIZE: 9pt; BORDER-LEFT: #EAE6E6 1px solid; COLOR: #666666; BORDER-BOTTOM: #EAE6E6 1px solid; BACKGROUND-COLOR: #ffffff">&nbsp;<a href="javascript:OnSearch('member');"><img src="images/bu_search.gif" width="65" height="19" border="0" align="absmiddle"></a></td>
							</tr>
							<tr>
								<td style="padding-bottom:10">검색 결과중 해당주소를 클릭하시면 자동입력됩니다.</td>
							</tr>
							<tr>
								<td>
									<DIV id="scrollbox">
									<table width="100%" border="0" cellspacing="0" cellpadding="6">
										<tr>
											<td width="80" height="28" bgcolor="#DBEEE5" style="border-top: #009999 1px solid ; border-bottom:#EAE6E6 1px solid ; border-right:#EAE6E6 1px solid">우편번호</td>
											<td width="410" bgcolor="#DBEEE5" style="border-top: #009999 1px solid ; border-bottom:#EAE6E6 1px solid">주소</td>
										</tr>
<% IF searchStr = "" THEN %>
										<tr>
											<td height="28" colspan="2" align="center" style="border-bottom:#EAE6E6 1px solid ; border-right:#EAE6E6 1px solid">지역명을 입력 후 검색버튼을 클릭해 주세요.</td>
									  </tr>
<%
	ELSE
		SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_POST] '" & searchStr & "' ")
		WHILE NOT(RS.EOF)
%>
										<tr>
											<td width="80" height="28" align="center" style="border-bottom:#EAE6E6 1px solid ; border-right:#EAE6E6 1px solid"><%=RS("ZIPCODE")%></td>
											<td width="410" style="border-bottom:#EAE6E6 1px solid"><a href="javascript:doLink('<%=RS("ZIPCODE")%>','<%=RS("SIDO")%>','<%=RS("GUGUN")%>','<%=RS("DONG")%>','<%=RS("BUNJI")%>','<%=strForm%>');"><%=RS("SIDO")%>&nbsp;<%=RS("GUGUN")%>&nbsp;<%=RS("DONG")%>&nbsp;<%=RS("BUNJI")%></a></td>
										</tr>
<%
		RS.MOVENEXT
		WEND
	END IF
%>
									</table>
									</DIV>
								</td>
							</tr>
					  </table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="38" align="right" bgcolor="#E7E7E7" style="padding-right:10"><a href="javascript:self.close();"><img src="images/bu_close.gif" width="56" height="38" border="0"></a></td>
	</tr>
</form>
</table>
<script language="javascript">
	function init(){
		window.resizeTo(600, 529);
	}

	function OnSearch(str){
		str = document.all['searchStr'];
		if (str.value == ""){
			alert("검색하실 지역명을 입력해 주시기 바랍니다.");
			str.focus();
			return false;
		}
		document.theForm.submit();
	}


	function doLink(str1, str2, str3, str4, str5, str6){
		opener.document.all[str6][0].value = str1.substring(0, 3);
		opener.document.all[str6][1].value = str1.substring(4, 7);
		opener.document.all[str6][2].value = str2 + " " + str3 + " " + str4;
		opener.document.all[str6][3].focus();
		self.close();
	}

</script>
<% SET RS = NOTHING : DBCON.CLOSE %>
</BODY>
</HTML>