# 1. Clear Environment

rm(list = ls())

# 2. Read Dataset

cancer_data <- read.csv("Cancer.dataset.csv")

# 3. View Dataset Structure and Data

print("--- 3. Data Structure (str) ---")
str(cancer_data)
print("\n--- 3. Data Head ---")
head(cancer_data)

# 4. Data Preparation (Select Paired Variables and Remove Missing Values)

data_paired <- cancer_data[c("radius_mean", "radius_worst")]

data_paired <- na.omit(data_paired)


# 5. Paired t-Test

paired_ttest <- t.test(
  data_paired$radius_mean,        # Group 1: Average Radius
  data_paired$radius_worst,       # Group 2: Largest Radius
  paired = TRUE, 
  alternative = "less",           # Tests if Group 1 mean is less than Group 2 mean
  conf.level = 0.95
)

# 6. Display Result

print("\n--- 6. Paired t-Test Results (Mean vs. Worst Radius) ---")
print(paired_ttest)
