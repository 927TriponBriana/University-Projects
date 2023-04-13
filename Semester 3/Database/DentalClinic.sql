use dental_clinic;

create table Devices(
	device_id int not null,
	device_type varchar(255),
	primary key(device_id)
);

create table Specialization(
	spec_id int not null,
	spec_type varchar(255),
	used_devices varchar(255),
	primary key(spec_id)
);

create table Dentist(
	dentist_id int not null,
	dentist_first_name varchar(30), 
	dentist_last_name varchar(30),
	dentist_address varchar(255),
	spec_id int not null,
	device_id int not null,
	dentist_salary int not null,
	hire_date datetime,
	PRIMARY KEY(dentist_id),
	foreign key(device_id)
		references Devices(device_id)
		on delete cascade,
	foreign key(spec_id)
		references Specialization(spec_id)
		on delete cascade
);

create table Pacient(
	pacient_id int not null,
	pacient_first_name varchar(30),
	pacient_last_name varchar(30),
	pacient_address varchar(100),
	dentist_id int not null,
	consultation_needed varchar(255),
	primary key(pacient_id),
	foreign key(dentist_id)
		references Dentist(dentist_id)
			on delete cascade
);
Select *  from Pacient;


create table Consultation(
	consultation_id int not null,
	consultation_type varchar(255),
	consultation_price int NOT NULL,
	consultation_date datetime,
	consultation_duration int not null,
	pacient_id int not null,
	primary key(consultation_id),
	foreign key(pacient_id)
		references Pacient(pacient_id)
		on delete cascade
);

create table Review(
	review_id int not null,
	review_text varchar(255),
	consultation_id int not null,
	review_appreciation int not null,
	primary key(review_id),
	foreign key(consultation_id)
		references Consultation(consultation_id)
		on delete cascade
);

create table Prescription(
	prescription_id int NOT NULL,
	prescription_date datetime,
	pacient_id int not null,
	primary key(prescription_id),
	foreign key(pacient_id)
		references Pacient(pacient_id)
		on delete cascade
);

create table Medication(
	med_id int NOT NULL,
	active_substance varchar(255),
	med_price int NOT NULL,
	PRIMARY KEY(med_id)
);

create table MedicationDentist(
	id_medication int not null,
	id_dentist int not null,
	foreign key(id_medication)
		references Medication(med_id)
		on delete cascade,
	foreign key(id_dentist)
		references Dentist(dentist_id)
		on delete cascade
);

create table Diagnostic(
	diag_id int NOT NULL,
	diagnostic_type varchar(255),
	PRIMARY KEY(diag_id)
);

create table DiagnisticDentist(
	id_diagnostic int NOT NULL,
	id_dentist int NOT NULL,
	FOREIGN KEY(id_diagnostic)
		REFERENCES Diagnostic(diag_id)
		ON DELETE CASCADE,
	FOREIGN KEY(id_dentist)
		REFERENCES Dentist(dentist_id)
		ON DELETE CASCADE
);

create table Assistant(
	assistant_id int NOT NULL,
	assistant_first_name varchar(30),
	assistant_last_name varchar(30),
	dentist_id int not null,
	experience int not null,
	assistant_salary int not null,
	primary key(assistant_id),
	foreign key(dentist_id)
		references Dentist(dentist_id)
		on delete cascade
);





-- ***INSERT***

insert into Pacient
	(pacient_id, pacient_first_name, pacient_last_name, pacient_address, dentist_id, consultation_needed)
	values
	(1, 'Simion', 'Amalia', 'Aurel Suciu 42', 2, 'Detartraj'),
	(2, 'Barsan', 'Cristian', 'Memorandumului 13', 4, 'Obturatie provizorie'),
	(3, 'Gradinariu', 'Teofan', 'Anton Pann 16', 3, 'Amprentare implantologie'),
	(4, 'Cadar', 'Andrei', 'Ioan Slavici 21', 2, 'Inlocuire bracket'),
	(5, 'Ciorcas', 'Giulia', 'Dragos Voda 7', 1, 'Albire profesioanla'),
	(6, 'Hoban', 'Cristian', 'Mihai Eminescu 5', 4, 'Implant dentar'),
	(7, 'Tomescu', 'Alex', 'Tulcea 4', 4, 'Obturatie estetica'),
	(8, 'Tripon', 'Maria', 'Aleea Bratisoara 4', 5, 'Detartraj'),
	(9, 'Negrean', 'Alin', 'Ciucea 4', 6, 'Amprentare implantologie'),
	(10, 'Fechete', 'Alex', 'AAurel Vlaicu 14', 7, 'Obturatie provizorie')
	--(1, 'Grigorut', 'Daniel', 'Aurel Suciu 42', 3, 'Detartraj')
