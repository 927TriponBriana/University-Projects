use preg_practic2_sII;

create table Users(
	idU int primary key identity(1,1),
	name varchar(255),
	pen_name varchar(255) unique,
	year_of_birth int not null
);

create table Awards(
	idA int primary key identity(1,1),
	name varchar(255),
	idU int references Users(idU)
);

create table Competitions(
	idC int primary key identity(1,1),
	year int not null,
	week int not null,
	unique (year, week) --a competition is defined by a year and a week
);

create table Poem(
	idP int primary key identity(1,1),
	title varchar(255),
	text varchar(255),
	idU int references Users(idU),
	idC int references Competitions(idC)
);

create table Judges(
	idJ int primary key identity(1,1),
	name varchar(255)
);

create table Evaluation(
	idP int references Poem(idP),
	idJ int references Judges(idJ),
	primary key(idP, idJ), --a judge cannot evaluate the same poem twice
	score int,
	constraint score_between_1_and_10 check (1<= score and score <= 10)
);



---b---
--stored procedure that receives a string value as parameter = the name of a judge
--the procedure must delete all judges with the specified name and their evaluations from the database

go
create procedure delete_judge(@judge_name varchar(255))
as
begin
	declare judge_cursor cursor for --used a cursor to execute for each judge at a time
		select idJ
		from Judges
		where name = @judge_name
	open judge_cursor 
	declare @idJ int
	fetch judge_cursor into @idJ
	while @@FETCH_STATUS = 0
	begin
		delete from Evaluation where idJ = @idJ
		delete from Judges where idJ = @idJ
		fetch judge_curosr into @idJ
	end
	close judge_cursor
	deallocate jugde_cursor
end

go
execute delete_judge 'Ron'

---c---
--create a view that shows the competitions (year and week number) with at least 10 submitted poems 
--that satisfy condition C. a poem P satisfies condition C if P received less than 5 points on each evaluation.

go
create view view_competitions 
as
begin
	select
	from (select C.
		  from )

end

---d---
--implement a function thath lists the users (name and pen name) with at least P submitted poems,
--where P is the function's parameter

go 
create function list_users(@P int)
returns table as
return
	select U2.name, U2.pen_name
	from (
		select U.idU as tidU
		from Users U inner join Poem P on U.idU = P.idU
		group by U.idU
		having count(*) >= @P
		) T join Users U2 on T.tidU = U2.idU

go
select * from list_users(3)
select * from list_users(4)

go
insert into Users(name, pen_name, year_of_birth)
values 
	('Maria', 'Mariuca', 2001),
	('Ana', 'Anuta', 2002),
	('Ion', 'Ionica', 2003)

insert into Competitions(year, week)
values
	(2014, 21),
	(2015, 22),
	(2020, 1)

insert into Poem(title, text, idU, idC)
values
	('a', 'b', 1, 1),
	('c', 'd', 1, 1),
	('e', 'f', 1, 1),
	('g', 'h', 2, 1),
	('i', 'j', 2, 1),
	('k', 'l', 2, 1),
	('m', 'n', 3, 1),
	('o', 'p', 3, 1),
	('q', 'r', 3, 1),
	('s', 't', 1, 1),
	('u', 'v', 1, 1),
	('w', 'x', 1, 2)

insert into Judges(name)
values
	('Ron'),
	('Tim'), 
	('Ron')

insert into Evaluation(idP, idJ, score)
values
	(1, 1, 4),
	(1, 2, 3),
	(2,3,6),
	(2,2,2),
	(3,1,4),
	(3,3,3),
	(3,2,2),
	(4,1,1),
	(5,2,4),
	(6,3,2),
	(7,3,1),
	(8,2,3),
	(9,1,3),
	(10, 2, 3),
	(11,3,1)

select * from Users
select * from Poem
select * from Competitions
select * from Judges
select * from Evaluation