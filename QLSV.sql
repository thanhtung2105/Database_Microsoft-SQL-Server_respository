create database QLSV

create table Khoa
(ma varchar(10) not Null,
tenKhoa nvarchar(100) not Null,
namThanhLap int,
primary key (ma))

create table KhoaHoc
(Ma varchar(10) not Null,
namBatDau int,
namKetThuc int,
primary key (Ma))

create table SinhVien
(Ma varchar(10) not Null,
hoTen nvarchar(100) not Null,
namSinh int,
danToc nvarchar(20),
maLop varchar(10),
primary key (Ma))

create table ChuongTrinh
(Ma varchar(10) not Null,
tenChuongTrinh nvarchar(100) not Null,
primary key (Ma))

create table MonHoc
(Ma varchar(10) not Null,
tenMonHoc nvarchar(100) not Null,
maKhoa varchar(10) not null,
primary key (Ma))

create table KetQua
(maSinhVien varchar(10) not null,
maMonHoc varchar(10) not null,
lanThi int not null,
diem float,
primary key (maSinhVien,lanThi,maMonhoc))

create table GiangKhoa
(maChuongTrinh varchar(10) not null,
maKhoa varchar(10) not null,
maMonHoc varchar(10) not null,
namHoc int,
hocKy int,
soTietLyThuyet int,
soTietThucHanh int,
soTinChi int,
primary key (maChuongTrinh,maKhoa,maMonHoc))

create table Lop
(Ma varchar(10) not null,
maKhoaHoc varchar(10) not null,
maKhoa varchar(10) not null,
maChuongTrinh varchar(10) not null,
soThuTu int,
primary key (Ma))

alter table SinhVien
add constraint PK_SV_Lop 
foreign key(maLop) 
references Lop(Ma)

alter table MonHoc 
add constraint PK_MH_Khoa 
foreign key(maKhoa) 
references Khoa(ma)

alter table KetQua 
add constraint PK_KQ_SV 
foreign key(maSinhVien) 
references SinhVien(Ma)

alter table KetQua 
add constraint PK_KQ_SV1 
foreign key(maMonHoc) 
references MonHoc(Ma)

alter table GiangKhoa 
add constraint PK_GK_CT 
foreign key(maChuongTrinh) 
references ChuongTrinh(Ma)

alter table GiangKhoa 
add constraint PK_GK_Khoa 
foreign key(maKhoa) 
references Khoa(ma)

alter table GiangKhoa 
add constraint PK_GK_MH 
foreign key(maMonHoc) 
references MonHoc(Ma)

alter table Lop 
add constraint PK_Lop_KH 
foreign key(maKhoaHoc) 
references KhoaHoc(Ma)

alter table Lop 
add constraint PK_Lop_Khoa 
foreign key(maKhoa) 
references Khoa(ma)

alter table Lop 
add constraint PK_Lop_CT 
foreign key(maChuongTrinh) 
references ChuongTrinh(Ma)

insert into Khoa values('CNTT',N'Công nghệ thông tin',1995)
insert into Khoa values('VL',N'Vật Lý',1970)
select *from Khoa
insert into KhoaHoc values('K2002',2002,2006)
insert into KhoaHoc values('K2003',2003,2007)
insert into KhoaHoc values('K2004',2004,2008)
select *from KhoaHoc
insert into ChuongTrinh values('CQ',N'Chính Qui')
select *from ChuongTrinh
insert into MonHoc Values('THT01',N'Toán Cao cấp A1','CNTT')
insert into MonHoc Values('VLT01',N'Vật lý cao cấp A1','VL')
insert into MonHoc Values('THT02',N'Toán rời rạc','CNTT')
insert into MonHoc Values('THCS01',N'Cấu trúc dữ liệu 1','CNTT')
insert into MonHoc Values('THCS02',N'Hệ điều hành','CNTT')
select *from MonHoc
insert into Lop values('TH2002/01','K2002','CNTT','CQ',1)
insert into Lop values('TH2002/02','K2002','CNTT','CQ',2)
insert into Lop values('TH2003/01','K2003','VL','CQ',1)
select *from Lop
insert into SinhVien values(0212001,N'Nguyễn Vĩnh An',1984,'Kinh','TH2002/01')
insert into SinhVien values(0212002,N'Nguyên Thanh Bình',1985,'Kinh','TH2002/01')
insert into SinhVien values(0212003,N'Nguyễn Thanh Cường',1984,'Kinh','TH2002/02')
insert into SinhVien values(0212004,N'Nguyễn Quốc Duy',1983,'Kinh','TH2002/02')
insert into SinhVien values(0311001,N'Phan Tuấn Anh',1985,'Kinh','VL2003/01')
insert into SinhVien values(0311002,N'Huỳnh Thanh Sang',1984,'Kinh','VL2003/01')
select *from SinhVien
insert into KetQua values(0212001,'THT01',1,4)
insert into KetQua values(0212001,'THT01',2,7)
insert into KetQua values(0212002,'THT01',1,8)
insert into KetQua values(0212003,'THT01',1,6)
insert into KetQua values(0212004,'THT01',1,9)
insert into KetQua values(0212001,'THT02',1,8)
insert into KetQua values(0212002,'THT02',1,5.5)
insert into KetQua values(0212003,'THT02',1,4)
insert into KetQua values(0212003,'THT02',2,6)
insert into KetQua values(0212001,'THCS01',1,6.5)
insert into KetQua values(0212002,'THCS01',1,4)
insert into KetQua values(0212003,'THCS01',1,7)
select *from KetQua
insert into GiangKhoa values('CQ','CNTT','THT01',2003,1,60,0,5)
insert into GiangKhoa values('CQ','CNTT','THT02',2003,2,45,0,4)
insert into GiangKhoa values('CQ','CNTT','THCS01',2004,1,45,30,4)
select *from GiangKhoa

