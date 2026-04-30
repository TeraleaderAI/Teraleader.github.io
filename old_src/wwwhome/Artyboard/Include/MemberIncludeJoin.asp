<!-- #include file = "MemberInclude.asp" -->
<%
	IF UCASE(GetReplaceInput(REQUEST.QueryString("Action"), "S")) = "REGIST" THEN
		IF REQUEST.FORM("bitCheck1") = "" OR REQUEST.FORM("bitCheck2") = "" THEN
			RESPONSE.WRITE ExecJavaAlert("회원가입 약관 및 개인정보보호정책에\n\n동의하셔야 회원가입이 가능합니다.", 0)
			RESPONSE.End()
		END IF
	END IF

	IF Action = "REGIST" THEN Action = "JOIN"

	DIM strJoinNotEmail, strJoinType, bitJoinEmailActivate, strJoinNotMsg, strJoinNotEmailCount, iList, iListCount, strWidth, strAlign
	DIM strSkin, strSkinGroup, skinPath, intNameAvataWidth, intNameAvataHeight, strJoinUrl, strJoinUrlTarget

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_JOIN] ")

	strSkin              = RS("strSkin")
	strSkinGroup         = RS("strSkinGroup")
	skinPath             = GetSkinPath(strSkin, 1, strSkinGroup, 1) & "/"

	strJoinNotEmail      = RS("strJoinNotEmail")
	strJoinType          = RS("strJoinType")
	bitJoinEmailActivate = RS("bitJoinEmailActivate")
	strJoinNotMsg        = RS("strJoinNotMsg")
	strWidth             = RS("strWidth")
	strAlign             = RS("strAlign")
	intNameAvataWidth    = RS("intNameAvataWidth")
	intNameAvataHeight   = RS("intNameAvataHeight")
	strJoinUrl           = RS("strJoinUrl")
	strJoinUrlTarget     = RS("strJoinUrlTarget")

	SELECT CASE strAlign
	CASE "0" : strAlign = "LEFT"
	CASE "1" : strAlign = "CENTER"
	CASE "2" : strAlign = "RIGHT"
	END SELECT

	IF Action = "JOIN" THEN
		IF strJoinType = "2" THEN
			RESPONSE.WRITE "<script language=javascript>" & vbcrlf
			RESPONSE.WRITE "alert('" & strJoinNotMsg & "')" & vbcrlf
			RESPONSE.WRITE "history.go(-1);" & vbcrlf
			RESPONSE.WRITE "</script>" & vbcrlf
			RESPONSE.End()
		END IF
	END IF

	IF Action = "EDIT" OR Action = "RESULT" THEN
		IF Action = "EDIT" AND SESSION("strLoginID") = "" THEN
			RESPONSE.WRITE ExecJavaAlert("로그인 후 이용하실 수 있습니다.", 0)
			RESPONSE.End()
		END IF

		IF Action = "EDIT" THEN
			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & SESSION("strLoginID") & "' ")
		ELSE
			SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & GetReplaceInput(REQUEST.QueryString("strLoginID"), "S") & "' ")
		END IF
