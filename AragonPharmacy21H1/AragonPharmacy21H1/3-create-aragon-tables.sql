/* Purpose: create tables in the AragonPharmacy21H1 database 
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
if OBJECT_ID('HumanResources.Class', 'U') is not null
drop table HumanResources.Class
;
go

create table HumanResources.Class
(
	ClassID int identity(1,1) not null,
	Description nvarchar(100) not null,
	Cost smallmoney not null,
	Renewal smallint null,
	Required bit null,
	Provider nvarchar(100) not null,
	constraint pk_Class primary key clustered (ClassID asc)
)
;
go

execute sp_help 'HumanResources.Class'
;
go

/* ***** Table No. 2 - HumanResources.Employee  ***** */
if OBJECT_ID('HumanResources.Employee', 'U') is not null
	drop table HumanResources.Employee
;
go

create table HumanResources.Employee
(
	EmpID int identity(1, 1) not null,
	EmpFirst nvarchar(30) not null,
	EmpMI nvarchar(30) null,
	EmpLast nvarchar(30) not null,
	SIN nchar(11) not null,
	DOB date not null,
	StartDate date not null,
	EndDate date null,
	Address nvarchar(60) not null,
	Apartment nvarchar(10) null,
	City nvarchar(40) not null,
	Province province,
	PostalCode post_code,
	JobID int not null,
	Memo nvarchar(512) null,
	Phone phone,
	Cell phone,
	Salary money null,
	HourlyRate smallmoney null,
	Review date null,
	Email email,
	constraint pk_Employee primary key clustered (EmpID asc)
)
;
go

execute sp_help 'HumanResources.Employee'
;
go

/* ***** Table No. 3 - HumanResources.EmployeeTraining ***** */
if OBJECT_ID('HumanResources.EmployeeTraining', 'U') is not null
drop table HumanResources.EmployeeTraining
;
go

create table HumanResources.EmployeeTraining
(
	EmpID int not null,
	ClassID int not null,
	Date date not null,
	constraint pk_EmployeeTraining primary key clustered 
		(
			EmpID asc,
			ClassID asc,
			Date asc
		)
)
;
go

execute sp_help 'HumanResources.EmployeeTraining'
;
go

/* ***** Table No. 4 - HumanResources.JobTitle ***** */
if OBJECT_ID('HumanResources.JobTitle', 'U') is not null
drop table HumanResources.JobTitle
;
go

create table HumanResources.JobTitle
(
	JobID int identity(1,1) not null,
	Title nvarchar(30) not null,
	Description nvarchar(100) null,
	constraint pk_JobTitle primary key clustered (JobID asc)
)
;
go

execute sp_help 'HumanResources.JobTitle'
;
go

/* ***** Table No. 5 - Sales.Customer ***** */
if OBJECT_ID('Sales.Customer', 'U') is not null
drop table Sales.Customer
;
go

create table Sales.Customer
(
	CustID int identity(1,1) not null,
	FirstName nvarchar(30) not null,
	LastName nvarchar(30) not null,
	Phone phone,
	DOB date not null,
	Gender nchar(1) not null,
	Balance smallmoney not null,
	ChildProofCap bit null,
	PlanID nchar(20) not null,
	HouseID int not null,
	HeadHH bit not null,
	Allergies nvarchar(50) null,
	Email email,
	constraint pk_Customer primary key clustered (CustID asc)
)
;
go

execute sp_help 'Sales.Customer'
;
go

/* ***** Table No. 6 - Sales.HealthPlan ***** */
if OBJECT_ID('Sales.HealthPlan', 'U') is not null
drop table Sales.HealthPlan
;
go

create table Sales.HealthPlan
(
	PlanID nchar(20) not null,
	PlanName nvarchar(50) not null,
	constraint pk_HealthPlan primary key clustered (PlanID asc)
)
;
go

execute sp_help 'Sales.HealthPlan'
;
go


/* ***** Table No. 7 - Sales.Household ***** */
if OBJECT_ID('Sales.Household', 'U') is not null
drop table Sales.Household
;
go

create table Sales.Household
(
	HouseID int identity(1,1) not null,
	Address nvarchar(60) not null,
	Apartment nvarchar(10) null,
	City nvarchar(40) not null,
	Province province,
	PostalCode post_code,
	constraint pk_Household primary key clustered (HouseID asc)
)
;
go

execute sp_help 'Sales.Household'
;
go

