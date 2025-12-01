# 7. Selecting and dropping variables using select() in R. 

library(dplyr)

# 1. IMPORT DATASET

country_data <- read.csv("ESGCountry.csv")

print("--- Original Dataset (First 3 rows and selected columns) ---")
print(head(country_data[, c("Country.Code", "Short.Name", "Region", "Income.Group")], 3))

# 2. SELECTING VARIABLES 

selected_cols <- country_data %>%
  select(Country.Code, Short.Name, Region, Income.Group)

print("--- Selected Specific Columns (Country ID, Name, Region, Income Group) ---")
print(head(selected_cols, 3))

# Method B: Select a range of adjacent columns
range_cols <- country_data %>%
  select(Short.Name:Income.Group)

print("--- Selected Range of Columns (Short.Name to Income.Group) ---")
print(head(range_cols, 3))

# Method C: Select using helper functions (e.g., starts_with)
starts_with_l <- country_data %>%
  select(starts_with("L"))

print("--- Selected columns starting with 'L' ---")
print(names(starts_with_l))
print(head(starts_with_l, 3))

# 3. DROPPING VARIABLES (Removing Columns) 

# FIX APPLIED: The blank column header is the 31st column, so it is named X31.
dropped_one <- country_data %>%
  select(-31)

print("--- Dataset with 'X31' dropped ---")

print(paste("Original count:", ncol(country_data), " | New count:", ncol(dropped_one)))

# Method B: Drop multiple columns
dropped_multiple <- country_data %>%
  select(-Table.Name, -X2.alpha.code) 

print("--- Dataset with 'Table.Name' and '2.alpha.code' dropped ---")
print(names(dropped_multiple))

# Method C: Drop a range of columns
dropped_range <- country_data %>%
  select(-(National.accounts.base.year:Other.groups))

print("--- Dataset with range 'National.accounts.base.year' to 'Other.groups' dropped ---")
print(names(dropped_range))
