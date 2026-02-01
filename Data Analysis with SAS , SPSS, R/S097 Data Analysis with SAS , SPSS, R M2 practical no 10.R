library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)

cancer_data <- read_csv("Cancer.dataset.csv", n_max = 20)


cancer_long <- cancer_data %>%
  select(id, radius_mean, texture_mean) %>%
  pivot_longer(cols = c("radius_mean", "texture_mean"), 
               names_to = "Metric", 
               values_to = "Value")

plot1 <- ggplot(cancer_long, aes(x = factor(id), y = Value, color = Metric, group = Metric)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  theme_minimal() +
  scale_color_manual(values = c("radius_mean" = "#2ECC71", "texture_mean" = "#9B59B6"),
                     labels = c("Mean Radius", "Mean Texture")) +
  labs(title = "Comparative Analysis: First 20 Patients",
       x = "Patient ID", y = "Value") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "bottom")

plot2 <- ggplot(cancer_long, aes(x = factor(id), y = Value, fill = Metric)) +
  geom_col() +
  facet_wrap(~Metric) +
  theme_minimal() +
  scale_fill_manual(values = c("radius_mean" = "#5DADE2", "texture_mean" = "#E74C3C")) +
  labs(title = "Clinical Metrics by Patient ID") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")

diagnosis_summary <- cancer_data %>% count(diagnosis)
plot3 <- ggplot(diagnosis_summary, aes(x = "", y = n, fill = diagnosis)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  theme_void() +
  labs(title = "Diagnosis Distribution (First 20 Patients)",
       fill = "Diagnosis") +
  scale_fill_manual(values = c("M" = "#C0392B", "B" = "#2980B9")) +
  geom_text(aes(label = paste0(round(n/sum(n)*100), "%")), 
            position = position_stack(vjust = 0.5), color = "white", fontface = "bold")

plot4 <- ggplot(cancer_data, aes(x = reorder(factor(id), -radius_mean), y = radius_mean, fill = radius_mean)) +
  geom_col() +
  scale_fill_gradient(low = "#D5F5E3", high = "#186A3B") +
  theme_minimal() +
  labs(title = "High-Low Analysis: Mean Radius",
       subtitle = "Patients sorted from highest to lowest radius",
       x = "Patient ID (Sorted)", y = "Radius Mean") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "right")

print(plot1)
print(plot2)
print(plot3)
print(plot4)
