USE MASTER
GO

IF DB_ID('QLPHONGKHAM') IS NOT NULL
	DROP DATABASE QLPHONGKHAM 
GO

CREATE DATABASE QLPHONGKHAM 
GO

USE QLPHONGKHAM 
GO

-- Tạo bảng TaiKhoan
CREATE TABLE TaiKhoan (
    SDT CHAR(10) PRIMARY KEY,
    MatKhau VARCHAR(8) NOT NULL,
    LoaiTK NVARCHAR(10)
);

-- Tạo bảng KhachHang
CREATE TABLE KhachHang (
    MaKH CHAR(5) PRIMARY KEY,
    HoTen NVARCHAR(30),
    NgSinh DATE,
    DiaChiKH NVARCHAR(100),
    SDT CHAR(10),
    FOREIGN KEY (SDT) REFERENCES TaiKhoan(SDT)
);

CREATE TABLE NhaSi (
    MaNS CHAR(5) PRIMARY KEY,
    SDTNS CHAR(10),
	NgSinhNS DATE,
    HoTen NVARCHAR(30),
    DiaChi NVARCHAR(100),
    ChiPhiKham DECIMAL(10, 2),
	FOREIGN KEY (SDTNS) REFERENCES TaiKhoan(SDT)
);

CREATE TABLE NhanVien (
    MaNV CHAR(5) PRIMARY KEY,
    SDTNV CHAR(10),
	NgSinhNV DATE,
    HoTen NVARCHAR(30),
    DiaChi NVARCHAR(100),
    LoaiNV NVARCHAR(10),
	FOREIGN KEY (SDTNV) REFERENCES TaiKhoan(SDT)
);

CREATE TABLE Thuoc (
    MaThuoc CHAR(5) PRIMARY KEY,
    TenThuoc NVARCHAR(30),
    DonVi VARCHAR(5),
    ChiDinh NVARCHAR(15),
    SoLuongTonKho INT,
    NgHetHan DATE,
    GiaTien DECIMAL(10, 2)
);

-- Tạo bảng DichVu
CREATE TABLE DichVu (
    MaDV CHAR(5) PRIMARY KEY,
    TenDV NVARCHAR(30),
    ChiPhi DECIMAL(10, 2)
);

-- Tạo bảng LichLamViec
CREATE TABLE LichLamViec (
    MaNS CHAR(5) PRIMARY KEY,
    LichBan DATE,
    FOREIGN KEY (MaNS) REFERENCES NhaSi(MaNS)
);



-- Tạo bảng LichHen
CREATE TABLE LichHen (
    MaKH CHAR(5),
    MaNS CHAR(5),
    ThoiGian DATE,
    PRIMARY KEY (MaNS, ThoiGian),
    FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
    FOREIGN KEY (MaNS) REFERENCES NhaSi(MaNS)
);

-- Tạo bảng HoSoKham
CREATE TABLE HoSoKham (
    MaHS CHAR(5) PRIMARY KEY,
    NgayKham DATE,
    NguoiKham CHAR(5),
    BenhNhan CHAR(5),
    FOREIGN KEY (NguoiKham) REFERENCES NhaSi(MaNS),
    FOREIGN KEY (BenhNhan) REFERENCES KhachHang(MaKH)
);

-- Tạo bảng HS_DV
CREATE TABLE HS_DV (
    MaHS CHAR(5),
    MaDV CHAR(5),
    PRIMARY KEY (MaHS, MaDV),
    FOREIGN KEY (MaHS) REFERENCES HoSoKham(MaHS),
    FOREIGN KEY (MaDV) REFERENCES DichVu(MaDV)
);

-- Tạo bảng HS_T
CREATE TABLE HS_T (
    MaHS CHAR(5),
    MaThuoc CHAR(5),
    SoLuong INT,
    PRIMARY KEY (MaHS, MaThuoc),
    FOREIGN KEY (MaHS) REFERENCES HoSoKham(MaHS),
    FOREIGN KEY (MaThuoc) REFERENCES Thuoc(MaThuoc)
);

-- Tạo bảng HoaDon
CREATE TABLE HoaDon (
    MaHS CHAR(5) PRIMARY KEY,
    TongTien DECIMAL(10, 2),
    TinhTrangThanhToan NVARCHAR(15),
	FOREIGN KEY (MaHS) REFERENCES HoSoKham(MaHS)
	
);

ALTER TABLE HoaDon
ADD CONSTRAINT CK_TinhTrangThanhToan
CHECK (TinhTrangThanhToan IN ('Đã thanh toán', 'Chưa thanh toán'));

ALTER TABLE NhanVien
ADD CONSTRAINT CK_LoaiNV
CHECK (LoaiNV IN (N'Thường', N'QTV'));

ALTER TABLE TaiKhoan
ADD CONSTRAINT CK_LoaiTK
CHECK (LoaiTK IN ('NV', 'NS', 'KH','QTV'));

go
CREATE TRIGGER TR_LichLamViec
ON LichLamViec
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN LichHen lh ON i.MaNS = lh.MaNS
        WHERE i.LichBan = lh.ThoiGian
    )
    BEGIN
        raiserror('trung lich', 16, 1);
        ROLLBACK tran;
    END
END
go

go
CREATE TRIGGER TR_LichHen
ON LichHen
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN LichLamViec llv ON i.MaNS = llv.MaNS
        WHERE i.ThoiGian = llv.LichBan
    )
    BEGIN
        raiserror('trung lich', 16, 1);
        ROLLBACK tran;
    END
END


go
CREATE TRIGGER TR_HSD
on HS_T
after insert, update
as
begin
	declare @hsd date

	select @hsd = t.NgHetHan
	from inserted i, Thuoc t
	where i.MaThuoc = t.MaThuoc

	if(@hsd < GETDATE())
	begin
		raiserror('error',16,1);
		rollback tran;
	end
end
