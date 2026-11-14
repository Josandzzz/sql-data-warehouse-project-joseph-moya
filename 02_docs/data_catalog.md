# Catálogo de datos – Capa Gold

La capa Gold contiene los datos listos para análisis, organizados en un
**modelo estrella** (2 dimensiones y 1 tabla de hechos) y una vista de reportes.

---

## gold.dim_customers

Dimensión de clientes. Integra CRM (datos principales) con ERP
(fecha de nacimiento, género y país). Una fila por cliente.

| Columna | Tipo | Descripción |
|---|---|---|
| customer_key | BIGINT | Clave subrogada del cliente. |
| customer_id | INT | Identificador del cliente en el CRM. |
| customer_number | NVARCHAR(50) | Código alfanumérico del cliente (ej. `AW00011000`). |
| first_name | NVARCHAR(50) | Nombre del cliente. |
| last_name | NVARCHAR(50) | Apellido del cliente. |
| country | NVARCHAR(50) | País de residencia (ej. `Australia`, `United States`). |
| marital_status | NVARCHAR(50) | Estado civil: `Married`, `Single` o `n/a`. |
| gender | NVARCHAR(50) | Género: `Male`, `Female` o `n/a`. Prioriza CRM; si no hay dato, usa ERP. |
| birthdate | DATE | Fecha de nacimiento. |
| create_date | DATE | Fecha de creación del cliente en el CRM. |

---

## gold.dim_products

Dimensión de productos. Solo incluye la **versión actual** de cada producto
(sin historial). Una fila por producto.

| Columna | Tipo | Descripción |
|---|---|---|
| product_key | BIGINT | Clave subrogada del producto. |
| product_id | INT | Identificador del producto en el CRM. |
| product_number | NVARCHAR(50) | Código del producto (ej. `BK-R93R-62`). |
| product_name | NVARCHAR(50) | Nombre descriptivo del producto. |
| category_id | NVARCHAR(50) | Código de categoría (ej. `BI_RB`). |
| category | NVARCHAR(50) | Categoría principal (ej. `Bikes`, `Accessories`). |
| subcategory | NVARCHAR(50) | Subcategoría (ej. `Road Bikes`). |
| maintenance | NVARCHAR(50) | Indica si requiere mantenimiento: `Yes` o `No`. |
| cost | INT | Costo del producto. |
| product_line | NVARCHAR(50) | Línea: `Mountain`, `Road`, `Touring`, `Other Sales` o `n/a`. |
| start_date | DATE | Fecha desde la que la versión actual está vigente. |

---

## gold.fact_sales

Tabla de hechos de ventas. Una fila por línea de pedido.

| Columna | Tipo | Descripción |
|---|---|---|
| order_number | NVARCHAR(50) | Número de pedido (ej. `SO43697`). |
| product_key | BIGINT | Clave del producto → `dim_products`. |
| customer_key | BIGINT | Clave del cliente → `dim_customers`. |
| order_date | DATE | Fecha del pedido. |
| shipping_date | DATE | Fecha de envío. |
| due_date | DATE | Fecha de vencimiento del pago. |
| sales_amount | INT | Monto total de la venta (`quantity × price`). |
| quantity | INT | Cantidad de unidades vendidas. |
| price | INT | Precio por unidad. |

---

## gold.report_sales

Vista plana del modelo estrella completo: une `fact_sales` con
`dim_customers` y `dim_products`. Una fila por venta, con los datos del
cliente y del producto. Se usa para reportes y para validar la arquitectura.

---

## Hallazgos de calidad de datos

- **Categoría `CO_PE`**: 7 productos tienen esta categoría en el CRM, pero
  no existe en el ERP. En `dim_products` quedan con `category`,
  `subcategory` y `maintenance` en `NULL`.
- **Clientes duplicados**: el CRM traía 5 clientes duplicados y 4 filas sin
  identificador. En Silver se conservó el registro más reciente.
- **Ventas inconsistentes**: 33 ventas con montos o precios vacíos,
  negativos o mal calculados se recalcularon en Silver.
