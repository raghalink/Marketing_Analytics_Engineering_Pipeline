# ETL Run Log – Marketing Analytics Engineering Pipeline (Pre-Warehouse)

This document records executed **data ingestion and preparation runs** for the Criteo Attribution Analytics project **prior to loading data into Snowflake and dbt modeling**.

All steps below were executed successfully and validated locally.

* * *

## ▶ Run 1 — Raw Dataset Exploration & Preparation

**Date:** 2026-01-13  
**Environment:** Local (Python / Pandas)  
**Source:** Hugging Face – Criteo Attribution Dataset (see readme for full citation)  
**Dataset:** `criteo/criteo-attribution-dataset`

* * *

## 1️⃣ Extraction

- Dataset loaded programmatically using the Hugging Face `datasets` package
    
- No manual downloads required
    
- Dataset loaded into memory as a Pandas DataFrame
    

**Notebook:**

- `01_explore_raw.ipynb`

**Key characteristics observed:**

- ~16.5M rows (ad impressions), 45k conversions and 700 campaigns
    
- Dataset sorted by `timestamp` (monotonic increasing)
    
- One row per ad impression
    
- Binary outcome flags (`click`, `conversion`, `attribution`)
    
- Anonymous categorical features (`cat1–cat9`) intended for ML use
    

* * *

## 2️⃣ Exploration & Validation (Python / Pandas)

Performed in `01_explore_raw.ipynb`.

### Validation checks

- Inspected schema, dtypes, and row counts
    
- Verified `timestamp` range for batching strategy
    
- Reviewed distributions of key flags:
    
    - `click`
        
    - `conversion`
        
    - `attribution`
        
- Confirmed absence of a natural primary key
    
- Identified sentinel values (`-1`) in conversion metadata columns
    

* * *

## 3️⃣ Cleaning & Preparation

Performed in `02_clean_prepare.ipynb` using a reusable Python module.

**Reusable module:**

- `src/clean_prep.py`

### Cleaning decisions

- Dropped ML-only and funnel-specific columns:
    
    - `cat1–cat9`
        
    - `click_pos`
        
    - `click_nb`
        
    - `time_since_last_click`
        
- Replaced sentinel values:
    
    - `conversion_timestamp = -1 → NULL`
        
    - `conversion_id = -1 → NULL`
        
- Enforced stable and semantically correct dtypes:
    
    - `click`, `conversion`, `attribution` → nullable boolean
        
    - identifier fields → integer
        
    - cost fields → float
        
- No aggregation or business logic applied (ELT approach)
    

### Validation

- Verified null counts after sentinel replacement
    
- Confirmed no remaining negative values in conversion metadata
    
- Final schema validated via `df.info()`
    

* * *

## 4️⃣ Batching & Export (Load-Ready Artifacts)

Performed in `03_batch_and_export.ipynb`.

### Batching strategy

- Dataset assumed sorted by `timestamp` (source guarantee)
  
- Created:
    
    - **Sample dataset**: first 200,000 rows (for development & testing)
        
    - **Three chronological batches** from remaining data using timestamp quantiles
        
- Batches designed to simulate incremental data arrival in Snowflake

- The initial sample batch was intentionally kept small to validate schema, loading logic, and incremental behavior while controlling warehouse cost during development.  

### Outputs (not tracked in git)

- Parquet format (columnar, Snowflake-optimized):
    
    - `criteo_sample_200k.parquet`
        
    - `criteo_batch_1.parquet`
        
    - `criteo_batch_2.parquet`
        
    - `criteo_batch_3.parquet`
        

All exported files are written to the local `data/` directory and excluded from version control.

* * *

## 5️⃣ Notes

- This project follows an **ELT architecture**:
    
    - Python is used only for ingestion preparation and validation
        
    - No aggregations or KPIs are computed outside the warehouse
        
- Snowflake will act as the true raw and transformed data layer
    
- Parquet artifacts are ephemeral and regenerated as needed
    
- This run represents the **final pre-warehouse ingestion state**
    

* * *

## ▶ Next Steps

- Load Parquet batches into Snowflake `RAW` tables
    
- Validate row counts and timestamp ranges post-load
    
- Initialize dbt sources and staging models
    
- Implement incremental fact models and BI-ready marts
