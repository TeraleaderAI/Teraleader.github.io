<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"></head>
<title>▒▒▒ 게시글 신고 ▒▒▒</title>
<link rel="stylesheet" type="text/css" href="style.css">
<body topmargin="0" leftmargin="0">
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	IF SESSION("strLoginID") = "" THEN
		RESPONSE.WRITE ExecJavaAlert("로그인 후 이용하시기 바랍니다.", 1)
		RESPONSE.End()
	END IF

	DIM strBoardID, intSeq
	strBoardID = GetReplaceInput(REQUEST.QueryString("strBoardID"), "S")
	intSeq     = GetReplaceInput(REQUEST.QueryString("intSeq"), "S")

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '" & strBoardID & "'")
	IF RS("bitUseBad") = False THEN
		RESPONSE.WRITE ExecJavaAlert("게시글 신고 기능을 사용하실 수 없는 게시판 입니다.", 1)
		RESPONSE.End()
	END IF
%>
<table width="460" height="100%"  border="0" cellpadding="0" cellspacing="0">
<form name="theForm" method="post" action="BoardBad_ok.asp" onSubmit="return OnSubmitAction();">
<input type="hidden" name="strBoardID" value="<%=strBoardID%>">
<input type="hidden" name="intSeq" value="<%=intSeq%>">
<input type="hidden" name="strLoginID" value="<%=SESSION("strLoginID")%>">
  <tr>
    <td><img src="images/tit_bad.jpg" width="460" height="41"></td>
  </tr>
  <tr>
    <td height="12" bgcolor="F0F0F0">&nbsp;</td>
  </tr>
  <tr>
    <td>
		<table width="97%"  border="0" align="center" cellpadding="0" cellspacing="0">
		  <tr>
			<td height="30"><font color="3096B7"><b>- 게시글 신고접수</b></font> </td>
		  </tr>
		  <tr>
			<td>
				<table width="100%"  border="0" cellpadding="15" cellspacing="3" bgcolor="F0F0F0">
				  <tr>
					<td bgcolor="#FFFFFF">
						<table width="100%"  border="0" cellspacing="0" cellpadding="0">
							<col width="90"><col>
							<tr>
							  <td height="1" colspan="2" bgcolor="F0F0F0"></td>
							</tr>
							<tr>
							  <td height="26" align="right" style="padding-right:10">게시판 아이디 :</td>
							  <td height="26"><%=strBoardID%></td>
							</tr>
							<tr>
							  <td height="26" align="right" style="padding-right:10">게시글 번호 :</td>
							  <td height="26"><%=intSeq%></td>
							</tr>
							<tr>
							  <td height="27" colspan="2">신고 사유 (구체적으로 등록) </td>
							  </tr>
							<tr>
							  <td height="1" colspan="2" bgcolor="F0F0F0"></td>
							</tr>
							<tr>
							  <td colspan="2" style="padding-top:5; padding-bottom:5"><textarea name="strContent" rows="5" id="strContent" style="border:solid 1;border-color:CCCCCC;font-size:9pt;color:000000;background-color:#FEFEFE; width:100%"></textarea></td>
							</tr>
							<tr>
							  <td height="1" colspan="2" bgcolor="F0F0F0"></td>
							</tr>
							<tr>
								<td colspan="2" height="40" align="center"><input type="image" name="imageField" src="images/btn_ok.gif" class="no_Line"></td>
							</tr>
						</table>
					</td>
				  </tr>
				</table>
			</td>
		  </tr>
		</table>
	</td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" bgcolor="E7E7E7"><a href="javascript:self.close();"><img src="images/snap_close.gif" width="57" height="33" border="0"></a></td>
  </tr>
</form>
</table>
<script language="javascript">
	function OnSubmitAction(){
		str = document.all['strContent'];
		if (str.value == ""){alert("신고사유를 입력해 주시기 바랍니다.");str.focus();return false;}
		
		if (confirm("허위로 게시글을 신고할 경우 회원님의 아이디가 박탈될 수 있습니다.\n\n게시글을 신고하시겠습니까?")){
			return;
		}else{
			return false;
		}
	}
</script>
<% SET RS = NOTHING : DBCON.CLOSE %>
</body>
</html>