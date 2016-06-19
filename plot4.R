library(sqldf)

# define wp as a file with indicated format
dataFile <- "./data/household_power_consumption.txt"

wp <- file(dataFile)
attr(wp, "file.format") <- list(sep = ";" , header = TRUE)

# use sqldf to read only the data required 
plotdata <- sqldf("select * from wp where Date in ('1/2/2007','2/2/2007')")

timeline <- strptime(paste(plotdata$Date, plotdata$Time, sep = " "),"%d/%m/%Y %H:%M:%S")

# open file

png("./plot4.png", width=480, height=480)
# create plot
Sys.setlocale("LC_ALL","English")
par(mfrow = c(2, 2)) 


# plot 1 - see plot2.png

plot(timeline, plotdata$Global_active_power,  
     ylab = "Global Active Power (kilowatts)", 
     xlab = "", 
     type = "l")

# plot 2

plot(timeline, plotdata$Voltage,  
     ylab = "Voltage", 
     xlab = "datetime", 
     type = "l")


# plot 3 - see plot3.png

plot(timeline, plotdata$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(timeline, plotdata$Sub_metering_2, type="l", col="red")
lines(timeline, plotdata$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

# plot 4

plot(timeline, plotdata$Global_reactive_power,  
     ylab = "Global_reactive_power", 
     xlab = "datetime", 
     type = "l")



# close file
dev.off()
