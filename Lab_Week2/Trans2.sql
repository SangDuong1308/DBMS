use master

--set transaction isolation level read committed
----select * from dbo.Item
--insert into dbo.Item Select 5,'e'

--UPDATE dbo.Item
--SET name = 'x'
--WHERE id>2
--SELECT * FROM item

insert into dbo.Item select 4,'d'
select * from dbo.Item