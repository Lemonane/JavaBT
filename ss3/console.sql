create schema csdl_QLBH CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci;

use csdl_QLBH;

-- Khách hàng
create table KhachHang
(
    MaKH     varchar(4)  not null
        primary key,
    TenKH    varchar(30) not null,
    DiaChi   varchar(50) null,
    NgaySinh datetime    null,
    SoDT     varchar(15) null
);


-- Nhân viên
create table Nhan_vien
(
    MaNV       varchar(4)  not null
        primary key,
    HoTen      varchar(30) not null,
    GioiTinh   bit         not null,
    DiaChi     varchar(50) not null,
    NgaySinh   datetime    not null,
    DienThoai  varchar(15) null,
    Email      text        null,
    NoiSinh    varchar(20) not null,
    NgayVaoLam datetime    null,
    MaNQL      varchar(4)  null
);


-- Nhà cung cấp
create table NhaCungCap
(
    MaNCC     varchar(5)  not null
        primary key,
    TenNCC    varchar(50) not null,
    DiaChi    varchar(50) not null,
    DienThoai varchar(15) not null,
    Email     varchar(30) not null,
    Website   varchar(30) null
);

-- Loại sản phẩm
create table LoaiSP
(
    MaloaiSP  varchar(4)   not null
        primary key,
    TenloaiSP varchar(30)  not null,
    GhiChu    varchar(100) not null
);


-- Sản phẩm
create table SanPham
(
    MaSP      varchar(4)   not null
        primary key,
    MaloaiSP  varchar(4)   not null,
    TenSP     varchar(50)  not null,
    Donvitinh varchar(10)  not null,
    GhiChu    varchar(100) null,
    constraint SanPham_LoaiSP_MaloaiSP_fk
        foreign key (MaloaiSP) references LoaiSP (MaloaiSP)
);

-- Phieu Nhập
create table PhieuNhap
(
    SoPN     varchar(5)   not null
        primary key,
    MaNV     varchar(4)   not null,
    MaNCC    varchar(5)   not null,
    Ngaynhap datetime     not null,
    GhiChu   varchar(100) null
);

-- CTPhieu nhập
create table CTPhieuNhap
(
    MaSP    varchar(4) not null,
    SoPN    varchar(5) not null,
    Soluong smallint   not null,
    GiaNhap double     not null
);

-- Phiếu xuất
create table PhieuXuat
(
    SoPX    varchar(5) not null
        primary key,
    MaNV    varchar(5) not null,
    MaKH    varchar(4) not null,
    NgayBan datetime   not null,
    GhiChu  text       null

);
-- Tạo trigger check ngày bán
DELIMITER //
CREATE TRIGGER check_date_before_insert
    BEFORE INSERT
    ON PhieuXuat
    FOR EACH ROW
BEGIN
    IF NEW.NgayBan <= CURDATE() THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ngay_Ban không được ở quá khứ';
    END IF;
END;
//
DELIMITER ;


-- CT Phiếu xuất
create table CTPhieuXuat
(
    SoPX    varchar(5) not null,
    MaSP    varchar(4) not null,
    Soluong smallint   not null,
    GiaBan  double     not null
);

-- Tạo liên kết khoá ngoại

-- * fk_PN
alter table PhieuNhap
    add constraint PhieuNhap_NhaCungCap_MaNCC_fk
        foreign key (MaNCC) references NhaCungCap (MaNCC),
    add constraint PhieuNhap_Nhan_vien_MaNV_fk
        foreign key (MaNV) references Nhan_vien (MaNV);
-- * fk_CT_PN
alter table CTPhieuNhap
    add constraint CTPhieuNhap_PhieuNhap_SoPN_fk
        foreign key (SoPN) references PhieuNhap (SoPN),
    add constraint CTPhieuNhap_SanPham_MaSP_fk
        foreign key (MaSP) references SanPham (MaSP);

-- * fk_PX
alter table PhieuXuat
    add constraint PhieuXuat_KhachHang_MaKH_fk
        foreign key (MaKH) references KhachHang (MaKH),
    add constraint PhieuXuat_Nhan_vien_MaNV_fk
        foreign key (MaNV) references Nhan_vien (MaNV);

-- * fk_CT_PX
alter table CTPhieuXuat
    add constraint CTPhieuXuat_PhieuXuat_SoPX_fk
        foreign key (SoPX) references PhieuXuat (SoPX),
    add constraint CTPhieuXuat_SanPham_MaSP_fk
        foreign key (MaSP) references SanPham (MaSP);



