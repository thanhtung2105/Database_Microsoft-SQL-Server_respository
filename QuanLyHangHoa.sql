create database QuanLyHangHoa
go
use QuanLyHangHoa
go
--tao bang
create table NHA_CUNG_CAP
(
	MANCC	int not null,
	TENNCC	char(30),
	DCHI	char(30),
	DTHOAI	char(10),
	primary key (MANCC)
)
create table MAT_HANG
(
	MAMH	int not null,
	TENMH	char(30),
	DVT	char(10),
	QUICACH	char(10),
	SLTON	int,
	primary key (MAMH)
)
create table CUNG_UNG
(
	MANCC	int not null,
	MAMH 	int not null,
	primary key (MANCC,MAMH)
)
create table DAT_HANG
(
	SODH	int not null,
	NGAYDH	datetime,
	MANCC	int,
	GHICHU	char(30),
	SOMH	int,
	THANHTIEN	float,
	primary key (SODH)
)
create table CTDH
(
	SODDH	int not null,
	MAMH	int not null,
	SLD	int,
	DGD	float,
	primary key (SODDH,MAMH)
)
create table GIAO_HANG
(
	SOGH	int not null,
	NGAYGH	datetime,
	SODH	int,
	primary key (SOGH)
)
create table CTGH
(
	SOGH	int not null,
	MAMH	int not null,
	SLG	int,
	primary key (SOGH,MAMH)
)
go
--Khoa ngoai
alter table CUNG_UNG
add constraint FK_CUNG_UNG_MANCC_NHA_CUNG_CAP
foreign key (MANCC)
references NHA_CUNG_CAP(MANCC)

alter table CUNG_UNG
add constraint FK_CUNG_UNG_MAMH_MAT_HANG
foreign key (MAMH)
references MAT_HANG(MAMH)

alter table DAT_HANG
add constraint FK_DAT_HANG_MANCC_NHA_CUNG_CAP
foreign key (MANCC)
references NHA_CUNG_CAP(MANCC)

alter table CTDH
add constraint FK_CTDH_SODDH_DAT_HANG
foreign key (SODDH)
references DAT_HANG(SODH)

alter table CTDH
add constraint FK_CTDH_MAMH_MAT_HANG
foreign key (MAMH)
references MAT_HANG(MAMH)

alter table GIAO_HANG
add constraint FK_GIAO_HANG_SODH_DAT_HANG
foreign key (SODH)
references DAT_HANG(SODH)

alter table CTGH
add constraint FK_CTGH_SOGH_GIAO_HANG
foreign key (SOGH)
references GIAO_HANG(SOGH)

alter table CTGH
add constraint FK_CTGH_MAMH_MAT_HANG
foreign key (MAMH)
references MAT_HANG(MAMH)
go

--du lieu
insert into NHA_CUNG_CAP values(111,'Kinh Do','123 Tran Hung Dao','8123456')
insert into NHA_CUNG_CAP values(222,'Pepsi','456 Hung Vuong','8654321')
insert into NHA_CUNG_CAP values(333,'Vinamilk','789 Nguyen Trai','8112233')

insert into MAT_HANG values(11,'Banh quy','Hop','Hop 10 cai',30)
insert into MAT_HANG values(22,'Pepsi','Lon','Lon 500ml',80)
insert into MAT_HANG values(33,'Aquafina','Chai','Chai 500ml',20)
insert into MAT_HANG values(44,'Sua tuoi','Hop','Hop 1l',10)
insert into MAT_HANG values(55,'Sua chua','Hop','',30)

insert into CUNG_UNG values(111,11)
insert into CUNG_UNG values(222,22)
insert into CUNG_UNG values(222,33)
insert into CUNG_UNG values(333,44)
insert into CUNG_UNG values(333,55)

insert into DAT_HANG values(101,'11/1/2008',111,'',1,75000)
insert into DAT_HANG values(102,'11/15/2008',222,'',2,280000)
insert into DAT_HANG values(103,'11/30/2008',333,'',2,110000)

insert into CTDH values(101,11,5,15000)
insert into CTDH values(102,22,48,5000)
insert into CTDH values(102,33,10,4000)
insert into CTDH values(103,44,5,10000)
insert into CTDH values(103,55,20,3000)

