# Guía de configuración

## Requisitos
- SQL Server 2017 o superior
- SQL Server Management Studio (SSMS)
- Git

## Orden de ejecución

| # | Script | Acción |
|---|---|---|
| 1 | `03_scripts/init_database.sql` | Crea la base de datos y los esquemas |
| 2 | `03_scripts/bronze/ddl_bronze.sql` | Crea las tablas Bronze |
| 3 | `03_scripts/bronze/proc_load_bronze.sql` | Crea `bronze.load_bronze` |
| 4 | `EXEC bronze.load_bronze;` | Carga los CSV |
| 5 | `03_scripts/silver/ddl_silver.sql` | Crea las tablas Silver |
| 6 | `03_scripts/silver/proc_load_silver.sql` | Crea `silver.load_silver` |
| 7 | `EXEC silver.load_silver;` | Limpia y carga Silver |
| 8 | `03_scripts/gold/ddl_gold.sql` | Crea el modelo estrella |
| 9 | `03_scripts/gold/view_report_sales.sql` | Crea la vista de reportes |
| 10 | `04_tests/*.sql` | Valida cada capa |

## Antes de ejecutar
En `proc_load_bronze.sql`, cambia las rutas de los CSV por la ubicación
del repositorio en tu equipo.

## Recargar los datos
```sql
EXEC bronze.load_bronze;
EXEC silver.load_silver;
```
Gold no se recarga: son vistas y se actualizan solas.
