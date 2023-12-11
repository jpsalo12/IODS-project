#Exersice 6, Jussipekka Salo
#Data wrangling

library(tidyverse)

#I start with RATS data
#Load the data 

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Look at the (column) names of BPRS
names(RATS)

#Structure
str (RATS)

#SUMMARY
summary(RATS)

#Convert categorical variables to factors
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#Convert data from wide to long

# Convert to long form
RATSL <-  pivot_longer(RATS, cols = -c(ID,Group),
                       names_to = "WD",values_to = "Weight")

# Extract the week number
RATSL <-  RATSL %>% 
  mutate(Time = as.integer(substr(WD,3,4))) %>% 

arrange(Time) #order by Time variable


# Take a glimpse at the RATSL data
glimpse(RATSL)


summary(RATSL)
#Now in the long form, each id has multiple observations (rows), each representing a different point in time. In the wide form, there is only one observation per id (one row)


#Save the long form

write_rds(RATSL,"data/rats.rds")

#Now the same for the other data set, called BPRS

#Load the data 

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)


# Look at the (column) names of BPRS
names(BPRS)

#Structure
str (BPRS)

#SUMMARY
summary(BPRS)

#Convert categorical variables to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)


#Convert data from wide to long

# Convert to long form

# Convert to long form
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) #order by weeks variable

# Extract the week number
BPRSL <-  BPRSL %>% 
  mutate(week = as.integer(substr(weeks,5,5)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)
summary(BPRS)
# Again, Now in the long form, each id has multiple observations (rows), each representing a different point in time. In the wide form, there is only one observation per id (one row)

#Save
readr::write_rds(BPRSL,"data/bprs.rds")