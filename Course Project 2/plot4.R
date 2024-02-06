
# Environment
library(dplyr)
library(ggplot2)

# Read source tables
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter coal emissions
SCC_grouped_coal <- SCC %>% 
  filter(grepl("Coal", SCC.Level.Four))
NEI_coal <- NEI %>% 
  inner_join(SCC_grouped_coal, by="SCC") %>% 
  group_by(year) %>% 
  arrange(year) %>% 
  summarize(
    Emissions=sum(Emissions)
  )

# Open file PNG
png("plot4.png", width = 480, height = 480)

# Build plot
plot1 <- with(NEI_coal, barplot(Emissions, names.arg = year, 
                                        main = "Total Coal Emissions by year in the United States", xlab = "Year", ylab = "Emissions"))
plot1

# Close file PNG
dev.off()

