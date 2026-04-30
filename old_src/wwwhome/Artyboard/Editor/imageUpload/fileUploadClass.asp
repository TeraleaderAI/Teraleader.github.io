<%
'----------------------------------------------------------------------
' 1. attach 디렉토리는 웹에서 파일을 쓰고, 읽을 수 있도록 퍼미션을 조정하여 주십시오.
' 2. 이미지 업로드는 "\program Files\Common Files\System\ado\msado15.dll" 를 이용합니다.
' 	 만약 위 모듈이 레지스트리에 등록되어 있지 않을 경우, regsvr32 명령을 이용하여 등록하여 주십시오.
'
' 보기: regsvr32 "c:\program files\common files\system\ado\msado15.dll"

' ASP의 경우 기본 업로드 크기가 200K로 기본 설정이 되어있습니다.
' 아래 과정을 통해 원하는 파일 크기로 재설정할 수 있습니다.

' 1. IIS 서비스를 멈춤니다.
' 2. 'c:\windows\system32\inetsrv\Metabase.XML' 파일을 간단한 에디터(노트패드와 같은) 열어 
'	 AspMaxRequestEntityAllowed="204800"으로 설정되어 있는 값을 원하는는 크기로 수정합니다.
' 3. IIS를 시작합니다.
'----------------------------------------------------------------------

const DEFAULT_CHUNK_SIZE = 200000

