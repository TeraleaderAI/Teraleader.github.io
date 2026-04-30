<!-- #include file = "../../../../Include/BoardIncludeListImage.asp" -->
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<% IF READ_COUNT = 0 AND CONF_bitImgLightbox = False THEN %>
	<tr>
		<td height="20"><% IF bitViewImageAll = "False" THEN %>
		<img src="<%=skinPath%>images/ico_all_img.gif" width="15" height="13" align="absmiddle" /> <a href="javascript:OnBoardGalleryImg('True');">전체 이미지 보기</a>
		<% ELSE %>
		<img src="<%=skinPath%>images/ico_default_img.gif" width="15" height="13" align="absmiddle" /> <a href="javascript:OnBoardGalleryImg('False');">기본 이미지 보기</a>
		<% END IF %></td>
	</tr>
<% END IF %>
<% IF bitViewImageAll = "False" THEN %>
  <tr>
    <td style="padding-top:5px; padding-bottom:5px;">
<%
	intThrumListCount = 10

	FOR I = 1 TO READ_intFileCount
		IF FILE_REDIM_FileType(I) = "0" THEN
			IF (I mod intThrumListCount) = 1 AND I <> 1 THEN RESPONSE.WRITE "<br>"
			IF CONF_bitThrum = False THEN
				RESPONSE.WRITE "<a href=""" & FILE_REDIM_ImageSmallLink(I) & """><img src=Pds/Board/" & strBoardID & "/" & FILE_REDIM_FileName(I) & " WIDTH=50 HEIGHT=40 style='border-width:1px;border-color:#000000;border-style:solid'></a>&nbsp;&nbsp;"
			ELSE
				RESPONSE.WRITE "<a href=""" & FILE_REDIM_ImageSmallLink(I) & """><img src=Pds/Board/" & strBoardID & "/Small/" & FILE_REDIM_FileName(I) & " WIDTH=50 HEIGHT=40 style='border-width:1px;border-color:#000000;border-style:solid'></a>&nbsp;&nbsp;"
			END IF
		END IF
	NEXT
%>
		</td>
  </tr>
  <tr>
    <td align="center" class="pda5"><a href="<%=FILE_REDIM_ImageZoomLink(1)%>"><img name="galleryIMG_<%=intSeq%>" src="Pds/Board/<%=strBoardID%>/<%=FILE_REDIM_FileName(1)%>" WIDTH="<%=FILE_REDIM_ImageWidth(1)%>" HEIGHT="<%=FILE_REDIM_ImageHeight(1)%>" style="border-width:1px;border-color:#000000;border-style:solid"></a></td>
  </tr>
<% ELSE %>
<% FOR I = 1 TO READ_intFileCount %>
<% IF FILE_REDIM_FileType(I) = "0" THEN %>
	<tr>
		<td align="center" class="pda5"><a href="<%=FILE_REDIM_ImageZoomLink(I)%>"<% IF CONF_bitImgLightbox = True THEN %> class="imageUtil" id="thumb_<%=I%>" onclick="return hs.run(this)"<% END IF %>><img class=chimg_photo" id="image_<%=I%> name="galleryIMG_<%=intSeq%>" src="Pds/Board/<%=strBoardID%>/<%=FILE_REDIM_FileName(I)%>" WIDTH="<%=FILE_REDIM_ImageWidth(I)%>" HEIGHT="<%=FILE_REDIM_ImageHeight(I)%>" style="border-width:1px; border-color:#000000;border-style:solid;" onload="addCaption(this)"></a></td>
	</tr>
<% END IF %>
<% NEXT %>
<% END IF %>
</table>