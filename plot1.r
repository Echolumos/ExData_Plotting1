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
png(file = "plot1.png", bg = "transparent",
    width = 504, height = 504, units = "px")
hist(df$Global_active_power, main = "Global Active Power", col = "red",
     border = "black", xlab = "Global Active Power (kilowatts)")
dev.off()