/* =========================================================
   DATABASE THỰC HÀNH
   SQL SERVER
   ========================================================= */


-- DỮ LIỆU, bảng database và chế dữ liệu đều được tạo ra nhờ: ChatGPT
-- Có thể tạo database riêng nếu muốn:
CREATE DATABASE CinemaPractice;
GO
USE CinemaPractice;
GO


/* =========================================================
   1. TẠO BẢNG
   ========================================================= */

CREATE TABLE CumRap
(
    MaCum VARCHAR(5) PRIMARY KEY,
    TenCum NVARCHAR(50),
    DiaChi NVARCHAR(100)
);

CREATE TABLE Rap
(
    MaRap VARCHAR(5) PRIMARY KEY,
    TongGhe INT,
    MaCum VARCHAR(5),

    CONSTRAINT FK_Rap_CumRap
        FOREIGN KEY (MaCum)
        REFERENCES CumRap(MaCum)
);

CREATE TABLE LoaiGhe
(
    MaLoaiGhe VARCHAR(5) PRIMARY KEY,
    TenLoaiGhe NVARCHAR(50),
    SLGhe INT
);

CREATE TABLE RapGhe
(
    MaRap VARCHAR(5),
    MaHang CHAR(1),
    SoGheBatDau INT,
    SoGheKetThuc INT,
    MaLoaiGhe VARCHAR(5),

    CONSTRAINT PK_RapGhe
        PRIMARY KEY (MaRap, MaHang, SoGheBatDau),

    CONSTRAINT FK_RapGhe_Rap
        FOREIGN KEY (MaRap)
        REFERENCES Rap(MaRap),

    CONSTRAINT FK_RapGhe_LoaiGhe
        FOREIGN KEY (MaLoaiGhe)
        REFERENCES LoaiGhe(MaLoaiGhe)
);

CREATE TABLE TheLoai
(
    MaTheLoai VARCHAR(5) PRIMARY KEY,
    TenTheLoai NVARCHAR(50)
);

CREATE TABLE Phim
(
    MaPhim VARCHAR(10) PRIMARY KEY,
    TenPhim NVARCHAR(50),
    MaTheLoaiChinh VARCHAR(5),
    ThoiLuong INT,
    CoLa3D BIT,
    CoLongTieng BIT,

    CONSTRAINT FK_Phim_TheLoai
        FOREIGN KEY (MaTheLoaiChinh)
        REFERENCES TheLoai(MaTheLoai)
);

CREATE TABLE PhimTheLoai
(
    MaPhim VARCHAR(10),
    MaTheLoai VARCHAR(5),

    CONSTRAINT PK_PhimTheLoai
        PRIMARY KEY (MaPhim, MaTheLoai),

    CONSTRAINT FK_PhimTheLoai_Phim
        FOREIGN KEY (MaPhim)
        REFERENCES Phim(MaPhim),

    CONSTRAINT FK_PhimTheLoai_TheLoai
        FOREIGN KEY (MaTheLoai)
        REFERENCES TheLoai(MaTheLoai)
);

CREATE TABLE KeHoach
(
    MaPhim VARCHAR(10),
    MaCum VARCHAR(5),
    NgayKhoiChieu DATE,
    NgayKetThuc DATE,
    GhiChu NVARCHAR(100),

    CONSTRAINT PK_KeHoach
        PRIMARY KEY (MaPhim, MaCum),

    CONSTRAINT FK_KeHoach_Phim
        FOREIGN KEY (MaPhim)
        REFERENCES Phim(MaPhim),

    CONSTRAINT FK_KeHoach_CumRap
        FOREIGN KEY (MaCum)
        REFERENCES CumRap(MaCum)
);

CREATE TABLE SuatChieu
(
    MaSuat VARCHAR(3) PRIMARY KEY,
    GioBatDau INT,
    PhutBatDau INT
);

