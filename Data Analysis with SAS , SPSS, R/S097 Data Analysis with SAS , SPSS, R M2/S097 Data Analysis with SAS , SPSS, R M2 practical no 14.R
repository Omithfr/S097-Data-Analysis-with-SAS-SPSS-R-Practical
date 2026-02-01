library(dplyr)

# 1. Load Data
df <- read.csv("House Price Prediction.csv")
df$High_Price <- ifelse(df$price > 500000, 1, 0)

# 2. Simplify to 20 Points (Ventiles)
# We now split the data into 20 buckets instead of 10
df$bin <- ntile(df$sqft_living, 20) 

# Calculate the average for each of the 20 bins
simplified_data <- df %>%
  group_by(bin) %>%
  summarise(
    avg_sqft = mean(sqft_living),
    prob_high_price = mean(High_Price)
  )

# 3. Create the Plot
# lwd = 3 makes the line "wider" (thicker)
plot(simplified_data$avg_sqft, simplified_data$prob_high_price,
     main = "Simplified Trend (20 Points)",
     xlab = "Living Area (sqft)",
     ylab = "Probability of High Price",
     col = "blue", 
     pch = 19,      
     cex = 1.5,       
     xlim = c(0, 6000), # Showing a wide range of house sizes
     ylim = c(0, 1))    # Keeping height standard (0% to 100%)

# 4. Add the Zigzag Line
lines(simplified_data$avg_sqft, simplified_data$prob_high_price, 
      col = "blue", lwd = 3) # Thicker line

grid()