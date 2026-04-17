import pandas as pd

df = pd.read_csv(
    "/Users/maksym_yakushev/Documents/Career Practice/GitHub Projects/store_analysis/data/raw/sample_superstore_fixed.csv",
    engine="python",
    on_bad_lines="skip"  
)

df = df.replace({r'\n': ' ', r'\r': ' '}, regex=True)

df.to_csv("/Users/maksym_yakushev/Documents/Career Practice/GitHub Projects/store_analysis/data/raw/cleaned_superstore_v2.csv", index=False)