CREATE TABLE LichChieu
(
    MaPhim VARCHAR(10),
    MaRap VARCHAR(5),
    NgayChieu DATE,
    ChuoiMaSuat NVARCHAR(100),

    CONSTRAINT PK_LichChieu
        PRIMARY KEY (MaPhim, MaRap, NgayChieu),

    CONSTRAINT FK_LichChieu_Phim
        FOREIGN KEY (MaPhim)
        REFERENCES Phim(MaPhim),

    CONSTRAINT FK_LichChieu_Rap
        FOREIGN KEY (MaRap)
        REFERENCES Rap(MaRap)
);

CREATE TABLE NgheNghiep
(
    MaNghe VARCHAR(5) PRIMARY KEY,
    TenNghe NVARCHAR(100)
);

CREATE TABLE ThanhPho
(
    MaThanhPho VARCHAR(5) PRIMARY KEY,
    TenThanhPho NVARCHAR(100)
);

CREATE TABLE Quan
(
    MaQuan VARCHAR(5) PRIMARY KEY,
    TenQuan NVARCHAR(100),
    MaThanhPho VARCHAR(5),

    CONSTRAINT FK_Quan_ThanhPho
        FOREIGN KEY (MaThanhPho)
        REFERENCES ThanhPho(MaThanhPho)
);

CREATE TABLE ThanhVien
(
    MaThanhVien VARCHAR(5) PRIMARY KEY,
    TenThanhVien NVARCHAR(50),
    NamSinh INT,
    GioiTinh BIT,
    MaQuan VARCHAR(5),
    MaNghe VARCHAR(5),

    CONSTRAINT FK_ThanhVien_Quan
        FOREIGN KEY (MaQuan)
        REFERENCES Quan(MaQuan),

    CONSTRAINT FK_ThanhVien_Nghe
        FOREIGN KEY (MaNghe)
        REFERENCES NgheNghiep(MaNghe)
);

CREATE TABLE BangGia
(
    MaLoaiGhe VARCHAR(5),
    MaSuat VARCHAR(3),
    NgayBatDau DATE,
    Gia FLOAT,
    GhiChu NVARCHAR(100),

    CONSTRAINT PK_BangGia
        PRIMARY KEY (MaLoaiGhe, MaSuat, NgayBatDau),

    CONSTRAINT FK_BangGia_LoaiGhe
        FOREIGN KEY (MaLoaiGhe)
        REFERENCES LoaiGhe(MaLoaiGhe),

    CONSTRAINT FK_BangGia_Suat
        FOREIGN KEY (MaSuat)
        REFERENCES SuatChieu(MaSuat)
);

CREATE TABLE Ve
(
    MaSoVe VARCHAR(20) PRIMARY KEY,
    MaPhim VARCHAR(10),
    MaRap VARCHAR(5),
    NgayChieu DATE,
    NgayMua DATE,
    MaSuat VARCHAR(3),
    MaHang CHAR(1),
    So INT,
    MaLoaiGhe VARCHAR(5),
    MaThanhVien VARCHAR(5),
    GiaGoc FLOAT,
    SoTienPhuThu FLOAT,
    SoTienGiam FLOAT,

    CONSTRAINT FK_Ve_Phim
        FOREIGN KEY (MaPhim)
        REFERENCES Phim(MaPhim),

    CONSTRAINT FK_Ve_Rap
        FOREIGN KEY (MaRap)
        REFERENCES Rap(MaRap),

    CONSTRAINT FK_Ve_Suat
        FOREIGN KEY (MaSuat)
        REFERENCES SuatChieu(MaSuat),

    CONSTRAINT FK_Ve_LoaiGhe
        FOREIGN KEY (MaLoaiGhe)
        REFERENCES LoaiGhe(MaLoaiGhe),

    CONSTRAINT FK_Ve_ThanhVien
        FOREIGN KEY (MaThanhVien)
        REFERENCES ThanhVien(MaThanhVien)
);

