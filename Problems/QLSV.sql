create database QLSV
drop database QLSV
--drop table Khoa
--drop table SinhVien
--drop table KetQua
--drop table Lop
--drop table ChuongTrinh
--drop table GiangKhoa
--drop table MonHoc
--drop table KhoaHoc
use QLSV

create table Khoa
(ma varchar(10) primary key,
tenKHOA nvarchar(100) not null,
namThanhLap int)

create table KhoaHoc
(Ma varchar(10) primary key,
namBATDAU int,
namKetThuc int)

create table Sinhvien
(Ma varchar(10) primary key,
hoTen nvarchar(100) not null,
namSinh int not null,
danToc nvarchar(20) not null,
maLop varchar(10))

create table ChuongTrinh
(Ma varchar(10) primary key,
tenChuongTrinh nvarchar(100))

create table MonHoc
(Ma varchar(10) primary key,
tenMonHoc nvarchar(100),
maKhoa varchar(10))

create table KetQua
(maSinhVien varchar(10) not null,
maMonHoc varchar(10) not null,
lanThi int not null,
diem float,
primary key(maSinhVien,maMonHoc,lanThi))

create table GiangKhoa
(maChuongTrinh varchar(10) not null,
maKhoa varchar(10) not null,
maMonHoc varchar(10) not null,
namHoc int,
hocKy int,
soTietLyThuyet int,
soTietThucHanh int,
soTinChi int
primary key(maChuongTrinh,maKhoa,maMonHoc))

create table Lop
(Ma varchar(10) primary key,
maKhoaHoc varchar(10),
maKhoa varchar(10),
maChuongTrinh varchar(10),
soThuTu int)

alter table KetQua add constraint FK_KetQua_Sinhvien foreign key (maSinhVien) references Sinhvien(Ma)
alter table KetQua add constraint FK_KetQua_MonHoc foreign key (maMonHoc) references MonHoc(Ma)
alter table GiangKhoa add constraint FK_GiangKhoa_ChuongTrinh foreign key (maChuongTrinh) references ChuongTrinh(Ma)
alter table GiangKhoa add constraint FK_GiangKhoa_Khoa foreign key (maKhoa) references Khoa(ma)
alter table MonHoc add constraint FK_MonHoc_Khoa foreign key (maKhoa) references Khoa(ma)
alter table GiangKhoa add constraint FK_GiangKhoa_MonHoc foreign key (maMonHoc) references MonHoc(Ma)
alter table Lop add constraint FK_Lop_KhoaHoc foreign key (maKhoaHoc) references KhoaHoc(ma)
alter table Lop add constraint FK_Lop_ChuongTrinh foreign key (maChuongTrinh) references ChuongTrinh(Ma)
alter table Lop add constraint FK_Lop_Khoa foreign key (maKhoa) references Khoa(ma)
alter table Sinhvien add constraint FK_Sinhvien_Lop foreign key (maLop) references Lop(Ma)

insert into Khoa values ('CNTT',N'Công nghệ thông tin',1995)
insert into Khoa values ('VL',N'Vật lý',1970)

insert into KhoaHoc values ('K2002',2002,2006)
insert into KhoaHoc values ('K2003',2003,2007)
insert into KhoaHoc values ('K2004',2003,2008)

insert into ChuongTrinh values ('CQ',N'Chính quy')

insert into MonHoc values ('THT01',N'Toán Cao cấp A1','CNTT')
insert into MonHoc values ('VLT01',N'Vật lý cao cấp A1','VL')
insert into MonHoc values ('THT02',N'Toán rời rạc','CNTT')
insert into MonHoc values ('THCS01',N'Cấu trúc dữ liệu 1','CNTT')
insert into MonHoc values ('THCS02',N'Hệ điều hành','CNTT')

insert into Lop values ('TH2002/01','K2002','CNTT','CQ',1)
insert into Lop values ('TH2002/02','K2002','CNTT','CQ',2)
insert into Lop values ('TH2003/01','K2003','VL','CQ',1)

insert into Sinhvien values ('0212001',N'Nguyễn Vĩnh An',1984,'Kinh','TH2002/01')
insert into Sinhvien values ('0212002',N'Nguyên Thanh Bình',1985,'Kinh','TH2002/01')
insert into Sinhvien values ('0212003',N'Nguyễn Thanh Cường',1984,'Kinh','TH2002/01')
insert into Sinhvien values ('0212004',N'Nguyễn Quốc Duy',1983,'Kinh','TH2002/01')
insert into Sinhvien values ('0312001',N'Phan Tuấn Anh',1985,'Kinh','VL2003/01')
insert into Sinhvien values ('0312002',N'Huỳnh Thanh Sang',1984,'Kinh','VL2003/01')

