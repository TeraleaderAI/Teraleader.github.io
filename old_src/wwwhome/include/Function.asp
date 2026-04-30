<%
Function EditConvertChar(strValue)
    strValue = Replace(strValue, """", "&quot;")
    EditConvertChar=strValue
End Function

Function ConvertChar(strValue)

  strValue = Replace(strValue, "&", "&amp;")
	strValue = Replace(strValue, """", "&quot;")
	strValue = Replace(strValue, "|", "&#124;")
	strValue = Replace(strValue, "<", "&lt;")
	strValue = Replace(strValue, ">", "&gt;")
	strValue = Replace(strValue, chr(32), "&nbsp;")
	
	ConvertChar=strValue
		
End Function


Function ReverseWord(strValue)
    'strValue = Replace(strValue,Chr(13), ">>")
		strValue = Replace(strValue, "&amp;", "&")
		strValue = Replace(strValue, "&quot;", """")
		strValue = Replace(strValue, "&#124;", "|")
		strValue = Replace(strValue, "&lt;", "<")
		strValue = Replace(strValue, "&gt;", ">")
		strValue = Replace(strValue, "&nbsp;", chr(32))
    ReverseWord = strValue
End Function


Function TrimCheck(strValue)

    IF Trim(strValue) = "" THEN
        Response.Redirect "/error/Error.asp?err_msg="&Server.URLEncode("내용이 입력되어 있지 않습니다.")
    END IF
    TrimCheck = strValue
    
End Function

' 이미지 실제크기 알아내기
Function GetImageSize(Virtual_Image_Path)

	Dim objPic
	Set objPic = LoadPicture(Virtual_Image_Path)
	imgWidth = CLng(CDbl(objPic.Width) * 24 / 635) 
	imgHeight = CLng(CDbl(objPic.Height) * 24 / 635)
	Set objPic = Nothing
	
	GetImageSize=imgWidth&","&imgHeight

End Function

' 이미지 비율에 따라 축소하기
Function SetImageSize(img,widsize)		
	      							
	image = GetImageSize(img)		
	image = split(image, ",")		
	iwidth = image(0)
	iheight = image(1)
	'response.write iwidth
	'response.write iheight
	'response.end
	width = widsize		
	'response.write width
	
	'가로가 세로보다 클경우
	if (Cint(iwidth) > Cint(iheight)) then
		if(Cint(iwidth) > Cint(width)) then
			iheight = iheight * width / iwidth
			iwidth = width	 			
		end if				
	'세로가 가로보다 클경우
	elseif (Cint(iwidth) < Cint(iheight)) then
		if (Cint(iheight) > Cint(width)) then
			iwidth = iwidth * width / iheight
			iheight = width			
		end if					
	'가로,세로 같을경우
	else	
		if (Cint(iwidth) > Cint(width)) then
			iwidth = width
			iheight = width
		end if
	end if 	
	
	SetImageSize = iwidth&","&iheight
End Function




'제목글길이에 맞게 제목글 출력하기
function title_str(str,su)
	
	dim tmp
	
		str	=	Replace(str, "&nbsp;", " ")
		str_true_length = Len(str)
		'response.write str_true_length&":"
		tmp = Left(str,su)
		str_length = Len(tmp)
		'response.write su
		
		if Cint(str_true_length) >= Cint(su) then '원래의 글자길이가 원하는 글자길이보다 길다면
	
				if str_length mod 2  = 0 then
		
					title_str = tmp & "..."
				else			
		
					tmp			= Left(str,su-1)
					title_str   = tmp & "..."
				end if
		else
			title_str = tmp
		end if

end function


Function CName(camp_semester)

    if camp_semester="1" then
			semester_name		=	"1학기(여름)"
		elseif camp_semester="2" then
			semester_name		=	"2학기(겨울)"
		end if

		CName		=	semester_name

End Function

' 캠프/분류별 카운터
Function Check_Yncount(camp_no,camp_gubun)

  SQL	=	"SELECT count(redate_no) FROM tb_redate where redate_bgubun='"&redate_bgubun&"' and redate_sgubun='"&redate_sgubun&"'"
	SQL = SQL&" and redate_date='"&redate_date&"' and redate_state='"&redate_state&"'"
	Set rs = db.Execute(SQL)
	
	Check_Yncount		=	rs(0)
		
End Function


%>