CREATE TABLE GiamGia
(
    MaGiam INT PRIMARY KEY,
    MaPhim VARCHAR(10),
    MaRap VARCHAR(5),
    Thu INT,
    Ngay DATE,
    MaSuat VARCHAR(3),
    MaLoaiGhe VARCHAR(5),
    NgayBatDauApDung DATE,
    LoaiHinhGiam INT,
    GiaMoi FLOAT,
    PhanTramGiam FLOAT,

    CONSTRAINT FK_GiamGia_Phim
        FOREIGN KEY (MaPhim)
        REFERENCES Phim(MaPhim),

    CONSTRAINT FK_GiamGia_Rap
        FOREIGN KEY (MaRap)
        REFERENCES Rap(MaRap),

    CONSTRAINT FK_GiamGia_Suat
        FOREIGN KEY (MaSuat)
        REFERENCES SuatChieu(MaSuat),

    CONSTRAINT FK_GiamGia_LoaiGhe
        FOREIGN KEY (MaLoaiGhe)
        REFERENCES LoaiGhe(MaLoaiGhe)
);

CREATE TABLE GiamGiaTheoNguoi
(
    MaGiam INT PRIMARY KEY,
    Tuoi INT,
    GioiTinh BIT,
    MaNghe NVARCHAR(5),
    NgayBatDauApDung DATE,
    LoaiHinhGiam INT,
    GiaMoi FLOAT,
    PhanTramGiam FLOAT
);


/* =========================================================
   2. DỮ LIỆU CỤM RẠP
   ========================================================= */

INSERT INTO CumRap
VALUES
('TPT', N'Lotte Tân Phú Tân', N'123 Tân Kỳ Tân Quý'),
('LNB', N'Lotte Nhuận Bình', N'45 Nguyễn Văn Trỗi'),
('LNS', N'Lotte Nam Sài', N'88 Nguyễn Hữu Thọ'),
('LBD', N'Lotte Bình Đông', N'20 Bình Đông'),
('LNT', N'Lotte Nguyễn Trãi', N'150 Nguyễn Trãi');


/* =========================================================
   3. DỮ LIỆU RẠP
   ========================================================= */

INSERT INTO Rap
VALUES
('R01', 80,  'TPT'),
('R02', 160, 'TPT'),
('R03', 120, 'LNB'),
('R04', 45,  'LNB'),
('R05', 100, 'LNS'),
('R06', 150, 'LNS'),
('R07', 200, 'LBD'),
('R08', 60,  'LNT');


/* =========================================================
   4. DỮ LIỆU LOẠI GHẾ
   ========================================================= */

INSERT INTO LoaiGhe
VALUES
('TC',  N'Ghế thường', 100),
('VIP', N'Ghế VIP', 50),
('GGĐ', N'Ghế đôi', 2),
('CPL', N'Ghế couple', 2);


/* =========================================================
   5. DỮ LIỆU RẠP - GHẾ
   ========================================================= */

INSERT INTO RapGhe
VALUES
('R01', 'A', 1, 20, 'TC'),
('R01', 'B', 1, 10, 'VIP'),

('R02', 'A', 1, 20, 'TC'),
('R02', 'B', 1, 10, 'VIP'),
('R02', 'C', 1, 5,  'GGĐ'),

('R03', 'A', 1, 20, 'TC'),
('R03', 'B', 1, 10, 'VIP'),

('R04', 'A', 1, 15, 'TC'),

('R05', 'A', 1, 20, 'TC'),
('R05', 'B', 1, 5, 'VIP'),

('R06', 'A', 1, 20, 'TC'),
('R06', 'B', 1, 10, 'GGĐ'),

('R07', 'A', 1, 30, 'TC'),

('R08', 'A', 1, 15, 'TC'),
('R08', 'B', 1, 5, 'VIP');


/* =========================================================
   6. THỂ LOẠI
   ========================================================= */

