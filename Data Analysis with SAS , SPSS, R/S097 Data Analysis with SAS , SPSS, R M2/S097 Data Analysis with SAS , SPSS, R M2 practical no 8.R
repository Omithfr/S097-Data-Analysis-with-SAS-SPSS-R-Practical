library(readr)

df <- read.csv("kepler-exoplanet.csv", stringsAsFactors = TRUE)

colnames(df)[5] <- "Gender"
colnames(df)[6] <- "CGPA_Range"
colnames(df)[8] <- "Depression"

convert_cgpa <- function(x) {
  x <- trimws(as.character(x)) 
  if (x == "CANDIDATE") return(1.0)
  if (x == "FALSE POSITIVE") return(0.0)
  # Adding CONFIRMED if present in the specific column
  if (x == "CONFIRMED") return(2.0)
  return(NA)
}

df$CGPA_Numeric <- sapply(df$CGPA_Range, convert_cgpa)

model <- aov(CGPA_Numeric ~ Gender * Depression, data = df)

summary(model)

aggregate(CGPA_Numeric ~ Gender + Depression, data = df, FUN = mean)