---Danh sách sinh viên khoa "Công nghệ thông tin"---
select SV.hoTen
from SinhVien SV,Lop L,Khoa K
where SV.maLop=L.Ma 
and L.maKhoa=K.Ma 
and K.tenKhoa=N'Công nghệ thông tin'

---Danh sách sinh viên khóa 2002-2006---
select *
from SinhVien SV,KhoaHoc KH,Lop L
where SV.maLop=L.Ma 
and L.maKhoaHoc=KH.Ma 
and KH.namBatDau=2002 
and KH.namKetThuc=2006

---Danh sách sinh viên đậu (điểm >=5) môn toán cao cấp A1---
select *
from SinhVien SV,MonHoc MH,KetQua KQ
where SV.Ma=KQ.maSinhVien 
and KQ.maMonHoc=MH.Ma 
and MH.tenMonHoc=N'Toán Cao cấp A1' 
and KQ.diem>=5

---Liệt kê sinh viên có họ "Nguyễn" và đã học môn toán rời rạc---
select distinct SV.Ma,SV.hoTen,SV.namSinh,MH.tenMonHoc
from SinhVien SV,MonHoc MH,KetQua KQ
where SV.Ma=KQ.maSinhVien 
and KQ.maMonHoc=MH.Ma 
and SV.hoTen like N'Nguyễn%' 
and MH.tenMonHoc=N'Toán rời rạc'

---Liệt kê các khoa thành lập hơn 25 năm---
 

---Cho biết các sinh viên (MSSV,họ tên, năm sinh) học sớm hơn tuổi quy định(theo tuổi qui định thì sinh viên đủ 18 tuổi khi bắt đầu khóa học)---
select SV.Ma,SV.hoTen,SV.namSinh
from SinhVien SV, KhoaHoc KH,Lop L
where SV.maLop=L.Ma 
and L.maKhoaHoc=KH.Ma 
and KH.namBatDau-SV.namSinh<18

---Cho biết 2 sinh viên có điểm thi Toán cao cấp A1 cao nhất---
select top(2) SV.Ma,SV.hoTen,Sv.namSinh,MH.tenMonHoc,KQ.diem
from SinhVien SV,KetQua KQ,MonHoc MH
where SV.Ma=KQ.maSinhVien 
and KQ.maMonHoc=MH.Ma 
and tenMonHoc=N'Toán Cao cấp A1' 
order by KQ.diem desc

---Cho biết điểm trung bình của sinh viên Nguyên Thanh Bình (điểm trung bình của tất cả môn thi,lần thi)---
select SV.Ma,SV.hoTen,AVG(KQ.diem) DiemTB
from SinhVien SV,KetQua KQ
where SV.Ma=KQ.maSinhVien 
and SV.hoTen=N'Nguyên Thanh Bình' 
group by SV.Ma,SV.hoTen

---Tìm môn mà chưa sinh viên nào theo học---
select *
from MonHoc
where Ma not in 
(select maMonHoc
from KetQua )

