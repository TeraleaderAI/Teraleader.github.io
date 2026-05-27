<%
'--------------------------------------------------------------------------------------
function fn_leapmonth(pYear)
    '*****************************************************
    'return boolean
    '그해의 윤달 여부 
    '*****************************************************
 
    '연도를 100으로 나눠떨어지지 않으면서 4로 나누어 떨어지면 윤달있음.
    '또는 
    '연도를 400으로 나눠떨어지면 윤달있음.
 
    if (pYear mod 100 <> 0 and pYear mod 4 = 0) or pYear mod 400 = 0 then
        fn_leapmonth = true
    else
        fn_leapmonth = false
    end if
 
    '이런 방법은 어떨까
    '날자의 존재여부를 확인하는 isdate 내장함수를 사용하는것이다.
    '예)isdate("2004-02-29") 는 true 이지만 isdate("2005-02-29") 는 false 이다.
end function
'--------------------------------------------------------------------------------------
function fn_monthcount(pYear,pMonth)
    '*****************************************************
    'return type : integer
    '해당월의 마지막 월을 반환한다
    '*****************************************************
 
    Dim aMonthNum
    aMonthNum = Split("31-0-31-30-31-30-31-31-30-31-30-31-", "-")
 
    '2월달은 예외
    if fn_leapmonth(pYear) then
        aMonthNum(1) = 29
    else
        aMonthNum(1) = 28
    end if
    
    fn_monthcount = cint(aMonthNum(cint(pMonth)-1))
 
end function
'--------------------------------------------------------------------------------------
function fn_firstweek(pYear,pMonth)
    '*****************************************************
    'return type : integer
    '해당년/월의 첫번째일의 위치를 반환
    '*****************************************************
    fn_firstweek = WeekDay(pYear & "-" & pMonth)
end function
'--------------------------------------------------------------------------------------
function fn_nowweek(pYear,pMonth,pDay)
    '*****************************************************
    'return type : integer
    '해당년/월/일의 위치를 반환
    '*****************************************************
    fn_nowweek = WeekDay(pYear & "-" & pMonth & "-" & pDay)
end function
'--------------------------------------------------------------------------------------
function fn_lastweek(pYear,pMonth)
    '*****************************************************
    'return type : integer
    '해당년/월의 마지막일의 위치를 반환
    '*****************************************************
    fn_lastweek = WeekDay(pYear & "-" & pMonth & "-" & fn_monthcount(pYear,pMonth))
end function
'--------------------------------------------------------------------------------------
function fn_blankweekfirst(pYear,pMonth)
    '*****************************************************
    'return type : integer
    '첫번째주 의 빈값을 구한다.
    '해당 년/월의 일수시작이 수요일 이라면 일/월/화 는 빈값이다.
    '*****************************************************
    fn_blankweekfirst = fn_firstweek(pYear,pMonth)-1
end function
'--------------------------------------------------------------------------------------
function fn_blankweeklast(pYear,pMonth)
    '*****************************************************
    'return type : integer
    '마지막주 의 빈값을 구한다.
    '해당 년/월의 일수끝이 목요일 이라면 금/토 는 빈값이다.
    '*****************************************************
    fn_blankweeklast = 7-fn_lastweek(pYear,pMonth)
