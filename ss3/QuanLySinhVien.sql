Create Database QuanLyDiemSV CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci;
use QuanLyDiemSV;
/*=============DANH MUC KHOA==============*/
Create table DMKhoa
(
    MaKhoa  char(2) primary key,
    TenKhoa nvarchar(30) not null
);
/*==============DANH MUC SINH VIEN============*/
Create table DMSV
(
    MaSV     char(3)      not null primary key,
    HoSV     nvarchar(15) not null,
    TenSV    nvarchar(7)  not null,
    Phai     nchar(7),
    NgaySinh datetime     not null,
    NoiSinh  nvarchar(20),
    MaKhoa   char(2),
    HocBong  float
);
/*===================MON HOC========================*/
create table DMMH
(
    MaMH   char(2)      not null,
    TenMH  nvarchar(25) not null,
    SoTiet tinyint,
    Constraint DMMH_MaMH_pk primary key (MaMH)
);
/*=====================KET QUA===================*/
Create table KetQua
(
    MaSV   char(3) not null,
    MaMH   char(2) not null,
    LanThi tinyint,
    Diem   decimal(4, 2),
    Constraint KetQua_MaSV_MaMH_LanThi_pk primary key (MaSV, MaMH, LanThi)
);
/*==========================TAO KHOA NGOAI==============================*/
Alter table dmsv
    add Constraint DMKhoa_MaKhoa_fk foreign key (MaKhoa)
        References DMKhoa (MaKhoa);
Alter table KetQua
    add constraint KetQua_MaSV_fk foreign key (MaSV) references DMSV (MaSV);
Alter table KetQua
    add constraint DMMH_MaMH_fk foreign key (MaMH) references DMMH (MaMH);
/*==================NHAP DU LIEU====================*/
/*==============NHAP DU LIEU DMMH=============*/
Insert into DMMH(MaMH, TenMH, SoTiet)
values ('01', 'Cơ Sở Dữ Liệu', 45);
Insert into DMMH(MaMH, TenMH, SoTiet)
values ('02', 'Trí Tuệ Nhân Tạo', 45);
Insert into DMMH(MaMH, TenMH, SoTiet)
values ('03', 'Truyền Tin', 45);
Insert into DMMH(MaMH, TenMH, SoTiet)
values ('04', 'Đồ Họa', 60);
Insert into DMMH(MaMH, TenMH, SoTiet)
values ('05', 'Văn Phạm', 60);
/*==============NHAP DU LIEU DMKHOA=============*/
Insert into DMKhoa(MaKhoa, TenKhoa)
values ('AV', 'Anh Văn');
Insert into DMKhoa(MaKhoa, TenKhoa)
values ('TH', 'Tin Học');
Insert into DMKhoa(MaKhoa, TenKhoa)
values ('TR', 'Triết');
Insert into DMKhoa(MaKhoa, TenKhoa)
values ('VL', 'Vật Lý');
/*==============NHAP DU LIEU DMSV=============*/
Insert into DMSV
values ('A01', 'Nguyễn Thị', 'Hải', 'Nữ', '1990-03-20', 'Hà Nội', 'TH', 130000);
Insert into DMSV(MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
values ('A02', 'Trần Văn', 'Chính', 'Nam', '1992-12-24', 'Bình Định', 'VL', 150000);
Insert into DMSV(MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
values ('A03', 'Lê Thu Bạch', 'Yến', 'Nữ', '1990-02-21', 'TP Hồ Chí Minh', 'TH', 170000);
Insert into DMSV(MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
values ('A04', 'Trần Anh', 'Tuấn', 'Nam', '1990-12-20', 'Hà Nội', 'AV', 80000);
Insert into DMSV(MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
values ('B01', 'Trần Thanh', 'Mai', 'Nữ', '1991-08-12', 'Hải Phòng', 'TR', 0);
Insert into DMSV(MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
values ('B02', 'Trần Thị Thu', 'Thủy', 'Nữ', '1991-01-02', 'TP Hồ Chí Minh', 'AV', 0);
/*==============NHAP DU LIEU BANG KET QUA=============*/
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A01', '01', 1, 3);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A01', '01', 2, 6);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A01', '02', 2, 6);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A01', '03', 1, 5);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A02', '01', 1, 4.5);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A02', '01', 2, 7);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A02', '03', 1, 10);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A02', '05', 1, 9);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A03', '01', 1, 2);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A03', '01', 2, 5);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A03', '03', 1, 2.5);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A03', '03', 2, 4);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A04', '05', 2, 10);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('B01', '01', 1, 7);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('B01', '03', 1, 2.5);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('B01', '03', 2, 5);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('B02', '02', 1, 6);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('B02', '04', 1, 10);


