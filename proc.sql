USE QLPHONGKHAM
CREATE or alter PROCEDURE GetAccountType
    @SDT CHAR(10),
    @MatKhau VARCHAR(8)
AS
BEGIN
    DECLARE @AccountType INT

    IF EXISTS (SELECT 1 FROM TaiKhoan WHERE SDT = @SDT AND MatKhau = @MatKhau AND LoaiTK = 'QTV')
        SET @AccountType = 1;
    ELSE IF EXISTS (SELECT 1 FROM TaiKhoan WHERE SDT = @SDT AND MatKhau = @MatKhau AND LoaiTK = 'NV')
        SET @AccountType = 2;
    ELSE IF EXISTS (SELECT 1 FROM TaiKhoan WHERE SDT = @SDT AND MatKhau = @MatKhau AND LoaiTK = 'KH')
        SET @AccountType = 3;
    ELSE IF EXISTS (SELECT 1 FROM TaiKhoan WHERE SDT = @SDT AND MatKhau = @MatKhau AND LoaiTK = 'NS')
        SET @AccountType = 4;
    ELSE
        SET @AccountType = 0;
	select @AccountType
END;
go
--exec sp_RegisterCustomerAccount '0379675992','SOL7', 'phan trung kien', '1/1/2003','afdasdfasdf'


create or alter PROCEDURE sp_RegisterCustomerAccount
    @SDT CHAR(10),
    @MatKhau VARCHAR(8),
    @HoTen NVARCHAR(30),
    @NgSinh DATE,
    @DiaChiKH NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MaKH CHAR(5);

    -- Check if the customer already has an account
    IF EXISTS (SELECT 1 FROM TaiKhoan WHERE SDT = @SDT)
    BEGIN
        SELECT 1 AS Result;
        RETURN; -- Exit the stored procedure if the account already exists
    END

    -- Begin a transaction
    BEGIN TRAN

    -- Generate a new unique customer ID
    SELECT @MaKH =
    RIGHT(
        '00000' + -- Add leading zeros
        CAST(
            ISNULL(
                MAX(CAST(SUBSTRING(MaKH, 3, 3) AS INT)), -- Extract the first 5 characters for numeric part
                0
            ) + 1 AS VARCHAR(5) -- Increment by 1 and convert to VARCHAR with max length of 5
        ),
        5 -- Take the rightmost 5 characters
    )
	FROM KhachHang;

    -- Insert into TaiKhoan table
    INSERT INTO TaiKhoan (SDT, MatKhau, LoaiTK)
    VALUES (@SDT, @MatKhau, 'KH');

    -- Check if the insert into TaiKhoan was successful


    -- Insert into KhachHang table with the generated MaKH
    INSERT INTO KhachHang (MaKH, HoTen, NgSinh, DiaChiKH, SDT)
    VALUES (@MaKH, @HoTen, @NgSinh, @DiaChiKH, @SDT);

    -- Check if the insert into KhachHang was successful


    -- Commit the transaction
    COMMIT TRAN;

    -- Select a message indicating successful registration
    SELECT 2 AS Result;
END
GO


create or alter PROCEDURE sp_ThongTinCaNhan
    @PhoneNumber CHAR(10)
AS
BEGIN
    SELECT
        'NhanVien' AS EntityType,
        TK.SDT AS PhoneNumber,
        NV.MaNV AS EntityID,
        NV.HoTen AS EntityName,
        NV.NgSinhNV AS EntityBirthdate,
        NV.DiaChi AS EntityAddress,
        TK.MatKhau
    FROM NhanVien NV
    INNER JOIN TaiKhoan TK ON TK.SDT = @PhoneNumber AND NV.SDTNV = TK.SDT

    UNION ALL

    SELECT
        'NhaSi' AS EntityType,
        TK.SDT AS PhoneNumber,
        NS.MaNS AS EntityID,
        NS.HoTen AS EntityName,
        NS.NgSinhNS AS EntityBirthdate,
        NS.DiaChi AS EntityAddress,
        TK.MatKhau
    FROM NhaSi NS
    INNER JOIN TaiKhoan TK ON TK.SDT = @PhoneNumber AND NS.SDTNS = TK.SDT

    UNION ALL

    SELECT
        'KhachHang' AS EntityType,
        TK.SDT AS PhoneNumber,
        KH.MaKH AS EntityID,
        KH.HoTen AS EntityName,
        KH.NgSinh AS EntityBirthdate,
        KH.DiaChiKH AS EntityAddress,
        TK.MatKhau
    FROM KhachHang KH
    INNER JOIN TaiKhoan TK ON TK.SDT = @PhoneNumber AND KH.SDT = TK.SDT
END
go
--exec sp_ThongTinCaNhan '0379665992'

create or alter proc sp_CapNhatThongTin
    @SDT CHAR(10),
    @MatKhau VARCHAR(8),
    @HoTen NVARCHAR(30),
    @NgSinh DATE,
    @DiaChiKH NVARCHAR(100)
