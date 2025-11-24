install.packages("dplyr")

library(dplyr)
library(readr) # For efficient reading

coffee_data <- read_csv("Daily Coffee Intake vs Sleep Duration.csv")

head(coffee_data)

# Example 1: Single Condition

high_sleep_subset <- subset(coffee_data, Sleep_Hours > 8)

cat("Number of people with high sleep (> 8 hours):", nrow(high_sleep_subset), "\n")
summary(high_sleep_subset$Sleep_Hours)

# Example 2: Multiple Conditions (AND)

relaxed_subset <- subset(coffee_data, Sleep_Hours > 8 & Stress_Level == "Low")

cat("Number of relaxed people (High Sleep & Low Stress):", nrow(relaxed_subset), "\n")
head(relaxed_subset)

brazil_or_caffeine_subset <- subset(coffee_data, Country == "Brazil" | Coffee_Intake > 4)

cat("Number of Brazil OR High Coffee Intake:", nrow(brazil_or_caffeine_subset), "\n")
head(brazil_or_caffeine_subset)

# Method 2: Using filter() (dplyr/Tidyverse)

young_people_filter <- coffee_data |>
  filter(Age < 25)

cat("Number of people under 25:", nrow(young_people_filter), "\n")
summary(young_people_filter$Age)

# Example 2: Multiple Conditions (Comma = AND)

female_low_caffeine_filter <- coffee_data |>
  filter(Gender == "Female", Caffeine_mg < 100)

cat("Number of Females with Low Caffeine:", nrow(female_low_caffeine_filter), "\n")
head(female_low_caffeine_filter)

# Example 3: Checking for Values in a Set (%in%)

eu_subset_filter <- coffee_data |>
  filter(Country %in% c("Germany", "Spain"))

cat("Number of people from Germany or Spain:", nrow(eu_subset_filter), "\n")
table(eu_subset_filter$Country)
