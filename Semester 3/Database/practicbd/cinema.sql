use cinema;


create table Companies(
	cid int primary key identity(1,1),
	cname varchar(255)
);

create table Directors(
	did int primary key identity(1,1),
	dname varchar(255),
	nr_awards int
);

create table Actors(
	aid int primary key identity(1,1),
	aname varchar(255),
	ranking int
);

create table Movies(
	mid int primary key identity(1,1),
	mname varchar(255),
	release_date date, 
	cid int references Companies(cid),
	did int references Directors(did)
);

create table Productions(
	pid int primary key identity(1,1),
	title varchar(255),
	mid int references Movies(mid)
);

create table ActorList(
	alid int primary key identity(1,1),
	aid int references Actors(aid),
	pid int references Productions(pid),
	entrymom int
);

insert into Directors values ('a', 13), ('b', 2)
insert into Companies values ('cc'), ('dd')
insert into Actors values ('ana', 1), ('maria', 2), ('marian', 1231)
insert into Movies values ('frozen', '2019-01-02', 2, 1), ('avatar', '2017-02-02', 1, 2)
insert into Productions values ('abc', 1), ('efg', 2)
insert into ActorList values (1, 1, 1), (2, 1, 10), (3, 2, 123)

select * from Directors
select * from Companies
select * from Actors
select * from Movies
select * from Productions
select * from ActorList

---2---
--procedure receives an actor, an entry moment and a cinema production and adds the new actor
--to the cinema production
go
create or alter procedure addActorToProduction(@actorid int, @productionid int, @entrymom int)
as
begin
	insert into ActorList values (@actorid, @productionid, @entrymom)
end

exec addActorToProduction 2, 3, 65

---3---
--view that shows the name of the actors that appear in all cinematic productions
go
create or alter view viewActorsFromProductions
as	
	select A.aname
	from Actors A 
	where A.aid in 
		(select Al.aid
		from ActorList Al inner join Actors A1 on Al.aid = A1.aid
		group by Al.aid)

go
select * from viewActorsFromProductions

---4---
--function that returns all movies that have the relase date after '2018-01-01' and
--have al least p productions 
go
create function listMovies(@P int)
returns table as
return
	select M.mname
	from Movies M
	where M.mid in (
				select P.mid
				from Productions P inner join Movies M1 on P.mid = M1.mid
				where M1.release_date > '2018-01-01'
				group by P.mid
				having count(*) >= @P
				)

go
select * from listMovies(1)
