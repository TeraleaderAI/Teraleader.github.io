<table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="192"><img src="images/logo.gif" width="153" height="27"></td>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="5"><img src="images/top_m_left.gif" width="5" height="37"></td>
                      <td background="images/top_m_bg.gif">
                        <table width="589" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="107" align="center" valign="bottom"><img src="images/m_1_over.gif" width="82" height="31"></td>
                            <td valign="bottom"><img src="images/m_2_off.gif" width="109" height="31"></td>
                            <td><img src="images/m_line.gif" width="7" height="37"></td>
                            <td valign="bottom"><img src="images/m_3_off.gif" width="101" height="31"></td>
                            <td><img src="images/m_line.gif" width="7" height="37"></td>
                            <td valign="bottom"><img src="images/m_4_off.gif" width="119" height="31"></td>
                            <td><img src="images/m_line.gif" width="7" height="37"></td>
                            <td valign="bottom"><img src="images/m_5_off.gif" width="125" height="31"></td>
                          </tr>
                        </table>
                      </td>
                      <td width="5"><img src="images/top_m_right.gif" width="5" height="37"></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="5"><img src="images/top_search_left.gif" width="5" height="34"></td>
                      <td align="right" background="images/top_search_bg.gif">
                        <table width="330" border="0" cellspacing="0" cellpadding="0">
													<form name="theSearch" method="post" action="Search/SearchResult.asp" onSubmit="return OnSearchCheck();">
													<input type="hidden" name="intSearchType1" value="0">
													<input type="hidden" name="intSearchType2" value="0">
													<input type="hidden" name="intSearchType3" value="1">
													<input type="hidden" name="intSearchType4" value="0">
                          <tr>
                            <td>
                              <input name="searchWord" type="text" id="searchWord" size="40">
                            </td>
                            <td width="50"><input type="image" name="imageField" src="images/btn_search.gif" /></td>
                          </tr>
													</form>
                        </table>
<script language="javascript">
	function OnSearchCheck(){
		str = document.theSearch.searchWord;
		if (str.value == ""){alert("검색단어를 입력해 주시기 바랍니다.");str.focus();return false;}
	}
</script>
                      </td>
                      <td width="5"><img src="images/top_search_right.gif" width="5" height="34"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>