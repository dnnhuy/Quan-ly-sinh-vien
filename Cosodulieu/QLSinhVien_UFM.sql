CREATE DATABASE QLSINHVIEN_UFM

go
USE  QLSINHVIEN_UFM

go
-- Tao bang Khoa
CREATE TABLE Khoa
(
	MaKhoa		nvarchar (4) constraint PK_Khoa_MaKhoa primary key,
	TenKhoa		nvarchar (50) not null

)
go

--Them du lieu vao bang Khoa
INSERT INTO Khoa
VALUES 
		('KETN', N'Khoa Kế toán'),
		('TMAI', N'Khoa Thương mại'),
		('QTKD', N'Khoa Quản trị kinh doanh'),
		('CNTT', N'Khoa Công nghệ thông tin'),
		('KTL', N'Khoa Kinh Tế Luật')
go

-- Tao bang chuyen nganh
CREATE TABLE ChuyenNganh
(
	MaCN		nvarchar (6) constraint PK_ChuyenNganh_MaCN primary key,
	TenCN		nvarchar (50) not null,
	MaKhoa		nvarchar (4) constraint FK_ChuyenNganh_MaKhoa references Khoa(MaKhoa)
)
go

-- Them du  lieu vao bang Chuyennganh
INSERT INTO ChuyenNganh
VALUES 
		('CN01',N'Tin học quản lý','CNTT'),
		('CN02',N'Hệ thống thông tin kế toán','CNTT'),
		('CN03',N'Thương mại quốc tế','TMAI'),
		('CN04',N'Thương mại điện tử','TMAI'),
		('CN05',N'Tài chính định lượng','KTL'),
		('CN06',N'Quản trị kinh doanh tổng hợp','QTKD'),
		('CN07',N'Quản trị dự án','QTKD'),
		('CN08',N'Quản trị bán hàng','QTKD'),
		('CN09',N'Kế toán doanh nghiệp','KETN'),
		('CN10',N'Kiểm toán','KETN')
go

-- Tao bang Lop
CREATE TABLE Lop
(
	MaLop		nvarchar (6) constraint PK_Lop_MaLop primary key,
	TenLop		nvarchar (50) not null,
	MaCN		nvarchar (6) constraint FK_Lop_MaCN references ChuyenNganh(MaCN)
)
go

-- Them du lieu vao bang Lop
INSERT INTO Lop
VALUES 
		('21DTH1',N'Lớp tin học quản lý 01','CN01'),
		('21DTK2',N'Lớp hệ thống thông tin kế toán 02','CN02'),
		('21DKT1',N'Lớp kiểm toán 01','CN10'),
		('21DBH1',N'Lớp quản trị bán hàng 01','CN08'),
		('21DTM1',N'Lớp thương mại điện tử 01','CN04'),
		('21DEM1',N'Lớp tài chính định lượng 01','CN05')

go

-- Tao bang TinhTP
CREATE TABLE TinhTP
(
  MaTinh	nvarchar (5) constraint PK_TinhTP_MaTinh primary key, 
  TenTinh   nvarchar (20) not null,
)
go 

-- Them du lieu vao bang TinhTP
INSERT INTO TinhTP
VALUES
	('MT01',N'Hà Nội'),
	('MT02',N'Bình Dương'),
	('MT03',N'TPHCM'),
	('MT04',N'Đồng Nai'),
	('MT05',N'Nha Trang')
go

-- Tao bang Sinh Vien
CREATE TABLE SinhVien
(
  MSSV			nvarchar (5) constraint PK_SinhVien_MSSV primary key, 
  HoTenSV		nvarchar (20)  not null,
  NgaySinhSV	datetime not null, 
  GioiTinhSV	nvarchar (6) not null constraint CK_SinhVien_GioiTinhSV Check (GioiTinhSV in ('Nam', N'Nữ', N'Khác')),
  SDTSV			nvarchar(11) not null, 
  CMND			nvarchar (10) not null,
  MaLop			nvarchar (6)  not null constraint FK_SinhVien_MaLop references Lop(MaLop),
  MaTinh		nvarchar (5) not null constraint FK_SinhVien_MaTinh references TinhTP(MaTinh)
)
go

