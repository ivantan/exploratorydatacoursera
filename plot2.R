# loads data from txt file
setwd("~/Documents/johnhopkins/")
powerdata <- read.table("household_power_consumption.txt", header=TRUE, sep = ";", 
                        stringsAsFactors = FALSE)
str(powerdata)

# use which() to find row numbers with the date of interest
ofinterest <- which(powerdata$Date == "1/2/2007" | powerdata$Date == "2/2/2007")
data_subset <- powerdata[ofinterest,]
head(data_subset)

# loaded data is not numeric for active power column
# create new column and use as.numeric to change data type, keeping orig column
data_subset$Global_active_power_num <- as.numeric(data_subset$Global_active_power)

# create new column for datetime concatenation of date and time
data_subset$Datetime <- strptime((paste(data_subset$Date, data_subset$Time, sep="-")), 
                                 format="%d/%m/%Y-%H:%M:%S")
str(data_subset)

## create plot
plot(data_subset$Datetime, data_subset$Global_active_power_num, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")

# save to file device as png
setwd("~/Documents/johnhopkins/exploratorydatacoursera/")
dev.copy(png, file="plot2.png", width = 480, height = 480)
dev.off()