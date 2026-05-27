<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title></title>
</head>
<link rel="stylesheet" type="text/css" href="../../Admin/Css/style.css">
<body leftmargin="0" topmargin="0">
<!-- #include file = "../../Dbconnect/Dbconnect.asp" -->
<!-- #include file = "../../Library/Function.asp" -->
<%
	DIM isAdminMenu, isAdminPopup, strAdminPrevUrl
	isAdminMenu     = 1
	isAdminPopup    = True
	strAdminPrevUrl = "BoardList.asp"
%>
<!-- #include file = "../AdminCheck.asp" -->
<%
	DIM tempSkin, tempSkinSet, SELECTED, strSkinGroup, strSkin, intSkinCount, strNowSkinIMG, I
	tempSkin     = SPLIT(GetFolderList(rootPath & "Skin\Board\", strSkin, "file"), "|")
	strSkinGroup = REQUEST.QueryString("strSkinGroup")
	strSkin      = REQUEST.QueryString("strSkin")
	tempSkinSet  = GetFolderList(rootPath & "Skin\Board\" & strSkinGroup & "\", strSkin, "file")
	IF tempSkinSet = "" THEN
		intSkinCount = 0
		strNowSkinIMG = "<img id=skinPrev src=../images/skin_not_image.gif width=160 height=120 align=absmiddle border=0>"
	ELSE
		tempSkinSet = SPLIT(tempSkinSet, "|")
		IF strSkin = "" THEN strSkin = tempSkinSet(0)
		IF GetFileExists(rootPath & "Skin\Board\" & strSkinGroup & "\" & strSkin & "\", "preview.jpg") = True THEN strNowSkinIMG = "<img id=skinPrev src=../../Skin/Board/" & strSkinGroup & "/" & strSKin & "/preview.jpg width=160 height=120 align=absmiddle border=0>" ELSE strNowSkinIMG = "<img id=skinPrev src=../images/skin_not_image.gif width=160 height=120 align=absmiddle border=0>"
%>
<script language="javascript">

	var arrSkinPrev     = new Array(<%=UBOUND(tempSkinSet)%>);
	var arrSkinPrevZoom = new Array(<%=UBOUND(tempSkinSet)%>);

<%
	FOR I = 0 TO UBOUND(tempSkinSet)
		IF tempSkinSet(I) <> "" THEN
			IF GetFileExists(rootPath & "Skin\Board\" & strSkinGroup & "\" & tempSkinSet(I) & "\", "preview.jpg") = True THEN
				RESPONSE.WRITE "	arrSkinPrev[" & I & "] = ""../../Skin/Board/" & strSkinGroup & "/" & tempSkinSet(I) & "/preview.jpg"";" & vbcrlf
				RESPONSE.WRITE "	arrSkinPrevZoom[" & I & "] = """ & httpPath & "Skin/Board/" & strSkinGroup & "/" & tempSkinSet(I) & "/preview.jpg"";" & vbcrlf
			ELSE
				RESPONSE.WRITE "	arrSkinPrev[" & I & "] = ""../images/skin_not_image.gif"";" & vbcrlf
				RESPONSE.WRITE "	arrSkinPrevZoom[" & I & "] = """";" & vbcrlf
			END IF
		END IF
	NEXT
%>
</script>
<%
	END IF
%>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<form name="theForm" method="post">
  <tr>
    <td width="210"><select name="strSkinGroupSet" size="9" id="strSkinGroupSet" style="width:200" onChange="OnChangeSkinGroup(this.value);">
<%
	FOR I = 0 TO UBOUND(tempSkin)
		IF tempSkin(I) <> "" THEN
			IF UCASE(strSkinGroup) = UCASE(tempSkin(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
			RESPONSE.WRITE "<option value=" & tempSkin(I) & SELECTED & ">" & GetSKinGroupCode(tempSkin(I)) & "</option>" & vbcrlf
		END IF
	NEXT
%>
		</select></td>
    <td width="210"><select name="strSkinSet" size="9" id="strSkinSet" style="width:200" onChange="OnChangeSkinPrev();">
<%
	IF intSkinCount <> "0" THEN
		FOR I = 0 TO UBOUND(tempSkinSet)
			IF tempSkinSet(I) <> "" THEN
				IF UCASE(strSkin) = UCASE(tempSkinSet(I)) THEN SELECTED = " SELECTED " ELSE SELECTED = ""
				RESPONSE.WRITE "<option value=" & tempSkinSet(I) & SELECTED & ">" & tempSkinSet(I) & "</option>" & vbcrlf
			END IF
		NEXT
	END IF
%>
    </select></td>
    <td><a href="javascript:;" onClick="OnPopSkinView();"><%=strNowSkinIMG%></a></td>
  </tr>
</form>
</table>
<script language="javascript">
	function OnChangeSkinGroup(str){
		document.theForm.action = "BoardSkin.asp?strSkinGroup=" + str;
		document.theForm.submit();
	}

	function OnChangeSkinPrev(){
		for (i=0;i<document.all['strSkinSet'].length;i++){if (document.all['strSkinSet'][i].selected){nowItem = i;break;}}
		document.all['skinPrev'].src = arrSkinPrev[nowItem];
	}
	
	function OnPopSkinView(){
		for (i=0;i<document.all['strSkinSet'].length;i++){if (document.all['strSkinSet'][i].selected){nowItem = i;break;}}
		if (arrSkinPrevZoom[nowItem]!=""){
			parent.popupLayer('../SkinView.asp?strFileName=' + arrSkinPrevZoom[nowItem],800,632);
		}
	}
</script>
</body>
</html>