##download the file and load relevant libraries
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
library(dplyr)
library(datasets)

##after unzipping it, load the data and preprocess it

data = read.table("household_power_consumption.txt", header = TRUE, sep = ";")
data$Date <- as.Date(as.character(data$Date), format="%d/%m/%Y")

##filter to only contain relevant dates
df <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")

## now let's combine date and time and convert it to an appropriate format
df$Date <- as.character(df$Date)
df$Time <- as.character(df$Time)
df <- mutate(df, datetime = paste(Date, Time))
df$datetime <- strptime(df$datetime, "%Y-%m-%d %H:%M:%S")

## here's the first plot!
df$GAP <- as.numeric(as.character(df$Global_active_power))
hist(df$GAP, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png, file = "plot1.png")
dev.off()