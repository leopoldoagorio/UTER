#dataloader
#now load the data from the file ./PDA/Ricaldoni_v1.sqlite
library(RSQLite)
library(readr)
library(ggplot2)

con <- dbConnect(SQLite(), dbname = "./PDA/Ricaldoni_v1.sqlite")
#print the tables
dbListTables(con)
#load the data from the table "POTENCIAS" where Id_estacion==65 (sum)
sums <- dbGetQuery(con, "SELECT * FROM POTENCIAS WHERE Id_estacion==65")
#close the connection
dbDisconnect(con)

#first install it with install.packages
#library(dplyr)
#install.packages("dplyr")

# now load the data from the dataset.csv
sumscsv <- read_csv("./dataset.csv")

# sanity check
head(sumscsv) #idx longitud latitud año mes dia hora temperatura(°C)
# print all possible values for the column "longitud"
unique(sumscsv$longitud)
# print all possible values for the column "latitud"
unique(sumscsv$latitud)
# Find the closest values to Montevideo
closest_lat <- unique(sumscsv$latitud)[which.min(abs(unique(sumscsv$latitud) + 34.9))] # -35
closest_long <- unique(sumscsv$longitud)[which.min(abs(unique(sumscsv$longitud) + 56.2))] # -56.25

# Subset rows where latitud and longitud match the closest values to Montevideo
sumscsvf <- sumscsv[sumscsv$latitud == closest_lat & sumscsv$longitud == closest_long, ]
# Rename the column to use an underscore instead of the degree symbol
names(sumscsvf)[names(sumscsvf) == "temperatura(°C)"] <- "temperatura_C"

# Plot the mean temperature per day for month 1
ggplot(sumscsvf[sumscsvf$mes == 1, ], aes(x = día, y = temperatura_C)) + geom_point() + geom_line() + geom_smooth(method = "lm") + ggtitle("Mean temperature per day for month 1")

library(dplyr)
library(lubridate)
library(ggplot2)

# Calculate the mean temperature for each day of the year
sumscsvf_year <- sumscsvf %>% 
  mutate(day_of_year = yday(as.Date(paste(año, mes, día, sep = "-")))) %>% 
  group_by(day_of_year) %>% 
  summarize(mean_temp = mean(temperatura_C))

# Plot the mean temperature for each day of the year
ggplot(sumscsvf_year, aes(x = day_of_year, y = mean_temp)) + 
  geom_point() + 
  geom_line() +
  ggtitle("Mean temperature per day for the year in Montevideo")