/* 1. Liệt kê danh sách sinh viên, gồm các thông tin sau:
   Mã sinh viên, Họ sinh viên, Tên sinh viên, Học bổng.
   Danh sách sẽ được sắp xếp theo thứ tự Mã sinh viên tăng dần
 */

#  SELECT MaSV, HoSV, TenSV, HocBong
#  FROM DMSV
#  GROUP BY

/* 2. Danh sách các sinh viên gồm thông tin sau:
   Mã sinh viên, họ tên sinh viên, Phái, Ngày sinh.
   Danh sách sẽ được sắp xếp theo thứ tự Nam/Nữ.
 */

-- 1 /
SELECT MaSV, HoSV, TenSV, HocBong
FROM DMSV
ORDER BY MaSV;

-- 2 /
SELECT MaSV, CONCAT(HoSV, ' ', TenSV) AS HoTen
FROM DMSV;

-- 3 /
SELECT CONCAT(HoSV, ' ', TenSV) AS HoTen, NgaySinh, HocBong
FROM DMSV
ORDER BY NgaySinh ASC, HocBong DESC;

-- 4 /
SELECT MaMH, TenMH, SoTiet
FROM DMMH
WHERE TenMH LIKE 'T%';

-- 5 /
SELECT CONCAT(HoSV, ' ', TenSV) AS HoTen, NgaySinh, Phai
FROM DMSV
WHERE TenSV LIKE '%I';

-- 6 /
SELECT MaKhoa, TenKhoa
FROM DMKhoa
WHERE TenKhoa LIKE '_N%';

-- 7 /
SELECT CONCAT(HoSV, ' ', TenSV) AS HoTen, MaKhoa, NoiSinh, HocBong
FROM DMSV
WHERE HoSV LIKE '%Thị%';

-- 8 /
SELECT MaSV, CONCAT(HoSV, ' ', TenSV) AS HoTen, MaKhoa, HocBong
FROM DMSV
WHERE HocBong > 100000
ORDER BY MaKhoa DESC;

-- 9 /
SELECT MaSV, CONCAT(HoSV, ' ', TenSV) AS HoTen, MaKhoa, HocBong
FROM DMSV
WHERE HocBong >= 150000
  AND NoiSinh = 'Hà Nội';

-- 10 /
SELECT MaSV, MaKhoa, Phai
FROM DMSV
WHERE MaKhoa = 'AV'
   OR MaKhoa = 'VL';

-- 11 /
SELECT MaSV, NgaySinh, NoiSinh, HocBong
FROM DMSV
WHERE NgaySinh BETWEEN '1991-01-01' AND '1992-06-05';

-- 12 /
SELECT MaSV, NgaySinh, Phai, MaKhoa
FROM DMSV
WHERE HocBong BETWEEN 80000 AND 150000;

-- 13 /
SELECT MaMH, TenMH, SoTiet
FROM DMMH
WHERE SoTiet > 30
  AND SoTiet < 45;

