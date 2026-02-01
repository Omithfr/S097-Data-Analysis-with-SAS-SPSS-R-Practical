df <- read.csv("House Price Prediction.csv", nrows = 20)

df$High_Price <- ifelse(df$price > 500000, 1, 0)

model <- glm(High_Price ~ sqft_living, family = binomial, data = df)

plot(df$sqft_living, df$High_Price,
     main = "Logistic Regression: High Price vs. Size (20 Houses)",
     xlab = "Living Area (sqft)",
     ylab = "Probability of High Price",
     col = "black", 
     pch = 19,      
     cex = 1.5,     
     ylim = c(0, 1))

x_values <- seq(min(df$sqft_living), max(df$sqft_living), length.out = 100)
predicted_probs <- predict(model, list(sqft_living = x_values), type = "response")

lines(x_values, predicted_probs, col = "red", lwd = 3)