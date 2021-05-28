/* Purpose: create user defined data types in the AragonPharmacy21H1 database 
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

/*  Create data type ssn for Social Insurance Number (sin is a reserved word)*/
CREATE TYPE ssn 
FROM varchar(11) NOT NULL ;  
go

/*  Create test table */
create table dbo.Test
(
	SIN ssn
)
;
go

/* create ssn rule like NNN-NNN-NNN */
Create rule ssn_rule
as @sin  like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]'
;
go

/* Bind the ssn rule and ssn data type */ 
EXEC sp_bindrule ssn_rule, 'ssn'
;
go

/*  Unbind the rule and drop it  */

EXEC sp_unbindrule 'ssn'
;
go

drop rule ssn_rule
;
go


/*  Insert data in the Test table - try different styles*/
insert into dbo.Test
values ('123-154-456')
;
go

/*  Show data in the Test table */
select *
from dbo.Test;
go

/*  Create test table2 */
create table dbo.Test2
(
	Name varchar(10) not null,
	SIN ssn
)
;
go

/*  Insert data in the Test2 table - try different styles*/
insert into dbo.Test2
values ('Mike', '123-154-456')
;
go

/*  Show data in the Test2 table */
select *
from dbo.Test2;
go

/* Delete data from the Test table */
delete 
from Test;
go

drop table Test
;
go