USE [data-warehouse-project];
GO

CREATE OR ALTER VIEW gold.report_sales AS
SELECT
    f.order_number,
    f.order_date,
    f.shipping_date,
    f.due_date,
    f.sales_amount,
    f.quantity,
    f.price,
    c.customer_key,
    c.customer_number,
    c.first_name,
    c.last_name,
    c.country,
    c.marital_status,
    c.gender,
    c.birthdate,
    p.product_key,
    p.product_number,
    p.product_name,
    p.category,
    p.subcategory,
    p.product_line,
    p.cost
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON f.customer_key = c.customer_key
LEFT JOIN gold.dim_products  p ON f.product_key  = p.product_key;
GO