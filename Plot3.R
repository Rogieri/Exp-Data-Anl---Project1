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


## Plot 3

with(data, {
  plot(Sub_metering_1~Date_time, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Date_time,col='Red')
  lines(Sub_metering_3~Date_time,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png,"plot3.png", width=480, height=480)
dev.off()