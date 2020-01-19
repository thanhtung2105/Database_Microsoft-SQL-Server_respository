create database DEANCTY

drop database DEANCTY
--drop table NHANVIEN
--drop table DEAN
--drop table DIADIEM_PHG
--drop table PHONGBAN
--drop table THANNHAN
--drop table PHANCONG

use DEANCTY

create table NHANVIEN
(HONV char(15) not null,
TENLOT char(15) not null,
TENNV char(15) not null,
MANV char(4) primary key,
NGSINH datetime,
DCHI char(30),
PHAI char(3) constraint NV_PHAI_CHK check (PHAI IN('Nam','Nu')),
LUONG int constraint NV_LUONG_DF default (1000),
MA_NQL char(4),
PHG char(2))

create table DEAN
(TENDA char(15) not null,
MADA int primary key,
DDIEM_DA char (15),
PHONG char(2),
NGAYBD datetime,
NGAYKT datetime)

create table DIADIEM_PHG
(MAPHG char(2),
DIADIEM char(15) primary key)

create table PHONGBAN
(TENPHG char(15) not null,
MA_PHG char(2) primary key,
TRPHG char(4),
NG_NHANCHUC datetime)

create table THANNHAN
(MA_NVIEN char(4),
TENTN char(15) primary key,
PHAI char(3) constraint TN_PHAI_CK check (PHAI IN('Nam','Nu')),
NGSINH datetime,
QUANHE char(15))

create table PHANCONG
(MA_NVIEN char(4),
SODA int primary key,
THOIGIAN float(5))

alter table PHONGBAN add constraint FK_PHONGBAN_NHANVIEN foreign key (TRPHG) references NHANVIEN(MANV)
alter table DIADIEM_PHG add constraint FK_DIADIEM_PHG_PHONGBAN foreign key (MAPHG) references PHONGBAN(MA_PHG)
alter table PHANCONG add constraint FK_PHANCONG_NHANVIEN foreign key (MA_NVIEN) references NHANVIEN(MANV)
alter table PHANCONG add constraint FK_PHANCONG_DEAN foreign key (SODA) references DEAN(MADA)
alter table THANNHAN add constraint FK_THANNHAN_NHANVIEN foreign key (MA_NVIEN) references NHANVIEN(MANV)
alter table DEAN add constraint FK_DEAN_PHONGBAN foreign key (PHONG) references PHONGBAN(MA_PHG)


insert into NHANVIEN values ('TRAN','THANH','TIEN','1111',1969/07/02,'890 BUI THI XUAN Q1 TPHCM','NAM',300,'2222','NC')
insert into NHANVIEN values ('NGUYEN','THANH','NAM','2222',1965/08/01,'78 NGUYEN TRAI Q1 TPHCM','NAM',400,'8888','NC')
insert into NHANVIEN values ('LE','THANH','NGOC','3333',1970/09/12,'456 TRAN BINH TRONG Q5 TPHCM','NU',250,'4444','DH')
insert into NHANVIEN values ('TRAN','QUYNH','ANH','4444',1960/17/04,'132 BACH DANG QPN TPHCM','NU',430,'8888','DH')
insert into NHANVIEN values ('NGUYEN','ANH','KHOA','5555',1962/25/06,'67 TRAN PHU NHA TRANG','NAM',380,'2222','NC')
insert into NHANVIEN values ('TRAN','NGOC','LINH','6666',1975/12/08,'789 HUNG VUONG Q6 TPHCM','NU',250,'2222','NC')
insert into NHANVIEN values ('BUI','THANH','PHONG','7777',1969/28/10,'689 LY THUONG KIET TPHCM','NAM',250,'4444','DH')
insert into NHANVIEN values ('PHAM','VAN','HUNG','8888',1950/13/09,'67 BA TRIEU HA NOI','NAM',550,'','QL')

alter table NHANVIEN add constraint FK_NHANVIEN_NQL foreign key (MA_NQL) references NHANVIEN(MANV)
alter table NHANVIEN add constraint FK_NHANVIEN_PHONGBAN foreign key (PHG) references PHONGBAN(MA_PHG)

insert into THANNHAN values ('2222','MAI','NU',1986/05/04,'CON GAI')
insert into THANNHAN values ('2222','TUAN','NAM',1983/25/10,'CON TRAI')
insert into THANNHAN values ('2222','LINH','NU',1955/03/05,'VO CHONG')
insert into THANNHAN values ('4444','MINH','NAM',1952/28/02,'VO CHONG')
insert into THANNHAN values ('1111','DAT','NAM',1990/01/01,'CON TRAI')
insert into THANNHAN values ('1111','NGOC','NU',1995/30/12,'CON GAI')
insert into THANNHAN values ('1111','PHUONG','NU',1970/05/05,'VO CHONG')