as
begin
	update TaiKhoan set MatKhau =@MatKhau where SDT = @SDT
	if exists (select * from NhanVien where SDTNV = @SDT)
	begin
		update NhanVien set HoTen= @HoTen, DiaChi = @DiaChiKH where SDTNV = @SDT
		select 1
		return;
	end
	else if exists (select * from NhaSi where SDTNS = @SDT)
	begin
		update NhaSi set HoTen= @HoTen, DiaChi = @DiaChiKH where SDTNS = @SDT
		select 1
		return;
	end
	else
	begin
		update KhachHang set HoTen= @HoTen, DiaChiKH = @DiaChiKH where SDT = @SDT
		select 1
		return;
	end
	IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRAN;
		select 0
        RETURN; -- Exit the stored procedure if an error occurred
    END
end
go
--exec sp_CapNhatThongTin '0379665992','qpalzm10',N'Phan Trung Kiên','11/05/2003',N'Mỹ Lợi'


CREATE or alter PROCEDURE sp_LichSuKham
    @SDT CHAR(10)
AS
BEGIN
    -- Check if the customer exists
    IF NOT EXISTS (SELECT 1 FROM TaiKhoan WHERE SDT = @SDT)
    BEGIN
        select 'Không tồn tại khách hàng với số điện thoại này.';
        RETURN; -- Exit the stored procedure if the customer doesn't exist
    END

    -- Retrieve HoSoKham records for the specified SDT
    SELECT
        HK.MaHS,
        HK.NgayKham,
        NS.HoTen as 'Bác sĩ'
    FROM
        HoSoKham HK
    INNER JOIN
        KhachHang KH ON HK.BenhNhan = KH.MaKH
    INNER JOIN
        TaiKhoan TK ON KH.SDT = TK.SDT
	INNER JOIN
		NhaSi NS ON NS.MaNS = HK.NguoiKham
    WHERE
        TK.SDT = @SDT;
END
go
--exec sp_LichSuKham '6673673611'


CREATE or alter PROCEDURE sp_ChiTietHoSo
    @MaHS CHAR(5)
AS
BEGIN

    -- Check if the medical record exists
    IF NOT EXISTS (SELECT 1 FROM HoSoKham WHERE MaHS = @MaHS)
    BEGIN
        select 'Không tồn tại hồ sơ khám với mã này.';
        RETURN; -- Exit the stored procedure if the medical record doesn't exist
    END

    -- Retrieve the names of medicines and services for the specified medical record
    SELECT
        T.TenThuoc AS TenThuoc,
        DV.TenDV AS TenDichVu
    FROM HS_T HT, HS_DV,Thuoc T, DichVu DV
    WHERE
        HT.MaHS = @MaHS and HT.MaThuoc = T.MaThuoc and HT.MaHS = HS_DV.MaHS and HS_DV.MaDV = DV.MaDV
END
go
--exec sp_ChiTietHoSo 'HS35 '

CREATE PROCEDURE sp_DanhSachNhaSiTrong
    @Ngay DATE
AS
BEGIN
    -- Display doctors who don't have appointments on the specified date
    SELECT
        NS.MaNS,
        NS.HoTen AS TenNhaSi
    FROM
        NhaSi NS
    WHERE
        NS.MaNS NOT IN (
            SELECT
                LLV.MaNS
            FROM
                LichLamViec LLV
            WHERE
                LLV.LichBan = @Ngay
        );
END
go

CREATE or alter PROCEDURE sp_DatLichHen
    @MaNS CHAR(5),
    @ThoiGian DATETIME,
    @SDT CHAR(10)
