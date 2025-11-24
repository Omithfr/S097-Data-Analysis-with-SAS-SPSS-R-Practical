install.packages("dplyr")

library(dplyr)
library(readr)

house_data <- read_csv("House Price Prediction.csv")

head(house_data)

#Example 1: Sorting by a Single Variable

house_sorted_price <- house_data |>
  arrange(price)

head(house_sorted_price, 5)

#Example 2: Sorting by a Single Variable

house_sorted_sqft_desc <- house_data |>
  arrange(desc(sqft_living))

head(house_sorted_sqft_desc, 5)

#Example 3: Sorting by Two Variables

house_multi_sort <- house_data |>
  arrange(view, desc(price))

head(house_multi_sort, 10)

#Example 4: Combined Filter and Sort

large_homes_by_year <- house_data |>
  filter(bedrooms > 4) |>
  arrange(yr_built)

cat("Top 5 large homes (5+ bedrooms) by oldest build year:\n")
print(large_homes_by_year |> select(bedrooms, yr_built, price) |> head(5))
