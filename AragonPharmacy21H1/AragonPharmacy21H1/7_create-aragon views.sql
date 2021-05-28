/* Purpose: create views in the AragonPharmacy21H1 database 
	Script Date: February 16, 2021

	Developed by: Anastassia Titova
		                    Raisa Stepanova
		                   Andrey Lyamkin
		                   Leonid Digerman
*/

-- switch to Northwind database
use AragonPharmacy21H1
;
go

/*****  1.  HumanResources.EmployeeTrainingView *****/ -- was written  before I read the instructions
/* Show all employees, classes they took, date the class was taken, class renewal due date, reqirement, price of the class and provider */
create view HumanResources.EmployeeTrainingView
as 
	select E.EmpID as 'EmployeeID', 
			HumanResources.EmployeeFullNameFn(E.EmpID) as 'Employee Name', 
			C.Description as 'Class Description', 
			format(ET.Date, 'MM/dd/yyyy', 'en-US') as 'Training Date', 
			format(DATEADD(year, C.Renewal, ET.Date ), 'MM/dd/yyyy', 'en-US') as 'Renewal Date',
			C.Required as 'Class Required',
			C.Cost as 'Price',
			C.Provider as 'Class Provider'
	from [HumanResources].[Employee] as E
	left join [HumanResources].[EmployeeTraining] as ET
		on E.EmpID = ET.EmpID
	left join [HumanResources].[Class] as C
		on ET.ClassID = C.ClassID
;
go

select *
from HumanResources.EmployeeTrainingView
;
go

/*****  2.  HumanResources.HourlyRateAnalysisView *****/
/*  To list the hourly wages for pharmacy technicians and cashiers, ranked from highest to lowest*/
create view HumanResources.HourlyRateAnalysisView
as
	select E.EmpID as 'Employee ID', 
			HumanResources.EmployeeFullNameFn(E.EmpID) as 'Employee Name', 
			JT.Title as 'Title',
			HumanResources.yearsOfServiceFn(E.StartDate) as 'Seniority (years)',
			E.HourlyRate as 'Hourly Rate'
	from [HumanResources].[Employee] as E
	inner join [HumanResources].[JobTitle] as JT
		on E.JobID = JT.JobID
	where E.HourlyRate <> 0
;
go

select *
from HumanResources.HourlyRateAnalysisView
order by [Hourly Rate] desc
;
go

/*****  2a.  HumanResources.SalaryAnalysisView *****/
/*  To list the salaries for pharmacists and managers, ranked from highest to lowest*/
create view HumanResources.SalaryAnalysisView
as
	select E.EmpID as 'Employee ID', 
			HumanResources.EmployeeFullNameFn(E.EmpID) as 'Employee Name', 
			JT.Title as 'Title',
			HumanResources.yearsOfServiceFn(E.StartDate) as 'Seniority (years)',
			E.Salary as 'Salary'
	from [HumanResources].[Employee] as E
	inner join [HumanResources].[JobTitle] as JT
		on E.JobID = JT.JobID
	where E.Salary<> 0 and Title <> 'Owner'
;
go

select *
from HumanResources.SalaryAnalysisView
order by  Salary desc
;
go

/*****  3.  HumanResources.SpeaksSpanishView *****/
/* To create a list all the employees that speak Spanish */
create view HumanResources.SpeaksSpanishView
as
	select E.EmpID as 'Employee ID', 
			HumanResources.EmployeeFullNameFn(E.EmpID) as 'Employee Name',
			JT.Title as 'Title',
			E.Phone,
			E.Cell,
			E.Memo as 'Memo'
	from [HumanResources].[Employee] as E
	inner join [HumanResources].[JobTitle] as JT
		on E.JobID = JT.JobID
	where E.Memo like '%Spanish%'
;
go

select *
from HumanResources.SpeaksSpanishView
;
go

/*****  4.  HumanResources.HourlyRateSummaryView *****/
/*  To create the hourly rate summary that returns minimun and maximum of hourly rate related to the job position */
create view HumanResources.HourlyRateSummaryView
as
	select JT.Title as 'Title',
			min(E.HourlyRate ) as 'Minimum Hourly Rate',
			max(E.HourlyRate) as 'Maximum Hourly Rate'
	from [HumanResources].[Employee] as E
	inner join [HumanResources].[JobTitle] as JT
		on E.JobID = JT.JobID
	where E.HourlyRate <> 0
	group by JT.Title
;
go

select *
from HumanResources.HourlyRateSummaryView
;
go

/*****  4a.  HumanResources.SalarySummaryView *****/
/*  To create the salary summary that returns minimun and maximum of salaries related to the job position */
create view HumanResources.SalarySummaryView
as
	select JT.Title as 'Title',
			min(E.Salary ) as 'Minimum Salary',
			max(E.Salary) as 'Maximum Salary'
	from [HumanResources].[Employee] as E
	inner join [HumanResources].[JobTitle] as JT
		on E.JobID = JT.JobID
	where E.Salary <> 0 and Title <> 'Owner'
	group by JT.Title
