library(ggplot2)
library(readr)

house_data <- read_csv("House Price Prediction.csv")
house_subset <- head(house_data, 50)

correlation_data <- house_subset[, c("price", "sqft_living", "bedrooms", "floors")]

cor_matrix <- cor(correlation_data)

print("Correlation Matrix (Practical 12):")
print(cor_matrix)


plot_scatter <- ggplot(house_subset, aes(x = sqft_living, y = price)) +
  geom_point(color = "#2E86C1", size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", color = "#C0392B", se = FALSE) + # Linear trend line
  theme_minimal() +
  labs(title = "Relationship: Price vs. Living Space",
       subtitle = "Analysis of the first 50 houses",
       x = "Square Feet (Living Area)",
       y = "Price ($)") +
  theme(plot.title = element_text(face = "bold", size = 14))

heatmap(cor_matrix, 
        main = "Correlation Heatmap (House Features)",
        col = colorRampPalette(c("#AED6F1", "white", "#E74C3C"))(20),
        symm = TRUE,
        margins = c(10, 10))

print(plot_scatter)