end function
'--------------------------------------------------------------------------------------
function fn_CalMain(pYear,pMonth)
    '*****************************************************
    'return type : aay
    '주어진 년/월의 달력을 만든다.
    '2차원배열을 사용하여 틀을 만든다.
    '가로(1주)는 무조건 7이 되므로 세로값만 알면 된다.
    '빈칸은 null 값으로한다
    '형태예제(2005년10월일경우)
    '|일|월|화|수|목|금|토|
    '| n| n| n| n| n| n| 1|
    '| 2| 3| 4| 5| 6| 7| 8|
    '| 9|10|11|12|13|14|15|
    '|16|17|18|19|20|21|22|
    '|23|24|25|26|27|28|29|
    '|30|31| n| n| n| n| n|
    '*****************************************************
 
    Dim aCal()'달력의 틀을 위한 2차원배열
    Dim intVertical'세로줄값
    Dim intWeekcnt'주일수
    Dim i,j 
    Dim k'루프전체 합
    Dim intDay'일수 값
 
    '초기값 셋팅
    k=1
    intDay=1'일
    '세로값얻는 방법 (그달의 일수 + 첫째주빈값 + 마지막주빈값)/7=세로값
    intVertical = (fn_monthcount(pYear,pMonth)+fn_blankweekfirst(pYear,pMonth)+fn_blankweeklast(pYear,pMonth))/7
    intWeekcnt = 7
 
    '배열셋팅
    'aay(세로사이즈,가로사이즈)
    ReDim aCal(intVertical,intWeekcnt)
 
    '배열에 값 삽입
    for i=1 to intVertical 
        for j=1 to intWeekcnt
            'k의값이 첫번째주 빈값보다 작거나 같을경우는 null을 삽입
            if k<=fn_blankweekfirst(pYear,pMonth) then
                aCal(i,j) = null
            'k의값이 첫번째주빈값이상이며 보다 작거나같으고 해당월의 마지막 월값과 작거나같을경우는 일수를 삽입
            elseif k<=fn_blankweekfirst(pYear,pMonth)+intDay and intDay<=fn_monthcount(pYear,pMonth) then
                aCal(i,j) = intDay
                intDay = intDay+1
            '이외의 값은 null로 채운다
            else
                aCal(i,j) = null
            end if
            k=k+1
        next
    next
 
    fn_CalMain=aCal
 
