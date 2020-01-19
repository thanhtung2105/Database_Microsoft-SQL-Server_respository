--______________________BÀI TẬP VỀ NHÀ - 2 BÀI TẬP TUẦN TRƯỚC ĐÓ: _____________________________--

--______________________	CSDL: QUẢN LÝ ĐỀ ÁN CÔNG TY		___________________________________--
-- Câu 1: Tìm họ tên và địa chỉ của những nhân viên làm việc cho đề án ở HCM nhưng 
-- phòng ban mà họ trực thuộc lại không tọa lạc ở HCM:
select distinct NV.HONV+' '+NV.TENLOT+' '+NV.TENNV 
as HOTENNV
from NHANVIEN NV, DEAN DA, DIADIEM_PHG DDP, PHONGBAN PB
where NV.PHG=PB.MAPHG and PB.MAPHG=DA.PHONG	and DA.PHONG=DDP.MAPHG and DA.DDIEM_DA='TP HCM'and DDP.DIADIEM!='TP HCM'

-- Câu 2: Tìm danh sách những nhân viên được phân công tất cả đề án do phòng NC chủ trì:
select *
from NHANVIEN NV
where MANV in (select PC1.MA_NVIEN
			   from PHANCONG PC1
			   where not exists(select *
								from DEAN DA
								where DA.PHONG='NC' and not exists(select *
																   from PHANCONG PC2
																   where PC2.SODA=DA.MADA and PC1.MA_NVIEN=PC2.MA_NVIEN)))


--_____		BÀI TẬP VỀ NHÀ - TUẦN 5 - RÀNG BUỘC - VIEW - CHECK - RULE	 ________________--

--______________________	CSDL: QUẢN LÝ SINH VIÊN		_________________________________--
-- Câu 1: Tạo view V1 danh sách các sinh viên Khoa 'Công nghệ thông tin':
create view V1 
as 
select SV.Ma, SV.hoTen, K.tenKhoa
from SinhVien SV, Lop L, Khoa K
where SV.maLop=L.Ma and L.maKhoa=K.ma and K.tenKhoa=N'Công nghệ thông tin'
select * from V1
--_______________________________________________--


-- Câu 2: Tạo view V2 danh sách sinh viên khóa 2002-2006:
create view V2 
as 
select SV.Ma, SV.hoTen, SV.malop, KH.namBatDau, KH.namKetThuc
from SinhVien SV, Lop L, KhoaHoc KH
where SV.maLop=L.Ma and L.maKhoaHoc=KH.Ma and KH.namBatDau='2002' and KH.namKetThuc='2006'
select * from V2
--_______________________________________________--


-- Câu 3: Tạo view V3 danh sách các môn mà chưa sinh viên nào theo học:
create view V3 as
select *
from MonHoc
where Ma not in (select maMonHoc
				 from KetQua)
select * from V3
--_______________________________________________--


-- Câu 4: Tạo view V4 danh sách sinh viên thi đậu môn Toán Cao cấp A1:
create view V4 
as
select SV.Ma, SV.hoTen, MH.tenMonHoc, KQ.lanThi, KQ.diem
from SinhVien SV, MonHoc MH, KetQua KQ
where SV.Ma=KQ.maSinhVien and KQ.maMonHoc=MH.Ma and MH.tenMonHoc=N'Toán Cao cấp A1' and KQ.diem>=5
select * from V4
--_______________________________________________--


-- Câu 5: Tìm sinh viên có điểm thi Toán Cao cấp A1 cao nhất từ view V4:
select top(1)*
from V4
order by diem desc
--_______________________________________________--


-- Câu 6: Đổi tên view V2 thành VSV02:
sp_rename V2,VSV02
select * from VSV02
--_______________________________________________--


-- Câu 7: ChuongTrinh.Ma chỉ có thể là 'CQ' hoặc 'CD' hoặc 'TC':
-- Cách 1: Check.
alter table ChuongTrinh 
add constraint ma_CT
check (Ma in('CQ','CD','TC'))
-- Cách 2: Rule.
create rule R4 as @Ma='CQ' or @Ma='CD' or @Ma='TC'
sp_bindrule 'R4','ChuongTrinh.Ma'
--_______________________________________________--