;

insert into Dentist
	(dentist_id, dentist_first_name, dentist_last_name, dentist_address, dentist_salary, hire_date, device_id, spec_id)
	values
	(1, 'Boitor', 'Patrick', 'Micu Klein 12',13400, '2019-03-12', 2, 3),
	(2, 'Leiher', 'Nora', 'Aurel Pop 2', 12345,'2021-05-13', 1, 2),
	(3, 'Borza', 'Calin', 'Mehedinti 72', 11000, '2022-10-29', 3, 1),
	(4, 'Soponar', 'Tudor', 'Florilor 134', 9000, '2020-12-19', 2, 1),
	(5, 'Silvasan', 'Alexandra', 'Maramuresului 13', 8500, '2022-11-15', 1, 1),
	(6, 'Topan', 'Alex', 'Bradului 17', 10000, '2021-08-01', 2, 2),
	(7, 'Zamfir', 'Alina', 'Bucuresti 148', 9300, '2022-09-17', 3, 2)
;

insert into Consultation
	(consultation_id, consultation_type, consultation_price, consultation_date, consultation_duration, pacient_id)
	values
	(1, 'Detartraj', 150, '2022-11-09', 60, 4),
	(2, 'Obturatie provizorie', 50, '2022-11-09', 25, 2),
	(3, 'Obturatie estetica', 200, '2022-11-11', 45, 2),
	(4, 'Amprentare implantologie', 200, '2022-11-25', 90, 5),
	(5, 'Implant dentar', 1500, '2022-12-05', 50, 5),
	(6, 'Albire profesioanla', 300, '2022-11-29', 120, 1),
	(7, 'Albire profesioanla', 800, '2022-12-10', 20, 6),
	(8, 'Inlocuire bracket', 50,' 2022-12-16', 40, 3),
	(9, 'Detartraj', 150, '2022-12-18', 60, 3),
	(10, 'Detartraj', 300, '2022-11-30', 70, 5),
	(11, 'Inlocuire bracket', 60, '2022-11-08', 180, 1)
;

insert into Review
	(review_id, review_text, consultation_id, review_appreciation)
	values
	(1, 'Very good', 2, 40),
	(2, 'Did not take long and it was without pain', 3, 60),
	(3, 'Professional', 9, 100),
	(4, 'Quick', 11, 30),
	(5, 'Painless', 4, 10),
	(6, 'Quick results', 7, 110),
	(7, 'Without pain', 1, 45)
;

insert into Prescription
	(prescription_id, prescription_date, pacient_id)
	values
	(1, '2022-11-09', 4),
	(2, '2022-11-22', 5),
	(3, '2022-12-03', 3),
	(4, '2022-12-10', 1),
	(5, NULL, 2)
;

insert into Medication
	(med_id, active_substance, med_price)
	values
	(1, 'Augmentin', 32),
	(2, 'Nurofen', 25),
	(3, 'Metrocropramid', 10),
	(4, 'Algesim', 30)
;
select * from Medication;

insert into MedicationDentist
	(id_medication, id_dentist)
	values
	(1, 3),
	(3, 4),
	(1, 2)
;

insert into Assistant
	(assistant_id, assistant_first_name, assistant_last_name, dentist_id, experience, assistant_salary)
	values
	(1, 'Popescu', 'Ioana', 2, 10, 2500),
	(2, 'Bura', 'Maria', 2, 6, 1100),
	(3, 'Silaghi', 'Stefan', 3, 8, 1300),
	(4, 'Tomescu', 'Alex', 4, 3, 1000),
	(5, 'Simion', 'Maria', 2, 9, 2400)
;

insert into Devices
	(device_id, device_type)
	values
	(1, 'Scaun stomatologic'),
	(2, 'Ansa implantologie'),
	(3, 'Caseta sterilizare')
;

insert into Specialization
	(spec_id, spec_type, used_devices)
	values
	(1, 'Ortodont', 'Ansa implantologie'),
	(2, 'Chirurgie dentara', 'Caseta sterilizare'),
	(3, 'Tehnician dentar', 'Ansa implantologie')
;

insert into Diagnostic
	(diag_id, diagnostic_type)
	values
	(1, 'Deformarea maxilarului'),
	(2, 'Carie'),
	(3, 'Muscatura gresita')
;

