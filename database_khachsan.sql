-- Tạo CSDL 
CREATE DATABASE QL_KHACHSAN;
GO

USE QL_KHACHSAN;
GO

-- Tạo bảng
CREATE TABLE LOAI_PHONG
(
	MaLoaiPhong VARCHAR(10) PRIMARY KEY,
	TenLoaiPhong VARCHAR (50) NOT NULL,
	DonGia DECIMAL(12,2) NOT NULL,
	SoNguoiToiDa INT NOT NULL
);

CREATE TABLE PHONG
(
	MaPhong VARCHAR(10) PRIMARY KEY,
	SoPhong VARCHAR (10) NOT NULL,
	MaLoaiPhong VARCHAR(10) REFERENCES LOAI_PHONG(MaLoaiPhong),
	TrangThai VARCHAR(20) NOT NULL
);

CREATE TABLE KHACH_HANG
(
	MaKH VARCHAR (10) PRIMARY KEY,
	HoTen VARCHAR(100) NOT NULL,
	CCCD VARCHAR(20),
	DienThoai VARCHAR(15),
	Email VARCHAR(100)
);

CREATE TABLE DAT_PHONG 
(
	MaDatPhong VARCHAR (10) PRIMARY KEY,
	MaKH VARCHAR(10) REFERENCES KHACH_HANG(MaKH),
	MaPhong VARCHAR(10) REFERENCES PHONG(MaPhong),
	NgayDat DATE NOT NULL, 
	NgayNhan DATE NOT NULL, 
	NgayTra DATE, 
	TrangThai VARCHAR(20) NOT NULL
);

CREATE TABLE DICH_VU
(
	MaDV VARCHAR(10) PRIMARY KEY,
	TenDV VARCHAR(100) NOT NULL, 
	DonGia DECIMAL(12,2) NOT NULL
);

CREATE TABLE SU_DUNG_DV
(
	MaSuDung INT PRIMARY KEY IDENTITY (1,1),
	MaDatPhong VARCHAR(10) NOT NULL REFERENCES DAT_PHONG(MaDatPhong),
	MaDV VARCHAR(10) NOT NULL REFERENCES DICH_VU(MaDV),
	NgaySuDung DATE NOT NULL,
	SoLuong INT NOT NULL 
);


-- Insert dữ liệu 
INSERT INTO LOAI_PHONG 
	(MaLoaiPhong, TenLoaiPhong, DonGia, SoNguoiToiDa) 
VALUES 
	('LP01', 'Standard', 800000, 2), 
	('LP02', 'Superior', 1000000, 2), 
	('LP03', 'Deluxe', 1200000, 3), 
	('LP04', 'Executive', 1600000, 3), 
	('LP05', 'Suite', 2000000, 4); 

INSERT INTO PHONG 
	(MaPhong, SoPhong, MaLoaiPhong, TrangThai) 
VALUES 
	('P101', '101', 'LP01', 'Trong'), 
	('P102', '102', 'LP01', 'Dang su dung'), 
	('P103', '103', 'LP01', 'Trong'), 
	('P201', '201', 'LP02', 'Trong'), 
	('P202', '202', 'LP02', 'Dang su dung'), 
	('P301', '301', 'LP03', 'Trong'), 
	('P302', '302', 'LP03', 'Dang su dung'), 
	('P303', '303', 'LP03', 'Bao tri'), 
	('P401', '401', 'LP04', 'Trong'), 
	('P402', '402', 'LP04', 'Dang su dung'), 
	('P501', '501', 'LP05', 'Trong'), 
	('P502', '502', 'LP05', 'Bao tri'); 

INSERT INTO KHACH_HANG 
	(MaKH, HoTen, CCCD, DienThoai, Email) 
VALUES 
	('KH01', 'Nguyen Van An', '079001001001', '0901000001', 'an@gmail.com'), 
	('KH02', 'Nguyen Thi Binh', '079001001002', '0901000002', 'binh@gmail.com'),
	('KH03', 'Nguyen Van Cuong', '079001001003', '0901000003', 'cuong@gmail.com'), ('KH04', 'Tran Thi Dung', '079001001004', '0901000004', 'dung@gmail.com'), 
	('KH05', 'Tran Van Em', '079001001005', '0901000005', 'em@gmail.com'), 
	('KH06', 'Le Minh Anh', '079001001006', '0901000006', 'anh@gmail.com'), 
	('KH07', 'Le Hoang Nam', '079001001007', '0901000007', 'nam@gmail.com'), 
	('KH08', 'Pham Van Binh', '079001001008', '0901000008', 'pham.binh@gmail.com'), ('KH09', 'Hoang Minh Duc', '079001001009', '0901000009', 'duc@gmail.com'), 
	('KH10', 'Vo Thi Lan', '079001001010', '0901000010', 'lan@gmail.com'); 

INSERT INTO DICH_VU 
	(MaDV, TenDV, DonGia) 
