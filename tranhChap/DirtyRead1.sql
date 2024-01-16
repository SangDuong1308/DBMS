USE QLPHONGKHAM
GO

--DROP PROCEDURE sp_LapHoaDon
CREATE OR ALTER PROCEDURE sp_LapHoaDon
	@MaHS CHAR(10)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	BEGIN TRAN
		IF NOT EXISTS (SELECT * FROM HoSoKham WHERE MaHS = @MaHS)
		BEGIN
			ROLLBACK TRAN 
			RETURN 1
		END
		DECLARE @PhiDV DECIMAL(10, 2), 
				@ChiPhiKham DECIMAL(10, 2), 
				@TienThuoc DECIMAL(10, 2), 
				@TongTien DECIMAL(10, 2)
 
   			SELECT @PhiDV = SUM(DV.ChiPhi) FROM HS_DV, DichVu DV WHERE HS_DV.MaHS = @MaHS AND HS_DV.MaDV = DV.MaDV
 
   			SELECT @ChiPhiKham = NS.ChiPhiKham FROM HoSoKham HSK, NhaSi NS WHERE HSK.MaHS = @MaHS AND HSK.NguoiKham = NS.MaNS
 
   			SELECT @TienThuoc = SUM(T.GiaTien*HS_T.SoLuong)
   			FROM HS_T, Thuoc T WHERE HS_T.MaHS = @MaHS AND HS_T.MaThuoc = T.MaThuoc
 
   			SET @TongTien = @PhiDV + @ChiPhiKham + @TienThuoc
			SELECT @TongTien AS Result;
	COMMIT

END

EXEC dbo.sp_LapHoaDon @MaHS = 'HS243' -- char(10)
