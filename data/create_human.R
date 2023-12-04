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

variable_mapping1 <- c(     "Maternal Mortality Ratio" = "Mat.Mor",
                            "Adolescent Birth Rate" = "Ado.Birth",
                          "Percent Representation in Parliament" = "Parli.F",
                           "Population with Secondary Education (Female)" ="Edu2.F",
                            "Population with Secondary Education (Male)" = "Edu2.M" ,
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
  mutate(Edu2.FM = Edu2.F / Edu2.M,
         Labo.FM = Labo.F / Labo.M)


write_csv(x = join_data,file = "data/human.csv")

#Here, I continute for exercise 5

human <- readr::read_csv("data/human.csv")

# look at the (column) names of human and structure
names(human)
  
str(human)  
  
# Data includes 19 indicators from different countries of the world


#"GNI" = Gross National Income per capita
#"Life.Exp" = Life expectancy at birth
#"Edu.Exp" = Expected years of schooling 
#"Mat.Mor" = Maternal mortality ratio
#"Ado.Birth" = Adolescent birth rate



#"Parli.F" = Percetange of female representatives in parliament
#"Edu2.F" = Proportion of females with at least secondary education
#"Edu2.M" = Proportion of males with at least secondary education
#"Labo.F" = Proportion of females in the labour force
#"Labo.M" = Proportion of males in the labour force


#"Edu2.FM" = Educ.F / Educ.M
#"Labo.FM" = Labo.F / Labo.M

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))  

#
human_ <- filter(human, complete.cases(human))

# Filter out observations related to regions
new_human <- human_ %>%
filter(!(Country %in% c("Arab States",
                        "East Asia and the Pacific",
                        "Europe and Central Asia",
                        "Latin America and the Caribbean",
                        "South Asia",
                        "Sub-Saharan Africa",
                        "World")))

write_csv(x = new_human,file = "data/human_new.csv")

