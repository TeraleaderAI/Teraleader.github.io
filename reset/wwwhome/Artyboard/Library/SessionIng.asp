<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title></title>
</head>
<body>
<%
	DIM intLogOutTime
	intLogOutTime = REQUEST.QueryString("intLogOutTime")
	IF intLogOutTime = "" THEN intLogOutTime = 20
	Session.Timeout = intLogOutTime
%>
<script language="JavaScript">
var refreshinterval = <%=INT(intLogOutTime) * 60%>;
var displaycountdown = "no"
var starttime
var nowtime
var reloadseconds=0
var secondssinceloaded=0

function starttime() {
        starttime=new Date()
        starttime=starttime.getTime()
    countdown()
}

function countdown() {
        nowtime= new Date()
        nowtime=nowtime.getTime()
        secondssinceloaded=(nowtime-starttime)/1000
        reloadseconds=Math.round(refreshinterval-secondssinceloaded)
        if (refreshinterval>=secondssinceloaded) {
        var timer=setTimeout("countdown()",1000)
                if (displaycountdown=="yes") {
                        window.status="이 페이지는 "+reloadseconds+ "초 후에 리프레쉬됩니다"
                }
    }
    else {
        clearTimeout(timer)
				window.location.reload(true)
    } 
}
window.onload = starttime;
</script>
</body>
</html>