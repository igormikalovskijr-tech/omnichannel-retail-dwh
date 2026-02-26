# Omnichannel Retail Data Warehouse
1. Executive Summary

This project implements a modern end-to-end ELT pipeline that unifies Shopify e-commerce sales and Walmart in-store transactions into a centralized Snowflake data warehouse.

Built using dbt Core, the solution follows a layered architecture (staging → intermediate → marts), enforces strict data validation standards, and exposes business-ready analytical models optimized for executive reporting and BI consumption.

The platform enables:

- Reliable cross-channel revenue analysis
- Customer behavior insights
- Market basket analytics
- Automated reconciliation
- Data-driven pricing and promotion strategies

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

-- Staging Layer

 - Cleans and standardizes raw Shopify and Walmart data.
 - Applies consistent naming and data typing.

-- Intermediate Layer

Technical transformation logic separated from business-facing marts.

Models:

- int_sales_unified
  
   Consolidates Shopify and Walmart transactions using UNION ALL.

- int_customer_channel_usage
  
   Identifies cross-channel vs single-channel customers.
  
- int_product_pair
  
   Identifies product category combinations purchased by the same customers.

This layer improves:

- Maintainability
- Reusability
- Scalability
- Testability

-- Mart Layer (Consumption Layer)

Business-facing analytical models optimized for BI:

- fct_sales_enriched
- fct_sales_daily
- mart_customer_channel_behavior
- mart_market_basket

-- Audit Layer

- audit_sales_reconciliation
- Ensures:
  
  - Shopify revenue + Walmart revenue = Unified revenue
  - Record counts reconcile across sources

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

-int_sales_unified

Maintains standardized fields:

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

6. Advanced Analytics: Market Basket Analysis

An advanced analytical model was implemented to identify product category combinations frequently purchased by the same customers.

Flow:

fct_sales_enriched
    → int_product_pairs
        → mart_market_basket

Metric:
- times_bought_together

Business Impact:

- Enables cross-selling strategies
- Supports bundled promotions
- Improves inventory planning
- Identifies category affinity

This demonstrates the extension of the warehouse beyond reporting into behavioral analytics.

---
7. Data Quality Framework

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

8. Architectural Design Decision

The unified sales logic was intentionally moved to an intermediate layer (int_sales_unified) to separate technical consolidation logic from business-facing fact tables.

This improves:

- Maintainability
- Scalability
- Testability
- Layered clarity
- Alignment with enterprise dbt modeling standards