insert into KetQua values ('0212001','THT01',1,4)
insert into KetQua values ('0212001','THT01',2,7)
insert into KetQua values ('0212002','THT01',1,8)
insert into KetQua values ('0212003','THT01',1,6)
insert into KetQua values ('0212004','THT01',1,9)
insert into KetQua values ('0212001','THT02',1,8)
insert into KetQua values ('0212002','THT02',1,5.5)
insert into KetQua values ('0212003','THT02',1,4)
insert into KetQua values ('0212003','THT02',2,6)
insert into KetQua values ('0212001','THCS01',1,6.5)
insert into KetQua values ('0212002','THCS01',1,4)
insert into KetQua values ('0212003','THCS01',1,7)

insert into GiangKhoa values ('CQ','CNTT','THT01',2003,1,60,0,5)
insert into GiangKhoa values ('CQ','CNTT','THT02',2003,2,45,0,4)
insert into GiangKhoa values ('CQ','CNTT','THCS01',2004,1,45,30,4)

--Xuất ra các bảng:
select* from Sinhvien
select* from KetQua
select* from Lop
select* from ChuongTrinh
select* from GiangKhoa
select* from MonHoc
select* from KhoaHoc

--cập nhật dữ liệu:
update Sinhvien set hoTen=N'Nguyễn Thanh Cường', danToc='Kinh'
where Ma='0212003'
select* from Sinhvien

--BTVN: Nhập liệu đề án CTY

--1. Danh sách SV khoa CNTT
select SV.Ma, SV.hoTen, SV.namSinh, Khoa.tenKhoa
from Sinhvien SV, Lop, Khoa
where (SV.maLop=SV.Ma and Lop.maKhoa=Khoa.ma) and maKhoa=N'Công Nghệ Thông Tin'

--2. Danh sách SV khóa 2002-2006
select SV.hoTen as TEN, SV.namSinh, KH.namBATDAU, KH.namKetThuc
from Sinhvien SV, KhoaHoc KH, Lop
where (Lop.Ma=SV.maLop) and (KH.namBATDAU like 2002) and (KH.namKetThuc like 2006) 

--3. Danh sách SV thi đậu (điểm >=5) môn toán cao cấp A1 Sinh viên đTHT01>5
select SV.hoTen as SVquamonToanA1, SV.danToc, SV.namSinh, KQ.diem
from KetQua KQ, Sinhvien SV
where (SV.Ma=KQ.maSinhVien) and (maMonHoc='THT01') and (diem>5)

--4. Liệt kê các SV có họ Nguyễn đã học môn toán rời rạc
select distinct (SV.hoTen), MonHoc.tenMonHoc
from Sinhvien SV, KetQua KQ, MonHoc
where (SV.hoTen like N'Nguyễn%') and (SV.Ma=KQ.maSinhVien) and (KQ.maMonHoc=MonHoc.Ma) and (MonHoc.tenMonHoc like N'Toán rời rạc')


--5. Liệt kê các Khoa thành lập hơn 25 năm
select tenKHOA 
from Khoa
where (year(getdate())-namThanhLap)>25

--6. Cho biết các SV(MSSV, hoten,namsinh) học sớm hơn số tuổi quy định (theo quy định SV đủ 18 tuổi khi bắt đầu)
select SV.Ma as MSSV, SV.hoTen as hoten, SV.namSinh as namsinh, KhoaHoc.namBATDAU
from Sinhvien SV, KhoaHoc, Lop
where ((Lop.Ma=SV.maLop) and (Lop.maKhoaHoc=KhoaHoc.Ma)) and (KhoaHoc.namBATDAU-SV.namSinh)<18

--7. Cho biết 2 SV có điểm thi toán cao cấp A1 cao nhất
select top(2) SV.hoTen as HoTen, tenMonHoc as Tenmonhoc, KQ.diem
from Sinhvien SV, KetQua KQ, MonHoc
where ((SV.Ma=KQ.maSinhVien) and (KQ.maMonHoc=MonHoc.Ma)) and (MonHoc.tenMonHoc=N'Toán Cao cấp A1')
order by KQ.diem desc

-- where -> group by -> having -> select -> from -> where

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

-- Câu 1:
select avg(KQ.diem) diemTB
from Sinhvien SV, KetQua KQ
where SV.Ma=KQ.maSinhVien and SV.hoTen=N'Nguyên Thanh Bình'

-- Câu 2:

-- Câu 3:
select MH.tenMonHoc nullSV
from MonHoc MH
where Ma not in
	(select maMonHoc
	from KetQua)