-- 14 /
SELECT DMSV.MaSV, CONCAT(DMSV.HoSV, ' ', DMSV.TenSV) AS HoTen, DMKhoa.TenKhoa, DMSV.Phai
FROM DMSV
         JOIN DMKhoa ON DMSV.MaKhoa = DMKhoa.MaKhoa
WHERE (DMSV.MaKhoa = 'AV' OR DMSV.MaKhoa = 'TH')
  AND DMSV.Phai = 'Nam';

-- 15 /
SELECT CONCAT(HoSV, ' ', TenSV) AS HoTen
FROM DMSV
WHERE Phai = 'Nữ'
  AND TenSV LIKE '%N%';

-- 16 /
SELECT HoSV, TenSV, NoiSinh, NgaySinh
FROM DMSV
WHERE NoiSinh = 'Hà Nội'
  AND MONTH(NgaySinh) = 2;

-- 17 /
SELECT CONCAT(HoSV, ' ', TenSV) AS HoTen, TIMESTAMPDIFF(YEAR, NgaySinh, CURDATE()) AS Tuoi, HocBong
FROM DMSV
HAVING Tuoi > 20;

-- 18 /
SELECT CONCAT(DMSV.HoSV, ' ', DMSV.TenSV)            AS HoTen,
       TIMESTAMPDIFF(YEAR, DMSV.NgaySinh, CURDATE()) AS Tuoi,
       DMKhoa.TenKhoa
FROM DMSV
         JOIN DMKhoa ON DMSV.MaKhoa = DMKhoa.MaKhoa
HAVING Tuoi BETWEEN 20 AND 25;

-- 19 /
SELECT CONCAT(HoSV, ' ', TenSV) AS HoTen, Phai, NgaySinh
FROM DMSV
WHERE YEAR(NgaySinh) = 1990
  AND MONTH(NgaySinh) BETWEEN 3 AND 5;

-- 20 /
SELECT MaSV,
       Phai,
       MaKhoa,
       IF(HocBong > 500000, 'Học bổng cao', 'Mức trung bình') AS MucHocBong
FROM DMSV;

-- 21 /
SELECT COUNT(*) AS TongSoHs
FROM DMSV;

-- 22 /
SELECT COUNT(*) AS TotalStudents, SUM(IF(Phai = 'Nữ', 1, 0)) AS TongSoHsNu
FROM DMSV;

-- 23 /
SELECT MaKhoa, COUNT(MaSV) AS TongSoHs
FROM DMSV
GROUP BY MaKhoa;

-- 24 /
SELECT MaMH, COUNT(DISTINCT MaSV) AS TongSoHs
FROM KetQua
GROUP BY MaMH;

-- 25 /
SELECT COUNT(DISTINCT MaMH) AS TongCacKhoaHoc
FROM KetQua;

-- 26 /
SELECT MaKhoa, SUM(HocBong) AS TongSoHocBong
FROM DMSV
GROUP BY MaKhoa;

-- 27 /
SELECT MaKhoa, MAX(HocBong) AS HocBongCaoNhat
FROM DMSV
GROUP BY MaKhoa;

-- 28 /
SELECT MaKhoa,
       COUNT(IF(Phai = 'Nam', 1, NULL)) AS TongSoHsNam,
       COUNT(IF(Phai = 'Nữ', 1, NULL))  AS TongSoHsNu
FROM DMSV
GROUP BY MaKhoa;

-- 29 /
SELECT TIMESTAMPDIFF(YEAR, NgaySinh, CURDATE()) AS Age, COUNT(*) AS SoLuongHocSinh
FROM DMSV
GROUP BY Age;

-- 30 /
SELECT YEAR(NgaySinh) AS BirthYear, COUNT(*) AS SoLuongHocSinh
FROM DMSV
GROUP BY BirthYear
HAVING SoLuongHocSinh = 2;

-- 31 /
SELECT NoiSinh, COUNT(*) AS SoLuongHocSinh
FROM DMSV
GROUP BY NoiSinh
HAVING SoLuongHocSinh > 2;

