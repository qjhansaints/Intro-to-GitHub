setwd("C:/Users/Qyle Jhan Santos/Desktop/specdata")

## 1. Function "pollutantMean"
pollutantMean <- function(directory, pollutant, id = 332){
  files <- list.files(path = getwd(), pattern = ".csv")
  x <- c()
  
  for(i in id){
    data <- read.csv(files[i])
    x <- c(x, data[[pollutant]])
  }
  mean(x, na.rm = TRUE)
}

pollutantMean("specdata", "sulfate", 1:10)
pollutantMean("specdata", "nitrate", 70:72)
pollutantMean("specdata", "nitrate", 23)


## 2. Function "complete"
complete <- function(directory, id = 1:332){
  files <- list.files(path = getwd(), pattern = ".csv")
  observations <- c()
  
  for(i in id){
    data <- read.csv(files[i])
    my_data <- sum(complete.cases(data))
    observations <- c(observations, my_data)
  }
  data.frame(id, observations)
}

complete("specdata", 1)
complete("specdata", c(2,4,6,8,10,12))
complete("specdata", 30:25)
complete("specdata", 3)


## 3. Function "corr"
corr <- function(directory, threshold = 0){
  files <- list.files(path = getwd(), pattern = ".csv")
  cases <- complete(directory)
  id <- cases[cases$observations > threshold, ] $id
  result <- c()
  
  for(i in id){
    data <- read.csv(files[i])
    my_data <- data[complete.cases(data), ]
    result <- c(result, cor(my_data$sulfate, my_data$nitrate))
  }
  return(result)
}

cr <- corr("specdata", 150)
head(cr); summary(cr)

cr <- corr("specdata", 400)
head(cr); summary(cr)

cr <- corr("specdata", 5000)
head(cr); summary(cr); length(cr)

cr <- corr("specdata")
head(cr); summary(cr); length(cr)


## 4. Histogram
setwd("C:/Users/Qyle Jhan Santos/Desktop")
outcome <- read.csv('outcome-of-care-measures.csv', colClasses = "character")
head(outcome)

ncol(outcome)
nrow(outcome)

outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])

hist(outcome[,11], main = "Hospital 30-Day Death (Morality) Rates from Heart Attack", xlab = "Deaths", ylab = "Frequency", col = "lightb lue")