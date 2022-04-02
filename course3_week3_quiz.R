# question 1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "./course3_data/community.csv", method = "curl")
community <- read.csv("./course3_data/community.csv")
agricultureLogical <- with(community, community$ACR == "3" & community$AGS == "6")
which(agricultureLogical)

# question 2
install.packages("jpeg")
library(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "./course3_data/img.jpg", method = "curl")
img <- readJPEG("./course3_data/img.jpg", native = TRUE)
quantile(img, probs=c(0.3, 0.8))

# question 3, 4, 5
install.packages("plyr")
library(plyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "./course3_data/gdp.csv", method = "curl")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "./course3_data/education.csv", method = "curl")
gdp <- read.csv("./course3_data/gdp.csv", na.strings = c(""))
education <- read.csv("./course3_data/education.csv")
mergeData <- merge(gdp, education, by.x = "X", by.y = "CountryCode")
mergeData <- mergeData[!is.na(mergeData$Gross.domestic.product.2012), ]
mergeData <- arrange(mergeData, desc(as.numeric(Gross.domestic.product.2012)))
mergeData$Long.Name[13]

highOECD <- mean(as.numeric(mergeData[mergeData$Income.Group == "High income: OECD", ]$Gross.domestic.product.2012))
hihgnonOECD <- mean(as.numeric(mergeData[mergeData$Income.Group == "High income: nonOECD", ]$Gross.domestic.product.2012))

mergeData$rank <- cut(as.numeric(mergeData$Gross.domestic.product.2012), breaks = c(quantile(as.numeric(mergeData$Gross.domestic.product.2012), probs=c(0, 0.2, 0.4, 0.6, 0.8, 1))))
table(mergeData$rank, mergeData$Income.Group)
