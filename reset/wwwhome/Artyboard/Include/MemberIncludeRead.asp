<%
	DIM AdRs_strLoginID, AdRs_strGroup, AdRs_strLoginPwd, AdRs_strLoginName, AdRs_strEmail, AdRs_bitMailing
	DIM AdRs_strSSN, AdRs_strBirthday, AdRs_strNick, AdRs_strIcq, AdRs_strMsn, AdRs_strHomepage, AdRs_strHomePost
	DIM AdRs_strHomeAddr1, AdRs_strHomeAddr2, AdRs_strHomeTel, AdRs_strMobile, AdRs_strCompPost, AdRs_strCompAddr1
	DIM AdRs_strCompAddr2, AdRs_strCompTel, AdRs_strJob, AdRs_strJobLevel, AdRs_strHobby, AdRs_strMarry
	DIM AdRs_strJoinMemo, AdRs_strPhotoFile, AdRs_strNameFile, AdRs_strMemo, AdRs_bitUserInfo, AdRs_strRecLoginID
	DIM AdRs_strUserSign, AdRs_strMemberAdd1, AdRs_strMemberAdd2, AdRs_strMemberAdd3, AdRs_strMemberAdd4, AdRs_strMemberAdd5
	DIM AdRs_strMemberAdd6, AdRs_strMemberAdd7, AdRs_strMemberAdd8, AdRs_strMemberAdd9, AdRs_strMemberAdd10
	DIM AdRs_strOpenMemo, AdRs_strOpenName, AdRs_strOpenGroup, AdRs_strOpenEmail, AdRs_strOpenSex, AdRs_strOpenAge
	DIM AdRs_strOpenBirthday, AdRs_strOpenTel, AdRs_strOpenMobile, AdRs_strOpenAddr, AdRs_strOpenHomp, AdRs_strOpenJob
	DIM AdRs_strOpenHobby, AdRs_strOpenMarry, AdRs_bitAuth, AdRs_intVisit, AdRs_intPoint, AdRs_dateSignDate, AdRs_bitSecession
	DIM AdRs_dateSecessionDate, AdRs_dateRegDate, AdRs_strGroupName, AdRs_strSecessionMemo, AdRs_intBoardCount
	DIM AdRs_intCommentCount, AdRs_intVote

	AdRs_strLoginID        = RS("strLoginID")
	AdRs_strGroup          = RS("strGroup")
	AdRs_strGroupName      = RS("strGroupName")
	AdRs_strLoginPwd       = RS("strLoginPwd")
	AdRs_strLoginName      = RS("strLoginName")
	AdRs_strEmail          = RS("strEmail")
	AdRs_bitMailing        = RS("bitMailing")
	AdRs_strSSN            = RS("strSSN")
	AdRs_strBirthday       = RS("strBirthday")
	AdRs_strNick           = RS("strNick")
	AdRs_strIcq            = RS("strIcq")
	AdRs_strMsn            = RS("strMsn")
	AdRs_strHomepage       = RS("strHomepage")
	AdRs_strHomePost       = RS("strHomePost")
	AdRs_strHomeAddr1      = RS("strHomeAddr1")
	AdRs_strHomeAddr2      = RS("strHomeAddr2")
	AdRs_strHomeTel        = RS("strHomeTel")
	AdRs_strMobile         = RS("strMobile")
	AdRs_strCompPost       = RS("strCompPost")
	AdRs_strCompAddr1      = RS("strCompAddr1")
	AdRs_strCompAddr2      = RS("strCompAddr2")
	AdRs_strCompTel        = RS("strCompTel")
	AdRs_strJob            = RS("strJob")
	AdRs_strJobLevel       = RS("strJobLevel")
	AdRs_strHobby          = RS("strHobby")
	AdRs_strMarry          = RS("strMarry")
	AdRs_strJoinMemo       = RS("strJoinMemo")
	AdRs_strPhotoFile      = RS("strPhotoFile")
	AdRs_strNameFile       = RS("strNameFile")
	AdRs_strMemo           = RS("strMemo")
	AdRs_bitUserInfo       = RS("bitUserInfo")
	AdRs_strRecLoginID     = RS("strRecLoginID")
	AdRs_strUserSign       = RS("strUserSign")
	AdRs_strMemberAdd1     = RS("strMemberAdd1")
	AdRs_strMemberAdd2     = RS("strMemberAdd2")
	AdRs_strMemberAdd3     = RS("strMemberAdd3")
	AdRs_strMemberAdd4     = RS("strMemberAdd4")
	AdRs_strMemberAdd5     = RS("strMemberAdd5")
	AdRs_strMemberAdd6     = RS("strMemberAdd6")
	AdRs_strMemberAdd7     = RS("strMemberAdd7")
	AdRs_strMemberAdd8     = RS("strMemberAdd8")
	AdRs_strMemberAdd9     = RS("strMemberAdd9")
	AdRs_strMemberAdd10    = RS("strMemberAdd10")
	AdRs_strOpenMemo       = RS("strOpenMemo")
	AdRs_strOpenName       = RS("strOpenName")
	AdRs_strOpenGroup      = RS("strOpenGroup")
	AdRs_strOpenEmail      = RS("strOpenEmail")
	AdRs_strOpenSex        = RS("strOpenSex")
	AdRs_strOpenAge        = RS("strOpenAge")
	AdRs_strOpenBirthday   = RS("strOpenBirthday")
	AdRs_strOpenTel        = RS("strOpenTel")
	AdRs_strOpenMobile     = RS("strOpenMobile")
	AdRs_strOpenAddr       = RS("strOpenAddr")
	AdRs_strOpenHomp       = RS("strOpenHomp")
	AdRs_strOpenJob        = RS("strOpenJob")
	AdRs_strOpenHobby      = RS("strOpenHobby")
	AdRs_strOpenMarry      = RS("strOpenMarry")
	AdRs_bitAuth           = RS("bitAuth")
	AdRs_intVisit          = RS("intVisit")
	AdRs_intPoint          = RS("intPoint")
	IF AdRs_intPoint = "" OR ISNULL(AdRs_intPoint) = True THEN AdRs_intPoint = 0
	AdRs_dateSignDate      = RS("dateSignDate")
	AdRs_bitSecession      = RS("bitSecession")
	AdRs_dateSecessionDate = RS("dateSecessionDate")
	AdRs_dateRegDate       = RS("dateRegDate")
	AdRs_strSecessionMemo  = RS("strSecessionMemo")
	AdRs_intBoardCount = RS("intBoardCount")
	AdRs_intCommentCount = RS("intCommentCount")
	AdRs_intVote = RS("intVote")
%>