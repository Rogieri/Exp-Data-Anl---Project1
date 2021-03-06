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


## Plot 2

plot(data$Global_active_power~data$Date_time, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png,"plot2.png", width=480, height=480)
dev.off()