data <- read.csv("meteorite-landings.csv", nrows = 5)

median_revenue <- median(data$mass, na.rm = TRUE)
median_net_income <- median(data$year, na.rm = TRUE)

data$Revenue_Cat <- ifelse(data$mass >= median_revenue, "High", "Low")
data$Net_Income_Cat <- ifelse(data$year >= median_net_income, "High", "Low")

contingency_table <- table(data$Revenue_Cat, data$Net_Income_Cat)

print("Contingency Table:")
print(contingency_table)

test_result <- chisq.test(contingency_table)

print(test_result)
