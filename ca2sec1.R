#Inserting the postcode data in dataframe
NIPostcodes_df <- read.csv("NIPostcodes.csv", header = 0)

#displaying number of rows in the dataframe
nrow(NIPostcodes_df)

#creating a visualization of dataframe created
str(NIPostcodes_df)

#displaying top 10 rows

head(NIPostcodes_df, n <- 10)

#assigining names to the atributes of the data
colnames(NIPostcodes_df) <- c("Organization Name", "Sub-Building Name", "Building Name", "Number", "Primary Thorfare", "Alt Thorfare", "Secondary Thorfare", "Locality", "Townland", "Town", "County", "Postcode", "x-coordinates", "y-coordinates", "Primary key")
head(NIPostcodes_df)
str(NIPostcodes_df)

#Replacing the missing values with NA
NIPostcodes_df[NIPostcodes_df==""] <- NA
NIPostcodes_df
str(NIPostcodes_df)
#Showing all the missing values and generation their mean
colSums(is.na(NIPostcodes_df))
colMeans(is.na(NIPostcodes_df))

#Adding categorizing factor for county
NIPostcodes_df$Location[NIPostcodes_df$County == "ANTRIM"] <- "TOP-RIGHT"
NIPostcodes_df$Location[NIPostcodes_df$County == "LONDONDERRY"] <- "TOP-LEFT"
NIPostcodes_df$Location[NIPostcodes_df$County == "DOWN"] <- "BOTTOM-RIGHT"
NIPostcodes_df$Location[NIPostcodes_df$County == "ARMAGH"] <- "BOTTOM"
NIPostcodes_df$Location[NIPostcodes_df$County == "TYRONE"] <- "LEFT"
NIPostcodes_df$Location[NIPostcodes_df$County == "FERMANAGH"] <- "BOTTOM-LEFT"

#we will now categorize the county by the factor of their location and display it in a different column
Location <- factor(NIPostcodes_df$Location, order = TRUE, levels = c("TOP-RIGHT", "TOP-LEFT", "BOTTOM-RIGHT", "BOTTOM", "LEFT", "BOTTOM-LEFT"))

#now we add the newly created attribute to the data
NIPostcodes_df$Location <- Location
head(NIPostcodes_df)
str(NIPostcodes_df)

#Moving the primary key from the last column to first column
NIPostcodes_df <- NIPostcodes_df[, c(15, 1:14, 16)]
head(NIPostcodes_df)
str(NIPostcodes_df)

#Creating new dataset for Limavady and storing it
NIPostcodes_df2 <- NIPostcodes_df[which(NIPostcodes_df$Town == "LIMAVADY"), ]
LIMAVADY_da <- NIPostcodes_df2[c(9:11)]
write.csv(LIMAVADY_da, file = "LIMAVADY1.csv", row.names = FALSE, col.names = FALSE)
str(LIMAVADY_da)

#Saving the new cleaned NIPostcode as a csv file
write.csv(NIPostcodes_df, file = "CleanedNIPostcodeData.csv", row.names = FALSE, col.names = FALSE)
str(CleanedNIPostcodeData)