INSERT INTO TheLoai
VALUES
('HH',  N'Hài'),
('HD',  N'Hành động'),
('TL',  N'Tâm lý'),
('GD',  N'Gia đình'),
('ACT', N'Phiêu lưu'),
('HP',  N'Hoạt hình');


/* =========================================================
   7. PHIM
   ========================================================= */

INSERT INTO Phim
VALUES
('P001', N'Vấn Điệp',                    'HD', 110, 0, 0),
('P002', N'Hài Nhà Mình',                'HH', 100, 1, 0),
('P003', N'Em là bà ngoại của anh',      'HH', 127, 0, 0),
('P004', N'Tôi không thấy hoa vàng',     'HD', 100, 0, 0),
('P005', N'Cười Lên Nào',                'HD',  90, 0, 1),
('P006', N'Hành trình biển xanh',        'TL', 120, 1, 0),
('P007', N'Người vận chuyển',            'ACT',105, 1, 0),
('P008', N'Chuyện đêm mưa',              'TL',  95, 0, 1),
('P009', N'Gia đình là số 1',            'GD', 115, 0, 0);


/* =========================================================
   8. PHIM - THỂ LOẠI
   ========================================================= */

/*
P005 được cố ý tạo tình huống:
MaTheLoaiChinh = HD
nhưng PhimTheLoai lại có HH.
Điều này giúp bạn có dữ liệu để tự làm câu hỏi có
quy định đặc biệt về MaTheLoaiChinh.
*/

INSERT INTO PhimTheLoai
VALUES
('P001', 'HD'),
('P001', 'TL'),

('P002', 'HH'),
('P002', 'GD'),

('P003', 'HH'),
('P003', 'GD'),

('P004', 'HD'),
('P004', 'GD'),

('P005', 'HH'),
('P005', 'GD'),

('P006', 'TL'),
('P006', 'GD'),

('P007', 'ACT'),
('P007', 'HH'),

('P008', 'TL'),

('P009', 'GD'),
('P009', 'HH');


/* =========================================================
   9. KẾ HOẠCH CHIẾU
   ========================================================= */

INSERT INTO KeHoach
VALUES
('P001', 'LNS', '2016-01-10', '2016-01-31', N'Chiếu cuối tuần'),
('P001', 'LNT', '2016-01-15', '2016-01-30', N'Đợt 1'),

('P002', 'TPT', '2016-01-01', '2016-01-31', N'Phim hài tháng 1'),
('P002', 'LNB', '2016-01-05', '2016-01-25', N'Phát hành rộng'),

('P003', 'LNB', '2016-01-10', '2016-01-31', N'Phim tháng 1'),
('P003', 'TPT', '2016-01-12', '2016-01-25', N'Phát hành'),

('P004', 'LBD', '2016-01-01', '2016-01-20', N'Chiếu đặc biệt'),
('P005', 'LNB', '2016-01-15', '2016-01-25', N'Chiếu thử'),

('P006', 'LNS', '2016-01-01', '2016-01-31', N'Phim tâm lý'),
('P007', 'LNS', '2016-01-05', '2016-01-31', N'Phim hành động'),

('P008', 'LNT', '2016-01-01', '2016-01-20', N'Phim đặc biệt'),
('P009', 'TPT', '2016-01-01', '2016-01-31', N'Phim gia đình');


/* =========================================================
   10. SUẤT CHIẾU
   ========================================================= */

INSERT INTO SuatChieu
VALUES
('S01', 7,  30),
('S02', 9,  15),
('S03', 11, 30),
('S04', 13, 45),
('S05', 16, 0),
('S06', 18, 0),
('S07', 19, 30),
('S08', 21, 0),
('S09', 22, 15);


/* =========================================================
   11. LỊCH CHIẾU
   ========================================================= */

/*
ChuoiMaSuat = chuỗi các mã suất chiếu trong ngày.
*/

INSERT INTO LichChieu
VALUES

