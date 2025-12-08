library(dplyr)
library(tidyr)

# --- 1. SETUP: Read and Clean Cancer Data ---
df <- read.csv("Cancer.dataset.csv") %>%

    select(-matches("Unnamed"))

df_subset <- df %>%
  select(id, diagnosis, ends_with("_mean"))

print("--- 1. Original Wide Data (Subset) ---")
print(head(df_subset, 3))

# 2. PIVOT_LONGER (Wide to Long)
df_long <- df_subset %>%
  pivot_longer(
    cols = ends_with("_mean"),  
    names_to = "Measurement_Type", 
    values_to = "Value"
  )

print("--- 2. Long Format (pivot_longer) ---")
print(head(df_long, 10))

# 3. PIVOT_WIDER (Long to Wide)
df_wide_recreated <- df_long %>%
  pivot_wider(
    names_from = Measurement_Type,
    values_from = Value 
  )

print("--- 3. Wide Format (Back to Original) ---")
print(head(df_wide_recreated, 3))

