<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Bài thực hành XSLT – Quản lý âm nhạc</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 30px; background: #fafafa; }
          h1 { text-align: center; color: #333; margin-bottom: 40px; }
          h2 { color: #0055aa; margin-top: 40px; border-bottom: 2px solid #0055aa; padding-bottom: 4px; }
          table { border-collapse: collapse; width: 100%; margin-top: 10px; }
          th, td { border: 1px solid #ccc; padding: 8px; }
          th { background-color: #0055aa; color: white; }
          tr:nth-child(even) { background-color: #f2f2f2; }
          .footer { text-align:center; color:#777; margin-top:40px; font-style:italic; }
        </style>
      </head>
      <body>
        <h1>🎶 BÀI THỰC HÀNH XSLT – QUẢN LÝ DANH SÁCH BÀI HÁT 🎶</h1>

        <!-- ========================== -->
        <!-- CÂU 1: NGƯỜI DÙNG -->
        <!-- ========================== -->
        <h2>Câu 1️⃣: Hiển thị người dùng được tạo gần đây nhất</h2>
          <table>
            <tr>
              <th>ID</th><th>Tên đăng nhập</th><th>Email</th><th>Ngày tạo</th>
            </tr>
            <xsl:for-each select="database/nguoidungs/nguoidung">
              <xsl:sort select="ngay_tao" order="descending"/>
              <xsl:if test="position() &lt;= 3">
                <tr>
                  <td><xsl:value-of select="nguoidung_id"/></td>
                  <td><xsl:value-of select="tendangnhap"/></td>
                  <td><xsl:value-of select="email"/></td>
                  <td><xsl:value-of select="ngay_tao"/></td>
                </tr>
              </xsl:if>
            </xsl:for-each>
          </table>


        <!-- ========================== -->
        <!-- CÂU 2: THỂ LOẠI -->
        <!-- ========================== -->
        <h2>Câu 2️⃣: Thống kê số lượng thể loại âm nhạc</h2>
          <p>Tổng số thể loại: 
            <strong><xsl:value-of select="count(database/theloais/theloai)"/></strong>
          </p>
          <ul>
            <xsl:for-each select="database/theloais/theloai">
              <li><xsl:value-of select="ten_theloai"/> – <xsl:value-of select="mo_ta"/></li>
            </xsl:for-each>
          </ul>


        <!-- ========================== -->
        <!-- CÂU 3: NGHỆ SĨ -->
        <!-- ========================== -->
        <h2>Câu 3️⃣: Nghệ sĩ Việt Nam có nhiều bài hát</h2>
          <table>
            <tr><th>Tên nghệ sĩ</th><th>Số bài hát</th></tr>
            <xsl:for-each select="database/nghesis/nghesi[quoc_gia='Việt Nam']">
              <xsl:variable name="nid" select="nghesi_id"/>
              <xsl:variable name="soluong" select="count(/database/baihat_nghesis/baihat_nghesi[nghesi_id=$nid])"/>
              <xsl:if test="$soluong &gt; 1">
                <tr>
                  <td><xsl:value-of select="ten_nghesi"/></td>
                  <td><xsl:value-of select="$soluong"/></td>
                </tr>
              </xsl:if>
            </xsl:for-each>
          </table>


        <!-- ========================== -->
        <!-- CÂU 4: ALBUM -->
        <!-- ========================== -->
        <h2>Câu 4️⃣: Các album phát hành trước năm 2021</h2>
          <table>
            <tr><th>ID</th><th>Tên album</th><th>Ngày phát hành</th></tr>
            <xsl:for-each select="database/albums/album[substring(ngay_phat_hanh,1,4) &lt; 2021]">
              <tr>
                <td><xsl:value-of select="album_id"/></td>
                <td><xsl:value-of select="ten_album"/></td>
                <td><xsl:value-of select="ngay_phat_hanh"/></td>
              </tr>
            </xsl:for-each>
          </table>


        <!-- ========================== -->
        <!-- CÂU 5: BÀI HÁT -->
        <!-- ========================== -->
        <h2>Câu 5️⃣: Bài hát có thời lượng dài nhất</h2>
          <table>
            <tr>
              <th>Tên bài hát</th><th>Thời lượng</th><th>Thể loại</th><th>Album</th>
            </tr>
            <xsl:for-each select="database/baihats/baihat">
              <xsl:sort select="thoi_luong" data-type="number" order="descending"/>
              <xsl:if test="position()=1">
                <tr>
                  <td><xsl:value-of select="tieu_de"/></td>
                  <td><xsl:value-of select="thoi_luong"/></td>
                  <td><xsl:value-of select="/database/theloais/theloai[theloai_id=current()/theloai_id]/ten_theloai"/></td>
                  <td><xsl:value-of select="/database/albums/album[album_id=current()/album_id]/ten_album"/></td>
                </tr>
              </xsl:if>
            </xsl:for-each>
          </table>


        <div class="footer">© 2025 - Bài thực hành XSLT: Quản lý danh sách bài hát</div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
