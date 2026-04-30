	function mgStartPopup(id, sizew, sizeh, scroll, wtype, nx, ny, nposset, nposition, httpPath){
		var szHtmlPage = httpPath + "Library/iStartPopup.asp?popid=" + id;
		var nClientWidth = screen.availWidth;
		var nClientHeight = screen.availHeight;
	
		if (GetCookie("ps_popup"+id)){
			return;
		}
	
		if (nposset == 1){
			if ( nposition == 3 ) {
				nx = -1;
				ny = -1;
			}else{
				nx = 100;
				switch (nposition){
				case 0 :
					ny = 0;
					break;
				case 1 :
					ny = parseInt((nClientWidth / 2) - (sizew / 2));
					break;
				case 2 :
					ny = parseInt( nClientWidth - sizew );
					break;
				}
			}
		}
	
		if (nx == -1 && ny == -1) {
			if (wtype == 0){
				WndCenterOpen(szHtmlPage, 'iStartPopup_'+id, sizew, sizeh, scroll, '')
			}else{
				OpenModalDialog(szHtmlPage, "", sizew, sizeh)
			}
		}else{
			if (wtype == 0){
				var settings = 'height='+sizeh+',width='+sizew+',top='+nx+',left='+ny+',scrollbars='+scroll;
				_centerWnd = window.open(szHtmlPage, 'iStartPopup_'+id, settings);
			}else{
				window.showModalDialog( szHtmlPage, "", "dialogWidth:"+sizew+"px;dialogHeight:"+sizeh+"px;toolbar:no;location:no;help:no;directories:no;status:no;menubar:no;scrollbars:no;resizable:no;dialogLeft:"+nx+";dialogTop:"+ny);
			}
		}	
	}

	function mgStartLayerPopup(id, sizew, sizeh, scroll, wtype, nx, ny, nposset, nposition, noutline, outlinecolor, ani, httpPath){
		var szHtmlPage = httpPath + "Library/iStartPopup.asp?popid=" + id;
		var nTop = 0, nLeft = 0, nOutline = 0, nwOutline = sizew, nhOutline = sizeh;
		var nClientWidth = document.body.clientWidth;
		var nClientHeight = document.body.clientHeight;
	
		if(GetCookie("ps_popup"+id)){
			return;
		}
	
		if(noutline == 1){
			nOutline = 24;
			nwOutline += 24;
			nhOutline += 24;
		}
	
		if(nposset == 0){
			nTop = ny;
			nLeft = nx;
		}else{
			if(nposition == 3){
				nTop =  (nClientHeight / 2) - (sizeh / 2);
				nLeft = (nClientWidth / 2) - (sizew / 2);
			}else{
				nTop = 100;
				switch ( nposition ) {
				case 0 :
					nLeft = 0;
					break;
				case 1 :
					nLeft = parseInt((nClientWidth / 2) - ((sizew + nOutline) / 2));
					break;
				case 2 :
					nLeft = parseInt( nClientWidth - (sizew + nOutline) );
					break;
				}
			}
		}
	
		var szLayerPopupDoc = "";
		szLayerPopupDoc = "<DIV ID=objId_LayerId_"+id+" style='diaplay: black; position: absolute; top:"+nTop+"px; left:"+nLeft+"px;'>";
		szLayerPopupDoc += "<MARQUEE BEHAVIOR=SLIDE DIRECTION="+ani+" height="+nhOutline+" width="+nwOutline+" scrollamount=20>";
	
		if (noutline == 1){
			szLayerPopupDoc += "<table width="+nwOutline+" height="+nhOutline+" border=0 cellpadding=0 cellspacing=1 bgcolor=#000000><tr><td bgcolor="+outlinecolor+" valign=top><table width=100% border=0 cellspacing=0 cellpadding=0><tr><td bgcolor=#FFFFFF width=1 height=1 style='filter:Alpha(opacity=60);'></td><td height=1 bgcolor=#FFFFFF style='filter:Alpha(opacity=60);'></td><td bgcolor=#FFFFFF width=1 height=1 style='filter:Alpha(opacity=60);'></td></tr><tr><td width=1 bgcolor=#FFFFFF style='filter:Alpha(opacity=50);'></td><td valign=top height=100%><table width=100% border=0 cellspacing=0 cellpadding=0><tr><td bgcolor=#FFFFFF width=1 height=1 style='filter:Alpha(opacity=10);'></td><td height=1 bgcolor=#FFFFFF style='filter:Alpha(opacity=10);'></td><td bgcolor=#FFFFFF width=1 height=1 style='filter:Alpha(opacity=10);'></td></tr><tr><td width=1 bgcolor=#FFFFFF style='filter:Alpha(opacity=20);'></td><td style=padding:7px;><table width=100% border=0 cellspacing=0 cellpadding=0><tr><td bgcolor=#000000 width=1 height=1 style='filter:Alpha(opacity=70);'></td><td height=1 bgcolor=#000000 style='filter:Alpha(opacity=70);'></td><td bgcolor=#000000 style='filter:Alpha(opacity=70);' width=1 height=1 ></td></tr><tr><td width=1 bgcolor=#000000 style='filter:Alpha(opacity=70);'></td><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=0><tr><td bgcolor=#000000 width=1 height=1 style='filter:Alpha(opacity=20);'></td><td height=1 bgcolor=#000000 style='filter:Alpha(opacity=20);'></td><td bgcolor=#000000 width=1 height=1 style='filter:Alpha(opacity=20);'></td></tr><tr><td width=1 bgcolor=#000000 style='filter:Alpha(opacity=20);'></td><td align=center>";
		}
	
		szLayerPopupDoc += "<IFRAME SRC=\""+szHtmlPage+"\" FRAMEBORDER=0 WIDTH="+sizew+" HEIGHT="+sizeh+" ALIGN=CENTER MARGINWIDTH=0 MARGINHEIGHT=0 Scrolling=NO></IFRAME>";
	
		if (noutline == 1){
			szLayerPopupDoc += "</td><td width=1></td></tr><tr><td bgcolor=#000000 style='filter:Alpha(opacity=20);' width=1 height=1></td><td></td><td></td></tr></table></td><td bgcolor=#ffffff width=1></td></tr><tr><td bgcolor=#000000 style='filter:Alpha(opacity=70);' width=1 height=1></td><td bgcolor=#ffffff height=1></td><td bgcolor=#ffffff width=1 height=1 ></td></tr></table></td><td bgcolor=#FFFFFF width=1 style='filter:Alpha(opacity=20);'></td></tr><tr><td bgcolor=#FFFFFF width=1 height=1 style='filter:Alpha(opacity=20);'></td><td bgcolor=#FFFFFF height=1 style='filter:Alpha(opacity=20);'></td><td bgcolor=#FFFFFF width=1 height=1  style='filter:Alpha(opacity=20);'></td></tr></table></td><td bgcolor=#FFFFFF width=1 style='filter:Alpha(opacity=60);'></td></tr><tr><td bgcolor=#FFFFFF width=1 height=1 style='filter:Alpha(opacity=60);'></td><td bgcolor=#FFFFFF height=1 style='filter:Alpha(opacity=60);'></td><td bgcolor=#FFFFFF width=1 height=1  style='filter:Alpha(opacity=60);'></td></tr></table></td></tr></table>";
		}
	
		szLayerPopupDoc += "</MARQUEE></DIV>";
		window.document.write(szLayerPopupDoc);
	}

	function GetCookie(name){
		var arg = name + "=";
		var alen = arg.length;
		var clen = document.cookie.length;
		var i = 0;
	
		while (i < clen){
			var j = i + alen;
			if (document.cookie.substring(i, j) == arg)
					return getCookieVal (j);
			i = document.cookie.indexOf(" ", i) + 1;
			if (i == 0)
				break; 
		}
		return null;
	}

	function WndCenterOpen(mypage,myname,w,h,scroll,option){
		LeftPosition = (screen.width) ? (screen.width-w)/2 : 0;
		TopPosition = (screen.height) ? (screen.height-h)/2 : 0;
		settings = 'height='+h+',width='+w+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+option;
		_centerWnd = window.open(mypage,myname,settings)
		return _centerWnd;
	}


	function OpenModalDialog(HtmlFile, vOptions, nWidth, nHeight){
		var browser_type = getBrowserType();
	
		if (browser_type == "OPERA" || browser_type == "FIREFOX"){
			var qResult = window.open( HtmlFile, vOptions, "Width:"+nWidth+"px;Height:"+nHeight+"px;toolbar:no;location:no;help:no;directories:no;status:no;menubar:no;scroll:no;resizable:no");
			return qResult;
		}else{
			var qResult = top.window.showModalDialog( HtmlFile, vOptions, "dialogWidth:"+nWidth+"px;dialogHeight:"+nHeight+"px;toolbar:no;location:no;help:no;directories:no;status:no;menubar:no;scroll:no;resizable:no");
			return qResult;
		}
	}

	function getBrowserType(){
		var userAgent = navigator.userAgent;
		if (userAgent.indexOf('Opera') > 0)
			return "OPERA";
		else if ( userAgent.indexOf('Firefox') > 0 )
			return "FIREFOX";
		else
			return "MSIE";
	}

	function getCookieVal(offset){
		var endstr = document.cookie.indexOf (";", offset);
		if (endstr == -1)
			endstr = document.cookie.length;
	
		return unescape(document.cookie.substring(offset, endstr));
	}