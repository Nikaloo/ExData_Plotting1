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
png("plot3.png")

# plot the chart for Energy submetering
plot(a$DT,a[,7],type="l",xlab="",ylab="Energy sub metering")
lines(a$DT,a[,8],type="l",col="red")
lines(a$DT,a[,9],type="l",col="blue")

# add a legend
legend("topright",legend=names(a[,7:9]),col=c("black","red","blue"),lty=1)

# close the file
dev.off()