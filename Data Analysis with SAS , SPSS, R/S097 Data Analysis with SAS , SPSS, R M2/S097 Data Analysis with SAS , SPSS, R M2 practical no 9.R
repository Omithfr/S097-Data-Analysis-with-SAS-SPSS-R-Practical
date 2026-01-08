library(tidyverse)

data <- read.csv("meteorite-landings.csv")

data <- data %>% filter(!is.na(mass), !is.na(year))

median_revenue <- median(data$mass)
median_net_income <- median(data$year)

data$Revenue_Cat <- ifelse(data$mass >= median_revenue, "High", "Low")
data$Net_Income_Cat <- ifelse(data$year >= median_net_income, "High", "Low")

observed <- table(data$Revenue_Cat, data$Net_Income_Cat)
print("Contingency Table (Observed):")
print(observed)

row_totals <- rowSums(observed)
col_totals <- colSums(observed)
grand_total <- sum(observed)

expected <- outer(row_totals, col_totals) / grand_total

chi_sq_stat <- sum((observed - expected)^2 / expected)

df_chi <- (nrow(observed) - 1) * (ncol(observed) - 1)

p_value <- pchisq(chi_sq_stat, df_chi, lower.tail = FALSE)

cat("\n--- Manual Chi-Square Results ---\n")
cat("Chi-Square Statistic:", chi_sq_stat, "\n")
cat("Degrees of Freedom:", df_chi, "\n")
cat("P-Value:", p_value, "\n")
