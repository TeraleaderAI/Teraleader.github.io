<%
	DIM strMailContent, intMailSeq
	strPath = "http://" & REQUEST.ServerVariables("SERVER_NAME") & "/"

	SET RS = DBCON.EXECUTE("SELECT TOP 1 [intSeq] FROM [MPLUS_BOARD] WHERE [strBoardID] = '" & strBoardID & "' ORDER BY [intSeq] DESC ")
	intMailSeq = RS("intSeq")

	strMailContent = "<html>" & vbcrlf
	strMailContent = strMailContent & "<head>" & vbcrlf
	strMailContent = strMailContent & "<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>" & vbcrlf
	strMailContent = strMailContent & "<title></title>" & vbcrlf
	strMailContent = strMailContent & "<link href='" & strPath & "/Admin/Css/style.css' rel='stylesheet' type='text/css'>" & vbcrlf
	strMailContent = strMailContent & "</head>" & vbcrlf
	strMailContent = strMailContent & "<body>" & vbcrlf
	strMailContent = strMailContent & "<table width='580'  border='0' cellspacing='0' cellpadding='0'>" & vbcrlf
	strMailContent = strMailContent & "	<tr>" & vbcrlf
	strMailContent = strMailContent & "		<td colspan='2' rowspan='2'><img src='" & strPath & "/Library/images/mail_img_td01.gif' width='15' height='15'></td>" & vbcrlf
	strMailContent = strMailContent & "		<td height='1' bgcolor='#E2E2E2'></td>" & vbcrlf
	strMailContent = strMailContent & "		<td colspan='2' rowspan='2'><img src='" & strPath & "/Library/images/mail_img_td02.gif' width='15' height='15'></td>" & vbcrlf
	strMailContent = strMailContent & "	</tr>" & vbcrlf
	strMailContent = strMailContent & "	<tr>" & vbcrlf
	strMailContent = strMailContent & "		<td height='14'></td>" & vbcrlf
	strMailContent = strMailContent & "	</tr>" & vbcrlf
	strMailContent = strMailContent & "	<tr>" & vbcrlf
	strMailContent = strMailContent & "		<td width='1' bgcolor='#E2E2E2'></td>" & vbcrlf
	strMailContent = strMailContent & "		<td width='14'></td>" & vbcrlf
	strMailContent = strMailContent & "		<td>" & vbcrlf
	strMailContent = strMailContent & "			<table width='100%'  border='0' cellspacing='0' cellpadding='0'>" & vbcrlf
	strMailContent = strMailContent & "				<tr>" & vbcrlf
	strMailContent = strMailContent & "					<td><img src='" & strPath & "/Library/images/board_logo.gif'></td>" & vbcrlf
	strMailContent = strMailContent & "				</tr>" & vbcrlf
	strMailContent = strMailContent & "				<tr>" & vbcrlf
	strMailContent = strMailContent & "					<td height='10'></td>" & vbcrlf
	strMailContent = strMailContent & "				</tr>" & vbcrlf
	strMailContent = strMailContent & "				<tr>" & vbcrlf
	strMailContent = strMailContent & "					<td>" & vbcrlf
	strMailContent = strMailContent & "						<table width='100%'  border='0' cellspacing='0' cellpadding='0'>" & vbcrlf
	strMailContent = strMailContent & "							<tr>" & vbcrlf
	strMailContent = strMailContent & "								<td height='1' bgcolor='#E2E2E2'></td>" & vbcrlf
	strMailContent = strMailContent & "							</tr>" & vbcrlf
	strMailContent = strMailContent & "							<tr>" & vbcrlf
	strMailContent = strMailContent & "								<td bgcolor='#F7F7F7'>" & vbcrlf
	strMailContent = strMailContent & "									<table width='100%'  border='0' cellspacing='0' cellpadding='10'>" & vbcrlf
	strMailContent = strMailContent & "										<tr>" & vbcrlf
	strMailContent = strMailContent & "											<td width='100%'><strong>" & strSubject & "</strong></td>" & vbcrlf
	strMailContent = strMailContent & "											<td align='right'><a href='" & strPath & "/Mboard.asp?Action=view&strBoardID=" & strBoardID & "&intSeq=" & intMailSeq & "'><img src='" & strPath & "/Library/images/mail_but_go.gif' width='68' height='24' border='0'></a></td>" & vbcrlf
	strMailContent = strMailContent & "										</tr>" & vbcrlf
	strMailContent = strMailContent & "									</table>" & vbcrlf
	strMailContent = strMailContent & "								</td>" & vbcrlf
	strMailContent = strMailContent & "							</tr>" & vbcrlf
	strMailContent = strMailContent & "							<tr>" & vbcrlf
	strMailContent = strMailContent & "								<td height='1' bgcolor='#E2E2E2'></td>" & vbcrlf
	strMailContent = strMailContent & "							</tr>" & vbcrlf
	strMailContent = strMailContent & "							<tr>" & vbcrlf
	strMailContent = strMailContent & "								<td align='right'>" & vbcrlf
	strMailContent = strMailContent & "									<table border='0' cellspacing='0' cellpadding='0'>" & vbcrlf
	strMailContent = strMailContent & "										<tr>" & vbcrlf
	strMailContent = strMailContent & "											<td style='padding:10 10 5 10'><FONT style='color: #6C6C6C; FONT-SIZE:12px; TEXT-DECORATION: none'>등록자 : " & strName & " / 등록일자 : " & REPLACE(NOW(), "-", ".") & "</FONT></td>" & vbcrlf
	strMailContent = strMailContent & "										</tr>" & vbcrlf
	strMailContent = strMailContent & "										<tr>" & vbcrlf
	strMailContent = strMailContent & "											<td height='1' bgcolor='#E2E2E2'></td>" & vbcrlf
	strMailContent = strMailContent & "										</tr>" & vbcrlf
	strMailContent = strMailContent & "									</table>" & vbcrlf
	strMailContent = strMailContent & "								</td>" & vbcrlf
	strMailContent = strMailContent & "							</tr>" & vbcrlf
	strMailContent = strMailContent & "							<tr>" & vbcrlf
	strMailContent = strMailContent & "								<td>" & vbcrlf
	strMailContent = strMailContent & "									<table width='100%'  border='0' cellspacing='0' cellpadding='10'>" & vbcrlf
	strMailContent = strMailContent & "										<tr>" & vbcrlf
	strMailContent = strMailContent & "											<td style='padding: 10 0 10 0'>" & strContent & "</td>" & vbcrlf
	strMailContent = strMailContent & "										</tr>" & vbcrlf
	strMailContent = strMailContent & "									</table>" & vbcrlf
	strMailContent = strMailContent & "								</td>" & vbcrlf
	strMailContent = strMailContent & "							</tr>" & vbcrlf
	strMailContent = strMailContent & "							<tr>" & vbcrlf
	strMailContent = strMailContent & "								<td height='1' bgcolor='#E2E2E2'></td>" & vbcrlf
	strMailContent = strMailContent & "							</tr>" & vbcrlf
	strMailContent = strMailContent & "							<tr>" & vbcrlf
	strMailContent = strMailContent & "								<td align='right' style='padding:10 10 10 10'><a href='" & strPath & "'><FONT face=Verdana, color=#000000 size=1 sans-serif Helvetica, Arial,>" & strPath & "</FONT></a></td>" & vbcrlf
	strMailContent = strMailContent & "							</tr>" & vbcrlf
	strMailContent = strMailContent & "						</table>" & vbcrlf
	strMailContent = strMailContent & "					</td>" & vbcrlf
	strMailContent = strMailContent & "				</tr>" & vbcrlf
	strMailContent = strMailContent & "			</table>" & vbcrlf
	strMailContent = strMailContent & "		</td>" & vbcrlf
	strMailContent = strMailContent & "		<td width='14'></td>" & vbcrlf
	strMailContent = strMailContent & "		<td width='1' bgcolor='#E2E2E2'></td>" & vbcrlf
	strMailContent = strMailContent & "	</tr>" & vbcrlf
	strMailContent = strMailContent & "	<tr>" & vbcrlf
	strMailContent = strMailContent & "		<td colspan='2' rowspan='2'><img src='" & strPath & "/Library/images/mail_img_td03.gif' width='15' height='15'></td>" & vbcrlf
	strMailContent = strMailContent & "		<td height='14'></td>" & vbcrlf
	strMailContent = strMailContent & "		<td colspan='2' rowspan='2'><img src='" & strPath & "/Library/images/mail_img_td04.gif' width='15' height='15'></td>" & vbcrlf
	strMailContent = strMailContent & "	</tr>" & vbcrlf
	strMailContent = strMailContent & "	<tr>" & vbcrlf
	strMailContent = strMailContent & "		<td height='1' bgcolor='#E2E2E2'></td>" & vbcrlf
	strMailContent = strMailContent & "	</tr>" & vbcrlf
	strMailContent = strMailContent & "</table>" & vbcrlf
	strMailContent = strMailContent & "</body>" & vbcrlf
	strMailContent = strMailContent & "</html>" & vbcrlf
%>