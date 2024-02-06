
# Environment
library(dplyr)
library(ggplot2)

# Read source tables
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Grouped total emissions by year in Baltimore
SCC_grouped_vehicle <- SCC %>% 
  filter(grepl("Vehicle", SCC.Level.Two))
NEI_vehicle <- subset(NEI, NEI$fips == "24510" | NEI$fips == "06037") %>% 
  inner_join(SCC_grouped_vehicle, by="SCC") %>% 
  group_by(year, fips) %>% 
  arrange(year) %>% 
  summarize(
    Emissions=sum(Emissions)
  ) %>% 
  mutate(fips=case_when(fips=="24510" ~ "Baltimore City", 
                   fips=="06037" ~ "Los Angeles County"))

# Build the plot
ggplot(NEI_vehicle, aes(x = year, y = Emissions, color = fips)) +
  geom_line() +
  labs(title = "Comparison of motor vehicle Emissions between Baltimore and Los Angeles",
       x = "Year",
       y = "Emissions",
       color = "fips")

# Save the plot as png
ggsave("plot6.png", plot = last_plot(), device = "png", width = 8, height = 8, dpi = 300)