end function
'--------------------------------------------------------------------------------------
function getSolar(pYear,pMonth,pDay)
    '*****************************************************
    'return type : string(yyyy-mm-dd)
    '음력을 양력으로 변환하는 함수
    '*****************************************************
    dim sLunarTableString
    dim sLunarTable, nDay
    
    ' 음력 테이블
    sLunarTableString = "1212122322121-1212121221220-1121121222120-2112132122122-2112112121220-2121211212120-2212321121212-2122121121210-2122121212120-1232122121212-1212121221220-1121123221222-1121121212220-1212112121220-2121231212121-2221211212120-1221212121210-2123221212121-2121212212120-1211212232212-1211212122210-2121121212220-1212132112212-2212112112210-2212211212120-1221412121212-1212122121210-2112212122120-1231212122212-1211212122210-2121123122122-2121121122120-2212112112120-2212231212112-2122121212120-1212122121210-2132122122121-2112121222120-1211212322122-1211211221220-2121121121220-2122132112122-1221212121120-2121221212110-2122321221212-1121212212210-2112121221220-1231211221222-1211211212220-1221123121221-2221121121210-2221212112120-1221241212112-1212212212120-1121212212210-2114121212221-2112112122210-2211211412212-2211211212120-2212121121210-2212214112121-2122122121120-1212122122120-1121412122122-1121121222120-2112112122120-2231211212122-2121211212120-2212121321212-2122121121210-2122121212120-1212142121212-1211221221220-1121121221220-2114112121222-1212112121220-2121211232122-1221211212120-1221212121210-2121223212121-2121212212120-1211212212210-2121321212221-2121121212220-1212112112210-2223211211221-2212211212120-1221212321212-1212122121210-2112212122120-1211232122212-1211212122210-2121121122210-2212312112212-2212112112120-2212121232112-2122121212110-2212122121210-2112124122121-2112121221220-1211211221220-2121321122122-2121121121220-2122112112322-1221212112120-1221221212110-2122123221212-1121212212210-2112121221220-1211231212222-1211211212220-1221121121220-1223212112121-2221212112120-1221221232112-1212212122120-1121212212210-2112132212221-2112112122210-2211211212210-2221321121212-2212121121210-2212212112120-1232212122112-1212122122120-1121212322122-1121121222120-2112112122120-2211231212122-2121211212120-2122121121210-2124212112121-2122121212120-1212121223212-1211212221220-1121121221220-2112132121222-1212112121220-2121211212120-2122321121212-1221212121210-2121221212120-1232121221212-1211212212210-2121123212221-2121121212220-1212112112220-1221231211221-2212211211220-1212212121210-2123212212121-2112122122120-1211212322212-1211212122210-2121121122120-2212114112122-2212112112120-2212121211210-2212232121211-2122122121210-2112122122120-1231212122212-1211211221220-2121121321222-2121121121220-2122112112120-2122141211212-1221221212110-2121221221210-2114121221221" '2050
    sLunarTable = Split(sLunarTableString, "-")
    nDay = Split("31-0-31-30-31-30-31-31-30-31-30-31", "-")
 
 
    dim nRetYear, nRetMonth, nRetDay
    dim nDays, nLunarMonth
    dim i, j
 
    nDays = 0
    for i = 0 to pYear - 1882            ''' 전년도까지의 일수를 구한다
        for j = 1 to 13
            nLunarMonth = CInt(Mid(sLunarTable(i), j, 1))
            if nLunarMonth > 2 then
                nDays = nDays + (26 +  nLunarMonth)
            else
                if nLunarMonth > 0 then nDays = nDays + (28 +  nLunarMonth)
            end if
        next
    next
 
    dim nLeapMonthCount, nRealMonthCount
    
    nLeapMonthCount = pMonth
    nRealMonthCount = 0
    do                        ''' 전달까지의 일수를 구한다
        nRealMonthCount = nRealMonthCount + 1
        if CInt(Mid(sLunarTable(pYear - 1881), nRealMonthCount, 1)) > 2 then
            nDays = nDays + 26 + CInt(Mid(sLunarTable(pYear - 1881), nRealMonthCount, 1))
            nLeapMonthCount = nLeapMonthCount + 1
        else
            if nRealMonthCount = nLeapMonthCount then
                if bIsLeapMonth then nDays = nDays + 28 + CInt(Mid(sLunarTable(pYear - 1881), nRealMonthCount, 1))
                exit do
            end if
            nDays = nDays + 28 + CInt(Mid(sLunarTable(pYear - 1881), nRealMonthCount, 1))
        end if
    loop
    nDays = nDays + pDay + 29
 
    
    'dim nDayPerYear
    
    nRetYear = 1880
    do                    ''' 연도를 구한다
        nRetYear = nRetYear + 1
        nDayPerYear = 365
        if nRetYear MOD 400 = 0 OR nRetYear MOD 100 <> 0 AND nRetYear MOD 4 = 0 then
            nDayPerYear = 366
        end if
        if nDays < nDayPerYear then exit do
        nDays = nDays - nDayPerYear
    loop
    
    nDay(1) = nDayPerYear - 337        ''' 2월의 날수를 계산
 
    nRetMonth = 0
    do                        ''' 월을 구한다
        nRetMonth = nRetMonth + 1
        if nDays <= CInt(nDay(nRetMonth - 1)) then exit do
        nDays = nDays - CInt(nDay(nRetMonth - 1))
    loop 
    
    nRetDay = nDays
    
    getSolar = CStr(nRetYear) & "-" & Right("0" & nRetMonth, 2) & "-" & Right("0" & nRetDay, 2)

    
end function
'--------------------------------------------------------------------------------------
function getLunar(pYear,pMonth,pDay)
    '*****************************************************
    'return type : string(yyyy-mm-dd)
    '양력을 음력으로 변환하는 함수
    '*****************************************************
    dim sLunarTableString
    dim sLunarTable, nDay
    
    ' 음력 테이블
    sLunarTableString = "1212122322121-1212121221220-1121121222120-2112132122122-2112112121220-2121211212120-2212321121212-2122121121210-2122121212120-1232122121212-1212121221220-1121123221222-1121121212220-1212112121220-2121231212121-2221211212120-1221212121210-2123221212121-2121212212120-1211212232212-1211212122210-2121121212220-1212132112212-2212112112210-2212211212120-1221412121212-1212122121210-2112212122120-1231212122212-1211212122210-2121123122122-2121121122120-2212112112120-2212231212112-2122121212120-1212122121210-2132122122121-2112121222120-1211212322122-1211211221220-2121121121220-2122132112122-1221212121120-2121221212110-2122321221212-1121212212210-2112121221220-1231211221222-1211211212220-1221123121221-2221121121210-2221212112120-1221241212112-1212212212120-1121212212210-2114121212221-2112112122210-2211211412212-2211211212120-2212121121210-2212214112121-2122122121120-1212122122120-1121412122122-1121121222120-2112112122120-2231211212122-2121211212120-2212121321212-2122121121210-2122121212120-1212142121212-1211221221220-1121121221220-2114112121222-1212112121220-2121211232122-1221211212120-1221212121210-2121223212121-2121212212120-1211212212210-2121321212221-2121121212220-1212112112210-2223211211221-2212211212120-1221212321212-1212122121210-2112212122120-1211232122212-1211212122210-2121121122210-2212312112212-2212112112120-2212121232112-2122121212110-2212122121210-2112124122121-2112121221220-1211211221220-2121321122122-2121121121220-2122112112322-1221212112120-1221221212110-2122123221212-1121212212210-2112121221220-1211231212222-1211211212220-1221121121220-1223212112121-2221212112120-1221221232112-1212212122120-1121212212210-2112132212221-2112112122210-2211211212210-2221321121212-2212121121210-2212212112120-1232212122112-1212122122120-1121212322122-1121121222120-2112112122120-2211231212122-2121211212120-2122121121210-2124212112121-2122121212120-1212121223212-1211212221220-1121121221220-2112132121222-1212112121220-2121211212120-2122321121212-1221212121210-2121221212120-1232121221212-1211212212210-2121123212221-2121121212220-1212112112220-1221231211221-2212211211220-1212212121210-2123212212121-2112122122120-1211212322212-1211212122210-2121121122120-2212114112122-2212112112120-2212121211210-2212232121211-2122122121210-2112122122120-1231212122212-1211211221220-2121121321222-2121121121220-2122112112120-2122141211212-1221221212110-2121221221210-2114121221221-" '2050
    sLunarTable = Split(sLunarTableString, "-")
    nDay = Split("31-0-31-30-31-30-31-31-30-31-30-31", "-")
 
    dim i, j
    dim nDayTable(170)
 
    dim nLunarMonth
    
    '음력 일수 셋팅
    for i = 0 to 169
        nDayTable(i) = 0
        for j = 1 to 13
            nLunarMonth = CInt(Mid(sLunarTable(i), j, 1))
            select case nLunarMonth
                case 1, 3
                    nDayTable(i) = nDayTable(i) + 29
                case 2, 4
                    nDayTable(i) = nDayTable(i) + 30
            end select
        next
    next
    
    dim nYear, nDays1, nDays2, nDays3
 
    nYear = pYear - 1
    nDays1 = 1880 * 365 + 1880 \ 4 - 1880 \ 100 + 1880 \ 400 + 30        ''' 1880년 까지의 날수
    nDays2 = nYear * 365 + nYear \ 4 - nYear \ 100 + nYear \ 400        ''' 1880년 이후의 날수
    
    '윤년일수 설정
    if fn_leapmonth(pYear) then
        nDay(1) = 29
    else
        nDay(1) = 28
    end if
 
    for i = 0 to pMonth - 2            ''' 전달까지의 날짜를 계산
        nDays2 = nDays2 + nDay(i)
    next
    nDays2 = nDays2 + pDay
    nRetDay = nDays2 - nDays1 + 1
    nDays3 = nDayTable(0)
    
    dim nRetDay, nRetMonth, nRetYear
    
    for i = 0 to 169
        if nRetDay <= nDays3 then exit for
        nDays3 = nDays3 + nDayTable(i + 1)
    next
    nRetYear = i + 1881
    nDays3 = nDays3 - nDayTable(i)
    nRetDay = nRetDay - nDays3
    
    dim nMonthCount, nDayPerMonth
    
    nMonthCount = 11 : if Mid(sLunarTable(i), 13, 1) > 0 then nMonthCount = 12
    nRetMonth = 0
    for j = 0 to nMonthCount
        nLunarMonth = CInt(Mid(sLunarTable(i), j + 1, 1))
        if nLunarMonth > 2 then
            nDayPerMonth = nLunarMonth + 26
        else
            nRetMonth = nRetMonth + 1
            nDayPerMonth = nLunarMonth + 28
        end if
        if nRetDay <= nDayPerMonth then exit for
        nRetDay = nRetDay - nDayPerMonth
    next
 
    getLunar=CStr(nRetYear) & "-" & Right("0" & nRetMonth, 2) & "-" & Right("0" & nRetDay, 2)
