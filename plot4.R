##Get data and create dataset

data <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", na.strings = "?", skip = 20000, nrows = 200000,)
headers <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",  nrows = 10)
headings <- colnames(headers)
colnames(data) <- headings
DateTime <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")
data <- cbind(DateTime, data)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- data[data$Date >= "2007-02-01",]
data <- data[data$Date <= "2007-02-02",]
data <- data[,c(1,4:10)]

#Create Chart Parameters

par(mfcol = (c(2,2)))

##Create 1st Plot

with(data, plot(DateTime, Global_active_power, type = "l", 
                ylab = "Global Active Power",
                xlab = ""))

##Create 2nd Plot

with(data, plot(c(DateTime,DateTime,DateTime), c(Sub_metering_1,Sub_metering_2,Sub_metering_3), type = "n", 
                ylab = "Energy sub metering",
                xlab = "", ))
with(subset(data,select = c("DateTime","Sub_metering_1"), lines(DateTime,Sub_metering_1, col = "black")))
with(subset(data,select = c("DateTime","Sub_metering_2"), lines(DateTime,Sub_metering_2, col = "red")))
with(subset(data,select = c("DateTime","Sub_metering_3"), lines(DateTime,Sub_metering_3, col = "blue")))
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.5, bty = "n")

##Create 3rd Plot

with(data, plot(DateTime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))

##Create 4th Plot

with(data, plot(DateTime, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))

##Create PNG File
dev.copy(png, file = "plot4.png", width=1200, height=600)
dev.off()




