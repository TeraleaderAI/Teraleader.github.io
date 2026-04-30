<%
	DIM intTopMenu, intLeftMenu, isAdminMenu, isAdminPopup, strAdminPrevUrl
	intTopMenu  = 7
	intLeftMenu = 2
	isAdminMenu = 2
	isAdminPopup= False
%>
<!-- #include file = "Head.asp" -->
						<table width="750" border="0" cellspacing="0" cellpadding="0">
							<form name="theForm" method="post" action="DbInsertMember_ok.asp" onSubmit="return OnSubmitAction();" enctype="multipart/form-data">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="35"><img src="../images/main_title52.gif" width="95" height="19"></td>
                      <td align="right">관리자 홈 &gt; DB 관리 &gt; <b>회원DB등록</b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>MS-SQL DB 정보</strong></span></td>
              </tr>
							<tr>
								<td height="3" bgcolor="#CCCCCC"></td>
							</tr>
              <tr>
                <td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="table_Left1">샘플파일 다운로드</td>
											<td class="table_Right1"><a href="../images/memberSample.xls"><img src="../images/btn_sample_w.gif" width="118" height="19" border="0" /></a></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
										<tr>
											<td class="table_Left1">회원 EXCEL 파일 올리기 </td>
											<td class="table_Right1"><input name="strFileName" type="file" class="input" id="strFileName" size="40"></td>
										</tr>
										<tr>
											<td colspan="2" height="1" bgcolor="#EFEFEF"></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							<tr>
								<td align="right" style="padding-right:20;"><input type="image" name="imageField" src="../images/btn_submit_m.gif" class="no_Line"></td>
							</tr>
              <tr>
                <td height="30"><img src="../images/stit_icon.gif" width="6" height="11"> <span style="font-size:14px"><strong>회원DB 필드정보</strong></span></td>
              </tr>
              <tr>
                <td>
<style>
	#field_table { border-collapse:collapse; }
	#field_table th { padding:4; }
	#field_table td { border-style:solid;border-width:1;border-color:#EBEBEB;color:#4c4c4c;padding:4; }
	#field_table i { color:green; font:8pt dotum; }