insert into GIAO_HANG values(201,'11/1/2008',101)
insert into GIAO_HANG values(202,'11/16/2008',102)
insert into GIAO_HANG values(203,'12/1/2008',103)
insert into GIAO_HANG values(204,'12/15/2008',103)

insert into CTGH values(201,11,5)
insert into CTGH values(202,22,48)
insert into CTGH values(202,33,10)
insert into CTGH values(203,55,10)
insert into CTGH values(204,55,10)
insert into CTGH values(204,44,5)

--________________________________________________
--1. Viết function tính số lượng tồn trung bình của các mặt hàng.
--2. Viết store procedure, kiểm tra với 1 mã đặt hàng, chỉ được giao hàng
--tối đa 3 lần. Nếu đúng xuất 'Hop le', nếu sai xuất 'Khong hop le'
--3. Viết store procedure, in danh sách các mặt hàng của 1 nhà cung cấp
--(tham số input là mã nhà cung cấp)
--DÙNG LỆNH PRINT



--1. Viết function tính số lượng tồn trung bình của các mặt hàng.
create function TBton ()
returns float
BEGIN
	declare @kqtb float
	select @kqtb=avg(SLTON)
	from MAT_HANG
	return @kqtb
END
go
select dbo.TBton ()

drop function TBton

--2. Viết store procedure, kiểm tra với 1 mã đặt hàng, chỉ được giao hàng tối đa 3 lần. Nếu đúng xuất 'Hop le', nếu sai xuất 'Khong hop le'

create procedure KTDH
(@sodh int)
as
Begin
	declare @dem int
	select @dem=count(SODH)
	from GIAO_HANG
	where SODH=@sodh
	if (@dem between 1 and 3) print 'Hop le'
	else print 'Khong hop le'
End
go
execute KTDH '103'

drop proc KTDH

--3. Viết store procedure, in danh sách các mặt hàng của 1 nhà cung cấp (tham số input là mã nhà cung cấp)
--DÙNG LỆNH PRINT

create procedure DSMH(@manhacc varchar(10))
AS
BEGIN
	declare @tenmathang char(30)
	declare @mamh varchar(20)
	declare cur_mathang cursor
	for
		select MH.TENMH,MH.MAMH
		from MAT_HANG MH,CUNG_UNG CU
		where  MH.MAMH = CU.MAMH and  @manhacc = CU.MANCC
	open cur_mathang
	fetch cur_mathang into @tenmathang,@mamh
	while (@@FETCH_STATUS =0)
		begin
			print 'Ten mat hang ' + @tenmathang
			print 'Ma mat hang ' + @mamh
			fetch cur_mathang into @tenmathang,@mamh
		end
	close cur_mathang
	deallocate cur_mathang
END

drop procedure DSMH
execute DSMH '222'

--______________________________________________________________________________________________________________________

--_______________________________________________________________________________________________________________________

--1. Xuất ra các bảng: MAT_HANG, GIAO_HANG, CTGH
select * from MAT_HANG	select * from GIAO_HANG	select * from CTGH

--2. Xuất ra tên các mặt hàng có số lượng tồn trên 20.
select TENMH
from MAT_HANG 
where SLTON>20

--3. Tính giá trị 60% giá trị của mặt hàng trong mỗi đơn hàng (xuất bảng). (function)
create view VD3 as
select MH.MAMH ,MH.TENMH, CT.DGD, CT.SLD
from MAT_HANG MH, CTDH CT
where MH.MAMH=CT.MAMH

select * from VD3
drop view VD3
--____________________________
create function VD31
(@maMH char(30))
returns float
BEGIN
	declare @kq float
	select @kq=(CT.DGD/CT.SLD)*0.6
	from CTDH CT
	where CT.MAMH=@maMH
	return @kq
END
go
select dbo.VD31(11)
drop function VD31

--4. Sắp xếp tên mặt hàng theo thứ tự DGD đơn hàng.
select MH.TENMH, CT.DGD
from MAT_HANG MH, CTDH CT
where MH.MAMH=CT.MAMH
order by CT.DGD 

--5. Với mỗi tên mặt hàng, cho biết địa chỉ nhà cung cấp. (xuất bảng (function) - 
-- store procedure - nhập vào tên mặt hàng, kiểm tra địa chỉ nhà cung cấp)
--FUNCTION - tao nguyen bang: 
create function VD5()
returns table
return(
	select MH.TENMH, NCC.DCHI
	from MAT_HANG MH, NHA_CUNG_CAP NCC, CUNG_UNG CU
	where MH.MAMH=CU.MAMH and CU.MANCC=NCC.MANCC)