---Tìm tất cả các môn học mà sinh viên chương trình chính quy, khoa công nghệ thông tin phải theo học---
select *
from MonHoc
where Ma in
(select maMonHoc
from GiangKhoa GK, ChuongTrinh CT, Khoa K
where K.ma=GK.maKhoa 
and CT.Ma=GK.maChuongTrinh 
and CT.tenChuongTrinh=N'Chính Qui' 
and K.tenKhoa=N'Công nghệ thông tin')

---Tính tỉ lệ sinh viên đạt điểm khá, giỏi(điểm>=7)---
select 
(select COUNT(*)
from KetQua KQ1
where KQ1.diem>=7)
*100/
(select COUNT (*)
from KetQua KQ2)

---Với mỗi lớp thuộc khoa Công nghệ thông tin, cho biết mã lớp, mã khóa học và số sinh viên thuộc lớp đó---
select L.Ma,L.maKhoaHoc,COUNT(SV.Ma) SoSV
from Lop L, Khoa K, SinhVien SV
where L.Ma=SV.maLop 
and L.maKhoa=K.ma
and K.tenKhoa=N'Công nghệ thông tin'
group by L.Ma,L.maKhoaHoc

---Cho biết sinh viên khoa CNTT, khóa 2002-2006 chưa học môn cấu trúc dữ liệu 1---
select SV.Ma,SV.hoTen,SV.namSinh,SV.danToc,SV.maLop
from SinhVien SV, KhoaHoc KH, Lop L, Khoa K
where SV.maLop=L.Ma 
and L.maKhoaHoc=KH.Ma
and L.maKhoa=K.ma
and K.tenKhoa=N'Công nghệ thông tin'
and KH.namBatDau=2002
and KH.namKetThuc=2006
and SV.Ma not in (
select KQ.maSinhVien
from MonHoc MH, KetQua KQ
where MH.Ma=KQ.maMonHoc
and MH.tenMonHoc=N'Cấu trúc dữ liệu 1')


---Cho biết điểm trung bình của sinh viên mã số 0212003 (điểm trung bình chỉ tính trên lần thi sau cùng của sinh viên)---
select AVG(KQ1.diem)DiemTB
from KetQua KQ1
where maSinhVien=0212003
and KQ1.lanThi=
(select MAX(KQ2.lanThi)
from KetQua KQ2
where KQ1.maSinhVien=KQ2.maSinhVien
and KQ1.maMonHoc=KQ2.maMonHoc)

                      ------------------------Bài tập về nhà------------------------------

---Với mỗi sinh viên, cho biết số môn mà sinh viên đó đã học, số môn đã thi đậu (điểm thi >=5) và số môn rớt---
select *
from SinhVien
where Ma in(
select COUNT(*),SV1.Ma
from SinhVien SV1, KetQua KQ1, MonHoc MH1
where SV1.Ma=KQ1.maSinhVien
and KQ1.maMonHoc=MH1.Ma
and KQ1.lanThi=1
group by SV1.Ma)
select COUNT(*),SV2.Ma
from SinhVien SV2, KetQua KQ2
where SV2.Ma=KQ2.maSinhVien
and KQ2.diem>=5
group by SV2.Ma

---Cho biết sinh viên thi không đậu (điểm thi<5) môn cấu trúc dữ liệu 1 nhưng chưa thi lại---
select *
from SinhVien SV, MonHoc MH1, KetQua KQ1
where SV.Ma=KQ1.maSinhVien
and KQ1.maMonHoc=MH1.Ma
and MH1.tenMonHoc=N'Cấu trúc dữ liệu 1'
and KQ1.diem<5
and SV.Ma not in
(select KQ2.maSinhVien
from KetQua KQ2
where KQ1.maMonHoc=KQ2.maMonHoc
and KQ2.lanThi=2)

---Tính điểm trung bình của tất cả các sinh viên (điểm trung bình tính trên lần thi sau cùng của sinh viên)---
select KQ1.maSinhVien,AVG(KQ1.diem)DiemTB
from KetQua KQ1
where KQ1.lanThi=
(select MAX(KQ2.lanThi)
from KetQua KQ2
where KQ1.maSinhVien=KQ2.maSinhVien
and KQ1.maMonHoc=KQ2.maMonHoc)
group by KQ1.maSinhVien




-- Câu 1: Tạo view V1 danh sách các sinh viên Khoa 'Công nghệ thông tin'
create view V1 as 
select SV.Ma,SV.hoTen,K.tenKhoa
from SinhVien SV, Lop L, Khoa K
where SV.maLop=L.Ma and L.maKhoa=K.ma and K.tenKhoa=N'Công nghệ thông tin'
select * from V1

