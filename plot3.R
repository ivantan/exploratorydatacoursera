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

# create columns for new Sub_metering as datatype numeric
data_subset$Sub_metering_1_num <- as.numeric(data_subset$Sub_metering_1)
data_subset$Sub_metering_2_num <- as.numeric(data_subset$Sub_metering_2)

# create plot with no points
plot(data_subset$Datetime, data_subset$Sub_metering_1_num, type="n", 
     ylab="Energy sub metering", xlab="")

# change the colors of lines and add other metering lines to plot
lines(data_subset$Datetime, data_subset$Sub_metering_1_num, type="l", col="black")
lines(data_subset$Datetime, data_subset$Sub_metering_2_num, type="l", col="red")
lines(data_subset$Datetime, data_subset$Sub_metering_3, type="l", col="blue")

# add legend
legend("topright", lty="solid", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = 0.6)

# save to file device as png
setwd("~/Documents/johnhopkins/exploratorydatacoursera/")
dev.copy(png, file="plot3.png", width = 480, height = 480)
dev.off()
