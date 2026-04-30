<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title></title>
</head>
<body topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0">
<%
	DIM strBoardID, strSessionID, intUploadSize, intUploadCount

	WITH REQUEST

		strBoardID       = .QueryString("strBoardID")
		strSessionID     = .QueryString("strSessionID")
		intUploadSize    = .QueryString("intUploadSize")
		intUploadCount   = .QueryString("intUploadCount")

	END WITH
%>
<script type="text/javascript" src="AC_OETags.js"></script>
<script type="text/javascript">

	var MaxFileSize = <%=intUploadSize%>;
	var MaxFileCount = <%=intUploadCount%>;
	var ServerURL = "../../Include/BoardUpload.asp?strParmData=<%=strBoardID%>|<%=strSessionID%>";
	var AppControlSRC = "chxupload";
	var FileFilter = "모든 파일|*.*";
	var AppWidth = "100%";
	var AppHeight = "265";
	var AppID = "chxupload";
	var BorderColor = "0xdedfdf";
	var AppActive = "<%=sitePath%>";
	var AppTitle = "파일 업로드";
	var AppDescription = "전송할 파일을 선택하여 주십시오.";
	var ListColumnHeader_1 = "파일 이름";
	var ListColumnHeader_2 = "크기";
	var ListColumnHeader_3 = "상태";
	var btnFileSelect = "파일 선택...";
	var btnFileRemove = "선택 삭제";
	var UploadMaxSizeStatus = "파일전송 크기 / 최대 업로드 : ";
	var ProgressStatusReady = "준비";
	var DropShadowEnabled = false;
	var SESSID = "sessid";

	function CHXUploadFinished (files) {

		parent.show_waiting();
		parent.document.theForm.submit();

	}

	function CHXUploadStart () {
		if (navigator.appName.indexOf("microsoft") != -1)
			window[AppID].CHXUploadStart();
		else
			document[AppID].CHXUploadStart();
	}

	function CHXUploadRUN() {
	
		var vars = "SESSID="+SESSID+"&MaxFileSize="+MaxFileSize+"&Server="+ServerURL;
		if (MaxFileCount) vars += "&MaxFileCount="+MaxFileCount;
		if (FileFilter) vars += "&Filter="+FileFilter;
		if (AppActive) vars += "&AppActive="+AppActive;
		if (AppTitle) vars += "&AppTitle="+AppTitle;
		if (AppDescription) vars += "&AppDescription="+AppDescription;
		if (BorderColor) vars += "&BorderColor="+BorderColor;
		if (ListColumnHeader_1) vars += "&ListColumnHeader_1="+ListColumnHeader_1;
		if (ListColumnHeader_2) vars += "&ListColumnHeader_2="+ListColumnHeader_2;
		if (ListColumnHeader_3) vars += "&ListColumnHeader_3="+ListColumnHeader_3;
		if (DropShadowEnabled) vars += "&DropShadowEnabled="+DropShadowEnabled;
		if (btnFileSelect) vars += "&btnFileSelect="+btnFileSelect;
		if (btnFileRemove) vars += "&btnFileRemove="+btnFileRemove;
		if (UploadMaxSizeStatus) vars += "&UploadMaxSizeStatus="+UploadMaxSizeStatus;
		if (ProgressStatusReady) vars += "&ProgressStatusReady="+ProgressStatusReady;
	
		chxupload_RUN("src", AppControlSRC, "width", AppWidth, "height",   AppHeight, "align", "middle", "id", AppID,
									"flashvars", vars, "quality", "high", "bgcolor", "#ffffff", "name", "chxupload", "allowScriptAccess",
									"sameDomain", "type", "application/x-shockwave-flash", "pluginspage", "http://www.adobe.com/go/getflashplayer");
		}
	
	CHXUploadRUN();
	</script>
</body>
</html>
