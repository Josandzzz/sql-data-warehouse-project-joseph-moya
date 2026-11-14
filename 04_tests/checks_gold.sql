USE [data-warehouse-project];
GO

-- 1. Conteo de filas
SELECT 'dim_customers' AS vista, COUNT(*) AS filas FROM gold.dim_customers UNION ALL
SELECT 'dim_products',  COUNT(*) FROM gold.dim_products  UNION ALL
SELECT 'fact_sales',    COUNT(*) FROM gold.fact_sales;

-- 2. Claves únicas (esperado: 0 filas)
SELECT customer_key FROM gold.dim_customers GROUP BY customer_key HAVING COUNT(*) > 1;
SELECT product_key  FROM gold.dim_products  GROUP BY product_key  HAVING COUNT(*) > 1;

-- 3. Ventas sin cliente o producto (esperado: 0 filas)
SELECT * FROM gold.fact_sales WHERE customer_key IS NULL OR product_key IS NULL;

-- 4. Productos sin categoría (esperado: 7 filas, categoría CO_PE)
SELECT product_number, product_name, category_id
FROM gold.dim_products WHERE category IS NULL;