end function

'--------------------------------------------------------------------------------------
Function fn_Holiday( pYear,pMonth, pDay  )
	'*****************************************************
    'return type : boolean
    '휴일 여부
	'휴일은 음력에서 1.1(설)/8.15(추석)/4.8(석가탄신일) 이 있으며
	'양력으로 1.1(신정)/3.1(삼일절)/4.5(식목일)/5.5(어린이날)/6.6(현충일)/7.17(제헌절)/8.15(광복절)/10.3(개천절)/12.25(크리스마스) 이다.
	'설과 추석은 앞뒤로 하루씩 휴일이 더해진다.
	'*****************************************************
	dim aHoli(13,31)
	dim i, j
	
	For	i = 0 to 12
		For j = 0 to 30
			aHoli(i, j) = false
		Next
	Next

	'양력 휴일
	aHoli(1,1) = true
	aHoli(3,1) = true
	aHoli(4,5) = true
	aHoli(5,5) = true
	aHoli(6,6) = true
	aHoli(7,17) = true
	aHoli(8,15) = true
	aHoli(10,3) = true
	aHoli(12,25) = true

	'음력휴일
	Dim iLunYear,iLunMonth,iLunDay,iLunYmd,iLunYmdpre,iLunYmdnext

	'(설)
	iLunYmd = getSolar(pYear,1,1)
	iLunYmdpre = dateadd("d",-1,iLunYmd)
	
	iLunYmdnext = dateadd("d",1,iLunYmd)

	aHoli(month(iLunYmd),day(iLunYmd)) = true
	aHoli(month(iLunYmdpre),day(iLunYmdpre)) = true
	aHoli(month(iLunYmdnext),day(iLunYmdnext)) = true

	'(추석)
	iLunYmd = getSolar(pYear,8,15)
	iLunYmdpre = dateadd("d",-1,iLunYmd)
	iLunYmdnext = dateadd("d",1,iLunYmd)

	aHoli(month(iLunYmd),day(iLunYmd)) = true
	aHoli(month(iLunYmdpre),day(iLunYmdpre)) = true
	aHoli(month(iLunYmdnext),day(iLunYmdnext)) = true

	'(석가탄신일)
	iLunYmd = getSolar(pYear,4,8)

	aHoli(month(iLunYmd),day(iLunYmd)) = true

	fn_Holiday = aHoli( pMonth , pDay )
