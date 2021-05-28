/* Purpose: upload data into tables in the AragonPharmacy21H1 database 
	Script Date: February 11, 2021

	Developed by: Anastassia Titova
		                    Raisa Stepanova
		                   Andrey Lyamkin
		                   Leonid Digerman
*/

-- switch to Northwind database
use AragonPharmacy21H1
;
go

/* ***** Table No. 1 - HumanResources.Class ***** */
BULK INSERT HumanResources.Class  
FROM 'C:\data\Class.csv'
   WITH (
      FIELDTERMINATOR = ',',
      ROWTERMINATOR = '\n',
	  FIRSTROW = 2
);
GO

-- reset identity to 0
DBCC CHECKIDENT ('HumanResources.Class', RESEED, 0);  
GO  

select * from HumanResources.Class
;
go

/* ***** Table No. 2 - HumanResources.Employee  ***** */
bulk insert HumanResources.Employee
from 'C:\data\Employee.csv'
	with
	(
		fieldterminator = ',',
		rowterminator = '\n',
		firstrow = 2
	)
;
go

select * from HumanResources.Employee
;
go

/* ***** Table No. 3 - HumanResources.EmployeeTraining ***** */
bulk insert HumanResources.EmployeeTraining
from 'C:\data\EmployeeTraining.csv'
	with
	(
		fieldterminator = ',',
		rowterminator = '\n',
		firstrow = 2
	)
;
go

select * from HumanResources.EmployeeTraining
;
go

/* ***** Table No. 4 - HumanResources.JobTitle ***** */
bulk insert HumanResources.JobTitle
from 'C:\data\JobTitle.csv'
	with
	(
		fieldterminator = ',',
		rowterminator = '\n',
		firstrow = 2
	)
;
go

select * from HumanResources.JobTitle
;
go

/* ***** Table No. 5 - Sales.Customer ***** */
bulk insert Sales.Customer 
from 'C:\data\Customer.csv'
	with
	(
		fieldterminator = ',',
		rowterminator = '\n',
		firstrow = 2
	)
;
go

select * from Sales.Customer
;
go

/* ***** Table No. 6 - Sales.HealthPlan ***** */
alter table Sales.HealthPlan
	add  Address nvarchar(60) not null,
	       City nvarchar(40) not null,
	       Province province,
	       PostalCode post_code,
	       Phone phone,
	      Days smallint null,
	      Website nvarchar(100) null
;
go

bulk insert Sales.HealthPlan
from 'C:\data\HealthPlan.csv'
	with
	(
		fieldterminator = ',',
		rowterminator = '\n',
		firstrow = 2
	)
;
go

select * from Sales.HealthPlan
;
go

/* ***** Table No. 7 - Sales.Household ***** */
bulk insert Sales.Household
from 'C:\data\Household.csv'
	with
	(
		fieldterminator = ',',
		rowterminator = '\n',
		firstrow = 2
	)
;
go

select * from Sales.Household
;
go

/* ***** Table No. 8 - Sales.Refill ***** */
bulk insert Sales.Refill 
from 'C:\data\Refill.csv'
	with
	(
		fieldterminator = ',',
		rowterminator = '\n',
		firstrow = 2
	)
;
go

select * from Sales.Refill 
;
go

/* ***** Table No. 9 - Sales.Rx ***** */
bulk insert Sales.Rx 
from 'C:\data\Rx.csv'
	with
	(
		fieldterminator = ',',
		rowterminator = '\n',
		firstrow = 2
	)
;
go

select * from Sales.Rx 
;
go

/* ***** Table No. 10 - Sales.Clinic ***** */
bulk insert Sales.Clinic 
from 'C:\data\Clinic.csv'
	with
	(
		fieldterminator = ',',
		rowterminator = '\n',
		firstrow = 2
	)
;
go

select * from Sales.Clinic
;
go

/* ***** Table No. 11 - Sales.Doctor ***** */
bulk insert Sales.Doctor 
from 'C:\data\Doctor.csv'
	with
	(
		fieldterminator = ',',
		rowterminator = '\n',
		firstrow = 2
	)
;
go

select * from Sales.Doctor
;
go

/* ***** Table No. 12 - Operations.Drug ***** */
bulk insert Operations.Drug  
from 'C:\data\Drug.csv'
	with
	(
		fieldterminator = ',',
		rowterminator = '\n',
		firstrow = 2
	)
;
go

select * from Operations.Drug 
;
go

/* ***** Table No. 13 - Operations.Supplier ***** */
bulk insert Operations.Supplier  
from 'C:\data\Supplier.csv'
	with
	(
		fieldterminator = ',',
		rowterminator = '\n',
		firstrow = 2
	)
;
go

select * from Operations.Supplier
;
go