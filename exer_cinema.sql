USE CinemaPractice; 
GO

-- BT1:
SELECT CR.MaCum, CR.TenCum
FROM CumRap CR 
INNER JOIN Rap R 
ON CR.MaCum = R.MaCum
INNER JOIN RapGhe RG 
ON RG.MaRap = R.MaRap
WHERE R.TongGhe BETWEEN 50 AND 150 OR RG.MaLoaiGhe = 'GGĐ';
GO

-- BT2: 
SELECT DISTINCT P.MaPhim, P.TenPhim, P.ThoiLuong
FROM Phim P
INNER JOIN KeHoach KH 
ON P.MaPhim = KH.MaPhim
INNER JOIN CumRap CR 
ON CR.MaCum = KH.MaCum
INNER JOIN PhimTheLoai PTL 
ON PTL.MaPhim = P.MaPhim
WHERE PTL.MaTheLoai = 'HH'
	AND CR.TenCum = 'Lotte Tân Phú Tân'
	AND EXISTS 
	(SELECT * 
	FROM PhimTheLoai PTL 
	WHERE P.MaPhim = PTL.MaPhim AND PTL.MaTheLoai = P.MaTheLoaiChinh);
GO

-- BT3: 
SELECT DISTINCT P.MaPhim, P.TenPhim, P.ThoiLuong
FROM Phim P 
INNER JOIN LichChieu LC 
ON LC.MaPhim = P.MaPhim
WHERE P.MaTheLoaiChinh = 'HH' AND LC.NgayChieu = '2016-01-15'
	AND NOT EXISTS 
	(SELECT * 
	FROM PhimTheLoai PTL 
	WHERE P.MaPhim = PTL.MaPhim AND PTL.MaTheLoai = P.MaTheLoaiChinh)
;
-- Việc có thêm NOT EXISTS là để làm đúng theo quy định của đề bài yêu cầu. Nên khác với bài 2 là bắt buộc nên phải dùng EXISTS. 
-- Nói chung, nếu xét theo thực tế thì 2 câu này xàm. Nhưng nếu xét theo về việc làm BT thì 2 câu này 'cũng được'
GO

-- BT4: 
SELECT DISTINCT P.MaPhim, P.TenPhim
FROM Phim P
INNER JOIN LichChieu LC
ON LC.MaPhim = P.MaPhim
INNER JOIN Rap R 
ON R.MaRap = LC.MaRap
INNER JOIN CumRap CR 
ON CR.MaCum = R.MaCum
INNER JOIN SuatChieu SC 
ON LC.ChuoiMaSuat LIKE '%' + SC.MaSuat + '%'
WHERE CR.TenCum = N'Lotte Tân Phú Tân' AND (SC.GioBatDau = 7 AND SC.PhutBatDau = 30);
GO

-- BT5: 
SELECT DISTINCT P.MaPhim, P.TenPhim
FROM Phim P
INNER JOIN LichChieu LC 
ON LC.MaPhim = P.MaPhim 
INNER JOIN Rap R 
ON LC.MaRap = R.MaRap
INNER JOIN CumRap CR 
ON CR.MaCum = R.MaCum
WHERE (LC.NgayChieu BETWEEN '2016-01-01' AND '2016-01-31') 
	AND CR.TenCum = N'Lotte Nhuận Bình';
GO

-- BT6:  
SELECT DISTINCT P.MaPhim, P.TenPhim
FROM Phim P
INNER JOIN LichChieu LC 
ON LC.MaPhim = P.MaPhim 
INNER JOIN Rap R 
ON LC.MaRap = R.MaRap
INNER JOIN SuatChieu SC 
ON LC.ChuoiMaSuat LIKE '%' + SC.MaSuat + '%'
WHERE (LC.NgayChieu BETWEEN '2016-01-01' AND '2016-01-31') AND R.MaCum = 'LNB' AND SC.GioBatDau < 12;
GO

-- BT7: 
SELECT DISTINCT TV.MaThanhVien, TV.TenThanhVien
FROM ThanhVien TV 
INNER JOIN Ve V 
ON TV.MaThanhVien = V.MaThanhVien
INNER JOIN Phim P
ON P.MaPhim = V.MaPhim
INNER JOIN LichChieu LC
ON LC.MaPhim = P.MaPhim
INNER JOIN SuatChieu SC 
ON LC.ChuoiMaSuat LIKE '%' + SC.MaSuat + '%'
INNER JOIN Rap R 
ON R.MaRap = LC.MaRap
INNER JOIN CumRap CR 
ON CR.MaCum = R.MaCum
WHERE P.TenPhim = N'Vấn Điệp' AND SC.GioBatDau > 19 AND CR.TenCum = N'Lotte Nam Sài';
GO

-- BT8:
SELECT DISTINCT CR.MaCum, CR.TenCum
FROM CumRap CR
WHERE NOT EXISTS (
	SELECT *
	FROM Phim P 
	INNER JOIN KeHoach KH 
	ON KH.MaCum = CR.MaCum
	WHERE KH.MaPhim = P.MaPhim
		AND P.TenPhim = N'Tôi không thấy hoa vàng'
);
GO

-- BT9: 
SELECT DISTINCT SC.MaSuat
	 , CAST (SC.GioBatDau AS VARCHAR(10)) + ' GIO' AS GIOCHIEU
	 , CAST (SC.PhutBatDau AS VARCHAR(10)) + ' PHUT' AS PHUTCHIEU
FROM LichChieu LC 
INNER JOIN Phim P
ON LC.MaPhim = P.MaPhim
INNER JOIN SuatChieu SC
ON LC.ChuoiMaSuat LIKE '%' + SC.MaSuat + '%'
INNER JOIN Rap R
ON LC.MaRap = R.MaRap
WHERE P.TenPhim = N'Em là bà ngoại của anh' AND R.MaCum = 'LNB'
	AND NOT EXISTS(
		SELECT *
		FROM Ve V
		WHERE V.MaPhim = P.MaPhim 
			AND V.MaSuat = SC.MaSuat
			AND V.MaRap = R.MaRap
	)
;
GO

-- BT10: 
-- 1: Nữ;  0: Nam
CREATE FUNCTION fn_TINH_TUOI_TV(@NAMSINH INT, @NAMHIENTAI_INPUT INT)
RETURNS INT 
AS 
BEGIN 
	DECLARE @TUOI INT; 
	SELECT @TUOI = @NAMHIENTAI_INPUT - @NAMSINH;
	RETURN @TUOI
END;
GO

SELECT Q.MaQuan, Q.TenQuan
FROM Quan Q
WHERE NOT EXISTS (
	SELECT *
	FROM ThanhVien TV
	WHERE TV.MaQuan = Q.MaQuan AND TV.GioiTinh = 1 AND dbo.fn_TINH_TUOI_TV(TV.NamSinh, 2016) > 45
);

-- Có thể dùng DATEDIFF(year, begin_date, end_date) > 45 với begin_date là năm sinh còn end_date là năm input