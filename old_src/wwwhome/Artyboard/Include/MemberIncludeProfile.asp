<!-- #include file = "MemberInclude.asp" -->
<%
	DIM strLoginID, strBoardID
	strLoginID = GetReplaceInput(REQUEST.QueryString("strLoginID"), "S")
	strBoardID = GetReplaceInput(REQUEST.QueryString("strBoardID"), "S")

	DIM strSkin, strSkinGroup, skinPath, bitUseGroup, bitUseVisit, bitUsePoint, bitUseSignDate, bitUseRegDate

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_CONFIG_PROFILE] ")

	strSkin        = RS("strSkin")
	strSkinGroup   = RS("strSkinGroup")
	skinPath       = GetSkinPath(strSkin, 1, strSkinGroup, 1) & "/"
	bitUseGroup    = RS("bitUseGroup")
	bitUseVisit    = RS("bitUseVisit")
	bitUsePoint    = RS("bitUsePoint")
	bitUseSignDate = RS("bitUseSignDate")
	bitUseRegDate  = RS("bitUseRegDate")

	DIM bitMemberInfoLevel
	bitMemberInfoLevel = True

	SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_READ] '" & strLoginID & "' ")

	IF RS.EOF THEN
		RESPONSE.WRITE ExecJavaAlert("회원정보를 찾을 수 없습니다.", 0)
		RESPONSE.End()
	END IF
