library(writexl)
library(ggplot2)

df <- read.csv("Daily Coffee Intake vs Sleep Duration.csv")

counts <- table(df$Stress_Level, df$Gender)

write.csv(as.data.frame.matrix(counts), "stress_by_gender.csv", row.names = TRUE)

counts_df <- as.data.frame.matrix(counts)
counts_df$Stress_Level <- rownames(counts_df) # Include labels
write_xlsx(counts_df, "stress_by_gender.xlsx")

barplot(counts,
        main = "Distribution of Stress Levels by Gender",
        xlab = "Gender",
        ylab = "Count",
        col = c("#2ca02c", "#d62728", "#1f77b4"),
        legend = rownames(counts),
        beside = TRUE)

pdf("graphical_report.pdf", width = 8, height = 6)

barplot(counts,
        main = "Distribution of Stress Levels by Gender",
        xlab = "Gender",
        ylab = "Count",
        col = c("#2ca02c", "#d62728", "#1f77b4"),
        legend = rownames(counts),
        beside = TRUE)

dev.off() 

print("Results successfully exported to stress_by_gender.csv, stress_by_gender.xlsx, and graphical_report.pdf")
