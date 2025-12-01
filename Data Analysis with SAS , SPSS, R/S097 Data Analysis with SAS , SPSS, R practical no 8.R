# R Script: Handling Missing Values (Data Cleaning)

library(dplyr)
library(tidyr) # Contains replace_na()

# 1. IMPORT DATASET

country_df <- read.csv("ESGCountry.csv", na.strings = c("", "NA"))

country_df <- country_df %>% 
  rename(alpha_2_code = X2.alpha.code) 

print("--- 1. Original Data (Selected Columns, First 6 Rows) ---")
print(head(country_df[, c("Short.Name", "Region", "Income.Group", "Latest.population.census", "PPP.survey.year")]))

print("--- Count of Missing Values per Column ---")
na_counts <- colSums(is.na(country_df))
print(na_counts[na_counts > 0])

# 2. METHOD A: REMOVE MISSING VALUES (na.omit)

omit_target_cols <- country_df %>%
  select(Short.Name, Region, Income.Group, Lending.category, PPP.survey.year)

clean_omit <- na.omit(omit_target_cols)

print("--- 2. Data after na.omit() ---")
print(paste("Original rows:", nrow(country_df)))
print(paste("Rows remaining:", nrow(clean_omit)))
print(head(clean_omit))


# 3. METHOD B: REPLACE MISSING VALUES (replace_na)

avg_census_year <- round(mean(as.numeric(as.character(country_df$Latest.population.census)), na.rm = TRUE))

median_ppp_year <- median(country_df$PPP.survey.year, na.rm = TRUE)

clean_replace <- country_df %>%
  replace_na(list(
    Income.Group = "Not Classified",
    Latest.population.census = as.character(avg_census_year),
    PPP.survey.year = median_ppp_year
  ))

print("--- 3. Data after replace_na() ---")
print(clean_replace[is.na(country_df$Income.Group) | is.na(country_df$PPP.survey.year), 
                    c("Short.Name", "Income.Group", "Latest.population.census", "PPP.survey.year")])
print(head(clean_replace[, c("Short.Name", "Income.Group", "Latest.population.census", "PPP.survey.year")]))

print("--- Remaining NAs after replacement ---")
na_counts_after <- colSums(is.na(clean_replace))
print(na_counts_after[c("Income.Group", "Latest.population.census", "PPP.survey.year")])

