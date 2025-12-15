# 1. Import Dataset
data = read.csv("star_dataset.csv")

# 2. View Dataset Structure (R head(data) equivalent)
head(data)

# 3. Frequency table for a column (example: Spectral Class)

freq_table <- table(data$"Spectral Class") # Note: using $ with spaces requires quotes in R

# 4. View result

freq_table
