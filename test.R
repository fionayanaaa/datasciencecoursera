install.packages("plyr")
library(plyr)
setwd("/Users/fionayan/Library/Mobile Documents/com~apple~CloudDocs/Desktop/Rstudio_Data")

df <- read.csv("hw1_data.csv", header = TRUE, sep = ",")

na_index <- is.na(df$Ozone)

count(na_index)

mean(df$Ozone[!na_index])

idx <- (df$Ozone > 31) & (df$Temp > 90)
df$Solar.R[idx]
mean(df$Solar.R[idx], na.rm = TRUE)

i <- df$Month == 6
mean(df$Temp[i])

max(df$Ozone[df$Month == 5], na.rm = TRUE)

x <- list(2, "a", "b", TRUE)
x[[1]]
