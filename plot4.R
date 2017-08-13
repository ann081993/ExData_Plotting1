## Load data
data <- read.table("C:/Users/Administrator/Desktop/datasci/coursera/JHDSS_ExploratoryDataAnalysis/data/household_power_consumption.txt",
                   sep = ";", stringsAsFactors = FALSE,
                   header = TRUE, na.strings = "?",
                   colClasses = c("character", "character", "numeric", "numeric",
                                  "numeric", "numeric", "numeric", "numeric",
                                  "numeric"))

## Subset
data.2days <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

## Convert Date classes
Sys.setlocale("LC_TIME","US") ## To get weekdays in English; source: https://stackoverflow.com/questions/17031002/get-weekdays-in-english-in-r
subset <- transform(data.2days, Date = as.Date(strptime(Date, "%d/%m/%Y")),
                    Date_Time = strptime(paste(Date, Time),
                                         "%d/%m/%Y %H:%M:%S", tz = "GMT"))
str(subset)

## Plot and export - plot4
# dev.copy makes truncated legend box when exported as .png through window device,
# thus, directly print straight into png() device
png(width = 480, height = 480, file = "plot4.png")
par(mfrow = c(2, 2))
#1
with(subset, plot(Date_Time, Global_active_power, type = "l",
                  ylab = "Global Active Power",
                  xlab = ""))
#2
with(subset, plot(Date_Time, Voltage, type = "l",
                  ylab = "Voltage",
                  xlab = "datetime"))
#3
with(subset,
     {
             plot(Date_Time, Sub_metering_1, type = "n",
                  ylab = "Energy sub metering",
                  xlab = "")
             lines(Date_Time, Sub_metering_1, col = "black")
             lines(Date_Time, Sub_metering_2, col = "red")
             lines(Date_Time, Sub_metering_3, col = "blue")
     }
)
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1.5,
       col = c("black", "red", "blue"),
       cex = 1,
       bty = "n" ## Remove border of legend box: bty="n"
)
#4
with(subset, plot(Date_Time, Global_reactive_power, type = "l",
                  xlab = "datetime"))

dev.off()
