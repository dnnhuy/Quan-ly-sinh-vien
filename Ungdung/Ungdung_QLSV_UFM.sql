USE  QLSINHVIEN_UFM

-- SYNONYM -------------------------------------------------------

-- Tạo tên đồng nghĩa bất kỳ truy xuất vào bảng SinhVien
Create synonym S_SV for SinhVien
-- Kiểm thử
select * from S_SV

--  Tạo tên đồng nghĩa truy xuất vào bảng cơ sở dữ liệu 
--của hệ thống do người dùng sys làm chủ sở hữu.
Create Synonym db for sys.databases
-- Kiểm thử
Select * From db


-- INDEX -------------------------------------------------------

--	Tạo Unique_ Index có tên bất kỳ trên cột CMND của bảng Sinh viên
CREATE unique INDEX index_CMND ON SinhVien(CMND)
-- Kiểm thử
EXEC sp_helpindex 'SinhVien'

-- Tạo Nonclustered_Index có tên tên bất kỳ trên cột HoTenGV của bảng Giảng viên
CREATE Nonclustered INDEX index_HtGV ON GiangVien(HoTenGV)
-- Kiểm thử
EXEC sp_helpindex 'GiangVien'

-- VIEW -------------------------------------------------------

-- Tạo khung nhìn cho biết mã khoa, tên khoa, mã chuyên ngành, 
--tên chuyên ngành do mỗi khoa đào tạo.
CREATE VIEW v_thongtinkhoa AS
SELECT K.MaKhoa, K.TenKhoa, MaCN, TenCN
FROM Khoa K, ChuyenNganh CN
WHERE K.MaKhoa=CN.MaKhoa
-- Kiểm thử
Select * from v_thongtinkhoa

-- Tạo khung nhìn thống kê số lượng các sinh viên thuộc một lớp
CREATE VIEW v_SLSVlop AS
SELECT SinhVien.MaLop, TenLop, count(MSSV) as N'Số lượng'
FROM SinhVien, Lop
where SinhVien.MaLop=Lop.MaLop
Group by  SinhVien.MaLop, TenLop

--drop VIEW v_SLSVlop
-- Kiểm thử
Select * from v_SLSVlop

-- Tạo khung nhìn thống kê tỉnh thành có nhiều sinh viên theo học tại trường nhất
CREATE VIEW v_svTinhTPnhieunhat AS
SELECT top (1) with ties TinhTP.MaTinh, TenTinh, count(MSSV) as N'Số lượng sinh viên'
FROM SinhVien, TinhTP
where SinhVien.MaTinh=TinhTP.MaTinh
Group by  TinhTP.MaTinh, TenTinh
order by count(MSSV) desc
-- Kiểm thử
Select * from 

-- Tạo khung nhìn thống kê sinh viên có điểm trung bình cao nhất
-- ở từng lớp học phần
CREATE VIEW v_maxdiemLHP AS
SELECT L1.MaLHP, SV1.MSSV, HoTenSV, DiemTb
FROM SinhVien SV1, DiemThi DT1, LopHP L1
where SV1.MSSV=DT1.MSSV and DT1.MaLHP=L1.MaLHP and
		DiemTb=(Select max(DiemTb) 
				from SinhVien SV2, DiemThi DT2, LopHP L2
				where SV2.MSSV=DT2.MSSV and DT2.MaLHP=L2.MaLHP
				and DT1.MaLHP=DT2.MaLHP)
-- Kiểm thử
Select * from v_maxdiemLHP


-- Tạo khung nhìn cho biết thông tin các giảng viên thuộc Khoa Công nghệ thông tin 
CREATE VIEW v_ttGvkhoaCNTT AS
SELECT *
FROM GiangVien
WHERE exists ( select *
				from Khoa
				where TenKhoa=N'Khoa Công nghệ thông tin' and Khoa.MaKhoa=GiangVien.MaKhoa)
drop VIEW v_ttGvkhoaCNTT
-- Kiểm thử
Select * from v_ttGvkhoaCNTT


-- FUNCTION -------------------------------------------------------

-- Viết hàm cho biết sinh viên có điểm thi cao nhất với tham số truyền vào là Mã lớp học phần
create function f_topsv(@MALHP nvarchar (8))
returns table
as
return (select top (1) with ties SinhVien.MSSV, HoTenSV, DiemThi, DiemThi.MaLHP
		from DiemThi, SinhVien, LopHP
		where DiemThi.MSSV=SinhVien.MSSV and DiemThi.MaLHP=LopHP.MaLHP and DiemThi.MaLHP=@MALHP
		order by DiemThi desc
		)
go

-- Kiểm thử
select * from f_topsv('LHP05')

drop function f_topsv



-- Viết hàm cho biết số lượng giảng viên với tham số truyền vào là Mã khoa
create function f_slgvtheokhoa(@MAKHOA nchar(4))
returns int
as begin
declare @SOLUONGGV int
select @SOLUONGGV = COUNT(MaGV)
FROM GiangVien 
where MaKhoa=@MAKHOA
return @SOLUONGGV
end
-- Kiểm thử
print N'Số lượng giảng viên là: ' + cast(dbo.f_slgvtheokhoa('CNTT') as nvarchar)



