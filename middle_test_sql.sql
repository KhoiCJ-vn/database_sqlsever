/*
=========================================================
SCRIPT CHUẨN BỊ DỮ LIỆU - ĐỀ THI CUỐI KỲ MÔN CƠ SỞ DỮ LIỆU
CSDL: QUẢN LÝ BAY
*/
-- Câu lệnh USE master thật ra không cần thiết, bỏ cũng được nhe
-- USE master;
-- GO

IF DB_ID(N'NguyenMinhKhoi_31251022130') IS NOT NULL
BEGIN
    ALTER DATABASE NguyenMinhKhoi_31251022130 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE NguyenMinhKhoi_31251022130;
END;
GO

-- Set MULTI_USER để có thể xoá database bằng cách thủ công 
ALTER DATABASE [NguyenMinhKhoi_31251022130] 
SET MULTI_USER;
GO

CREATE DATABASE NguyenMinhKhoi_31251022130;
GO

USE NguyenMinhKhoi_31251022130;
GO

/*========================================================
  1. TẠO BẢNG
========================================================*/

CREATE TABLE Pilots
(
    Pilot_ID     CHAR(3)       NULL,
    Pilot_name   NVARCHAR(50)  NULL,
    Plane_type   VARCHAR(20)   NULL,
    Flight_hours INT           NULL
);
GO

CREATE TABLE Planes
(
    Plane_ID     CHAR(4)       NULL,
    Plane_name   NVARCHAR(50)  NULL,
    Plane_type   VARCHAR(20)   NULL
);
GO

CREATE TABLE Flight_Schedule
(
    Pilot_ID            CHAR(3)       NULL,
    Plane_ID            CHAR(4)       NULL,
    Pilot_ID_Supervisor CHAR(3)       NULL,
    Date_flight         DATE          NULL,
    Time_flight         TIME          NULL
);
GO

/*========================================================
  2. DỮ LIỆU PILOTS
========================================================*/

INSERT INTO Pilots
    (Pilot_ID, Pilot_name, Plane_type, Flight_hours)
VALUES
    ('P01', N'John',    'A320',  3200),
    ('P02', N'Jane',    'A320',  2800),
    ('P03', N'Joane',   'B737',  2100),
    ('P04', N'Michael', 'B737',  3500),
    ('P05', N'Peter',   'ATR72', 1800),
    ('P06', N'Linda',   'A350',  4200),
    ('P07', N'Robert',  'B787',  3900);
GO

/*========================================================
  3. DỮ LIỆU PLANES
========================================================*/

INSERT INTO Planes
    (Plane_ID, Plane_name, Plane_type)
VALUES
    ('PL01', N'Airbus A320 - 01', 'A320'),
    ('PL02', N'Airbus A320 - 02', 'A320'),
    ('PL03', N'Airbus A320 - 03', 'A320'),
    ('PL04', N'Boeing 737 - 01',  'B737'),
    ('PL05', N'ATR 72 - 01',      'ATR72'),
    ('PL06', N'Airbus A350 - 01', 'A350'),
    ('PL07', N'Boeing 787 - 01',  'B787');
GO

/*========================================================
  4. DỮ LIỆU FLIGHT_SCHEDULE
========================================================*/

INSERT INTO Flight_Schedule
    (Pilot_ID, Plane_ID, Pilot_ID_Supervisor, Date_flight, Time_flight)
VALUES
    -- Jane (P02): 4 chuyến trong tháng 12/2024
    ('P02', 'PL01', 'P01', '2024-12-03', '08:00:00'),
    ('P02', 'PL02', 'P01', '2024-12-10', '13:30:00'),
    ('P02', 'PL01', 'P01', '2024-12-18', '15:00:00'),
    ('P02', 'PL02', 'P01', '2024-12-27', '09:30:00'),

    -- John (P01)
    ('P01', 'PL01', 'P04', '2024-12-05', '14:00:00'),
    ('P01', 'PL02', 'P04', '2024-12-20', '10:00:00'),

    -- Joane (P03)
    ('P03', 'PL04', 'P04', '2024-12-06', '16:30:00'),
    ('P03', 'PL04', 'P04', '2024-12-22', '08:30:00'),

    -- Michael (P04)
    ('P04', 'PL04', 'P01', '2024-12-07', '13:00:00'),
    ('P04', 'PL04', 'P01', '2024-12-28', '17:00:00'),

    -- Peter (P05)
    ('P05', 'PL05', 'P01', '2024-12-12', '14:30:00'),
    ('P05', 'PL05', 'P01', '2024-11-25', '09:00:00'),

    -- Linda (P06)
    ('P06', 'PL06', 'P07', '2024-12-15', '18:30:00'),
    ('P06', 'PL06', 'P07', '2025-01-05', '09:00:00'),

    -- Robert (P07)
    ('P07', 'PL07', 'P06', '2024-12-16', '15:30:00'),
    ('P07', 'PL07', 'P06', '2025-01-08', '08:00:00');
GO

/*========================================================
  5. KIỂM TRA DỮ LIỆU
========================================================*/

SELECT * FROM Pilots;

SELECT * FROM Planes;

SELECT *
FROM Flight_Schedule
ORDER BY Date_flight, Time_flight;
GO

-- CÂU 0
-- Trước khi tạo khoá chính thì phải đảm bảo cột đó phải NOT NULL
ALTER TABLE Pilots
ALTER COLUMN Pilot_ID CHAR(3) NOT NULL;
GO

