# 1. Install Required Packages (Run only once)

# 2. Load Libraries

library(titanic)
library(dplyr)

# 3. Import Dataset

titanic_data <- titanic_train

# 4. View Dataset Structure

print("--- 4. Data Structure (First 6 Rows) ---")
print(head(titanic_data))

# 5. Frequency Table using table() (Base R)

print("--- 5. Frequency Table: Passenger Class (Pclass) ---")
class_table <- table(titanic_data$Pclass)
print(class_table)

print("--- 5. Relative Frequency Table: Passenger Class ---")
class_prop_table <- prop.table(class_table)
print(class_prop_table)


# 6. Frequency Table using count() (Tidyverse/dplyr)

print("--- 6. Frequency Table: Sex (Gender) using dplyr::count ---")
sex_count <- titanic_data %>%
  count(Sex, sort = TRUE) # sort = TRUE orders by frequency (n)
print(sex_count)


# 7. Frequency Table for another variable (Embarked)

print("--- 7. Frequency Table: Port of Embarkation (Embarked) ---")
embark_table <- table(titanic_data$Embarked, useNA = "ifany") # useNA = "ifany" shows NA count
print(embark_table)