drop function VD5
select * from dbo.VD5()

--FUNCTION - Do tim tung cai: 
create function VD51(@tenMH char(30))
returns table
return(
	select MH.TENMH, NCC.DCHI
	from MAT_HANG MH, NHA_CUNG_CAP NCC, CUNG_UNG CU
	where @tenMH=MH.TENMH and MH.MAMH=CU.MAMH and CU.MANCC=NCC.MANCC)

drop function VD51
select * from dbo.VD51('Pepsi')

--STORE PROCEDURE - Kiem tra tung cai
create proc VD52(@maMH int)
as
Begin
	select MH.TENMH, NCC.DCHI
	from MAT_HANG MH, NHA_CUNG_CAP NCC, CUNG_UNG CU
	where @maMH=MH.MAMH and MH.MAMH=CU.MAMH and CU.MANCC=NCC.MANCC
End
execute VD52 44

--STORE PROCEDURE - xuat toan bang
create proc VD53
as
Begin
	select MH.TENMH, NCC.DCHI
	from MAT_HANG MH, NHA_CUNG_CAP NCC, CUNG_UNG CU
	where  MH.MAMH=CU.MAMH and CU.MANCC=NCC.MANCC
End
go
execute VD53

--6. Viết store procedure, in danh sách các mặt hàng thuộc cùng đơn vị tính (tham số input là DVT)
-- PROCEDURE
create proc VD6(@dvt char(30))
AS
BEGIN
	select MH.TENMH
	from MAT_HANG MH
	where MH.DVT=@dvt
END

execute VD6 'Hop'

-- CURSOR: Viết store procedure, in danh sách các mặt hàng của 1 nhà cung cấp (tham số input là mã nhà cung cấp)
create procedure MHCTT(@dvt char(30))
AS
BEGIN
	declare @tenmathang char(30)
	declare @mamh varchar(30)
	declare cur_hangcungtt cursor
	for
		select MH.TENMH,MH.MAMH
		from MAT_HANG MH
		where @dvt=MH.DVT
	open cur_hangcungtt
	fetch cur_hangcungtt into @tenmathang, @mamh
	while (@@FETCH_STATUS =0)
		begin
			print 'Ten mat hang ' + @tenmathang
			print 'Ma mat hang ' + @mamh
			fetch cur_hangcungtt into @tenmathang, @mamh
		end
	close cur_hangcungtt
	deallocate cur_hangcungtt
END

drop procedure MHCTT
execute MHCTT 'Lon'

--7. Viết function tính số lượng trung bình của chi tiết giao hàng.
create function SLTB()
returns float
	BEGIN
		declare @tbsl float
		select @tbsl=avg(SLG)
		from CTGH
		return @tbsl
	END

select dbo.SLTB()

--8. Với 1 mã mặt hàng và 1 mã số giao hàng, kiểm tra xem số lượng giao hàng có trên 10 hay không? 
--(trả về đúng hoặc sai) --(store procedure)
create proc ktslgh(@mamh int, @sogh int)
AS
BEGIN
	declare @kt int
	select @kt=SLG
	from CTGH CT
	where CT.MAMH=@mamh and CT.SOGH=@sogh
	if @kt>10 print N'Đúng'
	else print N'Sai'
END

drop proc ktslgh
execute ktslgh 11,201

--9. Viết store procedure tính thành tiền của mỗi đơn hàng với giá trị nhập vào là mã mặt hàng.
create proc thanhtien_mamh(@mamh int)
AS
BEGIN
	declare @kqtt float
	select @kqtt=DH.SOMH*CT.DGD
	from DAT_HANG DH, CTDH CT
	where CT.MAMH=@mamh and DH.SODH=CT.SODDH
	print @kqtt
END

drop proc thanhtien_mamh
execute thanhtien_mamh 33


--10. Viết store procedure tính số tiền hàng tồn của mỗi mặt hàng với nhập vào là mã mặt hàng.
create proc stht(@mamh int)
AS
BEGIN
	declare @sotienton float
	select @sotienton=CT.DGD*MH.SLTON
	from CTDH CT, MAT_HANG MH
	where MH.MAMH=@mamh and MH.MAMH=CT.MAMH
	print @sotienton
