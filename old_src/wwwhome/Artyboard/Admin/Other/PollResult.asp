<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu  = 2
	isAdminPopup = True
%>
<!-- #include file = "../Head.asp" -->
<%
	SET RS = DBCON.EXECUTE("SELECT [strPollCode], [strSubject], [strMemo], [intVoteCount] FROM [MPLUS_POLL] WHERE [intNum] = '" & REQUEST.QueryString("intNum") & "' ")

	DIM strPollCode, strSubject, strMemo, intItemCount, strItem, strValue, intVoteCount

	strPollCode  = RS("strPollCode")
	strSubject   = RS("strSubject")
	strMemo      = RS("strMemo")
	intVoteCount = RS("intVoteCount")
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td background="../images/pop_title_bg.gif"><img src="../images/pop_title_poll_result.gif" width="155" height="44"></td>
	</tr>
	<tr>
		<td height="8"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="33" class="table_Left1">설문조사 제목</td>
					<td class="table_Right1"><%=strSubject%></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td height="33" class="table_Left1">설문조사 설명(메모)</td>
					<td class="table_Right1"><%=strMemo%></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td height="33" class="table_Left1">전체 참여자</td>
					<td class="table_Right1"><%=GetMoneyComma(intVoteCount)%>&nbsp;명</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
				<tr>
					<td height="33" class="table_Left1">설문조사 결과</td>
					<td class="table_Right1">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
<%
	DIM intGrpWidth, intPercent, iCount

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_POLL_ITEM] '" & strPollCode & "' ")

	WHILE NOT(RS.EOF)

		iCount = iCount + 1
		strItem = SPLIT(RS("strItem"), "|")
		strValue = SPLIT(RS("strValue"), "|")
%>
            	<tr>
								<td style="padding-top:5; padding-bottom:5;"><b><%=iCount%>.&nbsp;<%=RS("strSubject")%></b></td>
              </tr>
<% IF RS("bitObjective") = True THEN %>
<%
	FOR I = 0 TO UBOUND(strItem)
		IF strValue(I) = 0 THEN
			intGrpWidth = 2
			intPercent  = "0%"
		ELSE
			intGrpWidth = INT(500 * REPLACE(FORMATPERCENT(strValue(I) / intVoteCount), "%", "") / 100)
			intPercent  = FORMATPERCENT(strValue(I) / intVoteCount)
		END IF
%>
							<tr>
								<td height="20" style="padding-left:10;"><%=I%>.&nbsp;<%=strItem(I)%> - <%=strValue(I)%></td>
							</tr>
							<tr>
								<td height="20" style="font-size:11px; padding-left:20;"><img src="../images/b_grp1.gif" width="<%=intGrpWidth%>" height="10" align="absmiddle">&nbsp;<%=strValue(I)%>&nbsp;(<%=intPercent%>)</td>
							</tr>
<% NEXT %>
<% ELSE %>
							<tr>
								<td height="30" style="padding-left:10;"><a href="javascript:popupLayer('PollResultText.asp?intSeq=<%=RS("intSeq")%>',700,200);"><img src="../images/btn_poll_text_w.gif" width="105" height="19" border="0"></a></td>
							</tr>
<% END IF %>
<%
	RS.MOVENEXT
	WEND
%>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- #include file = "../Foot.asp" -->