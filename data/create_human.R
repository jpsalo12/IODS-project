library(readr)
install.packages("skimr")
library(skimr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

#Let's check the Structure and dimension:
str(hd)
str(gii)

dim(hd)
dim(gii)

#Summaries:
skimr::skim(hd)
skimr::skim(gii)

# Shortening the variable names

variable_mapping <- c("Gross National Income (GNI) per Capita" = "GNI",
                      "Life Expectancy at Birth" = "Life.Exp",
                      "Expected Years of Education" = "Edu.Exp")

# Rename columns based on the mapping

names(hd) <- sapply(names(hd), function(x) ifelse(x %in% names(variable_mapping), variable_mapping[x], x))

# Shortening the variable names

variable_mapping1 <- c(     "Maternal Mortality Ratio" = "MM_rate",
                            "Adolescent Birth Rate" = "Ado BR",
                          "Percent Representation in Parliament" = "%_parliament",
                           "Population with Secondary Education (Female)" ="Educ.F",
                            "Population with Secondary Education (Male)" = "Educ.M" ,
                           "Labour Force Participation Rate (Female)" = "Labo.F",
                            "Labour Force Participation Rate (Male)" = "Labo.M" )

# Rename columns based on the mapping

names(gii) <- sapply(names(gii), function(x) ifelse(x %in% names(variable_mapping1), variable_mapping1[x], x))



# View the modified dataset with updated variable names
head(hd)


#Then do this in different order than in the assignment because it is more convenient:

#Join the datas
join_data <- gii %>% inner_join(hd,by="Country")



# Two new variables:

join_data  <- join_data  %>% 
  mutate(Edu2.FM = Educ.F / Educ.M,
         Labo.FM = Labo.F / Labo.M)


write_csv(x = join_data,file = "data/human.csv")