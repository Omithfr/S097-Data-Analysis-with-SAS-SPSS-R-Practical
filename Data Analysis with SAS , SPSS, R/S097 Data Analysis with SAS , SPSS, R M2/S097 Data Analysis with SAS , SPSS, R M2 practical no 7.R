library(tidyverse)
library(car)
library(ggpubr)    

data <- read.csv("Formula-1-constructors.csv")

anova_model <- aov(constructorId ~ nationality, data = data)

summary(anova_model)

