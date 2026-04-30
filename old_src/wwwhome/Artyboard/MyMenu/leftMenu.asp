<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#b3b3a6" bgcolor="#FFFFFF" rules="none" style="border-collapse:collapse;">
	<tr>
		<td style="padding:10px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td style="padding-bottom:5px;"><img src="<%=strUserPhoto%>" width="83" height="97"></td>
				</tr>
				<tr>
					<td class="profile_box" style="line-height:16px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><font color="#666666">성별 : </font><font color="#888888"><%=strUserSex%></font></td>
							</tr>
							<tr>
								<td><font color="#666666">나이 : </font><font color="#888888"><%=strUserAge%></font></td>
							</tr>
							<tr>
								<td><font color="#666666">지역 : </font><font color="#888888"><%=strUserAddr%></font></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="leftPadding"><img src="MyMenu/images/ico_dot.gif" width="9" height="9"><a href="MyMenu.asp?Action=info&strUserID=<%=strUserID%>">기본정보</a></td>
	</tr>
	<tr>
		<td height="15" class="leftPadding">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td background="MyMenu/images/line_dot.gif" height="9"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="20" style="line-height:18px;" class="leftPadding"><img src="MyMenu/images/ico_dot.gif" width="9" height="9"><a href="MyMenu.asp?Action=email&strUserID=<%=strUserID%>">이메일 보내기</a></td>
	</tr>
<% IF CONF_bitUseMemo = True AND CONF_bitMemoUse = True THEN %>
	<tr>
		<td height="20" style="line-height:18px;" class="leftPadding"><img src="MyMenu/images/ico_dot.gif" width="9" height="9"><a href="MyMenu.asp?Action=memo&strUserID=<%=strUserID%>">쪽지 보내기</a></td>
	</tr>
<% END IF %>
	<tr>
		<td height="15" class="leftPadding">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td background="MyMenu/images/line_dot.gif" height="9"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="20" class="leftPadding"><img src="MyMenu/images/ico_dot.gif" width="9" height="9"><a href="MyMenu.asp?Action=BoardList&strUserID=<%=strUserID%>">포스트목록</a></td>
	</tr>
	<tr>
		<td height="20" class="leftPadding"><img src="MyMenu/images/ico_dot.gif" width="9" height="9"><a href="MyMenu.asp?Action=CmtList&strUserID=<%=strUserID%>">댓글목록</a></td>
	</tr>
	<tr>
		<td height="15" class="leftPadding">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td background="MyMenu/images/line_dot.gif" height="9"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="20" class="leftPadding"><img src="MyMenu/images/ico_dot.gif" width="9" height="9"><a href="MyMenu.asp?Action=Guest&strUserID=<%=strUserID%>">흔적 남기기</a></td>
	</tr>
	<tr>
		<td height="20" class="leftPadding">&nbsp;</td>
	</tr>
</table>