-- Câu 8: Chỉ có 2 học kì là 'HK1' và 'HK2':
-- Cách 1: Check.
alter table GiangKhoa 
add constraint hk_GK
check (hocKy in(1,2))
-- Cách 2: Rule.
create rule R2 as @hocKy=1 and @hocKy=2
sp_bindrule 'R2','GiangKhoa.hocKy'
--_______________________________________________--


-- Câu 9: Số tiết lý thuyết (GiangKhoa.soTietLyThuyet) tối đa là 120:
-- Cách 1: Check.
alter table GiangKhoa 
add constraint tiet_GK
check (soTietLyThuyet<=120)
-- Cách 2: Rule.
create rule R3 as @soTietLyThuyet<=120
sp_bindrule 'R3','GiangKhoa.soTietLyThuyet'
--_______________________________________________--


-- Câu 10: Số tiết thực hành(GiangKhoa.soTietThucHanh) tối đa là 120:
-- Cách 1: Check.
alter table GiangKhoa
add constraint tietTH_GK
check (soTietThucHanh<=120)
-- Cách 2: Rule.
create rule R10 as @TTH <=120
sp_bindrule 'R10','GiangKhoa.soTietThucHanh'
--_______________________________________________--


-- Câu 11: Số tín chỉ(GiangKhoa.soTinChi) của một môn học tối đa là 6:
-- Cách 1: Check.
alter table GiangKhoa
add constraint soTC_GK
check (soTinChi<=6)
-- Cách 2: Rule.
create rule R11 as @TC <=6
sp_bindrule 'R11','GiangKhoa.soTinChi'
--_______________________________________________--


-- Câu 12: Điểm thi(KetQua.diem) được chấm theo thang điểm 10, chính xác đến 1 chữ số sau dấu phấy:
-- Câu 1: Check.
alter table KetQua
add constraint diem_KQ
check (diem=round(diem,1) and diem<=10 and diem>=0)
-- Câu 2: Rule.
create rule R12 as @diem=round(@diem,1) and @diem<=10 and @diem>=0
sp_bindrule 'R12','KetQua.diem'



--_____		BÀI TẬP VỀ NHÀ - TUẦN 6 - Lập trình SQL - Create Procedure	 ________________--

--______________________	CSDL: QUẢN LÝ SINH VIÊN		_________________________________--

-- Câu 1: In danh sách các sinh viên của 1 lớp học (mã lớp là tham số đầu vào):
create procedure DSSV (@maLop varchar(10))
as
Begin
	select Ma, hoTen, namSinh, danToc
	from Sinhvien
	where maLop=@maLop
End
execute DSSV 'VL2003/01'
--_______________________________________________--


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
--_______________________________________________--


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
print N'Sinh vien ' + @hoTen + N' KHÔNG ĐẬU!'
			
drop procedure KTdaurot
execute KTdaurot 'THCS01','0212002'
--_______________________________________________--


-- Câu 4: Nhập vào 1 khoa, in danh sách các sinh viên (mã sinh viên, họ tên, ngày sinh) thuộc khoa này.
create procedure DSSV_Khoa (@maKhoa varchar(10))
as
Begin
	select SV.Ma, SV.hoTen, SV.namSinh, SV.danToc
	from Sinhvien SV, Khoa K, Lop L
	where K.ma=@maKhoa and L.maKhoa=K.ma and L.Ma=SV.maLop
End

execute DSSV_Khoa 'CNTT'
--_______________________________________________--


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
--_______________________________________________--


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
--_______________________________________________--


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
--_______________________________________________--


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

--_______________________________________________--


--Tạo Function TinhTong, tham số đầu vào là so1 và so2 (kiểu số nguyên)
CREATE FUNCTION TinhTong  (@so1  int, @so2  int)
--Kết quả trả về của hàm là một kiểu số nguyên
RETURNS	int
BEGIN
	--Khai báo biến @tong
	DECLARE @tong 	int
	--Tính giá trị của tổng
	SET @tong  =  @so1  +   @so2
	--Trả về giá trị của tổng
	RETURN @tong
END
--Gọi hàm thực thi
SELECT 	dbo.TinhTong( 5, 8 )