/* ***** Table No. 8 - Sales.Refill ***** */
if OBJECT_ID('Sales.Refill', 'U') is not null
drop table Sales.Refill
;
go

create table Sales.Refill
(
	PrescriptionID int not null,
	RefillDate date not null,
	EmpID int not null,
	constraint pk_Refill primary key clustered 
		(
			PrescriptionID asc,
			RefillDate asc
		)
)
;
go

execute sp_help 'Sales.Refill'
;
go

/* ***** Table No. 9 - Sales.Rx ***** */
if OBJECT_ID('Sales.Rx', 'U') is not null
drop table Sales.Rx
;
go

create table Sales.Rx
(
	PrescriptionID int identity(1,1) not null,
	DIN nchar(8) not null,
	Quantity decimal(10,2) not null,
	Unit nvarchar(10) not null,
	Date date not null,
	ExpireDate date null,
	Refills smallint null,
	AutoRefill bit null,
	RefillsUsed smallint null,
	Instructions nvarchar(50) null,
	CustID int not null,
	DoctorID int not null,
	constraint pk_Rx primary key clustered (PrescriptionID asc)
)
;
go

execute sp_help 'Sales.Rx'
;
go

/* ***** Table No. 10 - Sales.Clinic ***** */
if OBJECT_ID('Sales.Clinic', 'U') is not null
drop table Sales.Clinic
;
go

create table Sales.Clinic
(
	ClinicID int identity(1,1) not null,
	ClinicName nvarchar(50) not null,
	Address1 nvarchar(40) not null,
	Addres2 nvarchar(40) null,
	City nvarchar(40) not null,
	Province province,
	PostalCode post_code,
	Phone phone,
	Email email,
	constraint pk_Clinic primary key clustered (ClinicID asc)
)
;
go

execute sp_help 'Sales.Clinic'
;
go

/* ***** Table No. 11 - Sales.Doctor ***** */
if OBJECT_ID('Sales.Doctor', 'U') is not null
drop table Sales.Doctor
;
go

create table Sales.Doctor
(
	DoctorID int identity(1,1) not null,
	FirstName nvarchar(30) not null,
    LastName nvarchar(30) not null,
	Phone phone,
	Cell phone,
	ClinicID int not null,
	Email email,
	constraint pk_Doctor primary key clustered (DoctorID asc)
)
;
go

execute sp_help 'Sales.Doctor'
;
go

/* ***** Table No. 12 - Operations.Drug ***** */
if OBJECT_ID('Operations.Drug', 'U') is not null
drop table Operations.Drug
;
go

create table Operations.Drug
(
	DIN nchar(8) not null,
	Name nvarchar(30) not null,
	Generic bit not null,
	Description nvarchar(250) null,
	Unit nvarchar(10) not null,
	Dosage nvarchar(10) null,
	DosageForm nvarchar(20) null,
	CostPerUnit money not null,
	PricePerUnit money not null,
	DispensingFee smallmoney not null,
	Interactions nvarchar(100) null,
	SupplierID int not null,
	UnitInStock smallint null,
	UnitsOnOrder smallint null,
	constraint pk_Drug primary key clustered (DIN asc)
)
;
go

execute sp_help 'Operations.Drug'
;
go

/* ***** Table No. 13 - Operations.Supplier ***** */
if OBJECT_ID('Operations.Supplier', 'U') is not null
drop table Operations.Supplier
;
go

create table Operations.Supplier
(
	SupplierID int identity(1, 1) not null,
	Name nvarchar(50) not null,
	Address1 nvarchar(40) not null,
	Address2 nvarchar(40) null,
	City nvarchar(40) not null,
	Province province,
	PostalCode post_code,
	Phone phone,
	Email email,
	Contact nvarchar(50) null,
	constraint pk_SupplierID primary key clustered (SupplierID asc)
)
;
go

execute sp_help 'Operations.Supplier'
;
go

/* display user-defined and system tables */

-- in schema HumanResources
execute sp_tables
@table_owner = 'HumanResources',
@table_qualifier = 'AragonPharmacy21H1'
;
go

-- in schema Sales
execute sp_tables
@table_owner = 'Sales',
@table_qualifier = 'AragonPharmacy21H1'
;
go

-- in schema Operations
execute sp_tables
@table_owner = 'Operations',
@table_qualifier = 'AragonPharmacy21H1'
;
go
