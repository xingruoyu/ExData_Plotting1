# 2017-1-15
# Coursera Module 4, Exploratory data, week 1 Assignment
# Plot 4 Script

#set working directory
wd_old<-getwd()
setwd(paste(wd_old, c("Coursera_R"), sep="/"))

# read data
# only dates of 2007-02-01 and 2007-02-02, 2 days
# This means we skip the data points from 2006-December-16,17:24 to 2007-January-31
# From 2006-Dec-16, 17:24 to 2006-Dec-16, 23:59, it is 6 hours 36 min
# 1 data/min point = 60 data/hour, therefore, 6h36min = (6*60+36) data points;
# From 2006-Dec-17 to 2007-Jan-31, it is (15+31) = 46 days
# 1 data/min point = 60 data/hour = 60*24 data/day 
# Therefore, we skip rows 6*60+36+60*24*46 data points

# the data we need to read is 2 days. 
# so the number of rows to read is = 60*24*2.5

data_raw <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", skip = (6*60+36+60*24*46), nrows = 60*24*2)

# set column names
colnames(data_raw) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# convert date and time
data_raw$Date <- as.Date(data_raw$Date, "%d/%m/%Y")
data_raw$Time <- strptime(paste(data_raw$Date,data_raw$Time, sep = " "), "%Y-%m-%d %H:%M:%S")

# Save as PNG file
png(filename = "plot4.png", width = 480, height = 480)

# set subplot parameter
par(mfrow=c(2,2))

#plot figure Time ~ Global_active_power
plot(data_raw$Time,data_raw$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab="")

#plot figure Time ~ Voltage
plot(data_raw$Time,data_raw$Voltage, type = "l", ylab = "Voltage", xlab="datetime")

# plot figure Time ~ Submetering1,2,3
plot(data_raw$Time, data_raw$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="")
par(new=T)
lines(data_raw$Time, data_raw$Sub_metering_2, type = "l", ylab = "", xlab="", col = "red")
par(new=T)
lines(data_raw$Time, data_raw$Sub_metering_3, type = "l", ylab = "", xlab="", col = "blue")
legend("topright",legend=colnames(data_raw)[7:9], lwd = c(1,1,1), col = c("black", "red", "blue"))

#plot figure Time ~ Global_reactive_power
plot(data_raw$Time,data_raw$Global_reactive_power, type = "l", lwd = c(0.5), ylab = "Global_reactive_power",xlab="datetime")

# close dev
dev.off()

# set working directory to old one
setwd(wd_old)