END

execute stht 11

--11. Tạo view VT danh sách có chứa: MaMH, TenMH, DVT, MANCC, TENNCC. Sau đó đổi tên view VT 
--thành CHITIETHANG.
create view VD11
as
select MH.MAMH, MH.TENMH, MH.DVT, NCC.MANCC, NCC.TENNCC
from MAT_HANG MH, NHA_CUNG_CAP NCC, CUNG_UNG CU
where MH.MAMH=CU.MAMH and CU.MANCC=NCC.MANCC

drop view VD11
select * from VD11
sp_rename VD11,THONGTINHANGHOA
go
select * from THONGTINHANGHOA
drop view THONGTINHANGHOA

--12. Nhập vào 2 mã mặt hàng, xuất ra cái có số lượng tồn nhiều hơn. (proc)
create proc ktslton(@mamh1 int, @mamh2 int)
AS
BEGIN
	declare @slton1 int, @slton2 int, @tenmh1 char(30), @tenmh2 char(30)
	select @slton1=MH1.SLTON, @slton2=MH2.SLTON, @tenmh1=MH1.TENMH, @tenmh2=MH2.TENMH
	from MAT_HANG MH1, MAT_HANG MH2
	where MH1.MAMH=@mamh1 and MH2.MAMH=@mamh2
	if @slton1>@slton2 print N'Mặt hàng có số lượng tồn nhiều hơn là ' + @tenmh1
	else print N'Mặt hàng có số lượng tồn nhiều hơn là ' + @tenmh2
END

execute ktslton 11,44

--13. Với một mã DDH và một mã MH, kiểm tra xem MH đó có thuộc đơn hàng hay không. Trả về Có hoặc Không.
create proc mh_dh(@maddh int, @mamh int)
AS
BEGIN
	declare @kt int
	select @kt=CT.SODDH
	from CTDH CT, MAT_HANG MH
	where MH.MAMH=@mamh and CT.SODDH=@maddh and MH.MAMH=CT.MAMH
	if @kt=@maddh print 'Thuoc'
	else print 'Khong thuoc'
END

drop proc mh_dh
execute mh_dh 102,11

--14. Viết store procedure, nhập vào 1 mã MH và 1 mã NCC sau đó in ra TENNCC, TENMH, DCHI và SĐT.
drop proc thongtin
go
create proc thongtin(@mamh int, @mancc int)
AS
BEGIN
	declare @tenncc char(30), @tenmh char(30), @diachi char(30), @sdt char(30), @kt int
	select @tenncc=NCC.TENNCC, @tenmh=MH.TENMH, @diachi=NCC.DCHI, @sdt=NCC.DTHOAI, @kt=CU.MANCC
	from NHA_CUNG_CAP NCC, MAT_HANG MH, CUNG_UNG CU
	where MH.MAMH=CU.MAMH and CU.MANCC=NCC.MANCC and MH.MAMH=@mamh and CU.MANCC=@mancc
	if @kt!=@mancc print 'Khong co thong tin'
	else
	begin
	print @tenncc
	print @tenmh
	print @diachi
	print @sdt
	end
END

execute thongtin 33,222

--15. Viết function, nhập vào SOGH, tính trung bình DGD của số giao hàng đã nhập vào đó.
create function TBDGD(@sogh int)
returns float
BEGIN
	declare @kqtb float
	select @kqtb=avg(CTDH.DGD)
	from CTGH, CTDH 
	where CTGH.MAMH=CTDH.MAMH and CTGH.SOGH=@sogh

	return @kqtb
END

select dbo.TBDGD(204)

--16. Viết proc, nhập vào 2 tên mã MH, cho biết số lượng giao hàng của loại hàng nào nhiều hơn, xuất tên mặt hàng của loại đó.
create proc SSSLG(@mamh1 int, @mamh2 int)
AS
BEGIN
	declare @slg1 int, @slg2 int, @tenmh1 char(30), @tenmh2 char(30)
	select @slg1=CT1.SLG, @slg2=CT2.SLG, @tenmh1=MH1.TENMH, @tenmh2=MH2.TENMH
	from CTGH CT1, CTGH CT2, MAT_HANG MH1, MAT_HANG MH2
	where CT1.MAMH=MH1.MAMH and CT2.MAMH=MH2.MAMH and CT1.MAMH=@mamh1 and CT2.MAMH=@mamh2
	if @slg1>@slg2 print 'Mat hang co so luong giao nhieu hon la ' + @tenmh1
	else print 'Mat hang co so luong giao nhieu hon la ' + @tenmh2
