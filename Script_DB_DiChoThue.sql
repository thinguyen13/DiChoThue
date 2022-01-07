USE [QL_DiChoThue]
GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 06/12/2021 8:42:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[MaNCC] [int] IDENTITY(1,1) NOT NULL,
	[TenNCC] [nvarchar](50) NOT NULL,
	[GiayPhepKinhDoanh] [varchar](50) NOT NULL,
	[SDT] [varchar](10) NOT NULL,
	[DiaChi] [nvarchar](50) NOT NULL,
	[Email] [varchar](50) NULL,
	[SoTaiKhoanNganHang] [varchar](50) NULL,
	[TaiKhoan] [int] NULL,
	[VanChuyen] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[MaDH] [int] IDENTITY(1,1) NOT NULL,
	[NgayLap] [datetime] NULL,
	[TongTien] [float] NULL,
	[TrangThai] [nvarchar](50) NULL,
	[MaKH] [int] NOT NULL,
	[HinhThucThanhToan] [nvarchar](50) NULL,
	[MaDVVC] [int] NOT NULL,
	[PhiVanChuyen] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietDonHang]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDonHang](
	[MaDH] [int] NOT NULL,
	[MaSP] [int] NOT NULL,
	[MaNCC] [int] NOT NULL,
	[SoLuong] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDH] ASC,
	[MaSP] ASC,
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_ThongKe_ThuNhap_NCC]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_ThongKe_ThuNhap_NCC]
AS
SELECT DISTINCT YEAR(DH.NgayLap) AS 'Nam', DATEPART(QQ, DH.NgayLap) AS 'Quy', 
MONTH(DH.NgayLap) AS 'Thang', NCC.MaNCC, NCC.TenNCC,
SUM(DH.TongTien) AS 'DoanhThu'
FROM DonHang DH 
LEFT JOIN ChiTietDonHang CT ON CT.MaDH = DH.MaDH
LEFT JOIN NhaCungCap NCC ON NCC.MaNCC = CT.MaNCC
WHERE DH.TrangThai = N'Đã giao'
GROUP BY YEAR(DH.NgayLap), DATEPART(QQ, DH.NgayLap), Month(DH.NgayLap), 
NCC.MaNCC, NCC.TenNCC
GO
/****** Object:  Table [dbo].[DonViVanChuyen]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonViVanChuyen](
	[MaDVVC] [int] IDENTITY(1,1) NOT NULL,
	[TenDVVC] [nvarchar](50) NOT NULL,
	[GiayPhepKinhDoanh] [varchar](50) NOT NULL,
	[SoTaiKhoanNganHang] [varchar](50) NULL,
	[SDT] [varchar](10) NOT NULL,
	[DiaChi] [nvarchar](50) NOT NULL,
	[Email] [varchar](50) NULL,
	[PhiVanChuyen_KM] [float] NULL,
	[TaiKhoan] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDVVC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_ThongKe_ThuNhap_DVVC]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ThongKe_ThuNhap_DVVC]
AS
SELECT DISTINCT YEAR(DH.NgayLap) AS 'Nam', DATEPART(QQ, DH.NgayLap) AS 'Quy', 
MONTH(DH.NgayLap) AS 'Thang', DH.MaDVVC, DVVC.TenDVVC,
SUM(DH.PhiVanChuyen) AS 'DoanhThu'
FROM DonHang DH 
LEFT JOIN ChiTietDonHang CT ON CT.MaDH = DH.MaDH
LEFT JOIN DonViVanChuyen DVVC ON DVVC.MaDVVC = DH.MaDVVC
WHERE DH.TrangThai = N'Đã giao'
GROUP BY YEAR(DH.NgayLap), DATEPART(QQ, DH.NgayLap), Month(DH.NgayLap), 
DH.MaDVVC, DVVC.TenDVVC
GO
/****** Object:  Table [dbo].[SanPham_NCC]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham_NCC](
	[MaSP] [int] NOT NULL,
	[MaNCC] [int] NOT NULL,
	[NSX] [nvarchar](50) NULL,
	[Gia] [float] NULL,
	[HSD] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC,
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiSanPham]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiSanPham](
	[MaLoaiSP] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiSP] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSP] [int] IDENTITY(1,1) NOT NULL,
	[TenSP] [nvarchar](50) NOT NULL,
	[DonViTinh] [nvarchar](50) NULL,
	[LoaiSP] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_ThongKe_MatHangThietYeu]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ThongKe_MatHangThietYeu]
AS
SELECT L.MaLoaiSP, L.TenLoaiSP, SP.MaSP, SP.TenSP, NCC.TenNCC, 
		SP.DonViTinh, SP_NCC.NSX, SP_NCC.Gia
FROM SanPham SP
LEFT JOIN LoaiSanPham L ON L.MaLoaiSP = SP.LoaiSP
LEFT JOIN SanPham_NCC SP_NCC ON SP_NCC.MaSP = SP.MaSP
LEFT JOIN NhaCungCap NCC ON NCC.MaNCC = SP_NCC.MaNCC
WHERE NCC.TenNCC IS NOT NULL
GO
/****** Object:  View [dbo].[V_ThongKe_NhuCau_CungKy]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ThongKe_NhuCau_CungKy]
AS
SELECT DISTINCT YEAR(DH.NgayLap) AS 'Nam', DATEPART(QQ, DH.NgayLap) AS 'Quy',
MONTH(DH.NgayLap) AS 'Thang', 
SP.MaSP, SP.TenSP, NCC.MaNCC, NCC.TenNCC , SP.DonViTinh, SP_NCC.Gia,
SUM(CT.SoLuong) AS 'SLBanRa'
FROM ChiTietDonHang CT 
LEFT JOIN SanPham_NCC SP_NCC ON SP_NCC.MaNCC = CT.MaNCC AND SP_NCC.MaSP = CT.MaSP
LEFT JOIN SanPham SP ON SP.MaSP = CT.MaSP
LEFT JOIN NhaCungCap NCC ON NCC.MaNCC = CT.MaNCC
LEFT JOIN DonHang DH ON DH.MaDH = CT.MaDH
GROUP BY DH.NgayLap, NCC.MaNCC, NCC.TenNCC, SP.MaSP, SP.TenSP, SP.DonViTinh, SP_NCC.Gia
GO
/****** Object:  Table [dbo].[BlackList]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlackList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaKH] [int] NOT NULL,
	[LyDo] [varchar](50) NULL,
	[MucDo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTiet_PYC]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTiet_PYC](
	[MaPYC] [int] NOT NULL,
	[MaSP] [int] NOT NULL,
	[MaNCC] [int] NOT NULL,
	[SoLuong] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [int] IDENTITY(1,1) NOT NULL,
	[TenKH] [nvarchar](50) NOT NULL,
	[NgaySinh] [datetime] NULL,
	[SDT] [varchar](10) NOT NULL,
	[DiaChi] [nvarchar](50) NOT NULL,
	[Email] [varchar](50) NULL,
	[CMND] [varchar](20) NULL,
	[MaLoaiKH] [int] NULL,
	[TaiKhoan] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiKhachHang]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiKhachHang](
	[MaLoaiKH] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiKH] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuDangKy_CungUng]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuDangKy_CungUng](
	[MaPhieuDKCU] [int] IDENTITY(1,1) NOT NULL,
	[MaNCC] [int] NOT NULL,
	[NgayDK] [datetime] NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuDKCU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuDangKy_VanChuyen]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuDangKy_VanChuyen](
	[MaPhieuDKVC] [int] IDENTITY(1,1) NOT NULL,
	[MaDVVC] [int] NOT NULL,
	[NgayDK] [datetime] NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuDKVC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuDangKyDiCho]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuDangKyDiCho](
	[MaPhieuDKDC] [int] IDENTITY(1,1) NOT NULL,
	[MaKH] [int] NOT NULL,
	[NgayDK] [datetime] NULL,
	[SoThanhVienGD] [int] NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuDKDC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuYeuCauMuaHang]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuYeuCauMuaHang](
	[MaPYC] [int] IDENTITY(1,1) NOT NULL,
	[MaKH] [int] NOT NULL,
	[NgayLapPhieu] [datetime] NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPYC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham_Chon]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham_Chon](
	[MaKH] [int] NOT NULL,
	[MaSP] [int] NOT NULL,
	[MaNCC] [int] NOT NULL,
	[ThoiGianChon] [datetime] NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC,
	[MaSP] ASC,
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[TrangThai] [nvarchar](50) NULL,
	[VaiTro] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BlackList] ON 

INSERT [dbo].[BlackList] ([ID], [MaKH], [LyDo], [MucDo]) VALUES (1, 3, N'Ð?t cho vui', 1)
SET IDENTITY_INSERT [dbo].[BlackList] OFF
GO
INSERT [dbo].[ChiTiet_PYC] ([MaPYC], [MaSP], [MaNCC], [SoLuong]) VALUES (1, 1, 1, 1)
INSERT [dbo].[ChiTiet_PYC] ([MaPYC], [MaSP], [MaNCC], [SoLuong]) VALUES (1, 4, 1, 2)
INSERT [dbo].[ChiTiet_PYC] ([MaPYC], [MaSP], [MaNCC], [SoLuong]) VALUES (1, 4, 2, 1)
INSERT [dbo].[ChiTiet_PYC] ([MaPYC], [MaSP], [MaNCC], [SoLuong]) VALUES (2, 2, 2, 1)
INSERT [dbo].[ChiTiet_PYC] ([MaPYC], [MaSP], [MaNCC], [SoLuong]) VALUES (2, 1, 3, 1)
INSERT [dbo].[ChiTiet_PYC] ([MaPYC], [MaSP], [MaNCC], [SoLuong]) VALUES (3, 4, 2, 3)
INSERT [dbo].[ChiTiet_PYC] ([MaPYC], [MaSP], [MaNCC], [SoLuong]) VALUES (3, 4, 3, 1)
GO
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (1, 1, 3, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (1, 2, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (1, 4, 2, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (2, 1, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (2, 4, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (3, 4, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (3, 4, 2, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (3, 4, 3, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (4, 1, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (4, 2, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (4, 4, 2, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (4, 4, 3, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (7, 1, 1, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (7, 1, 3, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (7, 2, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (7, 4, 3, 5)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (8, 1, 3, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (8, 4, 2, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (9, 1, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (9, 2, 1, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (9, 4, 1, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (10, 1, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (10, 4, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (10, 4, 2, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (11, 1, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (11, 2, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (12, 1, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (12, 2, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (12, 4, 3, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (13, 1, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (13, 2, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (13, 4, 3, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (14, 1, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (14, 4, 1, 5)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (14, 4, 2, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (15, 2, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (15, 4, 3, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (16, 1, 1, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (16, 2, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (16, 4, 2, 2)
GO
SET IDENTITY_INSERT [dbo].[DonHang] ON 

INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [MaDVVC], [PhiVanChuyen]) VALUES (1, CAST(N'2021-09-12T00:00:00.000' AS DateTime), 289500, N'Đang giao', 1, N'Tiền mặt', 1, 20000)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [MaDVVC], [PhiVanChuyen]) VALUES (2, CAST(N'2021-09-12T00:00:00.000' AS DateTime), 127500, N'Đang giao', 2, N'Chuyển khoản', 2, 12000)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [MaDVVC], [PhiVanChuyen]) VALUES (3, CAST(N'2021-09-12T00:00:00.000' AS DateTime), 217500, N'Đang giao', 4, N'Tiền mặt', 1, 15000)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [MaDVVC], [PhiVanChuyen]) VALUES (4, CAST(N'2021-10-21T00:00:00.000' AS DateTime), 362000, N'Đã giao', 1, N'Tiền mặt', 2, 25000)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [MaDVVC], [PhiVanChuyen]) VALUES (7, CAST(N'2021-11-01T00:00:00.000' AS DateTime), 344500, N'Đổi trả', 2, N'Chuyển khoản', 1, 32000)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [MaDVVC], [PhiVanChuyen]) VALUES (8, CAST(N'2021-11-02T00:00:00.000' AS DateTime), 127500, N'Đã giao', 3, N'Chuyển khoản', 2, 9000)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [MaDVVC], [PhiVanChuyen]) VALUES (9, CAST(N'2021-08-02T00:00:00.000' AS DateTime), 289500, N'Đã giao', 4, N'Tiền mặt', 1, 19000)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [MaDVVC], [PhiVanChuyen]) VALUES (10, CAST(N'2021-07-19T00:00:00.000' AS DateTime), 200000, N'Đã giao', 4, N'Chuyển khoản', 2, 31000)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [MaDVVC], [PhiVanChuyen]) VALUES (11, CAST(N'2021-08-01T00:00:00.000' AS DateTime), 217000, N'Đổi trả', 1, N'Tiền mặt', 1, 50000)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [MaDVVC], [PhiVanChuyen]) VALUES (12, CAST(N'2021-11-21T00:00:00.000' AS DateTime), 289500, N'Đã giao', 2, N'Chuyển khoản', 1, 38000)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [MaDVVC], [PhiVanChuyen]) VALUES (13, CAST(N'2020-11-01T00:00:00.000' AS DateTime), 289500, N'Đã giao', 3, N'Tiền mặt', 2, 12500)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [MaDVVC], [PhiVanChuyen]) VALUES (14, CAST(N'2020-04-12T00:00:00.000' AS DateTime), 200000, N'Đã giao', 1, N'Chuyển khoản', 1, 5000)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [MaDVVC], [PhiVanChuyen]) VALUES (15, CAST(N'2020-06-30T00:00:00.000' AS DateTime), 234500, N'Đã giao', 4, N'Tiền mặt', 1, 13000)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [MaDVVC], [PhiVanChuyen]) VALUES (16, CAST(N'2020-12-12T00:00:00.000' AS DateTime), 289500, N'Đã giao', 2, N'Tiền mặt', 2, 33000)
SET IDENTITY_INSERT [dbo].[DonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[DonViVanChuyen] ON 

INSERT [dbo].[DonViVanChuyen] ([MaDVVC], [TenDVVC], [GiayPhepKinhDoanh], [SoTaiKhoanNganHang], [SDT], [DiaChi], [Email], [PhiVanChuyen_KM], [TaiKhoan]) VALUES (1, N'Viettel Post', N'GPKD091283-VN012021', N'0112983012', N'0192837465', N'TPHCM', N'vp@gmail.com', 200, 9)
INSERT [dbo].[DonViVanChuyen] ([MaDVVC], [TenDVVC], [GiayPhepKinhDoanh], [SoTaiKhoanNganHang], [SDT], [DiaChi], [Email], [PhiVanChuyen_KM], [TaiKhoan]) VALUES (2, N'Giao hàng nhanh', N'GPKD04642-VN032021', N'0111234012', N'0199003465', N'TPHCM', N'ghn@gmail.com', 130, 10)
SET IDENTITY_INSERT [dbo].[DonViVanChuyen] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [NgaySinh], [SDT], [DiaChi], [Email], [CMND], [MaLoaiKH], [TaiKhoan]) VALUES (1, N'Nguyễn Văn An', CAST(N'2000-12-02T00:00:00.000' AS DateTime), N'0987654321', N'Q1, TPHCM', N'an@gmail.com', N'1234567890', 1, 1)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [NgaySinh], [SDT], [DiaChi], [Email], [CMND], [MaLoaiKH], [TaiKhoan]) VALUES (2, N'Nguyễn Thị Tuyết', CAST(N'2000-01-21T00:00:00.000' AS DateTime), N'0987654322', N'Q2, TPHCM', N'tuyet@gmail.com', N'1234567891', 1, 2)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [NgaySinh], [SDT], [DiaChi], [Email], [CMND], [MaLoaiKH], [TaiKhoan]) VALUES (3, N'Trần Tuấn', CAST(N'2000-01-10T00:00:00.000' AS DateTime), N'0987654321', N'Q1, TPHCM', N'tuan@gmail.com', N'1234567892', 1, 3)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [NgaySinh], [SDT], [DiaChi], [Email], [CMND], [MaLoaiKH], [TaiKhoan]) VALUES (4, N'Lê Đức', CAST(N'2000-12-29T00:00:00.000' AS DateTime), N'0987654321', N'Q1, TPHCM', N'duc@gmail.com', N'1234567893', 2, 4)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [NgaySinh], [SDT], [DiaChi], [Email], [CMND], [MaLoaiKH], [TaiKhoan]) VALUES (5, N'Lê Anh Thư', CAST(N'2000-07-30T00:00:00.000' AS DateTime), N'0987654321', N'Q1, TPHCM', N'thu@gmail.com', N'1234567894', 2, 5)
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiKhachHang] ON 

INSERT [dbo].[LoaiKhachHang] ([MaLoaiKH], [TenLoaiKH]) VALUES (1, N'Thông thường')
INSERT [dbo].[LoaiKhachHang] ([MaLoaiKH], [TenLoaiKH]) VALUES (2, N'VIP')
SET IDENTITY_INSERT [dbo].[LoaiKhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiSanPham] ON 

INSERT [dbo].[LoaiSanPham] ([MaLoaiSP], [TenLoaiSP]) VALUES (1, N'Lương thực')
INSERT [dbo].[LoaiSanPham] ([MaLoaiSP], [TenLoaiSP]) VALUES (2, N'Y tế')
SET IDENTITY_INSERT [dbo].[LoaiSanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[NhaCungCap] ON 

INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [GiayPhepKinhDoanh], [SDT], [DiaChi], [Email], [SoTaiKhoanNganHang], [TaiKhoan], [VanChuyen]) VALUES (1, N'Bách hóa xanh Q,1', N'GP10112020', N'0129837461', N'Q1, TPHCM', N'bhx@yahoo.com', N'0987651423', 6, NULL)
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [GiayPhepKinhDoanh], [SDT], [DiaChi], [Email], [SoTaiKhoanNganHang], [TaiKhoan], [VanChuyen]) VALUES (2, N'Siêu thị BigC', N'GP10112020', N'0129837222', N'Q2, TPHCM', N'bigc@yahoo.com', N'0987651666', 7, NULL)
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [GiayPhepKinhDoanh], [SDT], [DiaChi], [Email], [SoTaiKhoanNganHang], [TaiKhoan], [VanChuyen]) VALUES (3, N'Bách hóa xanh Thủ Đức', N'GP10112020', N'0129837333', N'Th? Ð?c, TPHCM', N'bhxtd@yahoo.com', N'0987651888', 8, NULL)
SET IDENTITY_INSERT [dbo].[NhaCungCap] OFF
GO
SET IDENTITY_INSERT [dbo].[PhieuDangKy_CungUng] ON 

INSERT [dbo].[PhieuDangKy_CungUng] ([MaPhieuDKCU], [MaNCC], [NgayDK], [TrangThai]) VALUES (1, 1, CAST(N'2021-02-02T00:00:00.000' AS DateTime), N'Thành công')
INSERT [dbo].[PhieuDangKy_CungUng] ([MaPhieuDKCU], [MaNCC], [NgayDK], [TrangThai]) VALUES (2, 2, CAST(N'2021-02-19T00:00:00.000' AS DateTime), N'Thành công')
INSERT [dbo].[PhieuDangKy_CungUng] ([MaPhieuDKCU], [MaNCC], [NgayDK], [TrangThai]) VALUES (3, 3, CAST(N'2021-02-23T00:00:00.000' AS DateTime), N'Thành công')
SET IDENTITY_INSERT [dbo].[PhieuDangKy_CungUng] OFF
GO
SET IDENTITY_INSERT [dbo].[PhieuDangKy_VanChuyen] ON 

INSERT [dbo].[PhieuDangKy_VanChuyen] ([MaPhieuDKVC], [MaDVVC], [NgayDK], [TrangThai]) VALUES (1, 1, CAST(N'2021-01-05T00:00:00.000' AS DateTime), N'Thành công')
INSERT [dbo].[PhieuDangKy_VanChuyen] ([MaPhieuDKVC], [MaDVVC], [NgayDK], [TrangThai]) VALUES (2, 2, CAST(N'2021-01-12T00:00:00.000' AS DateTime), N'Thành công')
SET IDENTITY_INSERT [dbo].[PhieuDangKy_VanChuyen] OFF
GO
SET IDENTITY_INSERT [dbo].[PhieuDangKyDiCho] ON 

INSERT [dbo].[PhieuDangKyDiCho] ([MaPhieuDKDC], [MaKH], [NgayDK], [SoThanhVienGD], [TrangThai]) VALUES (1, 1, CAST(N'2021-01-01T00:00:00.000' AS DateTime), 2, N'Thành công')
INSERT [dbo].[PhieuDangKyDiCho] ([MaPhieuDKDC], [MaKH], [NgayDK], [SoThanhVienGD], [TrangThai]) VALUES (2, 2, CAST(N'2021-01-01T00:00:00.000' AS DateTime), 3, N'Thành công')
INSERT [dbo].[PhieuDangKyDiCho] ([MaPhieuDKDC], [MaKH], [NgayDK], [SoThanhVienGD], [TrangThai]) VALUES (3, 3, CAST(N'2021-01-01T00:00:00.000' AS DateTime), 5, N'Thành công')
INSERT [dbo].[PhieuDangKyDiCho] ([MaPhieuDKDC], [MaKH], [NgayDK], [SoThanhVienGD], [TrangThai]) VALUES (4, 4, CAST(N'2021-01-01T00:00:00.000' AS DateTime), 1, N'Thành công')
INSERT [dbo].[PhieuDangKyDiCho] ([MaPhieuDKDC], [MaKH], [NgayDK], [SoThanhVienGD], [TrangThai]) VALUES (5, 5, CAST(N'2021-01-01T00:00:00.000' AS DateTime), 2, N'Thành công')
SET IDENTITY_INSERT [dbo].[PhieuDangKyDiCho] OFF
GO
SET IDENTITY_INSERT [dbo].[PhieuYeuCauMuaHang] ON 

INSERT [dbo].[PhieuYeuCauMuaHang] ([MaPYC], [MaKH], [NgayLapPhieu], [TrangThai]) VALUES (1, 1, CAST(N'2021-05-05T00:00:00.000' AS DateTime), N'Đã xử lý')
INSERT [dbo].[PhieuYeuCauMuaHang] ([MaPYC], [MaKH], [NgayLapPhieu], [TrangThai]) VALUES (2, 2, CAST(N'2021-06-05T00:00:00.000' AS DateTime), N'Đang xử lý')
INSERT [dbo].[PhieuYeuCauMuaHang] ([MaPYC], [MaKH], [NgayLapPhieu], [TrangThai]) VALUES (3, 4, CAST(N'2021-07-05T00:00:00.000' AS DateTime), N'Đã xử lý')
SET IDENTITY_INSERT [dbo].[PhieuYeuCauMuaHang] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DonViTinh], [LoaiSP]) VALUES (1, N'Gạo thơm', N'Bao 10kg', 1)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DonViTinh], [LoaiSP]) VALUES (2, N'Thịt heo', N'Kg', 1)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DonViTinh], [LoaiSP]) VALUES (3, N'Cá thu', N'Kg', 1)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DonViTinh], [LoaiSP]) VALUES (4, N'Nước mắm Nam ngư', N'Chai', 1)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DonViTinh], [LoaiSP]) VALUES (5, N'Khẩu trang y tế', N'Hộp', 2)
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
INSERT [dbo].[SanPham_Chon] ([MaKH], [MaSP], [MaNCC], [ThoiGianChon], [TrangThai]) VALUES (1, 1, 1, CAST(N'2021-11-24T22:37:04.673' AS DateTime), N'Đang chọn')
INSERT [dbo].[SanPham_Chon] ([MaKH], [MaSP], [MaNCC], [ThoiGianChon], [TrangThai]) VALUES (1, 2, 2, CAST(N'2021-11-24T22:37:04.673' AS DateTime), N'Đang chọn')
INSERT [dbo].[SanPham_Chon] ([MaKH], [MaSP], [MaNCC], [ThoiGianChon], [TrangThai]) VALUES (1, 4, 1, CAST(N'2021-11-24T22:37:04.677' AS DateTime), N'Đang chọn')
INSERT [dbo].[SanPham_Chon] ([MaKH], [MaSP], [MaNCC], [ThoiGianChon], [TrangThai]) VALUES (2, 4, 2, CAST(N'2021-11-24T22:37:04.677' AS DateTime), N'Đang chọn')
INSERT [dbo].[SanPham_Chon] ([MaKH], [MaSP], [MaNCC], [ThoiGianChon], [TrangThai]) VALUES (3, 4, 1, CAST(N'2021-11-24T22:37:04.677' AS DateTime), N'Đang chọn')
GO
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (1, 1, N'Gạo Việt Thương', 27000, CAST(N'2022-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (1, 3, N'Gạo Việt Thương', 28000, CAST(N'2022-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (2, 1, N'H2T-Food', 80000, CAST(N'2022-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (2, 2, N'H2T-Food', 82000, CAST(N'2022-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (4, 1, N'Chinsu', 24000, CAST(N'2022-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (4, 2, N'Chinsu', 23500, CAST(N'2022-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (4, 3, N'Chinsu', 25000, CAST(N'2022-12-31T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (1, N'1', N'12345', N'Đang hoạt động', N'KH')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (2, N'2', N'12345', N'Đang hoạt động', N'KH')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (3, N'3', N'12345', N'Đang hoạt động', N'KH')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (4, N'4', N'12345', N'Đang hoạt động', N'KH')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (5, N'5', N'12345', N'Đang hoạt động', N'KH')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (6, N'1', N'12345', N'Đang hoạt động', N'NCC')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (7, N'2', N'12345', N'Đang hoạt động', N'NCC')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (8, N'3', N'12345', N'Đang hoạt động', N'NCC')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (9, N'1', N'12345', N'Đang hoạt động', N'DVVC')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (10, N'2', N'12345', N'Đang hoạt động', N'DVVC')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (11, N'1', N'12345', N'Đang hoạt động', N'QL')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (12, N'1', N'12345', N'Đang hoạt động', N'ADMIN')
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
GO
ALTER TABLE [dbo].[BlackList] ADD  DEFAULT ((1)) FOR [MucDo]
GO
ALTER TABLE [dbo].[ChiTiet_PYC] ADD  DEFAULT ((1)) FOR [SoLuong]
GO
ALTER TABLE [dbo].[ChiTietDonHang] ADD  DEFAULT ((1)) FOR [SoLuong]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT (getdate()) FOR [NgayLap]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT ((0)) FOR [TongTien]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT (N'Chờ duyệt') FOR [TrangThai]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT (N'Tiền mặt') FOR [HinhThucThanhToan]
GO
ALTER TABLE [dbo].[DonViVanChuyen] ADD  DEFAULT ((0)) FOR [PhiVanChuyen_KM]
GO
ALTER TABLE [dbo].[NhaCungCap] ADD  DEFAULT ((0)) FOR [VanChuyen]
GO
ALTER TABLE [dbo].[PhieuDangKy_CungUng] ADD  DEFAULT (getdate()) FOR [NgayDK]
GO
ALTER TABLE [dbo].[PhieuDangKy_CungUng] ADD  DEFAULT (N'Chờ duyệt') FOR [TrangThai]
GO
ALTER TABLE [dbo].[PhieuDangKy_VanChuyen] ADD  DEFAULT (getdate()) FOR [NgayDK]
GO
ALTER TABLE [dbo].[PhieuDangKy_VanChuyen] ADD  DEFAULT (N'Chờ duyệt') FOR [TrangThai]
GO
ALTER TABLE [dbo].[PhieuDangKyDiCho] ADD  DEFAULT (getdate()) FOR [NgayDK]
GO
ALTER TABLE [dbo].[PhieuDangKyDiCho] ADD  DEFAULT ((1)) FOR [SoThanhVienGD]
GO
ALTER TABLE [dbo].[PhieuDangKyDiCho] ADD  DEFAULT (N'Chờ duyệt') FOR [TrangThai]
GO
ALTER TABLE [dbo].[PhieuYeuCauMuaHang] ADD  DEFAULT (getdate()) FOR [NgayLapPhieu]
GO
ALTER TABLE [dbo].[PhieuYeuCauMuaHang] ADD  DEFAULT (N'Đang xử lý') FOR [TrangThai]
GO
ALTER TABLE [dbo].[SanPham_Chon] ADD  DEFAULT (getdate()) FOR [ThoiGianChon]
GO
ALTER TABLE [dbo].[SanPham_Chon] ADD  DEFAULT (N'Đang chọn') FOR [TrangThai]
GO
ALTER TABLE [dbo].[SanPham_NCC] ADD  DEFAULT ((0)) FOR [Gia]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT ('12345') FOR [Password]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT (N'Đang hoạt động') FOR [TrangThai]
GO
ALTER TABLE [dbo].[BlackList]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[ChiTiet_PYC]  WITH CHECK ADD FOREIGN KEY([MaPYC])
REFERENCES [dbo].[PhieuYeuCauMuaHang] ([MaPYC])
GO
ALTER TABLE [dbo].[ChiTiet_PYC]  WITH CHECK ADD FOREIGN KEY([MaSP], [MaNCC])
REFERENCES [dbo].[SanPham_NCC] ([MaSP], [MaNCC])
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD FOREIGN KEY([MaDH])
REFERENCES [dbo].[DonHang] ([MaDH])
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD FOREIGN KEY([MaSP], [MaNCC])
REFERENCES [dbo].[SanPham_NCC] ([MaSP], [MaNCC])
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD FOREIGN KEY([MaDVVC])
REFERENCES [dbo].[DonViVanChuyen] ([MaDVVC])
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[DonViVanChuyen]  WITH CHECK ADD FOREIGN KEY([TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID])
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD FOREIGN KEY([MaLoaiKH])
REFERENCES [dbo].[LoaiKhachHang] ([MaLoaiKH])
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD FOREIGN KEY([TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID])
GO
ALTER TABLE [dbo].[NhaCungCap]  WITH CHECK ADD FOREIGN KEY([TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID])
GO
ALTER TABLE [dbo].[NhaCungCap]  WITH CHECK ADD FOREIGN KEY([VanChuyen])
REFERENCES [dbo].[DonViVanChuyen] ([MaDVVC])
GO
ALTER TABLE [dbo].[PhieuDangKy_CungUng]  WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[PhieuDangKy_VanChuyen]  WITH CHECK ADD FOREIGN KEY([MaDVVC])
REFERENCES [dbo].[DonViVanChuyen] ([MaDVVC])
GO
ALTER TABLE [dbo].[PhieuDangKyDiCho]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[PhieuYeuCauMuaHang]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([LoaiSP])
REFERENCES [dbo].[LoaiSanPham] ([MaLoaiSP])
GO
ALTER TABLE [dbo].[SanPham_Chon]  WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[SanPham_Chon]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[SanPham_Chon]  WITH CHECK ADD FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[SanPham_NCC]  WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[SanPham_NCC]  WITH CHECK ADD FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[BlackList]  WITH CHECK ADD CHECK  (([MucDo]>(0)))
GO
ALTER TABLE [dbo].[ChiTiet_PYC]  WITH CHECK ADD CHECK  (([SoLuong]>(0)))
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD CHECK  (([SoLuong]>(0)))
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD CHECK  (([HinhThucThanhToan] like N'Tiền mặt' OR [HinhThucThanhToan] like N'Chuyển khoản'))
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD CHECK  (([TongTien]>=(0)))
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD CHECK  (([TrangThai] like N'Chờ duyệt' OR [TrangThai] like N'Đang giao' OR [TrangThai] like N'Đã hủy' OR [TrangThai] like N'Đã giao' OR [TrangThai] like N'Đổi trả'))
GO
ALTER TABLE [dbo].[DonViVanChuyen]  WITH CHECK ADD CHECK  (([Email] like '%@%'))
GO
ALTER TABLE [dbo].[DonViVanChuyen]  WITH CHECK ADD CHECK  (([PhiVanChuyen_KM]>(0)))
GO
ALTER TABLE [dbo].[DonViVanChuyen]  WITH CHECK ADD CHECK  ((len([SDT])=(10)))
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD CHECK  (([Email] like '%@%'))
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD CHECK  (((getdate()-[NgaySinh])>=(5)))
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD CHECK  ((len([SDT])=(10)))
GO
ALTER TABLE [dbo].[NhaCungCap]  WITH CHECK ADD CHECK  (([Email] like '%@%'))
GO
ALTER TABLE [dbo].[NhaCungCap]  WITH CHECK ADD CHECK  ((len([SDT])=(10)))
GO
ALTER TABLE [dbo].[PhieuDangKy_CungUng]  WITH CHECK ADD CHECK  (([TrangThai] like N'Thành công' OR [TrangThai] like N'Chờ duyệt' OR [TrangThai] like N'Đã hủy'))
GO
ALTER TABLE [dbo].[PhieuDangKy_VanChuyen]  WITH CHECK ADD CHECK  (([TrangThai] like N'Thành công' OR [TrangThai] like N'Chờ duyệt' OR [TrangThai] like N'Đã hủy'))
GO
ALTER TABLE [dbo].[PhieuDangKyDiCho]  WITH CHECK ADD CHECK  (([SoThanhVienGD]>(0)))
GO
ALTER TABLE [dbo].[PhieuDangKyDiCho]  WITH CHECK ADD CHECK  (([TrangThai] like N'Thành công' OR [TrangThai] like N'Chờ duyệt' OR [TrangThai] like N'Đã hủy'))
GO
ALTER TABLE [dbo].[PhieuYeuCauMuaHang]  WITH CHECK ADD CHECK  (([TrangThai] like N'Đang xử lý' OR [TrangThai] like N'Đã xử lý'))
GO
ALTER TABLE [dbo].[SanPham_Chon]  WITH CHECK ADD CHECK  (([TrangThai] like N'Đang chọn' OR [TrangThai] like N'Đã bỏ chọn'))
GO
ALTER TABLE [dbo].[SanPham_NCC]  WITH CHECK ADD CHECK  (([Gia]>=(0)))
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD CHECK  (([TrangThai] like N'Đang hoạt động' OR [TrangThai] like N'Đã dừng'))
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD CHECK  (([VaiTro] like 'NCC' OR [VaiTro] like 'DVVC' OR [VaiTro] like 'KH' OR [VaiTro] like 'QL' OR [VaiTro] like 'ADMIN'))
GO
/****** Object:  StoredProcedure [dbo].[P_Demo]    Script Date: 06/12/2021 8:42:16 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[P_Demo]
AS
BEGIN
	SELECT * FROM SanPham
END
GO
