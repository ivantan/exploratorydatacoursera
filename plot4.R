# loads data from txt file
setwd("~/Documents/johnhopkins/")
powerdata <- read.table("household_power_consumption.txt", header=TRUE, sep = ";", 
                        stringsAsFactors = FALSE)
str(powerdata)

# use which() to find row numbers with the date of interest
ofinterest <- which(powerdata$Date == "1/2/2007" | powerdata$Date == "2/2/2007")
data_subset <- powerdata[ofinterest,]
str(data_subset)

# create new column for datetime concatenation of date and time
data_subset$Datetime <- strptime((paste(data_subset$Date, data_subset$Time, sep="-")), 
                                 format="%d/%m/%Y-%H:%M:%S")
str(data_subset)

# loaded data is not numeric for active power column
# create new column and use as.numeric to change data type, keeping orig column
# do the same for voltage and reactive power column
data_subset$Global_active_power_num <- as.numeric(data_subset$Global_active_power)
data_subset$Voltage_num <- as.numeric(data_subset$Voltage)
data_subset$Global_reactive_power_num <- as.numeric(data_subset$Global_reactive_power)

# create columns for new Sub_metering as datatype numeric
data_subset$Sub_metering_1_num <- as.numeric(data_subset$Sub_metering_1)
data_subset$Sub_metering_2_num <- as.numeric(data_subset$Sub_metering_2)

# open png file device; want to decrease default text size
png(file = "plot4.png", width = 480, height = 480, units = "px",
    pointsize=12)

# create 4 plots in 2 by 2 fashion, mfcol filling plots in by col
par(mfcol=c(2,2))

# first plot
plot(data_subset$Datetime, data_subset$Global_active_power_num, type="l", 
     ylab="Global Active Power", xlab="")

# second plot 
plot(data_subset$Datetime, data_subset$Sub_metering_1_num, type="n", 
     ylab="Energy sub metering", xlab="")
lines(data_subset$Datetime, data_subset$Sub_metering_1_num, type="l", col="black")
lines(data_subset$Datetime, data_subset$Sub_metering_2_num, type="l", col="red")
lines(data_subset$Datetime, data_subset$Sub_metering_3, type="l", col="blue")

# remove legend border to adhere to assignment example
legend("topright", lty="solid", col=c("black", "red", "blue"), bty = "n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# third plot 
plot(data_subset$Datetime, data_subset$Voltage_num, type="l", 
     ylab="Voltage", xlab="datetime")

# fourth plot 
plot(data_subset$Datetime, data_subset$Global_reactive_power_num, type="l", 
     ylab="Global_reactive_power", xlab="datetime")

# save to file device as png
setwd("~/Documents/johnhopkins/exploratorydatacoursera/")
dev.off()
