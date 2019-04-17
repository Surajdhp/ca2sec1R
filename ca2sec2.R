#setting the directory and amalgating the files to a single csv file
setwd("NI Crime Data")
files <- dir(pattern='*.csv$', recursive = T)

for(i in 1:length(files)) {
  if(i == 1)
    datafile <- read.csv(files[i])
  else
    datafile <- rbind(datafile, read.csv(files[i]))
}

#adding a new library
library(dplyr)

#reading all the files and then wirting them in the same csv file 
datafile <- rbind_list(lapply(files, read.csv))
head(datafile)
setwd("..")
CleanedNIPostcodeData <- read.csv("CleanedNIPostcodeData.csv")
write.csv(datafile, file = "AllNICrimeData.csv")

#modifying the data by altering attributes
ncol(datafile)
nrow(datafile)
str(datafile)

#Creating a subset that only includes necessary columns 
datafile <- subset(datafile, select = -c(Crime.ID, Reported.by, Falls.within, LSOA.code, LSOA.name, Last.outcome.category, Context))
str(datafile)

#categorizing the Crime.type by using Damage.type as another attribute
attach(datafile)
datafile$Damage.type[Crime.type == "Anti-social behaviour"] <- "Human Damage" 
datafile$Damage.type[Crime.type == "Drugs"]<- "Human Damage"
datafile$Damage.type[Crime.type == "Possession of weapons"] <- "Human Damage"
datafile$Damage.type[Crime.type == "Public order"]  <- "Human Damage"
datafile$Damage.type[Crime.type == "Theft from the person" ] <- "Human Damage"
datafile$Damage.type[Crime.type == "Violence and sexual offences"] <- "Human Damage"
datafile$Damage.type[Crime.type == "Bicycle theft"] <- "Property Damage"
datafile$Damage.type[Crime.type == "Burglary"] <- "Property Damage"
datafile$Damage.type[Crime.type == "Criminal damage and arson"] <- "Property Damage"
datafile$Damage.type[Crime.type == "Other crime"] <- "Property Damage"
datafile$Damage.type[Crime.type == "Other theft"] <- "Property Damage"
datafile$Damage.type[Crime.type == "Robbery"] <- "Property Damage"
datafile$Damage.type[Crime.type == "Shoplifting"] <- "Property Damage"
datafile$Damage.type[Crime.type == "Vehicle crime"] <- "Property Damage"
detach(datafile)
Damage.type <- factor(datafile$Damage.type, order = TRUE, levels = c("Human Damage", "Property Damage"))

#newly created attribute for crime table
datafile$Damage.type <- Damage.type
head(datafile)
str(datafile)

#Modifying the dataset such that the location attribute contains just the street name by removing 'On or near'
datafile$Location <- gsub("On or near", '', datafile$Location, ignore.case = FALSE)
datafile$Location <- trimws(datafile$Location, which = "both")
datafile$Location <- sub("^$", "No Location", datafile$Location)
head(datafile)
str(datafile)

sum(datafile[datafile$Location] == "No Location")
datafile_2 <- datafile[!rowSums(datafile[4] == "No Location"),]
random_crime_samples <- sample_n(datafile_2, 1000)
head(random_crime_samples)
