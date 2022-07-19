create database TourTravel
go
use TourTravel
go
create table HuongDanVien
(
	MaHDV varchar(10) primary key,
	TenHDV nvarchar(100) not null,
	GioiTinh bit null,
	DiaChi nvarchar(200) not null,
	SDT varchar(12) not null,
)
go
create table PhuongTien
(
	MaPT varchar(10) primary key,
	TenPT nvarchar(100) not null,
	SoGhe int not null,
)
go
create table Tour
(
	MaTour varchar(10) primary key,
	TenTour nvarchar(100) not null,
	NgayKhoiHanhDuKen datetime not null,
	NgayKetThucDuKien datetime not null,
)
go
create table Di
(
	MaTour varchar(10) not null,
	MaPT varchar(10) not null,

	foreign key(MaTour) references Tour(MaTour),
	foreign key(MaPT) references PhuongTien(MaPT),
)
go
create table KhachSan
(
	MaKS varchar(10) primary key,
	TenKS nvarchar(100) not null,
	DiaChi datetime not null,
)
go
create table DiaDemThamQuan
(
	MaDDTQ varchar(10) primary key,
	TenTour nvarchar(100) not null,
	NgayKhoiHanhDuKen datetime not null,
	NgayKetThucDuKien datetime not null,

	MaKS varchar(10)
)
go