--Them du lieu vao bang SinhVien
INSERT INTO SinhVien
VALUES 
		
		('SV01', N'Nguyễn Xuân Hùng', convert(datetime, '2003-10-9'), 'Nam', '0915007602', '235687156', '21DTH1','MT04'),
		('SV02', N'Nguyễn Hoàng Dũng', convert(datetime, '2003-7-9'), 'Nam', '0915000233', '244687156', '21DBH1','MT03'),
		('SV03', N'Nguyễn Quốc Việt', convert(datetime, '2003-7-7'), 'Nam', '0915007802', '235687476', '21DTH1','MT01'),
		('SV04', N'Nguyễn Mai Hồng', convert(datetime, '2003-11-9'), N'Nữ', '0975017602', '275687156', '21DTK2', 'MT02'),
		('SV05', N'Nguyễn Hà Anh', convert(datetime, '2003-12-9'), N'Nữ', '0935017602', '235777156', '21DTM1', 'MT04'),
		('SV06', N'Trần Nhật Nhi', convert(datetime, '2003-6-19'), N'Nữ', '0913007609', '235699156', '21DKT1', 'MT05'),
		('SV07', N'Trần Quốc An', convert(datetime, '2003-8-19'), 'Nam', '0923007609', '235699956', '21DBH1', 'MT01'),
		('SV08', N'Đỗ Nhật Hà', convert(datetime, '2003-7-18'), N'Nữ', '0914007609', '235699157', '21DTH1', 'MT01'),
		('SV09', N'Trần Thiên Ân', convert(datetime, '2003-5-11'), N'Nữ', '0613007609', '235699158', '21DBH1', 'MT05'),
		('SV010', N'Lê Thảo Nhi', convert(datetime, '2003-2-12'), N'Nữ', '0973007609', '235699159', '21DTH1', 'MT04'),
		('SV011', N'Nguyễn Hà Dịu Thảo', convert(datetime, '2003-1-20'), N'Nữ', '0913607609', '235699160', '21DTK2', 'MT02'),
		('SV012', N'Ngô Quỳnh Mai', convert(datetime, '2003-3-15'), N'Nữ', '0913007605', '235699161', '21DTM1', 'MT01'),
		('SV013', N'Bùi Quỳnh Hoa', convert(datetime, '2003-4-22'), N'Nữ', '0913007633', '235699162', '21DKT1', 'MT03'),
		('SV014', N'Huỳnh Phạm Thủy Tiên', convert(datetime, '2003-5-16'), N'Nữ', '0913117609', '235699163', '21DBH1', 'MT04'),
		('SV015', N'Trần Bảo Ngọc', convert(datetime, '2003-8-12'), N'Nữ', '0913004409', '235699164', '21DTH1', 'MT02'),
		('SV016', N'Nguyễn Phương Nhi', convert(datetime, '2003-7-19'), N'Nữ', '0953007609', '235699165', '21DBH1', 'MT03'),
		('SV017', N'Dược Sĩ Tiến', convert(datetime, '2003-2-11'), 'Nam', '0913557609', '235699166', '21DTH1', 'MT04'),
		('SV018', N'Hoàng Song Hà', convert(datetime, '2003-6-14'), N'Nữ', '0913677609', '235699167', '21DTK2', 'MT01'),
		('SV019', N'Nguyễn Quỳnh', convert(datetime, '2003-1-21'), N'Nữ', '0976007609', '235699168', '21DTM1', 'MT04'),
		('SV020', N'Nguyễn Đan Tiên', convert(datetime, '2003-7-12'), N'Nữ', '0913008709', '235699169', '21DKT1', 'MT03')
go

-- Tao bang Giang Vien
CREATE TABLE GiangVien
(
  MaGV			nvarchar (5) constraint PK_GiangVien_MaGV primary key, 
  HoTenGV		nvarchar (20)  not null,
  NgaySinhGV	datetime not null, 
  GioiTinhGV	nvarchar (6) not null constraint CK_SinhVien_GioiTinhGV Check (GioiTinhGV in ('Nam', N'Nữ', N'Khác')),
  SDTGV			nvarchar(11) not null, 
  CMNDGV		nvarchar (10) not null,
  MaKhoa		nvarchar (4) constraint FK_GiangVien_MaKhoa references Khoa(MaKhoa)
)
go