insert into DiagnisticDentist
	(id_dentist, id_diagnostic)
	values
	(1, 3),
	(3, 2)
;

---***Update***
--update the address of the dentist with id=2
 UPDATE Dentist
	SET dentist_address='Teleorman 55' WHERE dentist_id=2
SELECT * FROM Dentist;

--update consultation prices of types Detartraj, Obturatie provizorie, Obturatie estetica that are greater than 49 and lower than 301
--uses AND, IN, BETWEEN
UPDATE Consultation
	SET consultation_price=consultation_price+50 WHERE consultation_type IN ('Detartraj', 'Obturatie provizorie', 'Obturatie estetica') AND consultation_price BETWEEN 49 AND 301
SELECT * FROM Consultation;

--update prescription date such that a prescription has no longer null as date
--uses IS NULL
UPDATE Prescription
	SET prescription_date='2022-12-13' WHERE prescription_date IS NULL
SELECT * FROM Prescription;


-- ***Delete***
--delete the consultations that contain the word "albire" in them
--uses LIKE
DELETE FROM Consultation
	WHERE consultation_type LIKE '%Albire%'
SELECT * FROM Consultation;

--delete the consultations which have the price greate than 800
--uses >
DELETE FROM Consultation
	WHERE consultation_price > 800
SELECT * FROM Consultation;


--a. 2 queries with the union operation; use UNION [ALL] and OR
--the dentist Leiher(with id=2) holds a meeting and at the meeting can attend only the pacients who she works for 
--and the assistans who she works with
SELECT P.pacient_first_name
FROM Pacient P
WHERE P.dentist_id = 2
UNION
SELECT A.assistant_first_name
FROM Assistant A
WHERE A.dentist_id = 2

--select all the dentists who work for pacients with last name Maria or who work with assistants with last name Ioana, 
--eliminating duplicates
SELECT DISTINCT D.dentist_first_name, D.dentist_last_name
FROM Dentist D, Pacient P, Assistant A
WHERE (D.dentist_id = P.dentist_id AND P.pacient_last_name = 'Maria') OR (D.dentist_id = A.dentist_id AND A.assistant_last_name = 'Ioana')

--b. 2 queries with the intersection operation; use INTERSECT and IN
--all assistants that have the same first name as pacients
SELECT A.assistant_first_name
FROM Assistant A
INTERSECT
SELECT P.pacient_first_name
FROM Pacient P

--all assistants that have the same first name as pacients(with IN)
SELECT A.assistant_first_name
FROM Assistant A
WHERE A.assistant_first_name IN (
				SELECT P.pacient_first_name
				FROM Pacient P )

--c. 2 queries with the difference operation; use EXCEPT and NOT IN
--used OR
--devices that are Scaun stomatologic or Ansa implantologie, but are not used in a specialization by a dentist
SELECT D.device_type
FROM Devices D
WHERE D.device_type = 'Scaun stomatologic' OR D.device_type = 'Ansa implantologie'
EXCEPT
SELECT S.used_devices
FROM Specialization S

--devices that are Scaun stomatologic or Ansa implantologie, but are not used in a specialization by a dentist (with NOT IN)
SELECT D.device_type
FROM Devices D
WHERE (D.device_type = 'Scaun stomatologic' OR D.device_type = 'Ansa implantologie') AND D.device_type NOT IN (
				SELECT S.used_devices
				FROM Specialization S)

--d. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one query per operator); one query will join at least 3 tables, 
--while another one will join at least two many-to-many relationships;
--INNER JOIN
--get for each pacient the consultations that it has
SELECT P.pacient_first_name, P.pacient_last_name, C.consultation_type
FROM Pacient P INNER JOIN Consultation C ON C.pacient_id = P.pacient_id

--LEFT JOIN
--print all the dentists and their pacients and assistants, including the one than have no pacients or assistants
--join 3 tables
SELECT D.dentist_first_name, D.dentist_last_name, P.pacient_first_name, P.pacient_last_name, A.assistant_first_name, A.assistant_last_name
FROM Dentist D
LEFT JOIN Pacient P ON D.dentist_id = P.dentist_id
LEFT JOIN Assistant A ON D.dentist_id = A.dentist_id

--RIGHT JOIN
--print all the dentists and the prescribed medication, include dentists that did not prescribe any medication
SELECT D.dentist_first_name, M.active_substance
FROM Dentist D
RIGHT JOIN MedicationDentist MD ON MD.id_dentist = D.dentist_id
RIGHT JOIN Medication M ON M.med_id = MD.id_medication

