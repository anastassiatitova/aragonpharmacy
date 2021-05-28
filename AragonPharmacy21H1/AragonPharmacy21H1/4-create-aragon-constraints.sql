/* Purpose: create constraints in the AragonPharmacy21H1 database 
	Script Date: February 11, 2021

	Developed by: Anastassia Titova
		                    Raisa Stepanova
		                   Andrey Lyamkin
		                   Leonid Digerman
*/

-- switch to AragonPharmacy21H1 database
use AragonPharmacy21H1
;
go


/***** Table No. 1 -  Operations.Drug *****/

-- Foreign key constraints
/* -- 1. Between Operations.Drug  and Operations.Supplier */
alter table Operations.Drug 
	add constraint fk_Drug_Supplier foreign key (SupplierID)
		references Operations.Supplier (SupplierID)
;
go

-- Default constraints
/* -- 1. set the default constraint value to 0 for CostPerUnit */
alter table Operations.Drug 
	add constraint df_CostPerUnit_Drug default (0) for CostPerUnit
;
go

/* -- 2. set the default constraint value to 0 for PricePerUnit */
alter table Operations.Drug 
	add constraint df_PricePerUnit_Drug default (0) for PricePerUnit
;
go

/* -- 3. set the default constraint value to 0 for DispensingFee */
alter table Operations.Drug 
  add constraint df_DispensingFee_Drug default (0) for DispensingFee
;
go

/* -- 4. set the default constraint value to 0 for Generic */
alter table Operations.Drug 
	add constraint df_Generic_Drug default (0) for Generic
;
go


/***** Table No. 2 -  Operations.Supplier *****/

-- Default constraints
  /* -- 1. set the default constraint value to 'QC' for Province */
alter table Operations.Supplier
	add constraint df_Province_Supplier default ('QC') for Province
;
go

-- Unique constraints
/* -- 1. set the Name to be unique in the Operations.Supplier table */
alter table Operations.Supplier
	add constraint uq_Name_Supplier unique (Name)
;
go

-- Check constraints
/* -- 1. check that Province is equal to  'NL', 'PE', 'NS', 'NB', 'QC', 'ON', 'MB', 'SK', 'AB', 'BC', 'YT', 'NT', 'NU' */
alter table Operations.Supplier
  add constraint ck_Province_Supplier check (Province in ( 'NL', 'PE', 'NS', 'NB', 'QC', 'ON', 'MB', 'SK', 'AB', 'BC', 'YT', 'NT', 'NU'))
 ;
 go

 /* -- 2. check Postal Code is entered as 'LNL NLN' */
 alter table Operations.Supplier
	add constraint ck_PostalCode_Supplier check (PostalCode like '[A-Z][0-9][A-Z]_[0-9][A-Z][0-9]')