-- 32 / 
SELECT MaMH, COUNT(DISTINCT MaSV) AS SoLuongHocSinh
FROM KetQua
GROUP BY MaMH
HAVING SoLuongHocSinh > 3;

-- 33 /
SELECT MaSV, COUNT(*) AS SoLanThiLai
FROM KetQua
GROUP BY MaSV, MaMH
HAVING COUNT(*) > 2;

-- 34 /
SELECT MaSV
FROM KetQua
WHERE LanThi = 1
  AND Diem > 7
  AND MaSV IN (SELECT MaSV FROM DMSV WHERE Phai = 'Nam')
GROUP BY MaSV;

-- 35 /
SELECT MaSV
FROM KetQua
WHERE LanThi = 1
  AND Diem < 5
GROUP BY MaSV
HAVING COUNT(*) > 2;

-- 36 /
SELECT MaKhoa, COUNT(*) AS SoHsNam
FROM DMSV
WHERE Phai = 'Nam'
GROUP BY MaKhoa
HAVING COUNT(*) > 2;

-- 37 /
SELECT MaKhoa, COUNT(*) AS SoHs
FROM DMSV
WHERE HocBong BETWEEN 200000 AND 300000
GROUP BY MaKhoa
HAVING COUNT(*) = 2;

-- 38 /
SELECT MaMH,
       SUM(IF(Diem >= 5, 1, 0)) AS QuaMon,
       SUM(IF(Diem < 5, 1, 0))  AS RotMon
FROM KetQua
WHERE LanThi = 1
GROUP BY MaMH;

-- 39 /
SELECT MaSV, MAX(HocBong) AS MucHocBongCaoNhat
FROM DMSV;

-- 40 /
SELECT MaSV, MAX(Diem) AS DiemCaoNhat
FROM KetQua
WHERE MaMH = '01'
  AND LanThi = 1;

-- 41 /
SELECT MaSV, MAX(TIMESTAMPDIFF(YEAR, NgaySinh, CURDATE())) AS SVLonTuoiNhat
FROM DMSV
WHERE MaKhoa = 'AV';

-- 42 /
SELECT MaKhoa, COUNT(*) AS SoLuongHs
FROM DMSV
GROUP BY MaKhoa
ORDER BY SoLuongHs DESC
LIMIT 1;

-- 43 /
SELECT MaKhoa, COUNT(*) AS SoLuongHsNu
FROM DMSV
WHERE Phai = 'Nữ'
GROUP BY MaKhoa
ORDER BY SoLuongHsNu DESC
LIMIT 1;

-- 44 /
SELECT TenMH, COUNT(*) AS SoLanRotMon
FROM KetQua
         JOIN DMMH ON DMMH.MaMH = KetQua.MaMH
WHERE Diem < 5
  AND LanThi = 1
GROUP BY TenMH
ORDER BY SoLanRotMon DESC
LIMIT 1;

-- 45 /
SELECT A.MaSV
FROM KetQua A,
     KetQua B,
     DMSV C,
     DMSV D
WHERE A.MaMH = '05'
  AND B.MaMH = '05'
  AND A.MaSV = C.MaSV
  AND B.MaSV = D.MaSV
  AND C.MaKhoa != 'AV'
  AND D.MaKhoa = 'AV'
  AND A.Diem > B.Diem;

-- 46
SELECT MaSV
FROM DMSV
WHERE NoiSinh = (SELECT NoiSinh FROM DMSV WHERE TenSV = 'Hải');

-- 47
SELECT MaSV, HocBong
FROM DMSV
WHERE HocBong > (SELECT MAX(HocBong) FROM DMSV WHERE MaKhoa = 'AV');

-- 48
SELECT A.MaSV, A.HocBong
FROM DMSV A
WHERE A.HocBong > ALL (SELECT B.HocBong FROM DMSV B WHERE B.MaKhoa = 'AV');