;
go

select *
from HumanResources.SalarySummaryView
;
go

/*****  5.  HumanResources.EmployeeCarpoolView *****/
/* to identify Employees living in the same Postal Code area */
create view HumanResources.EmployeeCarpoolView
as
	select HumanResources.EmployeeFullNameFn(E.EmpID) as 'Employee Name',
		concat_ws(', ', E.Address, E.Apartment, E.City) as 'Address',
		E.PostalCode,
		E.Phone,
		E.Cell
	from [HumanResources].[Employee] as E
;
go

select *
from HumanResources.EmployeeCarpoolView
order by PostalCode
;
go

/*****  6.  Sales.CustomerSalesCallsView *****/
/* to identify Customers living in the same Postal Code area and the same adress  */
create view Sales.CustomerSalesCallsView
as
	select Sales.CustomerFullNameFn(C.CustID) as 'Customer Name',
		concat_ws(', ', H.Address, H.City ) as 'Address',
		H.PostalCode,
		C.Phone
	from [Sales].[Customer] as C
	inner join [Sales].[Household] as H
		on C.HouseID = H.HouseID
;
go

select *
from Sales.CustomerSalesCallsView
order by PostalCode
;
go

/*****  7.  Sales.CustomerWithoutOrdersView *****/
/* To find all customers who have not ordered any products  */
create view Sales.CustomerWithoutOrdersView
as
	select C.CustID,
		Sales.CustomerFullNameFn(C.CustID) as 'Customer Name',
		R.PrescriptionID
	from [Sales].[Customer] as C
	left join [Sales].[Rx] as R
		on C.CustID = R.CustID
	where R.PrescriptionID is null
;
go

select *
from Sales.CustomerWithoutOrdersView
;
go

/* Using queries to find unmatched records */

/* Identify employees who missed requered training courses */
select CONCAT_WS(' ',E.EmpLast, E.EmpFirst) as 'Full Name'
from HumanResources.EmployeeTraining as ET 
	inner join HumanResources.Class as C on ET.ClassID = C.ClassID
	right join HumanResources.Employee as E on ET.EmpID = E.EmpID
where ET.EmpID is null
order by E.EmpLast
;
go

/* Analyzing data from more than one tables */

/* Create view HumanResources.EmployeeClassesView to identify employees who have taken training courses */
create view HumanResources.EmployeeClassesView
as
select CONCAT_WS(' ',E.EmpLast, E.EmpFirst) as 'Full Name', C.ClassID, C.Description, ET.Date
from HumanResources.EmployeeTraining as ET 
	inner join HumanResources.Class as C on ET.ClassID = C.ClassID
	inner join HumanResources.Employee as E on ET.EmpID = E.EmpID
;
go

alter view HumanResources.EmployeeClassesView 
as
select CONCAT_WS(' ',E.EmpLast, E.EmpFirst) as 'Full Name', C.Description as 'Class Description', ET.Date
from HumanResources.EmployeeTraining as ET 
	inner join HumanResources.Class as C on ET.ClassID = C.ClassID
	inner join HumanResources.Employee as E on ET.EmpID = E.EmpID
;
go

select *
from HumanResources.EmployeeClassesView
;
go

/* Create view HumanResources.EmployeeTrainingView to identify employees who have taken training courses and misiing training */
create view HumanResources.EmployeeTrainingView
as
select CONCAT_WS(' ',E.EmpLast, E.EmpFirst) as 'Full Name', C.Description, ET.Date
from HumanResources.EmployeeTraining as ET 
	inner join HumanResources.Class as C on ET.ClassID = C.ClassID
	right join HumanResources.Employee as E on ET.EmpID = E.EmpID
;
go

select *
from HumanResources.EmployeeTrainingView
;
go

/* Create view HumanResources.EmployeeTrainingView to identify employees who have up to date trainings */
create view HumanResources.UpToDateView
as
select CONCAT_WS(' ',E.EmpLast, E.EmpFirst) as 'Full Name', ET.Date, C.Required,C.ClassID, C.Description
from HumanResources.EmployeeTraining as ET 
	inner join HumanResources.Class as C on ET.ClassID = C.ClassID
	right join HumanResources.Employee as E on ET.EmpID = E.EmpID
where C.ClassID in (1,3) and ET.Date between '2020-01-01' and '2020-12-31'
;
go

select *
from HumanResources.UpToDateView
;
go

/* Calculating Statistical Information */

/* Create view HumanResources.MaxMinAvgHourlyRateView to calculate min,max,avg hourly rates for each job ID */
create view HumanResources.MaxMinAvgHourlyRateView
as
select E.JobID as 'Job ID', min(E.HourlyRate) as 'MIN Hourly Rate', max(E.HourlyRate) as 'MAX Hourly Rate', AVG(E.HourlyRate) as 'Avarage Hourly Rate'
from HumanResources.Employee as E
where E.JobID in (3,4)
group by E.JobID
;
go

select *
from HumanResources.MaxMinAvgHourlyRateView
;
go









