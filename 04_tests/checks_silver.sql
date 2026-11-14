USE [data-warehouse-project];
GO

-- 1. Conteo de filas
SELECT 'crm_cust_info'     AS tabla, COUNT(*) AS filas FROM silver.crm_cust_info     UNION ALL
SELECT 'crm_prd_info',      COUNT(*) FROM silver.crm_prd_info      UNION ALL
SELECT 'crm_sales_details', COUNT(*) FROM silver.crm_sales_details UNION ALL
SELECT 'erp_cust_az12',     COUNT(*) FROM silver.erp_cust_az12     UNION ALL
SELECT 'erp_loc_a101',      COUNT(*) FROM silver.erp_loc_a101      UNION ALL
SELECT 'erp_px_cat_g1v2',   COUNT(*) FROM silver.erp_px_cat_g1v2;

-- 2. Clientes duplicados o sin id (esperado: 0 filas)
SELECT cst_id, COUNT(*) FROM silver.crm_cust_info
GROUP BY cst_id HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- 3. Productos con fecha fin menor que la de inicio (esperado: 0 filas)
SELECT * FROM silver.crm_prd_info WHERE prd_end_dt < prd_start_dt;

-- 4. Ventas mal calculadas (esperado: 0 filas)
SELECT * FROM silver.crm_sales_details
WHERE sls_sales <> sls_quantity * sls_price
   OR sls_sales IS NULL OR sls_price IS NULL
   OR sls_sales <= 0   OR sls_price <= 0;

-- 5. Fechas de nacimiento en el futuro (esperado: 0 filas)
SELECT * FROM silver.erp_cust_az12 WHERE bdate > GETDATE();

-- 6. Valores estandarizados (revisar que no haya códigos sueltos)
SELECT DISTINCT cst_marital_status FROM silver.crm_cust_info;
SELECT DISTINCT cst_gndr           FROM silver.crm_cust_info;
SELECT DISTINCT prd_line           FROM silver.crm_prd_info;
SELECT DISTINCT gen                FROM silver.erp_cust_az12;
SELECT DISTINCT cntry              FROM silver.erp_loc_a101;