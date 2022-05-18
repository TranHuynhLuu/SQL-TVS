use master
go

if(exists(select name from master.sys.databases where name = 'thuvienso'))
drop database thuvienso
go

create database thuvienso
go

use thuvienso
go

create table nganhhoc(
	manganh int IDENTITY(1,1) not null,
	tennganh nvarchar(50) not null,
	constraint pk_nganhhoc primary key (manganh))
	go

create table monhoc(
	idmon int IDENTITY(1,1) not null,
	tenmon nvarchar(50) not null,
	manganh int not null,--khóa ngoại 
	constraint pk_monhoc primary key (idmon))
	go

create table khoaBM(
	idkhoa int IDENTITY(1,1) not null,
	tenkhoa nvarchar(50) not null,
	constraint pk_khoaBM primary key (idkhoa))
go

create table giangvien(
	magv varchar(10) not null,
	hoten nvarchar(50) not null,
	email varchar(50) not null,
	gioitinh nchar(5) not null,
	idkhoa int not null,--khóa ngoại 
	constraint pk_giangvien primary key (magv))
	go

create table sinhvien(
	masinhvien varchar(10) not null,
	idkhoa int not null,--khóa ngoại
	hoten nvarchar(50) not null,
	lop varchar(50) not null,
	gioitinh nchar(5) not null,
	constraint pk_sinhvien primary key (masinhvien))
	go

create table sach(
	masach int IDENTITY(1,1) not null,
	madanhmuc int not null,--khóa ngoại
	idmon int not null,--khóa ngoại
	tacgia nvarchar(50) not null,
	tensach nvarchar(50) not null,
	anh nvarchar(max) null,
	filedata nvarchar(max) not null,
	gioithieu nvarchar(max) null,
	luottai int null,
	luotxem int null,
	diemdanhgia float null,
	luotdanhgia int null,
	magv varchar(10) not null,--khóa ngoại
	ngaydang date not null,
	keyword nvarchar(50) null,
	constraint pk_sach primary key (masach))
	go



create table danhmuc(
	madanhmuc int IDENTITY(1,1) not null,
	tendanhmuc nvarchar(50) not null,
	constraint pk_danhmuc primary key (madanhmuc))
	go

create table thongke(
	idthongke int IDENTITY(1,1) not null,
	magv varchar(10) null,--khóa ngoại 
	masach int not null,--khóa ngoại
	masinhvien varchar(10) null,--khóa ngoại
	ngaytai date null,
	ngaydoc date not null,
	constraint pk_thongke primary key (idthongke))
	go

create table taikhoan(
	idaccount int IDENTITY(1,1) not null,
	username varchar(50) not null,
	passwords varchar(max) not null,
	loaiaccount int not null,
	magv varchar(10) null,
	masinhvien varchar(10) null,
	constraint pk_taikhoan primary key (username))
	go

alter table monhoc add constraint fk_monhoc foreign key (manganh) references nganhhoc (manganh)
go

alter table giangvien add constraint fk_giangvien foreign key (idkhoa) references khoaBM (idkhoa)
go

alter table sinhvien add constraint fk_sinhvien foreign key (idkhoa) references khoaBM (idkhoa)
go

alter table sach add constraint  fk_sach_monhoc foreign key (idmon) references monhoc (idmon)
go
alter table sach add constraint fk_sach_danhmuc foreign key (madanhmuc) references danhmuc (madanhmuc)
go
alter table sach add constraint fk_sach_giangvien foreign key (magv) references giangvien (magv)
go

alter table thongke add constraint fk_thongke_giangvien foreign key (magv) references giangvien (magv)
go
alter table thongke add constraint fk_thongke_sinhvien foreign key (masinhvien) references sinhvien (masinhvien)
go
alter table thongke add constraint fk_thongke_sach foreign key (masach) references sach (masach)
go

alter table taikhoan add constraint fk_taikhoan_giangvien foreign key (magv) references giangvien (magv)
go
alter table taikhoan add constraint fk_taikhoan_sinhvien foreign key (masinhvien) references sinhvien (masinhvien)
go
