getwd()
setwd("/Users/fionayan/Library/Mobile Documents/com~apple~CloudDocs/Desktop/Rstudio_Data/datasciencecoursera/rprog_data_ProgAssignment3-data")
##outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
##head(outcome)
##outcome[, 11] <- as.numeric(outcome[, 11])
## You may get a warning about NAs being introduced; that is okay
##hist(outcome[, 11])
#names(outcome)

best <- function(state, outcome){
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  if(!(state %in% df$State)) stop("invalid state")
  else if (outcome == "heart attack") {
    df_temp <- df[df$State == state, ]
    df_order <- df_temp[order(df_temp[2]), ]
    name <- df_order[which.min(df_order[[11]]), ][[2]]
    return(name)
  }
  else if (outcome == "heart failure") {
    df_temp <- df[df$State == state, ]
    df_order <- df_temp[order(df_temp[2]), ]
    name <- df_order[which.min(df_order[[17]]), ][[2]]
    return(name)
  }
  else if (outcome == "pneumonia") {
    df_temp <- df[df$State == state, ]
    df_order <- df_temp[order(df_temp[2]), ]
    name <- df_order[which.min(df_order[[23]]), ][[2]]
    return(name)
  }
  else stop("invalid outcome")
}

rankhospital <- function(state, outcome, num = "best") {
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  if(!(state %in% df$State)) stop("invalid state")
  else if (outcome == "heart attack") {
    df_state <- df[df$State == state, ]
    df_state <- df_state[df_state[11] != "Not Available", ]
    n <- nrow(df_state)
    if (num != "best" && num != "worst" && num > n) return(NA)
    df_order <- df_state[with(df_state, order(as.numeric(df_state[[11]]), df_state[2])), ]
    if (num == "best") name <- df_order[1, ][[2]]
    else if (num == "worst") name <- df_order[n, ][[2]]
    else name <- df_order[num, ][[2]]
    return(name)
  }
  else if (outcome == "heart failure") {
    df_state <- df[df$State == state, ]
    df_state <- df_state[df_state[17] != "Not Available", ]
    n <- nrow(df_state)
    if (num != "best" && num != "worst" && num > n) return(NA)
    df_order <- df_state[with(df_state, order(as.numeric(df_state[[17]]), df_state[2])), ]
    if (num == "best") name <- df_order[1, ][[2]]
    else if (num == "worst") name <- df_order[n, ][[2]]
    else name <- df_order[num, ][[2]]
    return(name)
  }
  else if (outcome == "pneumonia") {
    df_state <- df[df$State == state, ]
    df_state <- df_state[df_state[23] != "Not Available", ]
    n <- nrow(df_state)
    if (num != "best" && num != "worst" && num > n) return(NA)
    df_order <- df_state[with(df_state, order(as.numeric(df_state[[23]]), df_state[2])), ]
    if (num == "best") name <- df_order[1, ][[2]]
    else if (num == "worst") name <- df_order[n, ][[2]]
    else name <- df_order[num, ][[2]]
    return(name)
  }
  else stop("invalid outcome")
}

rankall <- function(outcome, num = "best") {
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  states <- unique(df$State)
  states <- sort(states)
  n_states <- length(states)
  result <- data.frame("hospital" = numeric(n_states), "state" = numeric(n_states))
  for (i in 1:n_states) {
    state <- states[i]
    name <- rankhospital(state, outcome, num)
    result$hospital[i] <- name
    result$state[i] <- state
  }
  return(result)
}
