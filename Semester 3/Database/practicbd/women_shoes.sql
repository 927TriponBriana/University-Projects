use shoes;

drop table if exists Shoes
drop table if exists Shoes_models
drop table if exists Presentation
drop table if exists Women

create table Presentation(
	pid int primary key identity(1,1),
	pname varchar(255),
	city varchar(255)
);

create table Women(
	wid int primary key identity(1,1),
	wname varchar(255),
	amount int
);

create table Shoes_models(
	mid int primary key identity(1,1),
	mname varchar(255),
	season varchar(255),
);

create table Shoes(
	sid int primary key identity(1,1),
	price int,
	mid int references Shoes_models(mid)
);

create table Stock(
	stid int primary key identity(1,1),
	sid int references Shoes(sid),
	pid int references Presentation(pid),
	available int
);

create table Transactions(
	tid int primary key identity(1,1),
	wid int references Women(wid),
	sid int references Shoes(sid),
	bought_shoes int,
	spent int
);

insert into Shoes_models(mname, season) values ('low top', 'summer'), ('high top', 'winter')
insert into Presentation(pname, city) values ('soho', 'nyc'), ('nike', 'la')
insert into Women(wname, amount) values ('alice', 123), ('mary', 444)
insert into Shoes(price, mid) values (50, 1), (99, 2)
insert into Transactions(wid, sid, bought_shoes, spent) values (1,1,1,1), (1,2,30,200), (2,2,22,150)
insert into Stock(sid, pid, available) values (2, 2, 10), (2, 1, 99)
---2---
--procedure that receives a shoe, a presentation shop and the number of shoes
--and adds the shoe to the presentation shop
go
create or alter procedure addShoeToPresentation(@shoeid int, @presentationid int, @nrShoes int)
as
begin
	insert into Stock values (@shoeid, @presentationid, @nrShoes)
end

select * from Stock
exec addShoeToPresentation 1, 1, 10

---3---
--view that shows the women that bought at least 2 shoes from a given shoe model
go 
create or alter view viewWomenWith2ShoesSameModel
as
	select W.wname
	from Women W
	where W.wid in 
			(select T.wid
			 from Transactions T inner join Shoes S on T.sid = S.sid
			 where S.mid = 2
			 group by T.wid
			 having sum(T.bought_shoes)>=2)

go
select * from viewWomenWith2ShoesSameModel

---4---
--function that lists the shoes that can be found in at least T presentation shops,
--T>=1 
go
create or alter function listsShoes(@T int)
returns table as
return
	select S.sid, S.price
	from Shoes S
	where S.sid in (
			select St.sid
			from Stock St
			group by St.sid
			having count(*)>=@T)

go
select * from listsShoes(2)
	
