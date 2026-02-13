Omnichannel Retail Data Warehouse
1. Executive Summary

This project implements a modern end-to-end ELT pipeline that unifies Shopify e-commerce sales and Walmart in-store transactions into a centralized Snowflake data warehouse.

The solution leverages dbt Core for transformations, enforces strict data validation standards, and exposes a clean star schema optimized for business intelligence and executive reporting.

The final output enables reliable cross-channel revenue analysis, operational transparency, and automated daily reporting.

2. Business Problem

A mid-sized retailer operates:

An online store (Shopify)

Physical stores (Walmart sales dataset)

Sales data exists in separate systems, creating:

Manual reconciliation effort

Limited visibility across channels

Inconsistent reporting

Delayed business insights

This project eliminates data silos and builds a unified, automated analytics layer.

3. Solution Architecture
Data Flow

Raw Data → Snowflake Staging → dbt Transformations → Star Schema → Looker Studio Dashboard

Workflow Steps

Ingestion
Raw Shopify and Walmart data loaded into Snowflake staging tables

Transformation
Data cleaned, standardized, and modeled using dbt

Modeling
Star schema constructed for analytical performance

Validation
Automated data quality checks using dbt tests and dbt_utils

Visualization
Dashboard connected to Snowflake for real-time insights

| Layer           | Tool                           |
| --------------- | ------------------------------ |
| Data Warehouse  | Snowflake                      |
| Transformation  | dbt Core                       |
| Testing         | dbt built-in tests + dbt_utils |
| Version Control | Git & GitHub                   |
| Documentation   | dbt Docs                       |
| BI Layer        | Looker Studio                  |


5. Data Modeling Approach

The warehouse follows a star schema optimized for analytical queries.

Fact Tables

    fct_sales_shopify

    fct_sales_walmart

    fct_sales_unified

    fct_sales_daily

Dimension Tables

    dim_product

    dim_store

    dim_customer

    dim_date

Standardized Fields in Unified Fact

    product_id

    sale_date

    quantity

    revenue

    sales_channel

This ensures consistent cross-channel aggregation.

6. Data Quality Framework

Robust validation was implemented to ensure production-grade reliability.

Integrity Checks

Primary key uniqueness

Not-null constraints

Referential integrity (fact → dimension relationships)

Business Rule Validation

sales_channel restricted to valid values (shopify, walmart)

Revenue must be non-negative

Quantity must be non-negative

Reconciliation Layer

An audit model ensures full alignment:

Walmart revenue + Shopify revenue = Unified revenue
Walmart records + Shopify records = Unified records

This guarantees complete data reconciliation across channels.
