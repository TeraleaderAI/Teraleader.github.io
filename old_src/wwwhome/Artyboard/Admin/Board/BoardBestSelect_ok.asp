<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "../../Dbconnect/DbConnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 2
	isAdminPopup    = True
	strAdminPrevUrl = "Board/BoardBestList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM intPage, bitNotice, strSelectBoardID, intPageSize, strSearchCategory, strSearchWord, I, intSeqTemp
	DIM strSelectGroup, bitMemoInfo, strFontColor, bitBold, intStep

	WITH REQUEST

		intPage           = .QueryString("intPage")
		bitNotice         = GetReplaceInput(.FORM("bitNotice"),"")
		strSelectBoardID  = GetReplaceInput(.FORM("strSelectBoardID"),"")
		intPageSize       = GetReplaceInput(.FORM("intPageSize"),"")
		strSearchCategory = GetReplaceInput(.FORM("strSearchCategory"),"")
		strSearchWord     = GetReplaceInput(.FORM("strSearchWord"), "")
		strSelectGroup    = GetReplaceInput(.FORM("strSelectGroup"),"")
		bitMemoInfo       = GetReplaceInput(.FORM("bitMemoInfo"),"")
		strFontColor      = GetReplaceInput(.FORM("strFontColor"),"")
		bitBold           = GetReplaceInput(.FORM("bitBold"),"")

	END WITH

	FOR I = 1 TO REQUEST.FORM("intSeq").COUNT
		intSeqTemp = SPLIT(REQUEST.FORM("intSeq")(I), "|")
		SET RS = DBCON.EXECUTE("SELECT [intNum] FROM [MPLUS_BOARD_NOTICE_LIST] WHERE [strCode] = '" & strSelectGroup & "' AND [strBoardID] = '" & intSeqTemp(1) & "' AND [intSeq] = '" & intSeqTemp(0) & "' ")
		IF RS.EOF THEN
			SET RS = DBCON.EXECUTE("SELECT [intStep] FROM [MPLUS_BOARD_NOTICE_LIST] WHERE [strCode] = '" & strSelectGroup & "' ORDER BY [intStep] DESC ")
			IF RS.EOF THEN intStep = 1 ELSE intStep = RS("intStep") + 1
			DBCON.EXECUTE("INSERT INTO [MPLUS_BOARD_NOTICE_LIST] ([strCode], [strBoardID], [intSeq], [intStep], [bitUsage], [bitMemoInfo], [strFontColor], [bitBold]) VALUES ('" & strSelectGroup & "', '" & intSeqTemp(1) & "', '" & intSeqTemp(0) & "', '" & intStep & "', '1', '" & bitMemoInfo & "', '" & strFontColor & "', '" & bitBold & "') ")
		END IF
	NEXT

	DIM strHidden
	strHidden = "<input type=hidden name=bitNotice value=" & bitNotice & "><input type=hidden name=strSelectBoardID value=" & strSelectBoardID & "><input type=hidden name=intPageSize value=" & intPageSize & "><input type=hidden name=strSearchCategory value=" & strSearchCategory & "><input type=hidden name=strSearchWord value=""" & strSearchWord & """>"

	RESPONSE.WRITE ExecFormSubmitHidden("게시글 등록이 완료되었습니다.", strHidden, "BoardBestSelect.asp", "")
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>