library(dplyr)
library(data.table)
consumption <- read.table("household_power_consumption.txt", sep =";",
                          header = TRUE, na.strings = "?")
consumption$Date <- as.Date(consumption$Date, "%d/%m/%Y")
dates <- c(as.Date("2007-02-01", "%Y-%m-%d"),
           as.Date("2007-02-02", "%Y-%m-%d"))
df <- filter(consumption, Date %in% dates)
df$timetemp <- paste(df$Date, df$Time)
df$Time <- strptime(df$timetemp, "%Y-%m-%d %H:%M:%S")
png(file = "plot4.png", bg = "transparent",
    width = 504, height = 504, units = "px")
par(mfrow = c(2, 2))
# plot 1
plot(df$Time, df$Global_active_power, type = "l",
     ylab = "Global Active Power", xlab = "")
# plot 2
plot(df$Time, df$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
# plot 3
plot(df$Time, df$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(df$Time, df$Sub_metering_1)
lines(df$Time, df$Sub_metering_2, col = "red")
lines(df$Time, df$Sub_metering_3, col = "blue")
legend("topright", pch = "_", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
# plot 4
plot(df$Time, df$Global_reactive_power, xlab = "datetime",
     ylab = "Global_reactive_power", type = "l")
dev.off()
