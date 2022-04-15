## question 1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "./course3_data/ACS.csv", method = "curl")
acs_data <- read.csv("./course3_data/ACS.csv")
stp <- strsplit(colnames(acs_data), "wgtp")
stp[123]

## question 2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "./course3_data/GDP2.csv", method = "curl")
gdp2 <- read.csv("./course3_data/GDP2.csv")
gdp <- gsub(",", "", gdp2$X.3)
gdp <- gsub(" ", "", gdp)
gdp <- sapply(gdp, as.numeric)
gdp <- gdp[!is.na(gdp)]
print(gdp)
gdp_mean <- mean(gdp[1:190])

## question 4
GDPrank <- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                             , skip=5
                             , nrows=190
                             , select = c(1, 2, 4, 5)
                             , col.names=c("CountryCode", "Rank", "Country", "GDP")
)

eduDT <- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')
mergedDT <- merge(GDPrank, eduDT, by = 'CountryCode')

mergedDT[grepl(pattern = "Fiscal year end: June 30;", mergedDT[, `Special Notes`]), .N]


## question 5
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

timeDT <- data.table::data.table(timeCol = sampleTimes)
timeDT[(timeCol >= "2012-01-01") & (timeCol) < "2013-01-01", .N ]
timeDT[((timeCol >= "2012-01-01") & (timeCol < "2013-01-01")) & (weekdays(timeCol) == "Monday"), .N ]
