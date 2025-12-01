library(dplyr)

# 1. SETUP: Load and Prepare Data

country_data <- read.csv("ESGCountry.csv")
series_data  <- read.csv("ESGCountry-Series.csv")

country_list_1 <- head(country_data, 5) 
country_list_2 <- country_data[6:10, ]

print("--- Country List 1 (First 5) ---")
print(head(country_list_1[, c("Country.Code", "Short.Name")])) 

print("--- Country List 2 (Next 5) ---")
print(head(country_list_2[, c("Country.Code", "Short.Name")]))


# 2. MERGE (Joining Columns)

merged_data <- merge(
  country_data, 
  series_data, 
  by.x = "Country.Code", # Column name in first dataset
  by.y = "CountryCode"   # Column name in second dataset
)

print("--- Merged Data (Columns Added) ---")
print(head(merged_data[, c("Country.Code", "Short.Name", "SeriesCode", "DESCRIPTION")]))


# 3. APPEND (Stacking Rows)
final_list <- bind_rows(country_list_1, country_list_2)

print("--- Appended Data (Rows Added) ---")
print(final_list[, c("Country.Code", "Short.Name")])
