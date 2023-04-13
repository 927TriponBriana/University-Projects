use Lab5;
drop table Tc
drop table Tb
drop table Ta

create table Ta(
	aid int primary key,  --we automatically create a clustered index on aid column
	a2 int unique,  --we automatically create a nonclustered index on a2 column
	a3 int
	)
delete from Ta

create table Tb(
	bid int primary key,  --we automatically create a clustered index on bid column
	b2 int
	)

create table Tc(
	cid int primary key,  --we automatically create a clustered index on cid column
	aid int foreign key references Ta(aid),
	bid int foreign key references Tb(bid)
	)

-- Procedure to generate and insert random data into Ta
go 
create or alter procedure insertIntoTa(@rows int) as
begin
	declare @max int
	set @max = @rows*2 + 100
	while @rows > 0
	begin
		insert into Ta values (@rows, @max, @max%210)
		set @rows = @rows - 1
		set @max = @max - 2
	end
end

-- Procedure to generate and insert random data into Tb
go
create or alter procedure insertIntoTb(@rows int) as
begin
	while @rows > 0
	begin
		insert into Tb values (@rows, @rows%542)
		set @rows = @rows - 1
	end
end

-- Procedure to generate and insert random data into Tc
go
create or alter procedure insertIntoTc(@rows int) as
begin
	declare @aid int
	declare @bid int
	while @rows > 0 
	begin
		set @aid = (select top 1 aid from Ta order by newid())
		set @bid = (select top 1 bid from Tb order by newid())
		insert into Tc values(@rows, @aid, @bid)
		set @rows = @rows - 1
	end
end

exec insertIntoTa 5000
exec insertIntoTb 7500
exec insertIntoTc 3000

select * from Ta
select * from Tb
select * from Tc

--a. Write queries on Ta such that their execution plans contain the following operators:
--clustered index scan - scan the entire table
 select * from Ta

--clustered index seek - return a specific subset of rows from a clustered index
select * from Ta
where aid < 150

--nonclustered index scan - scan the entire nonclustered index
select a2 from Ta
order by a2

--nonclustered index seek - return a specific subset of rows from a nonclustered index
select a2
from Ta
where a2 between 120 and 130

--key lookup - nonclustered index seek + key lookup - the data is found in a nonclustered index, but additional data is needed
select a3,a2
from Ta
where a2 = 544

--b. Write a query on table Tb with a WHERE clause of the form WHERE b2 = value and analyze its execution plan.
--Create a nonclustered index that can speed up the query. 
--Examine the execution plan again.
--clustered index seek
select *
from Tb
where b2 = 154

--nonclustered index seek
drop index Tb_b2_index on Tb
create nonclustered index Tb_b2_index on Tb(b2)

--c. Create a view that joins at least 2 tables. 
--Check whether existing indexes are helpful;
--if not, reassess existing indexes / examine the cardinality of the tables.
go
create or alter view View1 as
	select A.aid, B.bid, C.cid
	from Tc C
	inner join Ta A on A.aid = C.aid
	inner join Tb B on B.bid = C.bid
	where B.b2 > 500 and A.a3 < 150

go 
select *
from View1

drop index Ta_a3_index on Ta
create nonclustered index Ta_a3_index on Ta(a3)	   --we add a nonclustered index on a3 from Ta

drop index Tc_index on Tc
create nonclustered index Tc_index on Tc(aid, bid)   --we add a nonclustered index on (aid, bid) from Tc

--with existing indexes (and nonclustered index on b2): cost: 0.135053
--adding nonclustered index on a3: cost: 0.126625
--without nonclustered index on b2 but with nonclustered index on a3: cost: 0.148999
--with all: cost: 0.125884