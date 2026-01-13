from __future__ import annotations

from datasets import load_dataset
import pandas as pd


DROP_COLS = ["cat1","cat2","cat3","cat4","cat5","cat6","cat7","cat8","cat9","time_since_last_click","click_pos","click_nb",]
NEG_TO_NULL_COLS = ["conversion_timestamp", "conversion_id"]
BOOL_COLS = ["click", "conversion", "attribution"]


def load_criteo_raw(split: str = "train") -> pd.DataFrame:
    ds = load_dataset("criteo/criteo-attribution-dataset")
    return ds[split].to_pandas()


def clean_criteo(df: pd.DataFrame) -> pd.DataFrame:
    df_clean = df.drop(columns=DROP_COLS).copy()
    df_clean[NEG_TO_NULL_COLS] = df_clean[NEG_TO_NULL_COLS].mask(df_clean[NEG_TO_NULL_COLS] < 0)
    df_clean[BOOL_COLS] = df_clean[BOOL_COLS].astype("boolean")
    df_clean[NEG_TO_NULL_COLS] = df_clean[NEG_TO_NULL_COLS].astype("Int64")
    return df_clean


def load_and_clean(split: str = "train") -> pd.DataFrame:
    df = load_criteo_raw(split=split)
    return clean_criteo(df)