--Them du lieu vao bang GiangVien
INSERT INTO GiangVien
VALUES 
		('GV01', N'Nguyễn Quang Khải', convert(datetime, '1980-10-12'), 'Nam', '0975007632', '735687156', 'QTKD'),
		('GV02', N'Trần Xuân Hương', convert(datetime, '1979-7-9'), N'Nữ', '0935000433', '744687156', 'QTKD'),
		('GV03', N'Nguyễn Quốc Đạt', convert(datetime, '1978-7-7'), 'Nam', '0985007802', '735687476', 'CNTT'),
		('GV04', N'Lương Mai Quyên', convert(datetime, '1981-11-9'), N'Nữ', '0975017688', '975687156', 'KETN'),
		('GV05', N'Trần Mai Thanh', convert(datetime, '1985-12-9'), N'Nữ', '0935666602', '735777156', 'CNTT'),
		('GV06', N'Bùi Xuân Anh', convert(datetime, '1984-6-19'), N'Nữ', '0913007677', '735699156', 'CNTT'), 
		('GV07', N'Phạm Ngọc Anh', convert(datetime, '1984-6-15'), 'Nam', '0913447677', '735699122', 'TMAI'),
		('GV08', N'Trần Thị La', convert(datetime, '1987-7-17'), N'Nữ', '0913447622', '735699352', 'KTL'),
		('GV09', N'Phạm Thị Khánh', convert(datetime, '1985-5-15'), N'Nữ', '0913444380', '735699865', 'CNTT'),
		('GV10', N'Bùi Minh', convert(datetime, '1986-6-16'), 'Nam', '0913443579', '735699197', 'TMAI')
go 

-- Tao bang HocPhan
CREATE TABLE HocPhan
(
  MaHP		nvarchar (5) constraint PK_HocPhan_MaHP primary key, 
  TenHP		nvarchar (20)  not null,
  SoTinChi	tinyint not null, 
  SoTietLT	tinyint not null, 
  SoTietTH	tinyint not null, 
  MaKhoa	nvarchar (4)  not null constraint FK_HocPhan_MaKhoa references Khoa(MaKhoa)
)
go

-- Them du lieu vao bang HocPhan
INSERT INTO HocPhan
VALUES 
		('HP01', N'Cơ sở dữ liệu', 4, 30, 60, 'CNTT'),
		('HP02', N'Luật đầu tư', 3, 30, 15, 'KTL'),
		('HP03', N'Quản trị dự án', 3, 30, 15, 'QTKD'),
		('HP04', N'Kiểm toán căn bản', 3, 30, 15, 'KETN'),
		('HP05', N'Thương mại quốc tế', 3, 30, 15, 'TMAI')
go

-- Tao bang LopHP
CREATE TABLE LopHP
(
  MaLHP			nvarchar (8) constraint PK_LopHP_MaLHP primary key, 
  TenHP			nvarchar (20)  not null,
  NgayBd		datetime not null, 
  NgayKt		datetime not null, 
  NgayDukienthi	datetime not null, 
  HK			tinyint not null constraint CK_LopHP_HocKi Check (HK in (1, 2, 3)),
  Nam			int not null,
  MaHP			nvarchar (5) constraint FK_LopHP_MaHP references HocPhan(MaHP),
  MaGV			nvarchar (5)  not null constraint FK_LopHP_MaGV references GiangVien(MaGV)
)
go

--Them du lieu vao bang LopHP
INSERT INTO LopHP
VALUES 
		('LHP01', N'Cơ sở dữ liệu', convert (datetime, '2022-2-20'), convert (datetime, '2022-5-20'), convert (datetime, '2022-6-20'), 1, 2022, 'HP01','GV03'),
		('LHP02', N'Luật đầu tư', convert (datetime, '2022-2-20'), convert (datetime, '2022-5-20'), convert (datetime, '2022-6-20'), 1, 2022, 'HP02', 'GV08'),
		('LHP03', N'Quản trị dự án', convert (datetime, '2022-2-20'), convert (datetime, '2022-2-20'), convert (datetime, '2022-6-20'), 3, 2022, 'HP03', 'GV01'),
		('LHP04', N'Kiểm toán căn bản', convert (datetime, '2022-3-10'), convert (datetime, '2022-6-10'), convert (datetime, '2022-6-30'), 2, 2022, 'HP04', 'GV04'),
		('LHP05', N'Thương mại quốc tế', convert (datetime, '2022-3-10'), convert (datetime, '2022-6-10'), convert (datetime, '2022-6-30'), 2, 2022, 'HP05', 'GV07')