insert into PHONGBAN values ('QUAN LY','QL','8888',1981/05/06)
insert into PHONGBAN values ('DIEU HANH ','DH','7777',1995/11/01)
insert into PHONGBAN values ('NGHIEN CUU','NC','2222',1988/26/08)

insert into DIADIEM_PHG values ('QL','TPHCM')
insert into DIADIEM_PHG values ('DH','HA NOI')
insert into DIADIEM_PHG values ('DH','TPHCM')
insert into DIADIEM_PHG values ('NC','NHA TRANG')
insert into DIADIEM_PHG values ('NC','DA NANG')
insert into DIADIEM_PHG values ('NC','TPHCM')


insert into DEAN values ('TIN HOC HOA 1','1','TP HCM','NC',2007/05/04,2008/23/08)
insert into DEAN values ('TIN HOC HOA 2','2','HA NOI','NC',2008/10/10,2008/30/12)
insert into DEAN values ('DAO TAO 1','10','NHA TRANG','DH',2005/05/05,2006/20/08)
insert into DEAN values ('DAO TAO 2','20','DA NANG','DH',2007/30/04,2008/19/09)

insert into PHANCONG values ('1111','1',32.5)
insert into PHANCONG values ('1111','2',7.5)
insert into PHANCONG values ('6666','1',20.0)
insert into PHANCONG values ('6666','2',20.0)
insert into PHANCONG values ('2222','2',10.0)
insert into PHANCONG values ('2222','10',10.0)
insert into PHANCONG values ('2222','20',10.0)
insert into PHANCONG values ('3333','10',10.0)
insert into PHANCONG values ('7777','10',35.0)
insert into PHANCONG values ('7777','20',15.0)
insert into PHANCONG values ('8888','20',20.0)

--Xuất ra các bảng:
select *from NHANVIEN
select *from DEAN
select *from DIADIEM_PHG
select *from PHONGBAN
select *from THANNHAN	
select *from PHANCONG
----------------------------------
select* from NHANVIEN
where (LUONG<300 and PHG='NC') 
or (LUONG>350 and PHG='QL')

select HONV,TENNV,TENNV
from NHANVIEN
where DCHI like '%TPHCM'

select* from NHANVIEN
where MA_NQL in ('2222','4444')

select* from NHANVIEN
where MA_NQL='2222' or MA_NQL='4444'

select* from NHANVIEN
where MA_NQL is null

--sắp xếp giảm dần
select* from NHANVIEN
order by LUONG desc,NGSINH

--phép hội
select* from NHANVIEN
where LUONG<300 and PHG='NC' UNION
select* from NHANVIEN
where LUONG>350 and PHG='QL'

--phép kết
select NV.HONV+''+NV.TENLOT+''+NV.TENNV as TEN
from NHANVIEN NV, PHONGBAN PB
where PB.TRPHG=NV.MANV and NV.LUONG>300

--phép kết nội
select PB.TENPHG, DD.DIADIEM
from PHONGBAN PB, DIADIEM_PHG DD
where PB.MA_PHG = DD.MAPHG

select PB.TENPHG,DD.DIADIEM
from
PHONGBAN PB INNER JOIN DIADIEM_PHG DD
on PB.MA_PHG = DD.MAPHG

--phép kết ngoại
SELECT NV1.HONV+' '+NV1.TENLOT+' '+NV1.TENNV AS
TENNV, NV2.HONV+' '+NV2.TENLOT+' '+NV2.TENNV AS
TENNQL
FROM NHANVIEN NV1, NHANVIEN NV2
WHERE NV1.MA_NQL=*NV2.MANV

select NV1.HONV+''+NV1.TENLOT+''+NV1.TENNV as
TENNV, NV2.HONV+''+NV2.TENLOT+''+NV2.TENNV as
TENNQL
from NHANVIEN NV1 LEFT OUTER JOIN NHANVIEN
NV2 on NV1.MA_NQL = NV2.MANV

--VD15
select DA.TENDA, sum(PC.THOIGIAN) as TONGTHOIGIAN
from DEAN DA, PHANCONG PC
where PC.SODA=DA.MADA
group by PC.SODA,DA.TENDA

--VD17
select (HONV+''+TENLOT+''+TENNV) as TEN, count(*) as SOTN
from NHANVIEN , THANNHAN 
where MANV=MA_NVIEN
group by MANV,HONV+''+TENLOT+''+TENNV



-- với các pB có mức lương TB>300, liệt kê tên PB & SL nhân viên của PB đó

select   PB.TENPHG, count(*)SO_NV
from NHANVIEN NV, PHONGBAN PB
where NV.PHG=PB.MA_PHG
group by PB.TENPHG, NV.PHG
having avg(LUONG)>300 

