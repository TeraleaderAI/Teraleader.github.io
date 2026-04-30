<!-- #include file = "../../../../Include/BoardIncludeListImage.asp" -->
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<% IF READ_COUNT = 0 AND CONF_bitImgLightbox = False THEN %>
	<tr>
		<td height="30"><% IF bitViewImageAll = "False" THEN %><a href="javascript:OnBoardGalleryImg('True');"><img src="<%=skinPath%>images/btn_total_imgview.gif" width="85" height="21" border="0"></a><% ELSE %><a href="javascript:OnBoardGalleryImg('False');"><img src="<%=skinPath%>images/btn_default_imgview.gif" width="85" height="21" border="0"></a><% END IF %></td>
	</tr>
<% END IF %>
<% IF bitViewImageAll = "False" THEN %>
  <tr>
    <td class="pdt5 pdb5">
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