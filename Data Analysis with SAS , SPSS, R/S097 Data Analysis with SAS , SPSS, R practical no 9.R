# R Script: Creating New Variables (Transformations & Calculations)

library(dplyr)
library(tidyr)

# 1. SETUP:  Import the Dataset and Clean for Calculation

df <- read.csv("ESGCountry.csv", na.strings = c("", "NA"))

# 1. Convert year columns to numeric (handling non-numeric text which becomes NA).
# 2. Fill NAs with the median for the year columns and a placeholder for text.
df_clean <- df %>%
  mutate(
    Latest.population.census = as.numeric(as.character(Latest.population.census)),
    PPP.survey.year = as.numeric(as.character(PPP.survey.year))
  ) %>%
  mutate(
    Latest.population.census = replace_na(Latest.population.census, median(Latest.population.census, na.rm = TRUE)),
    PPP.survey.year = replace_na(PPP.survey.year, median(PPP.survey.year, na.rm = TRUE)),
    Income.Group = replace_na(Income.Group, "Not Reported")
  )

print("--- Cleaned Baseline Data ---")
print(head(df_clean %>% select(Short.Name, Income.Group, Latest.population.census, PPP.survey.year)))

# 2. METHOD A: ARITHMETIC CALCULATIONS

df_calc <- df_clean %>%
  mutate(
    Census_Data_Age = 2025 - Latest.population.census,
    Survey_Year_Gap = Latest.population.census - PPP.survey.year
  )

print("--- Method A: Arithmetic Results (Data Age & Gap) ---")
print(df_calc %>% select(Short.Name, Latest.population.census, PPP.survey.year, Census_Data_Age, Survey_Year_Gap) %>% head())

# 3. METHOD B: CONDITIONAL LOGIC (ifelse)

df_logic <- df_clean %>%
  mutate(
    Data_Age_Flag = ifelse(PPP.survey.year < 2000, "Outdated PPP Data", "Recent PPP Data"),
    Lending_Risk_Level = ifelse(Income.Group == "Low income", "High Risk", "Moderate/Low Risk")
  )

print("--- Method B: Logic Results (Labels) ---")
print(df_logic %>% select(Short.Name, PPP.survey.year, Data_Age_Flag, Income.Group, Lending_Risk_Level) %>% head())

# 4. METHOD C: TEXT TRANSFORMATION (paste)

df_text <- df_clean %>%
  mutate(
    Lending.category = replace_na(Lending.category, "Unspecified"),
    Region_Summary = paste("Country in the", Region, "region with", Lending.category, "lending.")
  )

print("--- Method C: Text Transformation ---")
print(head(df_text$Region_Summary))

# 5. ALL TOGETHER (The Standard Workflow)

final_dataset <- df_clean %>%
  mutate(
    # Calc 1: Gap calculation
    Survey_Gap = Latest.population.census - PPP.survey.year,
    # Calc 2: Is the survey gap large?
    Has_Large_Gap = ifelse(Survey_Gap > 10, TRUE, FALSE),
    # Calc 3: Final combined status report
    Status_Report = paste0("Region: ", Region, " | Income: ", Income.Group, " | Gap: ", Survey_Gap)
  )

print("--- Final Combined Dataset ---")
print(head(final_dataset %>% select(Short.Name, Income.Group, Survey_Gap, Has_Large_Gap, Status_Report)))