          </td>
        </tr>
      </table>
    </td>
  </tr>
	<tr>
		<td height="40"><span style='font-size:8pt'>CopyRight Since 2001-2007 <a href='http://webarty.com' target='_blank'><b>WEBARTY.COM</b></a> All Rights RESERVED.</span></td>
  </tr>
</table>
<%
	SELECT CASE strUrl
	CASE "MBOARD.ASP", "MEMBER.ASP", "MEMO.ASP", "POLL.ASP", "SCRAP.ASP"
	CASE ELSE
		SET RS = NOTHING : DBCON.CLOSE
%>
</body>
</html>
<%
	END SELECT
%>