use bank;

drop table if exists Customers
drop table if exists BankAcc
drop table if exists Cards
drop table if exists ATMs
drop table if exists Transactions


create table Customers(
	cuid int primary key identity(1,1),
	name varchar(255),
	date_of_birth date,
);

create table BankAcc(
	bid int primary key identity(1,1),
	iban varchar(255),
	curr_balance int, 
	cuid int references Customers(cuid)
);

create table Cards(
	caid int primary key identity(1,1),
	cnumber varchar(255),
	cvv int,
	bid int references BankAcc(bid)
);

create table ATMs(
	aid int primary key identity(1,1),
	address varchar(255)
);

create table Transactions(
	aid int references ATMs(aid),
	caid int references Cards(caid),
	tsum int,
	ttime datetime
);

insert into Customers(name, date_of_birth)
values
		('Teo', '1999-02-02'),
		('Mara', '2000-01-01')

insert into BankAcc(iban, curr_balance, cuid)
values
		('12345', 100, 2),
		('67890', 200, 1)

insert into Cards(cnumber, cvv, bid)
values
		('12345', 234, 1),
		('67890', 567, 2)

insert into ATMs(address)
values
		('Cluj'),
		('Satu Mare')

insert into Transactions(aid, caid, tsum, ttime)
values
		(1, 1, 100, '2022-02-02'),
		(2, 1, 200, '2022-02-02'),
		(1, 2, 400, '2022-02-02')


---2---
--stored procedure that receives a card and deletes all the transactions
--related to that card
go
create or alter procedure deleteTransactions(@caid int)
as
begin
	if @caid is NULL
	begin
		raiserror('No such card', 16, 1)
		return -1
	end
	delete from Transactions
	where caid = @caid
end

select * from Transactions
exec deleteTransactions 1

---3---
--view that shows the card numbers which were used in transactions at all the ATMs
go
create or alter view viewCardsFromAllATMs1
as
	select C.cnumber
	from Cards C 
	where not exists
			(select A.aid
			 from ATMs A
			 except
			 select T.aid
			 from Transactions T
			 where T.caid = C.caid)

go
insert into Transactions(aid, caid, tsum, ttime)
values
		(2, 2, 200, '2022-02-02')
select * from Cards
select * from ATMs
select * from Transactions
select * from viewCardsFromAllATMs1


go
create or alter view viewCardsFromAllATMs2
as
	select C.cnumber
	from Cards C
	where C.caid in
				(select T.caid
				from Transactions T inner join ATMs A on T.aid = A.aid)

go
select * from Cards
select * from ATMs
select * from Transactions
select * from viewCardsFromAllATMs2

---4---
--function that lists the cards that have the total transaction sum > 2000lei.
go
create or alter function CardsWithTransactions()
returns table as
return
	select C.cnumber, C.cvv
	from Cards C
	inner join Transactions T on T.caid = C.caid
	group by C.cnumber, C.cvv
	having sum(T.tsum) > 2000

go
insert into Transactions
values
		(2, 2, 1900, '2019-01-01')
insert into Transactions
values
		(1, 2, 1900, '2019-01-01')

select * from Transactions
select * from CardsWithTransactions()

