 /*  Purpose: create the AragonPharmacy21H1 database for Aragon Pharmacy in Montreal 


   Script Date: February 10, 2021
   Developed by: Anastassia Titova 
*/

-- use master database
use master
;
go

--  create AragonPharmacy21H1 database
create database AragonPharmacy21H1
on primary
(
	-- 1. rows data logical filename
	name = 'AragonPharmacy21H1',
	-- 2. rows data initial by size
	size = 12MB,
	-- 3. rows data auto growth size
	filegrowth = 10MB,
	-- 4. rows data maximum file size
	maxsize = 500MB, -- unlimited
	-- 5. rows data path and file name
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AragonPharmacy21H1.mdf'
)
log on
(
	-- 1. log logical filename
	name = 'AragonPharmacy21H1_log',
	-- 2. log initial file size (1/4 of data file size) 
	size = 3MB,
	-- 3. log auto growth size
	filegrowth = 10%,
	-- 4. log maximum file size
	maxsize = 100MB, -- unlimited
	-- 5. log path and file name
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AragonPharmacy21H1_log.ldf'
)
;
go

-- switch to AragonPharmacy21H1 database
use AragonPharmacy21H1
;
go