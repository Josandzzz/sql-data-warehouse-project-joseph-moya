# Flujo de datos

```mermaid
flowchart LR
    subgraph Fuentes
        CRM[CRM<br/>cust_info<br/>prd_info<br/>sales_details]
        ERP[ERP<br/>CUST_AZ12<br/>LOC_A101<br/>PX_CAT_G1V2]
    end

    subgraph Bronze
        B1[crm_cust_info]
        B2[crm_prd_info]
        B3[crm_sales_details]
        B4[erp_cust_az12]
        B5[erp_loc_a101]
        B6[erp_px_cat_g1v2]
    end

    subgraph Silver
        S1[crm_cust_info]
        S2[crm_prd_info]
        S3[crm_sales_details]
        S4[erp_cust_az12]
        S5[erp_loc_a101]
        S6[erp_px_cat_g1v2]
    end

    subgraph Gold
        G1[dim_customers]
        G2[dim_products]
        G3[fact_sales]
        G4[report_sales]
    end

    CRM --> B1 & B2 & B3
    ERP --> B4 & B5 & B6
    B1 --> S1
    B2 --> S2
    B3 --> S3
    B4 --> S4
    B5 --> S5
    B6 --> S6
    S1 & S4 & S5 --> G1
    S2 & S6 --> G2
    S3 --> G3
    G1 & G2 --> G3
    G3 --> G4
```

| Capa | Proceso | Carga |
|---|---|---|
| Bronze | `bronze.load_bronze` – BULK INSERT desde CSV, sin cambios | Truncate & Insert |
| Silver | `silver.load_silver` – limpieza y estandarización | Truncate & Insert |
| Gold | Vistas – integración en modelo estrella | No aplica |
