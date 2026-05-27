<!--#include virtual="/include/dbconnect.asp"-->
<!--#include virtual="/include/Function.asp"-->
<!--#include virtual="/include/top.asp"-->

<%
	'************************************************************************************************
	'	최근 게시물을 클릭했을 시 게시물 내용을 보여주기
	'	iframe에 src="about:blank"를 하던가 없애준다
	'	strBoardID 쿼리가 없을 수 있으므로 각 페이지에 맞게 strBoardID 를 지정해준다.
	'*************************************************************************************************
	Dim strIntSeq, strMmode
	strIntSeq = Request("intSeq")
	strMmode = Request("mmode")
	strBoardID = Request("strBoardID")
	If strBoardID = "" Then
		strBoardID = "notice"	'쿼리에서 strBoardID 가 없을 시를 대비하여 strBoardID 를 직접 지정해 준다.
	End If
%>
<!-- 최근 게시물 내용 보여주기를 위한 설정 끝 -->



	<!-- gnb : end -->
	<div id="topVisual"><img src="/images/board/sup_top.jpg"></div>
		</div>

    <div id="container">
    	<div id="leftArea">
        	<!-- lnb : str -->
        	<div id="lnb">
            	<h2><img src="../../images/board/h2_introduction.gif" alt="커뮤니티"/></h2>
          		<!--#include virtual="/include/left_board.asp"-->
            </div>

            <!-- lnb : end -->
        </div>
        <div id="midArea">
            <!-- contentsArea : str -->
            <div id="contentsArea">
            	<div class="pageHis">
    	    		<ul>
                    	<li> 현재위치 : 홈 > 커뮤니티 > 공지사항</li>
                    </ul>
                </div>
  				<div class="ptitArea">
                	<h3><img src="../../images/board/pagetitle1-1.gif" alt="공지사항"/></h3>
              </div>
                <!-- contents : str -->
                <div class="contents">

							<!-- 내용 -->
				
					
	  			<!--게시판시작-->
				<%
					If strMmode = "view" Then
				%>
				<iframe src = "/artyboard/mboard.asp?Action=view&strBoardID=<%=strBoardID%>&intPage=1&intCategory=0&strSearchCategory=|s_name|s_subject|&strSearchWord=&intSeq=<%=strIntSeq%>" id="ifrm" class="autoHeight" frameborder="0" framespacing=0 marginwidth=0 marginheight=0 width=100% scrolling="no" allowtransparency title="공지사항DB리스트"></iframe>
				<%
					Else
				%>
				<iframe src = "/artyboard/mboard.asp?strBoardID=<%=strBoardID%>" id="ifrm" class="autoHeight" frameborder="0" framespacing=0 marginwidth=0 marginheight=0 width=100% scrolling="no" allowtransparency title="공지사항DB리스트"></iframe>
				<%
					End If
				%>
				
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
    	      <dt><img src="../../images/common/footer_logo.GIF" alt="학과로고"></dt>
		  <dd class="no3"><img src="../../images/common/down_add.gif" alt="충남 아산시 탕정면 선문로 221번지 70 선문대학교 인문관201호 전화 041)530-2491"></dd>
          <dd class="no4"><img src="../../images/common/footer_copyright.GIF" alt="copyright (c)2012 SUN MOON University all rights reserved"></dd>
            </dl>
      </div>
        <!-- footerArea : end -->
    </div>
</div>
</body>
</html>
