use practic;

drop table if exists Airplanes
drop table if exists Flights
drop table if exists Passengers
drop table if exists Reservations
drop table if exists Payments


create table Flights(
	fid int primary key identity(1,1),
	flight_nr int unique,
	dep_airport varchar(255),
	dest_airport varchar(255),
	dep_date datetime,
	arr_date datetime
);

create table Airplanes(
	aid int primary key identity(1,1),
	model_nr int,
	reg_number int unique,
	capacity int,
	fid int references Flights(fid)
);

create table Passengers(
	pid int primary key identity(1,1),
	first_name varchar(30),
	last_name varchar(30),
	email varchar(50) unique
);


create table Reservations(
	rid int primary key identity(1,1),
	pid int references Passengers(pid),
	fid int references Flights(fid),
);

create table Payments(
	paid int primary key identity(1,1),
	amount int, 
	pdate datetime,
	type varchar(30),
	rid int references Reservations(rid)
);

---3---
go
create or alter procedure addPayment(@paid, @amount, @pdate, @type, @) 


go
create view viewPassengers
as
	select P.first_name, P.last_name
	from Passengers P 
	where P.pid in (
					select R.pid
					from Reservations R inner join Flights F on R.fid = F.fid
					where F.dep_airport like 'Madrid')
go
select * from viewPassengers

go
insert into Passengers values ('Tre', 'Bia', 'asded@'), ('ERft', 'Teo', 'srefa')
insert into Flights values (2, 'Madrid', 'romania', '2018-01-19 03:14:07', '2018-01-19 03:14:07'), (1, 'China', 'Roma', '2018-01-19 03:14:07', '2018-01-19 03:14:07')
insert into Reservations values (1, 1), (2, 1), (2, 2)

select * from Passengers
select * from Flights
select * from Reservations
select * from Payments
---4---
go
create function listFlights(@start datetime, @end datetime, @X int)
returns table as
return
	select *
	from Flights F
	where F.fid in (
			select R.fid
			from Reservations R inner join Payments P on R.rid = P.rid
			where P.pdate > @start and P.pdate < @end
			group by R.fid
			having count(*) > @X)

go
select * from listFlights('2022-01-01 03:14:07', '2023-02-01 03:14:07', 1)

insert into Payments values (100, '2022-02-01 03:14:07', 'card', 1), (300, '2022-01-09 03:14:07', 'card', 3),(100, '2023-02-01 03:14:07', 'card', 2)

---1---
go
create procedure addpayment(@)