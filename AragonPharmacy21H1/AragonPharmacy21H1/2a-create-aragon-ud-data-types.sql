/* Purpose: create schema objects in the AragonPharmacy21H1 database 

	Script Date: February 13, 2021

	Developed by: Anastassia Titova
		                    Raisa Stepanova
		                   Andrey Lyamkin
		                   Leonid Digerman
*/

-- switch to AragonPharmacy21H1 database
use AragonPharmacy21H1
;
go

/* create Province data type */
create type province
from nchar(2) not null
;
go

/* create Phone, Cell, Fax data type */
create type phone
from nchar(14) null
;
go

/* create Postal Code data type */
create type post_code
from nchar(7) not null
;
go

/* Create Email data type */
create type email
from nvarchar(60) null
;
go