-- Tân Phú Tân
('P002', 'R01', '2016-01-05', N'S01,S04,S07'),
('P002', 'R01', '2016-01-15', N'S02,S05,S08'),
('P003', 'R02', '2016-01-15', N'S03,S06,S08'),
('P009', 'R02', '2016-01-20', N'S01,S04,S07'),

-- Nhuận Bình
('P002', 'R03', '2016-01-05', N'S02,S05,S07'),
('P003', 'R03', '2016-01-15', N'S02,S05,S07'),
('P005', 'R03', '2016-01-15', N'S03,S06'),
('P009', 'R04', '2016-01-20', N'S01,S03,S05'),

-- Nam Sài
('P001', 'R05', '2016-01-20', N'S04,S07,S08'),
('P001', 'R06', '2016-01-21', N'S06,S08'),
('P006', 'R05', '2016-01-18', N'S03,S06'),
('P007', 'R06', '2016-01-22', N'S05,S07'),

-- Bình Đông
('P004', 'R07', '2016-01-10', N'S02,S04,S08'),
('P004', 'R07', '2016-01-15', N'S03,S05'),

-- Nguyễn Trãi
('P001', 'R08', '2016-01-15', N'S01,S05,S07'),
('P003', 'R08', '2016-01-18', N'S02,S06'),
('P008', 'R08', '2016-01-12', N'S03,S07');


/* =========================================================
   12. NGHỀ NGHIỆP
   ========================================================= */

INSERT INTO NgheNghiep
VALUES
('SV', N'Sinh viên'),
('GV', N'Giảng viên'),
('NV', N'Nhân viên văn phòng'),
('KD', N'Kinh doanh'),
('IT', N'Công nghệ thông tin');


/* =========================================================
   13. THÀNH PHỐ
   ========================================================= */

INSERT INTO ThanhPho
VALUES
('HCM', N'Thành phố Hồ Chí Minh'),
('HN',  N'Hà Nội'),
('DN',  N'Đà Nẵng');


/* =========================================================
   14. QUẬN
   ========================================================= */

INSERT INTO Quan
VALUES
('Q01', N'Quận 1',       'HCM'),
('Q03', N'Quận 3',       'HCM'),
('QTP', N'Tân Phú',      'HCM'),
('QBT', N'Bình Thạnh',   'HCM'),
('QTB', N'Tân Bình',     'HCM'),
('QHD', N'Hải Châu',     'DN');


/* =========================================================
   15. THÀNH VIÊN
   ========================================================= */

/*
GioiTinh:
1 = Nữ
0 = Nam
*/

INSERT INTO ThanhVien
VALUES
('M001', N'An',       1998, 1, 'Q01', 'SV'),
('M002', N'Bình',     1970, 0, 'Q01', 'GV'),
('M003', N'Chi',      1955, 1, 'Q01', 'KD'),

('M004', N'Dũng',     1995, 0, 'Q03', 'SV'),
('M005', N'Hạnh',     1990, 1, 'Q03', 'NV'),
('M006', N'Khoa',     1982, 0, 'Q03', 'IT'),

('M007', N'Lan',      1960, 1, 'QTP', 'KD'),
('M008', N'Minh',     2000, 1, 'QBT', 'SV'),
('M009', N'Nam',      1975, 0, 'QBT', 'GV'),
('M010', N'Oanh',     1992, 1, 'QBT', 'NV'),

('M011', N'Phương',   1962, 1, 'QTB', 'KD'),
('M012', N'Quang',    1988, 0, 'QTB', 'IT'),

('M013', N'Thảo',     1996, 1, 'QHD', 'SV'),
('M014', N'Tuấn',     1978, 0, 'QHD', 'NV');


/* =========================================================
   16. BẢNG GIÁ
   ========================================================= */

INSERT INTO BangGia
VALUES
('TC',  'S01', '2016-01-01', 60000,  N'Giá buổi sáng'),
('TC',  'S02', '2016-01-01', 65000,  N'Giá buổi sáng'),
('TC',  'S03', '2016-01-01', 70000,  N'Giá buổi trưa'),

