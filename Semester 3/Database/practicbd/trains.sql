use pregatire_practic_sII;

create table TrainTypes(
	idTT int primary key identity(1,1),
	name varchar(255),
	description varchar(255)
);

create table Trains(
	idT int primary key identity(1,1),
	name varchar(255),
	idTT int references TrainTypes(idTT)
);

create table Stations(
	idS int primary key identity(1,1),
	name varchar(255) unique
);

create table Routes(
	idR int primary key identity(1,1),
	name varchar(255) unique,
	idTrain int references Trains(idT)
);

create table RoutesStations(
	idR int references Routes(idR),
	idS int references Stations(idS),
	primary key(idR, idS),
	arrivalTime time,
	departureTime time
);

insert into TrainTypes(name, description) VALUES ('type1', 'desc1'), ('type2', 'desc2')
insert into Trains(name, idTT) VALUES ('train1', 1), ('train2', 2), ('train3', 1)
insert into Routes(name, idTrain) VALUES ('r1', 1), ('r2', 2), ('r3', 3)
insert into Stations(name) values ('s1'), ('s2'), ('s3')
insert into RoutesStations(idR, idS, arrivalTime, departureTime) VALUES 
(1, 1, '9:00am', '9:10am'),
(1, 2, '9:15am', '9:30am'),
(1, 3, '10:00am', '10:10am'),
(2, 1, '9:00pm', '9:10pm'),
(2, 3, '5:00am', '5:20am'),
(3, 2, '7:00pm', '7:10pm')

select * from Trains
select * from TrainTypes
select * from Stations
select * from Routes
select * from RoutesStations



------2------
--implement a stored procedure that receives a route, a station, arrival and departure times, and adds the station to the route.
--if the station is already on the route, the departure and arrival times are updated.

go 
create procedure updateAddStationOnRoute(@RouteName varchar(255), @StationName varchar(255), @arrival time, @departure time)
as
begin
	declare @idStation int = (select idS from Stations where name = @StationName)
	declare @idRoute int = (select idR from Routes where name = @RouteName)
	if @idStation is not null and @idRoute is not null
		if not exists (select * from RoutesStations where idR = @idRoute and idS = @idStation)
			insert into RoutesStations(idR, idS, arrivalTime, departureTime)
			values
				(@idRoute, @idStation, @arrival, @departure)
		else
			update RoutesStations
			set arrivalTime = @arrival, departureTime = @departure
			where idR = @idRoute and idS = @idStation
	else
		raiserror('Not found Station or Route', 10, 1)
end

select * from RoutesStations

exec updateAddStationOnRoute @RouteName = 'r1', @StationName = 's1', @arrival = '4:00pm', @departure = '5:00pm'
exec UpdateAddStationOnRoute @RouteName = 'r2', @StationName = 's2', @arrival = '4:00pm', @departure = '5:00pm'
exec UpdateAddStationOnRoute @RouteName = 'r0', @StationName = 's2', @arrival = '4:00pm', @departure = '5:00pm'

-----3-----
--create a view that shows the names of the routes that pass through all the stations

go
create view viewRoutesWithAllStations
as
	select R.name
	from Routes R
	where R.idR in (
		select idR
		from RoutesStations 
		group by idR
		having count(*) = (select count(*) from Stations)
	)
go
select R.name
from Routes R
where not exists (
	select S.idS
	from Stations S
	except
	select RS.idS
	from RoutesStations RS
	where RS.idR = R.idR
	)

select * from viewRoutesWithAllStations

-----4----
--implement a function that lists the names of the stations with more than R routes
--where R is a function parameter

go
create function ListStationsNameWithRoutes(@R int)
returns table as
return
	select S.name
	from Stations S
	where S.idS in (
		select RS.idS
		from RoutesStations RS
		group by RS.idS
		having count(*) > @R
		)
go
select * from ListStationsNameWithRoutes(2)
select * from Stations
select * from Routes
select * from RoutesStations




