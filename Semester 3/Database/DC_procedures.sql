
use dental_clinic;

--a. modify the type of a column
GO 
CREATE OR ALTER PROCEDURE setDentistSalaryDecimal 
AS 
		ALTER TABLE Dentist ALTER COLUMN dentist_salary DECIMAL(10,2)

GO 
CREATE OR ALTER PROCEDURE setDentistSalaryInt
AS 
		ALTER TABLE Dentist ALTER COLUMN dentist_salary INT


--b. add / remove a column
GO 
CREATE OR ALTER PROCEDURE addDetailsToPrescription
AS 
		ALTER TABLE Prescription ADD prescription_details varchar(255)

GO 
CREATE OR ALTER PROCEDURE removeDetailsFromPrescription
AS 
		ALTER TABLE Prescription DROP COLUMN prescription_details



--c. add / remove a DEFAULT constraint
GO 
CREATE OR ALTER PROCEDURE addDefaultToExperienceFromAssistant
AS 
		ALTER TABLE Assistant ADD CONSTRAINT default_exp DEFAULT(0) FOR experience

GO
CREATE OR ALTER PROCEDURE removeDefaultFromExperienceFromAssistant
AS
		ALTER TABLE Assistant DROP CONSTRAINT default_exp


--g. create / drop a table
GO
CREATE OR ALTER PROCEDURE addCleaningFirm
AS
		CREATE TABLE CleaningFirms(
					cleaningFirm_id INT NOT NULL,
					cleaningFirm_name varchar(255) NOT NULL,
					salary int NOT NULL,
					CONSTRAINT CLEANINGFIRM_PRIMARY_KEY PRIMARY KEY(cleaningFirm_id),
					dentist_id INT NOT NULL
				)


GO
CREATE OR ALTER PROCEDURE dropCleaningFirm
AS
			DROP TABLE CleaningFirms



--d. add / remove a primary key
GO 
CREATE OR ALTER PROCEDURE addNameSalaryPrimaryKeyCleaningFirm
AS
		ALTER TABLE CleaningFirms
				DROP CONSTRAINT CLEANINGFIRM_PRIMARY_KEY
		ALTER TABLE CleaningFirms
				ADD CONSTRAINT CLEANINGFIRM_PRIMARY_KEY PRIMARY KEY(cleaningFirm_name, salary)

GO
CREATE OR ALTER PROCEDURE removeNameSalaryPrimaryKeyCleaningFirm
AS
		ALTER TABLE CleaningFirms
				DROP CONSTRAINT CLEANINGFIRM_PRIMARY_KEY
		ALTER TABLE CleaningFirms
				ADD CONSTRAINT CLEANINGFIRM_PRIMARY_KEY PRIMARY KEY(cleaningFirm_id)


--e. add / remove a candidate key
GO 
CREATE OR ALTER PROCEDURE newCandidateKeyAssistant
AS 
		ALTER TABLE Assistant
				ADD CONSTRAINT ASSISTANT_CANDIDATE_KEY UNIQUE(assistant_first_name, assistant_last_name, experience)

GO
CREATE OR ALTER PROCEDURE removeCandidateKeyAssistant
AS
		ALTER TABLE Assistant
				DROP CONSTRAINT ASSISTANT_CANDIDATE_KEY


--f. add / remove a foreign key
GO
CREATE OR ALTER PROCEDURE newForeignKeyCleaningFirm
AS
		ALTER TABLE CleaningFirms
				ADD CONSTRAINT CLEANINGFIRM_FOREIGN_KEY FOREIGN KEY(dentist_id) REFERENCES Dentist(dentist_id)
				
GO
CREATE OR ALTER PROCEDURE removeForeignKeyCleaningFirm
AS
		ALTER TABLE CleaningFirms
				DROP CONSTRAINT CLEANINGFIRM_FOREIGN_KEY


--a table that contains the current version
CREATE TABLE VersionTable(
		version INT
)

INSERT INTO VersionTable
VALUES
		(1) --initial version
SELECT * FROM VersionTable
--table with the initial version, the version after the execution of the procedure and the procedure
CREATE TABLE ProcedureTable(
		initial_version INT,
		final_version INT,
		procedure_name varchar(255),
		PRIMARY KEY(initial_version, final_version)
)

INSERT INTO ProcedureTable
VALUES
		(1, 2, 'setDentistSalaryDecimal'),
		(2, 1, 'setDentistSalaryInt'),
		(2, 3, 'addDetailsToPrescription'),
		(3, 2, 'removeDetailsFromPrescription'),
		(3, 4, 'addDefaultToExperienceFromAssistant'),
		(4, 3, 'removeDefaultFromExperienceFromAssistant'),
		(4, 5, 'addCleaningFirm'),
		(5, 4, 'dropCleaningFirm'),
		(5, 6, 'addNameSalaryPrimaryKeyCleaningFirm'),
		(6, 5, 'removeNameSalaryPrimaryKeyCleaningFirm'),
		(6, 7, 'newCandidateKeyAssistant'),
		(7, 6, 'removeCandidateKeyAssistant'),
		(7, 8, 'newForeignKeyCleaningFirm'),
		(8, 7, 'removeForeignKeyCleaningFirm')

--procedure to bring the database to specified version
GO
CREATE OR ALTER PROCEDURE goToVersion(@new_version  INT)
AS
		DECLARE @current_version INT
		DECLARE @procedure_name varchar(255)
		SELECT @current_version = version FROM VersionTable

		IF (@new_version > (SELECT MAX(final_version) FROM ProcedureTable) OR @new_version < 1)
					RAISERROR ('Bad version', 10, 1)
		ELSE
		BEGIN
				IF @new_version = @current_version
						PRINT('You are already in this version!');
				ELSE
				BEGIN
						IF @current_version > @new_version
						BEGIN
								WHILE @current_version > @new_version
									BEGIN 
											SELECT @procedure_name = procedure_name FROM ProcedureTable WHERE initial_version = @current_version AND final_version = @current_version-1
											PRINT('Executing ' +@procedure_name);
											EXEC(@procedure_name)
											SET @current_version = @current_version - 1
									END
						END

						IF @current_version < @new_version
						BEGIN
								WHILE @current_version < @new_version
									BEGIN
											SELECT @procedure_name = procedure_name FROM ProcedureTable WHERE initial_version = @current_version AND final_version = @current_version+1
											PRINT('Executing ' + @procedure_name);
											EXEC(@procedure_name)
											SET @current_version = @current_version + 1
									END
						END

						UPDATE VersionTable SET version = @new_version
				END
		END

EXEC goToVersion 1

SELECT *
FROM VersionTable

SELECT *
FROM ProcedureTable