USE master;
GO

IF DB_ID('data-warehouse-project') IS NULL
    CREATE DATABASE [data-warehouse-project];
GO

USE [data-warehouse-project];
GO

IF SCHEMA_ID('bronze') IS NULL EXEC('CREATE SCHEMA bronze');
IF SCHEMA_ID('silver') IS NULL EXEC('CREATE SCHEMA silver');
IF SCHEMA_ID('gold')   IS NULL EXEC('CREATE SCHEMA gold');
GO