-- Viết hàm cho biết 2 Lớp học phần có số lượng sinh viên đăng ký nhiều nhất
create function f_top2lophp()
returns table
as
return (select top (2) with ties count(MSSV) as 'So luong', MaLHP
		from DangKy
		group by MaLHP
		order by count(MSSV) desc
		)
-- Kiểm thử
select * from f_top2lophp()


-- STORE PROCEDURE ---------------------------------------------------------

-- 1. Tạo thủ tục cho biết giảng viên có tuổi cao nhất
create proc pc_maxtuoi
as
begin
select top (1) with ties HoTenGV, (Year(GETDATE())-YEAR(NgaySinhGV)) as N'Tuổi'
from GiangVien
order by (Year(GETDATE())-YEAR(NgaySinhGV)) desc
end

drop proc pc_maxtuoi
-- Kiểm thử
exec pc_maxtuoi

-- 2. Tạo thủ tục cập nhật kết quả thi của tất cả các sinh viên, 
--nếu điểm trung bình bé hơn hoặc bằng 4 thì rớt, ngược lại thì đậu
create proc pc_updateketqua
as
begin
	update DiemThi
	set KetQua= cast((CASE WHEN DiemTb>4 THEN N'Đậu' ELSE N'Rớt' END) as nvarchar)
end

drop proc pc_updateketqua
-- Kiểm thử
exec pc_updateketqua
Select * from DiemThi

-- 3. Tạo thủ tục lưu trữ các sinh viên rớt môn vào bảng RotMon
create proc sp_insert_RotMon
as
begin
if not exists (select * from sys.objects where object_id=OBJECT_ID('dbo.tbRotMon'))
begin
	create table tbRotMon
	(
	 MSSVRot		nvarchar (5) not null ,
	 HoTenSVRot		nvarchar (20)  not null,
	 MaLHPRot		nvarchar (8)  not null ,
	 DiemTbRot      float not null ,
	 KetQuaRot		nvarchar (20),
	)
end
	insert into tbRotMon
	select SinhVien.MSSV,HoTenSV, DiemThi.MaLHP,DiemThi.DiemTb, KetQua
	from SinhVien, DiemThi
	where SinhVien.MSSV=DiemThi.MSSV and SinhVien.MSSV not in 
	(select MSSVRot from tbRotMon)
	group by SinhVien.MSSV,HoTenSV, DiemThi.MaLHP,DiemThi.DiemTb,  KetQua
	having KetQua=N'Rớt'
end
-- Kiểm thử -- drop proc sp_insert_RotMon
exec sp_insert_RotMon
Select * from tbRotMon


--  4.Tạo thủ tục nhập vào 1 khoa, in danh sách các chuyên ngành (mã chuyên ngành, tên chuyên ngành) thuộc khoa này.
CREATE PROC pc_dschuyennganh (@makhoa nvarchar (4))
AS
BEGIN
SELECT MaCN, TenCN
FROM ChuyenNganh
   WHERE ChuyenNganh.MaKhoa = @makhoa
END
-- Kiểm thử
EXEC dbo.pc_dschuyennganh @makhoa = 'CNTT'

-- 5. Cho biết số lượng sinh viên đăng ký với ngày đăng ký tham số truyền vào và 
-- số lượng đăng ký là tham số truyền ra
Create proc sp_SLSinhVienDk (@NGAYDK datetime, @SLSV int output)
as
begin
set @SLSV=(select count(MSSV) from DangKy where NgayDK=@NGAYDK group by NgayDK)
end

--drop proc sp_SLSinhVienDk
--Kiểm thử
declare @SLSV1 int
set @SLSV1=0
execute sp_SLSinhVienDk '2022-02-01', @SLSV1 output
print (N'Số lượng sinh viên đăng ký của ngày là: '+ convert(varchar,@SLSV1))

-- 6.Tạo thủ tục cập nhập số điện thoại giảng viên trong GiangVien với tham số 
-- mã giảng viên do người dùng nhập và xác định 
-- cập nhật hoàn thành hoặc quay lui khi có lỗi.
create proc pc_capnhatsdtGV (@MAGV nvarchar (5), @SDT nvarchar(11))
as
declare @Error int, @Rowcount int
begin 
	if exists(select * from  GiangVien where MaGV = @MAGV)
		begin
   			update GiangVien
   			set SDTGV = @SDT
   			where MaGV = @MAGV
		end
	else
		print N'Mã giảng viên không tồn tại' 
 	 --Kiểm tra việc cập nhật có thành công không
   		select @Error = @@ERROR, @Rowcount = @@ROWCOUNT
	--Nếu có lỗi/ không cập nhật được
	if(@Error<>0 or @Rowcount<>1)
   		begin
       		rollback tran
			return -999
   		end
	else print N'Thực hiện thành công'
end