-- Tìm danh sách những nhân viên có trên 2 thân nhân
select HONV+''+TENLOT+''+TENNV as HoTen
from NHANVIEN
where MANV in
	(select MA_NVIEN
	from THANNHAN
	group by MA_NVIEN
	having count(*)>2)

---- Tìm danh sách những nhân viên không có thân nhân
select HONV+''+TENLOT+''+TENNV as HoTen
from NHANVIEN
where MANV not in
	(select MA_NVIEN
	from THANNHAN)

-- Tìm tên trưởng phòng chưa có gia đình
select HONV+''+TENLOT+''+TENNV as HoTen
from NHANVIEN NV, PHONGBAN PB
where NV.MANV=PB.TRPHG and NV.MANV not in
		(select MA_NVIEN
			from THANNHAN)

-- Cho biết họ tên các nhân viên có mức lương trên mức lương trung bình của phòng NGHIEN CUU
select HONV+''+TENLOT+''+TENNV as HoTen
from NHANVIEN NV
where NV.LUONG > 
		(select avg(LUONG)
		from NHANVIEN NV1, PHONGBAN PB
		where PB.TENPHG='NGHIEN CUU' and NV1.PHG=PB.MA_PHG)

--- Cho biết phòng ban có đông nhân viên nhất
select TENPHG
from PHONGBAN
where MA_PHG in
	(select PHG
	from NHANVIEN
	group by PHG
	having count(*)>=
	all(select count(*)
		from NHANVIEN
		group by PHG)
	)
-- >=all : lấy ra được giá trị lớn nhất

--LỒNG TƯƠNG QUAN:
-------------------------------------------
SELECT MANV, TENNV
FROM NHANVIEN, PHONGBAN
WHERE TENPHG='NGHIEN CUU' AND PHG=MA_PHG

SELECT MANV, TENNV
FROM NHANVIEN
WHERE EXISTS (SELECT *
FROM PHONGBAN
WHERE TENPHG='NGHIEN CUU'
AND PHG=MA_PHG )
-------------------------------------------

-- Cho biết danh sách đề án có nhân công với họ là BUI, hoặc có trưởng phòng chủ trì đề án với họ là BUI
select HONV+TENLOT+TENNV as HoTen, DA.TENDA, DA.MADA
from DEAN DA, NHANVIEN NV, PHANCONG PC
where NV.MANV=PC.MA_NVIEN and DA.MADA=PC.SODA and (NV.HONV='BUI' or 
			(select NV1.HONV
			from PHONGBAN PB, NHANVIEN NV1
			where DA.PHONG=PB.MA_PHG and NV1.MANV=PB.TRPHG and NV1.MANV=NV.MANV)='BUI')

--VD 26: Tìm họ tên và địa chỉ của những nhân viên làm việc cho đề án ở TP HCM, nhưng phòng ban không ở TP HCM
-- BTVN
select HONV+TENLOT+TENNV as HoTen
from DEAN DA, NHANVIEN NV, PHANCONG PC




--PHÉP CHIA
SELECT PC1.MA_NVIEN
FROM PHANCONG PC1
WHERE NOT EXISTS (
SELECT *
FROM DEAN DA
WHERE NOT EXISTS (
SELECT *
FROM PHANCONG PC2
WHERE PC2.SODA=DA.MADA AND
PC1.MA_NVIEN=PC2.MA_NVIEN
))

-- Tìm danh sách những nhân viên đc phân công tất cả các đề án do phòng NC chủ trì




--BÀI TẬP THỰC HÀNH
--		1. Cho viết điểm trung bình của sinh viên Nguyên Thanh Bình (điểm trung bình của tất cả các môn thi, lần thi).
--		2. Với mỗi sinh viên, cho biết số môn mà sinh viên đó đã học, số môn đã thi đậu (điểm thi >=5) và số môn rớt.
--		3. Tìm môn mà chưa sinh viên nào theo học.
--		4. Tìm tất cả các môn học mà sinh viên chương trình chính quy, khoa công nghệ thông tin phải theo học.
--		5. Tính tỷ lệ sinh viên đạt điểm khá, giỏi (điểm thi >=7).
--		6. Với mỗi lớp thuộc khoa Công nghệ thông tin, cho biết mã lớp, mã khóa học và số SV tuộc lớp đó.
--		7. Cho biết sinh viên CNTT, khóa 2002-2006 chưa học môn cấu trúc dữ liệu 1.
--		8. Cho biết sinh viên thi không đậu (điểm thi <5) môn cấu trúc dữ liệu 1 nhưng chưa thi lại.
--		9. Cho biết điểm trung bình của sinh viên mã số 0212003 (điểm trung bình chỉ tính trên lần thi sau cùng của sinh viên)
--		10. Tính điểm trung bình của tất cả các sinh viên (điểm trung bình tính trên lần thi sau cùng của sinh viên)
--		