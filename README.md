&nbsp;

* * *

# Marketing Analytics Engineering Pipeline 🚀

**End-to-end analytics engineering project** demonstrating a modern marketing analytics pipeline using cloud-native tools.

**raw event data → Python (EDA & batching) → Snowflake → dbt → Power BI**

**Focus areas: incremental processing, clean modeling, attribution-aware analysis, and BI-ready datasets**


* * *

## Key environment 🔧

- **Python:** 3.11
    
- **Snowflake:** cloud data warehouse
    
- **dbt:** transformations & tests
    
- **Power BI:** Desktop (latest)

* * *

## Repository structure 📁

```text
.
├── notebooks/
│   ├── 01_explore_raw.ipynb
│   ├── 02_clean_prepare.ipynb
│   └── 03_batch_and_export.ipynb
├── src/
│   └── clean_prep.py
├── snowflake/
│   ├── setup.sql
│   ├── schema.sql
│   ├── load_raw.sql
│   ├── test_incremental_load_progress.sql
│   └── test_no_duplicate_daily_keys.sql
├── criteo_dbt/
│   ├── dbt_project.yml
│   ├── packages.yml
│   ├── package-lock.yml
│   ├── models/
│   │   ├── staging/
│   │   │   ├── sources.yml
│   │   │   ├── schema.yml
│   │   │   └── stg_criteo_impressions.sql
│   │   └── marts/
│   │       ├── fct_campaign_daily.sql
│   │       ├── fct_overall_daily.sql
│   │       ├── schema.yml
│   │       └── exposures.yml
│   └── tests/
│       ├── test_fct_campaign_daily_sanity.sql
│       ├── test_fct_overall_daily_sanity.sql
│       └── test_stg_attributed_requires_conversion.sql
├── dashboards/
│   ├── criteo_dashboard.pbix
│   └── criteo_dashboard.pdf  
├── ETL_RUN_LOG.md
├── requirements.txt
├── README.md
└── .gitignore
```

* * *

## Dataset citation 📖

The dataset is used as a single raw source and already contains pre-attributed conversion fields.
This project uses the **Criteo Attribution Dataset**, published with the following paper:

> Eustache, D., Meynet, J., Galland, P., & Lefortier, D. (2017).  
> *Attribution Modeling Increases Efficiency of Bidding in Display Advertising*.  
> Proceedings of the AdKDD and TargetAd Workshop, KDD 2017, Halifax, NS, Canada.

* * *
## Data preparation (Python) ✨

Python is used for **exploratory analysis, sanity checks, and batch preparation**, not business logic.

Workflow:

- **`01_explore_raw.ipynb`**
    
    - dataset exploration
        
    - schema inspection
        
    - sanity checks (duplicates, field stability)
        
- **`02_clean_prepare.ipynb`**
    
    - documents the cleaning and preparation logic
        
    - serves as a readable reference
        
- **`03_batch_and_export.ipynb`**
    
    - orchestrates batch splitting to simulate incremental loads
        
    - applies cleaning logic via the reusable module in `src/clean_prep.py`
        
    - enforces stable dtypes (e.g. nullable booleans)
        
    - removes ML-only and funnel-specific columns
        
    - exports batches for warehouse ingestion
        

All reusable logic is implemented in **`src/clean_prep.py`**.  
No business logic or attribution logic is implemented in Python.

* * *

## Warehouse & modeling (Snowflake + dbt) 🧩

### Snowflake

- Raw data ingested via **incremental append**
    
- SQL scripts:
    
    - `setup.sql` – warehouse, database, schema setup
        
    - `schema.sql` – raw table definitions
        
    - `load_raw.sql` – incremental ingestion
        
- Validation queries:
    
    - `test_incremental_load_progress.sql`
        
    - `test_no_duplicate_daily_keys.sql`
        

These tests validate **incremental correctness and idempotency**.

* * *

### dbt

- Layers: **staging → marts**
    
- Staging:
    
    - normalization of raw impressions data
        
    - schema enforcement and basic constraints
        
- BI-ready marts:
    
    - `fct_campaign_daily`
        
    - `fct_overall_daily`
        
- Core measures modeled upstream:
    
    - impressions, clicks, conversions
        
    - spend, attributed conversions, attributed value
        
- Tests validate:
    
    - daily grain correctness
        
    - consistency between attributed and non-attributed measures
        

The dataset provides **pre-attributed measures**, which are preserved and exposed for downstream analysis.

#### dbt lineage graph
This graph shows the full transformation flow from raw sources → staging → marts (BI-ready layer).

Generated via `dbt docs generate`:

![dbt Lineage Graph](images/dbt-dag.png)

* * *

## Dashboard (Power BI) 📊

The Power BI dashboard is built **directly on dbt marts** and structured as a **three-page analytical narrative**.

### 1 – Executive Overview

High-level monitoring of spend, volume, and efficiency.
![Executive Overview](images/dashboard_1.png)

### 2 – Campaign Performance

Campaign-level efficiency analysis including spend, CPA, and attributed CPA.
![Campaign Performance](images/dashboard_2.png)

### 3 – Attribution & Overexposure

Analysis of **attributed vs non-attributed performance**, reach vs exposure, and over-targeting signals.
![Attribution & Overexposure](images/dashboard_3.png)


* * *

### DAX & semantic layer

DAX is intentionally limited to simple KPI derivations and presentation-layer calculations.Core measures and aggregations are defined upstream (dbt).

This enforces a clean separation:

- **dbt → single source of truth**
    
- **Power BI → analytics & visualization**
    

* * *

## Versioning & milestones 🏷️

| Version | Description |
|------|------------|
| **python-v1.0** | EDA, sanity checks, batching, and export logic |
| **snowflake-v1.0** | Data warehouse schema and incremental load validation |
| **dbt-v1.0** | BI-ready marts finalized |
| **powerbi-v1.0** | Dashboard complete |
| **v1.0.0** | End-to-end pipeline complete |

## Author

Ragha, Junior Analytics Engineer (Analytic Engineering & BI) | Berlin, Germany