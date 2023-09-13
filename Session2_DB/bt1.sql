-- phiếu xuất
create table Phieu_xuat
(
    so_px     int auto_increment
        primary key,
    dg_xuat   float                    not null,
    sl_xuat   int                      not null,
    ngay_xuat date default (curdate()) null
);

create index Phieu_xuat_dg_xuat_index
    on Phieu_xuat (dg_xuat);

create index Phieu_xuat_sl_xuat_index
    on Phieu_xuat (sl_xuat);

-- phiếu nhập
create table phieu_nhap
(
    so_pn     int                      not null
        primary key,
    ngay_nhap date default (curdate()) null,
    sl_nhap   int                      not null,
    dg_nhap   float                    not null
);

create index phieu_nhap_dg_nhap_index
    on phieu_nhap (dg_nhap);

create index phieu_nhap_sl_nhap_index
    on phieu_nhap (sl_nhap);

-- vattu
create table vattu
(
    ma_vtu  int         not null
        primary key,
    ten_vtu varchar(20) not null,
    dg_xuat float       not null,
    sl_xuat int         not null,
    dg_nhap float       not null,
    sl_nhap int         not null,

    constraint vattu_Phieu_xuat_dg_xuat_fk
        foreign key (dg_xuat) references Phieu_xuat (dg_xuat),
    constraint vattu_Phieu_xuat_sl_xuat_fk
        foreign key (sl_xuat) references Phieu_xuat (sl_xuat),
    constraint vattu_phieu_nhap_dg_nhap_fk
        foreign key (dg_nhap) references phieu_nhap (dg_nhap),
    constraint vattu_phieu_nhap_sl_nhap_fk
        foreign key (sl_nhap) references phieu_nhap (sl_nhap)
);

-- đơn đặt hàng
create table don_dh
(
    so_dh   int                      not null
        primary key,
    ngay_dh date default (curdate()) null
);

-- nhà cung cấp
create table nha_cc
(
    ma_ncc    int         not null
        primary key,
    ten_nhacc varchar(30) not null,
    dia_chi   text        not null,
    sdt       int         not null
);