%>
<!-- #include file = "MemberIncludeRead.asp" -->
<%
	END IF

	IF strJoinNotEmail <> "" AND ISNULL(strJoinNotEmail) = False THEN
		strJoinNotEmail      = SPLIT(strJoinNotEmail, CHR(13)&CHR(10))
		strJoinNotEmailCount = UBOUND(strJoinNotEmail)
	ELSE
		strJoinNotEmailCount = 0
	END IF

	SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.COMMAND")
	SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RECORDSET")

	WITH AdCmd
			
		.ActiveConnection	= DbConnect
		.CommandText		  = "MPLUS_GET_MEMBER_CONFIG_JOIN_ITEM"
		.CommandTimeOut		= 10
		.CommandType		  = adCmdStoredProc

		AdRs.Open .Execute
				
		IF (NOT (AdRs.EOF OR AdRs.BOF)) THEN
			AdRs_GetRows       = AdRs.GetRows
			AdRs_GetRows_Count = UBOUND(AdRs_GetRows, 2)
		END IF

		AdRs.Close

		SET	AdRS	= Nothing : SET	AdCmd	= Nothing

	END WITH

	iListCount = AdRs_GetRows_Count

	REDIM iMemberItem(AdRs_GetRows_Count)
	REDIM iMemberTitle(AdRs_GetRows_Count)
	REDIM iMemberRequire(AdRs_GetRows_Count)
	REDIM iMemberRequireNum(AdRs_GetRows_Count)
	REDIM iMemberOptionNum(AdRs_GetRows_Count)
	REDIM iMaxLength(AdRs_GetRows_Count)
	REDIM iLength(AdRs_GetRows_Count)
	REDIM iMemberMemo(AdRs_GetRows_Count)
	REDIM iDefaultItem(AdRs_GetRows_Count)
	REDIM iFormType(AdRs_GetRows_Count)

	DIM tmpNum1, tmpNum2, iCount, iMemberValue(70), fieldCount, CONF_intAddItemCount
	tmpNum1 = 0 : tmpNum2 = 0 : iCount = 0 : fieldCount = 0 : CONF_intAddItemCount = 0

	FOR tmpFor = 0 TO AdRs_GetRows_Count

		IF AdRs_GetRows(4, tmpFor) = True AND AdRs_GetRows(5, tmpFor) = False THEN CONF_intAddItemCount	= CONF_intAddItemCount + 1

		iMemberItem(tmpFor)        = AdRs_GetRows(0, tmpFor)
		iMemberTitle(tmpFor)       = AdRs_GetRows(2, tmpFor)
		iMemberRequire(tmpFor)     = AdRs_GetRows(5, tmpFor)
		IF AdRs_GetRows(5, tmpFor) = True THEN tmpNum1 = tmpNum1 + 1 ELSE tmpNum2 = tmpNum2 + 1
		IF LEN(tmpNum1) = 1 THEN iMemberRequireNum(tmpFor) = "0" & tmpNum1 ELSE iMemberRequireNum(tmpFor) = tmpNum1
		IF LEN(tmpNum2) = 1 THEN iMemberOptionNum(tmpFor)  = "0" & tmpNum2 ELSE iMemberOptionNum(tmpFor)  = tmpNum2
		iMaxLength(tmpFor)         = AdRs_GetRows(9, tmpFor)
		iMemberMemo(tmpFor)        = AdRs_GetRows(3, tmpFor)
		iDefaultItem(tmpFor)       = AdRs_GetRows(8, tmpFor)
		iFormType(tmpFor)          = AdRs_GetRows(7, tmpFor)
		iLength(tmpFor)            = AdRs_GetRows(12, tmpFor)

		DIM AdRs_strHomeTelSplit, AdRs_strMobileSplit, AdRs_strCompTelSplit

		IF Action = "EDIT" OR Action = "RESULT" THEN
			IF iMemberRequire(tmpFor) = True THEN

				SELECT CASE iMemberItem(tmpFor)
				CASE "strLoginID"    : iMemberValue(fieldCount) = AdRs_strLoginID     : fieldCount = fieldCount + 1
				CASE "strLoginPwd"   : iMemberValue(fieldCount) = AdRs_strLoginPwd    : fieldCount = fieldCount + 1
				CASE "strLoginName"  : iMemberValue(fieldCount) = AdRs_strLoginName   : fieldCount = fieldCount + 1
				CASE "strEmail"      : iMemberValue(fieldCount) = AdRs_strEmail       : fieldCount = fieldCount + 1
				CASE "bitMailing"    : iMemberValue(fieldCount) = GetTrueFalse(AdRs_bitMailing) : fieldCount = fieldCount + 1
				CASE "strSSN"        :
					iMemberValue(fieldCount)     = LEFT(AdRs_strSSN, 6)                 : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = RIGHT(AdRs_strSSN, 7)                : fieldCount = fieldCount + 1
				CASE "strBirthday"   :
					iMemberValue(fieldCount)     = LEFT(AdRs_strBirthday, 4)            : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = MID(AdRs_strBirthday, 5, 2)          : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = MID(AdRs_strBirthday, 7, 2)          : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = RIGHT(AdRs_strBirthday, 1)           : fieldCount = fieldCount + 1
				CASE "strNick"       : iMemberValue(fieldCount) = AdRs_strNick        : fieldCount = fieldCount + 1
				CASE "strIcq"        : iMemberValue(fieldCount) = AdRs_strIcq         : fieldCount = fieldCount + 1
				CASE "strMsn"        : iMemberValue(fieldCount) = AdRs_strMsn         : fieldCount = fieldCount + 1
				CASE "strHomepage"   : iMemberValue(fieldCount) = AdRs_strHomepage    : fieldCount = fieldCount + 1
				CASE "strHomeAddr"   :
					iMemberValue(fieldCount)     = LEFT(AdRs_strHomePost, 3)            : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = RIGHT(AdRs_strHomePost, 3)           : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = AdRs_strHomeAddr1                    : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = AdRs_strHomeAddr2                    : fieldCount = fieldCount + 1
				CASE "strHomeTel"    :
					IF AdRs_strHomeTel <> "" AND ISNULL(AdRs_strHomeTel) = False THEN
						AdRs_strHomeTelSplit = SPLIT(AdRs_strHomeTel, "-")
						iMemberValue(fieldCount)     = AdRs_strHomeTelSplit(0)              : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = AdRs_strHomeTelSplit(1)              : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = AdRs_strHomeTelSplit(2)              : fieldCount = fieldCount + 1
					ELSE
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
					END IF
				CASE "strMobile"     :
					IF AdRs_strMobile <> "" AND ISNULL(AdRs_strMobile) = False THEN
						AdRs_strMobileSplit  = SPLIT(AdRs_strMobile, "-")
						iMemberValue(fieldCount)     = AdRs_strMobileSplit(0)               : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = AdRs_strMobileSplit(1)               : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = AdRs_strMobileSplit(2)               : fieldCount = fieldCount + 1
					ELSE
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
					END IF
				CASE "strCompAddr"   :
					iMemberValue(fieldCount)     = LEFT(AdRs_strCompPost, 3)            : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = RIGHT(AdRs_strCompPost, 3)           : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = AdRs_strCompAddr1                    : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = AdRs_strCompAddr2                    : fieldCount = fieldCount + 1
				CASE "strCompTel"    :
					IF AdRs_strCompTel <> "" AND ISNULL(AdRs_strCompTel) = False THEN
						AdRs_strCompTelSplit = SPLIT(AdRs_strCompTel, "-")
						iMemberValue(fieldCount)     = AdRs_strCompTelSplit(0)              : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = AdRs_strCompTelSplit(1)              : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = AdRs_strCompTelSplit(2)              : fieldCount = fieldCount + 1
					ELSE
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
					END IF
				CASE "strJob"        : iMemberValue(fieldCount) = AdRs_strJob         : fieldCount = fieldCount + 1
				CASE "strJobLevel"   : iMemberValue(fieldCount) = AdRs_strJobLevel    : fieldCount = fieldCount + 1
				CASE "strHobby"      : iMemberValue(fieldCount) = AdRs_strHobby       : fieldCount = fieldCount + 1
				CASE "strMarry"      :

					iMemberValue(fieldCount)     = RIGHT(AdRs_strMarry, 1)
					fieldCount = fieldCount + 1

					iMemberValue(fieldCount)     = LEFT(AdRs_strMarry, 4)
					IF iMemberValue(fieldCount) = "0000" THEN iMemberValue(fieldCount) = ""
					fieldCount = fieldCount + 1
					
					iMemberValue(fieldCount)     = MID(AdRs_strMarry, 5, 2)
					IF iMemberValue(fieldCount) = "00" THEN iMemberValue(fieldCount) = ""
					fieldCount = fieldCount + 1
					
					iMemberValue(fieldCount)     = MID(AdRs_strMarry, 7, 2)
					IF iMemberValue(fieldCount) = "00" THEN iMemberValue(fieldCount) = ""
					fieldCount = fieldCount + 1

				CASE "strJoinMemo"   : iMemberValue(fieldCount) = AdRs_strJoinMemo    : fieldCount = fieldCount + 1
				CASE "strPhotoFile"  : iMemberValue(fieldCount) = AdRs_strPhotoFile   : fieldCount = fieldCount + 1
				CASE "strNameFile"   : iMemberValue(fieldCount) = AdRs_strNameFile    : fieldCount = fieldCount + 1
				CASE "strMemo"       : iMemberValue(fieldCount) = AdRs_strMemo        : fieldCount = fieldCount + 1
				CASE "bitUserInfo"   : iMemberValue(fieldCount) = GetTrueFalse(AdRs_bitUserInfo) : fieldCount = fieldCount + 1
				CASE "strRecLoginID" : iMemberValue(fieldCount) = AdRs_strRecLoginID  : fieldCount = fieldCount + 1
				CASE "strUserSign"   : iMemberValue(fieldCount) = AdRs_strUserSign    : fieldCount = fieldCount + 1
				CASE "strMemberAdd1" : iMemberValue(fieldCount) = AdRs_strMemberAdd1  : fieldCount = fieldCount + 1
				CASE "strMemberAdd2" : iMemberValue(fieldCount) = AdRs_strMemberAdd2  : fieldCount = fieldCount + 1
				CASE "strMemberAdd3" : iMemberValue(fieldCount) = AdRs_strMemberAdd3  : fieldCount = fieldCount + 1
				CASE "strMemberAdd4" : iMemberValue(fieldCount) = AdRs_strMemberAdd4  : fieldCount = fieldCount + 1
				CASE "strMemberAdd5" : iMemberValue(fieldCount) = AdRs_strMemberAdd5  : fieldCount = fieldCount + 1
				CASE "strMemberAdd6" : iMemberValue(fieldCount) = AdRs_strMemberAdd6  : fieldCount = fieldCount + 1
				CASE "strMemberAdd7" : iMemberValue(fieldCount) = AdRs_strMemberAdd7  : fieldCount = fieldCount + 1
				CASE "strMemberAdd8" : iMemberValue(fieldCount) = AdRs_strMemberAdd8  : fieldCount = fieldCount + 1
				CASE "strMemberAdd9" : iMemberValue(fieldCount) = AdRs_strMemberAdd9  : fieldCount = fieldCount + 1
				CASE "strMemberAdd10": iMemberValue(fieldCount) = AdRs_strMemberAdd10 : fieldCount = fieldCount + 1
				END SELECT
			END IF
		END IF

	NEXT

	IF Action = "EDIT" OR Action = "RESULT" THEN
		FOR tmpFor = 0 TO AdRs_GetRows_Count
			IF iMemberRequire(tmpFor) = False THEN
				SELECT CASE iMemberItem(tmpFor)
				CASE "bitMailing"    : iMemberValue(fieldCount) = GetTrueFalse(AdRs_bitMailing) : fieldCount = fieldCount + 1
				CASE "strSSN"        :
					iMemberValue(fieldCount)     = LEFT(AdRs_strSSN, 6)                 : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = RIGHT(AdRs_strSSN, 7)                : fieldCount = fieldCount + 1
				CASE "strBirthday"   :
					iMemberValue(fieldCount)     = LEFT(AdRs_strBirthday, 4)            : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = MID(AdRs_strBirthday, 5, 2)          : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = MID(AdRs_strBirthday, 7, 2)          : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = RIGHT(AdRs_strBirthday, 1)           : fieldCount = fieldCount + 1
				CASE "strNick"       : iMemberValue(fieldCount) = AdRs_strNick        : fieldCount = fieldCount + 1
				CASE "strIcq"        : iMemberValue(fieldCount) = AdRs_strIcq         : fieldCount = fieldCount + 1
				CASE "strMsn"        : iMemberValue(fieldCount) = AdRs_strMsn         : fieldCount = fieldCount + 1
				CASE "strHomepage"   : iMemberValue(fieldCount) = AdRs_strHomepage    : fieldCount = fieldCount + 1
				CASE "strHomeAddr"   :
					iMemberValue(fieldCount)     = LEFT(AdRs_strHomePost, 3)            : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = RIGHT(AdRs_strHomePost, 3)           : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = AdRs_strHomeAddr1                    : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = AdRs_strHomeAddr2                    : fieldCount = fieldCount + 1
				CASE "strHomeTel"    :
					IF AdRs_strHomeTel <> "" AND ISNULL(AdRs_strHomeTel) = False THEN
						AdRs_strHomeTelSplit = SPLIT(AdRs_strHomeTel, "-")
						iMemberValue(fieldCount)     = AdRs_strHomeTelSplit(0)              : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = AdRs_strHomeTelSplit(1)              : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = AdRs_strHomeTelSplit(2)              : fieldCount = fieldCount + 1
					ELSE
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
					END IF
				CASE "strMobile"     :
					IF AdRs_strMobile <> "" AND ISNULL(AdRs_strMobile) = False THEN
						AdRs_strMobileSplit  = SPLIT(AdRs_strMobile, "-")
						iMemberValue(fieldCount)     = AdRs_strMobileSplit(0)               : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = AdRs_strMobileSplit(1)               : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = AdRs_strMobileSplit(2)               : fieldCount = fieldCount + 1
					ELSE
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
					END IF
				CASE "strCompAddr"   :
					iMemberValue(fieldCount)     = LEFT(AdRs_strCompPost, 3)            : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = RIGHT(AdRs_strCompPost, 3)           : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = AdRs_strCompAddr1                    : fieldCount = fieldCount + 1
					iMemberValue(fieldCount)     = AdRs_strCompAddr2                    : fieldCount = fieldCount + 1
				CASE "strCompTel"    :
					IF AdRs_strCompTel <> "" AND ISNULL(AdRs_strCompTel) = False THEN
						AdRs_strCompTelSplit = SPLIT(AdRs_strCompTel, "-")
						iMemberValue(fieldCount)     = AdRs_strCompTelSplit(0)              : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = AdRs_strCompTelSplit(1)              : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = AdRs_strCompTelSplit(2)              : fieldCount = fieldCount + 1
					ELSE
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
						iMemberValue(fieldCount)     = ""                                   : fieldCount = fieldCount + 1
					END IF
				CASE "strJob"        : iMemberValue(fieldCount) = AdRs_strJob         : fieldCount = fieldCount + 1
				CASE "strJobLevel"   : iMemberValue(fieldCount) = AdRs_strJobLevel    : fieldCount = fieldCount + 1
				CASE "strHobby"      : iMemberValue(fieldCount) = AdRs_strHobby       : fieldCount = fieldCount + 1
				CASE "strMarry"      :

					iMemberValue(fieldCount)     = RIGHT(AdRs_strMarry, 1)
					fieldCount = fieldCount + 1

					iMemberValue(fieldCount)     = LEFT(AdRs_strMarry, 4)
					IF iMemberValue(fieldCount) = "0000" THEN iMemberValue(fieldCount) = ""
					fieldCount = fieldCount + 1
					
					iMemberValue(fieldCount)     = MID(AdRs_strMarry, 5, 2)
					IF iMemberValue(fieldCount) = "00" THEN iMemberValue(fieldCount) = ""
					fieldCount = fieldCount + 1
					
					iMemberValue(fieldCount)     = MID(AdRs_strMarry, 7, 2)
					IF iMemberValue(fieldCount) = "00" THEN iMemberValue(fieldCount) = ""
					fieldCount = fieldCount + 1

				CASE "strJoinMemo"   : iMemberValue(fieldCount) = AdRs_strJoinMemo    : fieldCount = fieldCount + 1
				CASE "strPhotoFile"  : iMemberValue(fieldCount) = AdRs_strPhotoFile   : fieldCount = fieldCount + 1
				CASE "strNameFile"   : iMemberValue(fieldCount) = AdRs_strNameFile    : fieldCount = fieldCount + 1
				CASE "strMemo"       : iMemberValue(fieldCount) = AdRs_strMemo        : fieldCount = fieldCount + 1
				CASE "bitUserInfo"   : iMemberValue(fieldCount) = GetTrueFalse(AdRs_bitUserInfo) : fieldCount = fieldCount + 1
				CASE "strRecLoginID" : iMemberValue(fieldCount) = AdRs_strRecLoginID  : fieldCount = fieldCount + 1
				CASE "strUserSign"   : iMemberValue(fieldCount) = AdRs_strUserSign    : fieldCount = fieldCount + 1
				CASE "strMemberAdd1" : iMemberValue(fieldCount) = AdRs_strMemberAdd1  : fieldCount = fieldCount + 1
				CASE "strMemberAdd2" : iMemberValue(fieldCount) = AdRs_strMemberAdd2  : fieldCount = fieldCount + 1
				CASE "strMemberAdd3" : iMemberValue(fieldCount) = AdRs_strMemberAdd3  : fieldCount = fieldCount + 1
				CASE "strMemberAdd4" : iMemberValue(fieldCount) = AdRs_strMemberAdd4  : fieldCount = fieldCount + 1
				CASE "strMemberAdd5" : iMemberValue(fieldCount) = AdRs_strMemberAdd5  : fieldCount = fieldCount + 1
				CASE "strMemberAdd6" : iMemberValue(fieldCount) = AdRs_strMemberAdd6  : fieldCount = fieldCount + 1
				CASE "strMemberAdd7" : iMemberValue(fieldCount) = AdRs_strMemberAdd7  : fieldCount = fieldCount + 1
				CASE "strMemberAdd8" : iMemberValue(fieldCount) = AdRs_strMemberAdd8  : fieldCount = fieldCount + 1
				CASE "strMemberAdd9" : iMemberValue(fieldCount) = AdRs_strMemberAdd9  : fieldCount = fieldCount + 1
				CASE "strMemberAdd10": iMemberValue(fieldCount) = AdRs_strMemberAdd10 : fieldCount = fieldCount + 1
				END SELECT
			END IF
		NEXT
	END IF

	fieldCount = 0

	DIM strIdCheckLink, strRecIdCheckLink, strEmailCheckLink, strSsnCheckLink, strSecessionLink, strPointLink, strPhotoDelLink
	DIM strNameDelLink, strNickCheckLink

	strIdCheckLink    = "javascript:OnMemberJoinCheck('memberID');"
	strRecIdCheckLink = "javascript:OnMemberJoinCheck('memberRecID');"

	IF bitJoinEmailActivate = False THEN
	strEmailCheckLink = "javascript:OnMemberJoinCheck('memberEMAIL');"
	ELSE
	strEmailCheckLink = "javascript:OnMemberJoinCheck('memberACTIVATE');"
	END IF

	strSsnCheckLink   = "javascript:OnMemberJoinCheck('memberSSN');"
	strSecessionLink  = "javascript:OnMemberSecession();"
	strPointLink      = "javascript:OnMemberPoint();"
	strPhotoDelLink   = "javascript:OnMemberFileRemove('1');"
	strNameDelLink    = "javascript:OnMemberFileRemove('2');"
	strNickCheckLink  = "javascript:OnMemberJoinCheck('memberNick');"
