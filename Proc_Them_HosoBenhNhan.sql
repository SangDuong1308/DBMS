USE QLPHONGKHAM
go

--Xem lich hen nha si
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

go
--Them lich lam viec--
CREATE OR ALTER PROC SP_NS_THEM_LICHLAMVIEC
	@LichBan DATE,
	@SDT CHAR(10)
AS
BEGIN TRAN
	DECLARE @MaNS CHAR(5)
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
EXEC dbo.SP_NS_THEM_LICHLAMVIEC @LichBan = '2024-02-03', -- date
                                @SDT = '0066814257'                -- char(10)

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

-- XEM HO SO KHAM BENH NHAN
CREATE OR ALTER PROC SP_NS_XEM_HOSOBENHNHAN
    @MaKH VARCHAR(255)
AS
BEGIN
    SELECT * FROM dbo.HoSoKham 
	WHERE dbo.HoSoKham.BenhNhan = @MaKH
END
GO
