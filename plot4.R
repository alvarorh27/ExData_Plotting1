---------
  
  library(magrittr)
library(dplyr)
library(ggplot2)

# Read file
data <- read.table("household_power_consumption.txt", header = TRUE, sep =";")

# Data Cleaning
data_cleaned <- data %>% 
  mutate(datetime = strptime(paste(Date, Time, sep=" "), "%d/%m/%Y %H:%M:%S")) %>% 
  mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>% 
  filter(Date == "2007-02-01" | Date == "2007-02-02") %>% 
  mutate_at(vars(Global_active_power:Sub_metering_3), ~as.numeric(.))

# Build set of plots
png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2)) 

plot(data_cleaned$datetime, data_cleaned$Global_active_power, type="l", ylab="Global Active Power", xlab="")

plot(data_cleaned$datetime, data_cleaned$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(data_cleaned$datetime, data_cleaned$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(data_cleaned$datetime, data_cleaned$Sub_metering_2, type="l", col="red")
lines(data_cleaned$datetime, data_cleaned$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

plot(data_cleaned$datetime, data_cleaned$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# Close file PNG
dev.off()

