library(dplyr)

# --- 1. SETUP: Load Data ---
df <- read.csv("Cancer.dataset.csv") %>%
  select(id, diagnosis, radius_mean)

# 2. CHECK FOR DUPLICATES
duplicate_check <- df %>%
  group_by(id) %>%
  count() %>%
  filter(n > 1)

print("--- 2. Duplicate Check Report ---")
if(nrow(duplicate_check) == 0) {
  print("No duplicate Patient IDs found in the original file.")
} else {
  print(duplicate_check)
}

# 3. HANDLING DUPLICATES (Example)
unique_diagnoses <- df %>%
  distinct(diagnosis)

print("--- 3. Unique Diagnoses ---")
print(unique_diagnoses)

unique_radius <- df %>%
  distinct(radius_mean, .keep_all = TRUE)

print("--- 4. Unique Radius Measurements ---")
print(paste("Original rows:", nrow(df), "| Unique Radius rows:", nrow(unique_radius)))

