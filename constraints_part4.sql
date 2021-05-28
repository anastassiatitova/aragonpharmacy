/***** Table No. 10 -  Sales.Clinic *****/

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


/***** Table No. 11 -  Sales.Doctor *****/

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


/***** Table No. 12 -  Operations.Drug *****/

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

***** Table No. 13 -  Operations.Supplier *****/

-- Default constraints
  /* -- 1. set the default constraint value to 'QC' for Province */
alter table Operations.Supplier
	add constraint df_Province_Supplier default ('QC') for Province
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

