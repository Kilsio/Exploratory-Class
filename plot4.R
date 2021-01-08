# Read in the data

data = read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?")

library(dplyr)
library(lubridate)

# Convert Date to Date object
data$Date = dmy(data$Date)

# Subset Data to Feb 1-2 2007
data = data[data$Date %in% c(ymd("2007-02-01"),ymd("2007-02-02")),]

# Change numeric data to numeric
data = data %>%  mutate_at(c(3:9), as.numeric)

# Create a complete date time object with Date/Time
data$Time = as.character(data$Time)
d2= paste(data$Date,data$Time)
d2 = strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S")
data$datetime = strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S")

# assign 4 plots to device
par(mfrow=c(2,2))
#Plot 1
plot(data$datetime,data$Global_active_power, type = "l", xlab="",ylab = "Global Active Power (kilowatts)")
#Plot 2
plot(data$datetime,data$Voltage, type = "l", xlab="datetime",ylab = "Voltage")
# Plot 3 
plot(data$datetime,data$Sub_metering_1, type = "l", xlab="",ylab = "Energy sub metering")
lines(data$datetime,data$Sub_metering_2,col="red")
lines(data$datetime,data$Sub_metering_3,col="blue")
legend("topright", legend = colnames(data)[7:9],col=c("black","red","blue"),lty=1,cex=.75,bty = "n")
# Plot 4
plot(data$datetime,data$Global_reactive_power, type = "l", xlab="datetime",ylab = "Global_reactive_power")

# Create plot4.png
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()
