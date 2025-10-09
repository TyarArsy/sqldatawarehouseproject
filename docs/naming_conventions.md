# **Naming Conventions**

This document defines the standardized naming conventions used across all layers (Bronze, Silver, and Gold) in the Data Warehouse project.  
Consistency in naming ensures clarity, maintainability, and scalability across ETL processes and business intelligence reports.

---

## **Table of Contents**

1. [General Principles](#general-principles)
2. [Table Naming Conventions](#table-naming-conventions)
   - [Bronze Rules](#bronze-rules)
   - [Silver Rules](#silver-rules)
   - [Gold Rules](#gold-rules)
3. [Column Naming Conventions](#column-naming-conventions)
   - [Surrogate Keys](#surrogate-keys)
   - [Technical Columns](#technical-columns)
4. [Stored Procedure Naming Conventions](#stored-procedure-naming-conventions)

---

## **General Principles**

- Use **snake_case** for all names.  
  Example: `crm_sales_detail`, not `CrmSalesDetail`.
- Use **English** for all identifiers.
- Avoid **SQL reserved words** (e.g., `order`, `select`, `table`).
- Be **descriptive but concise**.
- Maintain **consistency across schemas**.

---

## **Table Naming Conventions**

### **Bronze Rules**
The Bronze layer stores raw data directly from the source systems.

| Rule | Description | Example |
|------|--------------|----------|
| Prefix | Start with the source system name. | `crm_` or `erp_` |
| Format | `<source>_<table_name>` | `crm_sales_detail` |
| Naming | Use the **exact name from the source**. | `erp_loc_a101` |

**Example:**  
`bronze.crm_sales_detail` → Raw sales transaction data from the CRM source.

---

### **Silver Rules**
The Silver layer contains cleaned, standardized, and validated data.

| Rule | Description | Example |
|------|--------------|----------|
| Prefix | Same as Bronze (source name). | `crm_`, `erp_` |
| Format | `<source>_<entity>` | `crm_cust_info` |
| Naming | Keep logical consistency with Bronze, reflect cleansing stage. | `silver.crm_sales_details` |

**Example:**  
`silver.erp_loc_a101` → Cleaned and standardized location data from ERP.

---

### **Gold Rules**
The Gold layer is business-ready, organized into **fact** and **dimension** tables.

| Rule | Description | Example |
|------|--------------|----------|
| Prefix | Use `dim_` for dimension tables and `fact_` for fact tables. | `dim_`, `fact_` |
| Format | `<category>_<entity>` | `dim_customer`, `fact_sales` |
| Naming | Align with business logic and reporting context. | `dim_product`, `fact_sales` |

**Example:**  
`gold.fact_sales` → Sales fact table joining customers and products.  
`gold.dim_customer` → Dimension table containing consolidated customer data.

---

## **Column Naming Conventions**

### **Surrogate Keys**
Each dimension and fact table should use a surrogate key to uniquely identify rows.

| Rule | Description | Example |
|------|--------------|----------|
| Format | `<entity>_key` | `customer_key` |
| Purpose | Ensure unique identification within the warehouse. | Used in joins |
| Example | `dim_customer.customer_key` joins with `fact_sales.customer_key`. | ✔️ |

---

### **Technical Columns**

| Column | Purpose | Description |
|---------|----------|--------------|
| `dwh_create_date` | Metadata | Timestamp indicating when the record was inserted into the data warehouse. |
| `dwh_update_date` | Metadata | Timestamp indicating the last update to the record. |
| `dwh_load_id` | Batch Tracking | Optional column to track ETL batch loads. |

**Rule:** All technical metadata columns must begin with the prefix `dwh_`.

---

## **Stored Procedure Naming Conventions**

Stored procedures manage ETL and transformation logic between layers.

| Rule | Description | Example |
|------|--------------|----------|
| Format | `load_<layer>` | `load_bronze`, `load_silver`, `load_gold` |
| Action Naming | If specific to a table or subject area, use `load_<layer>_<subject>`. | `load_silver_sales` |
| Schema Placement | Stored procedure should reside in the same schema as its target layer. | `silver.load_silver` |

---

## **Summary**

| Object Type | Format | Example |
|--------------|---------|----------|
| Schema | Lowercase | `bronze`, `silver`, `gold` |
| Table | `<prefix>_<entity>` | `crm_sales_detail` |
| Column | `<entity>_<attribute>` | `customer_key`, `prd_id` |
| Technical Column | `dwh_<attribute>` | `dwh_create_date` |
| Stored Procedure | `load_<layer>` | `load_silver` |

---

**Author:** Ilham M. Arsyad  
**Last Updated:** 2025-10-09  
**Version:** 1.0
