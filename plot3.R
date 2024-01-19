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

# Open file PNG
png("plot3.png", width=480, height=480)

# Build plot
plot(data_cleaned$datetime, data_cleaned$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(data_cleaned$datetime, data_cleaned$Sub_metering_2, type="l", col="red")
lines(data_cleaned$datetime, data_cleaned$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

# Close file PNG
dev.off()