AS
BEGIN
    -- Check if the doctor exists
    IF NOT EXISTS (SELECT 1 FROM NhaSi WHERE MaNS = @MaNS)
    BEGIN
        select 0;
        RETURN; -- Exit the stored procedure if the doctor doesn't exist
    END

    -- Check if the appointment already exists
    IF EXISTS (SELECT 1 FROM LichHen WHERE MaNS = @MaNS AND ThoiGian = @ThoiGian)
    BEGIN
        select 0;
        RETURN; -- Exit the stored procedure if the appointment already exists
    END

    -- Check if the doctor is available during the specified time
    IF EXISTS (SELECT 1 FROM LichLamViec WHERE MaNS = @MaNS AND LichBan = @ThoiGian)
    BEGIN
        select 0;
        RETURN; -- Exit the stored procedure if the doctor is not available
    END
	declare @MaKH char(5)
    -- Begin a transaction
    BEGIN TRAN
	IF NOT EXISTS (SELECT 1 FROM TaiKhoan WHERE SDT = @SDT)
    BEGIN
        -- Insert into TaiKhoan table with a default password ('123')
        INSERT INTO TaiKhoan (SDT, MatKhau, LoaiTK)
        VALUES (@SDT, '123', 'KH');

        -- Insert into KhachHang table
		SELECT @MaKH =
			RIGHT(
				'00000' + -- Add leading zeros
				CAST(
					ISNULL(
						MAX(CAST(SUBSTRING(MaKH, 3, 3) AS INT)), -- Extract the first 5 characters for numeric part
						0
					) + 1 AS VARCHAR(5) -- Increment by 1 and convert to VARCHAR with max length of 5
				),
				5 -- Take the rightmost 5 characters
			)
		FROM KhachHang;

        INSERT INTO KhachHang (MaKH, HoTen, NgSinh, DiaChiKH, SDT)
        VALUES (@MaKH, 'New Customer', GETDATE(), 'Default Address', @SDT);
    END

    -- Insert into LichHen table
    INSERT INTO LichHen (MaNS, ThoiGian, MaKH)
    VALUES (@MaNS, @ThoiGian, (SELECT TOP 1 KH.MaKH FROM TaiKhoan TK JOIN KhachHang KH ON TK.SDT = KH.SDT WHERE TK.SDT = @SDT));

    -- Check if the insert into LichHen was successful
    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRAN;
        select 0;
        RETURN; -- Exit the stored procedure if an error occurred
    END

    -- Insert into LichLamViec table
    INSERT INTO LichLamViec (MaNS, LichBan)
    VALUES (@MaNS, @ThoiGian);

    -- Check if the insert into LichLamViec was successful
    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRAN;
        select 0;
        RETURN; -- Exit the stored procedure if an error occurred
    END

    -- Commit the transaction
    COMMIT TRAN;

    select 1;
END
go

CREATE OR ALTER PROCEDURE sp_ThemNhanVienNhaSi
    @SDT CHAR(10),
    @MatKhau VARCHAR(8),
    @LoaiTK NVARCHAR(10),
    @HoTen NVARCHAR(30),
    @NgSinh DATE,
    @DiaChi NVARCHAR(100)
AS
BEGIN
    -- Check if the account already exists
    IF EXISTS (SELECT 1 FROM TaiKhoan WHERE SDT = @SDT)
    BEGIN
        SELECT 0 AS Result;
        RETURN; -- Exit the stored procedure if the account already exists
    END

    -- Begin a transaction
    BEGIN TRAN

    -- Insert into TaiKhoan table
    INSERT INTO TaiKhoan (SDT, MatKhau, LoaiTK)
    VALUES (@SDT, @MatKhau, @LoaiTK);

    -- Check if the insert into TaiKhoan was successful
    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRAN;
        SELECT 0 AS Result;
        RETURN; -- Exit the stored procedure if an error occurred
    END
	declare @MaKH char(5)
    -- Insert into NhanVien or NhaSi table based on LoaiTK
    IF @LoaiTK = 'NV'
    BEGIN
		SELECT @MaKH =
			RIGHT(
				'00000' + -- Add leading zeros
				CAST(
					ISNULL(
						MAX(CAST(SUBSTRING(MaNV, 3, 3) AS INT)), -- Extract the first 5 characters for numeric part
						0
					) + 1 AS VARCHAR(5) -- Increment by 1 and convert to VARCHAR with max length of 5
				),
				5 -- Take the rightmost 5 characters
			)
		FROM NhanVien;
        INSERT INTO NhanVien (MaNV, SDTNV, NgSinhNV, HoTen, DiaChi, LoaiNV)
        VALUES (@SDT, @SDT, @NgSinh, @HoTen, @DiaChi, 'Thường');
    END
    ELSE IF @LoaiTK = 'NS'
    BEGIN
		SELECT @MaKH =
			RIGHT(
				'00000' + -- Add leading zeros
				CAST(
					ISNULL(
						MAX(CAST(SUBSTRING(MaNS, 3, 3) AS INT)), -- Extract the first 5 characters for numeric part
						0
					) + 1 AS VARCHAR(5) -- Increment by 1 and convert to VARCHAR with max length of 5
				),
				5 -- Take the rightmost 5 characters
			)
		FROM NhaSi;
        INSERT INTO NhaSi (MaNS, SDTNS, NgSinhNS, HoTen, DiaChi, ChiPhiKham)
        VALUES (@MaKH, @SDT, @NgSinh, @HoTen, @DiaChi, 0.0); -- Assuming a default value for ChiPhiKham
    END

    -- Check if the insert into NhanVien or NhaSi was successful
    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRAN;
        SELECT 0 AS Result;
        RETURN; -- Exit the stored procedure if an error occurred
    END

    -- Commit the transaction
    COMMIT TRAN;

    SELECT 1 AS Result;
END
go
CREATE OR ALTER PROC SP_NS_THEM_LICHLAMVIEC
	@LichBan DATE,
	@MaNS CHAR(5)
AS
BEGIN TRAN

	INSERT INTO dbo.LichLamViec
	(
	    MaNS,
	    LichBan
	)
	VALUES
	(   @MaNS,  -- MaNS - char(5)
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
