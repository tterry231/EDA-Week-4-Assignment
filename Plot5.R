#
# TAT - Assignment: Course Project 2 - Plot 5
#

#
# Read the EPA National Emissions Inventory dataset
#

library(ggplot2) 

NEI <- readRDS("summarySCC_PM25.rds")

#
# Read the EPA Source Classification Codes
#
 
SCC <- readRDS("Source_Classification_Code.rds")

#
# Subset the SCC for Motor Vehicles sources
# Using the designation "Mobile - On-Road" to categorize motor vehicles
#

SCC_mv <- SCC[grep("Mobile - On-Road", SCC$EI.Sector),]

#
# Subset the dataset for Baltimore City, Maryland
#

NEI_Baltimore <- subset(NEI, NEI$fips == "24510")

#
# Subset the Baltimore NEI for Motor Vehicle related SCC codes
#

NEI_Baltimore_mv <- subset(NEI_Baltimore, NEI_Baltimore$SCC %in% SCC_mv$SCC)

#
# Convert year to factor for charting
#

NEI_Baltimore_mv$year <- as.factor(NEI_Baltimore_mv$year)

#
# Create ggplot 
#

g <- ggplot(NEI_Baltimore_mv, aes(year, Emissions))


g + geom_point(color="steelblue", size=4, alpha=.35) +
    labs(y=expression(PM[2.5])) +
    labs(x="Observation Year") +
    labs(title = "Baltimore City, MD - PM2.5 by all Motor Vehicle Sources\nMean of observations in red") +
    stat_summary(fun.y = "mean", color = "red", size=3, alpha = .85, geom = "point")


##
## Copy the plot to .png and close the device
##

dev.copy(png,"plot5.png", width = 480, height = 480)
dev.off()