%>
<input type="hidden" name="bitIdCheck" value="0">
<input type="hidden" name="bitEmailCheck" value="0">
<input type="hidden" name="bitSsnCheck" value="0">
<input type="hidden" name="bitRecIdCheck" value="0">
<input type="hidden" name="bitNickCheck" value="0">
<script language="javascript">
	var SET_Editor_FilePath = "Pds/Member/Sign/";
</script>
<script type="text/javascript" language="javascript" src="Editor/cheditor.js"></script>
<script language="javascript">

	var myeditor = new cheditor("myeditor");

	myeditor.config.editorHeight = '150px';
	myeditor.config.editorWidth = '100%';
	myeditor.config.includeHostname = false;
	myeditor.config.editorBgcolor = "";
	myeditor.inputForm = 'strUserSign';

</script>
<script language="javascript">
	var arApplForm = new Array(<%=AdRs_GetRows_Count%>);
	var iCountryCode = "";
<%
	FOR tmpFor = 0 TO AdRs_GetRows_Count
		RESPONSE.WRITE "	arApplForm[" & tmpFor & "] = new makeApplFormData('" & AdRs_GetRows(2, tmpFor) & "','" & AdRs_GetRows(0, tmpFor) & "','" & AdRs_GetRows(7, tmpFor) & "', '" & AdRs_GetRows(5, tmpFor) & "', '', " & AdRs_GetRows(10, tmpFor) & ");" & vbcrlf
	NEXT