--drop proc pr_capnhatsdtGV
-- Kiểm thử
-- VD1: Không tồn tại mã GV
exec pc_capnhatsdtGV 'GV19',N'0377119774'
-- VD2: Tồn tại mã GV
exec pc_capnhatsdtGV 'GV10',N'0377119774'

--7.Tạo thủ tục thêm mới đăng ký học phần của sinh viên với 
--tham số truyền vào là mã lớp học phần, mã số sinh viên và ngày đăng ký
-- và xác định việc thêm hoàn thành hoặc quay lui khi có lỗi.
create proc sp_themDK (@MASV nvarchar (5), @MALHP nvarchar (8), @NGAYDK datetime)
as
declare @Error int, @Rowcount int
begin 
	if exists(select * from  SinhVien, LopHP where  @MALHP=MaLHP and @MASV=MSSV)
		begin
   			insert into DangKy
   			values (@MASV,@MALHP,@NGAYDK)
		end
	else
		print N'Mã sinh viên, mã lớp học phần không tồn tại' 
 	 --Kiểm tra việc thêm có thành công không
   		select @Error = @@ERROR, @Rowcount = @@ROWCOUNT
	--Nếu có lỗi/ không thêm được
	if(@Error<>0 or @Rowcount<>1)
   		begin
       		rollback tran
			return -999
   		end
	else print N'Thực hiện thành công'
end

--drop proc sp_themDK
-- Kiểm thử
-- VD1: Không tồn tại
exec sp_themDK 'SV99','LHP99','2022-02-01 00:00:00.000'
-- VD2: Tồn tại
exec sp_themDK 'SV09','LHP01','2022-02-02 00:00:00.000'


-- TRIGGER ---------------------------------------------------------

-- Tạo trigger Ngày đăng ký lớp học phần phải nhỏ hơn ngày bắt đầu lớp học phần
create trigger tg_ngaydk
on DangKy
for insert, update
as
If exists (select * 
		    from inserted, DangKy, LopHP
			where inserted.MaLHP=DangKy.MaLHP and inserted.MaLHP=LopHP.MaLHP and inserted.NgayDK>LopHP.NgayBd)
	begin
		print (N'Ngày đăng ký đang lớn hơn ngày bắt đầu học, vui lòng nhập lại!')
		rollback tran
	end
-- Thực thi
drop trigger tg_ngaydk
insert into DangKy values ('SV09', 'LHP02', '2023-10-30' )
--delete from DangKy
--where MSSV='SV09' and MaLHP='LHP02'


--Tạo trigger mỗi lớp phải có ít nhất 3 sinh viên
create trigger SLSVtrongLop
ON SinhVien
FOR DELETE, UPDATE
AS
  DECLARE @SLSVLOP INT
  SELECT  @SLSVLOP=COUNT(SinhVien.MaLop)
  FROM DELETED,SinhVien
  WHERE DELETED.MaLop=SinhVien.MaLop
IF  @SLSVLOP<3
   BEGIN
     ROLLBACK TRAN
     PRINT(N'Mỗi lớp phải có ít nhất 3 sinh viên')
END 

--drop trigger SLSVtrongLop
-- select * from v_SLSVLOP
-- Tạo lớp tạm 21DTH2 thuộc CN01 để không ảnh hưởng đến CSDL
insert into Lop values
('21DTH2',N'Lớp tin học quản lý 02','CN01')
-- Thêm dữ liệu cho lớp tạm
INSERT INTO SinhVien
VALUES 	('SV021', N'Nguyễn Danh Hiệp', convert(datetime, '2003-7-11'), N'Nam', '0913008000', '223699169', '21DTH2', 'MT01')
INSERT INTO SinhVien
VALUES 	('SV022', N'Trần Ngọc Thy', convert(datetime, '2003-7-12'), N'Nữ', '0913008001', '223699199', '21DTH2', 'MT01')
INSERT INTO SinhVien
VALUES 	('SV023', N'Nguyễn Nam', convert(datetime, '2003-8-12'), N'Nam', '0913008004', '223692169', '21DTH2', 'MT01')

-- Kiểm thử
delete from SinhVien
where MSSV='SV021'


-- USER --------------------------------------
--MỨC QUẢN LÝ
--Tạo tài khoản
create login QUANLY
with password = '1234',
default_database = QLSINHVIEN_UFM
--Tạo người dùng
create user qly
for login QUANLY
--Cấp quyền truy xuất CSDL QLSINHVIEN_UFM cho quản lý
GRANT insert, update, select to qly

--MỨC SINH VIÊN
--Tạo tài khoản
create login SINHVIEN
with password = '4321',
default_database = QLSINHVIEN_UFM
--Tạo người dùng
create user svien
for login SINHVIEN
--Cấp quyền xem thông tin trên bảng lớp học phần cho sinh viên vừa tạo
GRANT select on LopHP to svien

-- Partitioning -----------------------
CREATE DATABASE PartDB
GO
USE PartDB
GO
CREATE PARTITION FUNCTION PartFunc_1(INT) AS RANGE LEFT FOR VALUES (1, 5, 10)
