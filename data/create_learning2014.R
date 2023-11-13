
Jussipekka Salo, 10.11.2023
This is a rscript for the exercise 2
library(dplyr)

install.packages("readr")
library(readr)
# read the data into memory
data_ex1 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Look at the dimensions of the data
dim(data_ex1)


# Look at the structure of the data
str(data_ex1)

#Next let's create analysis data set with characteristics given in the exercise

# divide each number in the column vector
data_ex1$attitude <- data_ex1$Attitude / 10

##scaling
deep <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")

data_ex1$deep <- rowMeans(data_ex1[, deep])


strategics <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
data_ex1$stra <- rowMeans(data_ex1[, strategics])

surface <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
data_ex1$surf <- rowMeans(data_ex1[, surface])

learning2014 <- data_ex1[, c("gender","Age","attitude", "deep", "stra", "surf", "Points")]

#Filter zero points away
analysisdata <- dplyr::filter(learning2014, Points != 0)

#Save the data
write_csv(analysisdata,"Data/learning2014.csv")

rm(analysisdata)
#read the created data using read_csv command
analysisdata2 <- read_csv("Data/learning2014.csv")
str(analysisdata2)
head(analysisdata2)

