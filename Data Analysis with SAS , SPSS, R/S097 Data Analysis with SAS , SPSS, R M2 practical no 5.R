# 1. Load Data

rm(list = ls())

data <- read.csv("song_data.csv")


data$final_total_points <- as.numeric(data$final_total_points)
data <- subset(data, gender %in% c("Female", "Male"))
data <- na.omit(data[c("final_total_points", "gender")])


# 2. Check structure

print("--- 2. Data Structure ---")
str(data)

# 3. Descriptive statistics (Using aggregate)


print("\n--- 3. Descriptive Statistics (by Gender) ---")
aggregate(final_total_points ~ gender, data = data,
          FUN = function(x) c(
            Mean = mean(x),
            SD = sd(x),
            N = length(x)
          ))

# 4. Normality Test (Shapiro-Wilk)

print("\n--- 4. Normality Test (Female) ---")
shapiro.test(data$final_total_points[data$gender == "Female"])

print("\n--- 4. Normality Test (Male) ---")
shapiro.test(data$final_total_points[data$gender == "Male"])


# 5. Equality of Variance Test (F-test/Variance Ratio Test)

print("\n--- 5. Equality of Variance Test (F-test) ---")
var.test(final_total_points ~ gender, data = data)


# 6. Independent Two Sample t-test

# 6a. Welch t-test (Unequal variance) - DEFAULT

print("\n--- 6a. Welch t-test (Unequal variance) ---")
t_test_result <- t.test(final_total_points ~ gender, data = data)
print(t_test_result)


# 6b. Equal variance assumed (Student's t-test)

print("\n--- 6b. Equal variance assumed (Student's t-test) ---")
t_test_equal_var <- t.test(final_total_points ~ gender, data = data, var.equal = TRUE)
print(t_test_equal_var)


# 7. Manual Method (Subsetting)

group_A <- data$final_total_points[data$gender == "Female"]
group_B <- data$final_total_points[data$gender == "Male"]

print("\n--- 7. Manual Method Check (Should match 6a) ---")
t.test(group_A, group_B)
