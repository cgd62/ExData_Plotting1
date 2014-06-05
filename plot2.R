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

# produce timeline
png('plot2.png')
plot(df[,"POSIXCT"],df[,"Global_active_power"],
     type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
