#Plot 2

#load and clean data from the text file

table <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to type Date
table$Date <- as.Date(table$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
table <- subset(table,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
table <- table[complete.cases(table),]

## Combine Date and time column
dateTime <- paste(table$Date, table$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and time column
table <- table[ ,!(names(table) %in% c("Date","Time"))]

## Add Datetime column
table <- cbind(dateTime, table)

## Format datetime Column
table$dateTime <- as.POSIXct(dateTime)


#create plot 2

plot(table$Global_active_power~table$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Save file and close device
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()