-- -------- INSERT dữ liệu --------
-- KH
INSERT INTO KhachHang (MaKH, TenKH, DiaChi, NgaySinh, SoDT)
VALUES ('1', 'Thưởng', 'Tokyo', '0200-10-19 06:20:08', '08025605436');

INSERT INTO KhachHang (MaKH, TenKH, DiaChi, NgaySinh, SoDT)
VALUES ('KH10', 'Customer', 'Tokyo', '0200-10-19 06:20:08', '08025605436');

-- NV
INSERT INTO Nhan_vien (MaNV, HoTen, GioiTinh, DiaChi, NgaySinh, DienThoai, Email, NoiSinh, NgayVaoLam,
                       MaNQL)
VALUES ('1', 'Nhân viên 1', true, 'Tokyo', '2000-09-19 06:22:32', '080xxx', 'nv@gmail.com', 'VietNam',
        '2023-09-15 06:23:05', '1');
INSERT INTO Nhan_vien (MaNV, HoTen, GioiTinh, DiaChi, NgaySinh, DienThoai, Email, NoiSinh, NgayVaoLam,
                       MaNQL)
VALUES ('2', 'Nhân viên NEW', true, 'Tokyo', '2003-09-17 16:56:48', '080xxx', 'nv@gmail.com', 'VietNam', null, null);
INSERT INTO Nhan_vien (MaNV, HoTen, GioiTinh, DiaChi, NgaySinh, DienThoai, Email, NoiSinh, NgayVaoLam,
                       MaNQL)
VALUES ('NV05', 'Nhân viên NV05', true, 'Tokyo', '2000-09-19 06:22:32', '080xxx', 'nv@gmail.com', 'VietNam',
        '2023-09-15 06:23:05', '1');

-- NCC
INSERT INTO NhaCungCap (MaNCC, TenNCC, DiaChi, DienThoai, Email, Website)
VALUES ('1', 'SHOP_1', 'Tokyo', '080xxx', 'abc@email.com', 'http://web.com');

-- LoaiSP
INSERT INTO LoaiSP (MaloaiSP, TenloaiSP, GhiChu)
VALUES ('1', 'Quần áo', 'for demo');

-- SP
INSERT INTO SanPham (MaSP, MaloaiSP, TenSP, Donvitinh, GhiChu)
VALUES ('1', '1', 'Quần áo_demo', 'VN Đồng', 'SP_Demo');
INSERT INTO SanPham (MaSP, MaloaiSP, TenSP, Donvitinh, GhiChu)
VALUES ('2', '1', 'Quần áo_2', 'VN Đồng', 'SP_Demo');
INSERT INTO SanPham (MaSP, MaloaiSP, TenSP, Donvitinh, GhiChu)
VALUES ('3', '1', 'Quần áo_3', 'VN Đồng', 'SP_Demo');
INSERT INTO SanPham (MaSP, MaloaiSP, TenSP, Donvitinh, GhiChu)
VALUES ('4', '1', 'Quần áo_4', 'VN Đồng', 'SP_Demo');
INSERT INTO SanPham (MaSP, MaloaiSP, TenSP, Donvitinh, GhiChu)
VALUES ('SP15', '1', 'Quần áo_SP15', 'VN Đồng', 'SP_Demo');

-- PN
INSERT INTO PhieuNhap (SoPN, MaNV, MaNCC, Ngaynhap, GhiChu)
VALUES ('1', '1', '1', '2023-09-15 16:52:15', 'no');
INSERT INTO PhieuNhap (SoPN, MaNV, MaNCC, Ngaynhap, GhiChu)
VALUES ('2', '1', '1', '2023-09-15 16:52:28', 'no');

-- CTPN
INSERT INTO CTPhieuNhap (MaSP, SoPN, Soluong, GiaNhap)
VALUES ('1', '1', 2, 1000);
INSERT INTO CTPhieuNhap (MaSP, SoPN, Soluong, GiaNhap)
VALUES ('2', '2', 2, 2000);

-- PX
INSERT INTO PhieuXuat (SoPX, MaNV, MaKH, NgayBan, GhiChu)
VALUES ('1', '1', '1', '2023-09-15 16:54:33', 'no');
INSERT INTO PhieuXuat (SoPX, MaNV, MaKH, NgayBan, GhiChu)
VALUES ('2', '1', '1', '2023-09-15 16:54:34', 'no');

