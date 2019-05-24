# Reading Data (Assuming the data was downloaded to de working Directory)

data<-read.table("household_power_consumption.txt", header=TRUE,sep=";", 
                 na.strings = "?", 
                 colClasses = c('character','character','numeric','numeric',
                                'numeric','numeric','numeric','numeric',
                                'numeric')
)

# Making data "workable"
library(lubridate)
library(dplyr)

data<-mutate(data,Date_time = dmy_hms(paste(Date,Time,sep="_")),
             Date=dmy(Date),Time=hms(Time))



## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Plot 4

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

plot(data$Global_active_power~data$Date_time, type="l", ylab="Global Active Power (kilowatts)", xlab="")

plot(data$Voltage~data$Date_time, type="l", ylab="Voltage", xlab="datetime")

with(data, {
  plot(Sub_metering_1~Date_time, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Date_time,col='Red')
  lines(Sub_metering_3~Date_time,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(data$Global_reactive_power~data$Date_time, type="l", ylab="Global_rective_power", xlab="datetime")

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()