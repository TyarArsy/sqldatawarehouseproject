/*
===========================================================================
Create Database and Schemas
===========================================================================
Script Purpose:
  This scripts creates a new database named 'DataWarehouse' after checking if it already exists.
  If the database existsm it is dropped and recreated. Additionally, the scripts sets up three schemas 
  within the database: 'bronze','silver', and 'gold'.
 
WARNING:
Running this script will drop the entire 'DataWarehouse' Database if it exists.
All data in the database will be permanently deleted. Procees with caution
and ensure you have proper backups before running this scripts.

*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases where name='DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO
  
-- Create the Database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
  
USE DataWarehouse;
GO
  
-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

