
# Getting the data

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data.zip")
unzip("data.zip", overwrite = T)

library(readr)
library(lubridate)
data <- subset( read_delim("household_power_consumption.txt",";", escape_double = FALSE, trim_ws = TRUE, na = "?"), 
                dmy(Date) >= ymd("2007-02-01") & dmy(Date) <= ymd("2007-02-02")) # adding a condition to load only the days we are interested into

# Cleaning the data 

data$DateTime <- paste(data$Date, data$Time) # creating a new variable, combining date and time
data$DateTime <- dmy_hms(data$DateTime) # changing format to date
data$Date <- dmy(data$Date) # also for Date variable
data$Time <- hms(data$Time) # and for time variable

# Plotting

png('plot2.png') # opening graphic device

plot(data$DateTime, data$Global_active_power, # plotting histogram with required arguments
     type = "line",
     ylab = "Global Active Power (kilowatts)", 
     xlab = "")

dev.off() # closing graphic device
