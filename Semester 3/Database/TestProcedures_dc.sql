use dental_clinic;

--Procedures for adding specific tests, tables, views and for creating the connections between them--
go
create or alter procedure addToTables(@tableName varchar(50)) as
begin
	if @tableName in(select [Name] from [Tables])
	begin
		print 'Table is already present in Tables'
		return
	end

	if @tableName not in(select TABLE_NAME from INFORMATION_SCHEMA.TABLES)
	begin
		print 'Table is not in the database'
		return
	end

	insert into [Tables]([Name])
	values
		(@tableName)
end

go 
create or alter procedure addToViews(@viewName varchar(50)) as
begin
	if @viewName in(select [Name] from [Views])
	begin
		print 'View is already in Views'
		return
	end

	if @viewName not in(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS)
	begin
		print 'View is not in the database'
		return
	end

	insert into [Views]([Name])
	values
		(@viewName)
end

go
create or alter procedure addToTests(@testName varchar(50)) as
begin
	if @testName in(select [Name] from [Tests])
	begin
		print 'Test already in Tests'
		return
	end

	insert into [Tests]([Name])
	values
		(@testName)
end

go 
create or alter procedure connectTableToTest(@tableName varchar(50), @testName varchar(50), @rows int, @pos int) as
begin
	if @tableName not in (select [Name] from [Tables])
	begin
		print 'The table is not in the Tables'
		return
	end

	if @testName not in (select [Name] from [Tests])
	begin
		print 'The test is not in the Tests'
		return
	end

	if exists(
		select *
		from TestTables T1 join Tests T2 on T1.TestID=T2.TestID
		where t2.[Name]=@testName and Position=@pos
	)
		begin
			print 'Position provided conflicts with previous positions'
			return
		end
	insert into [TestTables](TestID, TableID, NoOfRows, Position)
	values(
			(select [Tests].TestID from [Tests] where [Name]=@testName),
			(select [Tables].TableID from [Tables] where [Name]=@tableName),
			@rows,
			@pos
			)
end

go
create or alter procedure connectViewToTest(@viewName varchar(50), @testName varchar(50)) as
begin
	if @viewName not in (select [Name] from [Views])
	begin
		print 'View is not in the Views'
		return
	end

	if @testName not in (select [Name] from [Tests])
	begin
		print 'Test is not in the Tests'
		return
	end

	insert into [TestViews](TestID, ViewID)
	values(
		(select [Tests].TestID from [Tests] where [Name] = @testName),
		(select [Views].ViewID from [Views] where [Name] = @viewName)
		)
end