-- Câu 2: Tạo view V2 danh sách sinh viên khóa 2002-2006
create view V2 as 
select SV.Ma,SV.hoTen,SV.malop,KH.namBatDau,KH.namKetThuc
from SinhVien SV, Lop L,KhoaHoc KH
where SV.maLop=L.Ma and L.maKhoaHoc=KH.Ma and KH.namBatDau='2002' and KH.namKetThuc='2006'
select * from V2

-- Câu 3: Tạo view V3 danh sách các môn mà chưa sinh viên nào theo học
create view V3 as
select *
from MonHoc
where Ma not in 
(select maMonHoc
from KetQua)
select * from V3

-- Câu 4: Tạo view V4 danh sách sinh viên thi đậu môn Toán Cao cấp A1
create view V4 as
select SV.Ma,SV.hoTen,MH.tenMonHoc,KQ.lanThi,KQ.diem
from SinhVien SV,MonHoc MH,KetQua KQ
where SV.Ma=KQ.maSinhVien 
and KQ.maMonHoc=MH.Ma 
and MH.tenMonHoc=N'Toán Cao cấp A1' 
and KQ.diem>=5
select * from V4

-- Câu 5: Tìm sinh viên có điểm thi Toán Cao cấp A1 cao nhất từ view V4
select top(1)*
from V4
order by diem desc

-- Câu 6: Đổi tên view V2 thành VSV02
sp_rename V2,VSV02
select * from VSV02

-- Câu 7: ChuongTrinh.Ma chỉ có thể là 'CQ' hoặc 'CD' hoặc 'TC'
-- Cách 1: Check.
alter table ChuongTrinh 
add constraint ck_CT
check (Ma in('CQ','CD','TC'))
-- Cách 2:
create rule R4 as @Ma='CQ' or @Ma='CD' or @Ma='TC'
sp_bindrule 'R4','ChuongTrinh.Ma'

-- Câu 8: Chỉ có 2 học kì là 'HK1' và 'HK2'
-- Cách 1:
alter table GiangKhoa 
add constraint hk_GK
check (hocKy in(1,2))
-- Cách 2:
create rule R2 as @hocKy=1 and @hocKy=2
sp_bindrule 'R2','GiangKhoa.hocKy'

-- Câu 9: Số tiết lý thuyết(GiangKhoa.soTietLyThuyet) tối đa là 120
-- Cách 1:
alter table GiangKhoa 
add constraint tiet_GK
check (soTietLyThuyet<=120)
-- Cách 2:
create rule R3 as @soTietLyThuyet<=120
sp_bindrule 'R3','GiangKhoa.soTietLyThuyet'

-- Câu 10: Số tiết thực hành(GiangKhoa.soTietThucHanh) tối đa là 120
-- Cách 1:
create rule R10 as @TTH <=120
sp_bindrule 'R10','GiangKhoa.soTietThucHanh'
-- Cách 2: Check
alter table GiangKhoa
add constraint tietTH_GK
check (soTietThucHanh<=120)

-- Câu 11: Số tín chỉ(GiangKhoa.soTinChi) của một môn học tối đa là 6
-- Cách 1:
create rule R11 as @TC <=6
sp_bindrule 'R11','GiangKhoa.soTinChi'
-- Cách 2:
alter table GiangKhoa
add constraint soTC_GK
check (soTinChi<=6)

-- Câu 12: Điểm thi(KetQua.diem) được chấm theo thang điểm 10, chính xác đến 1 chữ số sau dấu phấy
-- Câu 1:
create rule R12 as @diem=round(@diem,1) and @diem<=10 and @diem>=0
sp_bindrule 'R12','KetQua.diem'
-- Câu 2: Check
alter table KetQua
add constraint diem_KQ
check (diem=round(diem,1) and diem<=10 and diem>=0)


-- Câu 1: Tạo view V1 danh sách các sinh viên Khoa 'Công nghệ thông tin'
create view V1 as 
select SV.Ma,SV.hoTen,K.tenKhoa
from SinhVien SV, Lop L, Khoa K
where SV.maLop=L.Ma and L.maKhoa=K.ma and K.tenKhoa=N'Công nghệ thông tin'
select * from V1

