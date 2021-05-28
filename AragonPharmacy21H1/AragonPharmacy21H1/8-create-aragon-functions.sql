/* Purpose: create functions in the AragonPharmacy21H1 database 
	Script Date: February 17, 2021

	Developed by: Anastassia Titova
		                    Raisa Stepanova
		                   Andrey Lyamkin
		                   Leonid Digerman
*/

-- switch to Northwind database
use AragonPharmacy21H1
;
go

/* 1. HumanResources.yearsOfServiceFn function
Calcualtes employee's seniority in years */
if OBJECT_ID('HumanResources.yearsOfServiceFn', 'Fn') is not null
drop function HumanResources.yearsOfServiceFn
;
go

create function HumanResources.yearsOfServiceFn
(
	@startDate as datetime
)
returns int
as
	begin
		declare @yearsOfService as int
		select @yearsOfService = abs(datediff(year, @startDate, getdate()))
		return @yearsOfService
	end
;
go


/* 2.  HumanResources.EmployeeFullNameFn
Display Employee full name */
if OBJECT_ID('HumanResources.EmployeeFullNameFn', 'Fn') is not null
drop function HumanResources.EmployeeFullNameFn
;
go

create function HumanResources.EmployeeFullNameFn
(
	@EmpID as int
)
returns nvarchar(150)
 as
	begin
		declare @FullName as nvarchar(150)
		select @FullName = concat_ws(', ', EmpLast, EmpMI, EmpFirst)
		from [HumanResources].[Employee] 
		where EmpID = @EmpID 
		return @FullName
	end
;
go

/* 3.  Sales.CustomerFullNameFn
Display Customer full name */
if OBJECT_ID('Sales.CustomerFullNameFn', 'Fn') is not null
drop function Sales.CustomerFullNameFn
;
go

create function Sales.CustomerFullNameFn
(
	@CustID as int
)
returns nvarchar(150)
 as
	begin
		declare @FullName as nvarchar(150)
		select @FullName = concat_ws(', ', LastName, FirstName)
		from [Sales].[Customer]
		where CustID = @CustID 
		return @FullName
	end
;
go

/* 4.  HumanResources.getSubstituteListFn
Create an employee substitute list */
create function HumanResources.getSubstituteListFn
	(
		@JobID as int
	)
returns table
as
		return 
		(
			select 
				E.EmpLast as 'Employee Last Name',
				E.EmpFirst as 'Employee First Name',
				E.Phone as 'Phone',
				E.Cell as 'Cell',
				E.JobID as 'Job ID',
				JT.Title as 'Job Title'
			from HumanResources.Employee as E
				inner join HumanResources.JobTitle JT on E.JobID = JT.JobID
			where E.EndDate is null and E.JobID = @JobID
		)
;
go







