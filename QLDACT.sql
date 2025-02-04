create database QLDACT

create table NHANVIEN
(HONV nvarchar(20) not null,
TENLOT nvarchar(20) not null,
TENNV nvarchar(20) not null,
MANV varchar(10),
NGSINH date,
DCHI nvarchar(100),
PHAI char(3) check(PHAI IN('NAM','NU')),
LUONG int,
MA_NQL varchar(10),
PHG varchar(10) ,
primary key (MANV))

create table DEAN
(TENDA nvarchar(100),
MADA varchar(10) ,
DDIEM_DA nvarchar(100),
PHONG varchar(10),
NGAYBD date,
NGAYKT date,
primary key(MADA))

create table DIADIEM_PHG
(MAPHG varchar(10) ,
DIADIEM nvarchar(100),
primary key(MAPHG,DIADIEM))

create table PHONGBAN
(TENPHOG nvarchar(30),
MAPHG varchar(10),
TRPHG varchar(10),
NG_NHANCHUC date,
primary key (MAPHG))

create table THANNHAN
(MA_NVIEN varchar(10),
TENTN nvarchar(20),
PHAI char(3) check(PHAI IN('NAM','NU')),
NGSINH date,
QUANHE nvarchar(20),
primary key(MA_NVIEN,TENTN))

create table PHANCONG
(MA_NVIEN varchar(10),
SODA varchar(10),
THOIGIAN float(1),
primary key(MA_NVIEN,SODA))

alter table NHANVIEN
add constraint PK_NV_NV 
foreign key(MA_NQL) 
references NHANVIEN(MANV)

alter table NHANVIEN 
add constraint PK_NV_PB 
foreign key(PHG) 
references PHONGBAN(MAPHG)

alter table PHONGBAN 
add constraint PK_PB_NV 
foreign key(TRPHG) 
references NHANVIEN(MANV)

alter table DIADIEM_PHG add constraint PK_DDP_PB foreign key(MAPHG) references PHONGBAN(MAPHG)
alter table DEAN add constraint PK_DA_PB foreign key(PHONG) references PHONGBAN(MAPHG)
alter table PHANCONG add constraint PK_PC_NV foreign key(MA_NVIEN) references NHANVIEN(MANV)
alter table PHANCONG add constraint PK_PC_DA foreign key(SODA) references DEAN(MADA)
alter table THANNHAN add constraint PK_TN_NV foreign key(MA_NVIEN) references NHANVIEN(MANV)

insert into NHANVIEN (HONV,TENLOT,TENNV,MANV,NGSINH,DCHI,PHAI,LUONG)
values ('TRAN','THANH','TIEN','1111','02/07/1969','890 BUI THI XUAN Q1 TPHCM','NAM',300)
insert into NHANVIEN (HONV,TENLOT,TENNV,MANV,NGSINH,DCHI,PHAI,LUONG)
values ('NGUYEN','THANH','NAM','2222','01/08/1965','78 NGUYEN TRAI Q1 TPHCM','NAM',400)
insert into NHANVIEN (HONV,TENLOT,TENNV,MANV,NGSINH,DCHI,PHAI,LUONG)
values ('LE','THANH','NGOC','3333','12/09/1970','456 TRAN BINH TRONG Q5 TPHCM','NU',250)
insert into NHANVIEN (HONV,TENLOT,TENNV,MANV,NGSINH,DCHI,PHAI,LUONG)
values ('TRAN','QUYNH','ANH','4444','04/17/1960','123 BACH DANG QPN TPHCM','NU',430)
insert into NHANVIEN (HONV,TENLOT,TENNV,MANV,NGSINH,DCHI,PHAI,LUONG)
values ('NGUYEN','ANH','KHOA','5555','06/25/1962','67 TRAN PHU NHA TRANG','NAM',380)
insert into NHANVIEN (HONV,TENLOT,TENNV,MANV,NGSINH,DCHI,PHAI,LUONG)
values ('TRAN','NGOC','LINH','6666','08/12/1975','789 HUNG VUONG Q6 TPHCM','NU',250)
insert into NHANVIEN (HONV,TENLOT,TENNV,MANV,NGSINH,DCHI,PHAI,LUONG)
values ('BUI','THANH','PHONG','7777','10/28/1969','689 LY THUONG KIET TPHCM','NAM',250)
insert into NHANVIEN (HONV,TENLOT,TENNV,MANV,NGSINH,DCHI,PHAI,LUONG)
values ('PHAM','VAN','HUNG','8888','09/13/1950','67 BA TRIEU HA NOI','NAM',550)
select *from NHANVIEN

