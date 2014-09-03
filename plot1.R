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

##Create Histogram of Global_active_power

##par(mar = c(4.5,4,2,2)
with(data, hist(data$Global_active_power, main = "Global Active Power",
                xlab = "Global Active Power (kilowatts)", col = "red"))

##Create PNG File
dev.copy(png, file = "plot1.png", width=1200, height=600)
dev.off()