-- Câu 4:
select distinct MH.tenMonHoc CQ_CNTT_phaihoc
from MonHoc MH, GiangKhoa GK, Khoa K, ChuongTrinh CT
where (GK.maMonHoc=MH.Ma) and (K.ma=GK.maKhoa) and (CT.Ma=GK.maChuongTrinh) and (CT.tenChuongTrinh=N'Chính quy')
		and (K.tenKHOA=N'Công Nghệ Thông Tin')

-- Câu 5: Tính tỷ lệ sinh viên đạt điểm khá, giỏi (điểm thi >=7).
select 
	(select count(*)
	from KetQua KQ1
	where (KQ1.diem>=7))*100/
	(select count(KQ.diem)tong
	from KetQua KQ) as tylekhagioi

-- Câu 6: Với mỗi lớp thuộc khoa Công nghệ thông tin, cho biết mã lớp, mã khóa học và số SV thuộc lớp đó.
select Lop.Ma, Lop.maKhoaHoc, count(*)So_SV
from Khoa K, Sinhvien SV, Lop, KhoaHoc KH
where (K.tenKHOA=N'Công Nghệ Thông Tin') and (SV.maLop=Lop.Ma) and (K.ma=Lop.maKhoa)
group by Lop.Ma, Lop.maKhoaHoc

select * from Lop

--7. Cho biết sinh viên CNTT, khóa 2002-2006 chưa học môn cấu trúc dữ liệu 1.
select distinct SV.hoTen
from Sinhvien SV, Lop L, MonHoc MH, KetQua KQ
where (L.Ma=SV.maLop) and L.maKhoa='CNTT' and L.maKhoaHoc='K2002' 
		and (L.maKhoa=MH.maKhoa)
		and MH.tenMonHoc=N'Cấu trúc dữ liệu 1' 
		and (MH.Ma=KQ.maMonHoc)
		
		and MH.Ma not in
			(select maMonHoc
			from KetQua)

--8. Cho biết sinh viên thi không đậu (điểm thi <5) môn cấu trúc dữ liệu 1 nhưng chưa thi lại.
select distinct SV.hoTen
from Sinhvien SV, KetQua KQ, MonHoc MH
where SV.Ma=KQ.maSinhVien and KQ.lanThi=1 and KQ.diem<5 and
		MH.Ma=KQ.maMonHoc and MH.tenMonHoc=N'Cấu trúc dữ liệu 1'

--9. Cho biết điểm trung bình của sinh viên mã số 0212003 (điểm trung bình chỉ tính trên lần thi sau cùng của sinh viên)
select avg(KQ1.diem)diemtb
from KetQua KQ1
where maSinhVien='0212003' and 
		KQ1.lanThi=(select max(KQ2.lanThi)
					from KetQua KQ2
					where KQ1.maSinhVien=KQ2.maSinhVien and KQ1.maMonHoc=KQ2.maMonHoc) 

--10. Tính điểm trung bình của tất cả các sinh viên (điểm trung bình tính trên lần thi sau cùng của sinh viên)


--BTVN - 2 ví dụ trên lớp, câu 2, 8, 10 bài TH. 24h 22/10 
-- MSSV_Hoten_BTTH#6



-- VD về code
DECLARE @count int
SELECT @count=15
WHILE @count > 0
BEGIN
SELECT @count=@count-1
IF @count=4
BEGIN
BREAK
END
IF @count=6
BEGIN
CONTINUE
END
PRINT @count
END

--____________________________________

CREATE PROCEDURE InTenMonHoc (@maMon varchar(10))
AS
BEGIN
--Khai báo biến @tenMon
DECLARE @tenMon nvarchar (100)
--Tìm tên môn học ứng với @maMon, sau đó gán giá trị vừa tìm được cho @tenMon
SELECT @tenMon = tenMonHoc
FROM MonHoc
WHERE Ma = @maMon
--In tên môn học ra màn hình
PRINT N'Tên môn học là: '+ @tenMon
END

execute InTenMonHoc THT01
--______________________________________

-- Câu 1: In danh sách các sinh viên của 1 lớp học (mã lớp là tham số đầu vào):
create procedure DSSV (@maLop varchar(10))
as
Begin
	select Ma, hoTen, namSinh, danToc
	from Sinhvien
	where maLop=@maLop
End

execute DSSV 'VL2003/01'


-- Câu 2: Nhập vào 2 sinh viên, 1 môn học, tìm xem sinh viên nào có điểm thi môn đó cao hơn?
create procedure SoSanhSV (@maSV1 varchar(7), @maSV2 varchar(7), @maMH varchar(10))
as
Begin		
declare @hoTen1 nvarchar(100), @kq1 int, @hoTen2 nvarchar(100), @kq2 int
Begin	
			select @hoTen1=hoTen, @kq1=diem
			from
			Sinhvien SV, KetQua KQ
			where 
				KQ.maSinhVien=SV.Ma and KQ.maMonHoc=@maMH and KQ.maSinhVien=@maSV1 and KQ.lanThi=1
