library(sqldf)

# Load file
file.path()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              "household_power_consumption.zip")
unzip("household_power_consumption.zip")

# read only the rows with date 1/2 and 2/2/2007
df <- read.csv.sql("household_power_consumption.txt",
                   "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep=";")

# convert strings to POSIXct
df$Date <- as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")

# Plot without x axis
png(filename = "plot2.png", width = 480, height = 480)
plot(df$Date, df$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n")

# add labels for the wekdays
ax.dt <- seq(as.POSIXct(df$Date[1]),
             as.POSIXct("2007-02-03 0:00:00 CET"), by=86400)
axis(1, at=ax.dt, labels=weekdays(ax.dt, abbreviate=TRUE))

# close device
dev.off()