--run a test--
go
create or alter procedure runTest(@testName varchar(50)) as
begin
	if @testName not in(select [Name] from [Tests])
	begin
		print 'Test not in Tests'
		return
	end
	declare @command varchar(100)
	declare @testStartTime datetime2
	declare @startTime datetime2
	declare @endTime datetime2
	declare @table varchar(50)
	declare @rows int
	declare @pos int
	declare @view varchar(50)
	declare @testId int

	select @testId=TestID --luam id testului pe care dorim sa il executam
	from Tests
	where Name=@testName

	declare @testRunId int
	set @testRunId = (select max(TestRunID)+1 from TestRuns)  --setam un nou id pentru testRun ul curent
	if @testRunId is null
		set @testRunId = 0  --daca nu exista inca niciunul il setam la 0
	declare tableCursor cursor scroll for
		select T1.Name, T2.NoOfRows, T2.Position		--declaram un cursor pentru tables
		from [Tables] T1 join TestTables T2 on T1.TableID = T2.TableID
		where T2.TestID = @testId			--selectam numele testului, nr de rows date, positia data pentru testul dat si ordonam dupa pozitii
		order by T2.Position
	declare viewCursor cursor for			--declaram un cursor pentru views
		select V.Name						--selectam numele viewului pentru testul dat
		from [Views] V join TestViews TV on V.ViewID = TV.ViewID
		where TV.TestID = @testId

	set @testStartTime = SYSDATETIME()
	open tableCursor
	fetch last from tableCursor into @table, @rows, @pos		--returnam ultimul rand din cursor si il facem randul curent
	while @@FETCH_STATUS = 0 begin
		exec ('delete from ' + @table)
		fetch prior from tableCursor into @table, @rows, @pos	--returnam randul rezultant situat imediat inainte de randul curent
	end
	close tableCursor

	open tableCursor
	set identity_insert TestRuns on
	insert into TestRuns (TestRunID, Description, StartAt)
	values (@testRunId, 'Tests results for: ' + @testName, @testStartTime)		--inseram datele rezultate in TestRun
	set identity_insert TestRuns off

	fetch tableCursor into @table, @rows, @pos
	while @@FETCH_STATUS = 0 begin
		set @command = 'populateTable' + @table			--apelam procedura de populare a tabelelor
		if @command not in (select ROUTINE_NAME from INFORMATION_SCHEMA.ROUTINES) begin
			print @command + ' does not exist'
			return
		end
		set @startTime = SYSDATETIME()

		exec @command @rows
		set @endTime = SYSDATETIME()
		insert into TestRunTables (TestRunId, TableId, StartAt, EndAt)
		values(@testRunId, (select TableID from [Tables] where Name=@table), @startTime, @endTime)
		fetch tableCursor into @table, @rows, @pos			--punem valorile in variabile
	end
	close tableCursor
	deallocate tableCursor

	open viewCursor
	fetch viewCursor into @view
	while @@FETCH_STATUS = 0 begin
		set @command = 'select * from ' + @view
		set @startTime = SYSDATETIME()
		exec (@command)
		set @endTime = SYSDATETIME()
		insert into TestRunViews (TestRunID, ViewID, StartAt, EndAt)
		values(@testRunId, (select ViewID from Views where Name=@view), @startTime, @endTime)
		fetch viewCursor into @view
	end
	close viewCursor
	deallocate viewCursor

	update TestRuns
	set EndAt = SYSDATETIME()
	where TestRunID = @testRunId
end


select * from Assistant;
select * from Consultation;
select * from Review;

select * from Devices;
select * from DiagnisticDentist;
select * from Diagnostic;
select * from Dentist;
select * from Medication;
select * from MedicationDentist;
select * from Specialization;

select * from Pacient;
select * from Prescription;



----Views----
---a view with a SELECT statement operating on one table
--go 
--create or alter view dentistsWithSalaryBiggerThan10000 as
	--select D.dentist_first_name, D.dentist_last_name, D.dentist_salary
	--from Dentist D
	--where D.dentist_salary > 10000
go
create or alter view medicationWithPriceGreaterThan25 as
	select M.med_id, M.active_substance
	from Medication M
	where M.med_price > 25

---a view with a SELECT statement that operates on at least 2 different tables and contains at least one JOIN operator
go
create or alter view consultationAndPacient as
	select P.pacient_first_name, C.consultation_type
	from Consultation C inner join Pacient P on P.pacient_id = C.pacient_id 

---a view with a SELECT statement that has a GROUP BY clause, operates on at least 2 different tables and contains at least one JOIN operator
--go 
--create or alter view groupConsultationByReview as
	--select C.consultation_id, C.consultation_type, count(*) as reviewd
	--from Consultation C inner join Review R on C.consultation_id = R.consultation_id
	--group by C.consultation_id, C.consultation_type

go 
create or alter view groupMedicationByGiven as
	select M.med_id, M.active_substance, count(*) as given
	from Medication M
	inner join MedicationDentist MD on M.med_id = MD.id_medication
	group by M.med_id, M.active_substance

----Tests---
--a table with a single-column primary key and no foreign keys
---Test 1---
go
exec addToTables 'Medication'
exec addToViews 'medicationWithPriceGreaterThan25'
exec addToTests 'test1'
exec connectTableToTest 'Medication', 'test1', 1000, 1
exec connectViewToTest 'medicationWithPriceGreaterThan25', 'test1'

go 
create or alter procedure populateTableMedication(@rows int) as
	while @rows>0
	begin
		insert into Medication(med_id, active_substance, med_price)
		values (@rows, 'Active_substance', floor(rand()*100))
		set @rows = @rows-1
	end
exec runTest 'test1'
select * from [TestRuns]

