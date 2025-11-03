import sys
from lxml import etree

XML_FILE = "music_db.xml"

# Nạp (parse) file XML
# CHÚ Ý: Nếu file 'music_db.xml' không tồn tại hoặc bị lỗi cú pháp (như </baimat>),
# chương trình sẽ dừng (crash) ngay tại dòng này.
tree = etree.parse(XML_FILE)

print(f"--- Đã nạp thành công file: {XML_FILE} ---\n")

# 1. Lấy tất cả nghệ sĩ
nghesis = tree.xpath("/database/nghesis/nghesi")
print(f"1. Tổng số nghệ sĩ: {len(nghesis)}")

# 2. Lấy tất cả bài hát
baihats = tree.xpath("/database/baihats/baihat")
print(f"2. Tổng số bài hát: {len(baihats)}")

# 3. Lấy email của người dùng có nguoidung_id = '3'
email_nd3 = tree.xpath("/database/nguoidungs/nguoidung[nguoidung_id='3']/email/text()")
print(f"3. Email của người dùng ID 3: {email_nd3}")

# 4. Lấy tên và thời lượng của bài hát có baihat_id = '7'
ten_bh7 = tree.xpath("/database/baihats/baihat[baihat_id='7']/tieu_de/text()")
thoiluong_bh7 = tree.xpath("/database/baihats/baihat[baihat_id='7']/thoi_luong/text()")
print(f"4. Bài hát ID 7: {list(zip(ten_bh7, thoiluong_bh7))}")

# 5. Lấy tiêu đề bài hát có thời lượng (thoi_luong) > 240 giây
ten_baihat_dai = tree.xpath("/database/baihats/baihat[thoi_luong > 240]/tieu_de/text()")
print(f"5. Bài hát có thời lượng > 240s: {ten_baihat_dai}")

# 6. Lấy tên thể loại của bài hát 'Trốn Tìm'
theloai_trontim = tree.xpath("/database/theloais/theloai[theloai_id = /database/baihats/baihat[tieu_de='Trốn Tìm']/theloai_id]/ten_theloai/text()")
print(f"6. Thể loại của bài 'Trốn Tìm': {theloai_trontim}")

# 7. Lấy tên album của bài hát 'Em Gì Ơi'
album_emgioi = tree.xpath("/database/albums/album[album_id = /database/baihats/baihat[tieu_de='Em Gì Ơi']/album_id]/ten_album/text()")
print(f"7. Album của bài 'Em Gì Ơi': {album_emgioi}")

# 8. Đếm số album phát hành năm 2019
count_album_2019 = int(tree.xpath("count(/database/albums/album[starts-with(ngay_phat_hanh, '2019')])"))
print(f"8. Số album phát hành năm 2019: {count_album_2019}")

# 9. Lấy tất cả bài hát (toàn bộ node) thuộc thể loại 'Nhạc Trẻ' (theloai_id='1')
baihat_nhactre = tree.xpath("/database/baihats/baihat[theloai_id = /database/theloais/theloai[ten_theloai='Nhạc Trẻ']/theloai_id]")
print(f"9. Số bài hát 'Nhạc Trẻ': {len(baihat_nhactre)}")

# 10. Lấy tên nghệ sĩ và tiểu sử của 'Sơn Tùng M-TP'
info_sontung = tree.xpath("concat(/database/nghesis/nghesi[ten_nghesi='Sơn Tùng M-TP']/ten_nghesi, ' - Tóm tắt: ', /database/nghesis/nghesi[ten_nghesi='Sơn Tùng M-TP']/tieu_su)")
print(f"10. Thông tin Sơn Tùng M-TP: {info_sontung}")