#
# TAT - Assignment: Course Project 2 - Plot 1
#

#
# Read the EPA National Emissions Inventory dataset
#
 
NEI <- readRDS("summarySCC_PM25.rds")

#
# Subset the dataset into appropriate years
#

NEI_1999 <- subset(NEI, NEI$year == 1999)
NEI_2002 <- subset(NEI, NEI$year == 2002)
NEI_2005 <- subset(NEI, NEI$year == 2005)
NEI_2008 <- subset(NEI, NEI$year == 2008)

#
# Calculate total emissions for each year
#

total_pm25_1999 <- sum(NEI_1999$Emissions)
total_pm25_2002 <- sum(NEI_2002$Emissions)
total_pm25_2005 <- sum(NEI_2005$Emissions)
total_pm25_2008 <- sum(NEI_2008$Emissions)

#
# Load total emissions for each year for plotting
# Dividing each sum by one million for plotting and scale
#

total_pm25 <- c(total_pm25_1999/1000000, 
		total_pm25_2002/1000000,
		total_pm25_2005/1000000,
		total_pm25_2008/1000000)

#
# Set plot years for barplot labels on x-axis
#

plot_years <- c(1999,2002,2005,2008)

#
# Create barplot using base plotting system
#

barplot(total_pm25,
	main="Total PM2.5 for United States",
	names.arg=c(plot_years[1],
		    plot_years[2],
		    plot_years[3],
		    plot_years[4]),
	ylab="PM2.5 (in millions of tons)",
	xlab="Observation Years",
	ylim=c(0,8),
	col="steelblue"
	)

##
## Copy the plot to .png and close the device
##

dev.copy(png,"plot1.png", width = 480, height = 480)
dev.off()
