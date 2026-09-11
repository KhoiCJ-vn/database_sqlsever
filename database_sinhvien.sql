CREATE DATABASE SINH_VIEN;
USE SINH_VIEN;

CREATE TABLE SINH_VIEN
(
 MaSV VARCHAR(10) PRIMARY KEY
 ,Hoten VARCHAR(50)
 ,NgaySinh DATE
 ,Email VARCHAR(100)
 ,SDT VARCHAR(10)
);

CREATE TABLE HOC_PHAN
(
 MaHP VARCHAR(4) PRIMARY KEY
 ,TenHP VARCHAR(100)
 ,SoTinChi INT
);

CREATE TABLE DANG_KY
(
 MaSV VARCHAR(10) REFERENCES SINH_VIEN(MaSV),
 MaHP VARCHAR(4) REFERENCES HOC_PHAN(MaHP),
 NgayDK DATE,
 Diem DECIMAL(10,2) 
);

INSERT INTO SINH_VIEN
VALUES
('SV001', 'Nguyen Van An', '2004-01-10', 'an.nguyen@gmail.com', '0901000001'),
('SV002', 'Tran Thi Binh', '2004-02-15', 'binh.tran@gmail.com', '0901000002'),
('SV003', 'Le Van Cuong', '2003-03-20', 'cuong.le@gmail.com', '0901000003'),
('SV004', 'Pham Thi Dung', '2004-04-25', 'dung.pham@gmail.com', '0901000004'),
('SV005', 'Nguyen Minh Anh', '2004-03-15', 'anh.nguyen@gmail.com', '0901000005'),
('SV006', 'Tran Quoc Bao', '2004-05-21', 'bao.tran@gmail.com', '0901000006'),
('SV007', 'Le Thi Chi', '2003-11-08', 'chi.le@gmail.com', '0901000007'),
('SV008', 'Pham Hoang Duy', '2004-01-19', 'duy.pham@gmail.com', '0901000008'),
('SV009', 'Vo Minh Duc', '2003-09-25', 'duc.vo@gmail.com', '0901000009'),
('SV010', 'Hoang Ngoc Ha', '2004-07-12', 'ha.hoang@gmail.com', '0901000010'),
('SV011', 'Do Thanh Huy', '2003-12-03', 'huy.do@gmail.com', '0901000011'),
('SV012', 'Bui Khanh Linh', '2004-04-28', 'linh.bui@gmail.com', '0901000012'),
('SV013', 'Dang Quang Minh', '2003-10-17', 'minh.dang@gmail.com', '0901000013'),
('SV014', 'Phan Thu Nga', '2004-06-30', 'nga.phan@gmail.com', '0901000014'),
('SV015', 'Mai Gia Phuc', '2004-02-14', 'phuc.mai@gmail.com', '0901000015');

INSERT INTO HOC_PHAN
VALUES
('MH01', 'Co so du lieu co ban', 3),
('MH02', 'Lap trinh', 3),
('MH03', 'Phan tich so', 3),
('MH04', 'Co so du lieu nang cao', 3),
('MH05', 'Lap trinh Python', 3),
('MH06', 'Phan tich du lieu', 3),
('MH07', 'Tri tue nhan tao', 3),
('MH08', 'An toan thong tin', 2);

INSERT INTO DANG_KY
VALUES
('SV001', 'MH01', '2026-01-05', 8.50),
('SV001', 'MH02', '2026-01-05', 7.00),
('SV001', 'MH04', '2026-01-06', 9.00),

('SV002', 'MH01', '2026-01-05', 7.50),
('SV002', 'MH03', '2026-01-07', 8.00),
('SV002', 'MH05', '2026-01-07', 6.50),

('SV003', 'MH02', '2026-01-06', 9.00),
('SV003', 'MH04', '2026-01-08', 8.50),
('SV003', 'MH06', '2026-01-08', 7.50),

('SV004', 'MH01', '2026-01-05', 6.00),
('SV004', 'MH03', '2026-01-07', 7.00),
('SV004', 'MH05', '2026-01-07', 8.50),
('SV004', 'MH07', '2026-01-09', 9.50),

('SV005', 'MH01', '2026-01-06', 8.00),
('SV005', 'MH02', '2026-01-06', 7.50),
('SV005', 'MH06', '2026-01-08', 8.50),

('SV006', 'MH02', '2026-01-06', 6.50),
('SV006', 'MH04', '2026-01-08', 7.00),
('SV006', 'MH07', '2026-01-09', 8.00),

('SV007', 'MH01', '2026-01-05', 9.00),
('SV007', 'MH05', '2026-01-07', 8.50),
('SV007', 'MH06', '2026-01-08', 9.50),

('SV008', 'MH03', '2026-01-07', 7.00),
('SV008', 'MH04', '2026-01-08', 8.00),
('SV008', 'MH07', '2026-01-09', 8.50),

('SV009', 'MH01', '2026-01-05', 5.50),
('SV009', 'MH06', '2026-01-08', 6.00),

('SV010', 'MH02', '2026-01-06', 8.50),
('SV010', 'MH05', '2026-01-07', 9.00),
('SV010', 'MH07', '2026-01-09', 7.50);