-- CTPX
INSERT INTO CTPhieuXuat (SoPX, MaSP, Soluong, GiaBan)
VALUES ('1', '1', 3, 1000);
INSERT INTO CTPhieuXuat (SoPX, MaSP, Soluong, GiaBan)
VALUES ('2', '2', 3, 2000);

-- -------- UPDATE --------
UPDATE KhachHang
SET SoDT = '080xxxNew'
WHERE MaKH = 'KH10';
UPDATE Nhan_vien
SET DiaChi = 'New_Dia_Chi'
WHERE MaNV = 'NV05';

-- -------- DELETE --------
DELETE
FROM Nhan_vien
WHERE MaNV = 'NV05';
DELETE
FROM SanPham
WHERE MaSP = 'SP15';

-- -------- SELECT --------
/* 1. Liệt kê thông tin về nhân viên trong cửa hàng, gồm:
   mã nhân viên, họ tên nhân viên, giới tính, ngày sinh, địa chỉ, số điện thoại, tuổi.
   Kết quả sắp xếp theo tuổi.
   */
SELECT MaNV,
       HoTen,
       GioiTinh,
       DiaChi,
       TIMESTAMPDIFF(YEAR, NgaySinh, CURDATE()) AS NgaySinh,
       DienThoai,
       Email,
       NoiSinh,
       NgayVaoLam,
       MaNQL
FROM Nhan_vien
ORDER BY NgaySinh;

/*
 2. Liệt kê các hóa đơn nhập hàng trong tháng 6/2018,
 gồm thông tin số phiếu nhập, mã nhân viên nhập hàng,
 họ tên nhân viên, họ tên nhà cung cấp, ngày nhập hàng, ghi chú.
 */
SELECT SoPN, MaNV, MaNCC, Ngaynhap, GhiChu
FROM PhieuNhap
         JOIN Nhan_vien ON PhieuNhap.MaNV = Nhan_vien.MaNV
         JOIN NhaCungCap On PhieuNhap.MaNCC = NhaCungCap.MaNCC
WHERE MONTH(Ngaynhap) = 6
  AND YEAR(Ngaynhap) = 2018;

/*
 3. Liệt kê tất cả sản phẩm có đơn vị tính là chai, gồm tất cả thông tin về sản phẩm.
 */
SELECT MaSP, MaloaiSP, TenSP, Donvitinh, GhiChu
FROM SanPham
WHERE Donvitinh = 'Chai';

/*
 4. Liệt kê chi tiết nhập hàng trong tháng hiện hành gồm thông tin:
số phiếu nhập, mã sản phẩm, tên sản phẩm, loại sản phẩm, đơn vị tính, số lượng, giá
nhập, thành tiền.
 */
SELECT CTPhieuNhap.SoPN,
       CTPhieuNhap.MaSP,
       SanPham.TenSP,
       LoaiSP.TenloaiSP,
       SanPham.Donvitinh,
       Soluong,
       GiaNhap,
       (Soluong * GiaNhap) as ThanhTien
FROM CTPhieuNhap
         JOIN SanPham ON CTPhieuNhap.MaSP = SanPham.MaSP
         JOIN LoaiSP ON SanPham.MaloaiSP = LoaiSP.MaloaiSP
         JOIN PhieuNhap ON CTPhieuNhap.SoPN = PhieuNhap.SoPN
WHERE MONTH(PhieuNhap.Ngaynhap) = MONTH(CURDATE())
  AND YEAR(PhieuNhap.Ngaynhap) = YEAR(CURDATE());

/*
 5. Liệt kê các nhà cung cấp có giao dịch mua bán trong tháng hiện hành, gồm
thông tin: mã nhà cung cấp, họ tên nhà cung cấp, địa chỉ, số điện thoại,
email, số phiếu nhập, ngày nhập. Sắp xếp thứ tự theo ngày nhập hàng.
 */

SELECT PhieuNhap.MaNCC, TenNCC, DiaChi, DienThoai, Email, PhieuNhap.SoPN, PhieuNhap.Ngaynhap
FROM NhaCungCap
         JOIN PhieuNhap ON NhaCungCap.MaNCC = PhieuNhap.MaNCC
WHERE MONTH(PhieuNhap.Ngaynhap) = MONTH(CURDATE())
  AND YEAR(PhieuNhap.Ngaynhap) = YEAR(CURDATE())
