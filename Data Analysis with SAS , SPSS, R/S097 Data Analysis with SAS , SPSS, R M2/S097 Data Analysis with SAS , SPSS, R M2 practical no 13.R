airline_df <- read.csv("international-airline-passengers.csv", header = FALSE)

colnames(airline_df) <- c("Month", "Passengers")

airline_df$Time_Index <- 1:nrow(airline_df)

subset_df <- airline_df[1:20, ]

print(head(subset_df))

model <- lm(Passengers ~ Time_Index, data = subset_df)

summary(model)

plot(subset_df$Time_Index, subset_df$Passengers,
     main = "Linear Regression: Passengers vs Time (First 20 Samples)",
     xlab = "Time (Months from Start)",
     ylab = "Number of Passengers",
     pch = 19,   
     col = "yellow")

abline(model, col = "green", lwd = 2)
