# Marketing Analytics Engineering Pipeline 🚀

Analytics engineering project built on the **Criteo Attribution Dataset**, focusing on campaign-level performance and attribution analysis.

The project follows a production-style analytics workflow and is currently implemented up to the **Python ingestion and preparation stage**.

* * *

## Key environment 🔧

- **Python:** 3.11.9
    
- **Dataset access:** Hugging Face `datasets` package

* * *

## How to run project ⚡

1. Create & activate virtual environment (Windows):
python -m venv .venv && .venv\Scripts\activate

2. Install Python dependencies:
pip install -r requirements.txt

3. Run notebooks in order:
- 01_explore_raw.ipynb
- 03_batch_and_export.ipynb

Note:  
`02_clean_prepare.ipynb` documents the cleaning logic, but the actual preparation code is implemented as a reusable module in `src/clean_prep.py` and is imported directly by `03_batch_and_export.ipynb`.   

* * *

## Data preparation (Python) ✨

Performed using Pandas and a reusable preparation module.

Key steps:

- Raw dataset inspection and schema validation
    
- Removal of ML-specific and funnel-level columns
    
- Sentinel value handling (`-1 → NULL`)
    
- Stable dtype enforcement (nullable booleans and integers)
    
- Timestamp-based batching strategy
    
- Export of load-ready Parquet files  

Prepared data artifacts are generated locally and intentionally excluded from version control.

* * *

## Dataset citation 📖

This project uses the **Criteo Attribution Dataset**, published with the following paper:

> Eustache, D., Meynet, J., Galland, P., & Lefortier, D. (2017).  
> *Attribution Modeling Increases Efficiency of Bidding in Display Advertising*.  
> Proceedings of the AdKDD and TargetAd Workshop, KDD 2017, Halifax, NS, Canada.

* * *

## Author

Ragha  
Analytics Engineering Portfolio Project