ORDER BY PhieuNhap.Ngaynhap;

/*
6. Liệt kê chi tiết hóa đơn bán hàng trong 6 tháng đầu năm 2018 gồm thông tin:
số phiếu xuất, nhân viên bán hàng, ngày bán, mã sản phẩm, tên sản phẩm, đơn vị tính, số lượng, giá bán, doanh thu.
 */

SELECT CTPhieuXuat.SoPX,
       Nhan_vien.HoTen,
       NgayBan,
       CTPhieuXuat.MaSP,
       TenSP,
       Donvitinh,
       Soluong,
       GiaBan,
       (Soluong * GiaBan) as DoanhThu
FROM CTPhieuXuat
         JOIN PhieuXuat ON CTPhieuXuat.SoPX = PhieuXuat.SoPX
         JOIN Nhan_vien ON PhieuXuat.MaNV = Nhan_vien.MaNV
         JOIN SanPham ON CTPhieuXuat.MaSP = SanPham.MaSP
WHERE MONTH(PhieuXuat.NgayBan) BETWEEN 1 AND 6
  AND YEAR(PhieuXuat.NgayBan) = 2018;

/*
  Hãy in danh sách khách hàng có ngày sinh nhật trong tháng hiện hành (gồm tất cả thông tin của khách hàng)
 */
SELECT MaKH, TenKH, DiaChi, NgaySinh, SoDT
FROM KhachHang
WHERE MONTH(NgaySinh) = MONTH(CURDATE())
  AND YEAR(NgaySinh) = YEAR(CURDATE());

/*
 8. Liệt kê các hóa đơn bán hàng từ ngày 15/04/2018 đến 15/05/2018 gồm các thông tin: số phiếu xuất,
 nhân viên bán hàng, ngày bán, mã sản phẩm, tên sản phẩm, đơn vị tính, số lượng, giá bán, doanh thu.
 */
SELECT CTPhieuXuat.SoPX,
       Nhan_vien.HoTen,
       NgayBan,
       CTPhieuXuat.MaSP,
       TenSP,
       Donvitinh,
       Soluong,
       GiaBan,
       (Soluong * GiaBan) as DoanhThu
FROM CTPhieuXuat
         JOIN PhieuXuat ON CTPhieuXuat.SoPX = PhieuXuat.SoPX
         JOIN Nhan_vien ON PhieuXuat.MaNV = Nhan_vien.MaNV
         JOIN SanPham ON CTPhieuXuat.MaSP = SanPham.MaSP
WHERE DAY(PhieuXuat.NgayBan) = 15
  AND MONTH(PhieuXuat.NgayBan) BETWEEN 4 AND 5
  AND YEAR(PhieuXuat.NgayBan) = 2023;
/*
 9. Liệt kê các hóa đơn mua hàng theo từng khách hàng, gồm các thông tin:
 số phiếu xuất, ngày bán, mã khách hàng, tên khách hàng, trị giá.
 */
SELECT CTPhieuXuat.SoPX,
       PhieuXuat.NgayBan,
       KhachHang.MaKH,
       KhachHang.TenKH,
       (CTPhieuXuat.Soluong * CTPhieuXuat.GiaBan) AS TriGia
FROM CTPhieuXuat
         JOIN PhieuXuat ON PhieuXuat.SoPX = CTPhieuXuat.SoPX
         JOIN KhachHang ON KhachHang.MaKH = PhieuXuat.MaKH;
/*
 10. Cho biết tổng số chai nước xả vải Comfort đã bán trong 6 tháng đầu năm 2018.
 Thông tin hiển thị: tổng số lượng.
 */
SELECT Soluong
FROM CTPhieuXuat
         JOIN SanPham ON SanPham.MaSP = CTPhieuXuat.MaSP
WHERE TenSP = 'nước xả vải Comfort';

/*
 11.Tổng kết doanh thu theo từng khách hàng theo tháng, gồm các thông tin:
 tháng, mã khách hàng, tên khách hàng, địa chỉ, tổng tiền.
 */
SELECT MONTH(NgayBan)                                  AS NgayBan,
       PhieuXuat.MaKH,
       TenKH,
       DiaChi,
       SUM((CTPhieuXuat.Soluong * CTPhieuXuat.GiaBan)) as TongTien
FROM CTPhieuXuat
         JOIN PhieuXuat ON CTPhieuXuat.SoPX = PhieuXuat.SoPX
         JOIN KhachHang ON PhieuXuat.MaKH = KhachHang.MaKH
