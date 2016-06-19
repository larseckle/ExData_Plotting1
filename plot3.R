library(sqldf)

# define wp as a file with indicated format
dataFile <- "./data/household_power_consumption.txt"

wp <- file(dataFile)
attr(wp, "file.format") <- list(sep = ";", header = TRUE)

# use sqldf to read only the data required 
plotdata <- sqldf("select * from wp where Date in ('1/2/2007','2/2/2007')")


timeline <- strptime(paste(plotdata$Date, plotdata$Time, sep = " "),"%d/%m/%Y %H:%M:%S")

# open file
png("./plot3.png", width=480, height=480)
# create plot
Sys.setlocale("LC_ALL","English")
plot(timeline, plotdata$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(timeline, plotdata$Sub_metering_2, type="l", col="red")
lines(timeline, plotdata$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
# close file
dev.off()
