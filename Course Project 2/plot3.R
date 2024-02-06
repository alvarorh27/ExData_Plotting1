
# Environment
library(dplyr)
library(ggplot2)

# Read source tables
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Grouped total emissions by year in Baltimore
NEI_grouped_year_baltimore <- subset(NEI, NEI$fips == "24510") %>%
  mutate(type=as.factor(type)) %>% 
  group_by(year, type) %>% 
  arrange(year) %>% 
  summarize(
    Emissions=sum(Emissions), 
  )

# Build the plot
ggplot(NEI_grouped_year_baltimore, aes(x = year, y = Emissions, color = type)) +
  geom_line() +
  labs(title = "Trends in Pollutant Emissions by Source Type in Baltimore (1999-2008)",
       x = "Year",
       y = "Emissions",
       color = "type")

# Save the plot as png
ggsave("plot3.png", plot = last_plot(), device = "png")