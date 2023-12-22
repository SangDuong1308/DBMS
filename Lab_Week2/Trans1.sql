use master
create table dbo.Item (id INT, NAME varchar(50))


INSERT INTO dbo.Item SELECT 1,'a'
INSERT INTO dbo.Item SELECT 2,'b'
INSERT INTO dbo.Item SELECT 3,'c'

SELECT * FROM dbo.Item

SET TRANSACTION ISOLATION LEVEL serializable
BEGIN TRAN
SELECT * FROM dbo.Item
WAITFOR DELAY '00:00:10' --wait for 10 seconds
SELECT * FROM dbo.Item
COMMIT

--begin tran
--update dbo.Item
--	set name = 'x'
--	where id>2
--waitfor delay '00:00:10'
----rollback
--commit
--SELECT * FROM dbo.Item

