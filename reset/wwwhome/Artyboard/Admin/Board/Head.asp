<!-- #include file = "../Head.asp" -->
<% isAdminMenu = 1 %>
<%
	IF SESSION("strAdmin") = "1" THEN
		IF REQUEST.QueryString("strBoardID") = "" THEN
		ELSE
			SET RS = DBCON.EXECUTE("SELECT [strAdmin] FROM [MPLUS_BOARD_CONFIG_DEFAULT] WHERE [strBoardID] = '" & REQUEST.QueryString("strBoardID") & "' ")
			IF RS.EOF THEN
				RESPONSE.WRITE ExecJavaAlert("관리자만 접근이 가능합니다.", 0)
				RESPONSE.End()
			END IF
			DIM strCheckAdmin, A, strCheckAdminCount
			strCheckAdmin = RS("strAdmin")
			IF strCheckAdmin = "" OR ISNULL(strCheckAdmin) = True THEN
				RESPONSE.WRITE ExecJavaAlert("관리자만 접근이 가능합니다.", 0)
				RESPONSE.End()
			ELSE
				strCheckAdmin = SPLIT(strCheckAdmin, "|")
				FOR A = 0 TO UBOUND(strCheckAdmin)
					IF strCheckAdmin(I) = SESSION("strLoginID") THEN
						strCheckAdminCount = 1
					END IF
				NEXT
				IF strCheckAdminCount = 1 THEN
				ELSE
					RESPONSE.WRITE ExecJavaAlert("관리자만 접근이 가능합니다.", 0)
					RESPONSE.End()
				END IF
			END IF
		END IF
	END IF
%>
<table width="960" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><!-- #include file = "../TopMenu.asp" --></td>
  </tr>
  <tr>
    <td height="15"></td>
  </tr>
  <tr>
    <td height="100%">
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" valign="top"><!-- #include file = "LeftMenu.asp" --></td>
          <td width="15">&nbsp;</td>
          <td valign="top">