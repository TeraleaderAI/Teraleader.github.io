<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<meta name="Description" content="테라리더">
<meta name="keywords" content="테라리더">
<title>테라리더</title>
<link rel="stylesheet" href="/css/base.css" type="text/css" title="style"/>
<script type="text/javascript" src="/js/autoHeight.js"></script>
<script type="text/javascript" language="javascript" src="/js/common.js"></script>
<script type="text/javascript" language="javascript" src="/js/resize.js"></script>
<script type="text/javascript" language="javascript" src="/js/topMenu_cyber.js"></script>
</head>
<%
	pagenum1		=	request("pagenum1")
	pagenum2		=	request("pagenum2")
	pagenum3		=	request("pagenum3")
	pagenum4		=	request("pagenum4")
	
	if pagenum1 = "1" then
		pagenum1display		=	"inline"
		pagenum2display		=	"none"
		pagenum3display		=	"none"
		pagenum4display		=	"none"
		
	elseif pagenum1 = "2" then
		pagenum1display		=	"none"
		pagenum2display		=	"inline"
		pagenum3display		=	"none"
		pagenum4display		=	"none"
		
	elseif pagenum1 = "3" then
		pagenum1display		=	"none"
		pagenum2display		=	"none"
		pagenum3display		=	"inline"
		pagenum4display		=	"none"
		
	elseif pagenum1 = "4" then
		pagenum1display		=	"none"
		pagenum2display		=	"none"
		pagenum3display		=	"none"
		pagenum4display		=	"inline"
		
	else
		pagenum1display		=	"none"
		pagenum2display		=	"none"
		pagenum3display		=	"none"
		pagenum4display		=	"none"
		
	end if
%>
<body>
<div id="skipNavi">
	<a href="#header">대메뉴로 이동</a>
	<a href="#contentsArea">본문 내용으로 이동</a>
</div>
<div id="wrapAll">
  <div id="header">
		<!-- gnb : str -->
		<div id="gnb">
			<div class="topMenu">
				<ul>
					<li><a href="/main.asp"><img src="/images/common/top_home.gif" alt="home"></a></li>
					<li><img src="/images/common/top_ling.GIF" /></li>
					<li><a href="/pages/sitemap/sitemap.asp"><img src="/images/common/top_sitemap.gif" alt="sitemap"></a></li>
					<!--li><img src="/images/common/top_ling.GIF" /></li>
					<li><a href="http://www.hitnb.co.kr/english"><img src="/images/common/top_english.gif" alt="영문사이트"></a></li-->
				</ul>
			</div>
			<div class="topLogoArea">
				<ul>
					<li><a href="/main.asp"><img src="/images/common/logo.gif" alt="데라리더로고"/></a></li>                  
				</ul>
			</div>
			<div class="topNavi">
            	<ul id="top1menu">
								 
                	<li class="menu"><a href="/pages/company/company02.asp?pagenum1=1&pagenum2=1" id="top1m1" onmouseover="choice(1);" onfocus="choice(1);"><img src="/images/common/gnb_topmenu01_off.gif"  alt="회사소개" name="q1"></a>
                        <div class="topSub" id="gnbSub1" style="display:none;">
                            <ul id="top2m1">
                                <!--li><a href="/pages/company/company01.asp?pagenum1=1&pagenum2=1">인사말</a></li-->
                                <li><a href="/pages/company/company02.asp?pagenum1=1&pagenum2=1">연혁</a></li>
								<li><a href="/pages/company/company03.asp?pagenum1=1&pagenum2=2">사업영역</a></li>
								<li><a href="/pages/company/company04.asp?pagenum1=1&pagenum2=3">찾아오시는길</a></li>
                            </ul>
                        </div>
                    </li>
                        	
                   <li class="menu2"></li>
                    
                    <li class="menu"><a href="/pages/product/product01.asp?pagenum1=2&pagenum2=1" id="top1m2" onmouseover="choice(2);" onfocus="choice(2);"><img src="/images/common/gnb_topmenu02_off.gif" alt="제품안내" name="q2"></a>
                    	<div class="topSub" id="gnbSub2" style="display:none;">
                            <ul id="top2m2">
                               <li><a href="/pages/product/product01.asp?pagenum1=2&pagenum2=1">제품안내</a></li>
                            </ul>
                        </div>
                    </li>
                    
					<li class="menu2"></li>
                    
                    <li class="menu"><a href="/pages/technology/technology01.asp?pagenum1=3&pagenum2=1" id="top1m3" onmouseover="choice(3);" onfocus="choice(3);"><img src="/images/common/gnb_topmenu03_off.gif"  alt="기술정보" name="q3"></a>
					 	<div class="topSub" id="gnbSub3" style="display:none;">
                            <ul id="top2m3">
                                <li><a href="/pages/technology/technology01.asp?pagenum1=3&pagenum2=1">보유기술</a></li>
                                <li><a href="/pages/technology/technology02.asp?pagenum1=3&pagenum2=2">인증서</a></li>
                                					
                            </ul>
                        </div>
                    </li>
					
					<li class="menu2"></li>
                    
                    <li class="menu"><a href="/pages/board/board01.asp?pagenum1=4&pagenum2=1" id="top1m4" onmouseover="choice(4);" onfocus="choice(4);"><img src="/images/common/gnb_topmenu04_off.gif"  alt="커뮤니티" name="q4"></a>
					 	<div class="topSub05" id="gnbSub4" style="display:none;">
                            <ul id="top2m4">
                                <li><a href="/pages/board/board01.asp?pagenum1=4&pagenum2=1">공지사항</a></li>
								<li><a href="/pages/board/board02.asp?pagenum1=4&pagenum2=2">Q&amp;A</a></li>
                                					
                            </ul>
                        </div>
                    </li>
			
              </ul>
          </div>