-- Tạo CONSTRAINT chủ yếu để tên lúc mở trên Object Explorer không bị xấu. Nói chung là thay vì khai báo khoá chính khoá ngoại và mình muốn tự đặt tên không muốn SQL đặt giùm thì dùng CONSTRAINT
ALTER TABLE Pilots
ADD CONSTRAINT PK_Pilots 
PRIMARY KEY (Pilot_ID);
GO

-- Trước khi tạo khoá ngoại thì phải khai báo khoá chính ở bảng chính mà mình cần tham chiếu 
ALTER TABLE Flight_Schedule
ADD CONSTRAINT FK_FlightSchedule_Pilots 
FOREIGN KEY (Pilot_ID) REFERENCES Pilots(Pilot_ID);
GO

-- Tạo khoá ngoại cho Plane_ID 
ALTER TABLE Flight_Schedule
ALTER COLUMN Plane_ID CHAR(4) NOT NULL;
GO

ALTER TABLE Planes
ALTER COLUMN Plane_ID CHAR(4) NOT NULL;
GO

ALTER TABLE Planes
ADD CONSTRAINT PK_Plane_ID 
PRIMARY KEY (Plane_ID);
GO

ALTER TABLE Flight_Schedule
ADD CONSTRAINT FK_FlightSchedule_Planes
FOREIGN KEY (Plane_ID) REFERENCES Planes(Plane_ID);
GO

-- Vì đề bài yêu cầu chỉ có PLANE với PILOT là khoá chính, nhưng trong chính dữ liệu cũng đã có sự trùng lặp nên ta sẽ tạo tạm thời một cột có tên STT để cùng làm khoá chính ở phần dưới 
-- IDENTITY(a, b) với a là số bắt đầu và b  là "step" giống như bước đi của bước ban đầu a. 
ALTER TABLE Flight_Schedule
ADD STT INT IDENTITY(1,1) NOT NULL;
GO

-- Nếu theo đúng nghiệp vụ thì nên tất cả sẽ là khoá chính, đặc biệt phần Supervisor phải là khoá ngoại của bảng Pilot nên khúc này sẽ thêm khoá chính cho supervisor 
ALTER TABLE Flight_Schedule
ALTER COLUMN Pilot_ID_Supervisor CHAR(3) NOT NULL; 
GO

ALTER TABLE Flight_Schedule
ADD CONSTRAINT FK_FlightSchedule_Pilot_Supervisor
FOREIGN KEY (Pilot_ID_Supervisor) REFERENCES Pilots(Pilot_ID);
GO

ALTER TABLE Flight_Schedule
ALTER COLUMN Pilot_ID CHAR(3) NOT NULL;
GO

ALTER TABLE Flight_Schedule
ADD CONSTRAINT PK_Flight_Schedule
PRIMARY KEY (Pilot_ID, Plane_ID, STT);
GO

-- CÂU 1: 
-- a.
-- Thêm thuộc tính Sex
ALTER TABLE Pilots 
ADD Sex Char(1); 

-- Liệt kê tất cả các thuộc tính của bảng Pilots thì ta phải nhớ INFORMATION_SCHEMA.COLUMNS sẽ chứa các thông tin về thuộc tính của chính bảng đó 
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Pilots';


-- b. 
-- Cập nhật dữ liệu
UPDATE Pilots 
SET Sex = 'F'
WHERE Pilot_name = 'Jane' OR Pilot_name = 'Joane';

-- Truy vấn câu lệnh 
SELECT * 
FROM Pilots
WHERE Sex = 'F';

-- Câu 2: 
-- a.
SELECT PL.Plane_ID
FROM Planes PL
INNER JOIN Pilots PIL
ON PL.Plane_type = PIL.Plane_type
WHERE PIL.Pilot_name = 'Jane';

-- b. 
SELECT DISTINCT PIL2.Pilot_name AS Supervisor_Name
FROM Flight_Schedule FS
INNER JOIN Pilots PIL1
ON FS.Pilot_ID = PIL1.Pilot_ID
INNER JOIN Pilots PIL2 
ON FS.Pilot_ID_Supervisor = PIL2.Pilot_ID
WHERE PIL1.Pilot_name = 'Jane';

-- Quy định buổi chiều là từ 11g đến 5g rưỡi chiều
SELECT DISTINCT PIL.Pilot_name
FROM Flight_Schedule FS
JOIN Pilots PIL 
ON FS.Pilot_ID = PIL.Pilot_ID
WHERE FS.Date_flight BETWEEN '2024-12-01' AND '2024-12-31'
  AND FS.Time_flight >= '11:00:00'
  AND FS.Time_flight < '17:30:00';

SELECT COUNT(*) AS TONGCHUYENBAY
FROM Flight_Schedule FS
INNER JOIN Pilots P
ON FS.Pilot_ID = P.Pilot_ID
WHERE P.Pilot_name = 'Jane'
  AND FS.Date_flight BETWEEN '2024-12-01' AND '2024-12-31';
GO

-- Cau 3:
-- Vì lập lịch nên chỉ có insert mà không có update hay delete gì hết. 
CREATE TRIGGER trg_LAPLICHBAY_DUNGLOAI
ON Flight_Schedule
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted I
        INNER JOIN Pilots P
        ON I.Pilot_ID = P.Pilot_ID
        INNER JOIN Planes PL
        ON I.Plane_ID = PL.Plane_ID
        WHERE P.Plane_type <> PL.Plane_type
    )
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT(N'Phi công không có khả năng lái loại máy bay này');
    END
END;
GO

INSERT INTO Flight_Schedule VALUES ('P03', 'PL03','P01','2025-01-12','8:00:00')     