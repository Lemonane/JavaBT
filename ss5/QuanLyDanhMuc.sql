create schema quanLySanPham character set utf8mb4 collate utf8mb4_vietnamese_ci;
use quanLySanPham;
create table DanhMucSanPham
(
    MaDanhMuc  int auto_increment primary key,
    TenDanhMuc varchar(50) not null unique,
    MoTa       text,
    TrangThai  bit default 1
);

create table SanPham
(
    MaSanPham   varchar(5) primary key,
    TenSanPham  varchar(100) not null unique,
    NgayTao     date  default (CURDATE()),
    Gia         float default 0,
    MoTaSanPham text,
    TieuDe      varchar(200),
    MaDanhMuc   int,
    TrangThai   bit   default 1,
    foreign key (MaDanhMuc) references DanhMucSanPham (MaDanhMuc)
);

INSERT INTO DanhMucSanPham (TenDanhMuc, MoTa)
VALUES ('Danh Mục 1', 'Mô tả danh mục 1'),
       ('Danh Mục 2', 'Mô tả danh mục 2');

INSERT INTO SanPham (MaSanPham, TenSanPham, Gia, MoTaSanPham, TieuDe, MaDanhMuc)
VALUES ('SP001', 'Sản Phẩm 1', 25000, 'Mô tả sản phẩm 1', 'Tieu de sản phẩm 1', 1),
       ('SP002', 'Sản Phẩm 2', 30000, 'Mô tả sản phẩm 2', 'Tieu de sản phẩm 2', 1),
       ('SP003', 'Sản Phẩm 3', 18000, 'Mô tả sản phẩm 3', 'Tieu de sản phẩm 3', 2);

create view SanPhamGiaLonHon20000 as
select D.MaDanhMuc,
       D.TenDanhMuc,
       D.TrangThai as TrangThaiDanhMuc,
       S.MaSanPham,
       S.TenSanPham,
       S.Gia,
       S.TrangThai as TrangThaiSanPham
from SanPham S
         join DanhMucSanPham D on S.MaDanhMuc = D.MaDanhMuc
where S.Gia > 20000;

-- Thêm
DELIMITER //
CREATE PROCEDURE AddDanhMuc(IN ten VARCHAR(50), IN moTa TEXT, IN trangThai BIT)
BEGIN
    INSERT INTO DanhMucSanPham(TenDanhMuc, MoTa, TrangThai) VALUES (ten, moTa, trangThai);
END;
//
DELIMITER ;

CALL AddDanhMuc('danhmuc', 'Mô tả danh mục mới', 1);

-- Sửa
DELIMITER //
CREATE PROCEDURE UpdateDanhMuc(IN ma INT, IN ten VARCHAR(50), IN moTa TEXT, IN trangThai BIT)
BEGIN
    UPDATE DanhMucSanPham SET TenDanhMuc = ten, MoTa = moTa, TrangThai = trangThai WHERE MaDanhMuc = ma;
END;
//
DELIMITER ;

CALL UpdateDanhMuc(1,'Ten Mới' , 'Mô tả danh mục mới',1);

-- Xóa
DELIMITER //
CREATE PROCEDURE DeleteDanhMuc(IN ma INT)
BEGIN
    DELETE FROM DanhMucSanPham WHERE MaDanhMuc = ma;
END;
//
DELIMITER ;

CALL DeleteDanhMuc(1);

-- Lấy tất cả
DELIMITER //
CREATE PROCEDURE GetAllDanhMuc()
BEGIN
    SELECT * FROM DanhMucSanPham;
END;
//
DELIMITER ;

CALL GetAllDanhMuc;

-- Lấy danh mục theo mã
DELIMITER //
CREATE PROCEDURE GetDanhMucByMa(IN ma INT)
BEGIN
    SELECT * FROM DanhMucSanPham WHERE MaDanhMuc = ma;
END;
//
DELIMITER ;

call GetDanhMucByMa(2);

-- Procedure cho phép lấy ra tất cả các phẩm có trạng thái là 1
DELIMITER //
CREATE PROCEDURE GetSanPhamTrangThai1()
BEGIN
    SELECT MaSanPham, TenSanPham, Gia, TenDanhMuc, SanPham.TrangThai
    FROM SanPham
             JOIN DanhMucSanPham ON SanPham.MaDanhMuc = DanhMucSanPham.MaDanhMuc
    WHERE SanPham.TrangThai = 1;
END;
//
DELIMITER ;

-- Thống kê sản phẩm theo mã danh mục

DELIMITER //
CREATE PROCEDURE ThongKeSanPham()
BEGIN
    SELECT MaDanhMuc, COUNT(MaSanPham)
    FROM SanPham
    GROUP BY MaDanhMuc;
END;
//
DELIMITER ;

--  procedure cho phép tìm kiếm sản phẩm theo tên sản phầm:
DELIMITER //
CREATE PROCEDURE TimKiemSanPham(IN ten VARCHAR(100))
BEGIN
    SELECT MaSanPham, TenSanPham, Gia, SanPham.TrangThai, TenDanhMuc, DanhMucSanPham.TrangThai
    FROM SanPham
             JOIN DanhMucSanPham ON SanPham.MaDanhMuc = DanhMucSanPham.MaDanhMuc
    WHERE SanPham.TenSanPham LIKE CONCAT('%', ten, '%');
END;
//
DELIMITER ;

