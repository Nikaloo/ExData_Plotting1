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
png("plot1.png")

# plot the hystogram for Global active power
hist(a$Global_active_power, plot=T, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

# close the file
dev.off()