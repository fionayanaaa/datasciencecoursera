pollutantmean <- function(directory, pollutant, id = 1:332) {
  total_sum <- 0
  total_n <- 0
  n <- length(id)
  for (i in id) {
    path <- sprintf("%s/%03d.csv", directory, i)
    df <- read.csv(path)
    ind = !is.na(df[pollutant])
    i_sum <- sum(df[pollutant][ind])
    i_n <- sum(ind)
    total_sum = total_sum + i_sum
    total_n <- total_n + i_n
  }
  result <- total_sum / total_n
  print(result)
}

complete <- function(directory, id = 1:332) {
  n <- length(id)
  table <- data.frame("id"=id, "nobs"= numeric(n))
  for (i in 1:n){
    path <- sprintf("%s/%03d.csv", directory, id[i])
    df <- read.csv(path)
    i_nobs <- sum(!(is.na(df$sulfate) | is.na(df$nitrate)))
    table$nobs[i] = i_nobs
  }
  table
}

corr <- function(directory, threshold = 0) {
  result <- numeric(332)
  for (i in 1:332) {
    path <- sprintf("%s/%03d.csv", directory, i)
    df <- read.csv(path)
    ind <- !(is.na(df$sulfate) | is.na(df$nitrate))
    i_nobs <- sum(ind)
    if (i_nobs > threshold) {
      i_cor <- cor(df$sulfate[ind], df$nitrate[ind])
      result[i] = i_cor
    }
    else {
      result[i] = NA
    }
  }
  result = result[!is.na(result)]
}