;
go

 /* -- 3. check Phone is entered as '(###) ###-####'  */
 alter table Operations.Supplier
	add constraint ck_Phone_Supplier check (Phone like '([0-9][0-9][0-9])_[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
go


/***** Table No. 3 -  HumanResources.Employee *****/

-- Foreign key constraints
/* -- 1. Between HumanResources.Employee and HumanResources.JobTitle */
alter table HumanResources.Employee
	add constraint fk_Employee_JobTitle foreign key (JobID)
		references HumanResources.JobTitle (JobID)
;
go

-- Default constraints
/* -- 1. set the default constraint value to 'QC' for Province */
alter table HumanResources.Employee 
	add constraint df_Province_Employee default ('QC') for Province
;
go

-- Unique constraints
/* -- 1. set the SIN to be unique in the HumanResources.Employee table */
alter table HumanResources.Employee
	add constraint uq_SIN_Employee unique (SIN)
;
go

-- Check constraints
 /* -- 1. check the SIN is entered as '### ### ###' */
 alter table HumanResources.Employee
	add constraint ck_SIN_Employee check (SIN like '[0-9][0-9][0-9]_[0-9][0-9][0-9]_[0-9][0-9][0-9]')
;
go

/* --2. check the DOB < GETDATE() */
alter table HumanResources.Employee
	add constraint ck_DOB_Employee check (DOB < getdate())
;
go

/* -- 3. check EndDate > StartDate */
alter table HumanResources.Employee
	add constraint ck_EndDate_Employee check (EndDate > StartDate)
;
go

/* -- 4. check that Province is equal to  'NL', 'PE', 'NS', 'NB', 'QC', 'ON', 'MB', 'SK', 'AB', 'BC', 'YT', 'NT', 'NU' */
alter table HumanResources.Employee
  add constraint ck_Province_Employee check (Province in ( 'NL', 'PE', 'NS', 'NB', 'QC', 'ON', 'MB', 'SK', 'AB', 'BC', 'YT', 'NT', 'NU'))
 ;
 go

 /* -- 5. check Postal Code is entered as 'LNL NLN' */
 alter table HumanResources.Employee
	add constraint ck_PostalCode_Employee check (PostalCode like '[A-Z][0-9][A-Z]_[0-9][A-Z][0-9]')
;
go

 /* -- 6. check Phone is entered as '(###) ###-####'  */
 alter table HumanResources.Employee
	add constraint ck_Phone_Employee check (Phone like '([0-9][0-9][0-9])_[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
go

 /* -- 7. check Cell is entered as '(###) ###-####'  */
 alter table HumanResources.Employee
	add constraint ck_Cell_Employee check (Cell like '([0-9][0-9][0-9])_[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
go

alter table HumanResources.Employee
	add constraint ck1_DOB_Employee  check (DOB like 'mdy')
;
go


/***** Table No. 4 -  HumanResources.JobTitle *****/

-- Unique constraints
/* -- 1. set the Title to be unique in the HumanResources.JobTitle table */
alter table HumanResources.JobTitle
	add constraint uq_Title_Employee unique (Title)
;
go


/***** Table No. 5 -  HumanResources.EmployeeTraining *****/

-- Foreign key constraints
/* -- 1. Between HumanResources.EmployeeTraining  and HumanResources.Employee */
alter table HumanResources.EmployeeTraining
	add constraint fk_EmployeeTraining_Employee foreign key (EmpID)
		references HumanResources.Employee (EmpID)
;
go

/* -- 2. Between HumanResources.EmployeeTraining  and HumanResources.Class */
alter table HumanResources.EmployeeTraining
	add constraint fk_EmployeeTraining_Class foreign key (ClassID)
		references HumanResources.Class (ClassID)
;
go


/***** Table No. 6 -  HumanResources.Class *****/

-- Default constraints
/* -- 1. set the default constraint value to '0' for Cost */
alter table HumanResources.Class
	add constraint df_Cost_Class default (0) for Cost
;
go


/***** Table No. 7 -  Sales.RX *****/

-- Foreign key constraints
/* -- 1. Between Sales.Rx and Operations.Drug */
alter table Sales.Rx
	add constraint fk_Rx_Drug foreign key (DIN)
		references Operations.Drug (DIN)
;
go

/* -- 2. Between Sales.Rx and Sales.Customer */
alter table Sales.Rx
	add constraint fk_Rx_Customer foreign key (CustID)
		references Sales.Customer (CustID)
;
go

/* -- 3. Between Sales.Rx and Sales.Doctor */
alter table Sales.Rx
	add constraint fk_Rx_Doctor foreign key (DoctorID)
		references Sales.Doctor (DoctorID)
;
go

-- Default constraints
/* -- 1. set the default constraint value to '0' for Refills */
alter table Sales.Rx
	add constraint df_Refills_Rx default (0) for Refills
;
go

/* -- 2. set the default constraint value to '0' for AutoRefill */
alter table Sales.Rx
	add constraint df_AutoRefill_Rx default (0) for AutoRefill
;
go

/* -- 3. set the default constraint value to '0' for RefillsUsed */
alter table Sales.Rx
	add constraint df_RefillsUsed_Rx default (0) for RefillsUsed
;
go

-- Check constraints
 /* -- 1. check ExpireDate > Date */
 alter table Sales.Rx
	add constraint ck_ExpireDate_Rx check (ExpireDate > Date)
;
go


/***** Table No. 8 -  Sales.Refill *****/

-- Foreign key constraints
/* -- 1. Between Sales.Refill and Sales.Rx */
alter table Sales.Refill
	add constraint fk_Refill_Rx foreign key (PrescriptionID)
		references Sales.Rx (PrescriptionID)
;
go

/* -- 2. Between Sales.Refill and HumanResources.Employee */
alter table Sales.Refill
	add constraint fk_Refill_Employee foreign key (EmpID)
		references HumanResources.Employee (EmpID)
;
go


/***** Table No. 9 -  Sales.Clinic *****/

-- Default constraints
/* -- 1. set the default constraint value to 'QC' for Province */
alter table Sales.Clinic
	add constraint df_Province_Clinic default ('QC') for Province
;
go

-- Check constraints
/* -- 1. check that Province is equal to  'NL', 'PE', 'NS', 'NB', 'QC', 'ON', 'MB', 'SK', 'AB', 'BC', 'YT', 'NT', 'NU' */
alter table Sales.Clinic
  add constraint ck_Province_Clinic check (Province in ( 'NL', 'PE', 'NS', 'NB', 'QC', 'ON', 'MB', 'SK', 'AB', 'BC', 'YT', 'NT', 'NU'))
 ;
 go

 /* -- 2. check Postal Code is entered as 'LNL NLN' */
 alter table Sales.Clinic
	add constraint ck_PostalCode_Clinic check (PostalCode like '[A-Z][0-9][A-Z]_[0-9][A-Z][0-9]')
;
go

 /* -- 3. check Phone is entered as '(###) ###-####'  */
 alter table  Sales.Clinic
	add constraint ck_Phone_Clinic check (Phone like '([0-9][0-9][0-9])_[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
go


/***** Table No. 10 -  Sales.Doctor *****/

-- Foreign key constraints
/* -- 1. Between Sales.Doctor and Sales.Clinic */
alter table Sales.Doctor
	add constraint fk_Doctor_Clinic foreign key (ClinicID)
		references Sales.Clinic (ClinicID)
;
go

-- Check constraints
 /* -- 1. check Phone is entered as '(###) ###-####'  */
 alter table  Sales.Doctor
	add constraint ck_Phone_Doctor check (Phone like '([0-9][0-9][0-9])_[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
go

 /* -- 2. check Cell is entered as '(###) ###-####'  */
 alter table  Sales.Doctor
	add constraint ck_Cell_Doctor check (Cell like '([0-9][0-9][0-9])_[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
go


/***** Table No. 11 -  Sales.Customer  *****/

-- Foreign key constraints
/* -- 1. Between Sales.Customer and Sales.HealthPlan */
alter table Sales.Customer
	add constraint fk_Customer_HealthPlan foreign key (PlanID)
		references Sales.HealthPlan (PlanID)
;
go

/* -- 2. Between Sales.Customer and Sales.Household */
alter table Sales.Customer
	add constraint fk_Customer_Household foreign key (HouseID)
		references Sales.Household (HouseID)
;
go

-- Default constraints
/* -- 1. set the default constraint value to 0 for Balance */
alter table Sales.Customer
	add constraint df_Balance_Customer default 0 for Balance
;
go

/* -- 2. set the default constraint value to 1 for HeadHH */
alter table Sales.Customer
	add constraint df_HeadHH_Customer default 1 for HeadHH
;
go

-- Check constraints
 /* -- 1. check Phone is entered as '(###) ###-####'  */
 alter table  Sales.Customer
	add constraint ck_Phone_Customer check (Phone like '([0-9][0-9][0-9])_[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
go

 /* -- 2. check DOB < GETDATE() */
 alter table Sales.Customer
	add constraint ck_DOB_Customer check (DOB < getdate())
;
go

 /* -- 2. check Gender is 'M', 'F' */
 alter table Sales.Customer
	add constraint ck_Gender_Customer check (Gender in ('M', 'F'))
;
go



/***** Table No. 12 -  Sales.Household  *****/

-- Default constraints
/* -- 1. set the default constraint value to 'QC' for Province */
alter table Sales.Household
	add constraint df_Province_Household default ('QC') for Province
;
go

-- Check constraints
/* -- 1. check that Province is equal to  'NL', 'PE', 'NS', 'NB', 'QC', 'ON', 'MB', 'SK', 'AB', 'BC', 'YT', 'NT', 'NU' */
alter table Sales.Household
  add constraint ck_Province_Household check (Province in ( 'NL', 'PE', 'NS', 'NB', 'QC', 'ON', 'MB', 'SK', 'AB', 'BC', 'YT', 'NT', 'NU'))
 ;
 go

 /* -- 2. check Postal Code is entered as 'LNL NLN' */
 alter table Sales.Household
	add constraint ck_PostalCode_Household check (PostalCode like '[A-Z][0-9][A-Z]_[0-9][A-Z][0-9]')
;
go

/***** Table No. 13 - Sales.HealthPlan  *****/
-- No extra constraints (only one primary key)
