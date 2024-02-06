
# Environment
library(dplyr)
library(ggplot2)

# Read source tables
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Grouped total emissions by year in Baltimore
SCC_grouped_vehicle <- SCC %>% 
  filter(grepl("Vehicle", SCC.Level.Two))
NEI_vehicle <- subset(NEI, NEI$fips == "24510") %>% 
  inner_join(SCC_grouped_vehicle, by="SCC") %>% 
  group_by(year) %>% 
  arrange(year) %>% 
  summarize(
    Emissions=sum(Emissions)
  )

# Open file PNG
png("plot5.png", width = 480, height = 480)

# Build plot
plot2 <- with(NEI_vehicle, barplot(Emissions, names.arg = year, 
                                                  main = "Total Motor Vehicle Emissions by year in Baltimore", xlab = "Year", ylab = "Emissions"))
plot2

# Close file PNG
dev.off()

