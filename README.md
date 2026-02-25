# Omnichannel Retail Data Warehouse
1. Executive Summary

This project implements a modern end-to-end ELT pipeline that unifies Shopify e-commerce sales and Walmart in-store transactions into a centralized Snowflake data warehouse.

The solution leverages dbt Core for transformations, enforces strict data validation standards, and exposes a clean star schema optimized for business intelligence and executive reporting.

The final output enables reliable cross-channel revenue analysis, operational transparency, and automated daily reporting.

---

2. Business Problem

A mid-sized retailer operates:

- An online store (Shopify)

- Physical stores (Walmart sales dataset)

Sales data exists in separate systems, creating:

- Manual reconciliation effort

- Limited visibility across channels

- Inconsistent reporting

- Delayed business insights

This project eliminates data silos and builds a unified, automated analytics layer.

---

3. Solution Architecture
   
### Data Flow

Raw Data
→ Snowflake Staging 
→ dbt Transformations 
→ Intermediate Layer
→ Star Schema (Marts)
→ Looker Studio Dashboard

### Architectural Layers

Staging Layer

 - Cleans and standardizes raw Shopify and Walmart data.

Intermediate Layer

- int_sales_unified

- Consolidates cross-channel transactions before enrichment.

- Separates technical transformation logic from business-facing models.

Mart Layer (Consumption Layer)

- Optimized star schema for BI consumption.

Audit Layer

- Reconciliation logic to ensure full alignment across channels.

___

4. Technology Stack

| Layer           | Tool                           |
| --------------- | ------------------------------ |
| Data Warehouse  | Snowflake                      |
| Transformation  | dbt Core                       |
| Testing         | dbt built-in tests + dbt_utils |
| Version Control | Git & GitHub                   |
| Documentation   | dbt Docs                       |
| BI Layer        | Looker Studio                  |

---

5. Data Modeling Approach

The warehouse follows a layered architecture aligned with enterprise dbt best practices.

Fact Tables (Business-Facing)

- fct_sales_enriched

- fct_sales_daily

- fct_sales_shopify

- fct_sales_walmart

Intermediate Model

- int_sales_unified

  - Consolidates Shopify and Walmart transactions using UNION ALL.

  - Maintains standardized fields across channels.

Dimension Tables

- dim_product

- dim_store

- dim_customer

- dim_date

Standardized Fields in Unified Model

- transaction_id

- customer_id

- product_id

- store_id

- sale_date

- quantity

- total_revenue

- sales_channel

This structure ensures consistent cross-channel aggregation and simplified reporting logic.

---

6. Data Quality Framework

Robust validation was implemented to ensure production-grade reliability.

Integrity Checks

- Primary key uniqueness

- Not-null constraints

- Referential integrity (fact → dimension relationships)

Business Rule Validation

- sales_channel restricted to valid values (shopify, walmart)

- Revenue must be non-negative

- Quantity must be non-negative

Reconciliation Layer

An audit model ensures full alignment:

Walmart revenue + Shopify revenue = Unified revenue
Walmart records + Shopify records = Unified records

This guarantees complete data reconciliation across channels.

7. Architectural Design Decision

The unified sales logic was intentionally moved to an intermediate layer (int_sales_unified) to separate technical consolidation logic from business-facing fact tables.

This improves:

- Maintainability

- Scalability

- Testability

- Layered clarity

- Alignment with enterprise dbt modeling standards

