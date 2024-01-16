USE QLPHONGKHAM
GO

--DROP PROCEDURE sp_CapNhatPhiKham
CREATE OR alter PROCEDURE sp_CapNhatPhiKhamFix
	@MaNS CHAR(5),
	@ChiPhiKham decimal(10, 2)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
	BEGIN TRAN
	IF NOT EXISTS (SELECT 1 FROM dbo.NhaSi WHERE dbo.NhaSi.MaNS = @MaNS)
		BEGIN
			SELECT 'Nha sĩ kông không tồn tại.' AS Result;
			RETURN;
		END

	UPDATE dbo.NhaSi
		SET ChiPhiKham = @ChiPhiKham
		WHERE MaNS = @MaNS;
 
	WAITFOR DELAY '00:00:10'

	ROLLBACK
END

EXEC dbo.sp_CapNhatPhiKhamFix @MaNS = 'NS001',        -- char(5)
                           @ChiPhiKham = 100000 -- decimal(10, 2)
 