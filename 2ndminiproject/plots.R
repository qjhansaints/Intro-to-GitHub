getwd()
setwd("C:/Users/Qyle Jhan Santos/Desktop/specdata")

householdData <- "C:/Users/Qyle Jhan Santos/Desktop/specdata/household_power_consumption.txt"
Data <- read.table(householdData, header=T, sep=";", na.strings="?")

plot_data <- Data[Data$Date %in% c("1/2/2007","2/2/2007"),]
Time <- strptime(paste(plot_data$Date, plot_data$Time, sep=" "),
                "%d/%m/%Y %H:%M:%S")
plot_data <- cbind(Time, plot_data)

## Making Plots
  #Plot1
hist(plot_data$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

  #Plot2
plot(plot_data$Time, plot_data$Global_active_power, type="l", 
     col="black", xlab = "", ylab="Global Active Power (kilowatts)")
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

  #Plot3
columns <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
with(plot_data, {
  plot(Time, Sub_metering_1, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Time, Sub_metering_2, col=columns[2])
  lines(Time, Sub_metering_3, col=columns[3])
})
legend("topright", legend=labels, col=columns, lty="solid")
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

  #Plot4
labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
columns <- c("black","red","blue")
par(mfrow=c(2,2))
with(plot_data, {
  plot(Time, Global_active_power, 
       type="l", col="black", xlab="", ylab="Global Active Power")
  plot(Time, Voltage, type="l", 
       col="black", xlab="datetime", ylab="Voltage")
  plot(Time, Sub_metering_1, type="l", 
       xlab="", ylab="Energy sub metering")
  lines(Time, Sub_metering_2, type="l", col="red")
  lines(Time, Sub_metering_3, type="l", col="blue")
  legend("topright", bty="n", legend=labels, lty=1, col=columns)
  plot(Time, Global_reactive_power, type="l", col="black", 
       xlab="datetime", ylab="Global_reactive_power")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()