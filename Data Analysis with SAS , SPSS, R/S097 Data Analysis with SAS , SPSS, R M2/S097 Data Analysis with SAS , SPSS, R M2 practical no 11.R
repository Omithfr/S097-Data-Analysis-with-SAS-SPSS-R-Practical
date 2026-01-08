library(ggplot2)
library(dplyr)
library(readr)

data <- read_csv("Student Mental health.csv")

colnames(data) <- c("Timestamp", "Gender", "Age", "Course", "Year_of_Study", 
                    "CGPA", "Marital_Status", "Depression", "Anxiety", 
                    "Panic_Attack", "Treatment")

data_clean <- data %>% filter(!is.na(Age))


plot1 <- ggplot(data_clean, aes(x = Age)) +
  geom_histogram(binwidth = 1, fill = "#69b3a2", color = "white") +
  theme_minimal() +
  labs(title = "Distribution of Student Age",
       subtitle = "Practical 11: Histogram Analysis",
       x = "Age (Years)",
       y = "Number of Students") +
  theme(plot.title = element_text(face = "bold", size = 14))


plot2 <- ggplot(data_clean, aes(x = Gender, y = Age, fill = Gender)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 16) +
  scale_fill_manual(values = c("Female" = "#ffb7b2", "Male" = "#a2c2e0")) +
  theme_light() +
  labs(title = "Age Distribution by Gender",
       subtitle = "Practical 11: Box Plot Comparison",
       x = "Gender",
       y = "Age") +
  theme(legend.position = "none",
        plot.title = element_text(face = "bold", size = 14))

print(plot1)
print(plot2)
