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
Sys.setlocale("LC_TIME","US") ## To Get weekdays in English
subset <- transform(data.2days, Date = as.Date(strptime(Date, "%d/%m/%Y")),
                    Date_Time = strptime(paste(Date, Time),
                                         "%d/%m/%Y %H:%M:%S", tz = "GMT"))
str(subset)

## Plot and export - plot3
# dev.copy makes truncated legend box when exported as .png through window device,
# thus, directly print straight into png() device
png(width = 480, height = 480, file = "plot3.png")
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
       cex = 1
       )

dev.off()

