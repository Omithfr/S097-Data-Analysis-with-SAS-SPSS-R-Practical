library(tidyverse)

df <- read.csv("Formula-1-constructors.csv")

grand_mean <- mean(df$constructorId)

stats_table <- df %>%
  group_by(nationality) %>%
  summarise(
    group_mean = mean(constructorId),
    n = n(),
    group_var = var(constructorId)
  ) %>%
  mutate(
    ssb_part = n * (group_mean - grand_mean)^2,
    ssw_part = (n - 1) * ifelse(is.na(group_var), 0, group_var)
  )

SSB <- sum(stats_table$ssb_part)
SSW <- sum(stats_table$ssw_part)

df_between <- nrow(stats_table) - 1
df_within <- nrow(df) - nrow(stats_table)

MSB <- SSB / df_between
MSW <- SSW / df_within

f_statistic <- MSB / MSW
p_value <- pf(f_statistic, df_between, df_within, lower.tail = FALSE)

cat("Manual ANOVA Results:\n")
cat("F-Statistic:", f_statistic, "\n")
cat("P-Value:", p_value, "\n")