VALUES 
	('DV01', 'An sang', 150000), 
	('DV02', 'Giat ui', 100000), 
	('DV03', 'Don phong', 80000), 
	('DV04', 'Taxi san bay', 250000), 
	('DV05', 'Do uong', 70000), 
	('DV06', 'Goi phong', 120000); 

INSERT INTO DAT_PHONG 
	(MaDatPhong, MaKH, MaPhong, NgayDat, NgayNhan, NgayTra, TrangThai) 
VALUES 
	('DP01', 'KH01', 'P101', '2026-08-01', '2026-08-10', '2026-08-12', 'Da tra'), 
	('DP02', 'KH02', 'P102', '2026-08-02', '2026-08-11', '2026-08-14', 'Da tra'), 
	('DP03', 'KH03', 'P201', '2026-08-05', '2026-08-15', '2026-08-18', 'Da tra'), 
	('DP04', 'KH04', 'P202', '2026-08-08', '2026-08-20', '2026-08-23', 'Dang o'), 
	('DP05', 'KH01', 'P301', '2026-08-10', '2026-08-25', '2026-08-28', 'Da dat'), 
	('DP06', 'KH05', 'P103', '2026-08-12', '2026-08-27', '2026-08-30', 'Da dat'), 
	('DP07', 'KH06', 'P302', '2026-08-13', '2026-08-28', '2026-08-31', 'Da dat'), 
	('DP08', 'KH07', 'P401', '2026-08-15', '2026-09-01', '2026-09-04', 'Da dat'), 
	('DP09', 'KH08', 'P402', '2026-08-16', '2026-09-02', '2026-09-05', 'Da dat'), 
	('DP10', 'KH09', 'P501', '2026-08-18', '2026-09-03', '2026-09-07', 'Da dat'), 
	('DP11', 'KH10', 'P201', '2026-08-20', '2026-09-05', '2026-09-08', 'Da dat'), 
	('DP12', 'KH02', 'P301', '2026-08-21', '2026-09-06', '2026-09-09', 'Da dat'), 
	('DP13', 'KH03', 'P401', '2026-08-22', '2026-09-07', '2026-09-10', 'Da dat'), 
	('DP14', 'KH01', 'P501', '2026-08-24', '2026-09-10', '2026-09-13', 'Da dat'), 
	('DP15', 'KH05', 'P302', '2026-08-25', '2026-09-12', '2026-09-15', 'Da dat');

INSERT INTO SU_DUNG_DV (MaDatPhong, MaDV, NgaySuDung, SoLuong)
VALUES
('DP01','DV01','2026-08-10',2),
('DP01','DV05','2026-08-10',3),
('DP01','DV01','2026-08-11',2),
('DP02','DV02','2026-08-12',1),
('DP02','DV05','2026-08-13',2),
('DP03','DV01','2026-08-15',3),
('DP03','DV03','2026-08-16',1),
('DP04','DV05','2026-08-20',4),
('DP04','DV02','2026-08-21',2),
('DP04','DV05','2026-08-22',1),
('DP05','DV04','2026-08-25',1),
('DP05','DV01','2026-08-26',2),
('DP06','DV01','2026-08-27',2),
('DP06','DV02','2026-08-28',1),
('DP07','DV03','2026-08-29',2),
('DP08','DV04','2026-09-01',1),
('DP08','DV05','2026-09-02',3),
('DP09','DV02','2026-09-03',2),
('DP10','DV01','2026-09-04',2),
('DP10','DV04','2026-09-05',1),
('DP11','DV05','2026-09-06',2),
('DP12','DV02','2026-09-07',3),
('DP12','DV03','2026-09-08',1),
('DP13','DV01','2026-09-08',2),
('DP14','DV04','2026-09-11',1),
('DP14','DV05','2026-09-12',2),
('DP15','DV02','2026-09-13',1);
SELECT * FROM LOAI_PHONG;
SELECT * FROM PHONG;
SELECT * FROM KHACH_HANG;
SELECT * FROM DAT_PHONG;
SELECT * FROM DICH_VU;
SELECT * FROM SU_DUNG_DV;

-- UPDATE bảng 
UPDATE LOAI_PHONG
SET DonGia = DonGia * 1.1
WHERE MaLoaiPhong = 'LP02';

UPDATE DAT_PHONG
SET TrangThai = 'Dang su dung'
WHERE MaPhong = 'P103';

UPDATE KHACH_HANG
SET DienThoai = '0908888888',
	Email = 'dung.moi@gmail.com'
WHERE MaKH = 'KH04';

UPDATE DAT_PHONG
SET TrangThai = 'Dang o'
WHERE TrangThai = 'Da dat';

UPDATE DAT_PHONG
SET NgayTra = '2026-08-25'
WHERE MaDatPhong = 'DP04';

SELECT * FROM DAT_PHONG;
