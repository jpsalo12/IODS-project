# Jussipekka Salo, 20.11.2023, 
#This scricpt is for the exercise 3 
#The data that is used can be found here: http://www.archive.ics.uci.edu/dataset/320/student+performance
#Install packages:
library(tidyverse)
library(dplyr)

install.packages("readr")
library(readr)

# Read the data: 
mat <- read_delim("data/student-mat.csv",delim = ";")

por <- read_delim("data/student-por.csv",delim = ";")


# Look at the dimensions of the data
dim(mat)

dim (por)


# Look at the structure of the data
str(mat)

str(por)

# Variables to join on
join_cols <- names(mat %>% select(!c("failures", "paid", "absences", "G1", "G2", "G3")))

free_cols <- names(mat %>% select(c("failures", "paid", "absences", "G1", "G2", "G3")))

#Combine the two data sets using variables in join_cols. Keep only the students present in both data sets
math_por <- inner_join(mat, por, by = join_cols)
dim (math_por)


# Look at the structure of the data
str(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, all_of(join_cols))


# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}



# Define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# Define a new logical column 'high_use', which is TRUE for students whose alc_use is greater than 2 and FAlSE otherwise
alc <- mutate(alc, high_use = alc_use > 2)


# glimpse at the new combined data

glimpse(alc)

##Everything looks good, let's save the modified data set


install.packages("readr")
library(readr)

write_csv(alc,"data/alc.csv")
