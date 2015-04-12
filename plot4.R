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

df$GAP <- as.numeric(as.character(df$Global_active_power))

df$sub1 <- as.numeric(as.character(df$Sub_metering_1))
df$sub2 <- as.numeric(as.character(df$Sub_metering_2))
df$sub3 <- as.numeric(as.character(df$Sub_metering_3))
x <- df$datetime
y <- df$sub1

## fourth plot
df$Voltage <- as.numeric(as.character(df$Voltage))
Voltage <- df$Voltage
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
Global_reactive_power <- df$Global_reactive_power
datetime <- df$datetime

## set up the 2 by 2 plotting area
par(mfcol = c(2, 2))

##1st panel of 4th plot
x <- df$datetime
y <- df$GAP
plot(x, y, type = "l", xlab = "", ylab = "Global Active Power")

##2nd panel of 4th plot
x <- df$datetime
y <- df$sub1
plot(x, y, type = "n", xlab = "", ylab = "Energy sub metering")
legend("topright", legend = c("Sub_metering1", "Sub_metering2", "Sub_metering3"), col = c("black", "red", "blue"), lty = 1, cex = 0.5)
lines(x, df$sub1)
lines(x, df$sub2, col = "red")
lines(x, df$sub3, col = "blue")


##3rd
plot(datetime, Voltage, type = "l")

##4th
plot(datetime, Global_reactive_power, type = "l")

dev.copy(png, file = "plot4.png")
dev.off()

par(mfrow = c(1, 1))