%>
	var iNotEmail = new Array(<%=strJoinNotEmailCount%>);
<%
	IF strJoinNotEmailCount > 0 THEN
		FOR I = 0 TO strJoinNotEmailCount
			RESPONSE.WRITE "	iNotEmail[" & I & "] = """ & strJoinNotEmail(I) & """;" & vbcrlf
		NEXT
	END IF
%>

	var SET_MEMBER_MODE = "<%=Action%>";
	var SET_NAME_AVATAR_WIDTH = <%=intNameAvataWidth%>;
	var SET_NAME_AVATAR_HEIGHT = <%=intNameAvataHeight%>;
	var SET_EDIT_MAIL = "<%=AdRs_strEmail%>";
	var SET_EmailActivate = "<%=bitJoinEmailActivate%>";
	var SET_EDIT_NICK = "<%=AdRs_strNick%>"

	function makeApplFormData(szName, id, type, req, szDefaultValue, rdonly){
		this.name  = szName;
		this.field = id;
		this.type  = type;
		this.require = req;
		this.value = szDefaultValue;
		this.readonly = rdonly;
	}

	function OnSubmitAction(){

		for ( var i = 0; i < arApplForm.length; i++ ){
			if (arApplForm[i].require!="True") continue;

			switch (arApplForm[i].type){

			case "USERID":

				if (SET_MEMBER_MODE == "JOIN"){

					if (!isUserId(document.all[arApplForm[i].field].value)){
						alert(arApplForm[i].name + "는 영문과 숫자만 가능합니다. (4~12자)" );
						document.all[arApplForm[i].field].focus();
						return false;
					}
					if (document.all['bitIdCheck'].value != "1"){
						alert("아이디 중복체크를 실행해 주시기 바랍니다.");
						document.all[arApplForm[i].field].focus();
						return false;
					}
				}

				break;

			case "RECID":

				if (SET_MEMBER_MODE == "JOIN"){

					if (!isUserId(document.all[arApplForm[i].field].value)){
						alert(arApplForm[i].name + "는 영문과 숫자만 가능합니다. (4~12자)" );
						document.all[arApplForm[i].field].focus();
						return false;
					}
					if (document.all['bitRecIdCheck'].value != "1"){
						alert("추천인 아이디를 확인해 주시기 바랍니다.");
						document.all[arApplForm[i].field].focus();
						return false;
					}

				}

				break;

			case "PASSWORD":

				if (document.all[arApplForm[i].field][0].value.length < 4){
					alert(arApplForm[i].name + "는 4자 이상으로 설정해 주십시오.");
					document.all[arApplForm[i].field][0].focus();
					return false;
				}
				if (document.all[arApplForm[i].field][0].value != document.all[arApplForm[i].field][1].value){
					alert(arApplForm[i].name + "와 "+ arApplForm[i].name +" 확인이 일치하지 않습니다.");
					document.all[arApplForm[i].field][1].focus();
					return false;
				}

				break;

			case "SSN" :

				if (SET_MEMBER_MODE == "JOIN"){

					if (!isSSNNo(document.all[arApplForm[i].field][0].value + document.all[arApplForm[i].field][1].value)){
						alert(arApplForm[i].name + "을 올바르게 입력해 주시기 바립니다.");
						document.all[arApplForm[i].field][0].focus();
						return false;
					}

					if (document.all['bitSsnCheck'].value == "0"){
						alert("주민등록번호 중복체크를 실행해 주시기 바랍니다.");
						return false;
					}

				}

				break;

			case "NICK" :

				if (document.all[arApplForm[i].field].value == ""){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.");
					document.all[arApplForm[i].field].focus();
					return false;
				}

				if (SET_MEMBER_MODE == "JOIN"){
					if (document.all['bitNickCheck'].value == "0"){
						alert(arApplForm[i].name + " 중복체크를 실행해 주시기 바랍니다.");
						return false;
					}
				}

				if (SET_MEMBER_MODE == "EDIT"){

					if (SET_EDIT_NICK == document.all['strNick'].value){
						document.all['bitNickCheck'].value = "1";
					}else{
						if (document.all['bitNickCheck'].value != "1"){
							alert("닉네임이 변경되어 닉네임 중복체크를 실행해 주시기 바랍니다.");
							document.all['strNick'].focus();
							return false;
						}
					}

				}

				break;

			case "EMAIL" :

				if (!isEmailCheck(document.all[arApplForm[i].field].value)){
					alert(arApplForm[i].name + "을 올바르게 입력해 주시기 바립니다.");
					document.all[arApplForm[i].field].focus();
					return false;
				}

				if (SET_MEMBER_MODE == "JOIN"){
					if (document.all['bitEmailCheck'].value == "0"){
						alert("E-MAIL 중복체크를 실행해 주시기 바랍니다.");
						return false;
					}
				}

				break;

			case "BIRTHDAY" :

				if (document.all[arApplForm[i].field][0].value.length < 4){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.\n\n4자리로 입력해 주시기 바랍니다.");
					document.all[arApplForm[i].field][0].focus();
					return false;
				}

				if (document.all[arApplForm[i].field][1].value.length < 2){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.\n\n2자리로 입력해 주시기 바랍니다.");
					document.all[arApplForm[i].field][1].focus();
					return false;
				}

				if (document.all[arApplForm[i].field][2].value.length < 2){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.\n\n2자리로 입력해 주시기 바랍니다.");
					document.all[arApplForm[i].field][2].focus();
					return false;
				}

				if (document.all[arApplForm[i].field][3].checked == false && document.all[arApplForm[i].field][4].checked == false){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.");
					document.all[arApplForm[i].field][3].focus();
					return false;
				}

				break;

			case "ADDR" :

				var strPost1 = document.all[arApplForm[i].field][0];
				var strPost2 = document.all[arApplForm[i].field][1];
				var strAddr1 = document.all[arApplForm[i].field][2];
				var strAddr2 = document.all[arApplForm[i].field][3];
				if (strPost1.value.length < 1){
					alert(arApplForm[i].name + "을 검색 버튼을 이용해서 입력해 주시기 바랍니다.");
					strAddr2.focus();
					return false;
				}

				if (strAddr2.value.length < 1){
					alert("나머지 " + arApplForm[i].name + "를 입력해 주시기 바랍니다.");
					strAddr2.focus();
					return false;
				}

				break;

			case "TEL" :

				if (document.all[arApplForm[i].field][0].value.length < 1){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.");
					document.all[arApplForm[i].field][0].focus();
					return false;	
				}

				if (document.all[arApplForm[i].field][1].value.length < 1){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.");
					document.all[arApplForm[i].field][1].focus();
					return false;	
				}

				if (document.all[arApplForm[i].field][2].value.length < 1){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.");
					document.all[arApplForm[i].field][2].focus();
					return false;	
				}

				break;

			case "MOBILE" :

				if (document.all[arApplForm[i].field][0].value.length < 1){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.");
					document.all[arApplForm[i].field][0].focus();
					return false;	
				}

				if (document.all[arApplForm[i].field][1].value.length < 1){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.");
					document.all[arApplForm[i].field][1].focus();
					return false;	
				}

				if (document.all[arApplForm[i].field][2].value.length < 1){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.");
					document.all[arApplForm[i].field][2].focus();
					return false;	
				}

				break;

			case "RADIO":

				var isChecked = false;
				for (var e=0; e < document.all[arApplForm[i].field].length; e++ ){
					if (document.all[arApplForm[i].field][e].checked == true){
						isChecked = true;
					}
				}

				if (!isChecked){
					alert(arApplForm[i].name + "은(는) 필수항목으로 한가지를 꼭 선택하셔야합니다.");
					document.all[arApplForm[i].field][0].focus();
					return false;
				}

				break;

			case "BIT" :

				if (document.all[arApplForm[i].field][0].checked == false && document.all[arApplForm[i].field][1].checked == false){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.");
					document.all[arApplForm[i].field][0].focus();
					return false;
				}

				break;

			case "TEXTAREA":

				if (document.all[arApplForm[i].field].value.length < 1){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.");
					document.all[arApplForm[i].field].focus();
					return false;
				}

				break;

			case "TEXT" :

				if (document.all[arApplForm[i].field].value.length < 1){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.");
					document.all[arApplForm[i].field].focus();
					return false;
				}

				if (arApplForm[i].field == "strLoginName"){
					if (!CheckHangulEng(document.all[arApplForm[i].field].value)){
						alert(arApplForm[i].name + "은(는) 한글과 영문만 가능합니다.");
						document.all[arApplForm[i].field].focus();
						return false;
					}
				}

				break;

			case "FILE" :

				if (document.all[arApplForm[i].field].value.length < 1){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.");
					document.all[arApplForm[i].field].focus();
					return false;
				}

				break;

			case "AVATA" :

				if (document.all[arApplForm[i].field].value.length < 1){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.");
					document.all[arApplForm[i].field].focus();
					return false;
				}

				break;

			case "SELECT" :

				var nIndex = document.all[arApplForm[i].field].selectedIndex;
				if (document.all[arApplForm[i].field].options[nIndex].value == ""){
					alert(arApplForm[i].name + "은(는) 필수항목으로 한가지를 꼭 선택하셔야합니다.");
					document.all[arApplForm[i].field].focus();
					return false;
				}

				break;
				
			case "CHECKBOX" :

				var isChecked = false;
				for (var e=0; e < document.all[arApplForm[i].field].length; e++ ){
					if (document.all[arApplForm[i].field][e].checked == true){
						isChecked = true;
					}
				}

				if (!isChecked){
					alert(arApplForm[i].name + "은(는) 필수항목으로 한가지를 꼭 선택하셔야합니다.");
					document.all[arApplForm[i].field][0].focus();
					return false;
				}

				break;

			case "MARRY" :

				if (document.all[arApplForm[i].field][0].checked == false && document.all[arApplForm[i].field][1].checked == false){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.");
					document.all[arApplForm[i].field][0].focus();
					return false;
				}

				if (document.all[arApplForm[i].field][1].checked == true){

					if (document.all[arApplForm[i].field][2].value.length < 4){
						alert(arApplForm[i].name + "은(는) 필수항목 입니다.\n\n4자리로 입력해 주시기 바랍니다.");
						document.all[arApplForm[i].field][2].focus();
						return false;
					}
	
					if (document.all[arApplForm[i].field][3].value.length < 2){
						alert(arApplForm[i].name + "은(는) 필수항목 입니다.\n\n2자리로 입력해 주시기 바랍니다.");
						document.all[arApplForm[i].field][3].focus();
						return false;
					}
	
					if (document.all[arApplForm[i].field][4].value.length < 2){
						alert(arApplForm[i].name + "은(는) 필수항목 입니다.\n\n2자리로 입력해 주시기 바랍니다.");
						document.all[arApplForm[i].field][4].focus();
						return false;
					}

				}

				break;

			case "SIGN" :

				document.getElementById("strUserSign").value = myeditor.outputBodyHTML();

				if (document.getElementById("strUserSign").value == ""){
					alert(arApplForm[i].name + "은(는) 필수항목 입니다.");
					myeditor.editArea.focus();
					return false;
				}

				break;

			}
		}

		if (document.all['strBirthday']!= null){
			document.all['strBirthdayR'].value = document.all['strBirthday'][0].value + document.all['strBirthday'][1].value + document.all['strBirthday'][2].value;
			if (document.all['strBirthday'][3].checked == true){
				document.all['strBirthdayR'].value = document.all['strBirthdayR'].value + "0";
			}

			if (document.all['strBirthday'][4].checked == true){
				document.all['strBirthdayR'].value = document.all['strBirthdayR'].value + "1";
			}
		}

		if (document.all['strMarry']!= null){
			document.all['strMarryR'].value = document.all['strMarry'][2].value + document.all['strMarry'][3].value + document.all['strMarry'][4].value;
			if (document.all['strMarry'][0].checked == true){
				document.all['strMarryR'].value = document.all['strMarryR'].value + "0";
			}

			if (document.all['strMarry'][1].checked == true){
				document.all['strMarryR'].value = document.all['strMarryR'].value + "1";
			}
		}

		if (document.all['strNameFile']!= null){
			if (document.all['strNameFile'].value!= ""){
				var obj = document.all['strNameFile'];
				var objImg = document.all["imgAvatar"];
				objImg.src = obj.value;
		
				OnLoadAvatar(obj);
		
				var width = parseInt(objImg.width);
				var height = parseInt(objImg.height);
		
				if(width > SET_NAME_AVATAR_WIDTH) {
					alert("이름 이미지의 가로크기는 " + SET_NAME_AVATAR_WIDTH + " 이하이어야 합니다.");
					return false;
				} else if(height > SET_NAME_AVATAR_HEIGHT) {
					alert("이름 이미지의 세로크기는 " + SET_NAME_AVATAR_HEIGHT + " 이하이어야 합니다.");
					return false;
				}
			}
		}

		if (SET_MEMBER_MODE == "EDIT"){
			if (SET_EmailActivate == "True"){
				document.all['bitEmailCheck'].value = "1";
			}else{
				if (SET_EDIT_MAIL == document.all['strEmail'].value){
					document.all['bitEmailCheck'].value = "1";
				}else{
					if (document.all['bitEmailCheck'].value != "1"){
						alert("메일주소가 변경되어 메일주소의 중복체크를 실행해 주시기 바랍니다.");
						document.all['strEmail'].focus();
						return false;
					}
				}
			}
		}

		if (SET_MEMBER_MODE == "JOIN"){
			str = document.all['strCaptchaText'];
			if (str.value == ""){
				alert("중복가입 방지를 위한 문자를 입력해 주시기 바랍니다.");
				str.focus();return false;
			}
		}

		document.theForm.action = "MemberJoin.asp?Action=" + SET_MEMBER_MODE + "&bitIdCheck=" + document.all['bitIdCheck'].value + "&bitEmailCheck=" + document.all['bitEmailCheck'].value + "&bitSsnCheck=" + document.all['bitSsnCheck'].value + "&bitRecIdCheck=" + document.all['bitRecIdCheck'].value;

	}

	function OnMemberJoinCheck(str){

		switch (str){
			case "memberID" :
				var str = document.all['strLoginID'];
				if (!isUserId(str.value)){alert("회원아이디는 영문과 숫자만 가능합니다. (4~12자)" );str.focus();return;}

				var arr = showModalDialog('Library/memberCheck.asp?strInput=' + document.all['strLoginID'].value + '&Action=0', 'memberID', 'dialogWidth:300px; dialogHeight: 300px; resizable: no; help: no; status: no; scroll: no;');
				document.all['bitIdCheck'].value = arr;
				break;

			case "memberRecID" :

				var str = document.all['strRecLoginID'];
				if (!isUserId(str.value)){alert("회원아이디는 영문과 숫자만 가능합니다. (4~12자)" );str.focus();return;}
			
				var arr = showModalDialog('Library/memberCheck.asp?strInput=' + document.all['strRecLoginID'].value + '&Action=1', 'memberID', 'dialogWidth:300px; dialogHeight: 300px; resizable: no; help: no; status: no; scroll: no;');
				document.all['bitRecIdCheck'].value = arr;
				break;

			case "memberEMAIL" :
				var str = document.all['strEmail'];
				if (!isEmailCheck(str.value)){alert("E-MAIL을 올바르게 입력해 주시기 바랍니다." );str.focus();return;}
				var arr = showModalDialog('Library/memberCheck.asp?strInput=' + document.all['strEmail'].value + '&Action=2', 'memberEMAIL', 'dialogWidth:300px; dialogHeight: 300px; resizable: no; help: no; status: no; scroll: no;');
				document.all['bitEmailCheck'].value = arr;
				break;
			case "memberACTIVATE" :

				if (document.all['strLoginID'].value == ""){
					alert("회원 아이디를 먼저 등록해 주시기 바랍니다.");
					document.all['strLoginID'].focus();
					return;
				}

				if (document.all['strLoginName'].value == ""){
					alert("회원 이름을 먼저 등록해 주시기 바랍니다.");
					document.all['strLoginName'].focus();
					return;
				}

				var str = document.all['strEmail'];
				if (!isEmailCheck(str.value)){alert("E-MAIL을 올바르게 입력해 주시기 바랍니다." );str.focus();return;}

				var arr = showModalDialog('Library/memberCheck.asp?mode=' + SET_MEMBER_MODE + '&strLoginID=' + document.all['strLoginID'].value + '&strLoginName=' + document.all['strLoginName'].value + '&strInput=' + document.all['strEmail'].value + '&Action=4', 'memberEMAIL', 'dialogWidth:300px; dialogHeight: 300px; resizable: no; help: no; status: no; scroll: no;');
				document.all['bitEmailCheck'].value = arr;
				break;

			case "memberSSN" :
				if (!isSSNNo(document.all['strSSN'][0].value + document.all['strSSN'][1].value)){alert("주민등록번호를 올바르게 입력해 주시기 바랍니다." );document.all['strSSN'][0].focus();return;}

				var arr = showModalDialog('Library/memberCheck.asp?strInput=' + document.all['strSSN'][0].value + document.all['strSSN'][1].value + '&Action=3', 'memberSSN', 'dialogWidth:300px; dialogHeight: 300px; resizable: no; help: no; status: no; scroll: no;');
				document.all['bitSsnCheck'].value = arr;
				break;

			case "memberNick" :

				if (document.all['strNick'].value == ""){
					alert("닉네임을 입력해 주시기 바랍니다.");
					document.all['strNick'].focus();
					return;
				}

				var arr = showModalDialog('Library/memberCheck.asp?strLoginID=' + document.all['strLoginID'].value + '&mode=' + SET_MEMBER_MODE + '&strInput=' + document.all['strNick'].value + '&Action=5', 'memberNick', 'dialogWidth:300px; dialogHeight: 300px; resizable: no; help: no; status: no; scroll: no;');
				document.all['bitNickCheck'].value = arr;

			break;
		}
	}

	function CheckHangulEng(str){ 
		strarr = new Array(str.length); 
		schar = new Array('/','.','>','<',',','?','}','{',' ','\\','|','(',')','+','=','!','@','#','$','%','^','&','*','`'); 
		flag = true; 

		for (i=0; i<str.length; i++) { 
			for (j=0; j<schar.length; j++) { 
				if (schar[j] ==str.charAt(i)) { 
					flag = false; 
				} 
			} 
			
			strarr[i] = str.charAt(i) 
			if ((strarr[i] >=0) && (strarr[i] <=9)) { 
				flag = false;
			} else if ((escape(strarr[i]) > '%60') && (escape(strarr[i]) <'%80') ) { 
				flag = false;
			} 
		} 
		if (flag) { 
			return true; 
    } else { 
			return false; 
		} 
	} 
</script>