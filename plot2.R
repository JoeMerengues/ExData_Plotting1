#Se define el url de donde se obtiene el archivo zip
url <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#Preguntamos si existe el archivo zip, png y el txt
if( file.exists("power_consumption.zip")) {
  print("El archivo zip existe por lo que procedemos a borrarlo")
  unlink("power_consumption.zip")
} 
#Borramos la imagen si existe 
if ( file.exists("plot2.png"))
  unlink("plot2.png")

print("Descargando el archivo")
download.file(url, destfile = "power_consumption.zip", method = "curl")
dateDownloaded <- date()
file <- unzip("power_consumption.zip")

print("Leemos el archivo")
power <- read.table(file, header = T, sep = ";")
#head(power)
print("Convertimos date y time")
power$Time <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
print("Obtenemos el subconjunto de datos")
power_new <- subset(power, power$Date =="2007-02-01" | power$Date=="2007-02-02")
#Liberamos memoria
rm(power)
#Convertimos variables a numeros ya que las usaremos para las gráficas
print("Convertimos valores numéricos")
power_new$Global_active_power <- as.numeric(as.character(power_new$Global_active_power))
power_new$Global_reactive_power <- as.numeric(as.character(power_new$Global_reactive_power))
power_new$Voltage <- as.numeric(as.character(power_new$Voltage))
power_new$Global_intensity <- as.numeric(as.character(power_new$Global_intensity))
power_new$Sub_metering_1 <- as.numeric(as.character(power_new$Sub_metering_1))
power_new$Sub_metering_2 <- as.numeric(as.character(power_new$Sub_metering_2))
power_new$Sub_metering_3 <- as.numeric(as.character(power_new$Sub_metering_3))

print("Obtenemos la gráfica")
plot(power_new$Time,power_new$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
print("Borramos archivos")
unlink("household_power_consumption.txt")
unlink("power_consumption.zip")