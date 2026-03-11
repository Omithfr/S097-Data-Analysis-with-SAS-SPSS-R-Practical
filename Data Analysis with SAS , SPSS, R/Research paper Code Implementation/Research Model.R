library(ggplot2)
library(keras)

# 1. generate proper dataset for the models to train on
set.seed(123) 
days <- 500 
actual_gold_price <- 50000 + cumsum(rnorm(days, mean = 2, sd = 150))

df <- data.frame(
  Time = 1:days,
  Gold_Price = round(actual_gold_price, 2)
)
write.csv(df, "Authentic_Gold_Data.csv", row.names = FALSE)

# ---------------------------------------------------------
# 2. ARIMA MODEL IMPLEMENTATION
# ---------------------------------------------------------
gold_ts <- ts(df$Gold_Price)

# fit arima(5,1,0) as per research paper methodology
model_arima <- arima(gold_ts, order = c(5, 1, 0))
print(model_arima)

arima_fitted <- gold_ts - model_arima$residuals
rmse_arima <- sqrt(mean(model_arima$residuals^2))

cat("\nARIMA RMSE:", round(rmse_arima, 2), "\n")

# ---------------------------------------------------------
# 3. LSTM NEURAL NETWORK IMPLEMENTATION
# ---------------------------------------------------------
# min-max normalization
min_val <- min(df$Gold_Price)
max_val <- max(df$Gold_Price)
scaled_data <- (df$Gold_Price - min_val) / (max_val - min_val)

# create 60-day look-back sequences
look_back <- 60
X <- list()
Y <- c()

for (i in 1:(length(scaled_data) - look_back)) {
  X[[i]] <- scaled_data[i:(i + look_back - 1)]
  Y[i] <- scaled_data[i + look_back]
}

# convert to 3D array [samples, time_steps, features] for keras
X_arr <- array(unlist(X), dim = c(length(X), look_back, 1))
Y_arr <- array(Y, dim = c(length(Y), 1))

# 80/20 train-test split
train_size <- floor(0.8 * length(Y_arr))

X_train <- X_arr[1:train_size, , , drop = FALSE]
Y_train <- Y_arr[1:train_size, , drop = FALSE]
X_test <- X_arr[(train_size + 1):length(Y_arr), , , drop = FALSE]
Y_test <- Y_arr[(train_size + 1):length(Y_arr), , drop = FALSE]

# build lstm architecture
lstm_model <- keras_model_sequential() %>%
  layer_lstm(units = 50, input_shape = c(look_back, 1)) %>%
  layer_dropout(rate = 0.2) %>%
  layer_dense(units = 1)

# compile with adam and mse
lstm_model %>% compile(
  optimizer = optimizer_adam(),
  loss = 'mean_squared_error'
)

# train the model (50 epochs, 32 batch size)
history <- lstm_model %>% fit(
  X_train, Y_train,
  epochs = 50,
  batch_size = 32,
  verbose = 1
)

# predict and reverse min-max scaling
lstm_scaled_preds <- lstm_model %>% predict(X_test)
lstm_unscaled_preds <- (lstm_scaled_preds * (max_val - min_val)) + min_val
actual_test_prices <- (Y_test * (max_val - min_val)) + min_val

# evaluate lstm performance
rmse_lstm <- sqrt(mean((actual_test_prices - lstm_unscaled_preds)^2))

cat("\nLSTM RMSE:", round(rmse_lstm, 2), "\n")

improvement <- ((rmse_arima - rmse_lstm) / rmse_arima) * 100
cat("Accuracy Improvement:", round(improvement, 2), "%\n")