-- Câu 2: Tạo view V2 danh sách sinh viên khóa 2002-2006
create view V2 as 
select SV.Ma,SV.hoTen,SV.malop,KH.namBatDau,KH.namKetThuc
from SinhVien SV, Lop L,KhoaHoc KH
where SV.maLop=L.Ma and L.maKhoaHoc=KH.Ma and KH.namBatDau='2002' and KH.namKetThuc='2006'
select * from V2

-- Câu 3: Tạo view V3 danh sách các môn mà chưa sinh viên nào theo học
create view V3 as
select *
from MonHoc
where Ma not in 
(select maMonHoc
from KetQua)
select * from V3

-- Câu 4: Tạo view V4 danh sách sinh viên thi đậu môn Toán Cao cấp A1
create view V4 as
select SV.Ma,SV.hoTen,MH.tenMonHoc,KQ.lanThi,KQ.diem
from SinhVien SV,MonHoc MH,KetQua KQ
where SV.Ma=KQ.maSinhVien 
and KQ.maMonHoc=MH.Ma 
and MH.tenMonHoc=N'Toán Cao cấp A1' 
and KQ.diem>=5
select * from V4

-- Câu 5: Tìm sinh viên có điểm thi Toán Cao cấp A1 cao nhất từ view V4
select top(1)*
from V4
order by diem desc

-- Câu 6: Đổi tên view V2 thành VSV02
sp_rename V2,VSV02
select * from VSV02

-- Câu 7: ChuongTrinh.Ma chỉ có thể là 'CQ' hoặc 'CD' hoặc 'TC'
-- Cách 1: Check.
alter table ChuongTrinh 
add constraint ck_CT
check (Ma in('CQ','CD','TC'))
-- Cách 2:
create rule R4 as @Ma='CQ' or @Ma='CD' or @Ma='TC'
sp_bindrule 'R4','ChuongTrinh.Ma'

-- Câu 8: Chỉ có 2 học kì là 'HK1' và 'HK2'
-- Cách 1:
alter table GiangKhoa 
add constraint hk_GK
check (hocKy in(1,2))
-- Cách 2:
create rule R2 as @hocKy=1 and @hocKy=2
sp_bindrule 'R2','GiangKhoa.hocKy'

-- Câu 9: Số tiết lý thuyết(GiangKhoa.soTietLyThuyet) tối đa là 120
-- Cách 1:
alter table GiangKhoa 
add constraint tiet_GK
check (soTietLyThuyet<=120)
-- Cách 2:
create rule R3 as @soTietLyThuyet<=120
sp_bindrule 'R3','GiangKhoa.soTietLyThuyet'

-- Câu 10: Số tiết thực hành(GiangKhoa.soTietThucHanh) tối đa là 120
-- Cách 1:
create rule R10 as @TTH <=120
sp_bindrule 'R10','GiangKhoa.soTietThucHanh'
-- Cách 2: Check
alter table GiangKhoa
add constraint tietTH_GK
check (soTietThucHanh<=120)

-- Câu 11: Số tín chỉ(GiangKhoa.soTinChi) của một môn học tối đa là 6
-- Cách 1:
create rule R11 as @TC <=6
sp_bindrule 'R11','GiangKhoa.soTinChi'
-- Cách 2:
alter table GiangKhoa
add constraint soTC_GK
check (soTinChi<=6)

-- Câu 12: Điểm thi(KetQua.diem) được chấm theo thang điểm 10, chính xác đến 1 chữ số sau dấu phấy
-- Câu 1:
create rule R12 as @diem=round(@diem,1) and @diem<=10 and @diem>=0
sp_bindrule 'R12','KetQua.diem'
-- Câu 2: Check
alter table KetQua
add constraint diem_KQ
check (diem=round(diem,1) and diem<=10 and diem>=0)


--________________________________________________________________________
--1.1.	Với 1 mã sinh viên và 1 mã khoa, kiểm tra xem sinh viên có thuộc khoa này không (trả về đúng hoặc sai)
create function kiemtrasv
	(@maKhoa char(10), @maSV char(10))
returns	int
BEGIN
	declare @maKT char(10), @maSVi char(10), @xet int
	select  @maSVi=SV.Ma, @maKT=Lop.maKhoa
			from
			Sinhvien SV, Lop
			where
				SV.maLop=Lop.Ma
	if @maKhoa=@maKT
	set @xet=1
	else set @xet=0
	return @xet
END
drop function kiemtrasv
SELECT 	dbo.kiemtrasv('CNTT','0212001')

select* from Sinhvien
select* from Lop