</style>
									<table id="field_table" width="100%">
										<tr bgcolor="#eeeeee">
											<th><font class="small1" color="#444444"><b>항목 타이틀</b></font></th>
											<th><font class="small1" color="#444444"><b>컬럼명</b></font></th>
											<th>타입</th>
											<th>길이</th>
											<th><font class="small1" color="#444444"><b>설명</b></font></th>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#F6F6DF"><font class="small1" color="#444444">일련번호</font></td>
											<td bgcolor="#F6F6DF"><font class="ver8" color="#444444">intNum</font></td>
											<td align="center" bgcolor="#F6F6DF"><font class="small1" color="#444444">int</font></td>
											<td align="center" bgcolor="#F6F6DF"><font class="small1" color="#444444">10</font></td>
											<td bgcolor="#F6F6DF"><font class="small" color="#444444">일련번호 형식의 숫자. 중복 불가</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#F6F6DF"><font class="small1" color="#444444">회원 아이디</font></td>
											<td bgcolor="#F6F6DF"><font class="ver8" color="#444444">strLoginID</font></td>
											<td align="center" bgcolor="#F6F6DF"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#F6F6DF"><font class="small1" color="#444444">20</font></td>
											<td bgcolor="#F6F6DF"><font class="small" color="#444444">영문만 입력. 중복 불가</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#F6F6DF"><font class="small1" color="#444444">회원그룹</font></td>
											<td bgcolor="#F6F6DF"><font class="ver8" color="#444444">strGroup</font></td>
											<td align="center" bgcolor="#F6F6DF"><font class="small1" color="#444444">char</font></td>
											<td align="center" bgcolor="#F6F6DF"><font class="small1" color="#444444">4</font></td>
											<td bgcolor="#F6F6DF"><font class="small" color="#444444">4자리 그룹코드. 생성된 그룹코드 등록</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#F6F6DF"><font class="small1" color="#444444">비밀번호</font></td>
											<td bgcolor="#F6F6DF"><font class="ver8" color="#444444">strLoginPwd</font></td>
											<td align="center" bgcolor="#F6F6DF"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#F6F6DF"><font class="small1" color="#444444">20</font></td>
											<td bgcolor="#F6F6DF"><font class="small" color="#444444">20자 이내</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#F6F6DF"><font class="small1" color="#444444">회원 이름</font></td>
											<td bgcolor="#F6F6DF"><font class="ver8" color="#444444">strLoginName</font></td>
											<td align="center" bgcolor="#F6F6DF"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#F6F6DF"><font class="small1" color="#444444">20</font></td>
											<td bgcolor="#F6F6DF"><font class="small" color="#444444">한글 및 영문. 20자 이내</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#F6F6DF"><font class="small1" color="#444444">메일주소</font></td>
											<td bgcolor="#F6F6DF"><font class="ver8" color="#444444">strEmail</font></td>
											<td align="center" bgcolor="#F6F6DF"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#F6F6DF"><font class="small1" color="#444444">64</font></td>
											<td bgcolor="#F6F6DF"><font class="small" color="#444444">메일주소. 중복불가</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#F6F6DF"><font class="small1" color="#444444">메일수신</font></td>
											<td bgcolor="#F6F6DF"><font class="ver8" color="#444444">bitMailing</font></td>
											<td align="center" bgcolor="#F6F6DF"><font class="small1" color="#444444">bit</font></td>
											<td align="center" bgcolor="#F6F6DF"><font class="small1" color="#444444">1</font></td>
											<td bgcolor="#F6F6DF"><font class="small" color="#444444">수신 : 1, 미수신 : 0</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">주민등록번호</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strSSN</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">13</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">13자리의 주민등록번호, - 제외</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">생년월일</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strBirthday</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">9</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">년도/월/일/양,음, 9자리로 맞춤, 음력 : 1, 양력 : 0</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">별명</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strNick</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">20</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">20자 이내로 입력</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">ICQ 번호</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strIcq</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">32</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">32자 이내로 입력</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">MSN 주소</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strMsn</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">64</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">메일 주소 형태의 MSN 주소</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">홈페이지주소</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strHomepage</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">64</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">64자 이내로 입력</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">자택 우편번호</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strHomePost</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">char</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">6</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">6자로 등록, - 제외</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">자택 기본주소</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strHomeAddr1</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">64</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">우편번호 DB에서 등록된 기본주소</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">자택 세부주소</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strHomeAddr2</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">64</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">사용자가 입력한 세부주소</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">자택 전화번호</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strHomeTe</font>l</td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">14</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">14자 이내, -로 구분지어 입력</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">휴대폰번호</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strMobile</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">13</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">13자 이내, -로 구분지어 입력</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">회사 우편번호</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strCompPost</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">char</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">6</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">6자로 등록, - 제외</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">회사 기본주소</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strCompAddr1</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">64</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">우편번호 DB에서 등록된 기본주소</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">회사 세부주소</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strCompAddr2</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">64</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">사용자가 입력한 세부주소</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">회사 전화번호</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strCompTel</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">14</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">14자 이내, -로 구분지어 입력</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">직업</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strJob</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">32</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">32자 이내, 회원가입 항목에 설정한 내용과 동일</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">직급</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strJobLevel</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">32</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">32자 이내, 회원가입 항목에 설정한 내용과 동일</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">취미</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strHobby</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">32</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">32자 이내</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">결혼정보</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strMarry</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">9</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">년도/월/일/양,음, 9자리로 맞춤, 기혼 : 1, 미혼 : 0</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">가입동기</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strJoinMemo</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">32</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">32자 이내, 회원가입 항목에 설정한 내용과 동일</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">사진파일</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strPhotoFile</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">64</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">사진 파일이름</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">이름이미지 파일</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strNameFile</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">64</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">이름 이미지 파일 이름</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">자기소개</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strMemo</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">text</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">-</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">자기소개</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">개인정보 공개</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">bitUserInfo</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">bit</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">1</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">0 : 개인정보 미공개, 1 : 개인정보 공개</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">추천인 아이디</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strRecLoginID</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">20</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">등록된 회원 아이디 입력, 20자 이내</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">회원추가 정보1</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strMemberAdd1</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">text</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">-</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">회원가입 추가 항목</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">회원추가 정보2</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strMemberAdd2</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">text</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">-</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">회원가입 추가 항목</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">회원추가 정보3</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strMemberAdd3</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">text</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">-</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">회원가입 추가 항목</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">회원추가 정보4</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strMemberAdd4</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">text</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">-</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">회원가입 추가 항목</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">회원추가 정보5</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strMemberAdd5</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">text</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">-</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">회원가입 추가 항목</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">회원추가 정보6</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strMemberAdd6</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">text</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">-</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">회원가입 추가 항목</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">회원추가 정보7</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strMemberAdd7</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">text</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">-</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">회원가입 추가 항목</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">회원추가 정보8</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strMemberAdd8</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">text</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">-</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">회원가입 추가 항목</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">회원추가 정보9</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strMemberAdd9</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">text</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">-</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">회원가입 추가 항목</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">회원추가 정보10</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strMemberAdd10</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">text</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">-</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">회원가입 추가 항목</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">가입승인</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">bitAuth</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">bit</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">1</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">승인 : 1, 미승인 : 0</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">방문수</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">intVisit</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">int</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">10</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">방문수를 숫자로만 입력</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">포인트</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">intPoint</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">smallmoney</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">6</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">포인트를 숫자로만 입력</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">게시글 등록수</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">intBoardCount</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">smallint</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">5</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">게시글 등록수를 숫자로만 입력</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">댓글 등록수</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">intCommentCount</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">smallint</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">5</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">댓글 등록수를 숫자로만 입력</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">추천수</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">intVote</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">smallint</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">5</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">추천 받은 회수를 숫자로만 입력</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">관리자 유무</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strAdmin</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">char</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">1</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">2 : 전체관리자, 0 : 일반회원 (전체 관리자는 1명)</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">최근 방문일</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">dateSignDate</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">smalldatetime</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">-</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">날짜 형태 : 년도-월-일 시간:분:00 (2005-12-26 17:48:00)</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">최근 방문 IP</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strSignIP</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">15</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">최근 접속한 IP 주소</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">거주지역</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strSido</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">varchar</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">20</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">통계를 위한 거주지역, 예) 서울, 경기</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">탈퇴유무</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">bitSecession</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">bit</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">1</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">1 : 탈퇴회원, 0 : 정상회원</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">탈퇴사유</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">strSecessionMemo</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">text</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">-</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">회원 탈퇴시 탈퇴사유</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">탈퇴일자</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">dateSecessionDate</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">smalldatetime</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">-</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">날짜 형태 : 년도-월-일 시간:분:00 (2005-12-26 17:48:00)</font></td>
										</tr>
										<tr bgcolor="#ffffff">
											<td bgcolor="#ffffff"><font class="small1" color="#444444">회원 가입일</font></td>
											<td bgcolor="#ffffff"><font class="ver8" color="#444444">dateRegDate</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">smalldatetime</font></td>
											<td align="center" bgcolor="#ffffff"><font class="small1" color="#444444">-</font></td>
											<td bgcolor="#ffffff"><font class="small" color="#444444">날짜 형태 : 년도-월-일 시간:분:00 (2005-12-26 17:48:00)</font></td>
										</tr>
									</table>
								</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							<tr>
								<td style="padding:10 10 10 10">
									<fieldset CLASS="infobox">
									<legend CLASS="infotitle">&nbsp;<img src="../images/check.gif" align="absmiddle">&nbsp;</legend>
									<table width="100%"  border="0" cellspacing="10" cellpadding="0">
										<tr>
											<td>
											<LI>각 컬럼에 정상적으로 데이타가 있어야 회원 DB 등록이 정상적으로 됩니다.</LI>
											<LI>DB 등록시 오류가 발생하기 전의 라인까지는 정상적으로 등록이 되므로, 재 등록시 [intNum] 번호를 확인 후 [intNum] 번호 보다 작은 항목은 삭제 하시고 등록하셔야 오류가 발생하지 않습니다.</LI>
											</td>
										</tr>
									</table>
									</fieldset>
								</td>
							</tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
							</form>
            </table>
<script language="javascript">

	function OnSubmitAction(){

		str = document.all['strFileName'];
		if (str.value == ""){
			alert("EXCEL 파일을 선택해 주시기 바랍니다.");
			str.focus();
			return false;
		}

	}

</script>
<!-- #include file = "Foot.asp" -->