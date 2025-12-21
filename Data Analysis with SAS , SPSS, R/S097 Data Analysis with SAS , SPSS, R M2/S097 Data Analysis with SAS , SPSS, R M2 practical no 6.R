# 1. Load Data

rm(list = ls())

data <- read.csv("AmesHousing.csv")

data_paired <- data[c("X1st.Flr.SF", "X2nd.Flr.SF")]

names(data_paired) <- c("Flr_1_SF", "Flr_2_SF")

data_paired <- na.omit(data_paired)

# 2. Check structure

print("--- 2. Data Structure ---")
str(data_paired)

# 3. Descriptive statistics

print("\n--- 3. Descriptive Statistics ---")
mean(data_paired$Flr_1_SF)
mean(data_paired$Flr_2_SF)

sd(data_paired$Flr_1_SF)
sd(data_paired$Flr_2_SF)

# 4. Normality Test on Differences

difference <- data_paired$Flr_2_SF - data_paired$Flr_1_SF
print("\n--- 4. Normality Test on Differences (Shapiro-Wilk) ---")
shapiro.test(difference[1:500])

# 5. Paired t-test

print("\n--- 5. Paired t-test (Default Method) ---")
paired_t_test <- t.test(
  data_paired$Flr_1_SF,
  data_paired$Flr_2_SF,
  paired = TRUE
)

print(paired_t_test)

# 6. Alternative way (Formula method - using long format conversion)

long_data <- data.frame(
  Score = c(data_paired$Flr_1_SF, data_paired$Flr_2_SF),
  Time = rep(c("Flr_1_SF", "Flr_2_SF"), each = nrow(data_paired))
)

print("\n--- 6. Alternative Paired t-test (Formula Method) ---")
t.test(data_paired$Flr_1_SF, data_paired$Flr_2_SF, paired = TRUE)
