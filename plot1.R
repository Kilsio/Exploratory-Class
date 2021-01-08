
data = read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?")

library(dplyr)
library(lubridate)

# Convert Date to Date object
data$Date = dmy(data$Date)

# Subset Data to Feb 1-2 2007
data = data[data$Date %in% c(ymd("2007-02-01"),ymd("2007-02-02")),]

# Change numeric data to numeric
data = data %>%  mutate_at(c(3:9), as.numeric)

# Plot histogram with labels
hist(data$Global_active_power,col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatt)")

# Create plot1.png
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()
