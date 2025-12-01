# R Script: Text Manipulation with stringr (Adapted for ESGCountry.csv)
library(stringr)
library(tidyr)
library(dplyr)

# 1. IMPORT DATASET

country_df <- read.csv("ESGCountry.csv")

country_df <- country_df %>% 
  rename(alpha_2_code = X2.alpha.code) 

print("--- Original Dataset (Key Columns) ---")
print(head(country_df[, c("Country.Code", "Long.Name", "Latest.household.survey")], 5))


# 2. USING str_sub() (Substring)

country_df$Prefix_5 <- str_sub(country_df$Long.Name, 1, 5)

country_df$Suffix_5 <- str_sub(country_df$Long.Name, -5, -1)

print("--- Data after str_sub() ---")
print(country_df %>% select(Long.Name, Prefix_5, Suffix_5) %>% head(5))


# 3. USING str_split() (Split String)

# Method B: Split Fixed (Returns a matrix, easier to assign to columns)
split_matrix <- str_split(country_df$Latest.household.survey, ", ", simplify = TRUE)

country_df$Survey_Type <- split_matrix[, 1] # Text before the comma
country_df$Survey_Detail <- split_matrix[, 2] # Text after the comma

print("--- Data after str_split() (Manual Assignment) ---")
print(country_df %>% select(Latest.household.survey, Survey_Type, Survey_Detail) %>% head(5))


# 4. BONUS: The "Tidy" Way (separate)

tidy_data <- country_df %>%
  separate(Long.Name, 
           into = c("Status_1", "Status_2", "Rest_of_Name"), 
           sep = " ", 
           extra = "merge", # Merges all remaining parts into the last column
           remove = FALSE) # Keep the original Long.Name column

print("--- Bonus: The 'separate' function (easier splitting) ---")
print(tidy_data %>% select(Long.Name, Status_1, Status_2, Rest_of_Name) %>% head(5))

