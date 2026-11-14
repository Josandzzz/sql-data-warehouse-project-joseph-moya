USE [data-warehouse-project];
GO

-- 1. Las ventas pasan completas por todas las capas
SELECT 'bronze' AS capa, COUNT(*) AS filas FROM bronze.crm_sales_details UNION ALL
SELECT 'silver',         COUNT(*) FROM silver.crm_sales_details UNION ALL
SELECT 'gold fact',      COUNT(*) FROM gold.fact_sales          UNION ALL
SELECT 'gold report',    COUNT(*) FROM gold.report_sales;

-- 2. Totales iguales entre Silver y Gold
SELECT 'silver' AS capa, SUM(sls_sales) AS total_ventas, SUM(sls_quantity) AS total_cantidad
FROM silver.crm_sales_details
UNION ALL
SELECT 'gold', SUM(sales_amount), SUM(quantity)
FROM gold.report_sales;

-- 3. Ventas sin cliente o producto (esperado: 0)
SELECT COUNT(*) AS ventas_sin_dimension
FROM gold.report_sales
WHERE customer_number IS NULL OR product_number IS NULL;

-- 4. Ejemplo de análisis
SELECT country, category, SUM(sales_amount) AS total_ventas
FROM gold.report_sales
GROUP BY country, category
ORDER BY total_ventas DESC;