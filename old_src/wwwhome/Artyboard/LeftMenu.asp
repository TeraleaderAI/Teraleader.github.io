						<table width="180" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><iframe align="center" width="180" src="Member.asp?Action=login" frameborder="0" onload="this.style.height=this.contentWindow.document.body.scrollHeight;this.style.width=this.contentWindow.document.body.scrollWidth;"></iframe></td>
              </tr>
              <tr>
                <td height="12"></td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="images/left_top_frame.gif" width="180" height="5"></td>
                    </tr>
<%
	SET RS = DBCON.EXECUTE("SELECT TOP 1 [strPollCode], [strSubject] FROM [MPLUS_POLL] WHERE [strStartDate] <= " & GetTodayStr(YEAR(NOW), MONTH(NOW), DAY(NOW), HOUR(NOW), MINUTE(NOW)) & " AND [strEndDate] >= " & GetTodayStr(YEAR(NOW), MONTH(NOW), DAY(NOW), HOUR(NOW), MINUTE(NOW)))
%>
                    <tr>
                      <td background="images/left_bg_frame.gif">
                        <table width="168" border="0" align="center" cellpadding="0" cellspacing="0">
                          <tr>
                            <td><img src="images/research_tit.gif" width="168" height="28"></td>
                          </tr>
<% IF RS.EOF THEN %>
                          <tr>
                            <td height="30"><strong>진행중인 설문조사가 없습니다.</strong></td>
                          </tr>
<% ELSE %>
                          <tr>
                            <td style="padding-top:5; padding-bottom:5;"><strong><%=RS("strSubject")%></strong></td>
                          </tr>
                          <tr>
                            <td height="40" align="center"><a href="poll.asp?Action=read&strPollCode=<%=RS("strPollCode")%>"><img src="images/btn_research1.gif" width="56" height="20" border="0"></a> <a href="Poll.asp?Action=list"><img src="images/btn_research2.gif" width="77" height="20" border="0"></a></td>
                          </tr>
<% END IF %>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td><img src="images/left_foot_frame.gif" width="180" height="5"></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="E5E5E5">
                    <tr>
                      <td height="70" bgcolor="F9F9F9">
                        <table width="150" border="0" align="center" cellpadding="0" cellspacing="0">
<%
	SET RS = DBCON.EXECUTE("SELECT COUNT([intNum]) AS [intTotalCount], COUNT(CASE WHEN DATEDIFF(d, [strConnDate], getdate()) = 0 THEN 1 END) AS [intTodayCount], COUNT(CASE WHEN DATEDIFF(d, [strConnDate], getdate()) = 1 THEN 1 END) AS [intYesterdayCount] FROM [MPLUS_STAT] ")
%>
                          <tr>
                            <td width="10"><img src="images/txt_icon.gif" width="3" height="3"></td>
                            <td height="18">오늘방문 : <%=GetMoneyComma(RS("intTodayCount"))%> 명</td>
                          </tr>
                          <tr>
                            <td><img src="images/txt_icon.gif" width="3" height="3"></td>
                            <td height="18">어제방문 : <%=GetMoneyComma(RS("intYesterdayCount"))%> 명</td>
                          </tr>
                          <tr>
                            <td><img src="images/txt_icon.gif" width="3" height="3"></td>
                            <td height="18"><span style="color:439c24"><strong>전체방문 : <%=GetMoneyComma(RS("intTotalCount"))%> 명</strong></span></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>