('VIP', 'S01', '2016-01-01', 90000,  N'VIP buổi sáng'),
('VIP', 'S05', '2016-01-01', 120000, N'VIP buổi chiều'),
('VIP', 'S07', '2016-01-01', 130000, N'VIP buổi tối'),

('GGĐ', 'S05', '2016-01-01', 180000, N'Ghế đôi'),
('GGĐ', 'S07', '2016-01-01', 200000, N'Ghế đôi buổi tối');


/* =========================================================
   17. VÉ
   ========================================================= */

INSERT INTO Ve
VALUES
/* Em là bà ngoại của anh - LNB
   Có vé ở S02 và S05
   Không tạo vé S07 để dữ liệu có suất không có vé
*/
('V001', 'P003', 'R03', '2016-01-15', '2016-01-14',
 'S02', 'A', 1, 'TC', 'M001', 65000, 0, 0),

('V002', 'P003', 'R03', '2016-01-15', '2016-01-14',
 'S05', 'B', 2, 'VIP', 'M002', 120000, 10000, 0),


/* Vấn Điệp - Nam Sài
   Có suất sau 19 giờ và có thành viên
*/
('V003', 'P001', 'R05', '2016-01-20', '2016-01-19',
 'S07', 'A', 3, 'TC', 'M001', 130000, 0, 10000),

('V004', 'P001', 'R06', '2016-01-21', '2016-01-20',
 'S08', 'A', 2, 'VIP', 'M003', 130000, 0, 0),


/* Hài Nhà Mình */
('V005', 'P002', 'R01', '2016-01-05', '2016-01-04',
 'S07', 'A', 4, 'TC', 'M005', 130000, 0, 0),

/* Cười Lên Nào */
('V006', 'P005', 'R03', '2016-01-15', '2016-01-14',
 'S03', 'B', 3, 'TC', 'M006', 70000, 0, 0),

/* Một số vé bổ sung */
('V007', 'P009', 'R04', '2016-01-20', '2016-01-19',
 'S03', 'A', 5, 'TC', 'M008', 70000, 0, 0),

('V008', 'P004', 'R07', '2016-01-15', '2016-01-14',
 'S03', 'A', 6, 'TC', 'M010', 70000, 0, 0),

('V009', 'P007', 'R06', '2016-01-22', '2016-01-21',
 'S07', 'B', 7, 'GGĐ', 'M009', 200000, 0, 20000),

('V010', 'P001', 'R08', '2016-01-15', '2016-01-14',
 'S07', 'A', 8, 'VIP', 'M013', 130000, 0, 0);

--18. GIẢM GIÁ

INSERT INTO GiamGia
VALUES
(1, 'P002', 'R01', 7, '2016-01-05', 'S07', 'TC',
 '2016-01-01', 1, 110000, 10),

(2, 'P003', 'R03', 6, '2016-01-15', 'S05', 'VIP',
 '2016-01-01', 2, 100000, 15),

(3, 'P005', 'R03', 5, '2016-01-15', 'S03', 'TC',
 '2016-01-10', 1, 60000, 10),

(4, 'P001', 'R05', 3, '2016-01-20', 'S07', 'TC',
 '2016-01-01', 2, 120000, 8),

(5, 'P007', 'R06', 5, '2016-01-22', 'S07', 'GGĐ',
 '2016-01-01', 2, 180000, 10);


-- 19. GIẢM GIÁ THEO NGƯỜI

INSERT INTO GiamGiaTheoNguoi
VALUES
(101, 18, 1, N'SV', '2016-01-01', 1, 50000, 20),
(102, 25, 0, N'SV', '2016-01-01', 1, 55000, 15),
(103, 45, 1, N'GV', '2016-01-01', 2, 70000, 10),
(104, 60, 1, N'KD', '2016-01-01', 2, 60000, 15);
GO