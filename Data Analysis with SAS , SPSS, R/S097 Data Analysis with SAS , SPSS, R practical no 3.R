install.packages(c("readr", "psych"))

library(readr)   
library(psych)  

Caffeine_mg <- read.csv("Daily.Coffee.Intake.vs.Sleep.Duration.csv")


head(Daily.Coffee.Intake.vs.Sleep.Duration)

tail(Daily.Coffee.Intake.vs.Sleep.Duration)

dim(Daily.Coffee.Intake.vs.Sleep.Duration)

cat("Dimensions (Rows, Columns): ", dim(Daily.Coffee.Intake.vs.Sleep.Duration), "\n")

str(Daily.Coffee.Intake.vs.Sleep.Duration)

summary(Daily.Coffee.Intake.vs.Sleep.Duration)

describe(Daily.Coffee.Intake.vs.Sleep.Duration)