GROUP BY MONTH(NgayBan), PhieuXuat.MaKH;
/*
12.Thống kê tổng số lượng sản phẩm đã bán theo từng tháng trong năm, gồm thông tin:
năm, tháng, mã sản phẩm, tên sản phẩm, đơn vị tính, tổng số lượng.
*/
select YEAR(NgayBan) as Năm, MONTH(NgayBan) as Tháng, SanPham.MaSP, TenSP, Donvitinh, (Soluong) as SoLuong
from CTPhieuXuat
         join SanPham on SanPham.MaSP = CTPhieuXuat.MaSP
         join PhieuXuat on PhieuXuat.SoPX = CTPhieuXuat.SoPX;
# group by YEAR(NgayBan), MONTH(NgayBan), SanPham.MaSP, TenSP;
/*
13.Thống kê doanh thu bán hàng trong trong 6 tháng đầu năm 2018, thông tin hiển thị gồm: tháng, doanh thu.
*/
select MONTH(NgayBan) as Thang, SUM((GiaBan * CTPhieuXuat.Soluong - GiaNhap * CTPhieuNhap.Soluong)) as DoanhThu
from CTPhieuXuat
         join PhieuXuat on PhieuXuat.SoPX = CTPhieuXuat.SoPX
         join SanPham on SanPham.MaSP = CTPhieuXuat.MaSP
         join CTPhieuNhap on SanPham.MaSP = CTPhieuNhap.MaSP
group by MONTH(NgayBan);
/*
14.Liệt kê các hóa đơn bán hàng của tháng 5 và tháng 6 năm 2018, gồm các thông tin:
 số phiếu, ngày bán, họ tên nhân viên bán hàng, họ tên khách hàng, tổng trị giá.
*/
select CTPhieuXuat.SoPX, NgayBan, HoTen, TenKH, (Soluong * GiaBan) as TongTriGia
from CTPhieuXuat
         join PhieuXuat on CTPhieuXuat.SoPX = PhieuXuat.SoPX
         join Nhan_vien on Nhan_vien.MaNV = PhieuXuat.MaNV
         join KhachHang on KhachHang.MaKH = PhieuXuat.MaKH
where YEAR(NgayBan) = 2018
  and MONTH(NgayBan) between 5 and 6;
/*
15.Cuối ngày, nhân viên tổng kết các hóa đơn bán hàng trong ngày, thông tin gồm:
 số phiếu xuất, mã khách hàng, tên khách hàng, họ tên nhân viên bán hàng, ngày bán, trị giá.
*/
select CTPhieuXuat.SoPX, NgayBan, HoTen, TenKH, (Soluong * GiaBan) as TriGia
from CTPhieuXuat
         join PhieuXuat on CTPhieuXuat.SoPX = PhieuXuat.SoPX
         join Nhan_vien on Nhan_vien.MaNV = PhieuXuat.MaNV
         join KhachHang on KhachHang.MaKH = PhieuXuat.MaKH
where YEAR(NgayBan) = YEAR(CURDATE())
  and TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL 1 DAY) - INTERVAL 1 SECOND);

/*
16.Thống kê doanh số bán hàng theo từng nhân viên, gồm thông tin:
 mã nhân viên, họ tên nhân viên, mã sản phẩm, tên sản phẩm, đơn vị tính, tổng số lượng.
17.Liệt kê các hóa đơn bán hàng cho khách vãng lai (KH01) trong quý 2/2018,
thông tin gồm số phiếu xuất, ngày bán, mã sản phẩm, tên sản phẩm, đơn vị
tính, số lượng, đơn giá, thành tiền.
18.Liệt kê các sản phẩm chưa bán được trong 6 tháng đầu năm 2018, thông tin gồm:
 mã sản phẩm, tên sản phẩm, loại sản phẩm, đơn vị tính.
19.Liệt kê danh sách nhà cung cấp không giao dịch mua bán với cửa hàng trong
quý 2/2018, gồm thông tin:
mã nhà cung cấp, tên nhà cung cấp, địa chỉ, số điện thoại.
20.Cho biết khách hàng có tổng trị giá đơn hàng lớn nhất trong 6 tháng đầu năm 2018.
21.Cho biết mã khách hàng và số lượng đơn đặt hàng của mỗi khách hàng.
22.Cho biết mã nhân viên, tên nhân viên, tên khách hàng kể cả những nhân viên không đại diện bán hàng.
23.Cho biết số lượng nhân viên nam, số lượng nhân viên nữ
 */

