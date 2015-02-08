## get data
if (!file.exists("data")) { dir.create("data") }  # make sure data subdirectory exists

setInternet2(use = TRUE)
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url=dataURL, destfile="./data/household_power_consumption.zip", mode="wb")
list.files("./data")

dateDownloaded <- date(); dateDownloaded   # downloaded "Sun Feb 08 08:39:05 2015" from
                                        # https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
                                        # now read table into dataframe
df <- read.table(unz("./data/household_power_consumption.zip", "household_power_consumption.txt"),
                 header=T, sep=";", na.strings = "?")

## clean and preprocess data
df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")
subDF <- subset(df, DateTime>=as.POSIXct("2007-02-01 0:0:0") & DateTime<=as.POSIXct("2007-02-02 23:59:59"))

## plot 1
png(filename = "plot1.png", width = 480, height = 480)
hist(subDF$Global_active_power, freq = TRUE,
     col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()