Class fileUploadClass
	Public UploadedFiles
	Public FormElements

	Private VarArrayBinRequest
	Private StreamRequest
	Private uploadedYet
	Private internalChunkSize

	Private Sub Class_Initialize()
		Set UploadedFiles 	= Server.CreateObject("Scripting.Dictionary")
		Set FormElements 	= Server.CreateObject("Scripting.Dictionary")
		Set StreamRequest 	= Server.CreateObject("ADODB.Stream")
		
		StreamRequest.Type 	= 2
		StreamRequest.Open
		uploadedYet = false
		
		internalChunkSize = DEFAULT_CHUNK_SIZE
	End Sub
	
	Private Sub Class_Terminate()
		If IsObject(UploadedFiles) Then
			UploadedFiles.RemoveAll()
			Set UploadedFiles = Nothing
		End If
		If IsObject(FormElements) Then
			FormElements.RemoveAll()
			Set FormElements = Nothing
		End If
		StreamRequest.Close
		Set StreamRequest = Nothing
	End Sub

	Public Property Get Form(sIndex)
		Form = ""
		If FormElements.Exists(LCase(sIndex)) Then Form = FormElements.Item(LCase(sIndex))
	End Property

	Public Property Get Files()
		Files = UploadedFiles.Items
	End Property
	
    Public Property Get Exists(sIndex)
            Exists = false
            If FormElements.Exists(LCase(sIndex)) Then Exists = true
    End Property
        
    Public Property Get FileExists(sIndex)
        FileExists = false
            if UploadedFiles.Exists(LCase(sIndex)) then FileExists = true
    End Property
        
    Public Property Get chunkSize()
		chunkSize = internalChunkSize
	End Property

	Public Property Let chunkSize(sz)
		internalChunkSize = sz
	End Property

	Public Sub Save(path)
		Dim streamFile, fileItem
		Dim fs, fileNum, fileArr, fileNam, fileExt, fileExist
						
		if Right(path, 1) <> "\" then path = path & "\"

		if not uploadedYet then Upload

		For Each fileItem In UploadedFiles.Items
			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			
			fileItem.Path = path & fileItem.FileName
			fileNum = 0
			fileArr = split(fileItem.FileName, ".")
			fileNam = fileArr(0)
			fileExt = fileArr(1)
			fileExist = false
			
			Do until fileExist = true
				if fs.FileExists(fileItem.Path) = true then
					fileNum = fileNum + 1
					fileItem.FileName = fileNam & "_" & fileNum & "." & fileExt
					fileItem.Path = path & "\" & fileItem.FileName
				else
					fileExist = true
				End if
			Loop
			
			Set streamFile = Server.CreateObject("ADODB.Stream")
			streamFile.Type = 1
			streamFile.Open
			StreamRequest.Position=fileItem.Start
			StreamRequest.CopyTo streamFile, fileItem.Length
			streamFile.SaveToFile fileItem.Path, 2
			streamFile.close
			Set streamFile = Nothing

			fileItem.Path = Replace(fileItem.Path, "\", "\\")
		 Next
	End Sub

	Public Function SaveBinRequest(path) ' 디버깅을 위해서
		StreamRequest.SaveToFile path & "\debugStream.bin", 2
	End Function

	Public Sub Upload()
		Dim nCurPos, nDataBoundPos, nLastSepPos
		Dim nPosFile, nPosBound
		Dim sFieldName, osPathSep, auxStr
		Dim readBytes, readLoop, tmpBinRequest
		
		'RFC1867 토큰
		Dim vDataSep
		Dim tNewLine, tDoubleQuotes, tTerm, tFilename, tName, tContentDisp, tContentType
		tNewLine = String2Byte(Chr(13))
		tDoubleQuotes = String2Byte(Chr(34))
		tTerm = String2Byte("--")
		tFilename = String2Byte("filename=""")
		tName = String2Byte("name=""")
		tContentDisp = String2Byte("Content-Disposition")
		tContentType = String2Byte("Content-Type:")

		uploadedYet = true

		on error resume next
			readBytes = internalChunkSize
			VarArrayBinRequest = Request.BinaryRead(readBytes)
			VarArrayBinRequest = midb(VarArrayBinRequest, 1, lenb(VarArrayBinRequest))
			for readLoop = 0 to 300000
				tmpBinRequest = Request.BinaryRead(readBytes)
				
				if readBytes < 1 then exit for
				VarArrayBinRequest = VarArrayBinRequest & midb(tmpBinRequest, 1, lenb(tmpBinRequest))
			next
			
			if Err.Number <> 0 then 
				response.write "<br><br><B>시스템 오류 목록:</B><p>"
				response.write Err.Description & "<p>"
				response.write "IIS MetaBase의 AspMaxRequestEntityAllowed 값을 설정하여 주십시오.<p>"
				Exit Sub
			end if
		on error goto 0 '리셋 오류 핸들링

		nCurPos = FindToken(tNewLine,1)

		If nCurPos <= 1  Then Exit Sub
		 
		vDataSep = MidB(VarArrayBinRequest, 1, nCurPos-1)

		'시작
		nDataBoundPos = 1

		'끝 라인 시작
		nLastSepPos = FindToken(vDataSep & tTerm, 1)

		Do Until nDataBoundPos = nLastSepPos
			nCurPos = SkipToken(tContentDisp, nDataBoundPos)
			nCurPos = SkipToken(tName, nCurPos)
			sFieldName = ExtractField(tDoubleQuotes, nCurPos)

			nPosFile = FindToken(tFilename, nCurPos)
			nPosBound = FindToken(vDataSep, nCurPos)
			
			If nPosFile <> 0 And  nPosFile < nPosBound Then
				Dim oUploadFile
				Set oUploadFile = New UploadedFile
				
				nCurPos = SkipToken(tFilename, nCurPos)
				auxStr = ExtractField(tDoubleQuotes, nCurPos)
                osPathSep = "\"
                
                if InStr(auxStr, osPathSep) = 0 then osPathSep = "/"
                
                oUploadFile.origName = Right(auxStr, Len(auxStr)-InStrRev(auxStr, osPathSep))
				oUploadFile.FileName = CreateRandom(Right(auxStr, Len(auxStr)-InStrRev(auxStr, osPathSep)))

				if (Len(oUploadFile.FileName) > 0) then
					nCurPos = SkipToken(tContentType, nCurPos)
					
                    auxStr = ExtractField(tNewLine, nCurPos)
					oUploadFile.ContentType = Right(auxStr, Len(auxStr)-InStrRev(auxStr, " "))
					nCurPos = FindToken(tNewLine, nCurPos) + 4 '빈 라인 건너 뜀
					
					oUploadFile.Start = nCurPos+1
					oUploadFile.Length = FindToken(vDataSep, nCurPos) - 2 - nCurPos
					
					If oUploadFile.Length > 0 Then UploadedFiles.Add LCase(sFieldName), oUploadFile
				End If
			Else
				Dim nEndOfData
				nCurPos = FindToken(tNewLine, nCurPos) + 4 '빈 라인 건너 뜀
				nEndOfData = FindToken(vDataSep, nCurPos) - 2
				If Not FormElements.Exists(LCase(sFieldName)) Then 
					FormElements.Add LCase(sFieldName), Byte2String(MidB(VarArrayBinRequest, nCurPos, nEndOfData-nCurPos))
				else
                    FormElements.Item(LCase(sFieldName))= FormElements.Item(LCase(sFieldName)) & ", " & Byte2String(MidB(VarArrayBinRequest, nCurPos, nEndOfData-nCurPos)) 
                end if 

			End If

			nDataBoundPos = FindToken(vDataSep, nCurPos)
		Loop
		StreamRequest.WriteText(VarArrayBinRequest)
	End Sub

	Private Function SkipToken(sToken, nStart)
		SkipToken = InstrB(nStart, VarArrayBinRequest, sToken)
		If SkipToken = 0 then
			Response.write "처리중 오류가 발생하였습니다. IIS MetaBase의 AspMaxRequestEntityAllowed 값을 설정하여 주십시오.<p>"
			Response.End
		end if
		SkipToken = SkipToken + LenB(sToken)
	End Function

	Private Function FindToken(sToken, nStart)
		FindToken = InstrB(nStart, VarArrayBinRequest, sToken)
	End Function

	Private Function ExtractField(sToken, nStart)
		Dim nEnd
		nEnd = InstrB(nStart, VarArrayBinRequest, sToken)
		If nEnd = 0 then
			Response.write "처리중 오류가 발생하였습니다."
			Response.End
		end if
		ExtractField = Byte2String(MidB(VarArrayBinRequest, nStart, nEnd-nStart))
	End Function

	Private Function String2Byte(sString)
		Dim i
		For i = 1 to Len(sString)
		   String2Byte = String2Byte & ChrB(AscB(Mid(sString,i,1)))
		Next
	End Function

	Private Function Byte2String(bsString)
		Dim i
		dim b1, b2, b3, b4
		Byte2String =""
		For i = 1 to LenB(bsString)
		    if AscB(MidB(bsString,i,1)) < 128 then
		        '1 바이트
    		    Byte2String = Byte2String & ChrW(AscB(MidB(bsString, i, 1)))
    		elseif AscB(MidB(bsString, i, 1)) < 224 then
    		    '2 바이트
    		    b1 = AscB(MidB(bsString, i, 1))
    		    b2 = AscB(MidB(bsString, i + 1, 1))
    		    Byte2String = Byte2String & ChrW((((b1 AND 28) / 4) * 256 + (b1 AND 3) * 64 + (b2 AND 63)))
    		    i = i + 1
    		elseif AscB(MidB(bsString, i, 1)) < 240 then
    		    '3 바이트
    		    b1 = AscB(MidB(bsString, i, 1))
    		    b2 = AscB(MidB(bsString, i + 1, 1))
    		    b3 = AscB(MidB(bsString, i + 2, 1))
    		    Byte2String = Byte2String & ChrW(((b1 AND 15) * 16 + (b2 AND 60)) * 256 + (b2 AND 3) * 64 + (b3 AND 63))
    		    i = i + 2
    		else
    		    '4 바이트
    		    b1 = AscB(MidB(bsString, i, 1))
    		    b2 = AscB(MidB(bsString, i + 1, 1))
    		    b3 = AscB(MidB(bsString, i + 2, 1))
    		    b4 = AscB(MidB(bsString, i + 3, 1))
    		    Byte2String = Byte2String & "^"
    		    i = i + 3
		    end if
		Next
	End Function
End Class

Class UploadedFile
	Public ContentType
	Public Start
	Public Length
	Public Path
	Public origName
	Private nameOfFile

    Public Property Let FileName(fN)
        nameOfFile = fN
        nameOfFile = SubstNoReg(nameOfFile, "\", "_")
        nameOfFile = SubstNoReg(nameOfFile, "/", "_")
        nameOfFile = SubstNoReg(nameOfFile, ":", "_")
        nameOfFile = SubstNoReg(nameOfFile, "*", "_")
        nameOfFile = SubstNoReg(nameOfFile, "?", "_")
        nameOfFile = SubstNoReg(nameOfFile, """", "_")
        nameOfFile = SubstNoReg(nameOfFile, "<", "_")
        nameOfFile = SubstNoReg(nameOfFile, ">", "_")
        nameOfFile = SubstNoReg(nameOfFile, "|", "_")
    End Property

    Public Property Get FileName()
        FileName = nameOfFile
    End Property

End Class

Function SubstNoReg(initialStr, oldStr, newStr)
    Dim currentPos, oldStrPos, skip
    If IsNull(initialStr) Or Len(initialStr) = 0 Then
        SubstNoReg = ""
    ElseIf IsNull(oldStr) Or Len(oldStr) = 0 Then
        SubstNoReg = initialStr
    Else
        If IsNull(newStr) Then newStr = ""
        currentPos = 1
        oldStrPos = 0
        SubstNoReg = ""
        skip = Len(oldStr)
        Do While currentPos <= Len(initialStr)
            oldStrPos = InStr(currentPos, initialStr, oldStr)
            If oldStrPos = 0 Then
                SubstNoReg = SubstNoReg & Mid(initialStr, currentPos, Len(initialStr) - currentPos + 1)
                currentPos = Len(initialStr) + 1
            Else
                SubstNoReg = SubstNoReg & Mid(initialStr, currentPos, oldStrPos - currentPos) & newStr
                currentPos = oldStrPos + skip
            End If
        Loop
    End If
End Function

Function CreateRandom(origName)
 	Randomize Timer
  	Dim tmpCounter, tmpID, fileExt
  	Const strValid = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  	For tmpCounter = 1 To 20
    tmpID = tmpID & Mid(strValid, Int(Rnd(1) * Len(strValid)) + 1, 1)
  	Next
  	
  	fileExt = Mid(origName, InStrRev(origName, ".") + 1)
  	CreateRandom = tmpID & "." & LCase(fileExt)
End Function
%>