--FULL JOIN
--print all diagnostics for witch dentists have given medications, include diagnostics that have no medications, dentists that have given no medication
--join 2 many-to-many relationships
SELECT DI.diagnostic_type, D.dentist_first_name, M.active_substance
FROM Diagnostic DI
FULL JOIN DiagnisticDentist DID ON DID.id_diagnostic = DI.diag_id
FULL JOIN Dentist D ON D.dentist_id = DID.id_dentist
FULL JOIN MedicationDentist MD ON MD.id_dentist = D.dentist_id
FULL JOIN Medication M ON M.med_id = MD.id_medication

--e. 2 queries with the IN operator and a subquery in the WHERE clause; in at least one case, 
--the subquery must include a subquery in its own WHERE clause
--print the diagnostics given by dentists that have medications
--uses DISTINCT
SELECT DI.diagnostic_type
FROM Diagnostic DI
WHERE DI.diag_id IN (
				SELECT DISTINCT DI2.diag_id
				FROM Dentist DE INNER JOIN DiagnisticDentist DD ON DE.dentist_id = DD.id_dentist
								INNER JOIN Diagnostic DI2 ON DD.id_diagnostic = DI2.diag_id
				WHERE DD.id_dentist IN(
								SELECT DE2.dentist_id
								FROM Dentist DE2 INNER JOIN MedicationDentist MD ON MD.id_dentist = DE2.dentist_id
												 INNER JOIN Medication M ON M.med_id = MD.id_medication
									)
					)

--print all the dentists which have pacients with consultation duration longer than 30 minutes with reviews 
--condition in the WHERE clause with AND, NOT
--uses DISTINCT
SELECT D.dentist_first_name
FROM Dentist D
WHERE D.dentist_id IN(
					SELECT P.dentist_id
					FROM Pacient P
					WHERE P.consultation_needed IN(
								SELECT C.consultation_type
								FROM Consultation C
								WHERE NOT C.consultation_duration < 30 AND C.consultation_id IN(
														SELECT DISTINCT R.consultation_id
														FROM Review R)))


--f. 2 queries with the EXISTS operator and a subquery in the WHERE clause;
--print dentists that have pacients
--multiply their salary by 10, they have pacients this means they are good dentists
SELECT D.dentist_first_name, D.dentist_salary*10 AS NewSalary
FROM Dentist D
WHERE EXISTS(
			SELECT *
			FROM Dentist D2 INNER JOIN Pacient P ON P.dentist_id = D2.dentist_id)


--print medications that were prescribed and ar not empty
SELECT M.active_substance
FROM Medication M
WHERE EXISTS(
			SELECT *
			FROM Dentist D 
			INNER JOIN MedicationDentist MD ON D.dentist_id = MD.id_dentist
			INNER JOIN Medication M2 ON M2.med_id = MD.id_medication
			WHERE M2.med_id = M.med_id)

--g. 2 queries with a subquery in the FROM clause
--print the dentists that have the salary at least 7500 and are working for pacients
-- increase with 500 their salary (arithmetic operstion in SELECT)
SELECT D.dentist_first_name, D.dentist_salary + 100 AS increased_salary
FROM (
		SELECT *
		FROM Dentist D2
		WHERE NOT D2.dentist_salary < 7500
	)D WHERE D.dentist_id IN(
								SELECT DISTINCT P.dentist_id 
								FROM Pacient P
							)
ORDER BY increased_salary DESC

--print the consultations that have reviews with at least 50 appreciations which belong to a pacient
--the number of appreciations will increase with 10
--arithmetic operation in the SELECT clause
--order ascending by the number of appreciations
SELECT c.consultation_type, c.review_appreciation + 10 AS appreciations, c.review_text
FROM (
		SELECT C.consultation_type, R.consultation_id, R.review_appreciation, R.review_text
		FROM Consultation C INNER JOIN Review R ON C.consultation_id = R.consultation_id
		WHERE R.review_appreciation >= 50
	)c WHERE c.consultation_id IN(
					SELECT C2.consultation_id
					FROM Consultation C2
					INNER JOIN Pacient P ON C2.consultation_type = P.consultation_needed
					)
ORDER BY appreciations ASC


--h. 4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause;
--2 of the latter will also have a subquery in the HAVING clause; use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;
--print pacients and the number of consultations for each of them
--uses COUNT
SELECT C.consultation_type, COUNT(*) AS consultations
FROM Consultation C
GROUP BY C.consultation_type