/*
24.Cho biết mã nhân viên, tên nhân viên, số năm làm việc của những nhân viên
có thâm niên cao nhất.
 */
SELECT MaNV, HoTen, FLOOR(DATEDIFF(CURDATE(), NgayVaoLam) / 365) AS SoThamNien
FROM Nhan_vien
WHERE FLOOR(DATEDIFF(CURDATE(), NgayVaoLam) / 365) > 30
ORDER BY SoThamNien DESC;
/*
25.Hãy cho biết họ tên của những nhân viên đã đến tuổi về hưu (nam:60 tuổi,
nữ: 55 tuổi)
 */
SELECT HoTen
FROM Nhan_vien
WHERE (GioiTinh = 1 AND YEAR(CURDATE()) - YEAR(NgaySinh) >= 60)
   OR (GioiTinh = 0 AND YEAR(CURDATE()) - YEAR(NgaySinh) >= 55);

/*
26.Hãy cho biết họ tên của nhân viên và năm về hưu của họ.
 */
SELECT HoTen,
       IF(GioiTinh = 1, YEAR(NgaySinh) + 60, YEAR(NgaySinh) + 55) AS NamVeHuu
FROM Nhan_vien;

/*
27.Cho biết tiền thưởng tết dương lịch của từng nhân viên.
Biết rằng - thâm niên <1 năm thưởng 200.000 - 1 năm <= thâm niên < 3 năm thưởng 400.000 - 3 năm <=
thâm niên < 5 năm thưởng 600.000 - 5 năm <= thâm niên < 10 năm thưởng 800.000 - thâm niên >= 10 năm thưởng 1.000.000

 */
SELECT HoTen,
       CASE
           WHEN FLOOR(DATEDIFF(CURDATE(), NgayVaoLam) / 365) < 1 THEN 200000
           WHEN FLOOR(DATEDIFF(CURDATE(), NgayVaoLam) / 365) BETWEEN 1 AND 2 THEN 400000
           WHEN FLOOR(DATEDIFF(CURDATE(), NgayVaoLam) / 365) BETWEEN 3 AND 4 THEN 600000
           WHEN FLOOR(DATEDIFF(CURDATE(), NgayVaoLam) / 365) BETWEEN 5 AND 9 THEN 800000
           ELSE 1000000
           END AS TienThuongTet
FROM Nhan_vien;

/*
28.Cho biết những sản phẩm thuộc ngành hàng Hóa mỹ phẩm
*/
SELECT MaSP, TenSP
FROM LoaiSP p
         join SanPham on p.MaloaiSP = SanPham.MaloaiSP
WHERE p.TenloaiSP = 'Hóa mỹ phẩm';
/*
29.Cho biết những sản phẩm thuộc loại Quần áo.
*/
SELECT MaSP, TenSP
FROM LoaiSP p
         join SanPham on p.MaloaiSP = SanPham.MaloaiSP
WHERE p.TenloaiSP = 'Quần áo';
/*
30.Cho biết số lượng sản phẩm loại Quần áo.*/
SELECT TenSP, (CTPhieuNhap.Soluong) as SoLuong
from CTPhieuNhap
         join SanPham on SanPham.MaSP = CTPhieuNhap.MaSP
         join LoaiSP on SanPham.MaloaiSP = LoaiSP.MaloaiSP
WHERE LoaiSP.TenloaiSP = 'Quần áo';
/*
31.Cho biết số lượng loại sản phẩm ngành hàng Hóa mỹ phẩm.
*/
SELECT TenSP, (CTPhieuNhap.Soluong) as SoLuong
from CTPhieuNhap
         join SanPham on SanPham.MaSP = CTPhieuNhap.MaSP
         join LoaiSP on SanPham.MaloaiSP = LoaiSP.MaloaiSP
WHERE LoaiSP.TenloaiSP = 'Hoá mỹ phẩm';
/*
32.Cho biết số lượng sản phẩm theo từng loại sản phẩm.
 */
SELECT TenSP, (CTPhieuNhap.Soluong) as SoLuong
from CTPhieuNhap
         join SanPham on SanPham.MaSP = CTPhieuNhap.MaSP
         join LoaiSP on SanPham.MaloaiSP = LoaiSP.MaloaiSP
WHERE LoaiSP.MaloaiSP;