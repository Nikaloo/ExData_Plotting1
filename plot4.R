# read the file into the memory
a<-read.table("household_power_consumption.txt",header=T,sep=";")

# modify format of the variable "Date"
a$Date<-as.Date(a$Date, format="%d/%m/%Y")

# subset needed dates (between 2007-02-01 and 2007-02-02)
a<-a[a$Date=="2007-02-01" | a$Date=="2007-02-02",]

#Create the combined Date/time variable
for (i in 1:nrow(a)) {a[i,"DT"] <- paste(as.character(a[i,"Date"]),as.character(a[i,"Time"]))}

# Convert the Time variable into time format
a$DT<-strptime(a$DT,"%Y-%m-%d %H:%M:%S")

#Convert other variables into integers
for (i in 3:8) {a[,i]<-as.numeric(as.character(a[,i]))}

# ---------- Plots ---------
# create a png file
png("plot4.png")

# set the parameters for the ploting 2x2 charts, and reduce the font size.
par(mfcol=c(2,2),lwd=1.5)
par(cex.axis=0.9, cex.lab=0.9, cex.main=1, cex.sub=0.9)

# chart #1
plot(a$DT,a$Global_active_power,type="l",xlab="",ylab="Global Active Power")

# chart #2
plot(a$DT,a[,7],type="l",xlab="",cex=3.6,ylab="Energy sub metering")
lines(a$DT,a[,8],type="l",col="red")
lines(a$DT,a[,9],type="l",col="blue")
# add a legend
legend("topright",legend=names(a[,7:9]),cex=0.80,inset=0.01,box.col="transparent",col=c("black","red","blue"),lty=1)

# chart #3
plot(a$DT,a$Voltage,type="l",xlab="datetime",ylab="Voltage")

# chart #4
plot(a$DT,a$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

# close the file
dev.off()