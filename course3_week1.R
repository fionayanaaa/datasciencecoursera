setwd("..")
getwd()
install.packages("xlsx")
install.packages("XML")
install.packages("data.table")
library(xlsx)
library(XML)
library(data.table)

# read csv file, question 1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "./course3_data/quiz1.csv", method = "curl")
df <- read.csv("./course3_data/quiz1.csv")
value = nrow(df[which(df$VAL == 24), ])

# read xlsx file, question 3
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", destfile = "./course3_data/quiz1_3.xlsx", method = "curl")
dateDownloaded <- date()
dat <- read.xlsx("./course3_data/quiz1_3.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

# read xml file, question 4
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
dat_xml <- xmlTreeParse(fileUrl, useInternalNodes = TRUE)
root <- xmlRoot(dat_xml)
xmlName(root)
zipcode <- xpathSApply(root, "//row//row//zipcode", xmlValue)
sum(zipcode == "21231")

# question 5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "./course3_data/quiz1_5.csv", method = "curl")
DT <- fread("./course3_data/quiz1_5.csv")
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15))
system.time(mean(DT[DT$SEX==2,]$pwgtp15))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(rowMeans(DT)[DT$SEX==1])
system.time(rowMeans(DT)[DT$SEX==2])
