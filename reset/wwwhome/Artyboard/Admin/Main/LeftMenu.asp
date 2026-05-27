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
                            <td height="37" style="padding-left:6"><img src="../images/left_m_tit0.gif" width="91" height="23"></td>
                          </tr>
                          <tr>
                            <td height="2" bgcolor="D8E5F6"></td>
                          </tr>
                          <tr>
                            <td style="padding:9 0 9 8">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18"><img src="../images/left_m_icon.gif" width="10" height="11"></td>
                                  <td height="20"><a href="../Default/DefaultConfig.asp"><span class="leftMenu<% IF intLeftMenu = 1 THEN %>On<% END IF %>">기본환경설정</span></a></td>
                                </tr>
                                <tr>
                                  <td><img src="../images/left_m_icon.gif" width="10" height="11"></td>
                                  <td height="20"><a href="../Group/GroupList.asp"><span class="leftMenu<% IF intLeftMenu = 2 THEN %>On<% END IF %>">그룹관리</span></a></td>
                                </tr>
                                <tr>
                                  <td><img src="../images/left_m_icon.gif" width="10" height="11"></td>
                                  <td height="20"><a href="../Member/MemberList.asp"><span class="leftMenu<% IF intLeftMenu = 3 THEN %>On<% END IF %>">회원관리</span></a></td>
                                </tr>
                                <tr>
                                  <td><img src="../images/left_m_icon.gif" width="10" height="11"></td>
                                  <td height="20"><a href="../Board/BoardList.asp"><span class="leftMenu<% IF intLeftMenu = 3 THEN %>On<% END IF %>">게시판관리</span></a></td>
                                </tr>
                                <tr>
                                  <td><img src="../images/left_m_icon.gif" width="10" height="11"></td>
                                  <td height="20"><a href="../Stat/StatMemberJoin.asp"><span class="leftMenu<% IF intLeftMenu = 3 THEN %>On<% END IF %>">통계자료</span></a></td>
                                </tr>
                                <tr>
                                  <td><img src="../images/left_m_icon.gif" width="10" height="11"></td>
                                  <td height="20"><a href="../Other/PopupList.asp"><span class="leftMenu<% IF intLeftMenu = 3 THEN %>On<% END IF %>">기타관리</span></a></td>
                                </tr>
                                <tr>
                                  <td><img src="../images/left_m_icon.gif" width="10" height="11"></td>
                                  <td height="20"><a href="../DbManage/DbTableList.asp"><span class="leftMenu<% IF intLeftMenu = 3 THEN %>On<% END IF %>">DB 관리</span></a></td>
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
                <td height="100%" valign="top" bgcolor="F3F3F3">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="8"></td>
                    </tr>
                    <tr>
                      <td align="center"><a href="http://webarty.com/mboard.asp?Action=list&strBoardID=ArtyBoard_update" target="_blank"><img src="../images/left_banner_update.gif" width="172" height="33" border="0"></a></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>