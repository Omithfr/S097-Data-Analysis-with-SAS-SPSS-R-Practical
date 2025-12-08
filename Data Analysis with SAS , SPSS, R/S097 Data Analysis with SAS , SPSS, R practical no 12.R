# R Script: Vertical Concatenation using rbind() / bind_rows()
library(dplyr)

# --- 1. SETUP: Load Data ---
df <- read.csv("Cancer.dataset.csv") %>%
  select(id, diagnosis, radius_mean, texture_mean)

# --- 2. Create Two Separate Datasets ---
df_batch_1 <- head(df, 5)

df_batch_2 <- data.frame(
  id = c(999001, 999002),
  diagnosis = c("M", "B"),
  radius_mean = c(15.50, 12.30),
  texture_mean = c(20.10, 18.50)
)

print("--- Data Structure Check ---")
print(names(df_batch_1))
print(names(df_batch_2))

# 3. VERTICAL COMBINATION
combined_data <- bind_rows(df_batch_1, df_batch_2)

print("--- Combined Data Summary ---")
print(paste("Batch 1 rows:", nrow(df_batch_1)))
print(paste("Batch 2 rows:", nrow(df_batch_2)))
print(paste("Total Combined rows:", nrow(combined_data)))

print("--- Preview (Bottom rows show the new batch) ---")
print(tail(combined_data))

