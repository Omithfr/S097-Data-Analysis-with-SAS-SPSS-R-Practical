library(tidyverse)

df <- read.csv("kepler-exoplanet.csv") %>%
  select(koi_fpflag_nt, koi_fpflag_ss, koi_period) %>%
  filter(!is.na(koi_period))

grand_mean <- mean(df$koi_period)
N <- nrow(df)

stats_a <- df %>%
  group_by(koi_fpflag_nt) %>%
  summarise(mean_a = mean(koi_period), n_a = n()) %>%
  mutate(ss_a_part = n_a * (mean_a - grand_mean)^2)

SS_A <- sum(stats_a$ss_a_part)
df_A <- nrow(stats_a) - 1  

stats_b <- df %>%
  group_by(koi_fpflag_ss) %>%
  summarise(mean_b = mean(koi_period), n_b = n()) %>%
  mutate(ss_b_part = n_b * (mean_b - grand_mean)^2)

SS_B <- sum(stats_b$ss_b_part)
df_B <- nrow(stats_b) - 1 

stats_cells <- df %>%
  group_by(koi_fpflag_nt, koi_fpflag_ss) %>%
  summarise(
    cell_mean = mean(koi_period),
    n_ij = n(),
    cell_var = var(koi_period),
    .groups = 'drop'
  ) %>%
  mutate(
    ss_error_part = (n_ij - 1) * ifelse(is.na(cell_var), 0, cell_var),
    ss_between_cells_part = n_ij * (cell_mean - grand_mean)^2
  )

SS_Error <- sum(stats_cells$ss_error_part)
SS_Between_Cells <- sum(stats_cells$ss_between_cells_part)
SS_Interaction <- SS_Between_Cells - SS_A - SS_B

df_Interaction <- df_A * df_B
df_Error <- N - (nrow(stats_a) * nrow(stats_b))

MS_A <- SS_A / df_A
MS_B <- SS_B / df_B
MS_Interaction <- SS_Interaction / df_Interaction
MS_Error <- SS_Error / df_Error

f_a <- MS_A / MS_Error
f_b <- MS_B / MS_Error
f_int <- MS_Interaction / MS_Error

p_a <- pf(f_a, df_A, df_Error, lower.tail = FALSE)
p_b <- pf(f_b, df_B, df_Error, lower.tail = FALSE)
p_int <- pf(f_int, df_Interaction, df_Error, lower.tail = FALSE)

cat("=== MANUAL TWO-WAY ANOVA RESULTS ===\n")
cat("Factor A (nt) F-Stat:", f_a, " P-Value:", p_a, "\n")
cat("Factor B (ss) F-Stat:", f_b, " P-Value:", p_b, "\n")
cat("Interaction F-Stat:", f_int, " P-Value:", p_int, "\n")
