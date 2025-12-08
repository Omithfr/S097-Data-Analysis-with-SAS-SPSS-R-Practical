library(dplyr)
library(lubridate)

# --- 1. SETUP: Load and Simulate Dates ---
df <- read.csv("Cancer.dataset.csv") %>%
  select(id, diagnosis) %>%
  # Simulate a random diagnosis date for each patient within the year 2023
  mutate(
    Diagnosis_Date = as.Date("2023-01-01") + sample(0:364, n(), replace=TRUE)
  )

print("--- Data with Simulated Dates ---")
print(head(df, 3))

# 2. EXTRACT DATE COMPONENTS
df_dates_extracted <- df %>%
  mutate(
    Year = year(Diagnosis_Date),
    Month_Name = month(Diagnosis_Date, label = TRUE, abbr = FALSE),
    Week_Num = isoweek(Diagnosis_Date),
    Weekday = wday(Diagnosis_Date, label = TRUE)
  ) %>%
  select(id, Diagnosis_Date, Month_Name, Weekday)

print("--- Extracted Date Components ---")
print(head(df_dates_extracted, 5))