--1.2.	Tính điểm thi sau cùng của một sinh viên trong một môn học cụ thể
create function kiemtradiemthiSV
	(@maSV char(10), @maMH char(10))
returns	float

BEGIN	
		declare @diem int
		select @diem=KQ.diem
		from KetQua KQ, MonHoc MH
		where KQ.maMonHoc=MH.Ma and KQ.maSinhVien=@maSV and KQ.maMonHoc=@maMH
				and KQ.lanThi=(select max(KQtam.lanThi)
					from KetQua KQtam
					where KQ.maSinhVien=KQtam.maSinhVien and KQ.maMonHoc=KQtam.maMonHoc)
		return @diem	
END
drop function kiemtradiemthiSV
SELECT 	dbo.kiemtradiemthiSV('0212003','THT02')

select* from KetQua

--1.3.	Tính điểm trung bình của một sinh viên (chú ý: điểm trung bình được tính dựa trên lần thi sau cùng), sử dụng function ở câu 2 đã viết

create view KQtam as
select SV.Ma, KQ.maMonHoc, lanThi, KQ.diem
from KetQua KQ, Sinhvien SV
where SV.Ma=KQ.maSinhVien and KQ.diem=dbo.kiemtradiemthiSV(SV.Ma,KQ.maMonHoc)

create function diemTBSV
	(@maSV varchar(10))
returns float
BEGIN
	declare @kqtb float, @diemm float
	select @diemm=KQtam.diem
	from KQtam
	where KQtam.Ma=@maSV
	set @kqtb=avg(@diemm)
	return @diemTB
END


drop view KQtam
select * from KQtam
select * from KetQua

--1.4.	Nhập vào 1 sinh viên và 1 môn học, trả về các điểm thi của sinh viên này trong các lần thi của môn học đó. 
create function xuatdiemthi
	(@maSV char(10), @maMH char(10))
returns	table
return	(
		select KQ.lanThi, KQ.diem
		from KetQua KQ, MonHoc MH
		where KQ.maMonHoc=MH.Ma and KQ.maSinhVien=@maSV and KQ.maMonHoc=@maMH)

drop function xuatdiemthi
SELECT* from dbo.xuatdiemthi('0212003','THT02')

select* from KetQua

--1.5.	Nhập vào 1 sinh viên, trả về danh sách các môn học mà sinh viên này phải học.
create function cacmoncanhoc
	(@maSV char(10))
returns table
return	(
			select MH.tenMonHoc
			from MonHoc MH, Sinhvien SV, Lop L, Khoa K
			where SV.Ma=@maSV and L.maKhoa=K.ma and L.Ma=SV.maLop and MH.maKhoa=K.ma
		)
select* from dbo.cacmoncanhoc('0212003')




--18/12 thi TH

--========================================================================
--1. Viết stored procedure, dùng lệnh print in ra danh sách sinh viên:
create procedure DSSINHVIEN
as
Begin
		declare @ma varchar(10)
		declare @hoten nvarchar(30)
		
		declare cur_sv cursor
		FOR
			Select Ma, hoTen
			from Sinhvien 
		Open cur_sv
		fetch cur_sv into @ma, @hoten

		While (@@fetch_status=0)
		Begin
			Print 'Ma:' + @ma + ' la sinh vien ' + @hoten
			fetch cur_sv into @ma, @hoten
		End

		close cur_sv
		deallocate cur_sv
End

drop proc DSSINHVIEN

execute DSSINHVIEN

--2. Viết stored procedure, dùng lệnh print in ra danh sách các môn học:

create procedure DSMONHOC
as
Begin
		declare @maMH varchar(10)
		declare @tenMonHoc nvarchar(30)
		
		declare cur_tenmon cursor
		FOR
			Select Ma, tenMonHoc
			from MonHoc MH
		Open cur_tenmon
		fetch cur_tenmon into @maMH, @tenMonHoc

		While (@@fetch_status=0)
		Begin
			Print 'Ma mon hoc =' + @maMH
			Print 'Ten mon hoc la:' + @tenMonHoc

			fetch cur_tenmon into @maMH, @tenMonHoc
		End

		close cur_tenmon
		deallocate cur_tenmon
End

execute DSMONHOC

--=====================================================
--3. Viết stored procedure in điểm các môn học của sinh viên có mã số là maSinhVien được nhập vào. (Chú ý: điểm của 
--môn học là điểm thi của lần thi sau cùng). Các môn chưa có điểm thì ghi điểm là <chưa có điểm>:


create procedure KQthi (@maSV varchar(10))
as