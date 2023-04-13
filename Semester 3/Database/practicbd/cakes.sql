use cakes;

drop table if exists Cakes
drop table if exists Cake_types
drop table if exists Orders
drop table if exists Chefs

create table Chefs(
	chid int primary key identity(1,1),
	cname varchar(255),
	gender varchar(255),
	date_of_birth date
);

create table Cake_types(
	ctid int primary key identity(1,1),
	ctname varchar(255),
	description varchar(255),
);

create table Cakes(
	caid int primary key identity(1,1),
	caname varchar(255),
	shape varchar(30),
	weight int,
	price int,
	ctid int references Cake_types(ctid)
);

create table Specializations(
	chid int references Chefs(chid),
	caid int references Cakes(caid)
	primary key(chid, caid)
);

create table Orders(
	oid int primary key identity(1,1),
	odate date
);

create table ordersStorage(
	oid int references Orders(oid),
	caid int references Cakes(caid),
	number int
);

insert into Cake_types values ('t1','desc1'), ('t2','desc2'), ('t3','desc3')
insert into Cakes values ('cake1','round',10,100,1),('cake2','square',10,100,2),('cake3','oval',25,300,2)
insert into Chefs values ('alex','m','1999-08-18'),('rzv','f','1999-08-18'),('aaa','m','1999-08-18')
insert into Orders values ('2018-03-02'),('2019-12-22')
insert into Specializations values (1,1),(1,2),(2,2),(2,3),(1,3)
insert into OrdersStorage values (1,2,3),(1,3,5),(2,1,2)

---2---
--procedure: order id, cake name and a positive number P = number of ordered pieces,
--adds the cake to the order, if the cake is alreagy on the order the number of ordered
--pieces is set to P
go
create or alter procedure AddCakeToOrder(@orderid int, @cakename varchar(255), @P int)
as
begin
	declare @cakeid int
	set @cakeid = (select C.caid from Cakes C where C.caname = @cakename)
	declare @oid int
	set @oid = (select O.oid from Orders O where O.oid = @orderid)
	if @cakeid is null or @oid is null
	begin
		print 'cake/order does not exist'
		return
	end
	if exists (select * from ordersStorage Os where Os.caid = @cakeid and Os.oid = @oid)
	begin
		update ordersStorage
		set number = @P
		where ordersStorage.oid = @oid and ordersStorage.caid = @cakeid
	end
	else
	begin
		insert into ordersStorage values (@oid, @cakeid, @P)
	end
end

go
exec AddCakeToOrder 1,'cake2',10;
exec AddCakeToOrder 1,'cake3',10;
exec AddCakeToOrder 1,'sad',10;

select * from OrdersStorage

---3---
--function: list all the names of the chefs who are specialized in the preparation
--of all the cakes
go
create function listChefs()
returns table as
return
	select C.cname
	from Chefs C inner join (
				select S.chid
				from Specializations S
				group by S.chid
				having count(*) >= (select count(*) from Cakes)
				) as SpecializedChefs
	on C.chid = SpecializedChefs.chid

go
select * from listChefs()