USE [data-warehouse-project];
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @inicio DATETIME = GETDATE();
    BEGIN TRY
        PRINT '>> Cargando tablas CRM';

        TRUNCATE TABLE bronze.crm_cust_info;
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\Ashley moya\Downloads\BD_Avanzadas\Ejercicio07\sql-data-warehouse-project-joseph-moya\01_datasets\source_crm\cust_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', CODEPAGE = '65001', TABLOCK);

        TRUNCATE TABLE bronze.crm_prd_info;
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\Ashley moya\Downloads\BD_Avanzadas\Ejercicio07\sql-data-warehouse-project-joseph-moya\01_datasets\source_crm\prd_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

        TRUNCATE TABLE bronze.crm_sales_details;
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\Ashley moya\Downloads\BD_Avanzadas\Ejercicio07\sql-data-warehouse-project-joseph-moya\01_datasets\source_crm\sales_details.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

        PRINT '>> Cargando tablas ERP';

        TRUNCATE TABLE bronze.erp_cust_az12;
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\Ashley moya\Downloads\BD_Avanzadas\Ejercicio07\sql-data-warehouse-project-joseph-moya\01_datasets\source_erp\CUST_AZ12.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

        TRUNCATE TABLE bronze.erp_loc_a101;
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\Ashley moya\Downloads\BD_Avanzadas\Ejercicio07\sql-data-warehouse-project-joseph-moya\01_datasets\source_erp\LOC_A101.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\Ashley moya\Downloads\BD_Avanzadas\Ejercicio07\sql-data-warehouse-project-joseph-moya\01_datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

        PRINT '>> Carga Bronze completa en '
              + CAST(DATEDIFF(SECOND, @inicio, GETDATE()) AS NVARCHAR) + ' segundos';
    END TRY
    BEGIN CATCH
        PRINT '!! Error en la carga Bronze: ' + ERROR_MESSAGE();
    END CATCH
END
GO