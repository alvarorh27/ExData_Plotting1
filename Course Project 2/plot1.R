
# Environment
library(dplyr)
library(ggplot2)

# Read source tables
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Grouped total emissions by year
NEI_grouped_year <- NEI %>% 
  group_by(year) %>% 
  arrange(year) %>% 
  summarize(
    Emissions=sum(Emissions)
  )

# Open file PNG
png("plot1.png", width = 480, height = 480)

# Build plot
plot1 <- with(NEI_grouped_year, barplot(Emissions, names.arg = year, 
                                       main = "Total Emissions by year", xlab = "Year", ylab = "Emissions"))
plot1

# Close file PNG
dev.off()

