library(writexl)
library(readr)

df <- read_csv("Daily Coffee Intake vs Sleep Duration.csv")

counts <- table(df$Sleep_Quality, df$Gender)


barplot(counts,
        main = "Distribution of Sleep Quality by Gender",
        xlab = "Gender",
        ylab = "Count",
        col = c("green", "red", "blue", "yellow"),
        legend = rownames(counts),
        beside = TRUE)


pdf("graphical_report.pdf", width = 8, height = 6)

barplot(counts,
        main = "Distribution of Sleep Quality by Gender",
        xlab = "Gender",
        ylab = "Count",
        col = c("green", "red", "blue", "yellow"),
        legend = rownames(counts),
        beside = TRUE)

dev.off()

results_df <- as.data.frame.matrix(counts)
results_df <- cbind(Sleep_Quality = rownames(results_df), results_df)

write.csv(results_df, "Sleep_Quality_by_Gender.csv", row.names = FALSE)
write_xlsx(results_df, "Sleep_Quality_by_Gender.xlsx")

print("Success! Graph shown on screen AND saved to 'graphical_report.pdf'. Data saved to CSV/Excel.")