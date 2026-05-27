<!-- #include file = "../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../Library/Function.asp" -->
<%
	DIM strUserID, strUserName, strUserPhoto, CONF_strOpenMemo, CONF_strOpenEmail, strUserSex, strUserAge, strUserAddr
	strUserID = GetReplaceInput(REQUEST.QueryString("strUserID"), "S")

	DIM CONF_bitUserFriend

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_FRIEND] '" & SESSION("strLoginID") & "','" & strUserID & "' ")
	IF RS.EOF THEN CONF_bitUserFriend = False ELSE CONF_bitUserFriend = True

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & strUserID & "' ")

	strUserName       = RS("strLoginName")
	strUserPhoto      = RS("strPhotoFile")

	IF strUserPhoto = "" OR ISNULL(strUserPhoto) = True THEN strUserPhoto = "MyMenu/images/no_photo.gif" ELSE strUserPhoto = "Pds/Member/Photo/" & strUserPhoto

	CONF_strOpenMemo  = RS("strOpenMemo")
	CONF_strOpenEmail = RS("bitMailing")

	IF SESSION("strAdmin") = "2" OR SESSION("strLoginID") = strUserID THEN

		IF RS("strSSN") = "" OR ISNULL(RS("strSSN")) = True THEN
			strUserSex = "-"
		ELSE
			IF MID(RS("strSSN"), 7, 1) = "1" OR MID(RS("strSSN"), 7, 1) = "3" THEN strUserSex = "남성" ELSE strUserSex = "여성"
		END IF

		IF TRIM(RS("strSSN")) = "" OR ISNULL(RS("strSSN")) = True THEN
			strUserAge = "-"
		ELSE
			IF MID(RS("strSSN"), 7, 1) = "1" OR MID(RS("strSSN"), 7, 1) = "2" THEN
				strUserAge = YEAR(NOW) - (1900 + INT(LEFT(RS("strSSN"), 2))) & "세"
			ELSE
				strUserAge = YEAR(NOW) - (2000 + INT(LEFT(RS("strSSN"), 2))) & "세"
			END IF
		END IF

		IF RS("strSIDO") = "" OR ISNULL(RS("strSIDO")) = True THEN strUserAddr = "-" ELSE strUserAddr = RS("strSIDO")

	ELSE

		SELECT CASE RS("strOpenSex")
		CASE "0" : strUserSex = "비공개"
		CASE "1"

			IF CONF_bitUserFriend = True THEN
				IF RS("strSSN") = "" OR ISNULL(RS("strSSN")) = True THEN
					strUserSex = "-"
				ELSE
					IF MID(RS("strSSN"), 7, 1) = "1" OR MID(RS("strSSN"), 7, 1) = "3" THEN strUserSex = "남성" ELSE strUserSex = "여성"
				END IF
			ELSE
				strUserSex = "비공개"
			END IF

		END SELECT
	
		SELECT CASE RS("strOpenAge")
		CASE "0" : strUserAge = "비공개"
		CASE "1"

			IF CONF_bitUserFriend = True THEN
				IF RS("strSSN") = "" OR ISNULL(RS("strSSN")) = True THEN
					strUserAge = "-"
				ELSE
					IF MID(RS("strSSN"), 7, 1) = "1" OR MID(RS("strSSN"), 7, 1) = "2" THEN
						strUserAge = YEAR(NOW) - (1900 + INT(LEFT(RS("strSSN"), 2))) & "세"
					ELSE
						strUserAge = YEAR(NOW) - (2000 + INT(LEFT(RS("strSSN"), 2))) & "세"
					END IF
				END IF
			ELSE
				strUserAge = "비공개"
			END IF

		END SELECT
	
		SELECT CASE RS("strOpenAddr")
		CASE "0" : strUserAddr = "비공개"
		CASE "1"

			IF CONF_bitUserFriend = True THEN
				IF RS("strSIDO") = "" OR ISNULL(RS("strSIDO")) = True THEN strUserAddr = "-" ELSE strUserAddr = RS("strSIDO")
			ELSE
				strUserAddr = "비공개"
			END IF

		END SELECT

	END IF

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMO_CONFIG] '" & SESSION("strLoginID") & "' ")

	DIM CONF_bitUseMemo, CONF_bitMemoUse, CONF_intMemoUseLevel, CONF_intMemoSendLevel, CONF_intMemberLevel, CONF_strErrMsg

	CONF_bitUseMemo       = RS("bitUsage")
	CONF_intMemberLevel   = RS("intUserLevel")
	CONF_bitMemoUse       = RS("bitMemoUse")
	CONF_intMemoSendLevel = RS("intMemoSendLevel")
	CONF_intMemoUseLevel  = RS("intMemoUseLevel")
	CONF_strErrorMsg      = RS("strErrorMsg")
%>
<script language="javascript">

	var SET_strUserID = "<%=strUserID%>";
	var SET_strUserName = "<%=strUserName%>";
	var SET_strLoginID = "<%=SESSION("strLoginID")%>";

	function OnMyConfig(){
		if (SET_strUserID != SET_strLoginID){
			alert("본인의 정보만 수정이 가능합니다.");
			return false;
		}

		location.href = "MyMenu.asp?Action=config&strUserID=" + SET_strUserID;
	}

	function OnFriendMenu(strUserID){
		location.href = "MyMenu.asp?Action=info&strUserID=" + strUserID;
	}

</script>
<table width="800" height="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="eaeadd" bgcolor="#f4f4e7" rules="none" style="border-collapse:collapse">
	<tr>
		<td width="155" height="55" align="center" valign="middle" style="padding-left:14"><a href="MyMenu.asp?Action=Main&strUserID=<%=strUserID%>"><img src="MyMenu/images/logo.gif" border="0"></a></td>
		<td height="55" align="left" valign="middle" style="padding-right:25px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><b><%=strUserName%></b>(<%=strUserID%>)의 <b>멤버룸</b> 입니다.</td>
					<td align="right">
					<select name="strMyFriend" id="strMyFriend" style="font-size:12px;" onChange="OnFriendMenu(this.value);">
					<option value="">나의 관심회원 :</option>
<%
	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_FRIEND] '" & SESSION("strLoginID") & "' ")
	WHILE NOT(RS.EOF)
		RESPONSE.WRITE "					<option value=""" & RS("strFriendID") & """>" & RS("strFriendName") & "(" & RS("strFriendID") & ")</option>" & vbcrlf
	RS.MOVENEXT
	WEND
%>
					</select>
					<a href="javascript:;" onClick="self.close();return false;"><img src="MyMenu/images/btn_close.gif" width="44" height="19" align="absmiddle" border="0"></a></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td width="155" align="right" valign="top" style="padding-right:10px;">
			<table width="130" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><!-- #include file = "leftMenu.asp" --></td>
				</tr>
				<tr>
					<td style="padding-top:10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="left"><a href="MyMenu.asp?strUserID=<%=SESSION("strLoginID")%>"><img src="MyMenu/images/btn_my_box.gif" width="65" height="19" border="0"></a></td>
								<td><a href="javascript:;" onClick="OnMyConfig();return false;"><img src="MyMenu/images/btn_open_set.gif" width="54" height="19" border="0"></a></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
		<td width="645" height="100%" valign="top" style="padding-right:15px;">