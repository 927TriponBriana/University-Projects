use preg_practic3_sII;

create table Companies(
	comid int primary key identity(1,1),
	name varchar(255),
	description varchar(255),
	website varchar(255)
);

create table Games(
	gid int primary key identity(1,1),
	name varchar(255),
	release_date date,
	comid int references Companies(comid)
);

create table Heroes(
	hid int primary key identity(1,1),
	name varchar(255),
	description varchar(255),
	importance varchar(255)
);

create table Cinematics(
	cinid int primary key identity(1,1),
	name varchar(255),
	gid int references Games(gid),
);

create table HeroesList(
	hid int references Heroes(hid),
	cinid int references Cinematics(cinid),
	primary key (hid, cinid),
	entry_moment time
);


--2--
--create a stored procedure that receives a hero, a cinematic and an entry moment
--and adds the new cinematic to the hero. If the cinematic already exists, the entry 
--moment is updated.
go
create or alter procedure insertCinematic(@heroName varchar(255), @heroDescr varchar(255), @heroImp varchar(255), @cinematicName varchar(255), @cinematicGameid int, @entryMoment time)
as
begin
	declare @existGameid int = (select Games.gid from Games where Games.gid = @cinematicGameid)
	if @existGameid is null
	begin
		print 'Game id does not exist'
		return 1
	end

	declare @existCinematic int = (select C.cinid from Cinematics C where C.gid = @cinematicGameid and C.name = @cinematicName)
	declare @existHero int
	declare @getCinematicid int
	declare @getHeroid int

	if @existCinematic is null
	begin
		insert into Cinematics values(@cinematicName, @cinematicGameid)
		set @existHero = (select H.hid from Heroes H where H.name = @heroName and H.importance = @heroImp and H.description = @heroDescr)
		if @existHero is null
		begin
			print 'Hero inserted'
			insert into Heroes values (@heroName, @heroDescr, @heroImp)
		end
		else
			print 'Hero exists'
		
		set @getHeroid = (select H.hid from Heroes H where H.name = @heroName and H.importance = @heroImp and H.description = @heroDescr)
		set @getCinematicid = (select C.cinid from Cinematics C where C.gid = @cinematicGameid and C.name = @cinematicName)
		insert HeroesList values (@getHeroid, @getCinematicid, @entryMoment)
	end

	if @existCinematic is not null
	begin
		set @existHero = (select H.hid from Heroes H where H.name = @heroName and H.importance = @heroImp and H.description = @heroDescr)
		if @existHero is null
		begin
			print 'Hero inserted'
			insert into Heroes values (@heroName, @heroDescr, @heroImp)
		end
		else
			print 'Hero exists'

		set @getHeroid = (select H.hid from Heroes H where H.name = @heroName and H.importance = @heroImp and H.description = @heroDescr)
		set @getCinematicid = (select C.cinid from Cinematics C where C.gid = @cinematicGameid and C.name = @cinematicName)
		update HeroesList
		set entry_moment = @entryMoment
		where HeroesList.cinid = @getCinematicid and HeroesList.hid = @getHeroid
	end
end


--3--
--create a view that shows the name and the importance of all heroes that 
--appear in all cinematics.
go
create view viewHeroesFromAllCinematics
as
	select H.name, H.importance
	from Heroes H inner join HeroesList HL on H.hid = HL.hid
	group by H.name, H.importance
	having ((select count(HL.hid) as nr) = (select count(*) as Expr1 from Cinematics))


--4--
--create a function that lists the name of the company, the name of the game and the title
--of the cinematic for all games that have the release date greater than or equal to
--'2000-12-02' and less thar or equal to '2016-01-01'.
go
create function GamesDate() 
returns table as 
return
	select G.name as GameName, C.name as CompanyName, C2.name as CinematicName
	from Games G inner join Companies C on G.comid = C.comid
				 inner join Cinematics C2 on G.gid = C2.gid
	where G.release_date >= '2000-12-02' and G.release_date <= '2016-01-01'


go
insert into Companies(name, description, website)
values ('a', 'abc', 'www.google.com')

insert into Games(name, release_date, comid)
values 
	('dc game1', '2000-12-01', 1),
	('dc game2', '2005-12-01', 1),
	('dc game1', '2016-01-01', 1),
	('dc game1', '2016-12-01', 1)

insert into Heroes(name, description, importance)
values
	('Superman', 'a', 'main'),
	('Superman2', 'a', 'main')

insert into Cinematics(name, gid)
values
	('c1', 1),
	('c2', 2),
	('c3', 1)

insert into HeroesList(hid, cinid, entry_moment)
values
	(1, 1, '02:09'),
	(1, 2, '00:09'),
	(1, 3, '00:09'),
	(2, 1, '00:09')
		
go
exec insertCinematic 'Super Woman', 'a', 'main', 'c4', 2, '09:01'
exec insertCinematic 'Super Woman', 'a', 'main', 'c4', 2, '09:06'
select * from Heroes
select * from HeroesList
select * from Cinematics

go
select * from viewHeroesFromAllCinematics


select * from Heroes
select * from HeroesList

go
select * from Companies
select * from Cinematics
select * from Games
select * from GamesDate()