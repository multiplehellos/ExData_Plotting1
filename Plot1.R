#Plot 1

#load and clean data from the text file

table <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to type Date
table$Date <- as.Date(table$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
table <- subset(table,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
table <- table[complete.cases(table),]

## Combine Date and time column
datetime <- paste(table$Date, table$time)

## Name the vector
datetime <- setNames(datetime, "Datetime")

## Remove Date and time column
table <- table[ ,!(names(table) %in% c("Date","time"))]

## Add Datetime column
table <- cbind(datetime, table)

## Format datetime Column
table$datetime <- as.POSIXct(datetime)


#create plot 1

hist(table$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

