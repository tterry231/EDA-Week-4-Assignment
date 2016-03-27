#
# TAT - Assignment: Course Project 2 - Plot 4
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
# Subset the SCC for Coal sources
#

SCC_coal <- SCC[grep("Coal", SCC$EI.Sector),]


#
# Subset the NEI for Coal related SCC codes
#

NEI_coal <- subset(NEI, NEI$SCC %in% SCC_coal$SCC)

#
# Convert year to factor for charting
#

NEI_coal$year <- as.factor(NEI_coal$year)

#
# Create ggplot 
#

g <- ggplot(NEI_coal, aes(year, Emissions))


g + geom_point(color="steelblue", size=4, alpha=.35) +
    labs(y=expression(PM[2.5])) +
    labs(x="Observation Year") +
    labs(title = "United States - PM2.5 by all Coal Sources\nMean of observations in red") +
    stat_summary(fun.y = "mean", color = "red", size=3, alpha = .85, geom = "point")


##
## Copy the plot to .png and close the device
##

dev.copy(png,"plot4.png", width = 480, height = 480)
dev.off()
