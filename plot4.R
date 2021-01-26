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

png('plot4.png') # opening graphic device

par(mfrow = c(2,2)) # setting the number of rows for displaying several plots

plot(data$DateTime, data$Global_active_power, # plot 1
     type = "line",
     ylab = "Global Active Power", 
     xlab = "")

plot(data$DateTime, data$Voltage, # plot 2
     type = "line",
     ylab = "Voltage", 
     xlab = "datetime")

plot(data$DateTime, data$Sub_metering_1, # plot 3, built with several steps
     type = "line",
     ylab = "Energy sub metering", 
     xlab = "")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lty = "solid" )

plot(data$DateTime, data$Global_reactive_power, # plot 4
     type = "line",
     ylab = "Global_reactive_power", 
     xlab = "datetime")

dev.off() # closing graphic device