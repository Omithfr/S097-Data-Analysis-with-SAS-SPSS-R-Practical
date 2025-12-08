library(dplyr)

# --- 1. SETUP: Load Data ---
df <- read.csv("Cancer.dataset.csv") %>%
  select(id, diagnosis, radius_mean, texture_mean, area_mean)

# 2. USING str() (Structure)
print("--- OUTPUT OF str() (Data Structure) ---")
# Shows that 'diagnosis' is a character (chr) and others are numeric (num/int)
str(df)

# 3. USING summary() (Statistical Summary)
print("--- OUTPUT OF summary() (Descriptive Statistics) ---")
summary(df)
