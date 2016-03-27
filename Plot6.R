#
# TAT - Assignment: Course Project 2 - Plot 6
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
# Subset the dataset for Baltimore City, Maryland and Los Angeles County, California
#

NEI_Bal_LA <- subset(NEI, NEI$fips == "24510" | NEI$fips == "06037")

#
# Subset the Baltimore/Los Angeles NEI for Motor Vehicle related SCC codes
#

NEI_Bal_LA_mv <- subset(NEI_Bal_LA, NEI_Bal_LA$SCC %in% SCC_mv$SCC)

#
# Convert year to factor for charting
#

NEI_Bal_LA_mv$year <- as.factor(NEI_Bal_LA_mv$year)

#
# Create county column for meaningful facet label
#

NEI_Bal_LA_mv$county <- rep("",nrow(NEI_Bal_LA_mv))

#
# Assign county label based on "fips"
#

NEI_Bal_LA_mv[NEI_Bal_LA_mv$fips == "24510", ][,"county"] <- "Baltimore City, MD"
NEI_Bal_LA_mv[NEI_Bal_LA_mv$fips == "06037", ][,"county"] <- "Los Angeles, CA"


#
# Create ggplot with 2 facets using county
#

g <- ggplot(NEI_Bal_LA_mv, aes(year, Emissions))


g + geom_point(color="steelblue", size=4, alpha=.35) +
    facet_grid(.~county) +
    labs(y=expression(PM[2.5])) +
    labs(x="Observation Year") +
    labs(title = "Comparison - PM2.5 by all Motor Vehicle Sources\nMean of observations in red") +
    stat_summary(fun.y = "mean", color = "red", size=3, alpha = .85, geom = "point") +
    coord_cartesian(ylim = c(0,600))


##
## Copy the plot to .png and close the device
##

dev.copy(png,"plot6.png", width = 640, height = 480)
dev.off()
