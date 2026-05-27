<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"></head>
<title>▒▒▒ 게시글 관리 ▒▒▒</title>
<link rel="stylesheet" type="text/css" href="style.css">
<body topmargin="0" leftmargin="0">
<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	IF SESSION("strLoginID") = "" THEN
		RESPONSE.WRITE ExecJavaAlert("관리자만 접근이 가능합니다.", 1)
		RESPONSE.End()
	END IF

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '" & GetReplaceInput(REQUEST.QueryString("strBoardID"), "S") & "', '" & SESSION("strLoginID") & "' ")

	IF GetAdminCheck(SESSION("strLoginID"), RS("strAdmin"), SESSION("strAdmin")) = False THEN
		RESPONSE.WRITE ExecJavaAlert("관리자만 접근이 가능합니다.", 1)
		RESPONSE.End()
	END IF

	DIM intSeqTemp, Query, I, QueryIntThRead
	intSeqTemp = SPLIT(GetReplaceInput(REQUEST.QueryString("intSeq"), "S"), ",")
	Query = " WHERE [intSeq] IN ("

	FOR I = 0 TO UBOUND(intSeqTemp)
		Query = Query & "'" & intSeqTemp(I) & "',"
	NEXT
	Query = LEFT(Query, LEN(Query) - 1)
	Query = Query & ") "

	SET RS = DBCON.EXECUTE("SELECT [intThRead] FROM [MPLUS_BOARD] " & Query & " AND [intDepth] = '0' ORDER BY [intThRead] ASC ")

	QueryIntThRead = ""

	IF RS.EOF THEN
		RESPONSE.WRITE ExecJavaAlert("관리자 기능으로 실행 가능한 게시글이 없습니다.", 1)
		RESPONSE.End()
	END IF
	WHILE NOT(RS.EOF)
		QueryIntThRead = QueryIntThRead & RS("intThRead") & ","
	RS.MOVENEXT
	WEND
%>
<table width="460"  border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post">
<input type="hidden" name="intThRead" value="<%=QueryIntThRead%>">
<input type="hidden" name="strOrigBoardID" value="<%=GetReplaceInput(REQUEST.QueryString("strBoardID"),"S")%>">
  <tr>
    <td><img src="images/tit_snap.jpg" width="460" height="41"></td>
  </tr>
  <tr>
    <td height="12" bgcolor="F0F0F0">&nbsp;</td>
  </tr>
  <tr>
    <td>
		<table width="97%"  border="0" align="center" cellpadding="0" cellspacing="0">
		  <tr>
			<td height="30"><font color="3096B7"><b>- 선택된 게시물</b></font> </td>
		  </tr>
		  <tr>
			<td>
				<table width="100%"  border="0" cellpadding="15" cellspacing="3" bgcolor="F0F0F0">
				  <tr>
					<td bgcolor="#FFFFFF">
						<table width="100%"  border="0" cellspacing="0" cellpadding="0">
							<tr>
							  <td height="1" colspan="2" bgcolor="F0F0F0"></td>
							</tr>
							<tr>
							  <td height="20">&nbsp;</td>
							  <td align="right"><a href="javascript:;" onClick="OnBoardRemove();return false;"><img src="images/btn_snap_del.gif" width="68" height="16" border="0"></a></td>
							</tr>
							<tr>
							  <td height="27"><select name="strNotice" class="inputfs" id="strNotice" style="background-color:F7F4F8">
							    <option value="isNotice" selected>일반글 -&gt; 공지글로 변경</option>
							    <option value="isBoard">공지글 -&gt; 게시글로 변경</option>
							  </select></td>
							  <td align="right"><a href="javascript:;" onClick="OnNoticeChange();return false;"><img src="images/btn_snap_ch.gif" width="68" height="16" border="0"></a></td>
							</tr>
							<tr>
							  <td height="27"><select name="strBoardID" class="inputfs" id="strBoardID" style="background-color:F7F4F8">
								<option value="" selected>▒ 복사 또는 이동할 게시판 선택 ▒</option>
<%
	SET RS = DBCON.EXECUTE("SELECT [strBoardID], [strName] FROM [MPLUS_BOARD_CONFIG_DEFAULT] ")
	WHILE NOT(RS.EOF)
		RESPONSE.WRITE "<option value='" & RS("strBoardID") & "'>" & RS("strBoardID") & " - [" & RS("strName") & "]</option>" & vbcrlf
	RS.MOVENEXT
	WEND
%>
								</select></td>
							  <td align="right"><a href="javascript:;" onClick="OnBoardCopy();return false;"><img src="images/btn_snap_copy.gif" width="68" height="16" border="0"></a> <a href="javascript:;" onClick="OnBoardMove();return false;"><img src="images/btn_snap_mov.gif" width="68" height="16" border="0"></a></td>
							</tr>
							<tr>
							  <td height="1" colspan="2" bgcolor="F0F0F0"></td>
							</tr>
							<tr>
							  <td height="27" colspan="2"><input name="bitNewDate" type="checkbox" id="bitNewDate" value="1" checked class="no_Line"><LABEL FOR="bitNewDate" style="cursor:hand">게시글 복사/이동시 등록일자를 현재날짜로 변경</LABEL></td>
							</tr>
							<tr>
							  <td height="27" colspan="2"><input name="bitAddMemo" type="checkbox" id="bitAddMemo" value="1" checked class="no_Line"><LABEL FOR="bitAddMemo" style="cursor:hand">게시글 복사/이동시 게시글 본문에 복사/이동일자 추가저장</LABEL></td>
							</tr>
							<tr>
							  <td height="1" colspan="2" bgcolor="F0F0F0"></td>
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
	function OnBoardCopy(){
		str = document.all['strBoardID'];
		if (str.value == ""){alert("게시글을 복사할 게시판을 선택해 주시기 바랍니다.");str.focus();return false;}

		if (confirm("선택된 게시판으로 게시글을 복사하시겠습니까?\n\n게시글 복사시에는 복사된 게시글에는 포인트가 지급되지 않습니다.")){
			document.theForm.action = "Snap_ok.asp?Action=copy";
			document.theForm.submit();
		}
	}

	function OnBoardMove(){
		str = document.all['strBoardID'];
		if (str.value == ""){alert("게시글을 이동할 게시판을 선택해 주시기 바랍니다.");str.focus();return false;}

		if (confirm("선택된 게시판으로 게시글을 이동하시겠습니까?\n\n게시글 이동시 해당되는 게시글 관련 포인트는 초기화됩니다.")){
			document.theForm.action = "Snap_ok.asp?Action=move";
			document.theForm.submit();
		}
	}


	function OnBoardRemove(){
		if(confirm("삭제된 게시글은 복구가 불가능합니다.\n\n선택된 게시글을 삭제하시겠습니까?")){
			document.theForm.action = "Snap_ok.asp?Action=remove";
			document.theForm.submit();
		}
	}

	function OnNoticeChange(){
		str = document.all['strNotice'].value;
		switch (str){
			case "isNotice" :
				if (confirm("선택된 게시글을 공지글로 변경하시겠습니까?")){
					document.theForm.action = "Snap_ok.asp?Action=isNotice";
					document.theForm.submit();
				}
				break;
			case "isBoard" :
				if (confirm("선택된 게시글을 일반글로 변경하시겠습니까?")){
					document.theForm.action = "Snap_ok.asp?Action=isBoard";
					document.theForm.submit();
				}
				break;
		}
	}
</script>
<% SET RS = NOTHING : DBCON.CLOSE %>
</body>
</html>