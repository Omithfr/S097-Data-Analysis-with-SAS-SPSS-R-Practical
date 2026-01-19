
library(dplyr)
library(tidyr)


df <- read.csv("ESGCountry.csv", na.strings = c("", "NA"))

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


df_calc <- df_clean %>%
  mutate(
    Census_Data_Age = 2025 - Latest.population.census,
    Survey_Year_Gap = Latest.population.census - PPP.survey.year
  )

print("--- Method A: Arithmetic Results (Data Age & Gap) ---")
print(df_calc %>% select(Short.Name, Latest.population.census, PPP.survey.year, Census_Data_Age, Survey_Year_Gap) %>% head())


df_logic <- df_clean %>%
  mutate(
    Data_Age_Flag = ifelse(PPP.survey.year < 2000, "Outdated PPP Data", "Recent PPP Data"),
    Lending_Risk_Level = ifelse(Income.Group == "Low income", "High Risk", "Moderate/Low Risk")
  )

print("--- Method B: Logic Results (Labels) ---")
print(df_logic %>% select(Short.Name, PPP.survey.year, Data_Age_Flag, Income.Group, Lending_Risk_Level) %>% head())


df_text <- df_clean %>%
  mutate(
    Lending.category = replace_na(Lending.category, "Unspecified"),
    Region_Summary = paste("Country in the", Region, "region with", Lending.category, "lending.")
  )

print("--- Method C: Text Transformation ---")
print(head(df_text$Region_Summary))


final_dataset <- df_clean %>%
  mutate(
    Survey_Gap = Latest.population.census - PPP.survey.year,
    Has_Large_Gap = ifelse(Survey_Gap > 10, TRUE, FALSE),
    Status_Report = paste0("Region: ", Region, " | Income: ", Income.Group, " | Gap: ", Survey_Gap)
  )

print("--- Final Combined Dataset ---")

print(head(final_dataset %>% select(Short.Name, Income.Group, Survey_Gap, Has_Large_Gap, Status_Report)))
