						<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../images/left_m_top.gif" width="180" height="6"></td>
                    </tr>
                    <tr>
                      <td align="center" background="../images/left_m_bg.gif">
                        <table width="162" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="37" style="padding-left:6"><img src="../images/left_m_tit4.gif" width="90" height="23"></td>
                          </tr>
                          <tr>
                            <td height="2" bgcolor="D8E5F6"></td>
                          </tr>
                          <tr>
                            <td style="padding:9 0 9 8">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18"><img src="../images/left_m_icon.gif" width="10" height="11"></td>
                                  <td height="20"><a href="BoardMake.asp"><span class="leftMenu<% IF intLeftMenu = 1 THEN %>On<% END IF %>">신규 게시판 생성</span></a></td>
                                </tr>
                                <tr>
                                  <td><img src="../images/left_m_icon.gif" width="10" height="11"></td>
                                  <td height="20"><a href="BoardList.asp"><span class="leftMenu<% IF intLeftMenu = 2 THEN %>On<% END IF %>">게시판 리스트</span></a></td>
                                </tr>
                                <tr>
                                  <td><img src="../images/left_m_icon.gif" width="10" height="11"></td>
                                  <td height="20"><a href="BoardBestList.asp"><span class="leftMenu<% IF intLeftMenu = 3 THEN %>On<% END IF %>">메인 추천 게시글</span></a></td>
                                </tr>
                                <tr>
                                  <td><img src="../images/left_m_icon.gif" width="10" height="11"></td>
                                  <td height="20"><a href="BoardBadAsk.asp"><span class="leftMenu<% IF intLeftMenu = 4 THEN %>On<% END IF %>">불량 게시글 신고내역</span></a></td>
                                </tr>
                                <tr>
                                  <td><img src="../images/left_m_icon.gif" width="10" height="11"></td>
                                  <td height="20"><a href="BoardBadList.asp"><span class="leftMenu<% IF intLeftMenu = 5 THEN %>On<% END IF %>">불량 게시글 리스트</span></a></td>
                                </tr>
                                <tr>
                                  <td><img src="../images/left_m_icon.gif" width="10" height="11"></td>
                                  <td height="20"><a href="BoardCheckList.asp"><span class="leftMenu<% IF intLeftMenu = 6 THEN %>On<% END IF %>">미승인 게시글 리스트</span></a></td>
                                </tr>
                                <tr>
                                  <td><img src="../images/left_m_icon.gif" width="10" height="11"></td>
                                  <td height="20"><a href="BoardSearch.asp"><span class="leftMenu<% IF intLeftMenu = 7 THEN %>On<% END IF %>">게시글 데이타 추적</span></a></td>
                                </tr>
                                <tr>
                                  <td><img src="../images/left_m_icon.gif" width="10" height="11"></td>
                                  <td height="20"><a href="BoardOutSample.asp"><span class="leftMenu<% IF intLeftMenu = 8 THEN %>On<% END IF %>">최근 게시글 출력</span></a></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    
                    <tr>
                      <td height="29" align="center" valign="bottom" background="../images/left_login_bg.gif" style="padding-bottom:6"><strong><u><%=SESSION("strLoginName")%></u>님</strong> 방문을 환영합니다.</td>
                    </tr>
                    <tr>
                      <td><img src="../images/left_m_foot.gif" width="180" height="6"></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td height="100%" valign="top" bgcolor="F3F3F3"></td>
              </tr>
            </table>