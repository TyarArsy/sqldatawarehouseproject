# 🏆 **Gold Layer Data Catalog**

## 🧭 **Overview**
The **Gold Layer** represents the **business-ready** layer of the data warehouse.  
It integrates data from the **Silver Layer** into well-structured **dimension** and **fact tables**, optimized for analytics, dashboards, and reporting.

---

## 💠 **Table: gold.dim_customers**
> 📘 **Purpose:** Stores enriched customer information by combining CRM and ERP data sources.

| 🧾 Column Name | 🧱 Data Type | 💬 Description |
|----------------|--------------|----------------|
| `customer_key` | INT | Surrogate key uniquely identifying each customer record in the dimension table. |
| `customer_id` | INT | Original customer ID from the CRM system. |
| `customer_number` | NVARCHAR(50) | Alphanumeric code used to reference the customer across systems. |
| `first_name` | NVARCHAR(50) | The customer’s first name. |
| `last_name` | NVARCHAR(50) | The customer’s last or family name. |
| `country` | NVARCHAR(50) | Country of residence (e.g., `Germany`, `United States`). |
| `marital_status` | NVARCHAR(50) | Marital status of the customer (`Single`, `Married`, `n/a`). |
| `gender` | NVARCHAR(50) | Gender information (`Male`, `Female`, `n/a`). |
| `birthdate` | DATE | The customer’s date of birth. |
| `create_date` | DATE | The date the record was created in the CRM system. |

---

## 📦 **Table: gold.dim_products**
> 🧾 **Purpose:** Stores standardized product details and category attributes, combining CRM and ERP product data.

| 🧾 Column Name | 🧱 Data Type | 💬 Description |
|----------------|--------------|----------------|
| `product_key` | INT | Surrogate key uniquely identifying each product. |
| `product_id` | INT | Original product ID from the CRM source. |
| `product_number` | NVARCHAR(50) | Alphanumeric code used to identify the product. |
| `product_name` | NVARCHAR(50) | The product’s descriptive name. |
| `category_id` | NVARCHAR(50) | Category reference key derived from ERP data. |
| `category` | NVARCHAR(50) | Product category (e.g., `Bikes`, `Accessories`). |
| `subcategory` | NVARCHAR(50) | Detailed classification within the main category (e.g., `Road`, `Mountain`). |
| `maintenance_required` | NVARCHAR(50) | Indicates whether maintenance is required (`Yes`, `No`, or `n/a`). |
| `cost` | INT | The cost or base price of the product. |
| `product_line` | NVARCHAR(50) | Product line name (e.g., `Road`, `Touring`, `Mountain`). |
| `start_date` | DATE | The product’s start availability date. |

---

## 💰 **Table: gold.fact_sales**
> 📊 **Purpose:** Stores transactional sales facts, linking customers and products for analytical reporting.

| 🧾 Column Name | 🧱 Data Type | 💬 Description |
|----------------|--------------|----------------|
| `order_number` | NVARCHAR(50) | Unique identifier for each sales order. |
| `product_key` | INT | Foreign key referencing `dim_products.product_key`. |
| `customer_key` | INT | Foreign key referencing `dim_customers.customer_key`. |
| `order_date` | DATE | Date when the order was placed. |
| `shipping_date` | DATE | Date when the order was shipped. |
| `due_date` | DATE | Date when the payment for the order was due. |
| `sales_amount` | INT | Total sales value for the order line. |
| `quantity` | INT | Number of items sold in the order line. |
| `price` | INT | Unit price of the sold item. |

---

## 🧩 **Relationships**
> 🧠 **Fact-Dimension Relationships:**
- `fact_sales.customer_key` → `dim_customers.customer_key`
- `fact_sales.product_key` → `dim_products.product_key`

These relationships enable slicing and dicing of sales metrics by customer, product, and geography.

---

## 🕓 **Refresh Strategy**
- **Source:** Derived from Silver Layer tables (`silver.crm_*`, `silver.erp_*`)
- **Frequency:** Daily batch load via stored procedure `gold.load_gold`
- **Purpose:** To provide the latest business metrics for analysis and dashboards.

---

## ✨ **Summary**
The Gold Layer serves as the semantic layer of the data warehouse — transforming standardized data from the Silver Layer into a business-oriented model.
It supports reporting, dashboards, and advanced analytics focused on customer insights, product performance, and sales metrics.
