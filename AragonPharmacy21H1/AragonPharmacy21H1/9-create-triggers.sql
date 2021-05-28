/* Purpose: create triggers in the AragonPharmacy21H1 database 

	Script Date: February 18, 2021
	Modification Date: February 18, 2021 

	Developed by: Anastassia Titova
		                    Raisa Stepanova
		                   Andrey Lyamkin
		                   Leonid Digerman
*/

-- switch to AragonPharmacy21H1 database
use AragonPharmacy21H1
;
go

/* 1. create a trigger, HumanResources.CheckRevewDateTR, that checks the modified value of the Revie date column .*/


create trigger HumanResources.CheckRevewDateTR
on HumanResources.Employee
for insert, update
as
	begin
		-- declare variables
		declare @EmpID as int,
			@RevewDate as date
		-- compute the return value
		select @RevewDate = Review,
				@EmpID = EmpID
		from inserted

		-- making decision (comparing the Modified date with the current date 
		if (abs(DateDiff(day, @RevewDate, getDate() )) > 0) or (@RevewDate is null)
			begin
				-- set the modified date to the current date
				update HumanResources.Employee
				set Review = getDate()
				where  EmpID = @EmpID 
				print ' ***** The date was modified ***** '
			end
	end
;
go

enable trigger HumanResources.CheckRevewDateTR
on HumanResources.Review



-- change Review Date to Current Date
update HumanResources.Employee
set Review = getdate()
where EmpID =5
;
go

/* testing trigger HumanResources.CheckRevewDateTR */
select Review
from HumanResources.Employee
where EmpID =5
;
go


/* 2. create a trigger, Sales.UpdateHouseHoldTR, that update any changes applied to the HouseHold table */

if OBJECT_ID('Sales.UpdateHouseHold', 'U') is not null
drop table Sales.UpdateHouseHold
;
go

-- create UpdateHouseHold table */
create table Sales.UpdateHouseHold
(
	HouseLogID uniqueidentifier default newID() not null,
	LogType nchar(3) not null, -- new or old 
	UpdateHouseID int not null,
	UpdateAddress nvarchar(60) not null,
	UpdateApartment nvarchar(10) null,
	UpdateCity nvarchar(40) not null,
	UpdateProvince province,
	UpdatePostalCode post_code,
	ModifiedDate datetime default getDate()
)
;
go


/* set the relationship between Sales.UpdateHouseHold, and Sales.HouseHold tables */
alter table Sales.UpdateHouseHold
	add constraint fk_UpdateHouseHold_Household foreign key (UpdateHouseID)
	references Sales.HouseHold(HouseID)
;
go



create trigger  Sales.UpdateHouseHoldTR
on Sales.HouseHold
for update
as
	begin
	-- audit the EmployeeData old record
		insert into Sales.UpdateHouseHold
		(
		    LogType,
			UpdateHouseID ,
			UpdateAddress,
			UpdateApartment,
			UpdateCity,
			UpdateProvince ,
			UpdatePostalCode 

		)
		select 
			'old',
			del.HouseID ,
			del.Address,
			del.Apartment,
			del.City,
			del.Province ,
			del.PostalCode 

		from deleted as del
		union
		select 
			'new',
			ins.HouseID ,
			ins.Address,
			ins.Apartment,
			ins.City,
			ins.Province ,
			ins.PostalCode 

		from inserted as ins
	end
;
go

update Sales.HouseHold
	set Address = '1555 Rue Duchesneau',
	City = 'Laval',
	PostalCode = 'H7A 0A5'
where HouseID=1
;
go


select *
	from Sales.UpdateHouseHold
;
go