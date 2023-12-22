USE QLPHONGKHAM

GO

CREATE OR ALTER PROC SP_NS_XEM_TTCANHAN
AS
BEGIN
    SELECT *
    FROM V_TKNHASI
END
GO

-- XEM HO SO KHAM BENH NHAN
CREATE OR ALTER PROC SP_NS_XEM_BENHAN
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
CREATE OR ALTER PROCEDURE SP_NS_XEM_LICHLAMVIEC
AS
BEGIN
    SELECT * FROM dbo.LichLamViec WHERE MaNS = CURRENT_USER
    AND LichBan = GETDATE() 
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
CREATE OR ALTER PROC SP_NS_THEM_THUOCSD
	@MaHS CHAR(5),
	@MaThuoc CHAR(5),
	@SoLuong INT
AS
BEGIN TRAN
	SELECT @MaThuoc = MaThuoc
	FROM V_KEDONTHUOC 
	WHERE MaHS = @MaHS

	IF (LEN(ISNULL(@SoLuong, '')) = 0)
		BEGIN
			SET @SoLuong = (SELECT SoLuong FROM HS_T WHERE MaHS = @MaHS)
		END

	IF (@@ERROR <> 0)
		BEGIN
			RAISERROR (N'Không thể thêm. Vui lòng thử lại', 0, 0)
			ROLLBACK TRAN
			RETURN
		END
COMMIT TRAN
GO

-- THEM DICH VU
CREATE OR ALTER PROC SP_NS_THEM_DICHVU
	@MaDV CHAR(5),
	@TENDV NVARCHAR(30),
	@ChiPhi DECIMAL(10, 2)
AS
BEGIN TRAN

	INSERT INTO V_TT_LOAI_DICHVU(MaDV, TenDV,ChiPhi)
	VALUES (@MaDV, @TENDV, @ChiPhi)
	IF (@@ERROR <> 0)
		BEGIN
			RAISERROR (N'Không thể thêm. Vui lòng thử lại', 0, 0)
			ROLLBACK TRAN
			RETURN
		END
COMMIT TRAN
GO