End Function

Function fn_HolidayPrint( pYear,pMonth, pDay  )
	dim aHoli(13,31)
	dim i, j
	
	For	i = 0 to 12
		For j = 0 to 30
			aHoli(i, j) = false
		Next
	Next

	'양력 휴일
	aHoli(1,1) = "신정"
	aHoli(3,1) = "삼일절"
	aHoli(4,5) = "식목일"
	aHoli(5,5) = "어린이날"
	aHoli(6,6) = "현충일"
	aHoli(7,17) = "제헌절"
	aHoli(8,15) = "광복절"
	aHoli(10,3) = "개천절"
	aHoli(12,25) = "성탄절"

	'음력휴일
	Dim iLunYear,iLunMonth,iLunDay,iLunYmd,iLunYmdpre,iLunYmdnext

	'(설)
	iLunYmd = getSolar(pYear,1,1)
	iLunYmdpre = dateadd("d",-1,iLunYmd)
	
	iLunYmdnext = dateadd("d",1,iLunYmd)

	aHoli(month(iLunYmd),day(iLunYmd)) = "설연휴"
	aHoli(month(iLunYmdpre),day(iLunYmdpre)) = "설연휴"
	aHoli(month(iLunYmdnext),day(iLunYmdnext)) = "설연휴"

	'(추석)
	iLunYmd = getSolar(pYear,8,15)
	iLunYmdpre = dateadd("d",-1,iLunYmd)
	iLunYmdnext = dateadd("d",1,iLunYmd)

	aHoli(month(iLunYmd),day(iLunYmd)) = "추석"
	aHoli(month(iLunYmdpre),day(iLunYmdpre)) = "추석"
	aHoli(month(iLunYmdnext),day(iLunYmdnext)) = "추석"

	'(석가탄신일)
	iLunYmd = getSolar(pYear,4,8)

	aHoli(month(iLunYmd),day(iLunYmd)) = "석가탄신일"

	fn_HolidayPrint = aHoli( pMonth , pDay )
End Function
%>