go

-- Tao bang Dangky
CREATE TABLE DangKy
(
  MSSV			nvarchar (5) not null constraint FK_DangKy_MSSV references SinhVien(MSSV),
  MaLHP			nvarchar (8)  not null constraint FK_DangKy_MaLHP references LopHP(MaLHP),
  NgayDK		datetime not null,
  constraint PK_DangKy primary key (MSSV, MaLHP)
)
go

--Them du lieu vao bang DangKy
INSERT INTO DangKy
VALUES 
        ('SV01', 'LHP01', convert (datetime, '2022-2-1')),
		('SV02', 'LHP03', convert (datetime, '2022-2-1')),
		('SV03', 'LHP01', convert (datetime, '2022-2-1')),
		('SV04', 'LHP01', convert (datetime, '2022-2-1')),
		('SV05', 'LHP05', convert (datetime, '2022-2-1')),
		('SV06', 'LHP04', convert (datetime, '2022-2-1')),
		('SV07', 'LHP03', convert (datetime, '2022-2-1')),
		('SV08', 'LHP01', convert (datetime, '2022-2-1')),
		('SV09', 'LHP03', convert (datetime, '2022-2-1')),
		('SV010', 'LHP01', convert (datetime, '2022-2-1')),
		('SV011', 'LHP01', convert (datetime, '2022-2-1')),
		('SV012', 'LHP05', convert (datetime, '2022-2-1')),
		('SV013', 'LHP04', convert (datetime, '2022-2-1')),
		('SV014', 'LHP03', convert (datetime, '2022-2-1')),
		('SV015', 'LHP01', convert (datetime, '2022-2-1')),
		('SV016', 'LHP03', convert (datetime, '2022-2-1')),
		('SV017', 'LHP01', convert (datetime, '2022-2-1')),
		('SV018', 'LHP01', convert (datetime, '2022-2-1')),
		('SV019', 'LHP05', convert (datetime, '2022-2-1')), 
		('SV020', 'LHP04', convert (datetime, '2022-2-1'))
go

-- Tao bang DiemThi
CREATE TABLE DiemThi
(
  MSSV		nvarchar (5) not null constraint FK_DiemThi_MSSV references SinhVien(MSSV),
  MaLHP		nvarchar (8)  not null constraint FK_DiemThi_MaLHP references LopHP(MaLHP),
  DiemQt	float not null constraint CK_DiemThi_DiemQt Check (DiemQt >=0), 
  DiemThi   float not null constraint CK_DiemThi_DiemThi Check (DiemThi >=0), 
  DiemTb    float not null constraint CK_DiemThi_DiemTb Check (DiemTb >=0), 
  KetQua    nvarchar (20),

  constraint PK_DiemThi primary key (MSSV, MaLHP)
)
go

--Them du lieu vao bang DiemThi
INSERT INTO DiemThi
VALUES 
		('SV01', 'LHP01', 3, 2, 2.5, Null),
		('SV02', 'LHP03', 8, 10, 9, Null),
		('SV03', 'LHP01', 7, 7, 7, Null),
		('SV04', 'LHP01', 9, 9, 9, Null),
		('SV05', 'LHP05', 9, 10, 9.5, Null),
		('SV06', 'LHP04', 7, 9, 8, Null),
		('SV07', 'LHP03', 4, 4, 4, Null),
		('SV08', 'LHP01', 5, 7, 6, Null),
		('SV09', 'LHP03', 6, 4, 5, Null),
		('SV010', 'LHP01', 7, 7, 7, Null),
		('SV011', 'LHP01', 1, 2, 1.5, Null),
		('SV012', 'LHP05', 3, 5, 4, Null),
		('SV013', 'LHP04', 8, 8, 8, Null),
		('SV014', 'LHP03', 8, 10, 9, Null),
		('SV015', 'LHP01', 7, 7, 7, Null),
		('SV016', 'LHP03', 6, 4, 5, Null),
		('SV017', 'LHP01', 4, 8, 6, Null),
		('SV018', 'LHP01', 6, 2, 4, Null),
		('SV019', 'LHP05', 6, 6, 6, Null), 
		('SV020', 'LHP04', 5, 7, 6, Null)
go