insert into DEAN (TENDA,MADA,DDIEM_DA,NGAYBD,NGAYKT)
values('TIN HOC HOA 1','1','TP HCM','04/05/2007','08/23/2008')
insert into DEAN (TENDA,MADA,DDIEM_DA,NGAYBD,NGAYKT)
values('TIN HOC HOA 2','2','HA NOI','10/10/2008','12/30/2008')
insert into DEAN (TENDA,MADA,DDIEM_DA,NGAYBD,NGAYKT)
values('DAO TAO 1','10','NHA TRANG','12/05/2005','08/20/2006')
insert into DEAN (TENDA,MADA,DDIEM_DA,NGAYBD,NGAYKT)
values('DAO TAO 2','20','DA NANG','04/30/2007','09/19/2008')
select *from DEAN

insert PHONGBAN values('QUAN LY','QL','8888','06/05/1981')
insert PHONGBAN values('DIEU HANH','DH','7777','01/11/1995')
insert PHONGBAN values('NGHIEN CUU','NC','2222','08/26/1988')
select *from PHONGBAN

insert DIADIEM_PHG values('QL','TPHCM')
insert DIADIEM_PHG values('DH','HA NOI')
insert DIADIEM_PHG values('DH','TPHCM')
insert DIADIEM_PHG values('NC','NHA TRANG')
insert DIADIEM_PHG values('NC','DA NANG')
insert DIADIEM_PHG values('NC','TPHCM')
select *from DIADIEM_PHG

insert THANNHAN values('2222','MAI','NU','04/05/1986','CON GAI')
insert THANNHAN values('2222','TUAN','NAM','10/25/1983','CON TRAI')
insert THANNHAN values('2222','LINH','NU','05/03/1955','VO CHONG')
insert THANNHAN values('4444','MINH','NAM','02/28/1952','VO CHONG')
insert THANNHAN values('1111','DAT','NAM','01/01/1990','CON TRAI')
insert THANNHAN values('1111','NGOC','NU','12/30/1995','CON GAI')
insert THANNHAN values('1111','PHUONG','NU','05/05/1970','VO CHONG')
select *from THANNHAN

insert PHANCONG values('1111','1',32.5)
insert PHANCONG values('1111','2',7.5)
insert PHANCONG values('6666','1',20.0)
insert PHANCONG values('6666','2',20.0)
insert PHANCONG values('2222','2',10.0)
insert PHANCONG values('2222','10',10.0)
insert PHANCONG values('2222','20',10.0)
insert PHANCONG values('3333','10',10.0)
insert PHANCONG values('7777','10',35.0)
insert PHANCONG values('7777','20',15.0)
insert PHANCONG values('8888','20',20.0)
select *from PHANCONG

update NHANVIEN set MA_NQL='2222' where MANV='1111'
update NHANVIEN set MA_NQL='8888' where MANV='2222'
update NHANVIEN set MA_NQL='4444' where MANV='3333'
update NHANVIEN set MA_NQL='8888' where MANV='4444'
update NHANVIEN set MA_NQL='2222' where MANV='5555'
update NHANVIEN set MA_NQL='2222' where MANV='6666'
update NHANVIEN set MA_NQL='4444' where MANV='7777'

update NHANVIEN set PHG='NC' where MANV='1111'
update NHANVIEN set PHG='NC' where MANV='2222'
update NHANVIEN set PHG='DH' where MANV='3333'
update NHANVIEN set PHG='DH' where MANV='4444'
update NHANVIEN set PHG='NC' where MANV='5555'
update NHANVIEN set PHG='NC' where MANV='6666'
update NHANVIEN set PHG='DH' where MANV='7777'
update NHANVIEN set PHG='QL' where MANV='8888'

update DEAN set PHONG='NC' where MADA='1'
update DEAN set PHONG='NC' where MADA='2'
update DEAN set PHONG='DH' where MADA='10'
update DEAN set PHONG='DH' where MADA='20'







                                  ---Bài tập về nhà---

---Tìm họ tên và địa chỉ của những nhân viên làm việc cho đề án ở HCM nhưng phòng ban mà họ trực thuộc lại không tọa lạc ở HCM---
select distinct NV.HONV+' '+NV.TENLOT+' '+NV.TENNV as HOTENNV,NV.DCHI
from NHANVIEN NV, DEAN DA, DIADIEM_PHG DDP, PHONGBAN PB
where NV.PHG=PB.MAPHG
and PB.MAPHG=DA.PHONG
and DA.PHONG=DDP.MAPHG
and DA.DDIEM_DA='TP HCM'
and DDP.DIADIEM!='TP HCM'

---Tìm danh sách những nhân viên được phân công tất cả đề án do phòng NC chủ trì---
select *
from NHANVIEN NV
where MANV in (
select PC1.MA_NVIEN
from PHANCONG PC1
where not exists(
select *
from DEAN DA
where DA.PHONG='NC'
and
not exists(
select *
from PHANCONG PC2
where PC2.SODA=DA.MADA
and PC1.MA_NVIEN=PC2.MA_NVIEN
)))

alter table NHANVIEN add GHICHU char(50)

ALTER TABLE KHOA ALTER COLUMN tenKHOA
NVARCHAR(100) NOT NULL

alter table NHANVIEN drop column GHICHU

select * from KHOA