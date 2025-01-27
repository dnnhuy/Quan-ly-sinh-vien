USE [master]
GO
/****** Object:  Database [QLSINHVIEN_UFM]    Script Date: 22/04/2023 10:47:00 CH ******/
CREATE DATABASE [QLSINHVIEN_UFM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLSINHVIEN_UFM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\QLSINHVIEN_UFM.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLSINHVIEN_UFM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\QLSINHVIEN_UFM_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLSINHVIEN_UFM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET RECOVERY FULL 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET  MULTI_USER 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLSINHVIEN_UFM', N'ON'
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET QUERY_STORE = OFF
GO
USE [QLSINHVIEN_UFM]
GO
/****** Object:  User [svien]    Script Date: 22/04/2023 10:47:00 CH ******/
CREATE USER [svien] FOR LOGIN [SINHVIEN] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [qly]    Script Date: 22/04/2023 10:47:00 CH ******/
CREATE USER [qly] FOR LOGIN [QUANLY] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Synonym [dbo].[db]    Script Date: 22/04/2023 10:47:00 CH ******/
CREATE SYNONYM [dbo].[db] FOR [sys].[databases]
GO
/****** Object:  Synonym [dbo].[S_SV]    Script Date: 22/04/2023 10:47:00 CH ******/
CREATE SYNONYM [dbo].[S_SV] FOR [SinhVien]
GO
/****** Object:  UserDefinedFunction [dbo].[f_slgvtheokhoa]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[f_slgvtheokhoa](@MAKHOA nchar(4))
returns int
as begin
declare @SOLUONGGV int
select @SOLUONGGV = COUNT(MaGV)
FROM GiangVien 
where MaKhoa=@MAKHOA
return @SOLUONGGV
end
GO
/****** Object:  Table [dbo].[Khoa]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khoa](
	[MaKhoa] [nvarchar](4) NOT NULL,
	[TenKhoa] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Khoa_MaKhoa] PRIMARY KEY CLUSTERED 
(
	[MaKhoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChuyenNganh]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChuyenNganh](
	[MaCN] [nvarchar](6) NOT NULL,
	[TenCN] [nvarchar](50) NOT NULL,
	[MaKhoa] [nvarchar](4) NULL,
 CONSTRAINT [PK_ChuyenNganh_MaCN] PRIMARY KEY CLUSTERED 
(
	[MaCN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_thongtinkhoa]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_thongtinkhoa] AS
SELECT K.MaKhoa, K.TenKhoa, MaCN, TenCN
FROM Khoa K, ChuyenNganh CN
WHERE K.MaKhoa=CN.MaKhoa
GO
/****** Object:  Table [dbo].[GiangVien]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiangVien](
	[MaGV] [nvarchar](5) NOT NULL,
	[HoTenGV] [nvarchar](20) NOT NULL,
	[NgaySinhGV] [datetime] NOT NULL,
	[GioiTinhGV] [nvarchar](6) NOT NULL,
	[SDTGV] [nvarchar](11) NOT NULL,
	[CMNDGV] [nvarchar](10) NOT NULL,
	[MaKhoa] [nvarchar](4) NULL,
 CONSTRAINT [PK_GiangVien_MaGV] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_ttGvkhoaCNTT]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ttGvkhoaCNTT] AS
SELECT *
FROM GiangVien
WHERE exists ( select *
				from Khoa
				where TenKhoa=N'Khoa Công nghệ thông tin' and Khoa.MaKhoa=GiangVien.MaKhoa)
GO
/****** Object:  Table [dbo].[Lop]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lop](
	[MaLop] [nvarchar](6) NOT NULL,
	[TenLop] [nvarchar](50) NOT NULL,
	[MaCN] [nvarchar](6) NULL,
 CONSTRAINT [PK_Lop_MaLop] PRIMARY KEY CLUSTERED 
(
	[MaLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SinhVien]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SinhVien](
	[MSSV] [nvarchar](5) NOT NULL,
	[HoTenSV] [nvarchar](20) NOT NULL,
	[NgaySinhSV] [datetime] NOT NULL,
	[GioiTinhSV] [nvarchar](6) NOT NULL,
	[SDTSV] [nvarchar](11) NOT NULL,
	[CMND] [nvarchar](10) NOT NULL,
	[MaLop] [nvarchar](6) NOT NULL,
	[MaTinh] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_SinhVien_MSSV] PRIMARY KEY CLUSTERED 
(
	[MSSV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_SLSVlop]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_SLSVlop] AS
SELECT SinhVien.MaLop, TenLop, count(MSSV) as N'Số lượng'
FROM SinhVien, Lop
where SinhVien.MaLop=Lop.MaLop
Group by  SinhVien.MaLop, TenLop
GO
/****** Object:  Table [dbo].[TinhTP]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinhTP](
	[MaTinh] [nvarchar](5) NOT NULL,
	[TenTinh] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_TinhTP_MaTinh] PRIMARY KEY CLUSTERED 
(
	[MaTinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_svTinhTPnhieunhat]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_svTinhTPnhieunhat] AS
SELECT top (1) with ties TinhTP.MaTinh, TenTinh, count(MSSV) as N'Số lượng sinh viên'
FROM SinhVien, TinhTP
where SinhVien.MaTinh=TinhTP.MaTinh
Group by  TinhTP.MaTinh, TenTinh
order by count(MSSV) desc
GO
/****** Object:  Table [dbo].[LopHP]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LopHP](
	[MaLHP] [nvarchar](8) NOT NULL,
	[TenHP] [nvarchar](20) NOT NULL,
	[NgayBd] [datetime] NOT NULL,
	[NgayKt] [datetime] NOT NULL,
	[NgayDukienthi] [datetime] NOT NULL,
	[HK] [tinyint] NOT NULL,
	[Nam] [int] NOT NULL,
	[MaHP] [nvarchar](5) NULL,
	[MaGV] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_LopHP_MaLHP] PRIMARY KEY CLUSTERED 
(
	[MaLHP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiemThi]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiemThi](
	[MSSV] [nvarchar](5) NOT NULL,
	[MaLHP] [nvarchar](8) NOT NULL,
	[DiemQt] [float] NOT NULL,
	[DiemThi] [float] NOT NULL,
	[DiemTb] [float] NOT NULL,
	[KetQua] [nvarchar](20) NULL,
 CONSTRAINT [PK_DiemThi] PRIMARY KEY CLUSTERED 
(
	[MSSV] ASC,
	[MaLHP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_maxdiemLHP]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_maxdiemLHP] AS
SELECT L1.MaLHP, SV1.MSSV, HoTenSV, DiemTb
FROM SinhVien SV1, DiemThi DT1, LopHP L1
where SV1.MSSV=DT1.MSSV and DT1.MaLHP=L1.MaLHP and
		DiemTb=(Select max(DiemTb) 
				from SinhVien SV2, DiemThi DT2, LopHP L2
				where SV2.MSSV=DT2.MSSV and DT2.MaLHP=L2.MaLHP
				and DT1.MaLHP=DT2.MaLHP)
GO
/****** Object:  UserDefinedFunction [dbo].[f_topsv]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[f_topsv](@MALHP nvarchar (8))
returns table
as
return (select top (1) with ties SinhVien.MSSV, HoTenSV, DiemThi, DiemThi.MaLHP
		from DiemThi, SinhVien, LopHP
		where DiemThi.MSSV=SinhVien.MSSV and DiemThi.MaLHP=LopHP.MaLHP and DiemThi.MaLHP=@MALHP
		order by DiemThi desc
		)
GO
/****** Object:  Table [dbo].[DangKy]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DangKy](
	[MSSV] [nvarchar](5) NOT NULL,
	[MaLHP] [nvarchar](8) NOT NULL,
	[NgayDK] [datetime] NOT NULL,
 CONSTRAINT [PK_DangKy] PRIMARY KEY CLUSTERED 
(
	[MSSV] ASC,
	[MaLHP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[f_top2lophp]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[f_top2lophp]()
returns table
as
return (select top (2) with ties count(MSSV) as 'So luong', MaLHP
		from DangKy
		group by MaLHP
		order by count(MSSV) desc
		)
GO
/****** Object:  Table [dbo].[HocPhan]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocPhan](
	[MaHP] [nvarchar](5) NOT NULL,
	[TenHP] [nvarchar](20) NOT NULL,
	[SoTinChi] [tinyint] NOT NULL,
	[SoTietLT] [tinyint] NOT NULL,
	[SoTietTH] [tinyint] NOT NULL,
	[MaKhoa] [nvarchar](4) NOT NULL,
 CONSTRAINT [PK_HocPhan_MaHP] PRIMARY KEY CLUSTERED 
(
	[MaHP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbRotMon]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbRotMon](
	[MSSVRot] [nvarchar](5) NOT NULL,
	[HoTenSVRot] [nvarchar](20) NOT NULL,
	[MaLHPRot] [nvarchar](8) NOT NULL,
	[DiemTbRot] [float] NOT NULL,
	[KetQuaRot] [nvarchar](20) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_HtGV]    Script Date: 22/04/2023 10:47:00 CH ******/
CREATE NONCLUSTERED INDEX [index_HtGV] ON [dbo].[GiangVien]
(
	[HoTenGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_CMND]    Script Date: 22/04/2023 10:47:00 CH ******/
CREATE UNIQUE NONCLUSTERED INDEX [index_CMND] ON [dbo].[SinhVien]
(
	[CMND] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChuyenNganh]  WITH CHECK ADD  CONSTRAINT [FK_ChuyenNganh_MaKhoa] FOREIGN KEY([MaKhoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[ChuyenNganh] CHECK CONSTRAINT [FK_ChuyenNganh_MaKhoa]
GO
ALTER TABLE [dbo].[DangKy]  WITH CHECK ADD  CONSTRAINT [FK_DangKy_MaLHP] FOREIGN KEY([MaLHP])
REFERENCES [dbo].[LopHP] ([MaLHP])
GO
ALTER TABLE [dbo].[DangKy] CHECK CONSTRAINT [FK_DangKy_MaLHP]
GO
ALTER TABLE [dbo].[DangKy]  WITH CHECK ADD  CONSTRAINT [FK_DangKy_MSSV] FOREIGN KEY([MSSV])
REFERENCES [dbo].[SinhVien] ([MSSV])
GO
ALTER TABLE [dbo].[DangKy] CHECK CONSTRAINT [FK_DangKy_MSSV]
GO
ALTER TABLE [dbo].[DiemThi]  WITH CHECK ADD  CONSTRAINT [FK_DiemThi_MaLHP] FOREIGN KEY([MaLHP])
REFERENCES [dbo].[LopHP] ([MaLHP])
GO
ALTER TABLE [dbo].[DiemThi] CHECK CONSTRAINT [FK_DiemThi_MaLHP]
GO
ALTER TABLE [dbo].[DiemThi]  WITH CHECK ADD  CONSTRAINT [FK_DiemThi_MSSV] FOREIGN KEY([MSSV])
REFERENCES [dbo].[SinhVien] ([MSSV])
GO
ALTER TABLE [dbo].[DiemThi] CHECK CONSTRAINT [FK_DiemThi_MSSV]
GO
ALTER TABLE [dbo].[GiangVien]  WITH CHECK ADD  CONSTRAINT [FK_GiangVien_MaKhoa] FOREIGN KEY([MaKhoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[GiangVien] CHECK CONSTRAINT [FK_GiangVien_MaKhoa]
GO
ALTER TABLE [dbo].[HocPhan]  WITH CHECK ADD  CONSTRAINT [FK_HocPhan_MaKhoa] FOREIGN KEY([MaKhoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[HocPhan] CHECK CONSTRAINT [FK_HocPhan_MaKhoa]
GO
ALTER TABLE [dbo].[Lop]  WITH CHECK ADD  CONSTRAINT [FK_Lop_MaCN] FOREIGN KEY([MaCN])
REFERENCES [dbo].[ChuyenNganh] ([MaCN])
GO
ALTER TABLE [dbo].[Lop] CHECK CONSTRAINT [FK_Lop_MaCN]
GO
ALTER TABLE [dbo].[LopHP]  WITH CHECK ADD  CONSTRAINT [FK_LopHP_MaGV] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiangVien] ([MaGV])
GO
ALTER TABLE [dbo].[LopHP] CHECK CONSTRAINT [FK_LopHP_MaGV]
GO
ALTER TABLE [dbo].[LopHP]  WITH CHECK ADD  CONSTRAINT [FK_LopHP_MaHP] FOREIGN KEY([MaHP])
REFERENCES [dbo].[HocPhan] ([MaHP])
GO
ALTER TABLE [dbo].[LopHP] CHECK CONSTRAINT [FK_LopHP_MaHP]
GO
ALTER TABLE [dbo].[SinhVien]  WITH CHECK ADD  CONSTRAINT [FK_SinhVien_MaLop] FOREIGN KEY([MaLop])
REFERENCES [dbo].[Lop] ([MaLop])
GO
ALTER TABLE [dbo].[SinhVien] CHECK CONSTRAINT [FK_SinhVien_MaLop]
GO
ALTER TABLE [dbo].[SinhVien]  WITH CHECK ADD  CONSTRAINT [FK_SinhVien_MaTinh] FOREIGN KEY([MaTinh])
REFERENCES [dbo].[TinhTP] ([MaTinh])
GO
ALTER TABLE [dbo].[SinhVien] CHECK CONSTRAINT [FK_SinhVien_MaTinh]
GO
ALTER TABLE [dbo].[DiemThi]  WITH CHECK ADD  CONSTRAINT [CK_DiemThi_DiemQt] CHECK  (([DiemQt]>=(0)))
GO
ALTER TABLE [dbo].[DiemThi] CHECK CONSTRAINT [CK_DiemThi_DiemQt]
GO
ALTER TABLE [dbo].[DiemThi]  WITH CHECK ADD  CONSTRAINT [CK_DiemThi_DiemTb] CHECK  (([DiemTb]>=(0)))
GO
ALTER TABLE [dbo].[DiemThi] CHECK CONSTRAINT [CK_DiemThi_DiemTb]
GO
ALTER TABLE [dbo].[DiemThi]  WITH CHECK ADD  CONSTRAINT [CK_DiemThi_DiemThi] CHECK  (([DiemThi]>=(0)))
GO
ALTER TABLE [dbo].[DiemThi] CHECK CONSTRAINT [CK_DiemThi_DiemThi]
GO
ALTER TABLE [dbo].[GiangVien]  WITH CHECK ADD  CONSTRAINT [CK_SinhVien_GioiTinhGV] CHECK  (([GioiTinhGV]=N'Khác' OR [GioiTinhGV]=N'Nữ' OR [GioiTinhGV]='Nam'))
GO
ALTER TABLE [dbo].[GiangVien] CHECK CONSTRAINT [CK_SinhVien_GioiTinhGV]
GO
ALTER TABLE [dbo].[LopHP]  WITH CHECK ADD  CONSTRAINT [CK_LopHP_HocKi] CHECK  (([HK]=(3) OR [HK]=(2) OR [HK]=(1)))
GO
ALTER TABLE [dbo].[LopHP] CHECK CONSTRAINT [CK_LopHP_HocKi]
GO
ALTER TABLE [dbo].[SinhVien]  WITH CHECK ADD  CONSTRAINT [CK_SinhVien_GioiTinhSV] CHECK  (([GioiTinhSV]=N'Khác' OR [GioiTinhSV]=N'Nữ' OR [GioiTinhSV]='Nam'))
GO
ALTER TABLE [dbo].[SinhVien] CHECK CONSTRAINT [CK_SinhVien_GioiTinhSV]
GO
/****** Object:  StoredProcedure [dbo].[pc_capnhatsdtGV]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[pc_capnhatsdtGV] (@MAGV nvarchar (5), @SDT nvarchar(11))
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
GO
/****** Object:  StoredProcedure [dbo].[pc_dschuyennganh]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pc_dschuyennganh] (@makhoa nvarchar (4))
AS
BEGIN
SELECT MaCN, TenCN
FROM ChuyenNganh
   WHERE ChuyenNganh.MaKhoa = @makhoa
END
GO
/****** Object:  StoredProcedure [dbo].[pc_maxtuoi]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[pc_maxtuoi]
as
begin
select top (1) with ties HoTenGV, (Year(GETDATE())-YEAR(NgaySinhGV)) as N'Tuổi'
from GiangVien
order by (Year(GETDATE())-YEAR(NgaySinhGV)) desc
end
GO
/****** Object:  StoredProcedure [dbo].[pc_updateketqua]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[pc_updateketqua]
as
begin
	update DiemThi
	set KetQua= cast((CASE WHEN DiemTb>4 THEN N'Đậu' ELSE N'Rớt' END) as nvarchar)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_RotMon]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_insert_RotMon]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_SLSinhVienDk]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_SLSinhVienDk] (@NGAYDK datetime, @SLSV int output)
as
begin
set @SLSV=(select count(MSSV) from DangKy where NgayDK=@NGAYDK group by NgayDK)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_themDK]    Script Date: 22/04/2023 10:47:00 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_themDK] (@MASV nvarchar (5), @MALHP nvarchar (8), @NGAYDK datetime)
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
GO
USE [master]
GO
ALTER DATABASE [QLSINHVIEN_UFM] SET  READ_WRITE 
GO
