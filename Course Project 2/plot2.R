
# Environment
library(dplyr)
library(ggplot2)

# Read source tables
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Grouped total emissions by year in Baltimore
NEI_grouped_year_baltimore <- subset(NEI, NEI$fips == "24510") %>% 
  group_by(year) %>% 
  arrange(year) %>% 
  summarize(
    Emissions=sum(Emissions)
  )

# Open file PNG
png("plot2.png", width = 480, height = 480)

# Build plot
plot2 <- with(NEI_grouped_year_baltimore, barplot(Emissions, names.arg = year, 
                                        main = "Total Emissions by year in Baltimore", xlab = "Year", ylab = "Emissions"))
plot2

# Close file PNG
dev.off()

