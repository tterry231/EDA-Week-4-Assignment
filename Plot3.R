#
# TAT - Assignment: Course Project 2 - Plot 3
#

#
# Read the EPA National Emissions Inventory dataset
#
library(ggplot2) 

NEI <- readRDS("summarySCC_PM25.rds")

#
# Subset the dataset for Baltimore City, Maryland
#

NEI_Baltimore <- subset(NEI, NEI$fips == "24510")

#
# Convert year and type to factors for charting
#

NEI_Baltimore$year <- as.factor(NEI_Baltimore$year)

NEI_Baltimore$type <- as.factor(NEI_Baltimore$type)

#
# Create ggplot with 4 facets using type
#

g <- ggplot(NEI_Baltimore, aes(year, Emissions))


g + geom_point(color="steelblue", size=4, alpha=.35) +
    facet_grid(.~type) + 
    labs(y=expression(PM[2.5])) +
    labs(x="Observation Year") +
    labs(title = "Baltimore City, MD - PM2.5 by Source\nMean of observations in red") +
    stat_summary(fun.y = "mean", color = "red", size=3, alpha = .85, geom = "point") +
    coord_cartesian(ylim = c(0,400))


##
## Copy the plot to .png and close the device
##

dev.copy(png,"plot3.png", width = 720, height = 480)
dev.off()