END

execute SSSLG 55,11

--17. Viết proc, in danh sách SOGH và SLG giao ở CTGH tương ứng. - (input la mamh) DÙNG LỆNH PRINT.
create procedure TTGH(@mamh int)
AS
BEGIN
	declare @sogh char(30)
	declare @slg char(30)
	declare cur_check cursor
	for
		select CT.SOGH, CT.SLG
		from CTGH CT
		where CT.MAMH=@mamh
	open cur_check
	fetch cur_check into @sogh, @slg
	while (@@FETCH_STATUS =0)
		begin
			print 'So giao hang: ' + @sogh
			print 'So luong: ' + @slg
			fetch cur_check into @sogh, @slg
		end
	close cur_check
	deallocate cur_check
END

drop procedure TTGH
execute TTGH 55

--18. Xuất ra top 2 sản phẩm có đơn giá mắc nhất. Xuất ra thông tin mã hàng, tên hàng dvt, quy cách của nó.
select top(2) MH.MAMH, MH.TENMH, MH.DVT, MH.QUICACH, CT.DGD
from CTDH CT, MAT_HANG MH
where CT.MAMH=MH.MAMH
order by CT.DGD desc

--19. Nhập vào 4 mã hàng, xuất ra thông tin 2 loại hàng mà có số lượng tồn nhiều nhất.
create view VV
as
(

)

create proc HANGTON (@maha1 int, @maha2 int, @maha3 int, @maha4 int)
AS
BEGIN
	declare @max int
	select MH1.SLTON, MH2.SLTON, MH3.SLTON, MH4.SLTON
	from MAT_HANG MH1, MAT_HANG MH2, MAT_HANG MH3, MAT_HANG MH4
	where @maha1=MH1.MAMH and @maha2=MH2.MAMH and @maha3=MH3.MAMH and @maha4=MH4.MAMH
END

execute HANGTON 11,22,33,44
--20. Nhập vào 2 mã nhà cung cấp, cho biết nhà cung cấp nào có trung bình đơn giá sản phẩm nhiều hơn?
drop proc SSTBTT
go
create proc SSTBTT(@mancc1 int, @mancc2 int)
AS
BEGIN
	declare @ten1 char(10), @ten2 char(10)
			,@kqtb1 float, @kqtb2 float
	select @ten1=NCC1.TENNCC, @ten2=NCC2.TENNCC,
			@kqtb1=(select avg(CT.DGD)
					from CTDH CT, CUNG_UNG CU, NHA_CUNG_CAP NCC
					where NCC.MANCC=@mancc1 and CU.MANCC=NCC.MANCC and CT.MAMH=CU.MAMH)
		,	@kqtb2=(select avg(CT.DGD)
					from CTDH CT, CUNG_UNG CU, NHA_CUNG_CAP NCC
					where NCC.MANCC=@mancc2 and CU.MANCC=NCC.MANCC and CT.MAMH=CU.MAMH)
	from NHA_CUNG_CAP NCC1, NHA_CUNG_CAP NCC2, CUNG_UNG CU1, CUNG_UNG CU2, CTDH CT1, CTDH CT2
	where @mancc1=NCC1.MANCC and @mancc2=NCC2.MANCC
	and	  NCC1.MANCC=CU1.MANCC and NCC2.MANCC=CU2.MANCC
	and   CU1.MAMH=CT1.MAMH and CU2.MAMH=CT2.MAMH
	if @kqtb1>@kqtb2 print @ten1+'co TB don gia nhieu hon!'
	else print @ten2+'co TB don gia nhieu hon!'
END
go
execute SSTBTT 333,111

select * from DAT_HANG
select * from GIAO_HANG

select year(DH.NGAYDH), 
from DAT_HANG DH

declare @songay datetime

@songay=DH.NGAYGIAO-


select DH.SODH, sum(CT.DGD) as TONG
from DAT_HANG DH, CTDH CT
where DH.SODH=CT.SODDH
group by DH.SODH
order by TONG desc