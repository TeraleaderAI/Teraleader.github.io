<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Group/MailingGroupList.asp"
%>
<!-- #include file = "../Head.asp" -->
<%
	DIM strCode
	strCode = REQUEST.QueryString("strCode")
%>
<table width="920" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="19" background="../images/pop_title_bg.gif"><img src="../images/GroupMember_title.gif" width="155" height="44"></td>
  </tr>
  <tr>
    <td height="8"></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="450" height="458" align="center" valign="top"><table width="450" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>등록된 회원 리스트</strong></span></td>
					</tr>
          <tr>
            <td height="476" valign="top"><iframe name="MailingGroupMemberList" src="MailingGroupMemberList.asp?strCode=<%=strCode%>" width="450" height="476" frameborder="0" scrolling="no"></iframe></td>
          </tr>
        </table></td>
        <td width="450" height="458" align="center" valign="top"><table width="450" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>등록되지 않은 회원 리스트</strong></span></td>
					</tr>
          <tr>
            <td height="476" valign="top"><iframe name="MailingGroupMemberSearchList" src="MailingGroupMemberSearchList.asp?strCode=<%=strCode%>" width="450" height="476" frameborder="0" scrolling="no"></iframe></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
<!-- #include file = "../Foot.asp" -->