library(sqldf)

# define wp as a file with indicated format
dataFile <- "./data/household_power_consumption.txt"

wp <- file(dataFile)
attr(wp, "file.format") <- list(sep = ";", header = TRUE)

# use sqldf to read only the data required 
plotdata <- sqldf("select * from wp where Date in ('1/2/2007','2/2/2007')")


timeline <- strptime(paste(plotdata$Date, plotdata$Time, sep = " "),"%d/%m/%Y %H:%M:%S")

# open file
png("./plot2.png", width=480, height=480)
# create plot
Sys.setlocale("LC_ALL","English")
plot(timeline, plotdata$Global_active_power,  
     ylab = "Global Active Power (kilowatts)", 
     xlab = "", 
     type = "l")
# close file
dev.off()

