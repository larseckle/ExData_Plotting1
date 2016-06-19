library(sqldf)

# define wp as a file with indicated format
dataFile <- "./data/household_power_consumption.txt"

wp <- file(dataFile)
attr(wp, "file.format") <- list(sep = ";", header = TRUE)

# use sqldf to read only the data required 
plotdata <- sqldf("select * from wp where Date in ('1/2/2007','2/2/2007')")

# open file
png("./plot1.png", width=480, height=480)
# create plot
hist(plotdata$Global_active_power, col = "red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
# close file
dev.off()

