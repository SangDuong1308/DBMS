USE QLPHONGKHAM

GO

CREATE OR ALTER PROC SP_NS_XEM_TTCANHAN
AS
BEGIN
    SELECT *
    FROM V_TKNHASI
END
--EXEC dbo.SP_NS_XEM_TTCANHAN
GO

-- XEM HO SO KHAM BENH NHAN
CREATE OR ALTER PROC SP_NS_XEM_HOSOBENHNHAN
    @MaKH VARCHAR(255)
AS
BEGIN
    SELECT * FROM dbo.HoSoKham 
	WHERE dbo.HoSoKham.BenhNhan = @MaKH
END
GO

-- XEM THUOC -- 
CREATE OR ALTER PROC SP_NS_XEM_THUOC
AS
BEGIN
    SELECT * FROM V_XEM_THUOC
END
GO

-- XEM LỊCH LÀM VIỆC
USE QLPHONGKHAM
go
CREATE OR ALTER PROCEDURE SP_NS_XEM_LICHLAMVIEC
	@SDT CHAR(10)
AS
BEGIN
    SELECT dbo.LichLamViec.MaNS, dbo.LichLamViec.LichBan FROM dbo.LichLamViec INNER JOIN dbo.NhaSi ns
	ON ns.MaNS = dbo.LichLamViec.MaNS AND ns.SDTNS = @SDT
END
GO

DROP PROC SP_NS_SUA_TTCANHAN

-- UPDATE THONG TIN CA NHAN
CREATE OR ALTER PROC SP_NS_SUA_TTCANHAN
	@NGAYSINH DATE = NULL,
	@HOTEN NVARCHAR(30) = NULL,
	@DIACHI NVARCHAR(100) = NULL,
	@CHIPHIKHAM DECIMAL(10,2)
AS

BEGIN TRAN
	DECLARE @MaNS CHAR(5)
	SET @MaNS = CURRENT_USER

	IF (LEN(ISNULL(@NGAYSINH, '')) = 0)
		BEGIN
			SET @NGAYSINH = (SELECT NgSinhNS FROM dbo.NhaSi WHERE MaNS = @MaNS)
		END

	IF (LEN(ISNULL(@HOTEN, '')) = 0)
		BEGIN
			SET @HOTEN = (SELECT HoTen FROM dbo.NhaSi WHERE MaNS = @MaNS)
		END

	IF (LEN(ISNULL(@DIACHI, '')) = 0)
		BEGIN
			SET @DIACHI = (SELECT DiaChi FROM dbo.NhaSi WHERE MaNS = @MaNS)
		END

	IF (LEN(ISNULL(@CHIPHIKHAM, '')) = 0)
		BEGIN
			SET @CHIPHIKHAM = (SELECT ChiPhiKham FROM dbo.NhaSi WHERE MaNS = @MaNS)
		END

	UPDATE V_TKNHASI
	SET NgSinhNS = @NGAYSINH,
		HoTen = @HOTEN,
		DiaChi = @DIACHI,
		ChiPhiKham = @CHIPHIKHAM
	WHERE MaNS = @MaNS
			
	IF (@@ERROR <> 0)
		BEGIN
			RAISERROR (N'Không thể cập nhật. Vui lòng thử lại', 0, 0)
			ROLLBACK TRAN
			RETURN
		END
COMMIT TRAN
GO

--EXEC dbo.SP_NS_SUA_TTCANHAN @NGAYSINH = '2004-04-05',  -- date
--                            @HOTEN = 'Dunong PHuocs sang',     -- nvarchar(30)
--                            @DIACHI = '127 nvc',    -- nvarchar(100)
--                            @CHIPHIKHAM = '121223' -- decimal(10, 2)

--					SELECT * FROM dbo.NhaSi

-- THEM HO SO BENH NHAN
CREATE OR ALTER PROC SP_NS_THEM_HOSO_BENHNHAN
	@MaHS CHAR(5),
	@MaNS CHAR(5),
	@BenhNhan CHAR(5),
	@NgayKham DATE
