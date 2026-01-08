library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)

cancer_data <- read_csv("Cancer.dataset.csv", n_max = 5)

cancer_long <- cancer_data %>%
  select(id, radius_mean, texture_mean) %>%
  pivot_longer(cols = c("radius_mean", "texture_mean"), 
               names_to = "Metric", 
               values_to = "Value")



plot1 <- ggplot(cancer_long, aes(x = factor(id), y = Value, color = Metric, group = Metric)) +
  geom_line(size = 1.2) +
  geom_point(size = 4) +
  theme_minimal() +
  scale_color_manual(values = c("radius_mean" = "#2ECC71", "texture_mean" = "#9B59B6"),
                     labels = c("Mean Radius", "Mean Texture")) +
  labs(title = "Cancer Diagnosis Metrics: First 5 Patients",
       subtitle = "Comparative Analysis of Mean Radius vs. Mean Texture",
       x = "Patient ID",
       y = "Measurement Value",
       color = "Metric") +
  theme(legend.position = "bottom",
        plot.title = element_text(face = "bold", size = 16),
        axis.text.x = element_text(angle = 0))


plot2 <- ggplot(cancer_long, aes(x = factor(id), y = Value, fill = Metric)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = round(Value, 1)), vjust = -0.5, size = 3.5, fontface = "bold") +
  facet_wrap(~Metric) +
  theme_minimal() +
  scale_fill_manual(values = c("radius_mean" = "#5DADE2", "texture_mean" = "#E74C3C")) +
  labs(title = "Clinical Metrics by Patient ID",
       subtitle = "Faceted view for individual metric comparison",
       x = "Patient ID",
       y = "Value") +
  theme(legend.position = "none",
        strip.background = element_rect(fill = "#EBEDEF"),
        strip.text = element_text(face = "bold", size = 12),
        plot.title = element_text(face = "bold", size = 16))

print(plot1)
print(plot2)
