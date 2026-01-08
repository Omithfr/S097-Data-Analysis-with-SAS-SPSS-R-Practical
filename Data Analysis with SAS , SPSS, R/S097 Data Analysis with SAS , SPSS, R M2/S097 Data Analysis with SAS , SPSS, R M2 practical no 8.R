library(tidyverse)

df <- read.csv("kepler-exoplanet.csv") %>%
  select(koi_fpflag_nt, koi_period) %>%
  filter(!is.na(koi_period))

grand_mean <- mean(df$koi_period)
N <- nrow(df)

stats_table <- df %>%
  group_by(koi_fpflag_nt) %>%
  summarise(
    group_mean = mean(koi_period),
    n = n(),
    group_var = var(koi_period)
  ) %>%
  mutate(
    # SSB calculation: n * (Group Mean - Grand Mean)^2
    ssb_part = n * (group_mean - grand_mean)^2,
    # SSW calculation: (n - 1) * Variance
    ssw_part = (n - 1) * ifelse(is.na(group_var), 0, group_var)
  )

SSB <- sum(stats_table$ssb_part)
SSW <- sum(stats_table$ssw_part)

df_between <- nrow(stats_table) - 1
df_within <- N - nrow(stats_table)

MSB <- SSB / df_between
MSW <- SSW / df_within

f_statistic <- MSB / MSW
p_value <- pf(f_statistic, df_between, df_within, lower.tail = FALSE)

cat("=== MANUAL ONE-WAY ANOVA RESULTS ===\n")
cat("Variable: koi_period grouped by koi_fpflag_nt\n")
cat("F-Statistic:", f_statistic, "\n")
cat("P-Value:", p_value, "\n")