--prints the dentists who prescribed the most medications
--contains the HAVING clause
--has a subquery in th HAVING clause
--uses COUNT, MAX
SELECT D.dentist_id, D.dentist_first_name, COUNT(*) AS medications
FROM Dentist D INNER JOIN MedicationDentist MD ON D.dentist_id = MD.id_dentist
				INNER JOIN Medication M ON M.med_id = MD.id_medication
GROUP BY D.dentist_id, D.dentist_first_name
HAVING COUNT(*) = (
					SELECT MAX(T.C)
					FROM (
							SELECT COUNT(*) C
							FROM Dentist D2 INNER JOIN MedicationDentist MD2 ON D2.dentist_id = MD2.id_dentist
											INNER JOIN Medication M2 ON M2.med_id = MD2.id_medication
							GROUP BY D2.dentist_id, D2.dentist_first_name
							)T
					)

--print the minimum price from all the total prices per consultation type
--contains HAVING clause
--has a subquery in the HAVING clause
--uses SUM, MIN
SELECT C.consultation_type, SUM(C.consultation_price) AS total_price
FROM Consultation C
GROUP BY C.consultation_type
HAVING SUM(C.consultation_price) = (
						SELECT MIN(T.c)
						FROM(
								SELECT SUM(C2.consultation_price) c
								FROM Consultation C2
								GROUP BY C2.consultation_type
							)T
						)

--print the average price for each consultation type with at least 2 consultation dates after 2022-11-08
--contain HAVING clause
--has a subquery in the HAVING clause
--uses AVG, COUNT
SELECT C.consultation_type, AVG(C.consultation_price) AS average_price
FROM Consultation C
GROUP BY C.consultation_type
HAVING 1 < (SELECT COUNT(C2.consultation_type)
			FROM Consultation C2
			WHERE C.consultation_type = C2.consultation_type AND C2.consultation_date >= '2022-11-09')

--i. 4 queries using ANY and ALL to introduce a subquery in the WHERE clause (2 queries per operator); 
--rewrite 2 of them with aggregation operators, and the other 2 with IN / [NOT] IN
--find the top 5 consultations whitch have the price greater than the lowest consultation price FOR detartraj
--uses ANY
--uses ORDER BY
SELECT TOP 5 C.*
FROM Consultation C
WHERE C.consultation_price > ANY(
							SELECT C2.consultation_price
							FROM Consultation C2
							WHERE C2.consultation_type = 'Detartraj')
ORDER BY C.consultation_price DESC

--rewritten with an aggregation operator
--uses MIN instead of ANY
SELECT TOP 5 C.*
FROM Consultation C
WHERE C.consultation_price > (
							SELECT MIN(C2.consultation_price)
							FROM Consultation C2
							WHERE C2.consultation_type = 'Detartraj')
ORDER BY C.consultation_price DESC


--find all the pacients for the newest hired dentists (dentists that were hired in 2021, 2022)
--using ANY
SELECT P.*
FROM Pacient P
WHERE P.dentist_id = ANY(
					SELECT D.dentist_id
					FROM Dentist D
					WHERE D.hire_date >= '2021-01-01')

--rewritten with IN
SELECT P.*
FROM Pacient P
WHERE P.dentist_id IN(
					SELECT D.dentist_id
					FROM Dentist D
					WHERE D.hire_date >= '2021-01-01')


--find all top 50% assistants for witch half of the experience is more than the experience
--the assistants with salary smaller than 1200
--uses ALL
--ordered descendind=g by experience
SELECT TOP 50 PERCENT A.*
FROM Assistant A
WHERE A.experience/2 > ALL(
						SELECT A2.experience
						FROM Assistant A2
						WHERE A2.assistant_salary < 1200)
ORDER BY A.experience DESC

--rewritting using MAX instead of ALL
SELECT TOP 50 PERCENT A.*
FROM Assistant A
WHERE A.experience/2 >(
						SELECT MAX(A2.experience)
						FROM Assistant A2
						WHERE A2.assistant_salary < 1200)
ORDER BY A.experience DESC


--find all assistants that are not pacients whose last name is alex
--uses ALL
SELECT A.*
FROM Assistant A
WHERE A.assistant_last_name <>ALL(
							SELECT P.pacient_last_name
							FROM Pacient P
							WHERE P.pacient_last_name LIKE '%Alex%')

--rewritting using IS NOT
SELECT A.*
FROM Assistant A
WHERE A.assistant_last_name NOT IN(
							SELECT P.pacient_last_name
							FROM Pacient P
							WHERE P.pacient_last_name LIKE '%Alex%')
