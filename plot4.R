# Exploring Data - Project 1

fn <- "household_power_consumption"
zf <- paste(fn,"zip",sep='.')
tf <- paste(fn,"txt",sep='.')
hl <- paste("https://d396qusza40orc.cloudfront.net/exdata/data/",zf,sep="")


# download and unzip data file if necessary
if(!file.exists(zf)) {
  download.file(hl,zf,method="curl")
}

# load data file
df <- read.table(unz(zf,tf),na.strings="?",sep=";",header=TRUE,
                 colClasses=c("character","character",rep("numeric",7)))

# subset to just the two days requested
df <- df[df$Date %in% c("1/2/2007","2/2/2007"),]

# convert the date/time columns to native
df["POSIXCT"] <- as.POSIXct(paste(df$Date,df$Time),format="%d/%m/%Y %H:%M:%S")

# produce submetering values plot
png('plot4.png')

par(mfrow=c(2,2))

plot(df[,"POSIXCT"],df[,"Global_active_power"],
     type="l",xlab="",ylab="Global Active Power")

plot(df[,"Voltage"] ~ df[,"POSIXCT"],type="l",col="black",
     xlab="datetime",ylab="Voltage")

plot(df[,"Sub_metering_1"] ~ df[,"POSIXCT"],type="l",col="black",
     xlab="",ylab="Energy sub metering")
lines(df[,"Sub_metering_2"] ~ df[,"POSIXCT"],col="red")
lines(df[,"Sub_metering_3"] ~ df[,"POSIXCT"],col="blue")
legend("topright", names(df[7:9]),lty=c(1,1,1),col=c("black","red","blue"),border=NULL)

plot(df[,"Global_reactive_power"] ~ df[,"POSIXCT"],type="l",col="black",
     xlab="datetime",ylab="Global_reactive_power")

dev.off()
