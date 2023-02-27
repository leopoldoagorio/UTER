#dataloader
#now load the data from the file ./PDA/Ricaldoni_v1.sqlite
library(RSQLite)
library(readr)
library(ggplot2)

library(dplyr)
library(lubridate)
library(ggplot2)
library(MEFM)

Sys.setlocale("LC_TIME", "C")

sa <- sa # South Australia data frame

con <- dbConnect(SQLite(), dbname = "./PDA/Ricaldoni_v1.sqlite")
#print the tables
dbListTables(con)
#load the data from the table "POTENCIAS" where Id_estacion==65 (sum)
mvd_demands <- dbGetQuery(con, "SELECT * FROM POTENCIAS WHERE Id_estacion==65")
#close the connection
dbDisconnect(con)

# load climate data
all_temps <- read_csv("./dataset.csv")
# sanity check
#head(sumscsv) #idx longitud latitud año mes dia hora temperatura(°C)
# print all possible values for the column "longitud"
#unique(sumscsv$longitud)
# print all possible values for the column "latitud"
#unique(sumscsv$latitud)
# Find the closest values to Montevideo
closest_lat <- unique(all_temps$latitud)[which.min(abs(unique(all_temps$latitud) + 34.9))] # -35
closest_long <- unique(all_temps$longitud)[which.min(abs(unique(all_temps$longitud) + 56.2))] # -56.25

# Subset rows where latitud and longitud match the closest values to Montevideo
mvd_temps <- all_temps[all_temps$latitud == closest_lat & all_temps$longitud == closest_long, ]
# Rename the column to use an underscore instead of the degree symbol
names(mvd_temps)[names(mvd_temps) == "temperatura(°C)"] <- "temperatura_C"

# we have in the mvd_demands$FechaHum "2008-01-01 03:00:00" (char)
# Load necessary packages
library(lubridate)
library(data.table)

# Create a sample dataset with datetime column
mvd_demands <- data.frame(FechaHum = c("2008-01-01 03:00:00", "2008-01-02 05:00:00", "2008-01-03 02:00:00"))
    
# Convert to datetime object and extract date, month, year, day, time of year, and year
# we have in the mvd_demands$FechaHum "2008-01-01 03:00:00" (char)
# should have:
# date(int) 1..31
# month(int) 1..12
# year(int) 2008..2017
# day(Factor w/7 levels "Mon","Tue","Wed","Thu","Fri","Sat","Sun")
# idate (int) a numeric vector giving the date in days since 1 January 1900.
# holiday (Factor w/4 levels "Normal", "Day before", "Holiday", "Day after")
# workday (char) "WD" or "NWD"
# timeofyear (Time-Series) a numerical time series giving the time in days since midnight on 1 January of each year. example 6.02
# Year (Time-series) a numeric time series giving the time in years. Example 2000.146
# fyear (num) a numeric vector giving the financial year. Example 2000
mvd_demands$datetime <- ymd_hms(mvd_demands$FechaHum)
mvd_demands$date <- day(mvd_demands$datetime)
mvd_demands$month <- month(mvd_demands$datetime)
mvd_demands$year <- year(mvd_demands$datetime)
mvd_demands$day <- factor(weekdays(mvd_demands$datetime, abbreviate = TRUE))
mvd_demands$timeofyear <- as.numeric(mvd_demands$datetime - floor_date(mvd_demands$datetime, "year"), units = "days")
mvd_demands$Year <- as.numeric(format(mvd_demands$datetime, "%Y")) + as.numeric(format(mvd_demands$datetime, "%j")) / 365
# Create idate variable
mvd_demands$idate <- as.integer(as.Date(mvd_demands$FechaHum)) - as.integer(as.Date("1900-01-01"))

# Create holiday and workday variables
holidays <- data.frame(date = as.Date(c("2008-01-01", "2008-01-06", "2008-03-24", "2008-03-25")), 
                       name = c("Holiday", "Day after", "Day before", "Holiday"))
setDT(mvd_demands)[, holiday := factor(ifelse(date %in% holidays$date, holidays$name[match(date, holidays$date)], "Normal"))]
setDT(mvd_demands)[, workday := ifelse(day %in% c("Sat", "Sun") | holiday != "Normal", "NWD", "WD")]

# Create fyear variable
mvd_demands$fyear <- as.numeric(format(mvd_demands$datetime, "%Y"))#ifelse(month(mvd_demands$datetime) <= 6, year(mvd_demands$datetime) - 1, year(mvd_demands$datetime))

# Print the final dataframe
mvd_demands
