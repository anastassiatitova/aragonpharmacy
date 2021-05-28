/* Purpose: create schema objects in the AragonPharmacy21H1 database 

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

-- 1. create Sales schema
create schema Sales authorization dbo
;
go

-- 2. create Operations schema
create schema Operations authorization dbo
;
go

-- 3. create HumanResources schema
create schema HumanResources authorization dbo
;
go