-- 49
SELECT MaSV
FROM KetQua
WHERE MaMH = '01'
  AND LanThi = 2
  AND Diem > ALL (SELECT Diem
                  FROM KetQua
                  WHERE MaMH = '01'
                    AND LanThi = 1);

-- 50
SELECT MaMH, MAX(Diem) AS HighestScore
FROM KetQua
GROUP BY MaMH;

-- 51
SELECT MaKhoa
FROM DMKhoa
WHERE MaKhoa NOT IN (SELECT DISTINCT MaKhoa FROM DMSV);

-- 52
SELECT MaSV
FROM DMSV
WHERE MaSV NOT IN (SELECT DISTINCT MaSV FROM KetQua WHERE MaMH = '01');

-- 53
SELECT MaSV
FROM KetQua
WHERE LanThi = 2
  AND MaSV NOT IN (SELECT MaSV FROM KetQua WHERE LanThi = 1);

-- 54
SELECT MaMH
FROM DMMH
WHERE MaMH NOT IN (SELECT MaMH FROM KetQua WHERE MaSV IN (SELECT MaSV FROM DMSV WHERE MaKhoa = 'AV'));

-- 55
SELECT MaSV
FROM DMSV
WHERE MaKhoa = 'AV'
  AND MaSV NOT IN (SELECT MaSV FROM KetQua WHERE MaMH = '05');

-- 56
SELECT MaSV
FROM DMSV
WHERE MaSV NOT IN (SELECT MaSV FROM KetQua WHERE Diem < 5);

-- 57
SELECT MaSV
FROM DMSV
WHERE MaKhoa = 'AV'
  AND HocBong > 0
  AND MaSV NOT IN (SELECT MaSV FROM KetQua WHERE Diem < 5);

-- 58
SELECT TenKhoa, COUNT(*) AS SoHsCoNhieuHbNhat
FROM DMSV
         JOIN DMKhoa ON DMSV.MaKhoa = DMKhoa.MaKhoa
WHERE HocBong > 0
GROUP BY TenKhoa
ORDER BY SoHsCoNhieuHbNhat DESC, SoHsCoNhieuHbNhat ASC
LIMIT 1;

-- 59
SELECT MaSV, COUNT(DISTINCT MaMH) AS SoKhoaHoc
FROM KetQua
GROUP BY MaSV
ORDER BY SoKhoaHoc DESC
LIMIT 3;

-- 60
SELECT MaMH
FROM DMMH
WHERE MaMH IN (SELECT MaMH
               FROM KetQua
               GROUP BY MaMH
               HAVING COUNT(DISTINCT MaSV) = (SELECT COUNT(*) FROM DMSV));

-- 61
SELECT DISTINCT A.MaSV, TenSV
FROM KetQua A
         JOIN KetQua B ON A.MaMH = B.MaMH
         JOIN DMSV D on A.MaSV = D.MaSV
WHERE B.MaSV = 'A02';

-- 62
SELECT KQ1.MaSV
FROM KetQua KQ1
WHERE NOT EXISTS (
    SELECT KQ2.MaMH
    FROM KetQua KQ2
    WHERE KQ2.MaSV = 'A02'
      AND KQ2.MaMH NOT IN (
        SELECT KQ3.MaMH
        FROM KetQua KQ3
        WHERE KQ3.MaSV = KQ1.MaSV
    )
)
  AND NOT EXISTS (
    -- Môn học mà sinh viên khác học nhưng A02 không học
    SELECT KQ4.MaMH
    FROM KetQua KQ4
    WHERE KQ4.MaSV = KQ1.MaSV
      AND KQ4.MaMH NOT IN (
        SELECT KQ5.MaMH
        FROM KetQua KQ5
        WHERE KQ5.MaSV = 'A02'
    )
)
  AND KQ1.MaSV != 'A02'
GROUP BY KQ1.MaSV;