AS
BEGIN TRAN

	INSERT INTO dbo.HoSoKham
	(
	    MaHS,
	    NgayKham,
	    NguoiKham,
	    BenhNhan
	)
	VALUES(@MaHS,@NgayKham,@MaNS,@NgayKham)
	IF (@@ERROR <> 0)
		BEGIN
			RAISERROR (N'Không thể thêm. Vui lòng thử lại', 0, 0)
			ROLLBACK TRAN
			RETURN
		END
COMMIT TRAN
GO

--EXEC dbo.SP_NS_THEM_HOSO_BENHNHAN @MaHS = 'HS101',              -- char(5)
--                                  @MaNS = 'NS01',              -- char(5)
--                                  @BenhNhan = 'KH02',          -- char(5)
--                                  @NgayKham = '2023-12-20' -- date
SELECT * FROM dbo.HoSoKham

-- KÊ ĐƠN THUỐC
CREATE OR ALTER PROC SP_NS_THEM_THUOC_SD
	@MaHS char(5),
	@MaThuoc char(5),
	@SoLuong int
AS
BEGIN TRAN
	IF (LEN(ISNULL(@MaThuoc, '')) = 0)
		BEGIN
			SET @MaThuoc = (SELECT MaThuoc FROM dbo.HS_T WHERE MaHS = @MaHS)
		END

	IF (LEN(ISNULL(@SoLuong, '')) = 0)
		BEGIN
			SET @SoLuong = (SELECT SoLuong FROM dbo.HS_T WHERE MaHS = @MaHS)
		END
	INSERT INTO HS_T(
											MaHS,
											MaThuoc,
											SoLuong)

	VALUES									(@MaHS,
											@MaThuoc,
											@SoLuong)

	IF (@@ERROR <> 0)
		BEGIN
			RAISERROR (N'Không thể thêm. Vui lòng thử lại', 0, 0)
			ROLLBACK TRAN
			RETURN
		END
COMMIT TRAN
GO

EXEC dbo.SP_NS_THEM_THUOC_SD @MaHS = 'HS001',
							 @MaThuoc = 'TH002',
							 @SoLuong = '5'
						 
--Them dich vu su dung benh nhan--		 
CREATE OR ALTER PROC SP_NS_THEM_DICHVUSD
	@MaHS char(5),
	@MaDV char(5)
AS
BEGIN TRAN
	INSERT INTO V_GHI_DICHVU_SD(			
											MaHS,
											MaDV)

	VALUES									(@MaHS,
											@MaDV)

	IF (@@ERROR <> 0)
		BEGIN
			RAISERROR (N'Không thể thêm. Vui lòng thử lại', 0, 0)
			ROLLBACK TRAN
			RETURN
		END
COMMIT TRAN
GO


--Them lich lam viec--
CREATE OR ALTER PROC SP_NS_THEM_LICHLAMVIEC
	@LichBan DATE,
	@SDT CHAR(10)
AS
BEGIN TRAN
	DECLARE @MaNS CHAR(10)
	SELECT @MaNS = MaNS FROM dbo.NhaSi WHERE SDTNS = @SDT
	INSERT INTO dbo.LichLamViec
	(
	    MaNS,
	    LichBan
	)
	VALUES
	(   
		@MaNS,  -- MaNS - char(5)
	    @LichBan -- LichBan - date
	)

	IF (@@ERROR <> 0)
		BEGIN
			RAISERROR (N'Không thể thêm. Vui lòng thử lại', 0, 0)
			ROLLBACK TRAN
			RETURN
		END
COMMIT TRAN
GO

--nha si xem lich hen voi khach hang--
USE QLPHONGKHAM
GO
--DROP PROC sp_XemLichHen
CREATE OR ALTER PROCEDURE SP_NS_XEM_LICHHEN
    @MaNS CHAR(5)
AS
BEGIN
    SELECT lh.ThoiGian, kh.HoTen AS TenKhachHang
    FROM LichHen lh
    JOIN KhachHang kh ON lh.MaKH = kh.MaKH
    WHERE lh.MaNS = @MaNS
END

EXEC dbo.SP_NS_XEM_LICHHEN @MaNS = 'NS010' -- char(5)

