<!--#include virtual="/include/dbconnect.asp"-->
<!--#include virtual="/include/Function.asp"-->
<!--#include virtual="/include/top.asp"-->
	<!-- gnb : end -->
	<div id="topVisual"><img src="/images/board/sup_top.jpg" ></div>
		</div>

    <div id="container">
    	<div id="leftArea">
        	<!-- lnb : str -->
        	<div id="lnb">
            	<h2><img src="../../images/board/h2_introduction.gif" alt="커뮤니티" ></h2>
          		<!--#include virtual="/include/left_board.asp"-->
            </div>
				<!--div class="baner02">
		 		<ul >
		 			<li><a href=""><img src="/images/common/leftbanericon01.gif" alt="보건소이용시간 평일:09:00~18:00"></a></li>
					
				</ul>  
				</div-->
            <!-- lnb : end -->
        </div>
        <div id="midArea">
            <!-- contentsArea : str -->
            <div id="contentsArea">
            	<div class="pageHis">
    	    		<ul>
                    	<li> 현재위치 : 홈 > 커뮤니티 > Q&amp;A</li>
                    </ul>
                </div>
  				<div class="ptitArea">
                	<h3><img src="../../images/board/pagetitle1-2.gif" alt="질의응답" ></h3>
              </div>
                <!-- contents : str -->
                <div class="contents">

							<!-- 내용 -->
				
					<!--게시판시작-->
									<script>
									function do_resize() {
										resizeFrame("ifrm",1);
									}

									function resizeFrame(ifr_id,re){
										//가로길이는 유동적인 경우가 드물기 때문에 주석처리!
										var ifr= document.getElementById(ifr_id) ;
										var innerBody = ifr.contentWindow.document.body;
										var innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight);
										//var innerWidth = document.body.scrollWidth + (document.body.offsetWidth - document.body.clientWidth);

										if (ifr.style.height != innerHeight) //주석제거시 다음 구문으로 교체 -> if (ifr.style.height != innerHeight || ifr.style.width != innerWidth)
										{
											ifr.style.height = innerHeight;
											//ifr.style.width = innerWidth;
										}

										if(!re) {
											try{
												innerBody.attachEvent('onclick',parent.do_resize);
												innerBody.attachEvent('onkeyup',parent.do_resize);
												//글작성 상황에서 클릭없이 타이핑하면서 창이 늘어나는 상황이면 윗줄 주석제거
											} catch(e) {
												//innerBody.addEventListener("click", parent.do_resize, false);
												//innerBody.addEventListener("keyup", parent.do_resize, false);
												//글작성 상황에서 클릭없이 타이핑하면서 창이 늘어나는 상황이면 윗줄 주석제거
											}
										}
									}
									</script>

									<iframe src="/ArtyBoard/mboard.asp?strBoardID=qanda" id=ifrm frameborder="0" framespacing=0 marginwidth=0 marginheight=0 width=100% height=100% scrolling="no" allowTransparency onload="resizeFrame(this.id,false);"></iframe>
									<!--게시판끝-->
				<!-- 내용 끝 -->
                </div>
                <!-- contents : end -->
            </div>
            <!-- contentsArea : end -->
        </div>
    </div>
    </div>
    <div id="footer">
    	<!-- footerArea : str -->
    	<div class="footerArea">
        	<dl>
    	      <dt><img src="../../images/common/footer_logo.GIF" alt="학과로고"/></dt>
		  <dd class="no3"><img src="../../images/common/down_add.gif" alt="충남 아산시 탕정면 선문로 221번지 70 선문대학교 인문관201호 전화 041)530-2491"></dd>
          <dd class="no4"><img src="../../images/common/footer_copyright.GIF" alt="copyright (c)2012 SUN MOON University all rights reserved"></dd>
            </dl>
      </div>
        <!-- footerArea : end -->
    </div>
</div>
</body>
</html>
