df <- read.csv("study hours vs student scores.csv")

df$High_Caffeine <- ifelse(df$Caffeine_mg > 250, 1, 0)
model <- glm(High_Caffeine ~ Sleep_Hours, family = binomial, data = df)

summary(model)

subset_df <- df[1:20, ]

plot(subset_df$Sleep_Hours, subset_df$High_Caffeine,
     main = "Logistic Regression: High Caffeine Prob. vs Sleep Hours",
     xlab = "Sleep Hours",
     ylab = "Probability of High Caffeine Intake",
     col = rgb(0, 0, 0, 0.3),  # Point color with transparency
     pch = 19)

x_values <- seq(min(df$Sleep_Hours), max(df$Sleep_Hours), length.out = 100)

predicted_probs <- predict(model, list(Sleep_Hours = x_values), type = "response")

lines(x_values, predicted_probs, col = "green", lwd = 3)
