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

## Plot and export - plot1
with(subset, hist(Global_active_power, main = "Global Active Power",
                  xlab = "Global Active Power (kilowatts)",
                  col = "red"))

dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()