---Test 2---
---a table with a single-column primary key and at least one foreign key
exec addToTables 'Pacient'
exec addToTables 'Consultation'
exec addToViews 'consultationAndPacient'
exec addToTests 'test2'
exec connectTableToTest 'Consultation', 'test2', 500, 2
exec connectTableToTest 'Pacient', 'test2', 100, 1
exec connectViewToTest 'consultatinAndPacient', 'test2'

go 
create or alter procedure populateTableConsultation (@rows int) as
	while @rows > 0 
	begin
		insert into Consultation(consultation_id, consultation_type, consultation_price, consultation_date, consultation_duration, pacient_id)
		values
			(@rows, 'Type', floor(150*rand()), '2022-11-25 00:00:00.000', floor(100*rand()),
			(select top 1 pacient_id from Pacient order by newid()))
		set @rows = @rows - 1
	end
select * from Consultation
select * from Pacient

go 
create or alter procedure populateTablePacient(@rows int) as
	while @rows > 0
	begin
		insert into Pacient(pacient_id, pacient_first_name, pacient_last_name, dentist_id, consultation_needed)
		values
			(@rows, 'First_name', 'Last_name',
			(select top 1 dentist_id from Dentist order by newid()),
			'Needed_consultation')
		set @rows = @rows - 1
	end
execute runTest 'test2'

select * from [TestRuns]
select * from [TestRunViews]

---Test 3---
---a table with a multicolumn primary key
exec addToTables 'Medication'
exec addToTables 'Dentist'
exec addToTables 'MedicationDentist'
exec addToViews 'groupMedicationByGiven'
exec addToTests 'test3'
exec connectTableToTest 'Medication', 'test3', 100, 1
exec connectTableToTest 'Dentist', 'test3', 100, 2
exec connectTableToTest 'MedicationDentist', 'teste3', 100, 3
exec connectViewToTest 'groupMedicationByGiven', 'test3'

go
create or alter procedure populateTableDentist(@rows int) as
	while @rows > 0
	begin
		insert into Dentist(dentist_id, dentist_first_name, dentist_last_name, dentist_address, spec_id, device_id, dentist_salary, hire_date)
		values(@rows, 'First_name', 'Last_name', 'Address', 
				(select top 1 spec_id from Specialization order by newid()),
				(select top 1 device_id from Devices order by newid()),
				floor(rand()*1000), '2019-03-12 00:00:00.000'
				)
		set @rows = @rows - 1
	end

go 
create or alter procedure populateTableMedication(@rows int) as
	while @rows > 0
	begin
		insert into Medication(med_id, active_substance, med_price)
		values(@rows, 'Active_substance', floor(rand()*100))
		set @rows = @rows - 1
	end

go
create or alter procedure populateTableSpecialization(@rows int) as
	while @rows > 0
	begin
		insert into Specialization(spec_id, spec_type, used_devices)
		values(@rows, 'Type', 'Devices')
		set @rows = @rows - 1
	end

go
create or alter procedure populateTableDevices(@rows int) as
	while @rows > 0
	begin
		insert into Devices(device_id, device_type)
		values(@rows, 'Type')
		set @rows = @rows - 1
	end
go
create or alter procedure populateTableMedicationDentist(@rows int) as
	declare @mID int
	declare @dID int
	while @rows > 0
	begin
		set @mID = (select top 1 med_id from Medication order by newid())
		set @dID = (select top 1 dentist_id from Dentist order by newid())
		while exists(select * from MedicationDentist where id_medication = @mID and id_dentist = @dID)
			begin
				set @mID = (select top 1 med_id from Medication order by newid())
				set @dID = (select top 1 dentist_id from Dentist order by newid())
			end
		insert into MedicationDentist(id_medication, id_dentist)
		values(@mID, @dID)
		set @rows = @rows - 1
	end

exec runTest 'test3'




select * from [Views]
select * from [Tables]
select * from [Tests]
select * from [TestTables]
select * from [TestViews]
select * from [TestRuns]
select * from [TestRunTables]
select * from [TestRunViews]

delete from TestViews
delete from TestRuns
delete from Tables
delete from Views
delete from Tests


select * from [TestRuns]