%>
<!-- #include file = "MemberIncludeRead.asp" -->
<%
	IF bitMemberInfo = False THEN
		IF SESSION("strLoginiD") = "" THEN
			bitMemberInfoLevel = False
		ELSE
			IF SESSION("strLoginID") = AdRs_strLoginID THEN
				bitMemberInfoLevel = True
			ELSE
				SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_BOARD_CONFIG_DEFAULT] '" & strBoardID & "', '" & SESSION("strLoginID") & "' ")
				IF GetAdminCheck(SESSION("strLoginID"), RS("strAdmin"), SESSION("strAdmin")) = True THEN
					bitMemberInfoLevel = True
				ELSE
					IF AdRs_bitUserInfo = True THEN
						SET RS = DBCON.EXECUTE("EXEC [MPLUS_GET_MEMBER_LOGIN] '" & SESSION("strLoginID") & "' ")
						IF INT(RS("intLevel")) > INT(intMemberInfoLevel) OR INT(RS("intLevel")) = INT(intMemberInfoLevel) THEN bitMemberInfoLevel = True ELSE bitMemberInfoLevel = False
					ELSE
						bitMemberInfoLevel = False
					END IF
				END IF
			END IF
		END IF
	ELSE
		bitMemberInfoLevel = True
	END IF

	IF bitMemberInfoLevel = False THEN
		IF strErrorUrl <> "" AND ISNULL(strErrorUrl) = False THEN
			RESPONSE.WRITE ExecFormSubmit(strErrorMsg, strErrorUrl, strErrorUrlTarget)
			RESPONSE.End()
		ELSE
			RESPONSE.WRITE ExecJavaAlert(strErrorMsg, 1)
			RESPONSE.End()
		END IF
	END IF

	DIM iCount, iMemberValue(70), fieldCount, iListCount, tmpNum1, tmpNum2
	tmpNum1 = 0 : tmpNum2 = 0 : iCount = 0 : fieldCount = 0

	SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.COMMAND")
	SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RECORDSET")

	WITH AdCmd
			
		.ActiveConnection	= DbConnect
		.CommandText		  = "MPLUS_GET_MEMBER_CONFIG_JOIN_ITEM"
		.CommandTimeOut		= 10
		.CommandType		  = adCmdStoredProc
		.Parameters.Append	.CreateParameter("bitAdmin",	adVarChar,	adParamInput,	1,	"")
		.Parameters.Append	.CreateParameter("bitUseProfile",	adVarChar,	adParamInput,	1,	"1")

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
	REDIM iFormType(AdRs_GetRows_Count)
	REDIM ibitUseProfile(AdRs_GetRows_Count)

	FOR tmpFor = 0 TO AdRs_GetRows_Count

		iMemberItem(tmpFor)        = AdRs_GetRows(0, tmpFor)
		iMemberTitle(tmpFor)       = AdRs_GetRows(2, tmpFor)
		iMemberRequire(tmpFor)     = AdRs_GetRows(5, tmpFor)
		IF AdRs_GetRows(5, tmpFor) = True THEN tmpNum1 = tmpNum1 + 1 ELSE tmpNum2 = tmpNum2 + 1
		IF LEN(tmpNum1) = 1 THEN iMemberRequireNum(tmpFor) = "0" & tmpNum1 ELSE iMemberRequireNum(tmpFor) = tmpNum1
		IF LEN(tmpNum2) = 1 THEN iMemberOptionNum(tmpFor)  = "0" & tmpNum2 ELSE iMemberOptionNum(tmpFor)  = tmpNum2
		iFormType(tmpFor)          = AdRs_GetRows(7, tmpFor)
		ibitUseProfile(tmpFor)     = AdRs_GetRows(13,tmpFor)

		DIM AdRs_strHomeTelSplit, AdRs_strMobileSplit, AdRs_strCompTelSplit

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
				iMemberValue(fieldCount)     = RIGHT(AdRs_strMarry, 1)              : fieldCount = fieldCount + 1
				iMemberValue(fieldCount)     = LEFT(AdRs_strMarry, 4)               : fieldCount = fieldCount + 1
				iMemberValue(fieldCount)     = MID(AdRs_strMarry, 5, 2)             : fieldCount = fieldCount + 1
				iMemberValue(fieldCount)     = MID(AdRs_strMarry, 7, 2)             : fieldCount = fieldCount + 1
			CASE "strJoinMemo"   : iMemberValue(fieldCount) = AdRs_strJoinMemo    : fieldCount = fieldCount + 1
			CASE "strPhotoFile"
				IF AdRs_strPhotoFile <> "" AND ISNULL(AdRs_strPhotoFile) = False THEN iMemberValue(fieldCount) = "<img src=/Pds/Member/Photo/" & AdRs_strPhotoFile & " border=0>" ELSE iMemberValue(fieldCount) = ""
				fieldCount = fieldCount + 1
			CASE "strNameFile"
				IF AdRs_strNameFile <> "" AND ISNULL(AdRs_strNameFile) = False THEN iMemberValue(fieldCount) = "<img src=/Pds/Member/Name/" & AdRs_strNameFile & " border=0>" ELSE iMemberValue(fieldCount) = ""
				fieldCount = fieldCount + 1
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

	FOR tmpFor = 0 TO AdRs_GetRows_Count
		IF iMemberRequire(tmpFor) = False THEN
			SELECT CASE iMemberItem(tmpFor)
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
				iMemberValue(fieldCount)     = RIGHT(AdRs_strMarry, 1)              : fieldCount = fieldCount + 1
				iMemberValue(fieldCount)     = LEFT(AdRs_strMarry, 4)               : fieldCount = fieldCount + 1
				iMemberValue(fieldCount)     = MID(AdRs_strMarry, 5, 2)             : fieldCount = fieldCount + 1
				iMemberValue(fieldCount)     = MID(AdRs_strMarry, 7, 2)             : fieldCount = fieldCount + 1
			CASE "strJoinMemo"   : iMemberValue(fieldCount) = AdRs_strJoinMemo    : fieldCount = fieldCount + 1
			CASE "strPhotoFile"
				IF AdRs_strPhotoFile <> "" AND ISNULL(AdRs_strPhotoFile) = False THEN iMemberValue(fieldCount) = "<img src=/Pds/Member/Photo/" & AdRs_strPhotoFile & " border=0>" ELSE iMemberValue(fieldCount) = ""
				fieldCount = fieldCount + 1
			CASE "strNameFile"
				IF AdRs_strNameFile <> "" AND ISNULL(AdRs_strNameFile) = False THEN iMemberValue(fieldCount) = "<img src=/Pds/Member/Name/" & AdRs_strNameFile & " border=0>" ELSE iMemberValue(fieldCount) = ""
				fieldCount = fieldCount + 1
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

	fieldCount = 0

	SET RS = NOTHING : DBCON.CLOSE
%>