End
Begin
			select @hoTen2=hoTen, @kq2=diem
			from
			Sinhvien SV, KetQua KQ
			where 
				KQ.maSinhVien=SV.Ma and KQ.maMonHoc=@maMH and KQ.maSinhVien=@maSV2 and KQ.lanThi=1
End
If @kq1>@kq2
print N'Sinh vien diem cao hon la: ' + @hoTen1
else
print N'Sinh vien diem cao hon la: ' + @hoTen2
End
			
drop procedure SoSanhSV
execute SoSanhSV '0212001','0212002','THT01'


-- Câu 3: Nhập vào 1 môn học và 1 mã sv, kiểm tra xem sinh viên có đậu môn này trong lần thi đầu tiên không, nếu
-- đậu thì xuất ra là “Đậu”, không thì xuất ra “Không đậu”
create procedure KTdaurot (@maMH varchar(10), @maSV varchar(10))
as
Begin		
			declare @hoTen nvarchar(100), @kq float
			select @hoTen=hoTen, @kq=diem
			from
			Sinhvien SV, KetQua KQ
			where 
				KQ.maSinhVien=SV.Ma and KQ.maMonHoc=@maMH and KQ.maSinhVien=@maSV and KQ.lanThi=1
End

If @kq>=5
print N'Sinh vien ' + @hoTen + N' đã ĐẬU!'
else
print N'Sinh vien ' + @hoTen + N' rớt mất tiêu rồi!'
			
drop procedure KTdaurot
execute KTdaurot 'THCS01','0212002'

-- Câu 4: Nhập vào 1 khoa, in danh sách các sinh viên (mã sinh viên, họ tên, ngày sinh) thuộc khoa này.
create procedure DSSV_Khoa (@maKhoa varchar(10))
as
Begin
	select SV.Ma, SV.hoTen, SV.namSinh, SV.danToc
	from Sinhvien SV, Khoa K, Lop L
	where K.ma=@maKhoa and L.maKhoa=K.ma and L.Ma=SV.maLop
End

execute DSSV_Khoa 'CNTT'

-- Câu 5: Nhập vào 1 sinh viên và 1 môn học, in điểm thi của sinh viên này của các lần thi môn học đó.
create procedure TTthicu (@maSV varchar(10), @maMH varchar(10))
as
Begin		
			select KQ.lanThi, KQ.diem
			from
			Sinhvien SV, KetQua KQ
			where 
				KQ.maSinhVien=SV.Ma and KQ.maMonHoc=@maMH and KQ.maSinhVien=@maSV
End
			
drop procedure TTthicu
execute TTthicu '0212001','THT01'

-- Câu 6: Nhập vào 1 sinh viên, in ra các môn học mà sinh viên này phải học.
create procedure TraCuuMH (@maSV varchar(10))
as
Begin		
			select MH.tenMonHoc
			from MonHoc MH, Sinhvien SV, Lop L, Khoa K
			where SV.Ma=@maSV and L.maKhoa=K.ma and L.Ma=SV.maLop and MH.maKhoa=K.ma
End
			
drop procedure TraCuuMH
execute TraCuuMH '0212001'

-- Câu 7: Nhập vào 1 môn học, in danh sách các sinh viên đậu môn này trong lần thi đầu tiên.
create procedure ThiDauLanDau (@maMH varchar(10))
as
Begin		
			select SV.hoTen
			from Sinhvien SV, KetQua KQ
			where KQ.maSinhVien=SV.Ma and KQ.maMonHoc=@maMH and KQ.lanThi=1 and KQ.diem>=5
End
			
drop procedure ThiDauLanDau
execute ThiDauLanDau 'THT01'


-- Câu 8: In điểm các môn học của sinh viên có mã số là maSinhVien được nhập vào. 
--(Chú ý: điểm của môn học là điểm thi của lần thi sau cùng) Chỉ in các môn đã có điểm.

create procedure KetQuaThi (@maSV varchar(10))
as
Begin	
		select   MH.tenMonHoc ,KQ.diem
		from KetQua KQ, Sinhvien SV, MonHoc MH
		where	SV.Ma=KQ.maSinhVien and KQ.maMonHoc=MH.Ma and SV.Ma=@maSV
				and KQ.lanThi=(select max(KQtam.lanThi)
					from KetQua KQtam
					where KQ.maSinhVien=KQtam.maSinhVien and KQ.maMonHoc=KQtam.maMonHoc) 		
End

drop procedure KetQuaThi
execute KetQuaThi '0212002'